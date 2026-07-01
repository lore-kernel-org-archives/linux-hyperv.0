Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E59A420346
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934387; cv=none; b=eOYlR44cp7MzCFTXayXKLj6QgeZWtdzsNlWLkC2MK9tUi6VBrplMp95QtM9BeqroA7s+PiS8J9eqOQOsJc3oc1XnLeNESj8wDmakbfgSDyYdDt2lScITVZxOvoGdYdVo+9AJzK5fwDHRM9NjW/3EUGS9zpLa90kd2/WQPrSSxnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934387; c=relaxed/simple;
	bh=deYtEBfNYIRV0Cl+cVKPWPsT/vvrGngsxRRI6ukCYKE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=epx+o2UGIPMikkDw8UCMyVKTF6ij/5HY9E60AKVx6FMHGdrLcWnfVpc4HWU35cWuPgGR9UBbIPzyifN9uayAYc9HSaVAihrnkid2krRJD84l0fSa0Vz0oTF8TJKByF0QMniASWALf36tiVOi16Gft6fz7qM0YB2qxzhJ3OKTn0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YSQIK76t; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YSQIK76t"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2c9e9cb6a44so8480245ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934384; x=1783539184; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=FLdcwKjpeRYfRUJ5L0VC2fjzpWNaPddOoI275jwJM8U=;
        b=YSQIK76taM7bsiU5CoubMRO2+kU037Xms7JVVD/+dXgr4XsWGFyxhQt6ix15jcaB1a
         JtOle2XvWIFawfy36KYw/CuUay+/YqvBmQydWDUFUTa/0T15+3HI5AT33vHueiezaTV+
         ZE+LYiDcVz8Anl54leeg75s0FqWi7YhuKxTrfZ40XTElhbJvNCDGDz4IHgscxLnzHX/a
         iyr6ZJ/zwkaPbFjvdd8UuiFzI2y4dwQq3HJh696dSjsUi3AHz40xDxBPo1BA/0WoEI2V
         m+d5RAWzPX6WDd+VQAybOS2WVKsh9Fh6ljw1B9ca0hoHlIiyRcH22KjrmPQ0uvFe/5W8
         cKzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934384; x=1783539184;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLdcwKjpeRYfRUJ5L0VC2fjzpWNaPddOoI275jwJM8U=;
        b=OggF4OQFnmAdo2/dNTgidgdxrUS+Qn3f2BtaZTK6leglnLljT2XVDx7HCVrFPFk2/T
         yIK3W7yn+8smy3MB+3FsMx8b6VPrIRZCi8y1hkkfSbyScuMrTrOZI09uS9RzzcO4vlfb
         d2UOwhU3IFmrGbgo3hQQZqAAhAy+cJJoRSLIlYjXOpQLWW929zQq52FmqeqivgmAf0bW
         KtldOrQL7i1PCcX09P+WSBCye6HMdsPneLYcLiPGemNROO94KAIRcpjBRbC0z4/ECfLy
         ADDX3q2PDibj4qs/rwIuSpbE4iUDY1GXxnDkk7nfzLt2c81OfjoMP9S5yx7OwRG2oIA0
         F3Cw==
X-Forwarded-Encrypted: i=1; AHgh+RrV6kYsbB9kcz/yLgZeJ2G5ENqIM4eo89hXAp3RedgGLXz640gjRDU910UXAZTJua+FK9ge6ZldzijTFSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztV4S1i/WaYIwO7kZ6EddfsfSSbwWXW18NouHvMbOzLG6hHW+S
	w+/+NarvYrto6xI+HfLpNCWh5XnmxHdw5lMbgArwdkdxqWkp/nKXBVAyNejcOd74NoKVTXrJgd3
	9vlznYg==
X-Received: from plsq11.prod.google.com ([2002:a17:902:bd8b:b0:2c9:dc0d:6834])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:f551:b0:2bf:7b62:a038
 with SMTP id d9443c01a7336-2ca9112b126mr20357335ad.9.1782934384220; Wed, 01
 Jul 2026 12:33:04 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:31:51 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-31-seanjc@google.com>
Subject: [PATCH v5 30/51] x86/paravirt: Remove unnecessary PARAVIRT=n stub for paravirt_set_sched_clock()
From: Sean Christopherson <seanjc@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Sean Christopherson <seanjc@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: Shuah Khan <skhan@linuxfoundation.org>, "H. Peter Anvin" <hpa@zytor.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, linux-doc@vger.kernel.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, Tom Lendacky <thomas.lendacky@amd.com>, 
	Nikunj A Dadhania <nikunj@amd.com>, David Woodhouse <dwmw@amazon.co.uk>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Remove the unnecessary paravirt_set_sched_clock() stub for PARAVIRT=n, as
all callers are gated by PARAVIRT=y.  Eliminating the stub will avoid a
pile of pointless churn as the "real" implementation evolves.

No functional change intended.

Fixes: 39965afb1151 ("x86/paravirt: Move paravirt_sched_clock() related code into tsc.c")
Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/timer.h | 3 +++
 arch/x86/kernel/tsc.c        | 1 -
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/timer.h b/arch/x86/include/asm/timer.h
index fda18bcb19b4..c71b466d6ace 100644
--- a/arch/x86/include/asm/timer.h
+++ b/arch/x86/include/asm/timer.h
@@ -12,7 +12,10 @@ extern void recalibrate_cpu_khz(void);
 extern int no_timer_check;
 
 extern bool using_native_sched_clock(void);
+
+#ifdef CONFIG_PARAVIRT
 void paravirt_set_sched_clock(u64 (*func)(void));
+#endif
 
 /*
  * We use the full linear equation: f(x) = a + b*x, in order to allow
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 56e73e96920a..375b0279df66 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -288,7 +288,6 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 u64 sched_clock_noinstr(void) __attribute__((alias("native_sched_clock")));
 
 bool using_native_sched_clock(void) { return true; }
-void paravirt_set_sched_clock(u64 (*func)(void)) { }
 #endif
 
 notrace u64 sched_clock(void)
-- 
2.55.0.rc0.799.gd6f94ed593-goog

