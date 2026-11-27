Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=EfCtTFhxKBaBg2qYaEpX5uWPtr6L7lf0jfvL4rXfcP2IshlctTctxaadzGZxP3Q8kpRO
	 Gt4c6wsMizh7tP2FM180U/EYoQLXdM/YNTkbItYHeHM061XFd0vCeTck6B6TwtHKSZz8n
	 I8NeYm2rJSXtUDW+lk47IzmLWkikdR6ndVpjPWBRyb5SRfHmQKt7iIL07bqkyjzn4vrcC
	 u0OEH6TQSAt6QhvQCUn2r4fk1K/avHU++40PtpuMesrfR3S+pmSajMQd1HsLElulCau/9
	 sDElM21Qe0ShOnEENP0/RcVK3rZWfITXiKDeCo0X0UoxKwvwyXKIezLMowpoJ546CWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=V8f0Q6TbV7LbEpEvqhhk+84xLRLCblFP1gkUjWxyXtk=;
	b=PnKyFvAUMNdK0WzRLBTpnns9YHG+/CS+QLdHGT8eK7UK2SDhaS74B0jJptDnQgVLRaJU
	 7qTY52Zlfp3bHZAZYcEytjDLq+lfMJJop5B0mhNIYHWZ7o0hKkubaCm4VXhv17l/1kPTp
	 hiSLkE0s5NPb70faw8N3zb+xLyVLOF7IkJ8lCLM/Fg1XPD2J15N9m5AYXpYvDP013XauK
	 Wzn9D/272lYA4M6oL/YbmL7lwQE6mY5T4xVUyua+C6eYpJ1D7MLsUu8OAvffZFysE0fSw
	 kDcY3a6kHbdFqw45krs5katrk2oa79gbYtzvHEmlAHoEBRk6r430BV8ro3tUzeU0JVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FORv+Qzm;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF1F606A327;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF1F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=FORv+Qzm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=V8f0Q6TbV7LbEpEvqhhk+84xLRLCblFP1gkUjWxyXtk=; b=FORv+QzmIEWIulOlnG9e9oMjXE
	fnXpPyUw5RSLbohTtYurzBUjlh0SEWQGtRNOzEGAoBC1KNSAFxEN2ErYN5/snP6CUCZ/axjtE3rKM
	8z64JrvZ+MipsF+oX3B/1GfbdQuf6ovQOx4C8894GlbdMz7Ic/JsSyARQQUzaEYQTl63KaZZ79yDn
	8ZrW3hg3K82BBBR3MaPw1pTXQIQf3HQEQFaHWjbAdH9yUNZ3GEB7O626QowLp8gV06CmSuh1Yefxg
	yQA8jw/NrKzOHPg9JZeOKn4lQn3fbTdcI3lMgid8hlDIweiO+BR6CoHFlOHL5wn3RhI2od+/CTDHe
	Ghl4WbTw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy2t-3L6I;
	Fri, 27 Nov 2026 15:27:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000PqW-2WJs;
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
Subject: [PATCH v3 08/15] KVM: selftests: Add Hyper-V hypercall forwarding test
Date: Fri, 27 Nov 2026 15:27:23 +0000
Message-ID: <20261127152730.99319-9-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Cover KVM_CAP_HYPERV_FORWARD_HCALL: the feature mask; an unknown
hypercall forwarded in memory-based and fast form, and an extended one
in fast form, with the full 64-bit result and the XMM output from
userspace; and 'ret', which is ignored until enabled, raises #UD or #GP,
lets a queued #NM be taken at the hypercall, re-executes it with nothing
queued, and fails KVM_RUN when reserved, leaving RAX alone each time.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 395 ++++++++++++++++++
 2 files changed, 396 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index f0cb8cf748dd..2f67399ddd68 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_cpuid
 TEST_GEN_PROGS_x86 += x86/hyperv_evmcs
 TEST_GEN_PROGS_x86 += x86/hyperv_extended_hypercalls
 TEST_GEN_PROGS_x86 += x86/hyperv_features
+TEST_GEN_PROGS_x86 += x86/hyperv_forward_hcall
 TEST_GEN_PROGS_x86 += x86/hyperv_ipi
 TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
diff --git a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
new file mode 100644
index 000000000000..739cdc4c9cf4
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_CAP_HYPERV_FORWARD_HCALL: the feature mask KVM reports and
+ * accepts, Hyper-V hypercalls that KVM does not implement exiting to
+ * userspace in memory-based and fast form, with userspace supplying the
+ * result and the XMM output, an extended hypercall exiting in fast form,
+ * and userspace leaving a hypercall uncompleted through the exit's 'ret'
+ * field: with KVM_INSN_UD and KVM_INSN_GP, so that KVM raises the
+ * exception; with KVM_INSN_RESUME alone, so that the guest re-executes the
+ * hypercall; with KVM_INSN_RESUME and a #NM queued through
+ * KVM_SET_VCPU_EVENTS, so that the hypercall takes that instead; and with
+ * a reserved value, which KVM_RUN refuses.  A hypercall which is left
+ * uncompleted leaves RAX alone.
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+
+/* A hypercall code KVM does not implement (HvCallGetVpRegisters). */
+#define HVCALL_TEST_CODE	HVCALL_GET_VP_REGISTERS
+
+#define FAST_PARAM0		0x1122334455667788ULL
+#define FAST_PARAM1		0x99aabbccddeeff00ULL
+#define XMM_IN_MARKER		0x5157ca11c0ffee00ULL
+#define XMM_OUT_MARKER		0x0de1ba5eba5eba11ULL
+#define USERSPACE_STATUS	0x55AA
+/* Written with a hypercall which is left uncompleted: must never arrive. */
+#define POISON_STATUS		0xDEAD
+/* What __hyperv_hypercall() loads into EAX, where the result would go. */
+#define UNWRITTEN_STATUS	((u32)-EFAULT)
+#define FULL_RESULT		(BIT_ULL(63) | USERSPACE_STATUS)
+
+enum {
+	STAGE_DISABLED = 1,
+	STAGE_MEMORY,
+	STAGE_FAST,
+	STAGE_EXT_FAST,
+	STAGE_RESULT_FULL,
+	STAGE_RET_UD,
+	STAGE_RET_GP,
+	STAGE_RET_QUEUED,
+	STAGE_RET_RETRY,
+	STAGE_AFTER_RET,
+	STAGE_REDISABLED,
+};
+
+static void guest_code(gpa_t pgs_gpa)
+{
+	__sse128_u in, out;
+	u64 status;
+	u8 vector;
+
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
+
+	/* Nothing enabled: KVM fails the call itself. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status & 0xffff, HV_STATUS_INVALID_HYPERCALL_CODE);
+
+	/* As it does an extended hypercall in fast form. */
+	vector = __hyperv_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES |
+				    HV_HYPERCALL_FAST_BIT,
+				    FAST_PARAM0, FAST_PARAM1, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status & 0xffff, HV_STATUS_INVALID_PARAMETER);
+	GUEST_SYNC(STAGE_DISABLED);
+
+	/*
+	 * Forwarding enabled: userspace supplies the status.  It also sets
+	 * 'ret', which KVM ignores until KVM_HYPERV_HCALL_RET is enabled.
+	 */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_MEMORY);
+
+	/*
+	 * Fast form: the register parameters and XMM0 reach userspace, and
+	 * the XMM1 value userspace writes reaches the guest.
+	 */
+	in.as_u64[0] = XMM_IN_MARKER;
+	in.as_u64[1] = XMM_IN_MARKER + 1;
+	out.as_u64[0] = 0;
+	out.as_u64[1] = 0;
+	write_sse_reg(0, &in.vec);
+	write_sse_reg(1, &out.vec);
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE | HV_HYPERCALL_FAST_BIT,
+				    FAST_PARAM0, FAST_PARAM1, &status);
+	read_sse_reg(1, &out.vec);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_ASSERT_EQ(out.as_u64[0], XMM_OUT_MARKER);
+	GUEST_ASSERT_EQ(out.as_u64[1], XMM_OUT_MARKER + 1);
+	GUEST_SYNC(STAGE_FAST);
+
+	/* An extended hypercall in fast form reaches userspace too. */
+	vector = __hyperv_hypercall(HV_EXT_CALL_QUERY_CAPABILITIES |
+				    HV_HYPERCALL_FAST_BIT,
+				    FAST_PARAM0, FAST_PARAM1, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_EXT_FAST);
+
+	/* The result reaches the guest as all 64 bits userspace wrote. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, FULL_RESULT);
+	GUEST_SYNC(STAGE_RESULT_FULL);
+
+	/* Userspace asks for #UD, then for #GP: KVM raises it at the call. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT_EQ(vector, UD_VECTOR);
+	GUEST_ASSERT_EQ((u32)status, UNWRITTEN_STATUS);
+	GUEST_SYNC(STAGE_RET_UD);
+
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT_EQ(vector, GP_VECTOR);
+	GUEST_ASSERT_EQ((u32)status, UNWRITTEN_STATUS);
+	GUEST_SYNC(STAGE_RET_GP);
+
+	/* Userspace leaves the call alone and queues #NM: taken there. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT_EQ(vector, NM_VECTOR);
+	GUEST_ASSERT_EQ((u32)status, UNWRITTEN_STATUS);
+	GUEST_SYNC(STAGE_RET_QUEUED);
+
+	/*
+	 * Userspace leaves the call alone without queueing anything, and
+	 * then has KVM_RUN refuse a reserved value: this one hypercall
+	 * re-executes and exits to userspace each time, until userspace
+	 * completes it.
+	 */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_RET_RETRY);
+
+	/* An ordinary completion still works after those. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_AFTER_RET);
+
+	/* Everything disabled again. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status & 0xffff, HV_STATUS_INVALID_HYPERCALL_CODE);
+	GUEST_SYNC(STAGE_REDISABLED);
+
+	GUEST_DONE();
+}
+
+static void check_hcall_exit(struct kvm_vcpu *vcpu, u64 expect_control,
+			     u64 expect_in, u64 expect_out)
+{
+	struct kvm_run *run = vcpu->run;
+
+	TEST_ASSERT_EQ(run->exit_reason, KVM_EXIT_HYPERV);
+	TEST_ASSERT_EQ(run->hyperv.type, KVM_EXIT_HYPERV_HCALL);
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.input, expect_control);
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.params[0], expect_in);
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.params[1], expect_out);
+	/* KVM hands over every exit as one which completes. */
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.ret, KVM_INSN_COMPLETE);
+}
+
+/*
+ * Leave the hypercall uncompleted with @ret, optionally queueing a #NM to
+ * be delivered at the (unadvanced) hypercall instruction.  The result
+ * which userspace wrote must never reach the guest.
+ */
+static void leave_hcall(struct kvm_vcpu *vcpu, u8 ret, bool queue_nm)
+{
+	struct kvm_vcpu_events events;
+
+	vcpu->run->hyperv.u.hcall.ret = ret;
+	vcpu->run->hyperv.u.hcall.result = POISON_STATUS;
+	if (!queue_nm)
+		return;
+
+	vcpu_events_get(vcpu, &events);
+	events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
+	events.exception.pending = 1;
+	events.exception.injected = 0;
+	events.exception.nr = NM_VECTOR;
+	events.exception.has_error_code = 0;
+	events.exception_has_payload = 0;
+	vcpu_events_set(vcpu, &events);
+}
+
+static void handle_fast_hcall(struct kvm_vcpu *vcpu)
+{
+	struct kvm_fpu fpu;
+
+	check_hcall_exit(vcpu, HVCALL_TEST_CODE | HV_HYPERCALL_FAST_BIT,
+			 FAST_PARAM0, FAST_PARAM1);
+
+	vcpu_fpu_get(vcpu, &fpu);
+	TEST_ASSERT_EQ(*(u64 *)&fpu.xmm[0][0], XMM_IN_MARKER);
+	TEST_ASSERT_EQ(*(u64 *)&fpu.xmm[0][8], XMM_IN_MARKER + 1);
+	*(u64 *)&fpu.xmm[1][0] = XMM_OUT_MARKER;
+	*(u64 *)&fpu.xmm[1][8] = XMM_OUT_MARKER + 1;
+	vcpu_fpu_set(vcpu, &fpu);
+
+	vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+}
+
+static void test_feature_mask(struct kvm_vm *vm)
+{
+	u64 supported = kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL);
+	int r;
+
+	TEST_ASSERT(supported & KVM_HYPERV_HCALL_FORWARD_UNKNOWN,
+		    "KVM_HYPERV_HCALL_FORWARD_UNKNOWN not reported");
+	TEST_ASSERT(supported & KVM_HYPERV_HCALL_RET,
+		    "KVM_HYPERV_HCALL_RET not reported");
+	r = __vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, BIT_ULL(63));
+	TEST_ASSERT(r && errno == EINVAL,
+		    "Enabling an undefined feature should fail with EINVAL");
+
+	/* Enabling nothing is allowed. */
+	vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, 0);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gva_t hcall_page;
+	gpa_t hcall_gpa;
+	struct ucall uc;
+	int stage = STAGE_DISABLED;
+	int retries = 0;
+	struct kvm_regs regs;
+	u64 rip = 0, rax = 0;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_FORWARD_HCALL));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL) &
+		     KVM_HYPERV_HCALL_RET);
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_EXCEPTION_PAYLOAD));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_set_hv_cpuid(vcpu);
+	vm_enable_cap(vm, KVM_CAP_EXCEPTION_PAYLOAD, 1);
+
+	test_feature_mask(vm);
+
+	/* Hypercall page plus an input and an output page. */
+	hcall_page = vm_alloc_pages(vm, 3);
+	memset(addr_gva2hva(vm, hcall_page), 0x0, 3 * getpagesize());
+	hcall_gpa = addr_gva2gpa(vm, hcall_page);
+
+	vcpu_args_set(vcpu, 1, hcall_gpa);
+
+	for (;;) {
+		vcpu_run(vcpu);
+
+		if (vcpu->run->exit_reason == KVM_EXIT_HYPERV) {
+			switch (stage) {
+			case STAGE_MEMORY:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+				/* Not enabled yet: this must change nothing. */
+				vcpu->run->hyperv.u.hcall.ret = KVM_INSN_RESUME;
+				break;
+			case STAGE_FAST:
+				handle_fast_hcall(vcpu);
+				break;
+			case STAGE_EXT_FAST:
+				check_hcall_exit(vcpu,
+						 HV_EXT_CALL_QUERY_CAPABILITIES |
+						 HV_HYPERCALL_FAST_BIT,
+						 FAST_PARAM0, FAST_PARAM1);
+				vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+				break;
+			case STAGE_RESULT_FULL:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				vcpu->run->hyperv.u.hcall.result = FULL_RESULT;
+				break;
+			case STAGE_RET_UD:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				leave_hcall(vcpu, KVM_INSN_UD, false);
+				break;
+			case STAGE_RET_GP:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				leave_hcall(vcpu, KVM_INSN_GP, false);
+				break;
+			case STAGE_RET_QUEUED:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				leave_hcall(vcpu, KVM_INSN_RESUME, true);
+				break;
+			case STAGE_RET_RETRY:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				vcpu_regs_get(vcpu, &regs);
+				switch (retries++) {
+				case 0:
+					/*
+					 * Nothing queued: the same hypercall
+					 * must exit again, from the same RIP
+					 * and with RAX as it was.
+					 */
+					rip = regs.rip;
+					rax = regs.rax;
+					leave_hcall(vcpu, KVM_INSN_RESUME, false);
+					break;
+				case 1:
+					/* Refused, and the same again. */
+					TEST_ASSERT_EQ(regs.rip, rip);
+					TEST_ASSERT_EQ(regs.rax, rax);
+					leave_hcall(vcpu, KVM_INSN_RESUME + 1, false);
+					TEST_ASSERT(__vcpu_run(vcpu) == -1 &&
+						    errno == EINVAL,
+						    "KVM_RUN accepted a reserved 'ret'");
+					break;
+				default:
+					TEST_ASSERT_EQ(regs.rip, rip);
+					TEST_ASSERT_EQ(regs.rax, rax);
+					vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+					break;
+				}
+				break;
+			case STAGE_AFTER_RET:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+				break;
+			default:
+				TEST_FAIL("Unexpected hypercall exit in stage %d", stage);
+			}
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], stage);
+			switch (stage) {
+			case STAGE_DISABLED:
+				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+					      KVM_HYPERV_HCALL_FORWARD_UNKNOWN);
+				break;
+			case STAGE_MEMORY:
+				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+					      KVM_HYPERV_HCALL_FORWARD_UNKNOWN |
+					      KVM_HYPERV_HCALL_RET);
+				break;
+			case STAGE_AFTER_RET:
+				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, 0);
+				break;
+			}
+			stage++;
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		case UCALL_DONE:
+			goto done;
+		default:
+			TEST_FAIL("Unhandled ucall: %ld", uc.cmd);
+		}
+	}
+
+done:
+	TEST_ASSERT_EQ(stage, STAGE_REDISABLED + 1);
+	/* The call left alone came back twice: left, refused, completed. */
+	TEST_ASSERT_EQ(retries, 3);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

