Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5FF423F7F
	for <linux-hyperv@vger.kernel.org>; Wed,  1 Jul 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782934404; cv=none; b=fEiU9PZOexgtXolb9kd9VSBrA8/jLH2Pb25PD1Da7za8YzwRpRh/GrRMfqTSpgOtLObNjaQL8mRoB2clKE9FTB3ssIrPVnbwrpLAMMmjOKwAxv3m0d70erQ8puV2gP6FEZ9vP2+2BvpmM4lijrjAQ/EamfcUnVSpW1hxDAMJSnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782934404; c=relaxed/simple;
	bh=yJ9ey08FPsxOVFIWPFG6h7XBR1765ZGM408oIX3wjfI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=eioDnV1SRRm4OmTWHf0QCzbx3fx/0E1h84EoOStPRIUDj+8RR2kjgC/XiWvrXqcETdti4SVNZ8HWONDkYJTv56Ug5PgZ79jKwsZdXefDQJI2UUWhQX1ECHMN+8DosqL77gzJCq2jcdiOmJO9MUeDNq97iJV2FQAM3K5OEntmdVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UwCc1YrX; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UwCc1YrX"
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-37d125687b6so1193529a91.1
        for <linux-hyperv@vger.kernel.org>; Wed, 01 Jul 2026 12:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1782934401; x=1783539201; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:from:to:cc:subject:date:message-id:reply-to;
        bh=X+4LkvbZ4eCaIbae7uS/MPBNwexrDlCNdhdaInFV7cw=;
        b=UwCc1YrXsj570554spoRMd3lgymIboCj3I3nNRFQBe2yBN3n1i6XSHLJzHU9KvIFoB
         LmXYtHpqjeKOE4mTc4yeyqsIE6iG0Bt/BDWugFJmFnB3E0Cw7dfbGb3eco4EoHo4j7YV
         OembwmDtAImuBZBrLvhZ8DpGPZIh7Mxhd6CoRqWll/dPp1a12FWGF9NFdi6GtDb3eoUF
         ZwlGE4dk7J/ggzmLfJ8VhBHCYy29VKRKytUdKoit4Sqo1pbQOMfgXXhE4DENUWzArXA8
         RavyRwXSvQdsx+8ORlkwcB13wPk38tmXvlvv+gTfcrHAEmRiw+AlwHwSAIMEstk1cOYv
         LM/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782934401; x=1783539201;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:reply-to:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+4LkvbZ4eCaIbae7uS/MPBNwexrDlCNdhdaInFV7cw=;
        b=atfvDD3yhY4g1eLJ1cS4TWMSoVrkLOk35MLAmXZkNCBj5bEaAZoB5b6N5L8o4LW09E
         Bn1GMQE8amrCpb3QFr1M51wxYqnYS6PcPz+aZIljvUM4XabdXZs2JX/IiaZG3rzDkuf5
         2YCzF+p8KLst9Aa7TwLGkZfsXYBHhkQZ8XOwI/ov04GLrnuxfjslA0cgIUVxM7LPOaBI
         cFOjqZbS94mcqcntLevRai/BmzMlO+pcctOMzbuwfvQF5aNeHlgdYkqNAJWbb+p1leSM
         AsTu6aTF/5dvguyH4EzAr+xg+uKCuohcYe1M14n4HCFiJfF9XtCRXXr0w+hGr0vxR+tM
         Tung==
X-Forwarded-Encrypted: i=1; AHgh+Rrzd9iuRo8saXhBkwfeaCzP4De7Is7PUcYHBj5enK8Le+QtUl1U3M+6rjLeOGcag9oYeBp1nBUpIGd+bKs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnKKIuG1i/pm6XxWqkbmJI3njCJekVwtFSCFt9g1H1cDNOcsNw
	t5OIY0M1nQJcclq8+G7ueB04mplc8/8FPBfg2FLKJILARZdq9UbgeR/BAfSFYOzZaGkUEUvaweP
	ysIeyiA==
X-Received: from pjbms9.prod.google.com ([2002:a17:90b:2349:b0:37f:9ce0:f1f5])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2c87:b0:37f:ed7e:7e42
 with SMTP id 98e67ed59e1d1-380aa0e0512mr2733682a91.14.1782934400395; Wed, 01
 Jul 2026 12:33:20 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Wed,  1 Jul 2026 12:32:05 -0700
In-Reply-To: <20260701193212.749551-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260701193212.749551-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260701193212.749551-45-seanjc@google.com>
Subject: [PATCH v5 44/51] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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

WARN if kvmclock is still suspended when its wallclock is read, i.e. when
the kernel reads its persistent clock.  The wallclock subtly depends on
the BSP's kvmclock being enabled, and returns garbage if kvmclock is
disabled.

Reviewed-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 arch/x86/kernel/kvmclock.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 41aff709b90a..2cc3dd2ba355 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -53,6 +53,8 @@ static struct pvclock_vsyscall_time_info *hvclock_mem;
 DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
 EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
 
+static bool kvmclock_suspended;
+
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
  * have elapsed since the hypervisor wrote the data. So we try to account for
@@ -60,6 +62,7 @@ EXPORT_PER_CPU_SYMBOL_GPL(hv_clock_per_cpu);
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
+	WARN_ON_ONCE(kvmclock_suspended);
 	wrmsrq(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
 	preempt_disable();
 	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
@@ -140,6 +143,7 @@ static void kvm_save_sched_clock_state(void)
 	 * to the old address prior to reconfiguring kvmclock would clobber
 	 * random memory.
 	 */
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
@@ -152,16 +156,19 @@ static void kvm_setup_secondary_clock(void)
 
 static void kvm_restore_sched_clock_state(void)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, sched_clock resume");
 }
 
 static void kvmclock_suspend(struct clocksource *cs)
 {
+	kvmclock_suspended = true;
 	kvmclock_disable();
 }
 
 static void kvmclock_resume(struct clocksource *cs)
 {
+	kvmclock_suspended = false;
 	kvm_register_clock("primary cpu, clocksource resume");
 }
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

