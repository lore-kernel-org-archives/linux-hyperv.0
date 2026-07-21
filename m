Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D75046C4AD;
	Tue, 21 Jul 2026 15:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648878; cv=none; b=l5fqrjoB4dlhLQp1WYX9yJ21zYdXh7LxMWSKzObsE/xTQSNlYqj87HVKHfWrC4lCpAwqOQFtJJCUQJc7Fo0vUVTdqsDMCGi5wlvzJIYI1raxnCbOFSgEGt/txxrB72L6MKwb+3llFjMXC+85j0zUTn/EN7gg5ycMrfkx/WCGuJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648878; c=relaxed/simple;
	bh=M8MPzZvQT2RyQ18aDCvrd4nr6hgXjCpwjihYz7nllns=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YMY1v54nLpWoZhngkhSH8s5V2QZzqtpeH2jQLdwe4Utrm3/Uust81bPZFubiO9wcP2KiKxJuOGCheGNNICQ49evsLKk1bcxg3iZuzn2C8Y9mrPbXsiH+JvHanpu057UCGj17zI/6VzGLIl9dQOB3F8q43Ia6LMK2hHqykT3IvAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8Fa7X93; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8Fa7X93"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A961F000E9;
	Tue, 21 Jul 2026 15:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648876;
	bh=4pTB0MGXR4Vibqr5zUud9f3dqcCrmtj7Vhv9dny9GgU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=N8Fa7X93zQXemX3JSwp2Wm6m89EWzc7WgXxR4uOzwd3Axr6xZR2bU6vXQ6QELowBd
	 RM3N5AFR4Fw6Y7fMV90XArD6oN5kIy37cVq0LqeynxR2JJfGGfRdqhP3GQ4r/6DEus
	 SWxaskURo3HOzXb2eSf3rFvHQGKKjDI83vVCLs367SQgOAKUV5MJ4Lwi+rmkwY2pY8
	 gOl98ru6J153w5yDTIyg36KlGwSDnbgyiSrYItVEN6mi7MNTq88dpJsSn0WxcCXxQN
	 DG8siPGeP6UzRX/Xt4WRHF51EmxPb+LQw3bfZvI9zNj4tYioFe9TLEljjCcbGYMuAS
	 BC0jC+nLxoBuQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: Replace
 lockdep_hardirq_threaded() with lockdep annotation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260721153216.382536-2-bigeasy@linutronix.de>
References: <20260721153216.382536-1-bigeasy@linutronix.de>
 <20260721153216.382536-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 15:47:56 +0000
Message-Id: <20260721154756.A2A961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The clock event timer interrupt (HVMSG_TIMER_EXPIRED) is incor=
rectly processed in a kthread on PREEMPT_RT, violating the architectural re=
quirement that the system tick must run in hardirq context.
--

--- Patch [1]: [PATCH v2 1/2] Drivers: hv: vmbus: Replace lockdep_hardirq_t=
hreaded() with lockdep annotation ---
commit f939a4b9727e456e689d5d7488e6095b1358e5b5
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotat=
ion

This commit replaces the use of lockdep_hardirq_threaded() with a lockdep
annotation. This limits the threaded context on PREEMPT_RT to __vmbus_isr()
and clarifies that the ISR is not a shared handler.

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 23206640c6139..44877664d9d08 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -1384,8 +1384,19 @@ void vmbus_isr(void)
>  	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
>  		vmbus_irqd_wake();

[Severity: Critical]
This isn't a bug introduced by this patch, but is it safe to defer all
VMbus interrupt processing to the vmbus_irqd kthread on PREEMPT_RT?

When booting a PREEMPT_RT kernel on a Hyper-V host using legacy timer mode,
the kthread handles the hypervisor timer message and invokes the timer ISR:

vmbus_message_sched()
    if (msg->header.message_type =3D=3D HVMSG_TIMER_EXPIRED) {
        hv_stimer0_isr();

This executes the clock event handler in thread context, which breaks the
requirement that the system tick must run in hardirq context:

hv_stimer0_isr()
    ce =3D this_cpu_ptr(hv_clock_event);
    ce->event_handler(ce);

Because get_irq_regs() returns NULL when called from a kthread, calling
tick_handle_periodic() and then
update_process_times(user_mode(get_irq_regs())) will dereference a NULL
pointer and panic the kernel.

Alternatively, if high-resolution timers are used, tick_nohz_handler() sees
a NULL regs pointer and skips tick_sched_handle(), completely stalling the
scheduler tick and RCU updates, freezing the system.

>  	} else {
> -		lockdep_hardirq_threaded();
> +		static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
> +
> +		/*
> +		 * vmbus_isr is never force-threaded and always invoked at hard

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721153216.3825=
36-1-bigeasy@linutronix.de?part=3D1
