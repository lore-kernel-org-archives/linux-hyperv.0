Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793846281;
	b=K5qNTqhLIdZQ4DJEWMZIfxhHaOHrkAAUzv3zSqm/aJv8t70a9ORNqO0X13VwgDCUAeC4
	 D6pCfhDAAOmaT9MKrnyHsAy0PnKRFlWN6FroLMjX+QDKiT1I/ZMdIdfSYu7TEMRzRuyat
	 Q/+5J4MwOJ6WvHOXRlmLaOsb5n16nPXUbtcbmDjWfbtAXYCNKX2iLnhdxocdYclKo/qQ0
	 U8W/Nyb5MSOt0mrZvHCotK0Ta5PQtmLAtDLPslTHcUP7XL/Sw5VXx20Tjjiu/7UX+Bpzh
	 r+MkKUA/NTvE2mNahctxStOAMA4a3F6+QkR76IAYr9r7Zw/dJjGZXvrbIm3qoi6Xx7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793846281;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=tt4xF5mPgF83WC9mN28G2woeInnN7/5ECFp+kHN4yfM=;
	b=nJcqSK5G8/5z8Ea3RPuQRUIaXrh+vFehpZPI92Uhv9rdSuONA6WwpsuiUuHcb+6i0GL8
	 rjgrEoqpM+JmZ5G18bv4sNQaBj6+OJXx7XjadbUjR4QmZdQxHfOqjXKmu0yKNHWnnBONs
	 7xXvttbG42Skw3TSFm3BVShuh1KgrhUgmjKxLrZ82ws7zP4YlDEoFJldLicp5+hDwOvuk
	 tXtA6rM3BV9DCJuHKFiCeBhvpsWBhscppXAQ0LV+b+zhGyOiYRGGdgBVV0gV4u+ZD+8g+
	 DEScCYP3pzl4ljDEXvyjXkZfeLp4bZmKjcdHUEHhWIpS6HtvGHy0E4BVi+bLAIaqIMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSMD+mGq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8921A606A32C
	for <linux-hyperv@vger.kernel.org>; Thu,  5 Nov 2026 02:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nSMD+mGq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01AD71F00919;
	Thu,  5 Nov 2026 02:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793846281;
	bh=tt4xF5mPgF83WC9mN28G2woeInnN7/5ECFp+kHN4yfM=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=nSMD+mGqedpWz1O6KMw1wuwFhmjnbl7PeGf+sPYarUqIeow4M6ruHi1c3CxC5suxM
	 8xWQNKo3E/7gz3zo2Ueq57fDK8Ql6x0UGow1iCZDaskiX9DnnT0gCMiG/+2ib9Fzxc
	 1J4A7OGj9GCg7fo0qORWW6KEqaw76fPSDWLtEYUtuAL5Sy6j5k4o/N2hs9ZMS9cmQG
	 C3V0ZTGIqWzIXfv8+SCUnT4OCFOk8aBDbUbdfpH5qUQv7OmkIJc1O+NvGE3JeEkUfY
	 P6W2UDu9rUm7GP12ZlzlU/UhBJhqby1S1npcOXlalME1DfGQIiAcC1IgC8uujfGtYI
	 FmFu/eS795VxA==
Message-ID: <sashiko-outbox-198471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 5/5] x86/hyperv: Implement root partition IOMMU
 kernel only driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261105020106.3496339-6-mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 02:38:00 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/hyperv: missing !hv_root_partition() check in hv_root_iommu_=
detect()
--

commit c89a0e9d0fe34e767bd4527e0d99839504bcbea1
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Implement root partition IOMMU kernel only driver

This commit implements a kernel-only virtual IOMMU driver for baremetal
Microsoft Hyper-V root partitions, handling paging domain management, device
attachment, and IOVA page mapping via hypercalls.

> diff --git a/drivers/iommu/hyperv/hv-iommu-root.c b/drivers/iommu/hyperv/=
hv-iommu-root.c
> new file mode 100644
> index 0000000000000..e0e3e9d4385e2
> --- /dev/null
> +++ b/drivers/iommu/hyperv/hv-iommu-root.c

[ ... ]

> +static int hv_iommu_get_caps(struct hv_output_get_iommu_capabilities *ca=
ps)
> +{
> +	u64 status;
> +	unsigned long flags;
> +	struct hv_input_get_iommu_capabilities *input;
> +	struct hv_output_get_iommu_capabilities *output;
> +
> +	local_irq_save(flags);
> +
> +	input =3D *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id =3D HV_PARTITION_ID_SELF;
> +	status =3D hv_do_hypercall(HVCALL_GET_IOMMU_CAPABILITIES, input, output=
);
> +	*caps =3D *output;
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status))
> +		hv_status_err(status, "\n");
> +
> +	return hv_result_to_errno(status);
> +}
> +
> +static int __init hv_root_iommu_init(void)
> +{
> +	int rc;
> +	struct iommu_device *iommup =3D &hv_virt_iommu;
> +	struct hv_output_get_iommu_capabilities caps;
> +
> +	if (!hv_is_hyperv_initialized())
> +		return -ENODEV;
> +
> +	rc =3D hv_iommu_get_caps(&caps);

[ ... ]

> +void __init hv_root_iommu_detect(void)
> +{
> +	if (no_iommu || iommu_detected || hv_l1vh_partition())
> +		return;
> +
> +	/* This is set for root partitions only, it is never set for non-root */
> +	if (!(ms_hyperv.misc_features & HV_DEVICE_DOMAIN_AVAILABLE))
> +		return;
> +
> +	iommu_detected =3D 1;
> +	x86_init.iommu.iommu_init =3D hv_root_iommu_init;
> +
> +	pci_request_acs();
> +}

[Severity: High]
As reported by Sashiko on v3 [1], should hv_root_iommu_detect() check
!hv_root_partition() instead of hv_l1vh_partition()?

During x86 boot, ms_hyperv_init_platform() calls hv_identify_partition_type=
()
in drivers/hv/hv_common.c, which forces hv_curr_partition_type to
HV_PARTITION_TYPE_GUEST whenever HV_ISOLATION is set so that Confidential V=
Ms
do not execute root partition paths:

drivers/hv/hv_common.c:hv_identify_partition_type() {
	hv_curr_partition_type =3D HV_PARTITION_TYPE_GUEST;
	...
	if ((ms_hyperv.priv_high & HV_CREATE_PARTITIONS) &&
	    !(ms_hyperv.priv_high & HV_ISOLATION)) {
		...
	}
}

Later in boot, pci_iommu_alloc() calls hv_root_iommu_detect(). Because
hv_root_iommu_detect() only checks hv_l1vh_partition(), a guest partition
where HV_DEVICE_DOMAIN_AVAILABLE is set in ms_hyperv.misc_features will set
iommu_detected =3D 1 and x86_init.iommu.iommu_init =3D hv_root_iommu_init.

When hyperv_init() then calls hv_common_init() in drivers/hv/hv_common.c,
hyperv_pcpu_output_arg is only allocated if hv_output_page_exists() is true:

drivers/hv/hv_common.c:hv_common_init() {
	...
	if (hv_output_page_exists()) {
		hyperv_pcpu_output_arg =3D alloc_percpu(void *);
		BUG_ON(!hyperv_pcpu_output_arg);
	}
}

For HV_PARTITION_TYPE_GUEST (with CONFIG_MSHV_ROOT depending on
!HYPERV_VTL_MODE), hv_output_page_exists() is false and hyperv_pcpu_output_=
arg
remains NULL.

If CONFIG_HYPERV_PVIOMMU is disabled, pci_iommu_init() invokes
hv_root_iommu_init() -> hv_iommu_get_caps(), which dereferences
*this_cpu_ptr(hyperv_pcpu_output_arg) while hyperv_pcpu_output_arg is NULL.=
 If
CONFIG_HYPERV_PVIOMMU is enabled, hyperv_init() overwrites
x86_init.iommu.iommu_init with hv_pviommu_init, which then fails with -ENOD=
EV
because hv_root_iommu_detect() already set iommu_detected =3D 1.

Would checking !hv_root_partition() in hv_root_iommu_detect() avoid this by
excluding both L1VH and guest partitions?

[1] https://lore.kernel.org/r/20261103025150.3192119-6-mrathor@linux.micros=
oft.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105020106.3496=
339-1-mrathor@linux.microsoft.com?part=3D5
