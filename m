Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 477DE2EEE9D
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Aug 2026 00:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493801; cv=none; b=uNdXa0OkcrGwm/cHrrxKHYM0iyG0ttBk0Lxi2Gnh5wZC1w/mPRgDSFDgiLpT0drMu3NSgFGTM+ePdx4GmKcwe5LrLitseNUGkj6KmAV0T6zze5YlEZzVP9BHPGktLqDxBDg1TzvXtAXOyy5S+bD5s7Qnufu71kI6eVblkkvNg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493801; c=relaxed/simple;
	bh=nMfTSDzgLr1Gfdi85oj902x1qIpCe3FpQw5IlWxH0Pw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JH+hkoMPNadt0Qbermei6HDVPYbnhynROLI1QL8SVqQoMtEWsi4hCnaz1fgadYL+zRDKR83neDhGwPh7xfWNaakBPP6Y9tkqATXpccgo4tGFuNgI8eRpKr/P3Z+seBqlrDfa7Yo/HkFzYeLNs4KHUspcQBM9vSawGrGoTb+krr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f/cMeql4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f/cMeql4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51F4D1F000E9;
	Wed, 12 Aug 2026 00:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493798;
	bh=0VUW5bp/n/CwJdZ22zb/Wk83SJ3P6iIIBcW5XyYxY/A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f/cMeql4YzHNFvt5L7mdAdGGRnDsW6ibMlXCszBiRWRBksbvWgjQ0Ms9TALYN3xMq
	 5iqHCJ7w34w4qgqPZgiweNqG9doILpWaUxjPWQ30inS/ZXOGL2mYGsxVYo58jh8/fN
	 DiaJXaa9zSyj2wvazbmqUb0P/muqn2y3dy9hxFccSDBDquRrE1MRouGh4iboTDQW7b
	 PN1RUGbtHi9/B4vzYDEOQ7Jp1mkpLTMSwmYy3SHj0buwNYk1tYm+eY5Cb/aPvSFtJa
	 nDLbmQcGUt4PkqE5mGXvRkx7v1KPwNohX4w2XVICYdWCyZ9rb8PTRQ6s4XYjM8kmT2
	 wENNLUOb9e7Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V0 1/2] mshv: Stub out deposit memory functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260812000507.3809046-2-mrathor@linux.microsoft.com>
References: <20260812000507.3809046-1-mrathor@linux.microsoft.com>
 <20260812000507.3809046-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 00:16:37 +0000
Message-Id: <20260812001638.51F4D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Intentional breakage of core driver functionality, boot crashes, a=
nd UAPI violation via hardcoded error stubs.

Pre-existing issues:
- [Critical] A partial failure during the HVCALL_MAP_GPA_PAGES batch proces=
sing fails to unmap successfully mapped pages, leaving the guest with valid=
 GPA mappings to host pages that are subsequently unpinned and reallocated.
- [Critical] A partial failure during HVCALL_RELEASE_SPARSE_SPA_PAGE_HOST_A=
CCESS causes the host to permanently lose access to pinned memory, leading =
to a host kernel crash when the pages are unpinned and reused.
--

--- Patch [1]: [PATCH V0 1/2] mshv: Stub out deposit memory functions ---
commit 31673114cbc4abf8a6e554e641203a81af3ed70c
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Stub out deposit memory functions

This commit replaces the implementations of hv_call_deposit_pages() and
hv_deposit_memory_node() with stubs that unconditionally return -ENOTSUPP.
The commit message states this is to make adding new redesigned functions
easier to review.

> diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
> index 57b2c64197cb9..d5ce9a032e9c7 100644
> --- a/drivers/hv/hv_proc.c
> +++ b/drivers/hv/hv_proc.c
> @@ -9,135 +9,15 @@
>  #include <linux/export.h>
>  #include <asm/mshyperv.h>
> =20
[ ... ]
>  int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
>  {
[ ... ]
> -free_buf:
> -	free_page((unsigned long)pages);
> -	kfree(counts);
> -	return ret;
> +	return -ENOTSUPP;
>  }

[Severity: High]
Does unconditionally returning -ENOTSUPP here break core driver
functionality and cause boot failures?

If hv_smp_prepare_cpus() in arch/x86/kernel/cpu/mshyperv.c requires memory
during early CPU setup, the -ENOTSUPP return will trigger a BUG_ON(ret),
resulting in a fatal early boot crash.

Additionally, hv_call_initialize_partition() in
drivers/hv/mshv_root_hv_call.c unconditionally calls this function.
Returning -ENOTSUPP (which is internal to the kernel) will propagate up
to the mshv_partition_ioctl return value and leak to userspace as an
unrecognized error, while guaranteeing partition creation always fails.

[Severity: Critical]
This is a pre-existing issue, but I noticed a potential problem in
drivers/hv/mshv_root_hv_call.c:hv_do_map_gpa_hcall():

		} else if (!hv_result_success(status)) {
			ret =3D hv_result_to_errno(status);
			break;
		}

		done +=3D completed;

If a partial failure occurs during the HVCALL_MAP_GPA_PAGES batch processin=
g,
the break statement skips the done +=3D completed update.

Could this permanently lose track of the successfully mapped pages in this
batch?

If the stale done value is used during cleanup, successfully mapped pages
would not be unmapped, leaving the guest with valid GPA mappings to host
pages that are subsequently unpinned and reallocated.

[Severity: Critical]
This is a pre-existing issue, but there appears to be another error handling
concern in drivers/hv/mshv_root_hv_call.c:hv_call_modify_spa_host_access():

		completed =3D hv_repcomp(status);

		if (!hv_result_success(status))
			return hv_result_to_errno(status);

		done +=3D completed;

If this hypercall partially succeeds but returns an error for a subsequent
page, the function returns immediately and discards the completed count.

Can this prevent the caller from knowing which pages need their host access
restored?

If the caller treats the region as failed and unpins the pages without
restoring host access, the host kernel allocator could reuse pages that lack
host access. This could lead to a hardware-level access violation and a fat=
al
kernel panic when the host accesses them.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812000507.3809=
046-1-mrathor@linux.microsoft.com?part=3D1
