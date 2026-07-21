Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B946AA86;
	Tue, 21 Jul 2026 15:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647943; cv=none; b=ZZl/GqecjZnYsS3Krt/ePc0ZR2K6M6rbGUMk0fJOP5IcTYzuSqxYe2fCQqcb3i/hx2rQPrYd09kBsd2e/uO3jTCDj2Sujys/aRoRNBR3ywlJdrM1HK3wM5SL2RfBc92J0LxSL1UNBhG8Ll4/s3WdPLqu8FnJdu8yFPV/H4K9eLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647943; c=relaxed/simple;
	bh=0GVOyns5oaICjgiV6G+ts/SHimZQZxnRCFcaMBc0rUo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHECEz9Tdw8+FpLauFVP9CtXpg1xf4csRZAof5mNZtxQ85j2jmimUS/GYViZNpEVMX+smd0Kmy/1jAT2X85GXWf3PbOFAwBeaxbmckL6VAuTpapYI7Mjkaa7I8IPMTcKDnluLNfzIRCIKFAYCsSz2+UOKrEirmuMYTeqRUDmC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UGUqpxP9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rkr+0qNA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UGUqpxP9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rkr+0qNA"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784647940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGSN7WTVBJCzseHjn7LpvqEGg3MJG/jXG6JvPbUb44Q=;
	b=UGUqpxP9Cboh0AC3bF96qnukNi54KsbxPWgIyF8VZv3y4vTUahGXwKayS7jkmWKbJuPDHk
	a4Q2hS/J3BvCmOPWucAW4UHcUoF8Q4abN5tYB//nJ2ytF6hQnjCRfWiT/CYELhGtLv9DD6
	zsDGPqA0+I/G+Yix3Xa1Y9AkoXT6DHsRzShWe7fAV9zpyLkypWzmsarssiuhlHW7kiOMFh
	7dmCT276MSqMLOY3jOxgLYLncyWOidr3yOs7tv/SbSdIP7hOVfVQBHeIURKLnEUZiEOmLf
	Ih9CQGBb3F75plG454RDTGzffHeTpz2ofn4S2U/Y4c5N7X7ogoLNFPJ5r8gR0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784647940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGSN7WTVBJCzseHjn7LpvqEGg3MJG/jXG6JvPbUb44Q=;
	b=rkr+0qNA+eLq2u+FqwN6/a9YqmooDv9cPjbcvjW8vyR5+0Q2CjTmlsW8LoVNtL8vqVy64w
	EQltPvzCaZPVAHBg==
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
Subject: [PATCH v2 1/2] Drivers: hv: vmbus: Replace lockdep_hardirq_threaded() with lockdep annotation
Date: Tue, 21 Jul 2026 17:32:15 +0200
Message-ID: <20260721153216.382536-2-bigeasy@linutronix.de>
In-Reply-To: <20260721153216.382536-1-bigeasy@linutronix.de>
References: <20260721153216.382536-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

lockdep_hardirq_threaded() is supposed to be used within IRQ core code
and not within drivers. It is not obvious from within the driver, that
this is the only interrupt service routing and that it is not shared
handler.

Replace lockdep_hardirq_threaded() with a lockdep annotation limiting
threaded context on PREEMPT_RT to __vmbus_isr().

Fixes: f8e6343b7a89c ("Drivers: hv: vmbus: Use kthread for vmbus interrupts=
 on PREEMPT_RT")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/hv/vmbus_drv.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 23206640c6139..44877664d9d08 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1384,8 +1384,19 @@ void vmbus_isr(void)
 	if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
 		vmbus_irqd_wake();
 	} else {
-		lockdep_hardirq_threaded();
+		static DEFINE_WAIT_OVERRIDE_MAP(vmbus_map, LD_WAIT_CONFIG);
+
+		/*
+		 * vmbus_isr is never force-threaded and always invoked at hard
+		 * IRQ level. __vmbus_isr() below can acquire a spinlock_t
+		 * which becomes a sleeping lock and must not be acquired in
+		 * this context. Therefore on PREEMPT_RT this will be threaded
+		 * via vmbus_irqd_wake(). On non-PREEMPT the annotation lets
+		 * lockdep know that acquiring a spinlock_t is not an issue.
+		 */
+		lock_map_acquire_try(&vmbus_map);
 		__vmbus_isr();
+		lock_map_release(&vmbus_map);
 	}
 }
 EXPORT_SYMBOL_FOR_MODULES(vmbus_isr, "mshv_vtl");
--=20
2.53.0

