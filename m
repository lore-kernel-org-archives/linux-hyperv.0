Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698213C9EDD;
	Tue,  4 Aug 2026 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785828964; cv=none; b=IB92Cyvzy3UawlwvaxR2BoDU/v/E3HSlKfFjLv1di3MLjY5h8kw0Oo2UZ9rtUwbnjRrNIaKSfx0rTfoJx9NK3PJ0LoNCV3Hhp1HYJw52uMeSPPy70VvGU4LJt4lz7bhKqeXZKPJ/Q7kEXra9x/Zv5SPEb+PdDbkWkok55WvASQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785828964; c=relaxed/simple;
	bh=EJJ193UySnwbWymTAPQfISlUSrqUut1CwCXNbxDNPMI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OQlTJolFWAW9+zko77oiYIDYgrLxs7Ltt3/dTqNPKqw+33RQYNS2S5k7xhMFa9CJNkRpKSmW5xMwgaJTD2FqdmQSEy8HVUdZThcOIh98d/u0jjqS1F18ANboKQivvt1H2mKbzD6/OlrvaBBE8SNzR8/WHabH+NV6n5MEHW3KESQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HyqgoA41; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HyqgoA41"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C33681F00A3A;
	Tue,  4 Aug 2026 07:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785828963;
	bh=j7Qmntk2tBJFBDcj/36C0Dw/HVIoGjptr9Cb3gTmcJg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HyqgoA419F8tZr7WFw81sy0EPxzRwvUWCFIfdnhWzy7BapofKF9o1udh0d77ymLLx
	 a5IlNPglI5KCIoG2RBPjXJXjPZHV+p1CtErT73ggFc65ETD050IBMJOQLHqcpnZN26
	 msrP1SWkuIQLfbeiZ/6WX/9rgv+J8vIR9f6rXP3PztxiT8jPWbCysI2JvGNJiMGxWL
	 EX4Llsh06VNa9XAHNS+h+Ni501FYUF6hqtTVTPM9R8jUpQ8HGT2XOMzhxapOKSIOqI
	 hrKGFdjObi/Hi3NmGyKjY/5B/6cIDy6C3dKp5vv0op9ke7h0lV5OEafjdJOF4MKlIK
	 08p2l6X6MGR6w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/5] locking/qspinlock: Add contended_release tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dmitry Ilvokhin" <d@ilvokhin.com>
Cc: kvm@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <0d998e22a0c595f670cfc6725bb683323aced5cb.1785778551.git.d@ilvokhin.com>
References: <cover.1785778551.git.d@ilvokhin.com>
 <0d998e22a0c595f670cfc6725bb683323aced5cb.1785778551.git.d@ilvokhin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:36:02 +0000
Message-Id: <20260804073602.C33681F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The inline function `queued_spin_unlock()` references a GPL-only t=
racepoint symbol, inadvertently turning `spin_unlock()` into a GPL-only API=
 and breaking non-GPL out-of-tree modules.
- [High] The lock release tracepoint bypasses the RCU watching check, allow=
ing trace probes to execute unsafely in idle/offline contexts.
--

--- Patch [3]: [PATCH 3/5] locking/qspinlock: Add contended_release tracepo=
int ---
commit afc21b7e9fbc296817ffabe3684c2756069801e5
Author: Dmitry Ilvokhin <d@ilvokhin.com>

locking/qspinlock: Add contended_release tracepoint

This commit adds a contended_release tracepoint to qspinlock to allow
attributing a contended spinlock to its holder. It combines the contention
check and trace call in an out-of-line function to minimize overhead on
the hot path. The feature is gated behind a new configuration option.

Link: https://lore.kernel.org/all/aiphFXe_TPNPxZ_n@shell.ilvokhin.com/

> diff --git a/include/asm-generic/qspinlock.h b/include/asm-generic/qspinl=
ock.h
> index ae45289e8ec7f..2ca94e41823b9 100644
> --- a/include/asm-generic/qspinlock.h
> +++ b/include/asm-generic/qspinlock.h
[ ... ]
> @@ -130,12 +131,32 @@ static __always_inline void queued_spin_release(str=
uct qspinlock *lock)
>  #endif
> =20
>  #ifndef queued_spin_unlock
> +
> +DECLARE_TRACEPOINT(contended_release);
> +
> +extern void queued_spin_release_traced(struct qspinlock *lock);
> +
>  /**
>   * queued_spin_unlock - unlock a queued spinlock
>   * @lock : Pointer to queued spinlock structure
> + *
> + * Generic tracing wrapper around the arch-overridable
> + * queued_spin_release().
>   */
>  static __always_inline void queued_spin_unlock(struct qspinlock *lock)
>  {
> +	/*
> +	 * Trace and release are combined in queued_spin_release_traced() so
> +	 * the compiler does not need to preserve the lock pointer across the
> +	 * function call, avoiding callee-saved register save/restore on the
> +	 * hot path. queued_spin_release() is therefore called both here and in
> +	 * queued_spin_release_traced(). Keep the two in sync.
> +	 */
> +	if (IS_ENABLED(CONFIG_QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE) &&
> +	    tracepoint_enabled(contended_release)) {

[Severity: High]
Does this inadvertently make spin_unlock() a GPL-only API?

The contended_release tracepoint is exported via EXPORT_TRACEPOINT_SYMBOL_G=
PL
in mutex.c.

When spin_unlock() is inlined, this injects the GPL-only symbol into every
module calling spin_unlock().

Would this break the compilation or loading of non-GPL out-of-tree modules
due to referencing a GPL-only symbol?

> +		queued_spin_release_traced(lock);
> +		return;
> +	}
>  	queued_spin_release(lock);
>  }
>  #endif
> diff --git a/kernel/locking/qspinlock.c b/kernel/locking/qspinlock.c
> index af8d122bb649e..33fe6d437c8f6 100644
> --- a/kernel/locking/qspinlock.c
> +++ b/kernel/locking/qspinlock.c
[ ... ]
> @@ -104,6 +104,28 @@ static __always_inline u32  __pv_wait_head_or_lock(s=
truct qspinlock *lock,
>  #define queued_spin_lock_slowpath	native_queued_spin_lock_slowpath
>  #endif
> =20
> +#if !defined(queued_spin_unlock) && \
> +	IS_ENABLED(CONFIG_QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE)
> +/*
> + * Out-of-line trace-and-release path for queued_spin_unlock(), used when
> + * the contended_release tracepoint is enabled.
> + *
> + * queued_spin_release() is duplicated here on purpose: doing the release
> + * in this function (rather than tracing here and releasing in the calle=
r)
> + * lets queued_spin_unlock() return right after the call, so the
> + * tracepoint-disabled hot path never has to keep lock live across a call
> + * in a callee-saved register. Keep this release in sync with the one in
> + * queued_spin_unlock().
> + */
> +void __lockfunc queued_spin_release_traced(struct qspinlock *lock)
> +{
> +	if (queued_spin_is_contended(lock))
> +		trace_call__contended_release(lock);

[Severity: High]
Does calling trace_call__contended_release() directly bypass the RCU
watching checks?

Raw spinlocks are often used in the scheduler idle loop or CPU hotplug
paths where RCU is explicitly not watching (for example, after
rcu_idle_enter() is called).

The standard trace_contended_release() wrapper includes a lockdep safety
check to warn if RCU is not watching.

Could this direct call allow trace probes to execute unsafely in idle or
offline contexts, potentially causing RCU splats or use-after-free bugs if
attached BPF programs or ftrace plugins dereference RCU-protected data?

> +	queued_spin_release(lock);
> +}
> +EXPORT_SYMBOL(queued_spin_release_traced);
> +#endif
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1785778551.gi=
t.d@ilvokhin.com?part=3D3
