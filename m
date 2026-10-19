Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CD9503901;
	Mon, 19 Oct 2026 13:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792415456; cv=none; b=muOHP8hoDny6jX9p3n84am83MAWaR/zx6nntDwHeom9gtpIWNOeNs/VtvicutyeBSAMuKqCxJyan8NUmggDkI9muahzD7SW2t/gB2JtbZNntttB7SaBgTJPSPMKHAQD8vIQEDEAV29heyvarmwZ5c3TE8A7tTH+arGWUEnFAA6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792415456; c=relaxed/simple;
	bh=lUZ+7o4IvIylvesoUyVJ/wi61PbGA9hsUNj4GeSiLIQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GgT7xfzf5R9c+qU74SMZpDPLpHeZN8eWVkdNs2k7j8ICWUXpQaKsy4D4PESIw57Q1/CpwoWngyYYg1J9y9od9htt2g6wBHQFA7NyFq8QpuUX7M6/Oa4Hb+5R4AqZGJOJPyuXjbyoVBKGtaKKueaQRM1ImiWtCx4e2oEi5DiOmkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1eIbydz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1eIbydz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F10A1F000C5;
	Mon, 19 Oct 2026 13:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792415454;
	bh=iSjc97XJqMkqUxUMHAerf2M/VZgcfuK41nnK8KYqs2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n1eIbydzTKmb/UU6BWdkbLVP2xuF47+8Ac5br6WjGWTQa6TF+0Mh97g+mCx4lv0Fd
	 rI5uC9hHWXiARpigep3bTcMsUK8feaXrnn0FyAi31IDVUvQ2q6S6us6HUo/xr+vN01
	 qhSg42HjcznzefxXLnzGwSL+fMUrXhsUgL+0W3yIRSJU/kH8lyqSUcJSZg8LjmPb89
	 WZl1dbbNAIjlxaoL6n/1PcA1tVrHKI1afGClka6McPOO7huDSHwrQ1FGXmX0iaZRcj
	 UD9dIZ7WUQNVgiom/ibOSnZxxVQtxCHhlwRbJaXoO4frJwdTQiffvSu6H+RdhxYZJZ
	 LHr7GzHXwpk9w==
From: Frederic Weisbecker <frederic@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
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
	linux-hyperv@vger.kernel.org
Subject: [RFC PATCH 39/49] clocksource: hyper-v: Move CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Date: Mon, 19 Oct 2026 15:08:46 +0200
Message-ID: <20261019130856.49711-40-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019130856.49711-1-frederic@kernel.org>
References: <20261019130856.49711-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Between CPUHP_TEARDOWN_CPU and CPUHP_AP_OFFLINE, stop_machine executes
all the teardown callbacks while stopping all CPUs in the system. This
doesn't mix-up well with running RT or isolated tasks.

In order to transition smoothly from global stop_machine to finer
grained synchronization between teardown callbacks and the other CPUs,
a new stop machine post function has been introduced to be executed
after the main one with IRQs still disabled while other CPUs can exit
stop_machine().

The teardown callback here simply performs timer and IRQ disablement,
both of which can run concurrently with other CPUs.

Move it to post stop_machine() accordingly.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
---
 kernel/cpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index c2356a36d345..c37fe84baaa8 100644
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
2.53.0

