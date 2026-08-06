Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5E74AA121
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059434; cv=none; b=UMNTis40ruGjZF2OrQWiSn/T0Waq2eEqffQpZXrMNdaHGQJDtPLKvAcfBPX0qzfB7WWkXtp+1sIVkQqxqX0wyKbKcGJ2TXJfLvsuHgQvjoDj1rb+UkBT8k5TP8kKeQzmcRJE7or32HG1E6lq0Nt/CVydW+HZQfyjvbGow4ZTgkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059434; c=relaxed/simple;
	bh=O74eXjp88Xj4Hu2r50cQeq7DVhhqDrykpjbML2eTnkU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ezMczOUzRbBSP2PmPISRmbMOVbcMpxT8KFcNuDI4u3Tf0vvvtqDRMs/5/S1X8o6b2ra0B90dyXAJw/zvfJxuMYEouHW/aPMJeRIACDpcPfC5x11/9TXe2lV3B8W7bH7WICYs3xL0lPBAMvo2XOKZOfxmdPW+amw6Wxibe3i3bPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OarClglh; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OarClglh"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38dbf293831so5541651a91.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059432; x=1786664232; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4ag8yTwNbmjHFkBZxZL+JA4uvidx3vZA6IwgDKjMnAQ=;
        b=OarClglhwEA+owVh6lYxMrGoxZbJyBAayAPTYL+ax6G1o4reSTroxlLPegxNHx4de4
         SPHmZRiKLOlgZ9nclXsyWfiWUN7+e8VgVhxE6Y7cB0pVZZKumEhKk1TVwN8005/2xLdl
         OjPRCw/WYM7rOyrG1lSoYyKhult+/oROt1Pzk6FnpUjaaI39yWKrXtCOOSuXz0eXOhGc
         p3ga7WIRDS6r4H+1cyGGwG0aNNHYLm4IrmmLbdM4rpIiG8a7jP/3ZGUqJjLiDZN/B/LQ
         FVFWUXgNny84qvqB5q++z3jbTS+jRS5CFe2tpQA24s2/Ko6AxZwZx8Lzc1jCPwudF0Ef
         bpiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059432; x=1786664232;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4ag8yTwNbmjHFkBZxZL+JA4uvidx3vZA6IwgDKjMnAQ=;
        b=npdOrFL8WLw/QxgtJ/YKj9i6MCPAX1R2eit6T+qorSRpedZMTNPXwuMulsSC2X7f3r
         H/Q3EzLbvOg6pA7DJ7rNw04zGbZ2E5jfc2sWTBL75+4dBjrM1RYfxJsNMgEb4nY/HrEY
         1ZG5n1fFawGDB0H3/+3pZ14djb/CHgjR2DtekFoUb+T12888bOcboW6rQbF09BJz5kht
         GOo3yiuL7l6SLBv8nAA1yTDjs74hCTHm/60BnFq7dL4qLUM3usThvT9Fo3l0ub7CwdUl
         ca2+uuCwFpoT+RVQSq4USnGzlRZyJqSfIQPcNfSyGd8H30ceTL5imhdoqHpxlyZrvC9X
         4EwQ==
X-Forwarded-Encrypted: i=1; AHgh+RoqmUBbO11wgW9oSE4kXQEL4sX728RDaRsvq0y3YFYmC7IvSv30LXm0LreuyoaPO3stMWPgpwGC0+6wp0w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzExoGlFTYtYTOBZjZZUw3xQ+QC6QGD5KHVY4cqSKsTDijk8Mgp
	x4cviAzqhRw87IVXCdrx4ss0ZT/Vf6MAPtQmSMkw3LZTCiD1wOtH/qwreg6uiSb1t7F+DgOZPc4
	PzHLQ0w==
X-Received: from pjbqb12.prod.google.com ([2002:a17:90b:280c:b0:38f:2874:84ed])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:c88e:b0:38e:488f:7068
 with SMTP id 98e67ed59e1d1-3903c5373b4mr20565740a91.2.1786059431685; Thu, 06
 Aug 2026 16:37:11 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:55 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-39-seanjc@google.com>
Subject: [PATCH v6 38/51] x86/xen/time: Mark xen_setup_vsyscall_time_info() as __init
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

Annotate xen_setup_vsyscall_time_info() as being used only during kernel
initialization; it's called only by xen_time_init(), which is already
tagged __init.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/xen/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 8cd8bfaf1320..bc26f00fc53e 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -443,7 +443,7 @@ void xen_restore_time_memory_area(void)
 	xen_sched_clock_offset = xen_clocksource_read() - xen_clock_value_saved;
 }
 
-static void xen_setup_vsyscall_time_info(void)
+static void __init xen_setup_vsyscall_time_info(void)
 {
 	struct vcpu_register_time_memory_area t;
 	struct pvclock_vsyscall_time_info *ti;
-- 
2.55.0.679.g6767b8d81c-goog

