Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBA03C3F48;
	Tue,  4 Aug 2026 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870110; cv=none; b=XX3fiv0KsXmzNxuMWkcplIpZlSFjsajstZXAYpPlvuEKzv7yMpqjGcZs4a4dQlAuF07Y4w6Y+i4j3J3+CvNbqoiIn2PTn7iZRAukjbz+CNLyJDMh+AC3tiS8XF8To8dYl0u8py5+t0SV6/fiY64teLhfECtpJDup+Fpo/odoIwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870110; c=relaxed/simple;
	bh=3vya2HqjvkHNwjwQGGPkJF62irtxeSqzqP1qfAQivR8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StQGm0Q4qSP+cmcBfs7P27knE8hZe92+ckB4fvJ0AX6xFr+1vUMzhpEmpveqAOPe79S3hL5Cc+5+pBPTyWrm0UkUfE10B83aoWeXUKKSbhO4QDQfI+CXMKoZ3YATdkS23r+xS0JjliGayjd7LrHScnoV6D8cpPml/W5kDpZJwnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=i0HieeVU; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="i0HieeVU"
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 45BCB40E00C4;
	Tue,  4 Aug 2026 19:01:44 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id AlYW3JH6yZ7B; Tue,  4 Aug 2026 19:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785870092; bh=jTsy9ZARpgzdc80qYRTp3ZXD5rupzYp290aPlne24Qo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i0HieeVUumgJVayfbtPXTLtU9jBWToWFEfi863xOYMBKUVkhNQ0/BrVP6oPJRFif1
	 RGcTlXKPfkv3nwc3J6ik7Eoh+noJN7Y/49GURDCHiWmmcvjurYMzUfD5PiEHDk30cJ
	 pRNh4761TsVzHwyED8UB3oOsW/8KQRN3Mx749T5gWDfd00+A8+mFaHrqBYTGTGIryy
	 1YPo/r7tQzScAcbHiBe85j+9dxxQ1Y731eyF2lUw4Sly7Q3WVTpF3AMKJkf1uQzBeb
	 JYieO0HiWqsbzQPpPDzv9bTeOhd9OR72c9RvUYbqA+jOYpkvx07+CUAkReUdW59gi0
	 DEUGAN1LYWIUv6YarDwWUXxZMIEwPcB3vzm2FdFf05VVMvdQylixP4wN45bPVdqxMU
	 Kn3fe9OIqnxcur1gYV2y0vcl5y6+qcZQuCJISJ6PNY7JBIodKNlAd38lRkhXr5dcLn
	 ue0Fz+kQit+Fm1CnjBOmMu8dJCugOFpc7mCGptKUAONYjDfNlE7xcYS3TW8V8TeJ0I
	 otMAHzrkRKiVwHtrfjaDjpwIXwb7+HQ0fvxUrGTFlI1hc5AMrr8BoufCl/Fvn4BE8B
	 iR/+7JkM+My3QbPAtTN6ne7lhMXJnvOUNGV/mcaWods81JxYTbV35yHlLwwgWKwy7S
	 DIyILA9dtJY98R+pyzsu94ok=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 35E3D40E014A;
	Tue,  4 Aug 2026 19:00:51 +0000 (UTC)
Date: Tue, 4 Aug 2026 12:00:48 -0700
From: Borislav Petkov <bp@alien8.de>
To: Dmitry Ilvokhin <d@ilvokhin.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>, Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	kvm@vger.kernel.org, xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 1/5] x86/paravirt: Use static_call() for the paravirt
 spinlock ops
Message-ID: <20260804190048.GCanI24Hb5P8qAyVZs@fat_crate.local>
References: <cover.1785778551.git.d@ilvokhin.com>
 <9a32ae399eb804a02a31af04dcabe7e7ee4f3fdf.1785778551.git.d@ilvokhin.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <9a32ae399eb804a02a31af04dcabe7e7ee4f3fdf.1785778551.git.d@ilvokhin.com>

On Tue, Aug 04, 2026 at 07:15:41AM +0000, Dmitry Ilvokhin wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> 
> queued_spin_lock_slowpath() and queued_spin_unlock() are dispatched
> through pv_ops_lock via the paravirt-ops ALTERNATIVE machinery, which
> picks the target (native inline store / hypervisor call) once at boot
> and cannot change at runtime.
> 
> Convert both to static_call(). The site becomes a direct call patched in
> place (one byte smaller), and on native the unlock still collapses to
> the inline "movb $0, (%rdi)" store, so the fast path is unchanged.
> 
> Unlike the ALTERNATIVE mechanism, a static_call() target can also be
> updated at runtime via static_call_update(). This is a prerequisite for
> the contended_release tracepoint, which has to swap in a traced unlock
> while the system is running.
> 
> [ ilvokhin: commit message; fix PARAVIRT_SPINLOCKS=n build; teach
>   __static_call_validate() about the inline unlock insn; make the
>   slowpath site module-safe: static_call_mod() +
>   EXPORT_STATIC_CALL_TRAMP(); pass @lock to the callee-save unlock,
>   fixing a boot hang under CALL_DEPTH_TRACKING. Boot tested native + KVM
>   PV guest. ]
> 
> Link: https://lore.kernel.org/all/20260603120811.GW3493090@noisy.programming.kicks-ass.net/
> Co-developed-by: Dmitry Ilvokhin <d@ilvokhin.com>
> Signed-off-by: Dmitry Ilvokhin <d@ilvokhin.com>

This needs Peter's SOB.

> ---
>  arch/x86/hyperv/hv_spinlock.c            |  4 ++--
>  arch/x86/include/asm/cpufeatures.h       |  1 -
>  arch/x86/include/asm/paravirt-spinlock.h | 19 +++++++++++------
>  arch/x86/kernel/kvm.c                    |  5 ++---
>  arch/x86/kernel/paravirt-spinlocks.c     | 12 +++++------
>  arch/x86/kernel/static_call.c            | 27 ++++++++++++++++++++++++
>  arch/x86/xen/spinlock.c                  |  5 ++---
>  tools/arch/x86/include/asm/cpufeatures.h |  1 -
>  8 files changed, 51 insertions(+), 23 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_spinlock.c b/arch/x86/hyperv/hv_spinlock.c
> index 210b494e4de0..6b4bdea18218 100644
> --- a/arch/x86/hyperv/hv_spinlock.c
> +++ b/arch/x86/hyperv/hv_spinlock.c
> @@ -78,8 +78,8 @@ void __init hv_init_spinlocks(void)
>  	pr_info("PV spinlocks enabled\n");
>  
>  	__pv_init_lock_hash();
> -	pv_ops_lock.queued_spin_lock_slowpath = __pv_queued_spin_lock_slowpath;
> -	pv_ops_lock.queued_spin_unlock = PV_CALLEE_SAVE(__pv_queued_spin_unlock);
> +	static_call_update(queued_spin_lock_slowpath, __pv_queued_spin_lock_slowpath);
> +	static_call_update(queued_spin_unlock, __raw_callee_save___pv_queued_spin_unlock);
>  	pv_ops_lock.wait = hv_qlock_wait;
>  	pv_ops_lock.kick = hv_qlock_kick;
>  	pv_ops_lock.vcpu_is_preempted = PV_CALLEE_SAVE(hv_vcpu_is_preempted);
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index 1b4a48bff18f..e41fe5c24841 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -225,7 +225,6 @@
>  #define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
>  #define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
>  #define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
> -#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */

No, do:

/* free: was #define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */

so that we can reuse it by finding it easier.

>  #define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
>  #define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
