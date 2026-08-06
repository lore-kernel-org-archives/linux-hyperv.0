Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4884EA370
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 23:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786059401; cv=none; b=iHWyy+okBX6MLY/IoGwIc4cm3tL0KCvuxb/C9jnqlK0htwr3vClc4uw5n+6Ux2SfaAgtdOmA1sbzy/agHGcLOR0VJhIDyfV/26VbSuB7eQgRzTFG9TaBAqdeOhvwSzzUb22QMHoUP5Pm5CTfQqcUsWQDozbSJ0yDvq/2T9euKSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786059401; c=relaxed/simple;
	bh=jnf4MoiYxbuRu8FiLKuFAOuHO/WPwaUORBBRFhQd2s8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jQXQjSLFoKnMf1r4070O6diakUwMpr1keIzJdZO+zmw/Ii1tdHG8/BKb4S8oqneXuTkt0VhxqMLWLxz9bCNijBQnuG7CB1wmWURLMGw1NKsuQLWtGZvpnRTvEN9DxP19PdyNDK9NZFd46LZmm8xhjb3VK+jfWQ5naqgiwIDcgOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q0UP577C; arc=none smtp.client-ip=209.85.210.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q0UP577C"
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84e048a801dso3655123b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 06 Aug 2026 16:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786059397; x=1786664197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QkWxTw8zJYn5bKvqCmD8koA0mP/8bnNFfn6ySpGUKjQ=;
        b=q0UP577CYuy6TGIh8dVeqL227RS5P73+vyDuHDnwSWh2hPC1IhnAdhU46rdIBmwsWJ
         CR3NSOKrZrMuHZabae3ft4VTRTOPEuh4LJ0pQ3P5XTKME4+DLnZTZHV+5+2uX+aQF70B
         ofYXGgmT2X8cKZOKXY8tkTTPrUY3feN4XZM+q9ZIP1UE6A1XFeTbi+yT6PxFfjyvqiaa
         JWYTmgDpW/Q3qrrz6gbLwLUJ5kJOYkWN5rNqEFiAQKO2q66IIGinUQu4UseqxDnKjmAp
         xmugu8MT/3Pac0d4pK823Xfn8oODlPv7LQGm270IG9atpJtrRiUwdohZNi5jGEAQLF1N
         TCGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786059397; x=1786664197;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:reply-to
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QkWxTw8zJYn5bKvqCmD8koA0mP/8bnNFfn6ySpGUKjQ=;
        b=dLAA5o9X8tY0P3X4Jk2llPOvSVmueQRmHmX1YglI5XHVAHh1cwuzUjmsxc6yFFI+Bc
         CsvOckUL9llNMpwOAT5G4Vz7wkbPHn1NFelW2O+nqcy4Jhpor6GWhyOTgKI+2NA+ri+U
         0RyYn8u/pFefzSvs2uQjleoWq91sbdM5RhdYas/AoFz2lXAekKvgTsDFn/KZP9JPn9Qo
         kN9EYcrvjUPo6SSRVXfowB1TFa7felhe1R3HlAJNHVvJ8D9zhtod+mNB54Ck+pton8mB
         hfZda+Strz3uqpYZdSdnHU+aUDUCcs+1IP+PnkcuDHy8JWpBQ4C3hz8aJ//iUj9GEXHa
         UaQQ==
X-Forwarded-Encrypted: i=1; AHgh+RoZF6QNqyoGzJWwjXXs2RfDymkjnwqDhbr7YROx+ANGT11Ul0laDe1/Vnj+ep0z9MJV1RXbBBd8a2q0JV4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxsJlQs7ZTE4g7VLyETnIdtV0F2zEVV4TwPn3mlBgeI32GMFh2
	wDwGPY2gzlyOzgPyqHU1g+6joVYlW7Qm0D6mfB7T3XtQ8kBsBqm1fRhb6bd6AanPR+0jKtJmObS
	JXfEOHA==
X-Received: from pfqy1.prod.google.com ([2002:aa7:9e01:0:b0:848:46e6:1aac])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3692:b0:84e:24f:2677
 with SMTP id d2e1a72fcca58-84f2dfc0601mr21949181b3a.4.1786059396135; Thu, 06
 Aug 2026 16:36:36 -0700 (PDT)
Reply-To: Sean Christopherson <seanjc@google.com>
Date: Thu,  6 Aug 2026 16:35:27 -0700
In-Reply-To: <20260806233609.212337-1-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806233609.212337-1-seanjc@google.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260806233609.212337-11-seanjc@google.com>
Subject: [PATCH v6 10/51] x86/tdx: Force TSC frequency with CPUID-based info
 provided by the TDX-Module
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
Content-Transfer-Encoding: quoted-printable

When running as a TDX guest, explicitly set the TSC frequency to a known
value, using CPUID-based information, instead of potentially relying on a
hypervisor-controlled PV routine.  For TDX guests, CPUID.0x15 is always
emulated by the TDX-Module, i.e. the information from CPUID is more
trustworthy than the information provided by the hypervisor.

To maintain backwards compatibility with TDX guest kernels that use native
calibration, and because it's the least awful option, retain
native_calibrate_tsc()'s stuffing of the local APIC bus period using the
core crystal frequency.  While it's entirely possible for the hypervisor
to emulate the APIC timer at a different frequency than the core crystal
frequency, the commonly accepted interpretation of Intel's SDM is that APIC
timer runs at the core crystal frequency when that latter is enumerated via
CPUID:

  The APIC timer frequency will be the processor=E2=80=99s bus clock or cor=
e
  crystal clock frequency (when TSC/core crystal clock ratio is enumerated
  in CPUID leaf 0x15).

If the hypervisor is malicious and deliberately runs the APIC timer at the
wrong frequency, nothing would stop the hypervisor from modifying the
frequency at any time, i.e. attempting to manually calibrate the frequency
out of paranoia would be futile.

Deliberately leave CPU frequency calibration as is, since the TDX-Module
doesn't provide any guarantees with respect to CPUID.0x16.

Expose and use cpuid_get_tsc_info() instead of providing a wrapper to
get the TSC and core crystal frequency, as TDX is the only anticipated
user outside of the TSC code, i.e. adding a helper to dedup the math won't
actually dedup anything.  Having TDX use "struct cpuid_tsc_info" also
avoids the temptation of declaring a local "tsc_khz" variable and thus
unintentionally creating a shadow of the global "tsc_khz".

Cc: Kiryl Shutsemau (Meta) <kas@kernel.org>
Signed-off-by: Sean Christopherson <seanjc@google.com>
---
 .../admin-guide/kernel-parameters.txt         |  4 ++--
 arch/x86/coco/tdx/tdx.c                       | 20 ++++++++++++++++---
 arch/x86/include/asm/tdx.h                    |  2 ++
 arch/x86/include/asm/tsc.h                    |  7 +++++++
 arch/x86/kernel/tsc.c                         | 11 ++++------
 5 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentatio=
n/admin-guide/kernel-parameters.txt
index aa4eb568d9fb..5a3d40a4a4ec 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -7947,8 +7947,8 @@ Kernel parameters
 			Format: <unsigned int>
=20
 			Note, tsc_early_khz is ignored if the TSC frequency is
-			provided by trusted firmware when running as an SNP
-			guest.
+			provided by trusted firmware when running as an SNP or
+			TDX guest.
=20
 	tsx=3D		[X86] Control Transactional Synchronization
 			Extensions (TSX) feature in Intel processors that
diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index f904a636d449..ec28a15e26ac 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -8,6 +8,7 @@
 #include <linux/export.h>
 #include <linux/io.h>
 #include <linux/kexec.h>
+#include <asm/apic.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -1121,9 +1122,6 @@ void __init tdx_early_init(void)
=20
 	setup_force_cpu_cap(X86_FEATURE_TDX_GUEST);
=20
-	/* TSC is the only reliable clock in TDX guest */
-	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-
 	cc_vendor =3D CC_VENDOR_INTEL;
=20
 	/* Configure the TD */
@@ -1193,3 +1191,19 @@ void __init tdx_early_init(void)
=20
 	tdx_announce();
 }
+
+unsigned int __init tdx_tsc_init(void)
+{
+	struct cpuid_tsc_info info;
+
+	if (WARN_ON_ONCE(cpuid_get_tsc_info(&info) || !info.crystal_khz))
+		return 0;
+
+	apic_set_timer_frequency_khz(info.crystal_khz, "TDX-Module via CPUID");
+
+	/* TSC is the only reliable clock in TDX guest */
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
+	setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
+
+	return info.crystal_khz * info.numerator / info.denominator;
+}
diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index 89e97d5761d8..d23ff06db41a 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -68,6 +68,7 @@ struct ve_info {
 #ifdef CONFIG_INTEL_TDX_GUEST
=20
 void __init tdx_early_init(void);
+unsigned int __init tdx_tsc_init(void);
=20
 void tdx_get_ve_info(struct ve_info *ve);
=20
@@ -89,6 +90,7 @@ void __init tdx_dump_td_ctls(u64 td_ctls);
 #else
=20
 static inline void tdx_early_init(void) { };
+static inline unsigned int tdx_tsc_init(void) { return 0; }
 static inline void tdx_halt(void) { };
=20
 static inline bool tdx_early_handle_ve(struct pt_regs *regs) { return fals=
e; }
diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index 4d2d2f21ff06..b6b86e24e1bf 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -82,6 +82,13 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
=20
+struct cpuid_tsc_info {
+	unsigned int denominator;
+	unsigned int numerator;
+	unsigned int crystal_khz;
+};
+extern int cpuid_get_tsc_info(struct cpuid_tsc_info *info);
+
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index d405ff4e45e0..f3febe406fa8 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -34,6 +34,7 @@
 #include <asm/topology.h>
 #include <asm/uv/uv.h>
 #include <asm/sev.h>
+#include <asm/tdx.h>
=20
 unsigned int __read_mostly cpu_khz;	/* TSC clocks / usec, not used here */
 EXPORT_SYMBOL(cpu_khz);
@@ -645,13 +646,7 @@ static unsigned long quick_pit_calibrate(void)
 	return delta;
 }
=20
-struct cpuid_tsc_info {
-	unsigned int denominator;
-	unsigned int numerator;
-	unsigned int crystal_khz;
-};
-
-static int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
+int cpuid_get_tsc_info(struct cpuid_tsc_info *info)
 {
 	unsigned int ecx_hz, edx;
=20
@@ -1529,6 +1524,8 @@ void __init tsc_early_init(void)
=20
 	if (cc_platform_has(CC_ATTR_GUEST_SNP_SECURE_TSC))
 		known_tsc_khz =3D snp_secure_tsc_init();
+	else if (boot_cpu_has(X86_FEATURE_TDX_GUEST))
+		known_tsc_khz =3D tdx_tsc_init();
=20
 	/*
 	 * Ignore the user-provided TSC frequency if the exact frequency was
--=20
2.55.0.679.g6767b8d81c-goog

