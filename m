Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DD8476048
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 15:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115074; cv=none; b=Wt55g2GnBXS9gQneuCnvUsLXbPgCnxDF5ipX6xTOYLL9Is5nuo6Yuke1p+zosWsxE0jZ5BJ6jM0Ntezv0V21VYkInp918XROX4DNGvuI9GHEAFVebIQvPrAeu2VyY4+XGQTvhkO1hGuK2X0AOPYePsvR3Vv7yxlO4SCzdqw8/LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115074; c=relaxed/simple;
	bh=bSlsNBT7U2iosj8UwL+U/p2Tphi/GnQ0PJYxOQbJg38=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tbuHS2NKElLtlPd5eM9GXagMiHwmTKxL4AReea71EfSbPtgvt62/MruERo066wBCZKo+LY9K7Sgx6TOjcCAhUQ8lk6YjhNv0fmr2mX1ZeIgFu+iVtdXp6vvhs90QkiHO7Q4AKKaJB3aAXj6KMF2c4h+vp7NOI4zWb7fgv+v+AHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UW3bgG2B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UW3bgG2B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2201F00A3D;
	Fri,  7 Aug 2026 15:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115067;
	bh=mwaK05RucFUjIWf+cdKQtpTAMDFkad1BXz5gnySDQm8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UW3bgG2BS6jOP9MDXali3QF18SYyRD8cqnfdKTn2pDLmklWImBHH5vXQT1idvEZQL
	 oOL3PcR0+wQ6rI+fiDSm8naieSwevwq4q6596VGGKk1ukETk+m0zpQ1DYVUe+06X11
	 iIWgoGO4C+wvkb9jLA2SifaJGBZqzRvBLLuX3rX4XxzICUfeP9zdz81vi79mJCCN5w
	 ekYF0fYrvrzBVkEuxqy71h8834ktXTcbAOIPII9shUIoAsUb1DpxAqZ+Q8wGhD+MVY
	 TYChoXaPIdrkQo14VaukCv7Ith1PL3MZz4fx0aWnQdwL2ElO2t6koE+Q0Jd83A3LY5
	 SKcc7GclhWChw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 06/13] mshv: detect and report SEV-SNP support at
 init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-7-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-7-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:04:26 +0000
Message-Id: <20260807150427.4E2201F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Failing to query optional SEV-SNP support aborts the entire `mshv`=
 module initialization, preventing non-SNP virtual machines from running on=
 unsupported platforms.
- [Low] The helper function `hv_snp_status_to_string` is defined unconditio=
nally but only used inside an x86-specific block, causing a build failure o=
n non-x86 architectures.
--

--- Patch [6]: [PATCH v1 06/13] mshv: detect and report SEV-SNP support at =
init ---
commit e3193a7357d34307ce8275f28a3eb193fd3183cf
Author: Wei Liu <wei.liu@kernel.org>

mshv: detect and report SEV-SNP support at init
   =20
Query Hyper-V dynamic processor features during mshv initialization to
determine SEV-SNP availability, and report the result.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 3590a8ea24b5f..cc38507570ac4 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2660,6 +2660,109 @@ static int mshv_root_scheduler_cleanup(unsigned i=
nt cpu)
>  }
> =20
>  /* Must be called after retrieving the scheduler type */
> +#if defined(__x86_64__)
> +static int mshv_print_max_sev_snp_partitions(struct device *dev)
> +{

[ ... ]

> +	status =3D hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		dev_err(dev, "Failed to get max SNP partitions: %s\n",
> +			hv_result_to_string(status));
> +		return hv_result_to_errno(status);
> +	}

[Severity: High]
Does propagating this error cause driver initialization to abort on platfor=
ms
that do not support SEV-SNP?=20

If the hypervisor does not support this dynamic processor feature, returning
an error here will cause the entire mshv module to fail to load because it
is propagated up to mshv_parent_partition_init().

[ ... ]

> +static const char *hv_snp_status_to_string(enum hv_snp_status status)
> +{
> +	switch (status) {
> +	case HV_SNP_STATUS_NONE:
> +		return "not available";

[Severity: Low]
This function is defined unconditionally, but it is only called from within
an `#if defined(__x86_64__)` block in mshv_check_sev_snp_support().=20

Does this cause an unused function warning on non-x86 architectures (such as
ARM64) that could break the build when CONFIG_WERROR is enabled?

[ ... ]

> +static int __init mshv_check_sev_snp_support(struct device *dev)
> +{
> +#if defined(__x86_64__)
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	u64 status;
> +	enum hv_snp_status snp_status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->property_id =3D HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY;
> +	input->hv_processor_feature =3D HV_X64_DYNAMIC_PROCESSOR_FEATURE_SNP_ST=
ATUS;
> +
> +	status =3D hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
> +	if (!hv_result_success(status)) {
> +		local_irq_restore(flags);
> +		dev_err(dev, "Failed to get SNP support: %s\n",
> +			hv_result_to_string(status));
> +		return hv_result_to_errno(status);
> +	}

[Severity: High]
Similar to above, does returning an error here prevent the mshv module from
loading on systems without SEV-SNP support (like Intel CPUs) or on older
Hyper-V versions?=20

It appears this will abort module initialization if the hypercall fails.

> +
> +	snp_status =3D output->hv_processor_feature_value;
> +	local_irq_restore(flags);
> +
> +	dev_info(dev, "SEV-SNP support status: %s (%u)\n",
> +		 hv_snp_status_to_string(snp_status), snp_status);
> +
> +	if (snp_status =3D=3D HV_SNP_STATUS_AVAILABLE)
> +		return mshv_print_max_sev_snp_partitions(dev);
> +#endif
> +
> +	return 0;
> +}
> +
>  static int
>  root_scheduler_init(struct device *dev)
>  {

[ ... ]

> @@ -2763,6 +2866,10 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto synic_cleanup;
> =20
> +	ret =3D mshv_check_sev_snp_support(dev);
> +	if (ret)
> +		goto synic_cleanup;
> +

[Severity: High]
This is where the error from the informational SEV-SNP checks causes module
initialization to abort. Should these functions handle unsupported features
gracefully instead of failing the init?

>  	ret =3D root_scheduler_init(dev);
>  	if (ret)
>  		goto synic_cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D6
