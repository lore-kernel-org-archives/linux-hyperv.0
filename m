Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532A146AA6E;
	Tue, 21 Jul 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647943; cv=none; b=TVczALp4FcUsxXEYYsHK2f2dAw6/KqRxA/mLk/uxEMAV7edEIDmtY3oyKCEuqLiX53nc7COC8/RikZ5rsQL6BHQTfdpiwGyb7Cr/rvWmG54XKyaZhH/RVZNNMCk2AJiVY8rd4d1DoM5QEuUOn2TvLcG3yRRnGpp7bBw4DBard2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647943; c=relaxed/simple;
	bh=hAjqELKOTrMsgdp5VtMULrtJjWyKbupOgFbdGkxVAUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QiNNEr4cLvu195nGUV5ru0N6y6Bf0r4tCZfEOhB6F9u7Q9VaaysmTKGLF7YmR0j9yn8AJ1XEzTG31oDAv29w8HHqm5XzghjmQY/uJ3/3aFZ02ZZdMierAB4zK6a82fIkItGaaA8jlSYWK9Da7UtLnoCBjcbfFNQRrq1+cmlRhqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H3PS2QJz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E5GreTxE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H3PS2QJz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E5GreTxE"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784647940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ+kOeaOdGhatTWm/92wEG6NTZjICMJi0VidcGsbqRg=;
	b=H3PS2QJzesd+mDhRXz19l9J2OauP8DxVgj1uo5Acdehj/fkR8uToYbUcF7vXOIla4gggj3
	m3EknXlkTjvhF//ZAyy+LQPkvanknEbNAUS+O/AIH6NT+1uPhbm9uU8hL6qDJZ1vN7+97W
	5gdCRzYNlRZfBFi9qam9T7v0rR3gbVwaLpr63gNI82jDNGG4A/0a8o2VzHq9uDYpIsbaeR
	Lufa9pJvazj9omgTPE3x3rpLg4x/2xYT/54qIs08QxbM2GWO+56PVVkH+nRN8ZYfTPDZAL
	C0KjN6cBWzx2vLqetQpV1qh8dCUhPj5qs5M31Dih06VZO46pFJsn51vPeCi0Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784647940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gZ+kOeaOdGhatTWm/92wEG6NTZjICMJi0VidcGsbqRg=;
	b=E5GreTxEurj1vHcu/txFN+8zg4yyvZiQs8wJIDco9MktVxkIXX/2ttV0RZR4L+BbZGfPaD
	pL6dkSYabKSFajBQ==
To: linux-hyperv@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 2/2] Drivers: hv: vmbus: Remove vmbus_irq_initialized
Date: Tue, 21 Jul 2026 17:32:16 +0200
Message-ID: <20260721153216.382536-3-bigeasy@linutronix.de>
In-Reply-To: <20260721153216.382536-1-bigeasy@linutronix.de>
References: <20260721153216.382536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

vmbus_irq_initialized is only true if the registration of the per-CPU
threads succeeded. If it failed, the whole registration aborts and the
vmbus_exit() path is never called.

Remove vmbus_irq_initialized.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hv/vmbus_drv.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 44877664d9d08..95a2c6049854d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1369,8 +1369,6 @@ static void run_vmbus_irqd(unsigned int cpu)
 	__vmbus_isr();
 }
=20
-static bool vmbus_irq_initialized;
-
 static struct smp_hotplug_thread vmbus_irq_threads =3D {
 	.store                  =3D &vmbus_irqd,
 	.setup			=3D vmbus_irqd_setup,
@@ -1497,11 +1495,10 @@ static int vmbus_bus_init(void)
 	 * the VMbus interrupt handler.
 	 */
=20
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && !vmbus_irq_initialized) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		ret =3D smpboot_register_percpu_thread(&vmbus_irq_threads);
 		if (ret)
 			goto err_kthread;
-		vmbus_irq_initialized =3D true;
 	}
=20
 	if (vmbus_irq =3D=3D -1) {
@@ -1545,10 +1542,8 @@ static int vmbus_bus_init(void)
 	else
 		free_percpu_irq(vmbus_irq, &vmbus_evt);
 err_setup:
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
-		vmbus_irq_initialized =3D false;
-	}
 err_kthread:
 	bus_unregister(&hv_bus);
 	return ret;
@@ -3045,10 +3040,9 @@ static void __exit vmbus_exit(void)
 		hv_remove_vmbus_handler();
 	else
 		free_percpu_irq(vmbus_irq, &vmbus_evt);
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && vmbus_irq_initialized) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT))
 		smpboot_unregister_percpu_thread(&vmbus_irq_threads);
-		vmbus_irq_initialized =3D false;
-	}
+
 	for_each_online_cpu(cpu) {
 		struct hv_per_cpu_context *hv_cpu
 			=3D per_cpu_ptr(hv_context.cpu_context, cpu);
--=20
2.53.0

