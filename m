Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181B1488748
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 17:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788284166; cv=none; b=KUoqWGLjCgWfKIzT1irZRQJlKAj+91vbjqB0mFeE8C0COnkdHhV9c9HPvAgTHp0dNiewQgCyTscQCqY6CugKB2/DbIR4g7me1etqdVgUXpIAJZ7B+h7U0oNgYGQknnr6FOEbp9wEcsL9VnclY0kl7S2XC+AGWU1QBVKBvLieqe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788284166; c=relaxed/simple;
	bh=woMRMbAQfrwWwLkVHdRoa2dqv1IryQst0XdmKgJ+R2E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q9v1BiUeZ53Y012LQysjN76EdGgAMl3/HSyChcS0d9ZPTH5eS0httCEYXw8y6VBber06zZ+h/ZdLu1y876sVUoAgDVGRVf/1Qmgdr+Fj6UNRsXGeaTjSCZ9Y5bxTiMS2ccmoIsnNTOPXi8bpuUIiYgIyE5RCtanqiLH02ydAko4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GXinqLVx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GXinqLVx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66DAC1F00A3E;
	Tue,  1 Sep 2026 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788284164;
	bh=tMOM+bYXSVneAtTzaHWR8vQXVqidoo+dHQ2bJh3nXbc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GXinqLVxwjFYf5ahzeDgq5r3YlwaZpDgzKjG0Y0AiaYVeyr2To4u8/fAILp7YfEuP
	 5TQ8yOL0XQvUivXdZZiwzAo1BWFdWy/55CnTXjZ5VE56tRGJ587Rx6fhszLVY4MuJt
	 me+G361LXMPVRxEaAgpYTNhviJDP9tplqoDJYhndE6wunIO82nCmSW3BIl0ey67gI5
	 5g5cuixdzlQn8cL82qi4yi+/0F/5ogirKccDJLgxItAlB8HjJEe4HHDyvNdYatCtJc
	 rFz+chIbjmljCjyohn69cwqtpFZifORBKIXsCjKAfwtOpMq1I/BbpTmVX1WArmcrQv
	 AlARJ/j/S3z5A==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 09/12] drivers: hv: hv_vsm_boot: Enable VTL1 on the
 boot processor
Reply-To: sashiko-reviews@lists.linux.dev
To: "Thara Gopinath" <tgopinath@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260901165647.3160413-10-tgopinath@linux.microsoft.com>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-10-tgopinath@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 17:36:03 +0000
Message-Id: <20260901173604.66DAC1F00A3E@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Unconditional loading of the secure kernel overwrites VTL1 memory =
even if VTL1 is already active, leading to memory corruption or fatal fault=
s.

Pre-existing issues:
- [High] Missing bounds check when parsing ELF program headers from firmwar=
e, leading to potential out-of-bounds read.
--

commit 58f06b8de69e2f750e55a8ff7220ab38d88c0f8f
Author: Thara Gopinath <tgopinath@linux.microsoft.com>

drivers: hv: hv_vsm_boot: Enable VTL1 on the boot processor

This commit introduces helpers to get VP status and enable VTL1 on the boot
virtual processor. It extends hv_vsm_bootstrap_vtl() to enable VTL1 on the
boot VP if it is not already enabled, and re-queries the status to confirm
the transition.

> diff --git a/drivers/hv/hv_vsm_boot.c b/drivers/hv/hv_vsm_boot.c
> index dc20f935da5b2..abe82e03e1897 100644
> --- a/drivers/hv/hv_vsm_boot.c
> +++ b/drivers/hv/hv_vsm_boot.c
> @@ -216,6 +216,47 @@ static int __init hv_vsm_load_secure_kernel(Elf64_Ad=
dr *sk_entry_pa)
>  	return ret;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but there appears to be a missing
bounds check when parsing ELF program headers from the firmware in
hv_vsm_load_elf() which is called by hv_vsm_load_secure_kernel().

The firmware size (fw->size) is discarded instead of being passed to
hv_vsm_load_elf() for validation. Inside hv_vsm_load_elf(), the program hea=
der
table offset (e_phoff) is never bounds-checked against the firmware size be=
fore
being iterated over:

drivers/hv/hv_vsm_boot.c:hv_vsm_load_elf() {
    ...
    Elf64_Phdr *phdr =3D image + ehdr->e_phoff;
    ...
}

Later, the memcpy() copies uncontrolled lengths of kernel memory based on
untrusted firmware headers:

drivers/hv/hv_vsm_boot.c:hv_vsm_load_elf() {
    ...
    memcpy(load_addr, image + phdr->p_offset, phdr->p_filesz);
    ...
}

Could a malformed or maliciously crafted firmware file cause an out-of-boun=
ds
read past the end of the firmware buffer, potentially leaking sensitive ker=
nel
data into the secure kernel's memory or causing a kernel panic?

[ ... ]

> @@ -300,7 +342,34 @@ static int __init hv_vsm_bootstrap_vtl(void)
>  		}
>  	}
> =20
> -	return hv_vsm_load_secure_kernel(&sk_entry_pa);
> +	ret =3D hv_vsm_load_secure_kernel(&sk_entry_pa);
> +	if (ret)
> +		return ret;
> +
> +	/* Check and enable VTL1 for the primary virtual processor */
> +	ret =3D hv_vsm_get_vp_status(&vp_enabled_vtl_set, &active_mbec_enabled);
> +	if (ret)
> +		return ret;
> +
> +	if (vp_enabled_vtl_set & HV_VTL1_ENABLE_BIT) {
> +		pr_info("VP VTL1 is already enabled\n");

[Severity: High]
If VTL1 is already enabled, does calling hv_vsm_load_secure_kernel() earlier
in this function overwrite the memory of the currently running VTL1 secure
kernel?

Since hv_vsm_load_secure_kernel() is called unconditionally before checking=
 if
VP VTL1 is active, could unconditionally loading the secure kernel ELF image
cause a regression by triggering a fatal hypervisor intercept/fault in VTL0,
or silently corrupting the active VTL1 (such as during a kexec reboot)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901165647.3160=
413-1-tgopinath@linux.microsoft.com?part=3D9
