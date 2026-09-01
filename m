Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4FDC48876E
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788283484; cv=none; b=dYALTB95Jy4WLfsrBwGeaGv0RUUdhqq5erHgeAsaXj0E2i+vncNl8tM0QuRZpgz2DGlQn6y4PmaAniPTi0r8UFOB4wqkPmRhCVuwPAJe5iPgTzzRFcyAazTpCdTzCQc0Fve+Vhkb2OS/JdGE694ziE01w1bq5m4TtlUjp0JiYWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788283484; c=relaxed/simple;
	bh=/l3uhX+QSG8OL0NkHmRsxYWENHGQXyCH6hhLG5nDQzU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aAAps/3JOBSxmOS16IwLSjiPHr1zDawIqtj8nt5ffyciLM318WfGuxNOBTa7U/ae+TQqsKTBKCzUqdTRLjGrgZV4OWzoJp7B9URIcv5Eui9x6Ja7rR/I1ePsIDK84Am/6YPkItxUv80Ye8WnDwUinFvRIRvPcrennmkZPWduJE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6YQ86nZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6YQ86nZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995301F000E9;
	Tue,  1 Sep 2026 17:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283482;
	bh=aqYPL9rEhmydk3+8XAs8ajSbwwMHWspscWx+QFDfV8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=B6YQ86nZDTNjriCdFQjqlgvi88CqAtRGIFI2WR8KdLudKxoLTADwjaR1lxPmpVPTR
	 a5GOsyXdUlSTMAGiqxCsgUeHnObU2QmHv8wXHjuD2AH+t0/CesgDeu12L7RbXIOoJs
	 VLzaoLIzsePLZzuZh76x9MQodurFiaYEOsPEV12ykQcbTulbNXssNaW8OvDptXw21r
	 0ONdOzuBz4F6yGf6kAoxVNZKw53MopjPpFQjKolXXgQMFqlUkwVBmFFPePKbBcjSxe
	 X975OKnQCIlRZCTdXZrm33uJuH5cBzpHYXt2ZDFUfyHor7VB318zNBoSKxHPTLPHXD
	 0nWxpmcRXaeeQ==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 06/12] drivers: hv: Add VSM boot driver and enable
 VTL1 at the partition level
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-7-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-7-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:24:42 +0000
Message-Id: <20260901172442.995301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Incorrect validation of the MBEC enablement bitmask allows silent =
failure of VTL1 security configuration.
- [High] Missing MBEC validation when VTL1 is found to be already enabled, =
allowing acceptance of insecure pre-configured VTL1 states.
- [Medium] hv_vsm_boot_init pins initialization to cpumask_first(cpu_online=
_mask), which is incorrect for kexec/kdump where the boot CPU may not be CP=
U 0.
--

commit cce0c5216b1bbddd78ce31614c3d1587f8bcd4ea
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

drivers: hv: Add VSM boot driver and enable VTL1 at the partition level

This commit introduces a driver to bring up Linux VBS (LVBS) using Hyper-V's
Virtual Secure Mode. It provides the initial sequence to probe privileges, =
pin
execution to the VTL0 boot CPU, and enable VTL1 at the partition level with
MBEC.

> diff --git a/drivers/hv/hv_vsm_boot.c b/drivers/hv/hv_vsm_boot.c
> new file mode 100644
> index 0000000000000..99e4dc8695837
> --- /dev/null
> +++ b/drivers/hv/hv_vsm_boot.c
[ ... ]
> +static int __init hv_vsm_bootstrap_vtl(void)
> +{
> +	u16 partition_enabled_vtl_set =3D 0, partition_mbec_enabled_vtl_set =3D=
 0;
> +	u8 partition_max_vtl;
> +	int ret;
> +
> +	/* Check and enable VTL1 at the partition level */
> +	ret =3D hv_vsm_get_partition_status(&partition_enabled_vtl_set, &partit=
ion_max_vtl,
> +					  &partition_mbec_enabled_vtl_set);
> +	if (ret)
> +		return ret;
> +
> +	if (partition_max_vtl < HV_VTL_SECURE) {
> +		pr_err("VTL1 is not supported by the partition\n");
> +		return -EINVAL;
> +	}
> +
> +	if (partition_enabled_vtl_set & HV_VTL1_ENABLE_BIT) {
> +		pr_info("Partition VTL1 is already enabled\n");
> +	} else {

[Severity: High]
Does this code skip verifying MBEC when VTL1 is already enabled?

If an attacker or previous boot stage races to enable VTL1 but omits
enabling MBEC, checking partition_enabled_vtl_set here finds VTL1 enabled
and skips further configuration without validating
partition_mbec_enabled_vtl_set. Could this allow acceptance of insecure
pre-configured VTL1 states?

> +		ret =3D hv_vsm_enable_partition_vtl();
> +		if (ret) {
> +			pr_err("Enabling Partition VTL1 failed with status 0x%x\n",
> +			       ret);
> +			return -EINVAL;
> +		}
> +		ret =3D hv_vsm_get_partition_status(&partition_enabled_vtl_set, &parti=
tion_max_vtl,
> +						  &partition_mbec_enabled_vtl_set);
> +		if (ret)
> +			return ret;
> +		if (!(partition_enabled_vtl_set & HV_VTL1_ENABLE_BIT)) {
> +			pr_err("Tried Enabling Partition VTL 1 and still failed\n");
> +			return -EINVAL;
> +		}
> +		if (!partition_mbec_enabled_vtl_set) {

[Severity: High]
Since partition_mbec_enabled_vtl_set is a bitmask of all VTLs with MBEC,
does this validation only check if the mask is completely empty?

If VTL0 already has MBEC enabled (bit 0 is 1), the mask is non-zero, causing
this check to falsely pass even if the hypervisor failed to enable MBEC for
VTL1. Should this instead isolate the VTL1 bit, for example:
!(partition_mbec_enabled_vtl_set & HV_VTL1_ENABLE_BIT) ?

> +			pr_err("Tried Enabling Partition MBEC and failed\n");
> +			return -EINVAL;
> +		}
> +	}
> +	return 0;
> +}
[ ... ]
> +static int __init hv_vsm_boot_init(void)
> +{
> +	cpumask_var_t mask;
> +	unsigned int boot_cpu;
> +	int ret;
> +
> +	if (!vsm_arch_has_vsm_access())
> +		return 0;
> +
> +	/*
> +	 * Copy the current cpu mask and pin rest of the running code to boot c=
pu.
> +	 * Important since we want boot cpu of VTL0 to be the boot cpu for VTL1.
> +	 * ToDo: Check if copying and restoring current->cpus_mask is enough
> +	 * ToDo: Verify the assumption that cpumask_first(cpu_online_mask) is
> +	 * the boot cpu
> +	 */
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> +		panic("Could not allocate cpumask");
> +
> +	cpumask_copy(mask, &current->cpus_mask);
> +	boot_cpu =3D cpumask_first(cpu_online_mask);
> +	set_cpus_allowed_ptr(current, cpumask_of(boot_cpu));

[Severity: Medium]
Will this incorrectly pin the task to the lowest-numbered online CPU rather
than the actual boot CPU during a kexec or kdump?

If the kernel is booted via kexec or kdump on a non-zero CPU, lower-numbered
CPUs might be brought online during SMP initialization. In this scenario,
cpumask_first(cpu_online_mask) returns the lowest numbered online CPU, which
is not necessarily the Bootstrap Processor (BSP). Is get_boot_cpu_id() the
proper API to use here?

> +
> +	ret =3D hv_vsm_bootstrap_vtl();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D6
