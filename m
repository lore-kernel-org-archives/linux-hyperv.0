Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BE93ED5A1
	for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780067264; cv=none; b=CYNlztNkq31JJPDiISiE88xzG/9MSDP6Vx3eivoDKpjqRtXBLQty9xhm/gwV9GF6f2ItVPMGPYuqvaUDm0Q7quxwTwSigrncFaH25jot6KKA+B3/I4Xu20IgU49ajcN3gYxQRb0ZoBIM5Q2fJh7s4RVwe/vCGMyX0bE8ovqEYN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780067264; c=relaxed/simple;
	bh=N6HgGTl0IVNz6oX6cT3n/HXARjgILsqMOZOe8o8MgE0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=sxRQ+k0eDd3/uv9J2HH4bZ4mxfubs3vGqS6QkhDuWxEIKNxTaTBs7A0baZ3bVAtNEEIRuiiw7D0vzusBSpfIP4YLMP+s7fuhb7iwQzaoCMfaIxR/VdD/3K8+7/pMMAOFjfn9nVP7VGHfMRJxb3qybhuE0On08V3jzjt01OuSx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZTZpfdbe; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZTZpfdbe"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c827bda2e60so8279480a12.3
        for <linux-hyperv@vger.kernel.org>; Fri, 29 May 2026 08:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780067261; x=1780672061; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=QESOUvdfZXleHQZ88nzDXbmZWnZIugt5BTjJEx5ZF5Q=;
        b=ZTZpfdbetauluRrcop3gtWjK3MVm/FUplTrfZsN2Vuc4auLQ8mXMcFjIjR0nPrPRIx
         R8ZORo2AQuPKEcH6qPcAaGGrkrhWOrdi7Twq7UyCBVZl1Ju7Pk0Ysnl1Bmo5hPQMAKC5
         9aXAdKR7/Tl+ldPJPSSdJ7gwkDKJ+AFU8JJx9p9AO+buBwcLO1W6eLDHC/X4DqfuFFsb
         Gyz7CpPCmVC6qFQW7IxvEOjQSzx/+AxMWQDcvS5ou3truNj6+7EuUQbtGodjfCbQc2kJ
         L3hgg+hbaDd+ZSuv+PttrATrzz3Bt2s91awivBYuQSq8yZUV6KEpbgXw2W9QwHeUkVoc
         w/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780067261; x=1780672061;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QESOUvdfZXleHQZ88nzDXbmZWnZIugt5BTjJEx5ZF5Q=;
        b=Z88pKGA/nc6ns/7NzGGjY4H3MHx5an0nuHjRRJFeJg8ga5TDtzhLRzBCp7XOkiYm2Y
         tQZ4M3khl/HUmVl+Pqys8Ifa93T3/5+m1DlFJjbkeugZAtJn+sdmvoRB/OvrqvU7odCT
         Cx20cmR0sVd/fGpWpw7utxp6xK2fKHiJnSYN2G7r/YzlNackASztpFGShzpswY0ebgMy
         VAbcJlLEns9byRaQoDahUAmb1edd+yyL4tpS1woZSi6rOCQyPf7JGSHYoJ5ObxabhfYf
         ZpVDvA4ukda76eBVyzWe6X+Ypcmja4hTF5Q3TTRrsJujh7W48k5b6qrI41W/JfGWsnH7
         F6Gg==
X-Forwarded-Encrypted: i=1; AFNElJ+5fBG5tjiFnpCwKS6hXqr7mKBCik6o/xpo20s03mP+coR2M49sqRfKivpOtBz2hZCT17kyoybDjOjVUxo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1jeampDADDMQjn/TBjmPQNFszUHZR5SxDAx30nhsx8nSyV+nx
	FMHqfYsA92H8ntg97GAThEhialzZdJGxZAPA52pSr22p/OhHqFu8XLilQvHnvPPwDGOoTFvaGWZ
	9NVm/5g==
X-Received: from pgau6.prod.google.com ([2002:a05:6a02:2d86:b0:c85:828a:ba9a])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:692:b0:3aa:55eb:a5fb
 with SMTP id adf61e73a8af0-3b411dd1faamr4128146637.23.1780067260421; Fri, 29
 May 2026 08:07:40 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Fri, 29 May 2026 08:07:20 -0700
In-Reply-To: <20260529144435.704127-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529144435.704127-1-seanjc@google.com>
X-Mailer: git-send-email 2.54.0.823.g6e5bcc1fc9-goog
Message-ID: <20260529150720.714067-1-seanjc@google.com>
Subject: [PATCH v4 29/47] x86/kvmclock: Move sched_clock save/restore helpers
 up in kvmclock.c
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	Kiryl Shutsemau <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, 
	"K . Y . Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
	Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov <alexey.makhalov@broadcom.com>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Andy Lutomirski <luto@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Juergen Gross <jgross@suse.com>, 
	Daniel Lezcano <daniel.lezcano@kernel.org>, John Stultz <jstultz@google.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, 
	Vitaly Kuznetsov <vkuznets@redhat.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Stephen Boyd <sboyd@kernel.org>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev, 
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
	xen-devel@lists.xenproject.org, David Woodhouse <dwmw@amazon.co.uk>, 
	Tom Lendacky <thomas.lendacky@amd.com>, Nikunj A Dadhania <nikunj@amd.com>, 
	David Woodhouse <dwmw2@infradead.org>, Michael Kelley <mhklinux@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

Move kvmclock's sched_clock save/restore helper "up" so that they can
(eventually) be referenced by kvm_sched_clock_init().

No functional change intended.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 108 ++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 54 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4e50e75ff43d..0d4f2cf97246 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -71,6 +71,25 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 	return -ENODEV;
 }
 
+static void kvm_register_clock(char *txt)
+{
+	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
+	u64 pa;
+
+	if (!src)
+		return;
+
+	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
+	wrmsrq(msr_kvm_system_time, pa);
+	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
+}
+
+static void kvmclock_disable(void)
+{
+	if (msr_kvm_system_time)
+		native_write_msr(msr_kvm_system_time, 0);
+}
+
 static u64 kvm_clock_read(void)
 {
 	u64 ret;
@@ -91,6 +110,30 @@ static noinstr u64 kvm_sched_clock_read(void)
 	return pvclock_clocksource_read_nowd(this_cpu_pvti()) - kvm_sched_clock_offset;
 }
 
+static void kvm_save_sched_clock_state(void)
+{
+	/*
+	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
+	 * If the system is hibernating, then kvmclock will likely reside at a
+	 * different physical address when the system awakens, and host writes
+	 * to the old address prior to reconfiguring kvmclock would clobber
+	 * random memory.
+	 */
+	kvmclock_disable();
+}
+
+#ifdef CONFIG_SMP
+static void kvm_setup_secondary_clock(void)
+{
+	kvm_register_clock("secondary cpu clock");
+}
+#endif
+
+static void kvm_restore_sched_clock_state(void)
+{
+	kvm_register_clock("primary cpu clock, resume");
+}
+
 static inline void kvm_sched_clock_init(bool stable)
 {
 	kvm_sched_clock_offset = kvm_clock_read();
@@ -103,6 +146,17 @@ static inline void kvm_sched_clock_init(bool stable)
 		sizeof(((struct pvclock_vcpu_time_info *)NULL)->system_time));
 }
 
+void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
+{
+	/*
+	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
+	 * being used for sched_clock, then it needs to be kept alive until the
+	 * last minute, and restored as quickly as possible after resume.
+	 */
+	if (action != KVM_GUEST_BSP_SUSPEND)
+		kvmclock_disable();
+}
+
 /*
  * If we don't do that, there is the possibility that the guest
  * will calibrate under heavy load - thus, getting a lower lpj -
@@ -161,60 +215,6 @@ static struct clocksource kvm_clock = {
 	.enable	= kvm_cs_enable,
 };
 
-static void kvm_register_clock(char *txt)
-{
-	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
-	u64 pa;
-
-	if (!src)
-		return;
-
-	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
-	wrmsrq(msr_kvm_system_time, pa);
-	pr_debug("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
-}
-
-static void kvmclock_disable(void)
-{
-	if (msr_kvm_system_time)
-		native_write_msr(msr_kvm_system_time, 0);
-}
-
-static void kvm_save_sched_clock_state(void)
-{
-	/*
-	 * Stop host writes to kvmclock immediately prior to suspend/hibernate.
-	 * If the system is hibernating, then kvmclock will likely reside at a
-	 * different physical address when the system awakens, and host writes
-	 * to the old address prior to reconfiguring kvmclock would clobber
-	 * random memory.
-	 */
-	kvmclock_disable();
-}
-
-static void kvm_restore_sched_clock_state(void)
-{
-	kvm_register_clock("primary cpu clock, resume");
-}
-
-void kvmclock_cpu_action(enum kvm_guest_cpu_action action)
-{
-	/*
-	 * Don't disable kvmclock on the BSP during suspend.  If kvmclock is
-	 * being used for sched_clock, then it needs to be kept alive until the
-	 * last minute, and restored as quickly as possible after resume.
-	 */
-	if (action != KVM_GUEST_BSP_SUSPEND)
-		kvmclock_disable();
-}
-
-#ifdef CONFIG_SMP
-static void kvm_setup_secondary_clock(void)
-{
-	kvm_register_clock("secondary cpu clock");
-}
-#endif
-
 static void __init kvmclock_init_mem(void)
 {
 	unsigned long ncpus;
-- 
2.54.0.823.g6e5bcc1fc9-goog

