Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C941C409114
	for <linux-hyperv@vger.kernel.org>; Fri, 11 Sep 2026 18:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789149911; cv=none; b=X49SiH+9XbqIzUEwO1XBa2qJHefnD3SThu6jUyzs4TJWXYTWtJxW7jiFidUpmnNHJcszqdPu6oVKF9uJfqNUjlvr90OKZJ9ceQt9vmhmFQz/X2/l0eINoJFnjAgvhTrYwa8ZXP1UL86HxvNr83sRAWILmtlfLxvsed5j8KLwUjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789149911; c=relaxed/simple;
	bh=x5eb9G8RA5C1R/95nWnHIEZMgOWJge9ekJd6ytuYk/k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n8FUmEnq5jhC1HBpGbIqRoWXBCUSVS8jKAHQO/43uiwHR+tK617bLFcqCS6dxyUBEhlyrQGzX0GtC7k4aXcucd/jkip2xmgIjvyYwxlxoVnsN0HWBJZfQD4TD4vymaQD3rQpU+5e7+CPbKN5/aBfkurK2KyMx2i5aYc7WM/DEXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8x0Pv/g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8x0Pv/g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A5981F000FF;
	Fri, 11 Sep 2026 18:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789149909;
	bh=s/pVsU7ISrakQOpTRlwInBqCbr/4bXHwGf0jLRbNT1U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Y8x0Pv/g+wSJglDSQuhFjhYjqtgLspI9I3jRgFO5czqG96MbdA4u9073MoDVsDq1R
	 vUj+iCdiVmIh9R+OEK4DVyNOame5v25hsZChbH4rorJCql5bkGE/8lrFPuXBzD6PVm
	 Xmtp5b4eBNmcbVe90SG8Y68PvnMUn3UH8RVKjzch1t+HZZKdYUulr0BxGB5peq+Upw
	 qOuwR9Fp/FTfW5/A7MPQ+H+HFufCzGSRouSP5YMdFWJrIVpDk+nCJNCDufjVRGCoof
	 IPpthpTir2+0NUlMdBhMH4BjFj0RsI/kRsa6vXGZIlFi6CvkcZvBWDaAjk/cMpBcv4
	 46x1CRZZl12GA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] mshv_vtl: Check per-CPU register page before mmap
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hardik Garg" <hargar@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260911175146.1370148-1-hargar@linux.microsoft.com>
References: <20260911175146.1370148-1-hargar@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 18:05:09 +0000
Message-Id: <20260911180509.8A5981F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning VM_FAULT_NOPAGE for invalid memory offsets without insta=
lling a PTE causes an unkillable infinite page fault loop.
- [High] Per-CPU memory allocated for `run` and `reg_page` is leaked on dri=
ver module unload and upon CPU hotplug setup failures.
- [High] Premature character device registration allows userspace to trigge=
r page faults and ioctls before per-CPU data is initialized, bypassing the =
newly added `if (!page)` check and causing kernel panics or UAF.
--

commit 33a60782bd60657bd70b537be47acdb4ffe78f38
Author: Hardik Garg <hargar@linux.microsoft.com>

mshv_vtl: Check per-CPU register page before mmap

Register-page setup is optional for each CPU. If allocation or
registration fails, mshv_vtl_configure_reg_page() warns and leaves that
CPU's reg_page NULL, but initial context setup continues successfully.
Meanwhile, successful setup on another CPU sets the global
mshv_has_reg_page flag.

mshv_vtl_fault() checks this global flag before selecting the requested
CPU's register page. With mixed setup results across online CPUs, the
check passes even for a CPU with no register page, reaching
get_page(NULL) when userspace faults in that mapping.

Check the selected per-CPU register page before taking its reference and
return VM_FAULT_SIGBUS if it is absent.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Cc: stable@vger.kernel.org

> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 6e3c11c681717..d8225242c73f8 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -819,6 +819,9 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>  		return VM_FAULT_NOPAGE;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but returning VM_FAULT_NOPAGE
for an invalid memory offset without installing a PTE causes an unkillable
infinite page fault loop.

If a userspace process maps the /dev/mshv device and accesses an invalid pa=
ge
offset (neither MSHV_RUN_PAGE_OFFSET nor MSHV_REG_PAGE_OFFSET), this else
branch is taken. Returning VM_FAULT_NOPAGE signals to the core MM subsystem
that the fault handler successfully installed the page table entry, so the
kernel returns to userspace without doing anything. Since no PTE was actual=
ly
installed, the CPU will immediately re-fault on the same instruction, creat=
ing
a 100% CPU hung task.

Could we return VM_FAULT_SIGBUS here instead?

> =20
> +	if (!page)
> +		return VM_FAULT_SIGBUS;

[Severity: High]
This is a pre-existing issue, but premature character device registration
allows userspace to bypass this newly added check.

In mshv_vtl_init(), the character device is exposed to userspace early:

mshv_vtl_init() {
    ...
    ret =3D misc_register(&mshv_dev);
    ...
}

If a userspace process races the module initialization by opening /dev/mshv
and mapping it before hv_vtl_setup_synic() allocates the per-CPU run page,
mshv_vtl_cpu_run(cpu) will return NULL.

When this happens, virt_to_page(NULL) is called:

mshv_vtl_fault() {
    ...
    if (real_off =3D=3D MSHV_RUN_PAGE_OFFSET) {
        page =3D virt_to_page(mshv_vtl_cpu_run(cpu));
    ...
}

This produces a garbage non-NULL pointer, causing the new if (!page) check
to pass, and the subsequent get_page() will dereference the garbage pointer
and panic.

If initialization subsequently fails, the module load aborts and .text is
freed while the racing userspace process retains an open file descriptor,
leading to a use-after-free.

Could the device registration be deferred until after the per-CPU data is
initialized?

> +
>  	get_page(page);
>  	vmf->page =3D page;
> =20

[Severity: High]
This is a pre-existing issue, but does this code leak the per-CPU pages
allocated for run and reg_page on driver module unload and upon CPU hotplug
setup failures?

When setting up the hotplug state, the teardown callback is set to NULL:

hv_vtl_setup_synic() {
    ...
    ret =3D cpuhp_setup_state(CPUHP_AP_ONLINE_DYN, "hyperv/vtl:online",
                            mshv_vtl_alloc_context, NULL);
    ...
}

When the module unloads, cpuhp_remove_state() is called, but without a
teardown callback, the memory permanently allocated via __get_free_page()
in mshv_vtl_alloc_context() is leaked:

mshv_vtl_alloc_context() {
    ...
    per_cpu->run =3D (struct mshv_vtl_run *)
        __get_free_page(GFP_KERNEL | __GFP_ZERO);
    ...
}

Additionally, if the hotplug state setup fails midway, the successfully
processed CPUs will not be cleaned up.

Could a teardown callback be provided to free these pages?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911175146.1370=
148-1-hargar@linux.microsoft.com?part=3D1
