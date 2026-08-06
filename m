Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B99F4A653F
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059433; cv=none; b=hoeAyu9S9DyUY8YD7CW+CW/NCugPPQQGOxV38BCf48+fmGb7F8smptEOJ4tJaANotlEnT8SXGmSQrVWgn768DTPve3Yuq9GHZQR1OOci94V1AWnCPZ63Z37J2LkG5fz+Jp6ln4Fpye2pR66PcYWWAZCe44DwkAfWCCOVQLUaD+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059433; c=relaxed/simple;
	bh=xQeSz+UJSRzEJeUN758xlvy+p2UjlhjfQlkKcSNGiA0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CRdYEgNNGzHIZZW4Q9Z2kGZaIJCLWjQavWHJtKxLjNrfhCXmT+szf0/6dbXBcN8K9RARMvh0IfU/8biUPSxBP6Nz6sECdHGXabIabpzb3d9ezZtvKYD+zi2/PLhw2TeIfSinpXFLskTwFH73TFM8dBDLK1Q9lda74vUseotBV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FxLtI8uT; arc=none smtp.client-ip=209.85.216.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FxLtI8uT"
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-38e8e864ef0so3993291a91.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059431; x=1786664231; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=dLl1t0qRZTm556OBeVqKVx/DHfexmKODeXAiUOaDm4I=;
        b=FxLtI8uTpRMW3QsjAnJm+ORVKEpbSKKgwRYg5ddW/C+NUAk4Ci81ny7RUQmuh3+1OS
         HYmjrOCOz3QAjZYC9543vUexa1aJcsIj5LlnPRImZhdPK/OvRI9JPrkn3K5g8XjZnHgR
         Jfglss7Ka13TdAriw1cqYZxnz9+hr+ZMOQSs1gRieeNFVnnKaltdvtJGNGbYEv16zem8
         4+jbBYz/NU9+/EVFg33nsyG/B1k1sIQHNt5MDATzODrJRupRKitPLlhi+Ozrm14C6x4x
         lHhNDaTKcds4wXHm5qQ0kQmNTO4+QTW76Mi57IOAVkGp0WQk5rMaGv2ofxXWgEevITC7
         kznA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059431; x=1786664231;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dLl1t0qRZTm556OBeVqKVx/DHfexmKODeXAiUOaDm4I=;
        b=jhJnqsssSwnviYHv1W2cYIZT4C5c4i+CSAv8sWoR5v6O/b4IAtpkan4upQKv3cX35U
         qp2I9hwcF4on9/ywc0pblQWofmFtJ5so5QNRwzZizUcyxOgiwYBNf+dvUVuFkouzC3dV
         5EQoaW2FcSw0JmxIgq5BtvCSXFx2aAo4M5jlYQmO0q4+sNHLS1HnADhppoFab6JJ1ovg
         TKfiEDWDN+ycuMhr+AEImnA2dNOxOQsjMNVgzwJ00ZAzWZ1c3XEXeqMlofM1jzCVmPzX
         PTDqw5i//c9FJ9DrqyJDBVJtKHFFsBUWhE+R22YnNv5CdarIUxkCNo3WN2bq1oMiZYAN
         bFXg==
X-Forwarded-Encrypted: i=1; AHgh+Rooj+cbrzqyOAaMC9qkYhFxqF9PgpjPghqUZBDQ1AsBaidgiiyZTA9Cty/xNkyZyqlGdMnSnMtWXfcKy2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjBXslji1rmJvpiZ1SFWeeCNPRckMCIwEtujyVWL2FlNZpUI1R
	kd1VdyBHNWYtwJZgS0iB5y6J7irSg1zudi8amvQBubvSSlI/1vdPLCBM4G1X2C8tlrwxs7KY778
	ioa4Y5Q==
X-Received: from pjzg4.prod.google.com ([2002:a17:90a:e584:b0:38e:b470:e6db])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2590:b0:38f:2168:b9cb
 with SMTP id 98e67ed59e1d1-3903c572a05mr18787499a91.9.1786059430539; Thu, 06
 Aug 2026 16:37:10 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:54 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-38-seanjc@google.com>
Subject: [PATCH v6 37/51] x86/kvmclock: Move kvm_sched_clock_init() down in kvmclock.c
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

Move kvm_sched_clock_init() "down" so that it can reference the global
kvm_clock structure without needing a forward declaration.

Opportunistically mark the helper as "__init" instead of "inline" to make
its usage more obvious; modern compilers don't need a hint to inline a
single-use function, and an extra CALL+RET pair during boot is a complete
non-issue.  And, if the compiler ignores the hint and does NOT inline the
function, the resulting code may not get discarded after boot due lack of
an __init annotation.

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5b9955343199..5220d205abc7 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -155,20 +155,6 @@ static void kvm_restore_sched_clock_state(void)
 	kvm_register_clock("primary cpu clock, resume");
 }
 
-static inline void kvm_sched_clock_init(bool stable)
-{
-	kvm_sched_clock_offset = kvm_clock_read();
-	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
-				   kvm_save_sched_clock_state,
-				   kvm_restore_sched_clock_state);
-
-	pr_info("kvm-clock: using sched offset of %llu cycles",
-		kvm_sched_clock_offset);
-
-	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
-		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
-}
-
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
 {
 	/*
@@ -325,6 +311,20 @@ static int kvmclock_setup_percpu(unsigned int cpu)
 	return p ? 0 : -ENOMEM;
 }
 
+static __init void kvm_sched_clock_init(bool stable)
+{
+	kvm_sched_clock_offset = kvm_clock_read();
+	__paravirt_set_sched_clock(kvm_sched_clock_read, stable,
+				   kvm_save_sched_clock_state,
+				   kvm_restore_sched_clock_state);
+
+	pr_info("kvm-clock: using sched offset of %llu cycles",
+		kvm_sched_clock_offset);
+
+	BUILD_BUG_ON(sizeof(kvm_sched_clock_offset) >
+		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
+}
+
 void __init kvmclock_init(bool prefer_tsc)
 {
 	u8 flags;
-- 
2.55.0.679.g6767b8d81c-goog

