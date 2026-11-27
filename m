Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=CWxLdwIznan/7JleoJKeqEJkNEIuIgHIZzupAY4Yfg60fLmTBWmgUIaSHU8U/ftXiFL/
	 o6eSEDgTgSxYMJkF4+7L236q42howy0hMPOFNz+8MSIOn9JTs06FtfPVdLSksX7hZYQ7W
	 PUWL3blmayLLgAOkKTwmfvhDJZtWGu/kr8QE3W56B7Gjo9a1escJrXSOGGq96C1V/c3ND
	 i45pMQTAS+M6VbEU09099Jeb2Yg2Fdz9QIPRT4TS0SGlCGFpEZHYV+ri2AJugU2d+gAKJ
	 5jH7fKNsxUbkwhMAgMnniHK38vvXZWiSc5b1smr1sZWqZqKic3oinTGS+IOByvr3NqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=oNPz9ZpxCsGc+meuFpFKCWUePGwhGcZQxvI6bq4aWmQ=;
	b=GbFh6/bYdZTkVzG/U3SwzryAwjJj3f23TrVkdlDRe2FyVwLzO5IaLezqigHfh3WIps7D
	 qmznfowJ9aeMXCiRYDChA7RbZWzyplcfNrLnTdAXS+swkq7iu9BHZ0DeKqj+eGzs/2Yvr
	 30zZBk4y+7DbntVFa3Y1N4D+n3pwEM/oTrXE2pMRq4d9WBX9t/2e4tkKwjKsyXiOHN0Hm
	 542J4KsO6blYXsbH0SDH5SGGBbSNQKkQV+CL/UTXxKMZKzn93wLsZx159W/nsV9FT2/St
	 FbYQZP+X30isiUuJPHVRs/tl2L2e29RCxbKHz25pZvnVxBHjb9ZrXaN2WtMulfybW6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=NVlVyYWw;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE8E60A261E;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE8E60A261E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=NVlVyYWw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=oNPz9ZpxCsGc+meuFpFKCWUePGwhGcZQxvI6bq4aWmQ=; b=NVlVyYWwHLH49HGoDyJ4OT/K0o
	TEOIYd5+9Y0nv4/v1aP8Jv400UHre51NPqgIg/GVvUXQ3zFG1CcVu3Au6691GLSd9KugD6Cx16bQu
	xBavLTLLn2GNPOo/t6uEUwFH4tmIVyv2yqr9ufifIE0Q2iq8Tor0y0j8NKqGQUBweJa2c9NkMRYxZ
	/WllKMJZcaHhIxfyCUy7A/f9J9vPreXfkrKI6vq1nY2HOJDpmLht0Y+e7rxKEaKARog9M7YnBb+2q
	ZED9K9/PT9HiJY0/ORlCd2PMCh3Dq1xEiggV1/P+E+5vyO3pOrKiKZeOCG4p9Q8hN2PMjs8q8jnWX
	rdJ9RMEg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkq-2EHC;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pqv-3VAG;
	Fri, 27 Nov 2026 15:27:30 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Joerg Roedel <joro@8bytes.org>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nicolas Saenz Julienne <nsaenz@amazon.com>,
	Nikolas Wipper <nik.wipper@gmx.de>,
	Mushahid Hussain <hmushi@amazon.co.uk>,
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	Zack Rusin <zack.rusin@broadcom.com>,
	Doug Covelli <doug.covelli@broadcom.com>,
	Jim Mattson <jmattson@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 14/15] KVM: selftests: Add x86 register write filter test
Date: Fri, 27 Nov 2026 15:27:29 +0000
Message-ID: <20261127152730.99319-15-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127152730.99319-1-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Cover each register class with the write performed by userspace and
retired by KVM_RUN, single-stepped across an intercepted and an
emulated write; the write refused with #GP and #UD, left alone with #NM
queued, and a reserved answer, on both paths; a prefixed and an
emulated XSETBV; filters armed after the guest has run, and disarmed;
SMM; filters armed before KVM_SET_CPUID2, and across INIT and a triple
fault; and the error cases.

The library learns X86_FEATURE_AVX and the exit's name.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |    1 +
 .../selftests/kvm/include/x86/processor.h     |    1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |    1 +
 .../selftests/kvm/x86/reg_write_filter_test.c | 1004 +++++++++++++++++
 4 files changed, 1007 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/reg_write_filter_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2f67399ddd68..6fcf54f58c48 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -115,6 +115,7 @@ TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
 TEST_GEN_PROGS_x86 += x86/private_mem_kvm_exits_test
+TEST_GEN_PROGS_x86 += x86/reg_write_filter_test
 TEST_GEN_PROGS_x86 += x86/save_restore_pf_stress_test
 TEST_GEN_PROGS_x86 += x86/set_boot_cpu_id
 TEST_GEN_PROGS_x86 += x86/set_sregs_test
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 571f8a602edd..eec368e07b78 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -165,6 +165,7 @@ struct kvm_x86_cpu_feature {
 #define	X86_FEATURE_TSC_DEADLINE_TIMER	KVM_X86_CPU_FEATURE(0x1, 0, ECX, 24)
 #define	X86_FEATURE_XSAVE		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 26)
 #define	X86_FEATURE_OSXSAVE		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 27)
+#define	X86_FEATURE_AVX			KVM_X86_CPU_FEATURE(0x1, 0, ECX, 28)
 #define	X86_FEATURE_RDRAND		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 30)
 #define	X86_FEATURE_HYPERVISOR		KVM_X86_CPU_FEATURE(0x1, 0, ECX, 31)
 #define X86_FEATURE_PAE			KVM_X86_CPU_FEATURE(0x1, 0, EDX, 6)
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index d42e201eba76..c8879c3949bc 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -2079,6 +2079,7 @@ static struct exit_reason {
 	KVM_EXIT_STRING(LOONGARCH_IOCSR),
 	KVM_EXIT_STRING(MEMORY_FAULT),
 	KVM_EXIT_STRING(ARM_SEA),
+	KVM_EXIT_STRING(X86_REG_WRITE),
 };
 
 /*
diff --git a/tools/testing/selftests/kvm/x86/reg_write_filter_test.c b/tools/testing/selftests/kvm/x86/reg_write_filter_test.c
new file mode 100644
index 000000000000..7d7495c17466
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/reg_write_filter_test.c
@@ -0,0 +1,1004 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_X86_SET_REG_WRITE_FILTER and the KVM_EXIT_X86_REG_WRITE exit:
+ * arming and disarming, the write performed by userspace and retired by
+ * KVM_RUN (single-stepped too), the write refused by KVM with #GP and
+ * with #UD, left alone with an exception queued and a reserved answer,
+ * each of those for an intercepted and for an emulated write, an
+ * intercepted write left alone with RIP moved and with nothing, the true
+ * length of a prefixed instruction, per-bit mask semantics on CR0 and CR4,
+ * XCR0 filtering, descriptor-table filtering where supported, that SMM
+ * writes bypass the filter, that a sibling vCPU without filters is
+ * unaffected while the first vCPU's are armed, and that filters armed
+ * before KVM_SET_CPUID2 work after it, and survive an INIT and a triple
+ * fault.
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "apic.h"
+#include "smm.h"
+
+#define FILTERED_CR4_BIT	X86_CR4_TSD
+#define UNFILTERED_CR4_BIT	X86_CR4_DE
+/*
+ * The filtered CR0 bit is CR0.TS: the one which CLTS and LMSW, with their
+ * own exits, change as well as MOV to CR0.
+ */
+#define UNFILTERED_CR0_BIT	X86_CR0_AM
+
+#define SMRAM_GPA		0x1000000
+
+/* A port write which stops the guest without the FPU, unlike a ucall. */
+#define ARM_PORT		0x5a
+/* A port write by which the SMI handler shows that it runs. */
+#define SMM_PORT		0x5b
+
+static bool have_avx;
+static bool have_dt_filters;
+static bool have_smm;
+static bool crash;
+
+/*
+ * Say that the handler runs.  SMM entry clears CR4; set and clear the
+ * filtered CR4.TSD bit, which must be applied without a filter exit, and
+ * return.  RSM's restore of the pre-SMI CR4 is a state load and is not
+ * filtered either.
+ */
+static u8 smi_handler[] = {
+	0xe6, SMM_PORT,		/* out %al, $SMM_PORT */
+	0x0f, 0x20, 0xe0,	/* mov %cr4, %eax */
+	0x0c, 0x04,		/* or $X86_CR4_TSD, %al */
+	0x0f, 0x22, 0xe0,	/* mov %eax, %cr4 */
+	0x24, 0xfb,		/* and $~X86_CR4_TSD, %al */
+	0x0f, 0x22, 0xe0,	/* mov %eax, %cr4 */
+	0x0f, 0xaa,		/* rsm */
+};
+
+/* Fixed encodings, so that the host knows the length of each write. */
+#define MOV_TO_CR4_LEN	3
+#define MOV_TO_CR0_LEN	3
+#define CLTS_LEN	2
+#define LMSW_LEN	3
+#define XSETBV_LEN	3
+#define REX_XSETBV_LEN	4
+#define LGDT_LEN	3
+#define LIDT_LEN	3
+#define LLDT_LEN	3
+#define LTR_LEN		3
+
+static void write_cr4(u64 val)
+{
+	/* mov %rax, %cr4 */
+	asm volatile(".byte 0x0f, 0x22, 0xe0" : : "a"(val) : "memory");
+}
+
+static void write_cr0(u64 val)
+{
+	/* mov %rax, %cr0 */
+	asm volatile(".byte 0x0f, 0x22, 0xc0" : : "a"(val) : "memory");
+}
+
+static u8 write_cr4_safe(u64 val)
+{
+	/* mov %rax, %cr4 */
+	return kvm_asm_safe(".byte 0x0f, 0x22, 0xe0", "a"(val));
+}
+
+static void lgdt(const struct desc_ptr *gdt)
+{
+	/* lgdt (%rax) */
+	asm volatile(".byte 0x0f, 0x01, 0x10" : : "a"(gdt), "m"(*gdt));
+}
+
+static void lidt(const struct desc_ptr *idt)
+{
+	/* lidt (%rax) */
+	asm volatile(".byte 0x0f, 0x01, 0x18" : : "a"(idt), "m"(*idt));
+}
+
+static void lldt(u16 sel)
+{
+	/* lldt %ax */
+	asm volatile(".byte 0x0f, 0x00, 0xd0" : : "a"(sel));
+}
+
+static void ltr(u16 sel)
+{
+	/* ltr %ax */
+	asm volatile(".byte 0x0f, 0x00, 0xd8" : : "a"(sel));
+}
+
+static void guest_code(void)
+{
+	u64 cr0, cr4;
+	u8 vector;
+
+	/*
+	 * Nothing is filtered yet, and the guest owns these two bits where
+	 * the CPU lets it: KVM does not see them change.  With CR0.TS set
+	 * the guest must stay away from the FPU, so no ucall until CLTS.
+	 */
+	write_cr4(get_cr4() | FILTERED_CR4_BIT);
+	write_cr0(get_cr0() | X86_CR0_TS);
+	asm volatile("outb %%al, $" __stringify(ARM_PORT) : : "a"(0));
+
+	/*
+	 * The host has armed the filters, which takes the bits away from
+	 * the guest.  It must still read what it wrote, and its next write
+	 * of each must exit: CLTS decides by the value KVM shows it.
+	 */
+	cr0 = get_cr0();
+	cr4 = get_cr4();
+	asm volatile("clts");
+	GUEST_ASSERT(cr0 & X86_CR0_TS);
+	GUEST_ASSERT(cr4 & FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr0() & X86_CR0_TS));
+	write_cr4(get_cr4() & ~FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+
+	/* A write changing only an unfiltered bit must not exit. */
+	write_cr4(get_cr4() | UNFILTERED_CR4_BIT);
+	GUEST_ASSERT(get_cr4() & UNFILTERED_CR4_BIT);
+	write_cr0(get_cr0() ^ UNFILTERED_CR0_BIT);
+	write_cr0(get_cr0() ^ UNFILTERED_CR0_BIT);
+	GUEST_SYNC(1);
+
+	/* Filtered bit, userspace performs the write. */
+	write_cr4(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT(get_cr4() & FILTERED_CR4_BIT);
+	GUEST_SYNC(2);
+
+	/* Filtered bit, userspace leaves it uncompleted, then performs. */
+	write_cr4(get_cr4() & ~FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	GUEST_SYNC(3);
+
+	/* Filtered bit: KVM refuses with #GP(0) and #UD, userspace with #NM. */
+	vector = write_cr4_safe(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	vector = write_cr4_safe(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT_EQ(vector, UD_VECTOR);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	vector = write_cr4_safe(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT_EQ(vector, NM_VECTOR);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	GUEST_SYNC(4);
+
+	/* Filtered bit, userspace steps over the write itself. */
+	write_cr4(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	GUEST_SYNC(5);
+
+	/* CR0.TS: set by MOV to CR0, cleared by CLTS, set again by LMSW. */
+	write_cr0(get_cr0() | X86_CR0_TS);
+	GUEST_ASSERT(get_cr0() & X86_CR0_TS);
+	asm volatile("clts");
+	GUEST_ASSERT(!(get_cr0() & X86_CR0_TS));
+	/* lmsw %ax */
+	asm volatile(".byte 0x0f, 0x01, 0xf0" : :
+		     "a"((get_cr0() & 0xf) | X86_CR0_TS) : "memory");
+	GUEST_ASSERT(get_cr0() & X86_CR0_TS);
+	asm volatile("clts");
+	GUEST_SYNC(6);
+
+	if (have_avx) {
+		u64 legacy = XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
+		u64 xcr0 = xgetbv(0);
+
+		/* Drop everything above SSE along with YMM, and restore it. */
+		GUEST_ASSERT(xcr0 & XFEATURE_MASK_YMM);
+		xsetbv(0, legacy);
+		GUEST_ASSERT_EQ(xgetbv(0), legacy);
+		xsetbv(0, xcr0);
+		GUEST_ASSERT_EQ(xgetbv(0), xcr0);
+
+		/* The same with a redundant REX.W prefix: one byte longer. */
+		asm volatile(".byte 0x48, 0x0f, 0x01, 0xd1" : :
+			     "a"((u32)legacy), "d"((u32)(legacy >> 32)), "c"(0));
+		GUEST_ASSERT_EQ(xgetbv(0), legacy);
+		xsetbv(0, xcr0);
+		GUEST_ASSERT_EQ(xgetbv(0), xcr0);
+
+		/* And through the emulator, which must not let it past. */
+		if (is_forced_emulation_enabled) {
+			asm volatile(KVM_FEP ".byte 0x0f, 0x01, 0xd1" : :
+				     "a"((u32)legacy), "d"((u32)(legacy >> 32)),
+				     "c"(0));
+			GUEST_ASSERT_EQ(xgetbv(0), legacy);
+			asm volatile(KVM_FEP ".byte 0x0f, 0x01, 0xd1" : :
+				     "a"((u32)xcr0), "d"((u32)(xcr0 >> 32)),
+				     "c"(0));
+			GUEST_ASSERT_EQ(xgetbv(0), xcr0);
+		}
+	}
+	GUEST_SYNC(7);
+
+	if (have_dt_filters) {
+		struct desc_ptr gdt = get_gdt();
+		struct desc_ptr idt = get_idt();
+
+		/* Reloading the same GDT is still a filtered load. */
+		lgdt(&gdt);
+		GUEST_ASSERT_EQ(get_gdt().address, gdt.address);
+
+		/* So is reloading the IDT. */
+		lidt(&idt);
+		GUEST_ASSERT_EQ(get_idt().address, idt.address);
+
+		/*
+		 * And the task register, whose TSS is busy: the load would
+		 * fault if KVM performed it.  Userspace leaves TR as it is
+		 * and KVM retires the instruction.
+		 */
+		ltr(get_tr());
+
+		/* A null LDT selector is architecturally fine. */
+		lldt(0);
+
+		/* Load refused by KVM: #GP(0), GDTR unchanged. */
+		vector = kvm_asm_safe(".byte 0x0f, 0x01, 0x10", "a"(&gdt),
+				      "m"(gdt));
+		GUEST_ASSERT_EQ(vector, GP_VECTOR);
+		GUEST_ASSERT_EQ(get_gdt().address, gdt.address);
+
+		/* Load refused by KVM with #UD. */
+		vector = kvm_asm_safe(".byte 0x0f, 0x01, 0x10", "a"(&gdt),
+				      "m"(gdt));
+		GUEST_ASSERT_EQ(vector, UD_VECTOR);
+		GUEST_ASSERT_EQ(get_gdt().address, gdt.address);
+
+		/* Load refused by userspace, with #NM. */
+		vector = kvm_asm_safe(".byte 0x0f, 0x01, 0x10", "a"(&gdt),
+				      "m"(gdt));
+		GUEST_ASSERT_EQ(vector, NM_VECTOR);
+		GUEST_ASSERT_EQ(get_gdt().address, gdt.address);
+	}
+	GUEST_SYNC(8);
+
+	/* The host single-steps this write. */
+	write_cr4(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT(get_cr4() & FILTERED_CR4_BIT);
+	write_cr4(get_cr4() & ~FILTERED_CR4_BIT);
+	GUEST_SYNC(9);
+
+	/*
+	 * The host injects an SMI here when SMM is available; the SMM
+	 * handler's filtered-bit writes must go through unfiltered, and
+	 * the filter must still work afterwards.
+	 */
+	GUEST_SYNC(10);
+	if (have_smm) {
+		GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+		write_cr4(get_cr4() | FILTERED_CR4_BIT);
+		GUEST_ASSERT(get_cr4() & FILTERED_CR4_BIT);
+		write_cr4(get_cr4() & ~FILTERED_CR4_BIT);
+	}
+	GUEST_SYNC(11);
+
+	/* The host has disarmed every filter: no exit, the writes land. */
+	write_cr4(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT(get_cr4() & FILTERED_CR4_BIT);
+	write_cr4(get_cr4() & ~FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	write_cr0(get_cr0() | X86_CR0_TS);
+	asm volatile("clts");
+	GUEST_ASSERT(!(get_cr0() & X86_CR0_TS));
+	if (have_dt_filters) {
+		struct desc_ptr gdt = get_gdt();
+		struct desc_ptr idt = get_idt();
+
+		lgdt(&gdt);
+		lidt(&idt);
+		lldt(0);
+	}
+	if (have_avx) {
+		u64 xcr0 = xgetbv(0);
+
+		xsetbv(0, XFEATURE_MASK_FP | XFEATURE_MASK_SSE);
+		xsetbv(0, xcr0);
+	}
+	GUEST_SYNC(12);
+
+	GUEST_DONE();
+}
+
+/*
+ * One round of filtered writes, over and over, for the host to check that
+ * each still exits after an event which resets the vCPU.  LTR of the busy
+ * TSS would fault if KVM performed it.
+ */
+static void reset_guest_code(void)
+{
+	struct desc_ptr gdt, idt, zero = {};
+
+	for (;;) {
+		gdt = get_gdt();
+		idt = get_idt();
+		GUEST_SYNC(1);
+		write_cr4(get_cr4() ^ FILTERED_CR4_BIT);
+		if (have_dt_filters) {
+			lgdt(&gdt);
+			lidt(&idt);
+			lldt(0);
+			ltr(get_tr());
+		}
+		GUEST_SYNC(2);
+		GUEST_SYNC(3);
+		if (READ_ONCE(crash)) {
+			/* No IDT: the #UD cannot be delivered, triple fault. */
+			lidt(&zero);
+			asm volatile("ud2");
+		}
+	}
+}
+
+static void init_sender_code(void)
+{
+	x2apic_enable();
+	/* INIT to APIC ID 0, physical destination. */
+	x2apic_write_reg(APIC_ICR, APIC_DM_INIT | APIC_INT_ASSERT);
+	GUEST_DONE();
+}
+
+static void sibling_guest_code(void)
+{
+	/* No filter on this vCPU: both writes must go straight through. */
+	set_cr4(get_cr4() | FILTERED_CR4_BIT);
+	GUEST_ASSERT(get_cr4() & FILTERED_CR4_BIT);
+	set_cr4(get_cr4() & ~FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	GUEST_DONE();
+}
+
+static void set_filter(struct kvm_vcpu *vcpu, u32 reg, u64 mask)
+{
+	struct kvm_x86_reg_write_filter filter = {
+		.reg = reg,
+		.mask = mask,
+	};
+
+	vcpu_ioctl(vcpu, KVM_X86_SET_REG_WRITE_FILTER, &filter);
+}
+
+static void expect_sync(struct kvm_vcpu *vcpu, u64 stage)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		TEST_ASSERT_EQ(uc.args[1], stage);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu, wanted sync %lu",
+			  uc.cmd, stage);
+	}
+}
+
+static void expect_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu, wanted done", uc.cmd);
+	}
+}
+
+/*
+ * Run the vCPU into a KVM_EXIT_X86_REG_WRITE on @reg made by an instruction
+ * of @insn_len bytes.  KVM must not have performed the write or moved RIP.
+ */
+static struct kvm_run *expect_reg_write(struct kvm_vcpu *vcpu, u32 reg,
+					u8 insn_len)
+{
+	static const u8 zeroes[sizeof(vcpu->run->reg_write.pad)];
+	struct kvm_run *run = vcpu->run;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_X86_REG_WRITE);
+	TEST_ASSERT_EQ(run->reg_write.reg, reg);
+	TEST_ASSERT_EQ(run->reg_write.insn_len, insn_len);
+	/* KVM hands over every exit as one which completes. */
+	TEST_ASSERT_EQ(run->reg_write.ret, KVM_INSN_COMPLETE);
+	TEST_ASSERT(!memcmp(run->reg_write.pad, zeroes, sizeof(zeroes)),
+		    "Reserved bytes of the exit are not zero");
+	return run;
+}
+
+/*
+ * Perform the write which the exit reports, as userspace must before it
+ * lets KVM_RUN retire the instruction.
+ */
+static void perform_reg_write(struct kvm_vcpu *vcpu)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_xcrs xcrs = {
+		.nr_xcrs = 1,
+		.xcrs[0].value = run->reg_write.new_value,
+	};
+	struct kvm_sregs sregs;
+
+	vcpu_sregs_get(vcpu, &sregs);
+
+	switch (run->reg_write.reg) {
+	case KVM_X86_REG_FILTER_CR0:
+		sregs.cr0 = run->reg_write.new_value;
+		break;
+	case KVM_X86_REG_FILTER_CR4:
+		sregs.cr4 = run->reg_write.new_value;
+		break;
+	case KVM_X86_REG_FILTER_XCR0:
+		vcpu_xcrs_set(vcpu, &xcrs);
+		return;
+	case KVM_X86_REG_FILTER_GDTR:
+		sregs.gdt.base = run->reg_write.new_value;
+		sregs.gdt.limit = run->reg_write.new_limit;
+		break;
+	case KVM_X86_REG_FILTER_IDTR:
+		sregs.idt.base = run->reg_write.new_value;
+		sregs.idt.limit = run->reg_write.new_limit;
+		break;
+	case KVM_X86_REG_FILTER_LDTR:
+		/* Only the null selector, which needs no descriptor. */
+		TEST_ASSERT_EQ(run->reg_write.new_value, 0);
+		memset(&sregs.ldt, 0, sizeof(sregs.ldt));
+		sregs.ldt.unusable = 1;
+		break;
+	default:
+		TEST_FAIL("Unexpected register class %u", run->reg_write.reg);
+	}
+
+	vcpu_sregs_set(vcpu, &sregs);
+}
+
+/* The write was performed: KVM_RUN retires the instruction. */
+static struct kvm_run *reg_write_performed(struct kvm_vcpu *vcpu, u32 reg,
+					   u8 insn_len)
+{
+	struct kvm_run *run = expect_reg_write(vcpu, reg, insn_len);
+
+	perform_reg_write(vcpu);
+	return run;
+}
+
+/*
+ * Say with @ret that the write does not complete, optionally queuing an
+ * exception for the guest to take at the instruction.
+ */
+static void leave_reg_write(struct kvm_vcpu *vcpu, u8 ret, int vector,
+			    bool has_ec)
+{
+	struct kvm_vcpu_events events;
+
+	vcpu->run->reg_write.ret = ret;
+	if (vector < 0)
+		return;
+
+	vcpu_events_get(vcpu, &events);
+	events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
+	events.exception.pending = 1;
+	events.exception.injected = 0;
+	events.exception.nr = vector;
+	events.exception.has_error_code = has_ec;
+	events.exception.error_code = 0;
+	events.exception_has_payload = 0;
+	vcpu_events_set(vcpu, &events);
+}
+
+/* Have KVM_RUN refuse a reserved answer: the write comes back as it was. */
+static void refuse_reg_write(struct kvm_vcpu *vcpu, u32 reg, u8 insn_len)
+{
+	struct kvm_regs regs;
+	u64 rip;
+
+	vcpu_regs_get(vcpu, &regs);
+	rip = regs.rip;
+	leave_reg_write(vcpu, KVM_INSN_RESUME + 1, -1, false);
+	TEST_ASSERT(__vcpu_run(vcpu) == -1 && errno == EINVAL,
+		    "KVM_RUN accepted a reserved 'ret'");
+	expect_reg_write(vcpu, reg, insn_len);
+	vcpu_regs_get(vcpu, &regs);
+	TEST_ASSERT_EQ(regs.rip, rip);
+}
+
+/*
+ * The guest makes the same filtered write three times, expecting #GP, #UD
+ * and #NM: the first two from KVM, the third queued by userspace with the
+ * write left alone, after KVM_RUN has refused a reserved answer.
+ */
+static void refuse_reg_writes(struct kvm_vcpu *vcpu, u32 reg, u8 insn_len,
+			      const char *what)
+{
+	expect_reg_write(vcpu, reg, insn_len);
+	leave_reg_write(vcpu, KVM_INSN_GP, -1, false);
+	expect_reg_write(vcpu, reg, insn_len);
+	leave_reg_write(vcpu, KVM_INSN_UD, -1, false);
+	expect_reg_write(vcpu, reg, insn_len);
+	refuse_reg_write(vcpu, reg, insn_len);
+	leave_reg_write(vcpu, KVM_INSN_RESUME, NM_VECTOR, false);
+	pr_info("%s: KVM_INSN_GP, KVM_INSN_UD, reserved, KVM_INSN_RESUME with #NM queued\n",
+		what);
+}
+
+static void test_bogus_args(struct kvm_vcpu *vcpu)
+{
+	struct kvm_x86_reg_write_filter filter = {};
+	int r;
+
+	/* Out of range register class. */
+	filter.reg = 0xffff;
+	filter.mask = ~0ULL;
+	r = __vcpu_ioctl(vcpu, KVM_X86_SET_REG_WRITE_FILTER, &filter);
+	TEST_ASSERT(r && errno == EINVAL, "Bogus reg: wanted EINVAL, got %d",
+		    r ? errno : 0);
+
+	/* Non-zero flags. */
+	filter.reg = KVM_X86_REG_FILTER_CR0;
+	filter.flags = 1;
+	filter.mask = X86_CR0_TS;
+	r = __vcpu_ioctl(vcpu, KVM_X86_SET_REG_WRITE_FILTER, &filter);
+	TEST_ASSERT(r && errno == EINVAL, "Bogus flags: wanted EINVAL, got %d",
+		    r ? errno : 0);
+	filter.flags = 0;
+
+	/* Non-zero reserved space. */
+	filter.reserved[3] = 1;
+	r = __vcpu_ioctl(vcpu, KVM_X86_SET_REG_WRITE_FILTER, &filter);
+	TEST_ASSERT(r && errno == EINVAL,
+		    "Bogus reserved: wanted EINVAL, got %d", r ? errno : 0);
+	filter.reserved[3] = 0;
+
+	/* CR0 bit 32 is reserved and can never change. */
+	filter.mask = BIT_ULL(32);
+	r = __vcpu_ioctl(vcpu, KVM_X86_SET_REG_WRITE_FILTER, &filter);
+	TEST_ASSERT(r && errno == EINVAL, "Bogus mask: wanted EINVAL, got %d",
+		    r ? errno : 0);
+
+	if (have_dt_filters) {
+		/* Descriptor-table filters take an all-ones mask only. */
+		filter.reg = KVM_X86_REG_FILTER_GDTR;
+		filter.mask = 1;
+		r = __vcpu_ioctl(vcpu, KVM_X86_SET_REG_WRITE_FILTER, &filter);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "Bogus GDTR mask: wanted EINVAL, got %d",
+			    r ? errno : 0);
+	}
+}
+
+/*
+ * Run the vCPU to the guest's sync @stop, performing the filtered writes on
+ * the way, except for TR, which stays as it is.  Returns the classes whose
+ * writes exited.
+ */
+static u32 run_to_sync(struct kvm_vcpu *vcpu, u64 stop)
+{
+	struct ucall uc;
+	u32 seen = 0;
+
+	for (;;) {
+		vcpu_run(vcpu);
+		if (vcpu->run->exit_reason == KVM_EXIT_X86_REG_WRITE) {
+			seen |= BIT(vcpu->run->reg_write.reg);
+			if (vcpu->run->reg_write.reg != KVM_X86_REG_FILTER_TR)
+				perform_reg_write(vcpu);
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			if (uc.args[1] == stop)
+				return seen;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+}
+
+/* One round of the guest's writes: every armed filter must still exit. */
+static void check_round(struct kvm_vcpu *vcpu, u32 armed, const char *when)
+{
+	u32 seen;
+
+	run_to_sync(vcpu, 1);
+	seen = run_to_sync(vcpu, 2);
+	run_to_sync(vcpu, 3);
+	TEST_ASSERT(seen == armed,
+		    "%s: writes of classes 0x%x exited, armed are 0x%x",
+		    when, seen, armed);
+	pr_info("%s: MOV to CR4%s still exit\n", when,
+		have_dt_filters ? ", LGDT, LIDT, LLDT, LTR" : "");
+}
+
+/*
+ * KVM_SET_CPUID2 recomputes the controls of a vCPU which has not run, and a
+ * reset leaves the filters armed: both have to leave the interception which
+ * the filters need in place.  Arm before KVM_SET_CPUID2, then reset with an
+ * INIT and with a triple fault, which on SVM clears the VMCB.  Userspace
+ * puts the register state back each time, as a VMM which resets a vCPU
+ * would.
+ */
+static void test_reset(void)
+{
+	u32 armed = BIT(KVM_X86_REG_FILTER_CR4);
+	struct kvm_vcpu *vcpu, *sender;
+	struct kvm_mp_state mp_state;
+	struct kvm_sregs sregs, now;
+	struct kvm_regs regs;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	vm = vm_create_with_one_vcpu(&vcpu, reset_guest_code);
+	sender = vm_vcpu_add(vm, 1, init_sender_code);
+	sync_global_to_guest(vm, have_dt_filters);
+
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR4, FILTERED_CR4_BIT);
+	if (have_dt_filters) {
+		set_filter(vcpu, KVM_X86_REG_FILTER_GDTR, ~0ULL);
+		set_filter(vcpu, KVM_X86_REG_FILTER_IDTR, ~0ULL);
+		set_filter(vcpu, KVM_X86_REG_FILTER_LDTR, ~0ULL);
+		set_filter(vcpu, KVM_X86_REG_FILTER_TR, ~0ULL);
+		armed |= BIT(KVM_X86_REG_FILTER_GDTR) |
+			 BIT(KVM_X86_REG_FILTER_IDTR) |
+			 BIT(KVM_X86_REG_FILTER_LDTR) |
+			 BIT(KVM_X86_REG_FILTER_TR);
+	}
+
+	/*
+	 * The vCPU has not run, so this is not the no-op which KVM makes of
+	 * KVM_SET_CPUID2 afterwards: the vendor code computes its controls
+	 * again, with the filters armed.
+	 */
+	vcpu_set_cpuid(vcpu);
+	check_round(vcpu, armed, "Armed, then KVM_SET_CPUID2 before the first run");
+
+	/* INIT, which KVM_GET_MP_STATE has the vCPU take. */
+	vcpu_regs_get(vcpu, &regs);
+	vcpu_sregs_get(vcpu, &sregs);
+	vcpu_run(sender);
+	TEST_ASSERT_KVM_EXIT_REASON(sender, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(get_ucall(sender, &uc), UCALL_DONE);
+	vcpu_mp_state_get(vcpu, &mp_state);
+	vcpu_sregs_get(vcpu, &now);
+	TEST_ASSERT(!now.cr4, "CR4 0x%llx after INIT: no reset", now.cr4);
+	mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+	vcpu_mp_state_set(vcpu, &mp_state);
+	vcpu_sregs_set(vcpu, &sregs);
+	vcpu_regs_set(vcpu, &regs);
+	check_round(vcpu, armed, "After INIT");
+
+	/* A triple fault.  The guest's LIDT is filtered on the way to it. */
+	vcpu_regs_get(vcpu, &regs);
+	vcpu_sregs_get(vcpu, &sregs);
+	crash = true;
+	sync_global_to_guest(vm, crash);
+	for (;;) {
+		vcpu_run(vcpu);
+		if (vcpu->run->exit_reason == KVM_EXIT_X86_REG_WRITE) {
+			TEST_ASSERT_EQ(vcpu->run->reg_write.reg,
+				       KVM_X86_REG_FILTER_IDTR);
+			perform_reg_write(vcpu);
+		} else if (vcpu->run->exit_reason == KVM_EXIT_IO) {
+			/* The guest's last sync, completed or repeated. */
+			TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+			TEST_ASSERT_EQ(uc.args[1], 3);
+		} else {
+			break;
+		}
+	}
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_SHUTDOWN);
+	crash = false;
+	sync_global_to_guest(vm, crash);
+	vcpu_mp_state_get(vcpu, &mp_state);
+	mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+	vcpu_mp_state_set(vcpu, &mp_state);
+	vcpu_sregs_set(vcpu, &sregs);
+	vcpu_regs_set(vcpu, &regs);
+	check_round(vcpu, armed, "After a triple fault");
+
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_guest_debug debug = {};
+	struct kvm_vcpu *vcpu, *sibling;
+	struct kvm_regs regs;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	u32 filters;
+	u64 rip;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_REG_WRITE_FILTER));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
+
+	filters = kvm_check_cap(KVM_CAP_X86_REG_WRITE_FILTER);
+	TEST_REQUIRE(filters & BIT(KVM_X86_REG_FILTER_CR0));
+	TEST_REQUIRE(filters & BIT(KVM_X86_REG_FILTER_CR4));
+	TEST_REQUIRE(filters & BIT(KVM_X86_REG_FILTER_XCR0));
+
+	have_avx = kvm_cpu_has(X86_FEATURE_AVX);
+	have_dt_filters = (filters & BIT(KVM_X86_REG_FILTER_GDTR)) &&
+			  (filters & BIT(KVM_X86_REG_FILTER_IDTR)) &&
+			  (filters & BIT(KVM_X86_REG_FILTER_LDTR)) &&
+			  (filters & BIT(KVM_X86_REG_FILTER_TR));
+	have_smm = kvm_has_cap(KVM_CAP_X86_SMM);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	sibling = vm_vcpu_add(vm, 1, sibling_guest_code);
+
+	/* To queue an exception as pending, as the refusing legs do. */
+	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, 1);
+
+	if (have_smm)
+		setup_smram(vm, vcpu, SMRAM_GPA, smi_handler,
+			    sizeof(smi_handler));
+
+	sync_global_to_guest(vm, have_avx);
+	sync_global_to_guest(vm, have_dt_filters);
+	sync_global_to_guest(vm, have_smm);
+
+	test_bogus_args(vcpu);
+
+	if (have_avx)
+		set_filter(vcpu, KVM_X86_REG_FILTER_XCR0, XFEATURE_MASK_YMM);
+	if (have_dt_filters) {
+		set_filter(vcpu, KVM_X86_REG_FILTER_GDTR, ~0ULL);
+		set_filter(vcpu, KVM_X86_REG_FILTER_IDTR, ~0ULL);
+		set_filter(vcpu, KVM_X86_REG_FILTER_LDTR, ~0ULL);
+		set_filter(vcpu, KVM_X86_REG_FILTER_TR, ~0ULL);
+	}
+
+	/*
+	 * Stage 0: arm the CR0 and CR4 filters on a vCPU which has run, and
+	 * whose guest has just set both bits behind KVM's back.  The exits
+	 * must report them as set, and the guest reads them so (it asserts).
+	 */
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(vcpu->run->io.port, ARM_PORT);
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR4, FILTERED_CR4_BIT);
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR0, X86_CR0_TS);
+	run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR0, CLTS_LEN);
+	TEST_ASSERT(run->reg_write.old_value & X86_CR0_TS,
+		    "CR0 0x%llx of the exit lacks the TS which the guest set before the filter",
+		    run->reg_write.old_value);
+	run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	TEST_ASSERT(run->reg_write.old_value & FILTERED_CR4_BIT,
+		    "CR4 0x%llx of the exit lacks the bit which the guest set before the filter",
+		    run->reg_write.old_value);
+	pr_info("CR0.TS and CR4 filters armed on a vCPU which has run: values kept, writes exit\n");
+
+	/* Stage 1: unfiltered-bit write, no reg_write exit. */
+	expect_sync(vcpu, 1);
+
+	/* Stage 2: filtered CR4 write, performed by userspace. */
+	run = expect_reg_write(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	TEST_ASSERT(!(run->reg_write.old_value & FILTERED_CR4_BIT),
+		    "Old CR4 value already has the filtered bit");
+	TEST_ASSERT(run->reg_write.new_value & FILTERED_CR4_BIT,
+		    "New CR4 value lacks the filtered bit");
+	perform_reg_write(vcpu);
+	expect_sync(vcpu, 2);
+
+	/*
+	 * Stage 3: left alone with nothing changed, the write runs again
+	 * and exits again, at the same RIP.
+	 */
+	run = expect_reg_write(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	TEST_ASSERT(run->reg_write.old_value & FILTERED_CR4_BIT,
+		    "Old CR4 value lacks the filtered bit");
+	vcpu_regs_get(vcpu, &regs);
+	rip = regs.rip;
+	leave_reg_write(vcpu, KVM_INSN_RESUME, -1, false);
+	expect_reg_write(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	vcpu_regs_get(vcpu, &regs);
+	TEST_ASSERT_EQ(regs.rip, rip);
+	perform_reg_write(vcpu);
+	expect_sync(vcpu, 3);
+	pr_info("MOV to CR4 (intercepted): KVM_INSN_RESUME alone\n");
+
+	/*
+	 * Stage 4: refused by KVM with #GP(0) and with #UD, then by
+	 * userspace with #NM queued.
+	 */
+	refuse_reg_writes(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN,
+			  "MOV to CR4 (intercepted)");
+	expect_sync(vcpu, 4);
+
+	/*
+	 * Stage 5: left alone with RIP moved past the write, which KVM
+	 * then neither performs nor retires again.
+	 */
+	run = expect_reg_write(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	leave_reg_write(vcpu, KVM_INSN_RESUME, -1, false);
+	vcpu_regs_get(vcpu, &regs);
+	regs.rip += run->reg_write.insn_len;
+	vcpu_regs_set(vcpu, &regs);
+	expect_sync(vcpu, 5);
+	pr_info("MOV to CR4 (intercepted): KVM_INSN_RESUME with RIP moved\n");
+
+	/* Stage 6: CR0.TS set by MOV, cleared by CLTS, set by LMSW. */
+	run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR0, MOV_TO_CR0_LEN);
+	TEST_ASSERT(run->reg_write.new_value & X86_CR0_TS,
+		    "New CR0 value lacks TS");
+	run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR0, CLTS_LEN);
+	TEST_ASSERT((run->reg_write.old_value & X86_CR0_TS) &&
+		    !(run->reg_write.new_value & X86_CR0_TS),
+		    "CLTS exit does not clear TS (old 0x%llx new 0x%llx)",
+		    run->reg_write.old_value, run->reg_write.new_value);
+	run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR0, LMSW_LEN);
+	TEST_ASSERT(run->reg_write.new_value & X86_CR0_TS,
+		    "LMSW exit does not set TS");
+	reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR0, CLTS_LEN);
+	expect_sync(vcpu, 6);
+
+	/* Stage 7: XSETBV, both directions. */
+	if (have_avx) {
+		run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_XCR0,
+					  XSETBV_LEN);
+		TEST_ASSERT(!(run->reg_write.new_value & XFEATURE_MASK_YMM),
+			    "New XCR0 value retains YMM");
+		reg_write_performed(vcpu, KVM_X86_REG_FILTER_XCR0, XSETBV_LEN);
+
+		/* A prefix makes the instruction longer, and KVM says so. */
+		reg_write_performed(vcpu, KVM_X86_REG_FILTER_XCR0,
+				    REX_XSETBV_LEN);
+		reg_write_performed(vcpu, KVM_X86_REG_FILTER_XCR0, XSETBV_LEN);
+		pr_info("XSETBV (intercepted): performed, also with a REX prefix\n");
+
+		if (is_forced_emulation_enabled) {
+			reg_write_performed(vcpu, KVM_X86_REG_FILTER_XCR0,
+					    XSETBV_LEN);
+			reg_write_performed(vcpu, KVM_X86_REG_FILTER_XCR0,
+					    XSETBV_LEN);
+			pr_info("XSETBV (forced emulation): performed\n");
+		} else {
+			pr_info("XSETBV (forced emulation): not run, set kvm.force_emulation_prefix=1\n");
+		}
+	} else {
+		pr_info("XSETBV: not run, no AVX to take away\n");
+	}
+	expect_sync(vcpu, 7);
+
+	/* Stage 8: descriptor tables. */
+	if (have_dt_filters) {
+		/*
+		 * LGDT reaches KVM through the emulator, which then retires
+		 * it.  Single-step across that one too.
+		 */
+		run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_GDTR,
+					  LGDT_LEN);
+		TEST_ASSERT_EQ(run->reg_write.new_value,
+			       run->reg_write.old_value);
+		TEST_ASSERT_EQ(run->reg_write.new_limit,
+			       run->reg_write.old_limit);
+		vcpu_regs_get(vcpu, &regs);
+		rip = regs.rip;
+		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+		vcpu_guest_debug_set(vcpu, &debug);
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_DEBUG);
+		TEST_ASSERT_EQ(vcpu->run->debug.arch.pc, rip + LGDT_LEN);
+		debug.control = 0;
+		vcpu_guest_debug_set(vcpu, &debug);
+		run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_IDTR,
+					  LIDT_LEN);
+		TEST_ASSERT_EQ(run->reg_write.new_value,
+			       run->reg_write.old_value);
+		TEST_ASSERT_EQ(run->reg_write.new_limit,
+			       run->reg_write.old_limit);
+		/* TR stays as it is: userspace performs nothing. */
+		run = expect_reg_write(vcpu, KVM_X86_REG_FILTER_TR, LTR_LEN);
+		TEST_ASSERT_EQ(run->reg_write.new_value,
+			       run->reg_write.old_value);
+		run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_LDTR,
+					  LLDT_LEN);
+		TEST_ASSERT_EQ(run->reg_write.new_value, 0);
+		pr_info("LGDT, LIDT, LTR, LLDT (emulated): performed\n");
+		/* The same refusals from the emulator's completion. */
+		refuse_reg_writes(vcpu, KVM_X86_REG_FILTER_GDTR, LGDT_LEN,
+				  "LGDT (emulated)");
+	} else {
+		pr_info("LGDT (emulated): not run, no descriptor-table filters\n");
+	}
+	expect_sync(vcpu, 8);
+
+	/*
+	 * Stage 9: single-step across a performed write.  The step is
+	 * reported once the instruction has retired, at the next one.
+	 */
+	expect_reg_write(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	vcpu_regs_get(vcpu, &regs);
+	rip = regs.rip;
+	perform_reg_write(vcpu);
+	debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+	vcpu_guest_debug_set(vcpu, &debug);
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_DEBUG);
+	TEST_ASSERT_EQ(vcpu->run->debug.arch.pc, rip + MOV_TO_CR4_LEN);
+	debug.control = 0;
+	vcpu_guest_debug_set(vcpu, &debug);
+	reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR4, MOV_TO_CR4_LEN);
+	expect_sync(vcpu, 9);
+
+	/*
+	 * Stage 10: the SMM handler sets and clears the filtered CR4 bit
+	 * with no filter exit; the first exit after RSM is the guest's own
+	 * filtered write, with the full (non-SMM) CR4 as the old value.
+	 */
+	expect_sync(vcpu, 10);
+	if (have_smm) {
+		struct kvm_vcpu_events events;
+
+		/* The handler says that it runs, in SMM. */
+		inject_smi(vcpu);
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+		TEST_ASSERT_EQ(vcpu->run->io.port, SMM_PORT);
+		vcpu_events_get(vcpu, &events);
+		TEST_ASSERT(events.smi.smm, "The SMI handler runs outside SMM");
+
+		run = reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR4,
+					  MOV_TO_CR4_LEN);
+		TEST_ASSERT(run->reg_write.old_value &&
+			    !(run->reg_write.old_value & FILTERED_CR4_BIT),
+			    "Unexpected old CR4 0x%llx: SMM write filtered?",
+			    run->reg_write.old_value);
+		TEST_ASSERT(run->reg_write.new_value & FILTERED_CR4_BIT,
+			    "New CR4 value lacks the filtered bit");
+		reg_write_performed(vcpu, KVM_X86_REG_FILTER_CR4,
+				    MOV_TO_CR4_LEN);
+	}
+	expect_sync(vcpu, 11);
+	pr_info("SMM: %s\n", have_smm ? "the handler ran, its CR4 writes took no exit" :
+				       "not run, no KVM_CAP_X86_SMM");
+
+	/*
+	 * The sibling vCPU has no filters and must run straight through,
+	 * while this vCPU's are all still armed.
+	 */
+	expect_done(sibling);
+
+	/* Stage 12: disarmed, the same writes take no exit. */
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR4, 0);
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR0, 0);
+	if (have_avx)
+		set_filter(vcpu, KVM_X86_REG_FILTER_XCR0, 0);
+	if (have_dt_filters) {
+		set_filter(vcpu, KVM_X86_REG_FILTER_GDTR, 0);
+		set_filter(vcpu, KVM_X86_REG_FILTER_IDTR, 0);
+		set_filter(vcpu, KVM_X86_REG_FILTER_LDTR, 0);
+		set_filter(vcpu, KVM_X86_REG_FILTER_TR, 0);
+	}
+	expect_sync(vcpu, 12);
+	pr_info("MOV to CR4, MOV to CR0, CLTS%s%s: no exit once the filters are disarmed\n",
+		have_avx ? ", XSETBV" : "",
+		have_dt_filters ? ", LGDT, LIDT, LLDT" : "");
+
+	expect_done(vcpu);
+
+	kvm_vm_free(vm);
+
+	test_reset();
+	return 0;
+}
-- 
2.50.1

