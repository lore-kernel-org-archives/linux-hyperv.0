Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270262641CA
	for <linux-hyperv@vger.kernel.org>; Mon, 10 Aug 2026 13:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786367403; cv=none; b=H1OcEJfYEcVN1U2fmE48SUDZ5mJWerbb/v5WwFG9DD4wiKCUETrVAFnMBlcThjmynU87goH4JCjE/epMfQxFo+xxrrjczkCjVZ0WufyexUpNtkhuLc6ngSG+yzZCygXxXqp3G2U+Z/KHO2rUtRWwpPKPFCndN0ACspIv3/0XTf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786367403; c=relaxed/simple;
	bh=cUZ7uko43dtmPcOtVV5SZKtbxHRhbuZH9SZIsUG8RwQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bgQ+FX3LJdiEtg7XaRfFIQXLym997boH4pIO6enbfjXXAUwFzfslvelyPjCgIGKyZeLTZOtzOn1mRGlvO/5mU+no6jzi+bzLZrl/SVTSgQwEK3GBvHsVPQIYimABF4ZsQf6q9+n/Oc+3B8UkoO1sD9h8ClOtZYRKVXvW7EXHRnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwAiHq3W; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwAiHq3W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE771F000E9;
	Mon, 10 Aug 2026 13:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786367401;
	bh=2BdO7Q1FxCxkCMhFgoH/y1YZ+lDA6D1n11DvDEeCjmc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UwAiHq3W/iPJzQIqeR0mWHmFAePTJOk3jvI9+YiBbtB1GsolIsAJZb5j5BSF/eSHy
	 3vnbimt4lWGBjiPbbwL2ZFHw7BRcRE06Mhb+rktCt5yHahPF13vA7NPIvYadfZPaC1
	 1uH7wYAqrsngmOo+dSIpFNGHZ1SL+XJKsihrHX8zsf0to+zFIYbjDwbmxiP2YGTo95
	 sVRJRqexvbFDbUfT5vJGqfk1nzsSXMA95yx3XeP+FDlocwLa/kTCQrRteT0g/P8LYx
	 aO/7BwqzK1f9Gw2xsvvpvZ2r4FR58waQSEVHZt/PoVj8jHfH58fIgmMZJAWD/2pdGG
	 dzkCKOr++PtzQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/13] mshv: unlock SNP pages on panic for crashdump
 collection
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260810124527.1409634-12-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-12-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 13:10:00 +0000
Message-Id: <20260810131001.ADE771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Panic notifier fails to set crash_kexec_post_notifiers globally, b=
ypassing memory unmap in default configurations.
- [High] Acquiring spinlock_t via spin_trylock in a panic notifier is struc=
turally unsafe and violates PREEMPT_RT wait-context rules.
- [Medium] Panic path memory unlocking aborts on the first chunk error, fai=
ling to execute best-effort vmcore recovery.
- [Low] Missing rcu_read_lock() during RCU hash table traversal.
- [Low] Misleading success message is logged unconditionally even if SNP un=
locking completely aborts.
--

--- Patch [11]: [PATCH v2 11/13] mshv: unlock SNP pages on panic for crashd=
ump collection ---
commit b8503cbf714b3ffa7932540f4a80cc94da615bdc
Author: Wei Hu <weh@microsoft.com>

mshv: unlock SNP pages on panic for crashdump collection

Add an SNP panic-path page-unlock feature so a root partition running
confidential (SEV-SNP) guests can still collect a Linux root vmcore via
kexec after a crash. On panic, guest pages of every encrypted partition
are unmapped and shared back to the host so kexec can read them.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 0dbf509351bb0..6b38a45ad43cc 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2941,6 +2941,81 @@ static int __init mshv_init_vmm_caps(struct device=
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
> +	if (!spin_trylock(&vm->pt_mem_regions_lock)) {
> +		pt_err(vm, "Cannot lock SNP memory regions during panic\n");
> +		return;
> +	}

[Severity: High]
Is it safe to acquire a spinlock_t via spin_trylock() in a panic notifier?

Calling spin_trylock() on a spinlock_t from a hardirq or NMI context violat=
es
PREEMPT_RT wait-context rules.=20

Additionally, if the CPU that panicked happens to hold this lock, the trylo=
ck
will fail and bypass the memory unmap entirely, breaking the kexec crashdum=
p.

> +
> +	hlist_for_each_entry(memreg, &vm->pt_mem_regions, hnode) {
> +		mshv_region_unmap(memreg);
> +		ret =3D mshv_region_share(memreg);

[Severity: Medium]
Will this abort prematurely if an error occurs on a single chunk?

The return value of mshv_region_unmap() is ignored, and both underlying
functions call mshv_region_process_range() which aborts immediately on the
first error.

Could a best-effort approach be used here to continue attempting to unlock
remaining regions instead of halting on the first hypercall failure?

> +		if (ret)
> +			pt_err(vm, "Unlock snp failed. ret:0x%x gfn:%llx numpfns:%lld\n",
> +			       ret, memreg->start_gfn, memreg->nr_pages);
> +	}
> +
> +	spin_unlock(&vm->pt_mem_regions_lock);
> +}
> +
> +static int mshv_root_panic_cb(struct notifier_block *this, unsigned long=
 event,
> +			      void *ptr)
> +{
> +	int i, done =3D 0;
> +	struct mshv_partition *pt;
> +	struct device *dev =3D NULL;
> +
> +	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {

[Severity: Low]
Should this RCU hash table traversal be protected by rcu_read_lock()?

While preemption is stopped in the panic path, RCU subsystem semantics still
dictate explicitly delimiting the critical section to prevent static checker
warnings.

> +		if (!mshv_partition_encrypted(pt))
> +			continue;
> +
> +		done =3D 1;
> +		mshv_panic_unlock_snp(pt);
> +		dev =3D pt->pt_module_dev;
> +	}
> +	if (done && dev)
> +		dev_info(dev, "SNP pages are unlocked for panic\n");

[Severity: Low]
Could this emit a misleading success message?

The done flag is set to 1 before mshv_panic_unlock_snp() is called. If the
spin_trylock() inside mshv_panic_unlock_snp() fails and returns early, or if
an error occurs during unmapping, this will still unconditionally log that =
SNP
pages are unlocked.

> +
> +	return NOTIFY_DONE;
> +}
> +
> +static struct notifier_block mshv_root_panic_blk =3D {
> +	.notifier_call =3D mshv_root_panic_cb,
> +};
> +
> +/*
> + * If mshv devirt setup failed during boot, or the feature itself is not
> + * available, allow the system to at least collect linux root vmcore. For
> + * that, snp guest pages must be made readable in the panic path so kexe=
c can
> + * collect them.
> + */
> +static void mshv_crashdump_init(void)
> +{
> +	if (hv_crash_enabled)
> +		return;
> +
> +	atomic_notifier_chain_register(&panic_notifier_list,
> +				       &mshv_root_panic_blk);

[Severity: High]
Does this setup guarantee that the notifier will run before kexec boots?

By default, panic() calls __crash_kexec() before evaluating
panic_notifier_list.

Without explicitly setting crash_kexec_post_notifiers to true here, the
kdump kernel will boot immediately upon panic on standard configurations,
skipping the notifier list and leaving SNP memory locked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810124527.1409=
634-1-weh@linux.microsoft.com?part=3D11
