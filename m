Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F804AB834
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059439; cv=none; b=PtilpI0s2M3tEcsmC9wuKxS9y87F2jaBK0qFjqjB1hwLJr5//2g+vi/9STgnzPKoXAHNbgN/EWIyhazfrgLx1jADJu0sV72q7k/JuzYXvs9EfuudjqnOROBKVqJxeEtDZdEvxUrNENxE17q3tG7aVezyM3OF5HXYmU1UcpHmeU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059439; c=relaxed/simple;
	bh=CMNPpn663VblKppKKu5nFjYj1HkUy1nnfJebT2ynUYY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=MaHF2la1xVdeYyB+q0TBvYojVWEUvh7VpGiy+9EomaVKCUEh3j1Ga8CHgOoIB8paYKSxjNUsSERWJR2oSuxtqRyh4wjTf7s9riNq8uT7Z1vRMsb9b+UxXG/xBZnk+g8Rm9SETFHdEht6RRyIFH1Q03clAofbMdFIAMDXTwvpm0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AW4CMHyS; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AW4CMHyS"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbe62e01567so2346090a12.2
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059437; x=1786664237; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=qISz6FBmFt+Rjc4N/P+Kp805/IDsq2ZStMxtEE1uDRQ=;
        b=AW4CMHySlmhYrT72DTxH1CFaADGEcb+OsB0Lv2jWisdK+ZVBA4B3YpJmonI8tQ6U8p
         hTjQFu2SPZNNKmGS4geXikr94xBv5k6rs3HIy7U5EYhAripWLlB6VUnNJQtVTYlfj9s6
         cBn/XWXt5CgApEOr7lklGVdX/+OIefFTn0MbkSmCyCEDYkIUJyjO3EnMe7I7k7+9qO8g
         O8TVRLSK5NN5mVqeSmmhs3F/XAgk0bQWX6Y/amidPpMrWq/yu8GNmVYVcP+uoTCR6UMD
         kDdaNifv9iQ4C1oFhRSzMKmLNtIRbkl7Q6EFW73m/uR62MYvYwHwox43zievt5H7LRbw
         N1EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059437; x=1786664237;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qISz6FBmFt+Rjc4N/P+Kp805/IDsq2ZStMxtEE1uDRQ=;
        b=QQyE+iBiwTSjKfntFgRHm0rkeGSIGgn1UVLyA2veBXgl7MYP/n9Qij/jWsemtGQFBN
         qVhmc3wy+1bipibHlXLruVZrW7cUu8ifTQ9olAmvpjoeykdh0YLQmgn1QxaXUYHcUW7P
         GU9n15llA2APlDB7Gq2DbDNl59R2i9pt4kM33Y96F/npgsAiCv/5GaUFzCykwZILidvb
         zfi+cv/lGEWTp5/Yu4Da/zuFZfQnu8MM0k9a6wEeTHZ7mDULEwI1JwoUXNixRm6tNhJB
         IRNr0MXUbiXXSCGQ2+eHMmsO2TGe+hWRuN2YuK7GuClgJnZsKX1TehVvhof71fMN8cii
         P0kw==
X-Forwarded-Encrypted: i=1; AHgh+Ro6kpBdu6M25o+vbEQYMI65z1K6sgD7VkJ0KMNt9hoBE2TTbJdw5PWUcOuhEnUBvLoBOp9NJfLUMNzojkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVvAupU/dDsvkDaxX98spy4Y10rn36RKkYlDbgw1KgUwgls6JZ
	CPHz5Asi17/99FDWhMMtkxO8r6ZiGTZMPOorp5MPj57/UyQOOEuFSYnOJtAvQlP162jYqNomzNS
	JsIuSBw==
X-Received: from pgbep6.prod.google.com ([2002:a05:6a02:2646:b0:c99:90dc:7b3f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:6112:b0:3b4:e4f6:4f15
 with SMTP id adf61e73a8af0-3cb85e9922cmr22668021637.5.1786059436589; Thu, 06
 Aug 2026 16:37:16 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:59 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-43-seanjc@google.com>
Subject: [PATCH v6 42/51] timekeeping: Resume clocksources before reading
 persistent clock
From: Sean Christopherson <seanjc@google.com>
To: Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Dave Hansen <dave.hansen@linux.intel.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	John Stultz <jstultz@google.com>
Cc: Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, 
	Miroslav Lichvar <mlichvar@redhat.com>, x86@kernel.org, linux-coco@lists.linux.dev, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org, 
	xen-devel@lists.xenproject.org, Michael Kelley <mhklinux@outlook.com>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw@amazon.co.uk>, David Woodhouse <dwmw2@infradead.org>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

When resuming timekeeping after suspend, restore clocksources prior to
reading the persistent clock.  Paravirt clocks, e.g. kvmclock, tie the
validity of a PV persistent clock to a clocksource, i.e. reading the PV
persistent clock will return garbage if the underlying PV clocksource
hasn't been enabled.  The flaw has gone unnoticed because kvmclock is a
mess and uses its own suspend/resume hooks instead of the clocksource
suspend/resume hooks, which happens to work by sheer dumb luck (the
kvmclock resume hook runs before timekeeping_resume()).

Note, there is no evidence that any clocksource supported by the kernel
depends on a persistent clock.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 kernel/time/timekeeping.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 97db2e9393f9..585525f5c1f6 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2226,11 +2226,16 @@ void timekeeping_resume(void)
 	u64 cycle_now, nsec;
 	unsigned long flags;
 
-	read_persistent_clock64(&ts_new);
-
 	clockevents_resume();
 	clocksource_resume();
 
+	/*
+	 * Read persistent time after clocksources have been resumed.  Paravirt
+	 * clocks have a nasty habit of piggybacking a persistent clock on a
+	 * system clock, and may return garbage if the system clock is suspended.
+	 */
+	read_persistent_clock64(&ts_new);
+
 	raw_spin_lock_irqsave(&tk_core.lock, flags);
 
 	/*
-- 
2.55.0.679.g6767b8d81c-goog

