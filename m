Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAE725B09F;
	Sat, 18 Jul 2026 02:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342435; cv=none; b=aVGUsNnCOkf5dFEd0aBthT0SI0w4TUU3YqZ4gtrbJAWLbuTnGwoZpffd7ScFAJ3h9nc2qVphdPBitjFt7lHOnJMTQY+xRrGt29dT07lKc6nIx82gSSuqrv8ZJG33i0A7rHFQfMwiOHnbkKM55NvrNb2XgvbtXTRmZL76kD6htJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342435; c=relaxed/simple;
	bh=gukBOTJrlqBNSQzV5qwIsyC8xB9J3WkxTnfBUxZqaLU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mQQXdo9gFDVVZVADIVwmxtPehH/6gJRnRHVj/XtWYKZ2bUKJJj9teDBhbF/beCIFLlnv+vkkDFDT9O9zfxjY4wLGikAizfoRoI2prNtyWvBA7vw3JcBdilzG0nOCzvUNNcC+QytdExN7nV1zuXwM8+FI9yBPLPgYAFpqipmyW0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gmke9h6k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gmke9h6k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EE6B1F000E9;
	Sat, 18 Jul 2026 02:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784342433;
	bh=K3ZgnvmiXPTrCvvjGjQJbDzGalxlUSCCUdJlFfU6s1g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gmke9h6k5UPWZLhM1K/ZzopVKBQUF3q9PZ483BwGgD7q/gHSUrc/G01Of2Rj1KaGC
	 z/7dyQ3l59xUfRU9QxJQi/cxNeaUMpfIpoVzvcesqdkLze9zfSqlkQDgVu5xFE9JRP
	 zGLrXg5jwCurmFYbvosgl0azV2s0RZh3T5JeIwJE0uh16Uwoa/cnSpSx1Fc+G+4Ybq
	 jIaFFTeOC05IHvyplUHmxkhNQbZstybY1T1YQLlbYOSF3UF8ZxSA00ggNqvh6r9R4B
	 0iJGCZbI8rCfbUc1Io1Nf6K2lTqVYgH35rCgyAChxF6QRqUqE4b7ZYiEg1yYY1pZWD
	 rWqKymFIJ5u1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 9/9] mshv: Disable movable regions upfront if device
 passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260718021949.926306-10-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-10-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:40:33 +0000
Message-Id: <20260718024033.6EE6B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Malicious userspace can bypass memory pinning enforcement by forci=
ng copy_to_user() to fail.
- [Low] Module parameter `hv_memreg` is exposed as runtime-writable despite=
 being designed as a boot parameter.
--

--- Patch [9]: [PATCH V4 9/9] mshv: Disable movable regions upfront if devi=
ce passthru ---
commit c768ee85b3efb1c981444ab02e4e4d365693795e
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Disable movable regions upfront if device passthru

If a VM is started with a device attached, the memory regions must be marked
non-movable since the device attach hypercall allows the use of SLAT for IO=
MMU.
This patch marks them non-movable upfront upon device passthru and adds a b=
oot
parameter to allow a user to pin them manually if anticipated.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 58cf61cb227ba..b085fa13574f0 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -46,6 +46,10 @@ MODULE_DESCRIPTION("Microsoft Hyper-V root partition V=
MM interface /dev/mshv");
>  #define HV_VP_COUNTER_ROOT_DISPATCH_THREAD_BLOCKED 95
>  #endif
> =20
> +static uint hv_memreg;  /* mshv_mem_region allocations type */
> +module_param(hv_memreg, uint, 0644);

[Severity: Low]
The commit message states this is a "boot parameter". Is it intentional
that this module parameter is created with 0644 permissions? This allows
root to change the allocation policy at runtime, whereas 0444 would
correctly enforce its boot-only nature.

> +MODULE_PARM_DESC(hv_memreg, "0: movable (default), 1: pinned");
> +
>  struct mshv_root mshv_root;

[ ... ]

> @@ -1801,6 +1811,9 @@ static long mshv_partition_ioctl_create_device(stru=
ct mshv_partition *partition,
>  	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
>  		return -EFAULT;    /* cleanup in mshv_device_fop_release() */

[Severity: High]
If userspace passes a read-only memory buffer to the MSHV_CREATE_DEVICE ioc=
tl,
copy_from_user() can succeed but copy_to_user() will fault and return -EFAU=
LT.

Because the file descriptor has already been installed via anon_inode_getfd=
()
prior to the copy_to_user() call, the user can recover the functional device
FD via /proc/self/fd/ even after the ioctl returns an error.

Does this early return allow malicious userspace to bypass the memory pinni=
ng
enforcement by forcing copy_to_user() to fail, intentionally skipping the
partition->pt_regions_pinned =3D true assignment?

> =20
> +	/* For now, just mark regions pinned if there is device passthru. */
> +	partition->pt_regions_pinned =3D true;
> +
>  	return 0;
> =20
>  undo_out:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D9
