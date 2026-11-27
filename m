Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=3SYv2Xo7oODs/QeVabh6y29nzqQnf7mcrE0okQaTrf/Ci20MBeRfQemVTcf1qUvpA+Nx
	 D1IDT0DSspfm4T9PzWAk4maU1T5NyEObrTkmlMGyKTaPG0PqAc8qiBvtUJeA0EWl0maIq
	 uaA/i82/9knWZqL0ga07ef35ABVArcqwY7693i2DI9sIN3/wiuBWUZc9sRd1uS0fwXDm1
	 bHqnHXHk/hBLJu7nqNoIUTx/fkcyDUYrgHegbw0K7YPFrTTm9iRgxR01Oy5MITBB0/lWe
	 DdYFp47oFXvFmFVx6g7lMRf0NV1H1W04ceaqZf7nxoZgtRKnDxTKisKv634pCF5jEng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=Q1rk+MWwvc7Fve/JWR2vpL2/QQrE9g6zzvFUkXszEaM=;
	b=BtcXCKPgUWMu3MhixDw6P3yP9OENyO03kutfIIpRsiPoO8Jrht6OU3uF/3LhBiX+YhE8
	 P6SUzk/T91DJ4AAjRVGMBfa1k79JOqkq3ENd5pik6C1GPqggM3YpAbiR3OwgXAijb0mBm
	 nNBcxPLmpqQOOlBdE/fQB4Ck2Hf112uqZ7AXF8zkT2fn71dc2wsMee8E0FKPJJecJVXm3
	 AvwHJBXWDMk5XmtUwQLyWZazE+CLUSmFVUv38j9JP6BlrJnC/RXlSbem7w+jd5TZRtMAV
	 JJN4QJc2f9eUkYoSXDBcwHBsfr+tq+MECJJcpBKy3LyFjg5RFgMwAPUtHy2b+axBy9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="XsQD/hLy";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE1760A261C;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE1760A261C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=XsQD/hLy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Q1rk+MWwvc7Fve/JWR2vpL2/QQrE9g6zzvFUkXszEaM=; b=XsQD/hLyWGGaa08xzMs7qg2gh5
	wu/Vt8mW6NB+WFAiKXtrMABY0fEjpfu09E0f3wMzeNMzb8FZMKG92OsXb7flB6CrLxIg2hcLm8v4Y
	JJQksRHXNzTS9L/npyxOx+cGMNeer7An3kD5XXZrIIGEazqsCy4n+w/QnuWRRSDjC46ze1CwjnHfp
	Pg9J93bmBbDtjrgSf3zy/NLGmUT4I0jphuWtlL+QjrBEvL88i+4Y5cWj/wtRF/YCuBDGjgQCbC4lg
	xTOrgBEqqEsFI0wl7D6XWfEF8gnYhpHvxTAnN7OD43q+UHwvY1rAe6PVRyaNRpgiLLe+1XdsbsZPP
	UPfE89HQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkr-2EDH;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pr0-3ccl;
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
Subject: [PATCH v3 15/15] KVM: selftests: Test the register write filter with a nested guest
Date: Fri, 27 Nov 2026 15:27:30 +0000
Message-ID: <20261127152730.99319-16-dwmw2@infradead.org>
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

L1 and L2 share XCR0.  Check that an XSETBV which KVM performs for L2
is filtered (SVM only), that one which exits to L1 is not, and that
filtered CR0 and CR4 bits which L2 writes are not.  On VMX, check that
a CR4 bit filtered for L1 stays L2's to own across a VMRESUME for which
KVM recomputes nothing: the test resumes L2 itself, as the library's
helper writes host state fields before every entry.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/nested_reg_write_filter_test.c    | 362 ++++++++++++++++++
 2 files changed, 363 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 6fcf54f58c48..5b4bc0ec37ad 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -104,6 +104,7 @@ TEST_GEN_PROGS_x86 += x86/nested_dirty_log_test
 TEST_GEN_PROGS_x86 += x86/nested_emulation_test
 TEST_GEN_PROGS_x86 += x86/nested_exceptions_test
 TEST_GEN_PROGS_x86 += x86/nested_invalid_cr3_test
+TEST_GEN_PROGS_x86 += x86/nested_reg_write_filter_test
 TEST_GEN_PROGS_x86 += x86/nested_set_state_test
 TEST_GEN_PROGS_x86 += x86/nested_tdp_fault_test
 TEST_GEN_PROGS_x86 += x86/nested_tsc_adjust_test
diff --git a/tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c b/tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c
new file mode 100644
index 000000000000..4977b3d5f64b
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c
@@ -0,0 +1,362 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test the register write filters of a vCPU which runs a nested guest.
+ *
+ * XCR0 is shared by L1 and L2, so an XSETBV which KVM performs for L2 must
+ * be filtered like L1's own.  On AMD CPUs L1 chooses whether to intercept
+ * XSETBV: without the intercept the write takes KVM_EXIT_X86_REG_WRITE with
+ * the vCPU in guest mode, with it the exit is L1's and userspace sees
+ * nothing.  On Intel CPUs XSETBV in L2 always exits to L1, so only the
+ * XSETBV which L1 then executes itself is filtered.
+ *
+ * CR0 and CR4 writes of L2 are not filtered: they change L2's registers.
+ * L2 writes a filtered CR0 bit and a filtered CR4 bit which KVM intercepts
+ * (on Intel CPUs, bits which KVM does not let a guest own), and neither
+ * write may exit to userspace.
+ *
+ * On Intel CPUs a CR4 filter takes the filtered bits away from L1 in
+ * vmcs01, and must not take them away from L2 as well: a bit which L2 owns
+ * and changes after a VMRESUME has to show in vmcs12.  That takes a
+ * VMRESUME for which KVM has nothing to recompute, i.e. one before which
+ * L1 wrote none but the fields a shadow VMCS would let it write.  The
+ * library's vmresume() writes HOST_RSP and HOST_RIP every time, so this
+ * test resumes L2 twice from one stack frame by itself.
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "svm_util.h"
+#include "vmx.h"
+
+#define LEGACY			(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)
+#define FILTERED_CR4_BIT	X86_CR4_TSD
+/* Bits which KVM never lets a guest own: a write to them always exits. */
+#define INTERCEPTED_CR4_BIT	X86_CR4_MCE
+#define INTERCEPTED_CR0_BIT	X86_CR0_MP
+#define XSETBV_LEN		3
+
+enum {
+	STAGE_READY = 1,
+	STAGE_L2_XSETBV,
+	STAGE_L1_XSETBV,
+	STAGE_L2_CR4,
+};
+
+static void l2_svm_code(void)
+{
+	xsetbv(0, LEGACY);
+
+	/* KVM intercepts both for a vCPU with a CR0 filter armed. */
+	set_cr0(get_cr0() ^ INTERCEPTED_CR0_BIT);
+	set_cr4(get_cr4() | FILTERED_CR4_BIT);
+	vmmcall();
+}
+
+static void l1_svm_code(struct svm_test_data *svm)
+{
+	struct vmcb *vmcb = svm->vmcb;
+	u64 xcr0 = xgetbv(0);
+
+	GUEST_ASSERT(xcr0 & XFEATURE_MASK_YMM);
+	GUEST_SYNC(STAGE_READY);
+
+	/* L1 leaves XSETBV to L0, which performs it for L2. */
+	generic_svm_setup(svm, l2_svm_code);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_VMMCALL);
+	/* L2 started with L1's CR0 and CR4, and its writes took effect. */
+	GUEST_ASSERT((vmcb->save.cr0 ^ get_cr0()) & INTERCEPTED_CR0_BIT);
+	GUEST_ASSERT(vmcb->save.cr4 & FILTERED_CR4_BIT);
+	GUEST_ASSERT(!(get_cr4() & FILTERED_CR4_BIT));
+	GUEST_SYNC_ARGS(STAGE_L2_XSETBV, xgetbv(0), 0, 0, 0);
+
+	/* Userspace has put XCR0 back.  Now L1 intercepts XSETBV. */
+	GUEST_ASSERT_EQ(xgetbv(0), xcr0);
+	generic_svm_setup(svm, l2_svm_code);
+	vmcb->control.intercept |= BIT_ULL(INTERCEPT_XSETBV);
+	run_guest(vmcb, svm->vmcb_gpa);
+	GUEST_ASSERT_EQ(vmcb->control.exit_code, SVM_EXIT_XSETBV);
+	GUEST_SYNC_ARGS(STAGE_L1_XSETBV, xgetbv(0), 0, 0, 0);
+	GUEST_DONE();
+}
+
+static void l2_vmx_code(void)
+{
+	xsetbv(0, LEGACY);
+	vmcall();
+
+	/* Out to L1 once more, which resumes L2 with vmcs12 as it is. */
+	vmcall();
+
+	/* So L2 still owns this bit, and sets it without an exit. */
+	set_cr4(get_cr4() | FILTERED_CR4_BIT);
+
+	/* These two exit to KVM, which must not filter them. */
+	set_cr4(get_cr4() | INTERCEPTED_CR4_BIT);
+	set_cr0(get_cr0() ^ INTERCEPTED_CR0_BIT);
+	vmcall();
+}
+
+/* How often resume_twice() has come back from L2. */
+static u64 nr_resumed;
+
+/*
+ * Resume L2, step over the VMCALL it exits with, and resume it again having
+ * written nothing to the VMCS but GUEST_RIP.  Both VM-exits land on the
+ * same label with the same stack pointer, so HOST_RSP and HOST_RIP are
+ * written once, before the first VMRESUME.  Returns non-zero if a VMRESUME
+ * failed.
+ */
+static noinline u64 resume_twice(void)
+{
+	u64 failed;
+
+	nr_resumed = 0;
+	asm volatile("push %%rbp\n\t"
+		     "mov %[host_rsp], %%eax\n\t"
+		     "vmwrite %%rsp, %%rax\n\t"
+		     "lea 1f(%%rip), %%rbx\n\t"
+		     "mov %[host_rip], %%eax\n\t"
+		     "vmwrite %%rbx, %%rax\n\t"
+		     "vmresume\n\t"
+		     "jmp 3f\n\t"
+		     "1: incq %[nr]\n\t"
+		     "cmpq $1, %[nr]\n\t"
+		     "jne 2f\n\t"
+		     "mov %[insn_len], %%eax\n\t"
+		     "vmread %%rax, %%rcx\n\t"
+		     "mov %[guest_rip], %%eax\n\t"
+		     "vmread %%rax, %%rdx\n\t"
+		     "add %%rcx, %%rdx\n\t"
+		     "vmwrite %%rdx, %%rax\n\t"
+		     "vmresume\n\t"
+		     "jmp 3f\n\t"
+		     "2: xor %%eax, %%eax\n\t"
+		     "jmp 4f\n\t"
+		     "3: mov $1, %%eax\n\t"
+		     "4: pop %%rbp\n\t"
+		     : "=&a"(failed), [nr] "+m"(nr_resumed)
+		     : [host_rsp] "i"(HOST_RSP), [host_rip] "i"(HOST_RIP),
+		       [insn_len] "i"(VM_EXIT_INSTRUCTION_LEN),
+		       [guest_rip] "i"(GUEST_RIP)
+		     : "cc", "memory", "rbx", "rcx", "rdx", "rsi", "rdi",
+		     "r8", "r9", "r10", "r11", "r12", "r13", "r14", "r15");
+	return failed;
+}
+
+static void l1_vmx_code(struct vmx_pages *vmx)
+{
+	u64 xcr0 = xgetbv(0);
+
+	GUEST_ASSERT(xcr0 & XFEATURE_MASK_YMM);
+	prepare_for_vmx_operation(vmx);
+	load_vmcs(vmx);
+	prepare_vmcs(vmx, l2_vmx_code);
+	GUEST_ASSERT(!(vmread(GUEST_CR4) & FILTERED_CR4_BIT));
+	GUEST_ASSERT(!(vmread(CR4_GUEST_HOST_MASK) & FILTERED_CR4_BIT));
+	GUEST_SYNC(STAGE_READY);
+
+	/* XSETBV in L2 exits to L1, whatever L1 asked for. */
+	vmlaunch();
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_XSETBV);
+	GUEST_SYNC_ARGS(STAGE_L2_XSETBV, xgetbv(0), 0, 0, 0);
+
+	/* L1 makes the write for L2, as a hypervisor would: L1's own. */
+	xsetbv(0, LEGACY);
+	GUEST_SYNC_ARGS(STAGE_L1_XSETBV, xgetbv(0), 0, 0, 0);
+
+	/* Skip L2's XSETBV, and the VMCALL after it. */
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
+	vmresume();
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	vmwrite(GUEST_RIP, vmread(GUEST_RIP) + vmread(VM_EXIT_INSTRUCTION_LEN));
+
+	/*
+	 * The first VMRESUME below recomputes everything for vmcs02, the
+	 * second nothing.  After it L2 sets the CR4 bit which is filtered
+	 * for L1, without an exit: it is L2's to own, and vmcs12 must
+	 * show it.
+	 */
+	GUEST_ASSERT(!resume_twice());
+	GUEST_ASSERT_EQ(nr_resumed, 2);
+	GUEST_ASSERT_EQ(vmread(VM_EXIT_REASON), EXIT_REASON_VMCALL);
+	GUEST_ASSERT(vmread(GUEST_CR4) & INTERCEPTED_CR4_BIT);
+	GUEST_ASSERT((vmread(GUEST_CR0) ^ get_cr0()) & INTERCEPTED_CR0_BIT);
+	GUEST_SYNC_ARGS(STAGE_L2_CR4, vmread(GUEST_CR4), 0, 0, 0);
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
+static void set_xcr0(struct kvm_vcpu *vcpu, u64 xcr0)
+{
+	struct kvm_xcrs xcrs = {
+		.nr_xcrs = 1,
+		.xcrs[0].value = xcr0,
+	};
+
+	vcpu_xcrs_set(vcpu, &xcrs);
+}
+
+/*
+ * Run to the guest's next sync, performing every filtered XCR0 write on the
+ * way.  Returns the value the guest reported; counts the exits, and those
+ * of them which were taken in guest mode.
+ */
+static u64 run_to_sync(struct kvm_vcpu *vcpu, u64 stage, int *exits,
+		       int *nested_exits)
+{
+	struct kvm_run *run = vcpu->run;
+	struct ucall uc;
+
+	*exits = 0;
+	*nested_exits = 0;
+
+	for (;;) {
+		vcpu_run(vcpu);
+		if (run->exit_reason == KVM_EXIT_X86_REG_WRITE) {
+			TEST_ASSERT_EQ(run->reg_write.reg, KVM_X86_REG_FILTER_XCR0);
+			TEST_ASSERT_EQ(run->reg_write.new_value, LEGACY);
+			TEST_ASSERT_EQ(run->reg_write.insn_len, XSETBV_LEN);
+			set_xcr0(vcpu, run->reg_write.new_value);
+			(*exits)++;
+			if (run->flags & KVM_RUN_X86_GUEST_MODE)
+				(*nested_exits)++;
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], stage);
+			return uc.args[2];
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu, wanted sync %lu",
+				  uc.cmd, stage);
+		}
+	}
+}
+
+static void expect_done(struct kvm_vcpu *vcpu)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_DONE);
+}
+
+static void test_svm(struct kvm_vcpu *vcpu, u64 full)
+{
+	int exits, nested;
+	u64 xcr0;
+
+	xcr0 = run_to_sync(vcpu, STAGE_L2_XSETBV, &exits, &nested);
+	TEST_ASSERT(exits == 1 && nested == 1,
+		    "XSETBV in L2, not intercepted by L1: %d filter exits, %d in guest mode, wanted one of each (XCR0 0x%lx)",
+		    exits, nested, xcr0);
+	TEST_ASSERT_EQ(xcr0, LEGACY);
+	pr_info("SVM, XSETBV in L2 which L1 does not intercept: filtered, in guest mode\n");
+	pr_info("SVM, filtered CR0 and CR4 bits written by L2, intercepted by KVM: not filtered\n");
+
+	/* Put XCR0 back from userspace: a state load, not filtered. */
+	set_xcr0(vcpu, full);
+
+	xcr0 = run_to_sync(vcpu, STAGE_L1_XSETBV, &exits, &nested);
+	TEST_ASSERT(!exits, "XSETBV in L2, intercepted by L1: %d filter exits",
+		    exits);
+	TEST_ASSERT_EQ(xcr0, full);
+	pr_info("SVM, XSETBV in L2 which L1 intercepts: L1's exit, not filtered\n");
+}
+
+static void test_vmx(struct kvm_vcpu *vcpu, u64 full)
+{
+	int exits, nested;
+	u64 val;
+
+	val = run_to_sync(vcpu, STAGE_L2_XSETBV, &exits, &nested);
+	TEST_ASSERT(!exits, "XSETBV in L2: %d filter exits before L1's own",
+		    exits);
+	TEST_ASSERT_EQ(val, full);
+	pr_info("VMX, XSETBV in L2: always L1's exit, not filtered\n");
+
+	val = run_to_sync(vcpu, STAGE_L1_XSETBV, &exits, &nested);
+	TEST_ASSERT(exits == 1 && !nested,
+		    "XSETBV by L1 for L2: %d filter exits, %d in guest mode, wanted one outside it",
+		    exits, nested);
+	TEST_ASSERT_EQ(val, LEGACY);
+	pr_info("VMX, XSETBV which L1 executes for L2: filtered\n");
+
+	val = run_to_sync(vcpu, STAGE_L2_CR4, &exits, &nested);
+	TEST_ASSERT(!exits, "CR4 write in L2: %d filter exits", exits);
+	TEST_ASSERT(val & FILTERED_CR4_BIT,
+		    "vmcs12 guest CR4 0x%lx lacks the bit L2 set after a VMRESUME with nothing to recompute",
+		    val);
+	pr_info("VMX, CR4 bit filtered for L1 and owned by L2: unfiltered, and in vmcs12 after a VMRESUME with nothing to recompute\n");
+	pr_info("VMX, filtered CR0 and CR4 bits written by L2, intercepted by KVM: not filtered\n");
+}
+
+int main(int argc, char *argv[])
+{
+	bool svm = kvm_cpu_has(X86_FEATURE_SVM);
+	struct kvm_xcrs xcrs = {};
+	struct kvm_vcpu *vcpu;
+	gva_t nested_gva = 0;
+	int exits, nested;
+	struct kvm_vm *vm;
+	u32 filters;
+	u64 full;
+
+	TEST_REQUIRE(svm || kvm_cpu_has(X86_FEATURE_VMX));
+	TEST_REQUIRE(kvm_cpu_has(X86_FEATURE_AVX));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_REG_WRITE_FILTER));
+
+	filters = kvm_check_cap(KVM_CAP_X86_REG_WRITE_FILTER);
+	TEST_REQUIRE(filters & BIT(KVM_X86_REG_FILTER_XCR0));
+	TEST_REQUIRE(filters & BIT(KVM_X86_REG_FILTER_CR0));
+	TEST_REQUIRE(filters & BIT(KVM_X86_REG_FILTER_CR4));
+
+	vm = vm_create_with_one_vcpu(&vcpu, svm ? (void *)l1_svm_code :
+						   (void *)l1_vmx_code);
+	if (svm)
+		vcpu_alloc_svm(vm, &nested_gva);
+	else
+		vcpu_alloc_vmx(vm, &nested_gva);
+	vcpu_args_set(vcpu, 1, nested_gva);
+
+	/* L1 gets ready with nothing filtered; then arm. */
+	run_to_sync(vcpu, STAGE_READY, &exits, &nested);
+	TEST_ASSERT_EQ(exits, 0);
+	vcpu_xcrs_get(vcpu, &xcrs);
+	full = xcrs.xcrs[0].value;
+	set_filter(vcpu, KVM_X86_REG_FILTER_XCR0, XFEATURE_MASK_YMM);
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR0, INTERCEPTED_CR0_BIT);
+	set_filter(vcpu, KVM_X86_REG_FILTER_CR4,
+		   FILTERED_CR4_BIT | INTERCEPTED_CR4_BIT);
+
+	if (svm) {
+		test_svm(vcpu, full);
+		pr_info("VMX legs: not run, this is an AMD CPU\n");
+	} else {
+		test_vmx(vcpu, full);
+		pr_info("SVM legs: not run, this is an Intel CPU\n");
+	}
+
+	expect_done(vcpu);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

