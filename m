Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8445340014B
	for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 19:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778872878; cv=none; b=BW+KlD+nVFcYx4sk/qFW5AHYpXt3DjrFEG8GHPiyR2DB1XuHUXJHQJrzeNfFtOKwXru6xsi7R51HaCZVAhjoEAHcWjzBavehX6FWsJJ5H9osfn1TEC1OGydcfbKfmw7Hq+5GApGa6c+A8WX8+YM1SgowHAprQM9ZAaiQgpxOs4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778872878; c=relaxed/simple;
	bh=lj0Wrx3Iv//hmkaQGmo4E+9Pr8EcmWhtdqcjCm5wSw8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TAc4fIpYbDIlzazp+2DO/rUTsTBuyho+GwTZEMNE52Q08cOFJwbjRcdrEYWIKYChNqVlWrsCouAekKc5eHtyhdZNoyCJroZw/scRRCxI0bnFxWwKuSn1GmpqXsDAiNpJSv57MFjVuU2pF06kPQgfFgUoCeOiQVfOIeE10XKnP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K9Dkyqfa; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K9Dkyqfa"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-8353fbc7ad5so193654b3a.3
        for <linux-hyperv@vger.kernel.org>; Fri, 15 May 2026 12:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778872876; x=1779477676; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=b8iwHk13SynGR+feSoAEVsPbJ8RDfXFvMc9oOLx500A=;
        b=K9Dkyqfa3RaGeSD8dV91pA0SluiqNnvEpIfy8bSrL8dt07s42DBDdTxdF8TWIJXBZ0
         gd7uoOe9IaaJ1oxipmVXSa8wQmP1hW8zl/lpvvdz6y9f2Zf7tA+BcWonVW4l4hfG2DoF
         6sBiKuz4kD1/k7mklFm+uPAhuBLm8Q88Dkp+khpqdm6EuHIHkR4lYew+9B/fpdJVOt9p
         V5Lf/Eo8q0WaexeC7VsKg2DcpWHkgteLymlZi1hGe1kkCZ9QcXUVHp9saVG+bq8TDAGc
         eAXx6InNtl9Au705LR8nUacjdCNUIe45Z1IoIdm3g3knnopCaWpJLtv86/W2/fxrc46X
         pwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778872876; x=1779477676;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b8iwHk13SynGR+feSoAEVsPbJ8RDfXFvMc9oOLx500A=;
        b=aIdVCq6WQhhJUVplYebatUy9JcX+UjNWRI4/AyB+NxZkMTOA0NSE6C1wtCgzMy0oab
         cGH6V2OhK3xrwoGYcxisqoXMwLPvv2+/bwHZWbmmgCQ2hXQLE/dRB8KOReiCV3cUd2Uy
         RpfCv3L1ysXeWrrxVU3uogdfuwvKeZvUX5vmIaNZ/0W2kmtD3g5Om4R341gdLtZFl8aT
         jBGz6JemYmgfTaDJFsbJQ3YtsnGrleP9yerqHhZaGysfs9zUVVAE+IaVqukd7kE6gVPT
         eEdTCaE+quzdKVhHHIbIa/thtZma56Jho/FecItJX0ZdrkYu+WCtd7dZ1zoj+X3LQPmQ
         N94A==
X-Forwarded-Encrypted: i=1; AFNElJ86jI5zijIq1YHtPUwrXEgYr13jICWqXVgjGEz5xhp99P3sZQ0iZs0//yX+4msLu/XPw1KD4gy0mJ2DcMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YziJf+ULuyfRo81DntAT5fB/vJl6pB9zzeydDbjrpd8RindoKBN
	u4cbFKwnaW0Rsk1Eaek7iuGRyj8v7Q5joDVWIWqiEDYvp5nPLyZocUG0/Io9LcJ6NcF/1eaEjO8
	22lGZQQ==
X-Received: from pfmm20.prod.google.com ([2002:a05:6a00:2494:b0:835:43a4:4aaa])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4293:b0:835:41f3:f440
 with SMTP id d2e1a72fcca58-83f33bf68e4mr5394751b3a.14.1778872875569; Fri, 15
 May 2026 12:21:15 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 15 May 2026 12:19:37 -0700
In-Reply-To: <20260515191942.1892718-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260515191942.1892718-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260515191942.1892718-37-seanjc@google.com>
Subject: [PATCH v3 36/41] x86/kvmclock: Get local APIC bus frequency from PV
 CPUID Timing Info
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

When running as a KVM guest with kvmclock support enabled, stuff the APIC
timer period/frequency with the local APIC bus frequency reported in
CPUID.0x40000010.EBX instead of trying to calibrate/guess the frequency.

See Documentation/virt/kvm/x86/cpuid.rst for details.

Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/include/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c           | 19 ++++++++++++++++---
 arch/x86/kernel/kvmclock.c      | 13 +++++++++++--
 3 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 3f7f558b5b24..381d029b72e7 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -130,6 +130,7 @@ void kvmclock_init(void);
 void kvmclock_cpu_action(enum kvm_guest_cpu_action action);
 bool kvm_para_available(void);
 unsigned int kvm_para_tsc_khz(void);
+unsigned int kvm_para_apic_bus_khz(void);
 unsigned int kvm_arch_para_features(void);
 unsigned int kvm_arch_para_hints(void);
 void kvm_async_pf_task_wait_schedule(u32 token);
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5cd92a0b156a..bfe36e361b3c 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -918,12 +918,25 @@ bool kvm_para_available(void)
 }
 EXPORT_SYMBOL_GPL(kvm_para_available);
 
-unsigned int kvm_para_tsc_khz(void)
+static bool kvm_cpuid_has_timing_info(void)
 {
 	u32 base = kvm_cpuid_base();
 
-	if (cpuid_eax(base) >= (base | KVM_CPUID_TIMING_INFO))
-		return cpuid_eax(base | KVM_CPUID_TIMING_INFO);
+	return cpuid_eax(base) >= (base | KVM_CPUID_TIMING_INFO);
+}
+
+unsigned int kvm_para_tsc_khz(void)
+{
+	if (kvm_cpuid_has_timing_info())
+		return cpuid_eax(kvm_cpuid_base() | KVM_CPUID_TIMING_INFO);
+
+	return 0;
+}
+
+unsigned int kvm_para_apic_bus_khz(void)
+{
+	if (kvm_cpuid_has_timing_info())
+		return cpuid_ebx(kvm_cpuid_base() | KVM_CPUID_TIMING_INFO);
 
 	return 0;
 }
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 5ceba4f3836c..abcc5b36ea1d 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -200,10 +200,19 @@ void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
  */
 static unsigned long kvm_get_tsc_khz(void)
 {
+#ifdef CONFIG_X86_LOCAL_APIC
+	u32 apic_khz = kvm_para_apic_bus_khz();
+
 	/*
-	 * If KVM advertises the frequency directly in CPUID, use that
-	 * instead of reverse-calculating it from the KVM clock data.
+	 * Use the TSC frequency from KVM's (and other hypervisors') PV CPUID
+	 * leaf when available, instead of reverse-calculating it from the KVM
+	 * clock data.  As a bonus, the CPUID leaf also includes the local APIC
+	 * bus/timer frequency.
 	 */
+	if (apic_khz)
+		lapic_timer_period = apic_khz;
+#endif
+
 	return kvm_para_tsc_khz() ? : pvclock_tsc_khz(this_cpu_pvti());
 }
 
-- 
2.54.0.563.g4f69b47b94-goog

