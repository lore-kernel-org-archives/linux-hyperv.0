Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20813D9DCA
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366537; cv=none; b=cBwp/rrzyjOuHOXMolpiQNamIr7I1UZ211w9YUxx6YQzEHZY6CE6WGCxMT3FHIGhSJ1Xh67bc7CuHIZNhRdIZnBTXZSJqFQ9KS/nZVuXWvJm20lXzNs5tsPxiiX79NSTD/kuQs+I0mwBQuKENXZ2HhyQUQ1MIuG9VYewlWg+/mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366537; c=relaxed/simple;
	bh=tklWrYhO05qiYR9hwn24DcflO1jzeKNdJcqenfbOybY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LvAOK13qxj47zSkQBL9L9L878goziXrzufY3TMspsBcEkqvp6hIhd73Wwbm1ZxlaIXNCIk31YpJxQfF8+MPJMTwDy8xywi3aWod0yGJM0GcUOBWDQMxuWI4lVmIFRZcYpDTXW7tjSwKj2m9fhqOLYSMSAFPphtxsFNsE7gfm5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8JhPO/9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8JhPO/9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F2DE1F000E9;
	Mon, 10 Aug 2026 12:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786366535;
	bh=tQyGNH/+VdZi1VcO6Y4wyl95Vu2TIwYBJ7wG+u415yM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V8JhPO/9fzKk6Iq3i8MgyvwQB6PqwdzVh222cG+XQHS0kwHLN2Oso7szHisXkVk5x
	 qtz6kI6rr+77e8jtGsKbbS+aqKpFQO9sFPMTcSvkX8X4R133QDU1DBp+aOGas656tQ
	 G+SdzMC8uH32Svyf7+yHn85LAvYbVKhx/gK8iaiGkDS15FI14kTZonVFOvJJF3RQ61
	 D9p9BFb4kdNsYjxFY0nKBAfzfotx6DXeDHz69slH0XKXTu48h/fvYGtuqOJgvpDYUu
	 H/d2E+ojFug30dpUmK+5zmDHpkKgANe4vkFFUQ3vCi0Kt8U2DjdFOb3hewV11i+zKT
	 Rv0Dy4SNP3rUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/13] mshv: detect and report SEV-SNP support at
 init
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-7-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-7-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 12:55:34 +0000
Message-Id: <20260810125535.5F2DE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] The shared per-CPU hypercall output buffer is read after local i=
nterrupts are restored, creating a race condition that can lead to data cor=
ruption.

Pre-existing issues:
- [High] Userspace can access the `/dev/mshv` character device before the r=
oot driver initialization is complete, exposing uninitialized structures.
--

--- Patch [6]: [PATCH v2 06/13] mshv: detect and report SEV-SNP support at =
init ---
commit e5cd5a244ce2b3b2547714151c9b94d944d9fd7b
Author: Wei Liu <wei.liu@kernel.org>

mshv: detect and report SEV-SNP support at init

Query Hyper-V dynamic processor features during mshv initialization to
determine SEV-SNP availability, and report the result. On success, log the
maximum number of encrypted partitions, otherwise log the decoded SNP status
string so misconfigurations are diagnosable.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 8c87dd8e0378f..712f45dcef60c 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c

[ ... ]

> @@ -2705,6 +2705,100 @@ static int mshv_root_scheduler_cleanup(unsigned i=
nt cpu)
>  }
> =20
>  /* Must be called after retrieving the scheduler type */
> +#if defined(__x86_64__)

[ ... ]

> +static void mshv_print_max_sev_snp_partitions(struct device *dev)
> +{
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	u64 status;
> +
> +	local_irq_save(flags);
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	input->property_id =3D HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY;
> +	input->hv_processor_feature =3D
> +		HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS;
> +
> +	status =3D hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
> +	local_irq_restore(flags);
> +	if (!hv_result_success(status)) {
> +		dev_warn(dev, "Failed to get max SNP partitions: %s\n",
> +			 hv_result_to_string(status));
> +		return;
> +	}
> +
> +	dev_info(dev, "Maximum supported SEV-SNP partitions are: %llu\n",
> +		 output->hv_processor_feature_value);

[Severity: Medium]
Could this result in a corrupted value being read from the output buffer?

By calling local_irq_restore(flags) before reading
output->hv_processor_feature_value, an interrupt could occur immediately
after IRQs are restored. If the interrupt handler executes another hypercal=
l,
the per-CPU output buffer (hyperv_pcpu_output_arg) will be overwritten befo=
re
the value is logged.=20

Should the value be copied to a local variable before restoring local
interrupts?

> +}
> +
> +static void __init mshv_check_sev_snp_support(struct device *dev)
> +{
> +	struct hv_input_get_system_property *input;
> +	struct hv_output_get_system_property *output;
> +	unsigned long flags;
> +	enum hv_snp_status snp_status;
> +	u64 status;
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
> +	local_irq_restore(flags);
> +	if (!hv_result_success(status)) {
> +		dev_warn(dev, "Failed to get SNP support: %s\n",
> +			 hv_result_to_string(status));
> +		return;
> +	}
> +
> +	snp_status =3D output->hv_processor_feature_value;

[Severity: Medium]
If an interrupt overwrites the buffer after local_irq_restore(flags) but
before snp_status is assigned, snp_status could read a corrupted value.

Is there a similar race condition here as seen in
mshv_print_max_sev_snp_partitions()?

> +	dev_info(dev, "SEV-SNP support status: %s (%u)\n",
> +		 hv_snp_status_to_string(snp_status), snp_status);
> +
> +	if (snp_status =3D=3D HV_SNP_STATUS_AVAILABLE)
> +		mshv_print_max_sev_snp_partitions(dev);
> +}

[ ... ]

> @@ -2808,6 +2902,8 @@ static int __init mshv_parent_partition_init(void)
>  	if (ret)
>  		goto synic_cleanup;
> =20
> +	mshv_check_sev_snp_support(dev);
> +

[Severity: High]
This is a pre-existing issue, but is it safe to expose the character device
before the root driver initialization is complete?

Earlier in mshv_parent_partition_init(), misc_register(&mshv_dev) is called,
which immediately exposes the device to userspace. A racing userspace thread
could open the device and trigger the MSHV_CREATE_PARTITION ioctl before
initialization finishes.

The ioctl invokes add_partition(), which attempts to acquire
mshv_root.pt_ht_lock. The lock initialization spin_lock_init(&mshv_root.pt_=
ht_lock)
isn't executed until much later in the setup sequence.

Wouldn't this trigger a kernel oops if accessed early?

>  	ret =3D root_scheduler_init(dev);
>  	if (ret)
>  		goto synic_cleanup;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D6
