Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795645502;
	b=gnGPf5QGDCFSMUCPpQ9GCrwIxZF5j6Od4J5/zS1NT9Rz56pE45KkThgg8MoPwDzeOLNE
	 hm+szA/1+hOd/lSUE5xcYa+wLW4fFJYx84gMTc6VGfP+WIhmR0Ou9GTspRgmY3jEos4tA
	 /SoUHBzXKjDABLbVKj/B3uvHn23nV7Ud1KwCle+88Mt8wxeObohZSgbQ3NMVbWIx2Mylx
	 V5CCOTx7by4/mf71nAg1J7eYyoinyLT6Bvh89o05f7rxTOhx9zidASfmnTd/LQpfHUWPH
	 Y7sGFYNvqZlTjzwXg9br/GExEtIvUPhVxrmXlAOhpjcRNcesPHpHreSkIJToF6kFLbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795645502;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=uV62PU8V8xb/3jZr6V+Zcdh0Dt9oHzWUSjJLwKfoSF0=;
	b=kW2N86TgHxoXnL1Afwg0O3er9URXvv8TYWQumOZRquj1XJDEpKLwDdcvkbE+ThgucxxN
	 jF4Y2aG3S8at8ge7cdtNNzZ84toJX5+iSEV3P3w+ipxqdaLuCgPtS8iAhrpLL7KQsgsUW
	 OLG7YtL7maVRwVlGegC1AdV+fX7KjBle9fUR9G2CJ1JbTflbBMi7ipKfnrE7snN2VsKlB
	 EUKrYwrqVWCgKSEEqgeEgXjuo6RwtFXbGiQFLQ0nVfgwV/0PIf7Nv/3GmRDH/iFa3UL+N
	 rv9FhJjRP6Ka8pxSY8d7vA8b3qw2tuIWc9QtsVGAR+CfNZ8ArFs75r19Ahw7SvQqwzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ88EkqV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8127606A330;
	Wed, 25 Nov 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ88EkqV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E221F008B2;
	Wed, 25 Nov 2026 22:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795645502;
	bh=uV62PU8V8xb/3jZr6V+Zcdh0Dt9oHzWUSjJLwKfoSF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PJ88EkqV20AWU6rw8IroHBrz+eKQhItIMXmOChHj9CytheUbgOwe27w7HMX54U7zc
	 7EmxrOXtvNdK8Xqx+MJhQlCOm0Yay6OTQraOn7cBe/88J4Ci7aZG5MbYvyKsA0MmVH
	 MhxOZAHU9fHZV/JhjLW9J1Os8/6tt+WV9kgXb475JnvmnD6dQ7Koa+G86wvN0182xf
	 oDotVOiKvZcb6FbW1PXVNSHZDUqeeuhrs93C9lwKb7awcaMIgszQROswndbB+BYLmX
	 mR0dB5g7IZtKx8w6NVNZLTKozueIzQ+0wqbRBQYk5cW277RHwqKFDjVWjEkt3+feXZ
	 uPIgdwiVF0VbA==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Marco Crivellari <marco.crivellari@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Phil Auld <pauld@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Wei Liu <wei.liu@kernel.org>,
	linux-hyperv@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH 39/47] clocksource: hyper-v: Move CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Date: Wed, 25 Nov 2026 23:22:22 +0100
Message-ID: <20261125222230.22508-40-frederic@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261125222230.22508-1-frederic@kernel.org>
References: <20261125222230.22508-1-frederic@kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
all the teardown callbacks while temporarily stopping/pausing all CPUs
in the system. This doesn't mix well with running RT or isolated tasks.

In order to transition smoothly from global stop_machine to finer
grained synchronization between teardown callbacks and the other CPUs,
a new stop machine post function has been introduced to be executed
after the main one with IRQs still disabled while other CPUs can exit
stop_machine().

The teardown callback here simply performs timer and IRQ disablement,
both of which can run concurrently with other CPUs.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 93b8498e26c4..b49b67ef5ecb 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1275,7 +1275,7 @@ void clear_tasks_mm_cpumask(int cpu)
 static int take_cpu_down(void *_param)
 {
 	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
-	enum cpuhp_state target = max((int)st->target, CPUHP_AP_TI_GP_TIMER_STARTING);
+	enum cpuhp_state target = max((int)st->target, CPUHP_AP_HYPERV_TIMER_STARTING);
 	int err, cpu = smp_processor_id();
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
@@ -1303,7 +1303,7 @@ static int take_cpu_down_post(void *_param)
 	enum cpuhp_state target = max((int)st->target, CPUHP_AP_OFFLINE);
 	int cpu = smp_processor_id();
 
-	WARN_ON(st->state != CPUHP_AP_TI_GP_TIMER_STARTING);
+	WARN_ON(st->state != CPUHP_AP_HYPERV_TIMER_STARTING);
 	/*
 	 * Invoke the former CPU_DYING callbacks. DYING must not fail!
 	 */
-- 
2.56.1

