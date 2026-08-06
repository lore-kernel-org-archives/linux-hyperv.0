Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB794D90D8
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059399; cv=none; b=bN/kwP/laP3E0GO9out91dH4hApvxRutCRRT9kAUND/qJJ7PJSAWnJH1Zm4FS/zPpIjdeeZKJldC3N62F3nOcKmW4CJagzxS2xXg+NXbp2NdP7tesExi5nOv9zXHqpgJKRHXg4wUZYgLtkbdTYUET9uyS7FpNMRl4lSwRGI5KvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059399; c=relaxed/simple;
	bh=0Kl+c7t025bK+Cqp86ctpON2KCu80eKJQ0ZAUvEQz8s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=N+9YbelyDBe9wrSKNQKvFIN6KTyNq1DrPffJd7G5TqaKO+taEf8W54abCwyuodXH7J5CGixK6E+ZA61ixz6QUZKXaLWWKddfW0AssCXeEdgOwTIkoryRGPegZswTi3QxpJhqgTtP0o9Mq7ssF4Mw6cRxA+CzMQdnNrB+h2hs4g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDkWZOFG; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDkWZOFG"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbb6433e9d4so3414105a12.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059394; x=1786664194; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kH88onT2XQPjPMTP9foWuf2kpVwGIl3qVDy3ZQ/XBNk=;
        b=sDkWZOFGs3ScjqHDZiAXKBlr5eTgShEjIANcKhv5kcigEmrAyfXxwlESroLiDWbPNZ
         3XXk8iQ6Wgp6b8kMiQ30ZAXzkLFqw2waS1q+ZZDA4Gajvh4IkECBy/y4jJH1b5mTUi+D
         gEWAoBmxv0ebRAVYQZr1sO9XlMgMmvWLWhIgRb/X7kg8JxxGfTdtXUMTLg/pe5n8GWBs
         GOAhoi2XZGc8oXqeBgSWod4HtA8vzZjrwns8SiL5Sm5NuzeXUi2p12KHs90Xjm7ED+iF
         ncUQozGbNGRBkBNADW2p1zRXT8/mL2CaKJIaj0abDz32oyrgYAZP4ZnKY+GfiSZ8R82F
         S/+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059394; x=1786664194;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:reply-to:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kH88onT2XQPjPMTP9foWuf2kpVwGIl3qVDy3ZQ/XBNk=;
        b=qrO11aKQRFBTdRo91Vme34GzqnzIrbgNidPrgGuhr2akCQ5kOhQoSak8SeKoDsmX0L
         umxYOLaBMymyvwFdNOQbw/NDHDVXgRhBtqQxFkrlJ8k/LMewxFmWvgSielwq4MiX0j52
         skonek5dOSxNMbTP5dM5VlRt9lmP+QVbYMf6C34bEm6+qqK2iLGKAg87isDbtk935TsF
         LF8TP+M/7rcmZ3XzGwNpiGazLgSwdLfhlWK9rFG1HgM4uEbizOPmaWY82bBK7LRkBzAV
         jQX8QgUCp9p/U7xygsb7Ck7Whw0Q6RwKf8Q5H86w6Wc924A/jgueG4bjPNpaWmsSGj4K
         9o1w==
X-Forwarded-Encrypted: i=1; AHgh+Rok0Zxc7l7hEvCMPGK9j08NLs4H/P3hM427Tg599iQr6cqwstb3gQ/7NFAsNiRy1l2aFgF3l890FMbNATI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD/Ui//hCWFtDHEzZEzYQyxUH626T+lMipuuYCWGrHDvvuvvF
	cG53RZNZ5quWWdQGdI7R/RoqWkyJylWoOtq04FeZev20rVCRTrfQyXILduaB3RkNsjkoHPkRQ36
	U0+f0Lg==
X-Received: from pgei3.prod.google.com ([2002:a05:6a02:5263:b0:c82:7761:9936])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1ca2:b0:847:8ccc:d7c6
 with SMTP id d2e1a72fcca58-84f2e0278d5mr21014018b3a.31.1786059393911; Thu, 06
 Aug 2026 16:36:33 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:25 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-9-seanjc@google.com>
Subject: [PATCH v6 08/51] x86/sev: Shove SNP's secure/trusted TSC frequency
 directly into "calibration"
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

As a first step towards dropping .calibrate_{cpu,tsc}() and explicitly
defining precedence/priority for "calibration" routines, pass the secure
TSC frequency obtained from SNP firmware directly to
determine_cpu_tsc_frequencies() instead of overriding the .calibrate_tsc()
hook.

Unlike the native calibration routines, all of the paravirtual overrides,
including SNP and TDX, are constant in the sense that the frequency
provided by the hypervisor or trusted firmware is fixed, known, and always
available during early boot.  More importantly, for CoCo (SNP and TDX) VMs,
it's imperative that the kernel uses the frequency provided by the trusted
firmware, not by the untrusted hypervisor.  Enforcing the priority between
sources by carefully ordering seemingly unrelated init calls, so that the
trusted override "wins", is brittle and all but impossible to follow.

Explicitly ignore tsc_early_khz if the exact TSC frequency was obtained
from trusted firmware, as per commit bd35c77e32e4 ("x86/tsc: Add
tsc_early_khz command line parameter"), the goal of the param is to play
nice with setups that provide partial frequency information in CPUID, i.e.
is NOT intended to be a hard override.  Neither SNP's secure TSC nor TDX
was supported when commit bd35c77e32e4 landed back in 2020, i.e. lack of
consideration for the interaction was purely due to oversight when SNP and
TDX support came along.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Tested-by: Nikunj A Dadhania <nikunj@amd.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 +++
 arch/x86/coco/sev/core.c                      | 14 +++--------
 arch/x86/include/asm/sev.h                    |  4 +--
 arch/x86/kernel/tsc.c                         | 25 ++++++++++++++-----
 4 files changed, 29 insertions(+), 18 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 87bb1fb31696..aa4eb568d9fb 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7946,6 +7946,10 @@ Kernel parameters
 			with CPUID.16h support and partial CPUID.15h support.
 			Format: <unsigned int>
 
+			Note, tsc_early_khz is ignored if the TSC frequency is
+			provided by trusted firmware when running as an SNP
+			guest.
+
 	tsx=		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
 			support TSX control.
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index 403dcea86452..bc5ae9ef74da 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -99,7 +99,6 @@ static const char * const sev_status_feat_names[] = {
  */
 static u64 snp_tsc_scale __ro_after_init;
 static u64 snp_tsc_offset __ro_after_init;
-static unsigned long snp_tsc_freq_khz __ro_after_init;
 
 DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
 DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
@@ -2014,15 +2013,10 @@ void __init snp_secure_tsc_prepare(void)
 	pr_debug("SecureTSC enabled");
 }
 
-static unsigned long securetsc_get_tsc_khz(void)
-{
-	return snp_tsc_freq_khz;
-}
-
-void __init snp_secure_tsc_init(void)
+unsigned int __init snp_secure_tsc_init(void)
 {
+	unsigned long snp_tsc_freq_khz, tsc_freq_mhz;
 	struct snp_secrets_page *secrets;
-	unsigned long tsc_freq_mhz;
 	void *mem;
 
 	mem = early_memremap_encrypted(sev_secrets_pa, PAGE_SIZE);
@@ -2043,7 +2037,7 @@ void __init snp_secure_tsc_init(void)
 
 	snp_tsc_freq_khz = SNP_SCALE_TSC_FREQ(tsc_freq_mhz * 1000, secrets->tsc_factor);
 
-	x86_platform.calibrate_tsc = securetsc_get_tsc_khz;
-
 	early_memunmap(mem, PAGE_SIZE);
+
+	return snp_tsc_freq_khz;
 }
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 594cfa19cbd4..05ebf0b73ef4 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -530,7 +530,7 @@ int snp_send_guest_request(struct snp_msg_desc *mdesc, struct snp_guest_req *req
 int snp_svsm_vtpm_send_command(u8 *buffer);
 
 void __init snp_secure_tsc_prepare(void);
-void __init snp_secure_tsc_init(void);
+unsigned int snp_secure_tsc_init(void);
 enum es_result savic_register_gpa(u64 gpa);
 enum es_result savic_unregister_gpa(u64 *gpa);
 u64 savic_ghcb_msr_read(u32 reg);
@@ -637,7 +637,7 @@ static inline int snp_send_guest_request(struct snp_msg_desc *mdesc,
 					 struct snp_guest_req *req) { return -ENODEV; }
 static inline int snp_svsm_vtpm_send_command(u8 *buffer) { return -ENODEV; }
 static inline void __init snp_secure_tsc_prepare(void) { }
-static inline void __init snp_secure_tsc_init(void) { }
+static inline unsigned int __init snp_secure_tsc_init(void) { return 0; }
 static inline void sev_evict_cache(void *va, int npages) {}
 static inline enum es_result savic_register_gpa(u64 gpa) { return ES_UNSUPPORTED; }
 static inline enum es_result savic_unregister_gpa(u64 *gpa) { return ES_UNSUPPORTED; }
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index c710c71a1bdf..6898584610a7 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1440,15 +1440,16 @@ static int __init init_tsc_clocksource(void)
  */
 device_initcall(init_tsc_clocksource);
 
-static bool __init determine_cpu_tsc_frequencies(bool early)
+static bool __init determine_cpu_tsc_frequencies(bool early,
+						 unsigned int known_tsc_khz)
 {
 	/* Make sure that cpu and tsc are not already calibrated */
 	WARN_ON(cpu_khz || tsc_khz);
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
-			tsc_khz = tsc_early_khz;
+		if (known_tsc_khz)
+			tsc_khz = known_tsc_khz;
 		else
 			tsc_khz = x86_platform.calibrate_tsc();
 	} else {
@@ -1503,6 +1504,8 @@ static void __init tsc_enable_sched_clock(void)
 
 void __init tsc_early_init(void)
 {
+	unsigned int known_tsc_khz = 0;
+
 	if (!boot_cpu_has(X86_FEATURE_TSC))
 		return;
 	/* Don't change UV TSC multi-chassis synchronization */
@@ -1510,9 +1513,19 @@ void __init tsc_early_init(void)
 		return;
 
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
-		snp_secure_tsc_init();
+		known_tsc_khz = snp_secure_tsc_init();
 
-	if (!determine_cpu_tsc_frequencies(true))
+	/*
+	 * Ignore the user-provided TSC frequency if the exact frequency was
+	 * obtained from trusted firmware, as the user-provided frequency is
+	 * intended as a "starting point", not a known, guaranteed frequency.
+	 */
+	if (!known_tsc_khz)
+		known_tsc_khz = tsc_early_khz;
+	else if (tsc_early_khz)
+		pr_err("Ignoring 'tsc_early_khz' in favor of trusted firmware.\n");
+
+	if (!determine_cpu_tsc_frequencies(true, known_tsc_khz))
 		return;
 	tsc_enable_sched_clock();
 }
@@ -1533,7 +1546,7 @@ void __init tsc_init(void)
 
 	if (!tsc_khz) {
 		/* We failed to determine frequencies earlier, try again */
-		if (!determine_cpu_tsc_frequencies(false)) {
+		if (!determine_cpu_tsc_frequencies(false, 0)) {
 			mark_tsc_unstable("could not calculate TSC khz");
 			setup_clear_cpu_cap(X86_FEATURE_TSC_DEADLINE_TIMER);
 			return;
-- 
2.55.0.679.g6767b8d81c-goog

