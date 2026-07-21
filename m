Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AA43634C
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Jul 2026 20:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784665472; cv=none; b=C8TAshlgGd/91lStJbqL1QKPjwK2POXZG2XkpyIyTHrP6nzIauLzhjmIpIA/2vpqxtFuWmDqPZzlkQp/AwCUc45iKIxQnQPXkVx+M22KePtSI+HnGerlKndlVZNfg7IAORuljz1SRMj6a0Y8zXPWR07GpQe22PV1jg+PR0NjbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784665472; c=relaxed/simple;
	bh=3T9+Uu/1j5E+VWZUVamomoS8Sm2zIgYRnBJTY3rHkDM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lWICtJcpC6JVRbJ/BikAY9/w1FUu+B2T51K14NaE9Y3FaANoesSrB1T9gtEJampMoHHDE1kL5fZtW3j+POP118Qqx1RZzi5KF+TzsX2LdmizAFPY8CfWckMSL+kYYdnZ504uS3Zk6ADaPnqRkU6tYvWOfhYRVXZGOzPAHDMva28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIqJehYy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIqJehYy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35E0E1F000E9;
	Tue, 21 Jul 2026 20:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784665471;
	bh=v6Qnyens/vVjjKkcPHTO7amXxx/4fB3svWNpPjtgx3E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NIqJehYyeX/XjUtmI7LqSXwUwSFAQI/9OA7COndj0OdRPvtTMfKE8Uato54f+nluQ
	 0Emd14j0seiG67TzbK9uzoYZOquKRkwEM7CHtwnZF8URiOMtiBk6IuVeOAyHG/IpFL
	 k79vnHrvY+xgFiN043p6cdX9ggzn9IF2tlr5ayFGHi8rDQLCn1681cHSVYdggzeMWd
	 WR4K0z3+Lzu2L5HK+AB4kn3lfo+s8NPe41PwkxXXNXCGidRofeAkw5Xz1kF1OfvdDH
	 /ODvIQJ6ECxQOGnUYRwOklnOR450JLArRaMg6uy9XoPg57RBVhp1Sn5x+H55twKgR4
	 WlenQPi8aHglg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/6] Drivers: hv: Mark shared memory as decrypted for
 CCA Realms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kameron Carr" <kameroncarr@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260721201148.1441143-5-kameroncarr@linux.microsoft.com>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
 <20260721201148.1441143-5-kameroncarr@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 20:24:30 +0000
Message-Id: <20260721202431.35E0E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Using `kmalloc()` for memory passed to `set_memory_decrypted()` ca=
uses silent memory corruption on x86 and initialization failures on ARM64 d=
ue to a lack of strict page alignment and KASAN/MTE pointer tagging.
--

--- Patch [4]: [PATCH v3 4/6] Drivers: hv: Mark shared memory as decrypted =
for CCA Realms ---
commit 21b5c4cec77eb56971c17ededee7133820fad287
Author: Kameron Carr <kameroncarr@linux.microsoft.com>

Drivers: hv: Mark shared memory as decrypted for CCA Realms

This patch extends confidential VM isolation memory decryption to Arm CCA R=
ealm
guests during hypercall memory initialization. It introduces a helper for C=
CA
isolation and updates the hypercall buffer allocation path to use it.

> diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> index 6b67ac6167891..0f9412fcb9571 100644
> --- a/drivers/hv/hv_common.c
> +++ b/drivers/hv/hv_common.c
[ ... ]
> @@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
>  	 * online and then taken offline
>  	 */
>  	if (!*inputarg) {
> -		mem =3D kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
> +		mem =3D kmalloc(alloc_size, flags);
>  		if (!mem)
>  			return -ENOMEM;
> =20
> @@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
>  		}
> =20
>  		if (!ms_hyperv.paravisor_present &&
> -		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
> -			ret =3D set_memory_decrypted((unsigned long)mem, pgcount);
> +		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
> +		     hv_isolation_type_cca())) {
> +			ret =3D set_memory_decrypted((unsigned long)mem,
> +						   alloc_size >> PAGE_SHIFT);

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to pass memory=20
allocated by kmalloc to set_memory_decrypted() in hv_common_cpu_init()?

When kmalloc is used with SLUB_DEBUG, the returned pointer is not strictly=
=20
page-aligned. Because set_memory_decrypted() operates on page frames and
rounds down to the page boundary, this could silently decrypt adjacent slab
objects or metadata on x86 architectures.

Additionally, on arm64 systems with MTE enabled, kmalloc returns a tagged=20
pointer. Passing a tagged pointer to set_memory_decrypted() causes its
internal __is_lm_address() check to fail, leading to initialization failures
during boot or CPU hotplug for CCA guests.

Would it be better to allocate this memory using the page allocator, such a=
s=20
with __get_free_pages(), to ensure the address is strictly page-aligned and=
=20
untagged?

>  			if (ret) {
>  				/* It may be unsafe to free 'mem' */
>  				return ret;
>  			}
> =20
> -			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
> +			memset(mem, 0x00, alloc_size);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721201148.1441=
143-1-kameroncarr@linux.microsoft.com?part=3D4
