Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1850279A;
	Wed, 30 Sep 2026 14:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779057; cv=none; b=OTypw4VTI9TGwUdQzILntIfQTh+SlMPfVFmK9vrQSJCgM7kxPcopzv/CdDcvZv2EM+cMizxDnwoewVVT4Ujyexso7SFRFndI9vwVBrA83oAADWOpzoDU2D2c/V5771yVZXO9GpqK7hG7l5eIcKnry80D3hm1aQ+TvAKTgvscvtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779057; c=relaxed/simple;
	bh=qUd9myM8mM3Cs/EXyaZRdyAvljLfbURxeOsDXp6i0Zk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FNo0g+1/mvC3y3WZQVwFn+AWCyGzIJZyET+jprsEoORUOZfbyLmIz+tKNzUFHHss/VIl9PjaUzIYu13nw+HsPBQ3SBSM07/bKrWfd30Ma2VkwwihYMgqDhZuWY4SCXCMUEWRJ7PVZPguJPFIw006IWI4Tzzc40NsTAQrlrO8BaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtx018pz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtx018pz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65BEE1F000FF;
	Wed, 30 Sep 2026 14:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779044;
	bh=ji6dkTtEJFJnspzeyWza4ncppCmIJbz7wVpRzIYq63w=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Gtx018pzBfvIlctwScsdTKKIg+hfQkV5n/ld1Q2uzJpJoxXpyuk7WHeChqfebh9lh
	 RBO2RxZ37ZCgAixoZCuDyRr5UW6MoyKiUILV64NPkHdVa2wgO6av4VHTTO+TaMiuPp
	 qsM4nj8n+2OJOU4drOhDCUX7JlGdTW1j8KPwZLq4vuT32P737O9YgwbB2353mZOwGX
	 oEvX7DGsZmvWNnyqrmY29406r9UKVwyviie023k92PVSNUe4AeQ9oORSwccuNMjzr7
	 RoISvbqx0unuqCqopZLGCy6p/UfNyAeC2Yil3Anbe4uxe7QPeZmRey7XKT4iXa/oRr
	 tnpAGnkkqcmEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/5] iommu/hyperv: Add para-virtualized IOMMU support
 for Hyper-V guest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260930141409.437904-5-zhangyu1@linux.microsoft.com>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
 <20260930141409.437904-5-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:37:23 +0000
Message-Id: <20260930143724.65BEE1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] iommu/hyperv: missing detach causes silent attach failures
- [Medium] iommu/hyperv: page table UAF due to wrong domain teardown order
- [Low] iommu/hyperv: missing MODULE_IMPORT_NS causes modpost warning
--

commit e9c9e7afc1e982c251a775443c1fa2af0f333b80
Author: Yu Zhang <zhangyu1@linux.microsoft.com>

iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest

Add a para-virtualized IOMMU driver for Linux guests running on Hyper-V.
This driver implements stage-1 IO translation within the guest OS and
integrates with the Linux IOMMU core utilizing Hyper-V hypercalls.

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/h=
v-iommu-guest.c
new file mode 100644
index 0000000000000..341d70eed5924
--- /dev/null
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
[ ... ]
> +static int hv_iommu_attach_dev(struct iommu_domain *domain, struct devic=
e *dev,
> +			       struct iommu_domain *old)
> +{
[ ... ]
> +	status =3D hv_do_hypercall(HVCALL_ATTACH_DEVICE_DOMAIN, input, NULL);
> +
> +	local_irq_restore(flags);
> +
> +	if (!hv_result_success(status) &&
> +	    hv_result(status) !=3D HV_STATUS_DEVICE_ALREADY_IN_DOMAIN) {

[Severity: High]
If a device is already attached to a domain (e.g., blocking or identity),
HVCALL_ATTACH_DEVICE_DOMAIN fails with HV_STATUS_DEVICE_ALREADY_IN_DOMAIN.

By ignoring this error code and returning success without detaching from
the old domain first, does the IOMMU core assume the device is successfully
isolated in the new domain while it actually remains in the old domain?
Could this silently break DMA isolation?

> +		hv_status_err(status, "HVCALL_ATTACH_DEVICE_DOMAIN failed\n");
> +		return hv_result_to_errno(status);
> +	}
> +
> +	if (domain !=3D &hv_blocking_domain.domain &&
> +	    !pdev->ats_enabled &&
[ ... ]
> +static void hv_iommu_paging_domain_free(struct iommu_domain *domain)
> +{
> +	struct hv_iommu_domain *hv_domain =3D to_hv_iommu_domain(domain);
> +
> +	/* Free all remaining mappings */
> +	pt_iommu_deinit(&hv_domain->pt_iommu);
> +
> +	hv_delete_device_domain(hv_domain);

[Severity: Medium]
In hv_iommu_paging_domain_free(), the driver frees the guest memory backing
the page tables via pt_iommu_deinit() before instructing the hypervisor to
destroy the domain via hv_delete_device_domain().

Since the hypervisor's device domain is still active and holds the page
table root pointer, could the hypervisor access freed memory if it performs
background invalidations or delayed faults before the domain is destroyed?
Should the domain be deleted before the page tables are freed?

> +
> +	kfree(hv_domain);
> +}
[ ... ]
> +static struct iommu_domain *hv_iommu_domain_alloc_paging(struct device *=
dev)
> +{
[ ... ]
> +	cfg.top_level =3D (hv_iommu_device->max_iova_width > 48) ? 4 : 3;
> +
> +	ret =3D pt_iommu_x86_64_init(&hv_domain->pt_iommu_x86_64, &cfg, GFP_KER=
NEL);

[Severity: Low]
The driver selects GENERIC_PT and calls pt_iommu_x86_64_init(), which is
exported into the GENERIC_PT_IOMMU namespace.

Without a MODULE_IMPORT_NS("GENERIC_PT_IOMMU") declaration, will this
cause modpost warnings during the kernel build?

> +	if (ret)
> +		goto err_free;
> +
> +	/* Constrain to page sizes the hypervisor supports */
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141409.4379=
04-1-zhangyu1@linux.microsoft.com?part=3D4
