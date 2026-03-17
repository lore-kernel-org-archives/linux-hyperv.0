Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96843A6EF0;
	Tue, 17 Mar 2026 11:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745293; cv=none; b=dP0MyEim4+tlrXeCGJcyW/NAnFvuF4ZuYLrclGNZKvZi6njBHs4UlDFGHnXMu2zd6dOhiCqCCJsp6VelLrZhB5UNZUPv07bGUf0QpSqGyGtUuu6KWXDd6w7M580Ma2yuD4liu7kgAI5R3zRsPZcxnCUWDxEBVnHrGznve5aTNLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745293; c=relaxed/simple;
	bh=DDl010gbgdOETWLBVfnIYQBbn89FBFK7KNewPeQMSkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eXItisVsL2fODf3ZdSvSTTidpST+KEZmzidjUEpD6l25dKjf/mer1uE7h9lTa0BRo/818q2Ehsp2+eq5x1sZWuo6kH+ciJw/Q77vSqHw1T5E9dTQhAs9ldiow9cig4roFdHq/vNLDaxjmC+xdEpPYocI2rVjqv8YCPnygicSVYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAUWChx/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4F2gneTx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAUWChx/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4F2gneTx"
Date: Tue, 17 Mar 2026 12:01:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773745290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BMUsXnGltrhUGe5lhxPi39wC7MkjMhm1Wg4IXhiMebU=;
	b=uAUWChx//JiR1lctCMPz1mgDn79OuIsW80unb1sSnGGizsKPJBgqJb11GE276W3KzsBNm6
	/24FjixBf1PUWsqYSLQ1pn47FfjYnNBY+kwheokjHNwhas9ck4PtSWpz34PcPyX0yVNqxS
	/SIQzazF0Vy5uVu5rsm2h/Y8jL+b+gsVvEQifPQdOvsS5jvfyvTpVFXU0dp16EYfxvox2L
	e7Cd/tSx7VALz8rgApdOJQHbRVnLMw97SlOeAlSr4u5UOw6zq3/5BIBRXyZklTWwNoRUm0
	rWlhRPBdG+E5C/grtscRydoSEQLaGXbqUmgcU2jGFNZ1uV7NdOPyGWvP5ZaEUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773745290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BMUsXnGltrhUGe5lhxPi39wC7MkjMhm1Wg4IXhiMebU=;
	b=4F2gneTxd7iS2klm98kdZOnF1VKSWXeiuw90hoN1ZWkViygOj8mnV9okooLzmdtFUtOcpq
	8CfXtFWcCuY6vnCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jan Kiszka <jan.kiszka@siemens.com>,
	Peter Zijlstra <peterz@infradead.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Florian Bezdeka <florian.bezdeka@siemens.com>,
	RT <linux-rt-users@vger.kernel.org>,
	Mitchell Levy <levymitchell0@gmail.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Saurabh Singh Sengar <ssengar@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>
Subject: Re: [PATCH v3] drivers: hv: vmbus: Use kthread for vmbus interrupts
 on PREEMPT_RT
Message-ID: <20260317110128.k59TflVp@linutronix.de>
References: <289d8e52-40f8-4b22-8aa9-d0bd3bd15aae@siemens.com>
 <20260312170715.HA08BHiO@linutronix.de>
 <b0359046-3c58-47a6-b503-8a2b52cb1448@siemens.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0359046-3c58-47a6-b503-8a2b52cb1448@siemens.com>

On 2026-03-17 08:49:38 [+0100], Jan Kiszka wrote:
> >> +void vmbus_isr(void)
> >> +{
> >> +	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
> >> +		vmbus_irqd_wake();
> >> +	} else {
> >> +		lockdep_hardirq_threaded();
> > 
> > What clears this? This is wrongly placed. This should go to
> > sysvec_hyperv_callback() instead with its matching canceling part. The
> > add_interrupt_randomness() should also be there and not here.
> > sysvec_hyperv_stimer0() managed to do so.
> 
> First of all, we need to keep all this in generic code to avoid missing
> arm64.

This kind of belongs to the IRQ core code so I would prefer to see it on
IRQ entry, not in a random driver.

> But the question about lockdep_hardirq_threaded() is valid - and that
> not only for this new code: I tried hard to understand from the code how
> hardirq_threaded is managed, but I simply couldn't find the spot where
> it is reset after lockdep_hardirq_threaded() but before returning from
> the interrupt to the task that now has hardirq_threaded=1. I failed, and
> so I started a debugger. That confirms for the existing code path
> (__handle_irq_event_percpu) that we are indeed returning to the
> interrupted task with hardirq_threaded set. I'm not sure if that is
> intended that only the next irq_enter_rcu->lockdep_hardirq_enter of the
> next IRQ over this same task will reset the flag again.

While looking into it again, it assumes that you enter an IRQ and due to
the implementation if one is threaded, all of them are. So if you switch
from IRQ handling to TIMER then this does not happen "as-is" but exit
from one and then entry another at which point it is set to zero again.

> With that in mind, the new logic here is no different from the one the
> kernel used before. If both are not doing what they should, we likely
> want to add a generic reset of hardirq_threaded to the IRQ exit path(s).

The difference is that you expect that _everyone_ calling this driver
has everything else threaded. This might not be the case. That is why
this should be in core knowing what is called if threaded, use in driver
after explicit killing that flag afterwards since you don't know what
can follow or add a generic threaded infrastructure here. 

A different option which I would prefer in the drivere, would be an
explicit lockdep override for the locking class without using
lockdep_hardirq_threaded()

> > Different question: What guarantees that there won't be another
> > interrupt before this one is done? The handshake appears to be
> > deprecated. The interrupt itself returns ACKing (or not) but the actual
> > handler is delayed to this thread. Depending on the userland it could
> > take some time and I don't know how impatient the host is.
> > 
> 
> Good question. I guess people familiar with the hv interface need to
> comment on that.
> 
> >> +		__vmbus_isr();
> > Moving on. This (trying very hard here) even schedules tasklets. Why?
> > You need to disable BH before doing so. Otherwise it ends in ksoftirqd.
> > You don't want that.
> > 
> 
> You are referring to the re-existing logic now, aren't you?

Yes.

> > Couldn't the whole logic be integrated into the IRQ code? Then we could
> > have mask/ unmask if supported/ provided and threaded interrupts. Then
> > sysvec_hyperv_reenlightenment() could use a proper threaded interrupt
> > instead apic_eoi() + schedule_delayed_work(). 
> > 
> 
> Again, you are thinking x86-only. We need a portable solution.

well, ARM could use a threaded interrupt, too.

> >> +	}
> >> +}
> >>  EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
> >>  
> >>  static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
> > 
> > Sebastian
> 
> Jan

Sebastian
