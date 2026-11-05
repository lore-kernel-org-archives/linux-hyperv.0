Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896375;
	b=VUebB5CwybO8ULf8jYNv3Vnf4cnG1Il+2wKITooDlrFVPLm8piuHcGgd6p1V+O0VuQky
	 sQWt2wB3BMEh3d+nj2gnPNDgWjax5BjSExvCd4nNicqVFZLdXljT9xvck0IZ4ylwfsSPQ
	 5vTa2gJzkHrVdgbhIOcrPCJ0mlcPgKP/L1YpXC07sUn8rhQNK+LR2ehGM70HahlfzESp9
	 tDRfsawzV180yA0OPy5StcpDu4docCVLQpjeg5L8ytlV1X5V2Ubr9GrS0zfD0U63R2iZ4
	 PpNeIztdLv4PANCK8CZ0t5zKoiwjnQQv0TgvgJn4deuifwiHaGegF/Ua5ABnXXug5tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896375;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kg5bErG9AdTDiRitVVVlJkekm9pYQshPoKcKiS8xeto=;
	b=zpTnt6hxcF81V1WUNyt+FTRNuG4W6dP1oGZfPy+2dg0C68NC5kg2/1WzKkogcrmG0ssS
	 9R/Wx1RHFRnS01y9wb0G68r8YlkYw6WyOA7LCZvnGqYW0Z7/FMe3MlD/PSnDH7aCVNkc8
	 MObD+RDlQb5LBzfjcrF6+NBg2gD26f2bWbIs1Ivc6z2/Kn7JyP6BVovbLbh66ejsysp13
	 HP0dBjbO8b389mO1tuhFte44+lch+CrQsGeR0JlfIEndaK9FLwYlQNUOmjDeaFublWprP
	 zBs4lNQ76pwIh7s+QvJn3gItep/DSB0K7RSjwLPBRYvf1MO2z4oSZPiwD9exod9jtcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1rSf1o7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2777F606D735;
	Thu,  5 Nov 2026 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R1rSf1o7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CD21F0093A;
	Thu,  5 Nov 2026 16:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896374;
	bh=kg5bErG9AdTDiRitVVVlJkekm9pYQshPoKcKiS8xeto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R1rSf1o7yeWlzS7LhIqvjlNIs4Rf6OhQO6DI8S0nmWJ7whO3aE1NptEDEgSV9C92V
	 I9ZAF0EjAIhUhLqiygNPwIZEzGDRa8+/IHevpDgNQI0LoKdEIdPd+sDmM5HOFcRJGo
	 JaPkRvCaLdq918Q9xHuWEVFC11mdis1HrX0dFJvLxPOMsWBnVIhyTCMxbgHRbPRCNa
	 1Rw4G+6+RIglH98Mw9WAUa2QIkEojlI1dlAlYJNAOkwUnhwfjXM6SShddDf2sOhWis
	 +wEKsa1vTQlc8FAQsWqkyiOijqCjBPcJYsrl8w88wU9VesHMkkeA/rSYNLlaClXs0p
	 TPfEaKTT02bqQ==
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
	linux-hyperv@vger.kernel.org,
	"Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH 39/47] clocksource: hyper-v: Move CPUHP_AP_HYPERV_TIMER_STARTING post stop_machine()
Date: Thu,  5 Nov 2026 17:30:37 +0100
Message-ID: <20261105163045.38862-40-frederic@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105163045.38862-1-frederic@kernel.org>
References: <20261105163045.38862-1-frederic@kernel.org>
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
2.53.0

