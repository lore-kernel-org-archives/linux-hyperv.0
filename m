Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37F3485CC3
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788282760; cv=none; b=mj71TgispKOdGgYkwg0fRbvdDeeOKZSADtq3Nj9iB6162Ti49y9TL0wxH5kf8TzMl4uL9kTc5BK2LWsC7WYCLU+KurFTQmv4L4PI1FPMqdfhjPSz0EaPA8ZZk04cZjTRaz9mZk5H/r8daWVDbv6t5A8jCv1L4XXGTZTVjQkKfHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788282760; c=relaxed/simple;
	bh=SV2vfvHMSSlI4DyjMSJ4LLvsvx8kPo/eS+VXbmYwtPY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qvN1i2RIMm6lJ/YJ8Oo4lihGhbxNMNVXqnIV5I9R88UgcNw5+No6Mg0/LbnbpFEPJlh1VUvSlO3HYcRTTFI/UU7xVF1NR5+hvdg7TfQLmKkGijaiq66mUqQNlviz4NktUAtkXjiAwPtxGl9UJgAnlxP3HlzuFnoRhUOL92yV6Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTX/VwvU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTX/VwvU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 834601F00A3A;
	Tue,  1 Sep 2026 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282758;
	bh=bvCmyU4QO+EogO2cKlxucdrlR9PG6tE/Tj9wAIWuygs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BTX/VwvUglwFrmbvHRpfIIg439cF7O7iMP3YnG0FJcw33UQ0vsSgrdTwDaR0/IJUI
	 Y4DzKM1HndUrblSWMhKaGrsk0Rb66svux6CI5tH8fqpr0dvp0zR8II8b4HN3DlBPGs
	 s+e8RTdNp0dnXBdsnTqB4qaH3OwBD/ezhYB6kCFX8/laY4qNLZG8PpYb0+Ihd9LLOu
	 /wjkhbTseBNUlEjXG78+Lkvnx2vtl+7D9Pj6/rkYPr51JJfiG59S26G2UyEOUMQmkh
	 9g+LJJXCoXMfER2yKSzscHZBewMvyf3UopuAFZXWpyIUzCcOOF3+qMZ+7G2BK/fhpZ
	 BfDfwN2koSSWA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 02/12] drivers: hv: hv_common: Allocate Hyper-V
 output arg page when VSM is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-3-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-3-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:12:38 +0000
Message-Id: <20260901171238.834601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] hv_apicid_to_vp_index() unconditionally dereferences the unallocat=
ed hyperv_pcpu_output_arg pointer in standard/SNP guests.
--

commit 0ee3313e113c9ca7969923f2af5a1ed18ddb25d2
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

drivers: hv: hv_common: Allocate Hyper-V output arg page when VSM is enabled

This commit extends hv_output_page_exists() to return true when=20
CONFIG_HYPERV_VSM is enabled. This ensures the per-CPU output argument
page is allocated at boot for VSM hypercalls.

> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 31256cb22b39e..44f4a10984618 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
> @@ -259,7 +259,8 @@ static void hv_kmsg_dump_register(void)
> =20
>  static inline bool hv_output_page_exists(void)
>  {
> -	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> +	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE) ||
> +		IS_ENABLED(CONFIG_HYPERV_VSM);

[Severity: High]
This is a pre-existing issue, but modifying this function highlights a
vulnerability for SEV-SNP guests where VSM and VTL modes are disabled.

When an SEV-SNP guest boots secondary CPUs, hv_smp_prepare_cpus() overrides
the wakeup callback with hv_snp_boot_ap(), which then calls
hv_apicid_to_vp_index() in arch/x86/hyperv/ivm.c.

If CONFIG_HYPERV_VSM and CONFIG_HYPERV_VTL_MODE are both disabled,
hv_output_page_exists() evaluates to false. This means hyperv_pcpu_output_a=
rg
is never allocated during hv_common_init() and remains NULL.

Consequently, arch/x86/hyperv/hv_init.c:hv_apicid_to_vp_index() dereferences
this unallocated pointer:

arch/x86/hyperv/hv_init.c:hv_apicid_to_vp_index() {
        ...
        output =3D *this_cpu_ptr(hyperv_pcpu_output_arg);
        ...
        status =3D hv_do_hypercall(HVCALL_GET_VP_ID_FROM_APIC_ID, input, ou=
tput);
        ...
}

Since this_cpu_ptr(NULL) resolves to the base of the per-CPU area, it
dereferences a garbage pointer. This is then passed to hv_do_hypercall(),
causing the hypervisor to overwrite random physical memory with the hyperca=
ll
result, and eventually oopsing the kernel when output[0] is read.

Should hv_output_page_exists() also be extended to account for SEV-SNP
guests that rely on hv_apicid_to_vp_index() during boot?

>  }
> =20
>  void __init hv_get_partition_id(void)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D2
