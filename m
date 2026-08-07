Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1349AEEB3
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786119089; cv=none; b=a4rbmV1i7L8vINUircxYBU+Oe532smyYbd7ufRC7Z1y0bkzgSQaeoZ9jXKOPRqs7daTaKeK/VOVzZIceSfJBmtH4kQHoD3e1koXZHjtpcY6YndXHQ4jfXP/tWn/ERMQucZUkulbf2pd7wDU1F5bOLcNun7eP+LkAzTj21gEMPm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786119089; c=relaxed/simple;
	bh=IJopVHGUKxKKc1PS7OnfEX/bGMCqvkjtLmESysR45aI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dhSf+w/5FpkVWQPviWJfWTnSazwqWTpSfDPYrkJWU15vB9bXIYsY+J+hIccp9cIHeksW5mJPQUG4qjOwXrFuvH3J+/YnFXA86Bj4aOKcoTRkHtWgKpcPHXyZzxZHolgBdSermvRMa14dTl+kdkZzch4YYES9wcm8/FEnSUjYZ+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIL8W6vt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIL8W6vt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE4691F000E9;
	Fri,  7 Aug 2026 16:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786119088;
	bh=LSf6v5llAB9MfEGo4z/Jod/mkSqzEjRHpiDU1QSTlCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nIL8W6vtjx3KdBw0PIPr3i6JeSKh34tuefSYHMnilb5G4fK9vLLonI2GuQvRgN4bs
	 U/YnPEJ40bpXLkv04vmk+886wx9amj+1kgZshjylYUInblt5TQqF0RcioC2EYPW+VZ
	 ApB/XoFBcrjhD342VbGTUIJ3SijQctpIKQLGa3w2AJie2YlURSP7tgIt0uuIQrNG7j
	 6o+nWylIQgu6KuAcnzBLGlxSK0uJjzInq+v/LtEhSRu1ziKkOUT2dwnyj6pOG7hXy+
	 2wt1lWSr+lLNDoPspvgMdbPxK411Rl8oZpymJSJIeZzAoc7W/zXEqPCiEcG3RWfWAZ
	 LxhuWFD2oQULg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 11/13] mshv: unlock SNP pages on panic for crashdump
 collection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-12-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-12-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 16:11:26 +0000
Message-Id: <20260807161127.BE4691F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Lockless iteration of a non-RCU list in a panic notifier exposes t=
he system to poison pointer dereferences, causing a nested panic and preven=
ting crashdump collection.
--

--- Patch [11]: [PATCH v1 11/13] mshv: unlock SNP pages on panic for crashd=
ump collection ---
commit da7cefab011e489222d854cd80ab1f7f2ab3f297
Author: Wei Hu <weh@microsoft.com>

mshv: unlock SNP pages on panic for crashdump collection

This commit adds a panic notifier to unmap and share SEV-SNP guest pages
back to the host, allowing kexec to collect a valid root vmcore after a
crash. The notifier walks the partition table and unlocks memory regions
if the hypervisor's own crashdump support is inactive.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 0fbd2158968da..4d08d547704e4 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -2898,6 +2898,74 @@ static int __init mshv_init_vmm_caps(struct device=
 *dev)
>  	return 0;
>  }
> =20
> +#if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_CRASH_DUMP)
> +static void mshv_panic_unlock_snp(struct mshv_partition *vm)
> +{
> +	struct mshv_mem_region *memreg;
> +	int ret;
> +
> +	hlist_for_each_entry(memreg, &vm->pt_mem_regions, hnode) {

[Severity: High]
Is it safe to iterate pt_mem_regions locklessly here?

Since panic notifiers can run at any time, they might interrupt a concurrent
hlist_del() operation on this list. If that happens, the list removal poiso=
ns
the node pointers. This hlist_for_each_entry() traversal would then
dereference a poisoned pointer, causing a recursive panic.

A recursive panic would instantly halt the machine and abort the kexec
crashdump process, defeating the purpose of this fallback path.

Does this list need to be converted to use RCU to safely traverse it during
a panic, or is there another way to safely identify these regions without
risking a page fault?

> +		mshv_region_unmap(memreg);
> +		ret =3D mshv_region_share(memreg);
> +		if (ret)
> +			pt_err(vm, "Unlock snp failed. ret:0x%x gfn:%llx numpfns:%lld\n",
> +			       ret, memreg->start_gfn, memreg->nr_pages);
> +	}
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D11
