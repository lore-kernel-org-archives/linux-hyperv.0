Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 512411A239A;
	Tue, 21 Jul 2026 15:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784648986; cv=none; b=jFZ2rbhTw+F32DO3iQCyGIvMjuUSYH91vFDPV0ZxbjKekuYsnpfCRE1xCoNs5VVVcm6W12rFryEdfPoK0c25os7YSPNXAGNPTyFMw2HeGfwTEE6+mOZCNjIKIRKXTPw9qd9c2I3Sqp/WYppYr4QhLq5Li+ZHzTCU82KxUh1pyrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784648986; c=relaxed/simple;
	bh=XAy/MJK6tuuooFgAQobeeG+2mH0kFOGcU5kVjtdFVqI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GBuG/hmEWgaJuyZavtSBeypkYKzpm6nBU/JcScOREytAKkDYDRA7eeRIKOAeBgrFSbBbE+2zeIkR6L2nYi+KkXJ85rP8IjhGlGmS+XyXpOZYz2rJguq+AlucafTw1fRxaNU+WqTOt8nGWPedtuJzpha91hGVVjC64/PlZpZD/Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hb6BKa2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hb6BKa2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A09BD1F00A3D;
	Tue, 21 Jul 2026 15:49:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784648983;
	bh=+39Maqyi+rI2vo3QXzlwlS1yWNsub6gIne/Wxa/OVbk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hb6BKa2Tgb6NWG9sSao1UnYC3rViK3rfBjWDZIQ2dQbQ1h3iBEdv3PU1rGloktnWh
	 vKqvxwjyH7vhnIi6lQ72mVlW9bQYK59ftB5jomyh5E0biyuUOr6Q1NhICmgXJ5yTNz
	 04NsvyczKp8CcBAXbgrXt8gP9CFytJyJByWptFqBEEoSy5TBciqFsOPNnLf1sxFC+w
	 t8GJiFxC92FLvg/aqCGfSk2I7gOMUITleV0hoFaYrwryig8X/DnB94YkNUfS2ltZx7
	 eXuqX4lxtJ/y45BFWwVKC/SO+1xzdfGKa+LuaCaSKodiFgl8zJJUZs8MRYpQDJaq0O
	 1Bc/OOWa6kGwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Remove vmbus_irq_initialized
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-rt-devel@lists.linux.dev
In-Reply-To: <20260721153216.382536-3-bigeasy@linutronix.de>
References: <20260721153216.382536-1-bigeasy@linutronix.de>
 <20260721153216.382536-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 21 Jul 2026 15:49:43 +0000
Message-Id: <20260721154943.A09BD1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Removal of vmbus_irq_initialized flag introduces a NULL pointer de=
reference in smpboot_unregister_percpu_thread().

Pre-existing issues:
- [High] Unconditional cleanup in vmbus_exit() leads to multiple NULL point=
er dereferences if module initialization was bypassed.
--

--- Patch [2]: [PATCH v2 2/2] Drivers: hv: vmbus: Remove vmbus_irq_initiali=
zed ---
commit 5d2e18e4c080ed3a0d4cb94c834ff4580a336e21
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Drivers: hv: vmbus: Remove vmbus_irq_initialized

This commit removes the vmbus_irq_initialized flag, relying on the
assumption that if per-CPU thread registration fails, the whole
registration aborts and vmbus_exit() is never called.

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index 44877664d9d08..95a2c6049854d 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c

[ ... ]

> @@ -3045,10 +3040,9 @@ static void __exit vmbus_exit(void)
>  		hv_remove_vmbus_handler();
>  	else
>  		free_percpu_irq(vmbus_irq, &vmbus_evt);
> -	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
> +	if (IS_ENABLED(CONFIG_PREEMPT_RT))
>  		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
> -		vmbus_irq_initialized =3D false;
> -	}

[Severity: High]
Will this unconditionally unregister uninitialized threads if the module is
loaded and unloaded without executing vmbus_bus_init()?

The commit message states that vmbus_exit() is never called if registration
fails. However, hv_acpi_init() can return early and bypass vmbus_bus_init()
completely:

hv_acpi_init() {
    ...
    if (hv_root_partition() && !hv_nested)
        return 0;
    ...
}

If the module loads via this early return path and is later unloaded,
vmbus_exit() will execute. Calling smpboot_unregister_percpu_thread() on
the zero-initialized vmbus_irq_threads.list will trigger a NULL pointer
dereference in list_del().

> =20
>  	for_each_online_cpu(cpu) {
>  		struct hv_per_cpu_context *hv_cpu
>  			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
> =20
>  		tasklet_kill(&hv_cpu->msg_dpc);

[Severity: High]
This is a pre-existing issue, but won't the same early return in
hv_acpi_init() cause multiple crashes during teardown as well?

If vmbus_bus_init() is completely bypassed and the module is subsequently
unloaded, vmbus_exit() performs unconditional cleanup on uninitialized
resources.=20

For example, tasklet_kill() will attempt to access hv_cpu derived from an
unallocated hv_context.cpu_context. Similarly, unregister_syscore() called
at the start of vmbus_exit() will also dereference a NULL pointer since it
was never registered.

>  	}
>  	hv_debug_rm_all_dir();

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260721153216.3825=
36-1-bigeasy@linutronix.de?part=3D2
