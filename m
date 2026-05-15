Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882463E0241
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872847; cv=none; b=ZWwtgDJ1nB28hxYLwAYRZ6oMYGJzTTJWfkhQVomiQ7u/Jvi1M1iApE4zjP3Jt45cyhmjY0MrguXznApHwT4B1w3i+qAtmg3r7pUzICxH64y5/eisIrlkl2zd+Ur5bX2UXzwO4AvOYY7Dym4erWwpU/MW4lNlJ3A5pWi7M7CRscU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872847; c=relaxed/simple;
	bh=lEMsR3dKvKq215PZd6emceDFTwLDtk70c4kzuFxS2LU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qcSfiBsUwnXHJelDJfev09okPCbwBDBQoZUMesz/CF1yJ0GTvznxCFHalM6IlVccfaa48kRtcu1OAADsbxwAe+tYBruvd3pAvf46AAYOLXxZxCWAh/wesGiZjX2P6cbcdrG1NIGSlYLyIkk0967/VTDqJE27VpYqIn1VvILRI68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DBczljoL; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DBczljoL"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so1056983b3a.1
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872845; x=1779477645; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=/y8QjMIN78jXY0C38vMz/eIP3YtBj5/Xygk6fhPK+NQ=;
        b=DBczljoLqDv0LbZhlQBZdzdEFQwDvDuQ81LuTIL7GVKIYx1FAk//ngUGWCmJM0c876
         L3+Mdt2glacWhIDY3ZaGnnX7uwGh6TsSV1IEUVTeprruG2bAZSQwX3Mo4/C8B31pJ0b/
         1QgWCMfzwGmN5+R0XU9PPqvjfXmxusKUb0c4EdhQO6FbS6d2ALr2diOs1Cj0gNG8fKgN
         OK2KvlqHH7HkQv/5N5wjp2U97e8Ophz5AF9BjHsKHZ2MSlkd/WXw3/QFiv1WX23Ew75F
         iEOAWfDV3nQ7uD6WS2AxuXCYkbptM/BHDDiw9B/90QeVyFnDQHheF3lQJCzcUKnJwB3X
         xnFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872845; x=1779477645;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/y8QjMIN78jXY0C38vMz/eIP3YtBj5/Xygk6fhPK+NQ=;
        b=gZYk7O9+yWBc0zA49oFhQQgINxwtl88KD23trrZIDEhmz3dQxordwcj2M2X8mUDBYs
         oEa63K+bLAbLP6vS+y1GREdFd5PPe2oXaBQe2ImQF1k1KkTffMwkW4IlSzeR5B4qH6JY
         BId8wz4bWhuX75u1CixKvENZt/cZdUP/1ZK6Myr0LtHref8HaHqkwstQAd4EQ9t6l3Uf
         skc3DJb3LLtQK+0aWfN2L3npRilL1LqW+oQull4S2J5FA3Ubo+OXwDH0XD55Verb4JFa
         qYeyDLvrV9nNruH3WpQPf188EBP5Igsr0q9Z2ebgiijct0n2T7M+q3F29RZoiA0H6P4O
         OWHQ==
X-Forwarded-Encrypted: i=1; AFNElJ/V6abj8PEFxjZYG6AsBzokozJvjeQNgufIILUurG80N/8wNIT3gjv6fnPUlFk7pY561ic45k1BP+yaqmg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaXOnRivXZOfXfzhJgIjMq+qZE6/nqj+KLmgG7zDYMSINEupJh
	rnmmQM8SVsweOwoACwbV7P+EAGHWZKI2OFrvoCcwP8CxlYSlbew7+PW0pbd7vY/Eq6JaQFZXI+p
	6KnS6iQ==
X-Received: from pgbda3.prod.google.com ([2002:a05:6a02:2383:b0:c73:bc95:cca8])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:4328:b0:3a2:cf6d:aa04
 with SMTP id adf61e73a8af0-3b0bdd00bfbmr9342014637.8.1778872844563; Fri, 15
 May 2026 12:20:44 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:14 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-14-seanjc@google.com>
Subject: [PATCH v3 13/41] x86/paravirt: Move handling of unstable PV clocks
 into paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Rick Edgecombe <rick.p.edgecombe@intel.com>, Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, x86@kernel.org, 
	linux-coco@lists.linux.dev, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	Thomas Gleixner <tglx@linutronix.de>, David Woodhouse <dwmw@amazon.co.uk>
Content-Type: text/plain; charset="UTF-8"

Move the handling of unstable PV clocks, of which kvmclock is the only
example, into paravirt_set_sched_clock().  This will allow modifying
paravirt_set_sched_clock() to keep using the TSC for sched_clock in
certain scenarios without unintentionally marking the TSC-based clock as
unstable.

No functional change intended.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 7 ++++++-
 arch/x86/kernel/kvmclock.c   | 5 +----
 arch/x86/kernel/tsc.c        | 5 ++++-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index c71b466d6ace..fe41d40a9ae6 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -14,7 +14,12 @@ extern int no_timer_check;
 extern bool using_native_sched_clock(void);
 
 #ifdef CONFIG_PARAVIRT
-void paravirt_set_sched_clock(u64 (*func)(void));
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable);
+
+static inline void paravirt_set_sched_clock(u64 (*func)(void))
+{
+	__paravirt_set_sched_clock(func, true);
+}
 #endif
 
 /*
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 006e3a13500b..1cbdb48e5503 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -12,7 +12,6 @@
 #include <linux/hardirq.h>
 #include <linux/cpuhotplug.h>
 #include <linux/sched.h>
-#include <linux/sched/clock.h>
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/set_memory.h>
@@ -94,10 +93,8 @@ static noinstr u64 kvm_sched_clock_read(void)
 
 static inline void kvm_sched_clock_init(bool stable)
 {
-	if (!stable)
-		clear_sched_clock_stable();
 	kvm_sched_clock_offset = kvm_clock_read();
-	paravirt_set_sched_clock(kvm_sched_clock_read);
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable);
 
 	pr_info("kvm-clock: using sched offset of %llu cycles",
 		kvm_sched_clock_offset);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 021612c22b84..567d30b30a5a 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -280,8 +280,11 @@ bool using_native_sched_clock(void)
 	return static_call_query(pv_sched_clock) == native_sched_clock;
 }
 
-void paravirt_set_sched_clock(u64 (*func)(void))
+void __paravirt_set_sched_clock(u64 (*func)(void), bool stable)
 {
+	if (!stable)
+		clear_sched_clock_stable();
+
 	static_call_update(pv_sched_clock, func);
 }
 #else
-- 
2.54.0.563.g4f69b47b94-goog

