Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F163F4AC28D
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059442; cv=none; b=mUQhr6FFfXsjDhh/xBXIAB5kyRHy+9X65nmmOj5fDKWZdKcHlWsc/upic46oLugZHU9qROCHhmkC2NE66CZtYGUKfp6zyhJi2P9yMVElc0SB3TKDSBewdwUVFrvQD/g/qIMdQpRchYNHgSbhA9Zy2eTHVQs6KyrAdwfJ1jb3YRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059442; c=relaxed/simple;
	bh=dgm+zs36iagZrNsiEaG5tDm77qWr4GhnmJ9+Xj3CxnQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=gLWnLfV5o2o4WpDyLm+tzMdvwmpoj/A2R109uSdiWkhmnMk3wbu9S7DCDS1S4V8G9uQhfy0kCVgUuxwDm5WoDIE7igJUKCdXLlWsVQwc6QZz7dhm7Byi0UWYNPBOg8GoN8dF1dz5s8kzgSyugdFXtbhRdpHxCdkvFpcd1Gsgbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uts+aybb; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uts+aybb"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cab048cdb3eso3723743a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059439; x=1786664239; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=+wCYK2twR3W1N/eNELl9D0JNBeD1Zbsv+o0OdDwvKek=;
        b=uts+aybbPJYUPzSfs+xuKgWXGgKUIEG4Qz3Pr1JP+dhdr2FDPxKAupVVHUo7i22y4h
         fgBkbFoXQkxOiMfTPOrvoHcHSXX60/wE9SRH8RbjlD2jYFT1j97IUG6U1+bZsIXR+TOW
         0rj6G28Fzm5MJEbce9fWP1AXvQbp4QbbvY3ZuMOySCHKjb/voKDas0d5UVWoh9JOAeNm
         Bww6augN15XXZv4MajXNVHpmdsws07VB1nJOApv3BMUFiAWq3AIsb72QuZswTV9MnJgv
         5kG1nKm8zL6xAiJVE+ym9990uTKHBWDHfWHdYjjQ0Hev0Au/hdpIDuX9vwAwuleenbFy
         a4Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059439; x=1786664239;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+wCYK2twR3W1N/eNELl9D0JNBeD1Zbsv+o0OdDwvKek=;
        b=VnVm/vpbyBLkiZKOWiJperSm01a/ifE9lCRUlfE74PjqGeQk7+fhCy3yyiaG4SjBxJ
         B6fsb5haJ2TCAQe8g0yCGb4KIP52Gf0SoipNs7OkqW/7mpe4nwttNM8btrDaFfd/iJGX
         W6+D+2qmU1xFPJokKiYDDBoTg9eDHRoZ6eqYS3q2uQeokYpu8lV3orm8TnbXFA4/FQu1
         pnGLGF4Z3K2v8wwinuez83etk/5ERFuiCp+UFeN6ToQptPTuJ7ainSagNwfJ+eKQu+vj
         ZsI+7t76UiOe4uCiaNpFjf8OtDkve3EyQ7o3Zmf8deh6l6qBrYPTpmAMQKycI52F5z5V
         zAWw==
X-Forwarded-Encrypted: i=1; AHgh+RrrEPFnptcu9/wKGZ6qL4qsri1BP+j3vlm6pBiVqPFjbWnW/L4p8U0pR30m5Fjxa6NW6Or2SPhUU2k0hZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtGIfb+PVlfetKqQWg996VkkK7bxyuMCTffXrT7aaue/tOyL41
	24xMtQDZRAy+tnMS5//Jlu/fdVr3u6cQSCxWfKsqK03UjOA9K87eZLyVBYqxmcD8rAqXFxcRJlV
	ZXBeejQ==
X-Received: from pfn34.prod.google.com ([2002:a05:6a00:a222:b0:84a:31b0:7544])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3d4b:b0:84e:89a:b8f7
 with SMTP id d2e1a72fcca58-84f2dff69eemr17547973b3a.11.1786059438943; Thu, 06
 Aug 2026 16:37:18 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:36:01 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-45-seanjc@google.com>
Subject: [PATCH v6 44/51] x86/kvmclock: WARN if wall clock is read while
 kvmclock is suspended
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
2.55.0.679.g6767b8d81c-goog

