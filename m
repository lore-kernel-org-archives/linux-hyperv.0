Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589547;
	b=G8+QJI7xVFJsl4z77M77aCkYB9LbDdWtaNIY7YPjsjx3v8fbc1Dc59KyQKjQ5E7508Dv
	 faXFiUKAXJKZ1a+daGfl4N/COP4EOplPtaNBRoYLsMEroJ4Psg0JzhGTAHm/09nSxP1c2
	 Pm5IZta/+1WJSxfRvXXup7/TAzkUpLmwPoTJ2gPDWmtYw1knnQAYMX0y3Y+M8NQwHgNuT
	 POVeqVgIHzGsZga9/zwndQumFffLE3r64ElkqyxKhjcQZU719moc7uSVx488CHipsejuL
	 rqt4/mURcDdROCyvLqFXOxroFmiCbKg/FvvrJRzPJArRj9Gf6AGj3E0kfIofmX+L5dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=kD+k376dF5CzmJ+PBfXNBW4wFZFtiWBoTErzmU1dBPA=;
	b=CpSjIEZg4QpX0ae6lm7hG281RvCRwsxWotphAp7aDSm8yLDpm1s6bwVP1Rf1SmgMgtlC
	 i+yS7RndL1+rWapvglL5ow7OWXZezobOpWFNiCdX0zVuRbdFRhJjdICdVeCTyIxHvrSvz
	 AooVGBV+EdFyAspZXXfnrK4GqAScZ7fsQc9hW6QiwO/QfeNUeKEsGyqtWTxidT0+thx8d
	 VD72grCIdaOVABJgQNTDQVZfL+eZQABrFo7tXfqJ5TXZRS9jc6+WQ2lLoosvLdBpk6hTM
	 umrZOnMw69jByRCjdY2Ys1XqQzl9dX9FJ6BFSEZ/hxmnqxbGK1gMRD5WdLmElV+os8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=H6dQNxeF;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF90C606A339;
	Fri, 13 Nov 2026 17:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF90C606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=H6dQNxeF
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kD+k376dF5CzmJ+PBfXNBW4wFZFtiWBoTErzmU1dBPA=; b=H6dQNxeFJndlqqSGqyGkw+GCgZ
	vf9XCdOJShWEvU16qKisJ1fBnwiEhAFQ8L3KQdvmAZt3ZDDSAEsBgytpyXkFfNgETL51Lmkeksn5v
	Wc/fWnMInNIQ/bJlrj2s0NFQqfbcTsi16aeikDo2wYoRQjNOuBxH79NRkz7asdCUbUkVnjoVDOFJ0
	lPuWn8U4anItx4OOMl9s21msiqxLmq/2LPXAJrohHvtH0KmC2yB0tEwKox+9qOu2G2qNvl1vFeWQW
	kvYcs1LAWG+NGyhL1HLB3QSphzR/CoYX4ffoW3cAd0m2yOMTL3nFrm4oNXGiqsEP6+XJf93DBSVXu
	nktVJlpg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuiW-00000003oWI-0ox4;
	Fri, 13 Nov 2026 17:05:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRuiV-00000000KcV-4BNB;
	Fri, 13 Nov 2026 17:05:35 +0000
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 4/4] KVM: selftests: Add Hyper-V hypercall forwarding test
Date: Fri, 13 Nov 2026 10:05:35 -0700
Message-ID: <20261113170535.79246-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113170535.79246-1-dwmw2@infradead.org>
References: <20261113170535.79246-1-dwmw2@infradead.org>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Cover KVM_CAP_HYPERV_FORWARD_HCALL and the completion cancel:

 - the feature mask reports forwarding, and rejects bits it does not
   report;
 - with nothing enabled, an unknown hypercall fails in KVM;
 - with forwarding enabled, it exits to userspace in memory-based and
   fast form with the control value and parameters, and the guest
   sees the status userspace supplies (and, for the fast form, the XMM
   output userspace writes through KVM_SET_FPU);
 - the result reaches the guest as the full 64-bit value userspace
   wrote, bit 63 included;
 - a cancel with a queued #UD faults the hypercall, leaving RIP and
   RAX untouched;
 - a cancel alone makes the same hypercall exit a second time, and
   completing the second exit works;
 - the cancel fails with EBUSY at a hypercall-less ucall exit, whose
   PIO completion is not cancellable, and leaves the vCPU's events
   unchanged;
 - disabling everything restores the in-kernel failure.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 337 ++++++++++++++++++
 2 files changed, 338 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 7a51ff975cfa..ca68943f99d4 100644
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
index 000000000000..4c290b6a1012
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
@@ -0,0 +1,337 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_CAP_HYPERV_FORWARD_HCALL: the feature mask KVM reports and
+ * accepts, Hyper-V hypercalls that KVM does not implement exiting to
+ * userspace in memory-based and fast form, with userspace supplying the
+ * result and the XMM output, and a pending completion cancelled through
+ * KVM_SET_VCPU_EVENTS - alone, so that the guest re-executes the
+ * hypercall, and together with a queued #UD, so that the hypercall
+ * faults instead.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+
+/* A hypercall code KVM does not implement (HvCallGetVpRegisters). */
+#define HVCALL_TEST_CODE	0x50
+
+#define FAST_PARAM0		0x1122334455667788ULL
+#define FAST_PARAM1		0x99aabbccddeeff00ULL
+#define XMM_IN_MARKER		0x5157ca11c0ffee00ULL
+#define XMM_OUT_MARKER		0x0de1ba5eba5eba11ULL
+#define USERSPACE_STATUS	0x55AA
+#define FULL_RESULT		(BIT_ULL(63) | USERSPACE_STATUS)
+
+enum {
+	STAGE_DISABLED = 1,
+	STAGE_MEMORY,
+	STAGE_FAST,
+	STAGE_RESULT_FULL,
+	STAGE_CANCEL_UD,
+	STAGE_CANCEL_RETRY,
+	STAGE_AFTER_CANCEL,
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
+	GUEST_SYNC(STAGE_DISABLED);
+
+	/* Forwarding enabled: userspace supplies the status. */
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
+	/* The result reaches the guest as all 64 bits userspace wrote. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, FULL_RESULT);
+	GUEST_SYNC(STAGE_RESULT_FULL);
+
+	/* Userspace cancels the completion and queues #UD: the call faults. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT_EQ(vector, UD_VECTOR);
+	GUEST_SYNC(STAGE_CANCEL_UD);
+
+	/*
+	 * Userspace cancels the completion without queueing anything: this
+	 * one hypercall re-executes and exits to userspace a second time,
+	 * which then completes it.
+	 */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_CANCEL_RETRY);
+
+	/* An ordinary completion still works after the cancels. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_AFTER_CANCEL);
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
+}
+
+/*
+ * Cancel the pending hypercall completion, optionally queueing a #UD to
+ * be delivered at the (unadvanced) hypercall instruction.  The cancel
+ * must leave RIP and RAX alone.
+ */
+static void cancel_hcall(struct kvm_vcpu *vcpu, bool queue_ud)
+{
+	struct kvm_vcpu_events events;
+	struct kvm_regs before, after;
+
+	vcpu_events_get(vcpu, &events);
+	events.flags |= KVM_VCPUEVENT_CANCEL_HCALL;
+	if (queue_ud) {
+		events.flags |= KVM_VCPUEVENT_VALID_PAYLOAD;
+		events.exception.pending = 1;
+		events.exception.injected = 0;
+		events.exception.nr = UD_VECTOR;
+		events.exception.has_error_code = 0;
+		events.exception_has_payload = 0;
+	}
+
+	vcpu_regs_get(vcpu, &before);
+	vcpu_events_set(vcpu, &events);
+	vcpu_regs_get(vcpu, &after);
+	TEST_ASSERT_EQ(before.rip, after.rip);
+	TEST_ASSERT_EQ(before.rax, after.rax);
+}
+
+/*
+ * With no cancellable completion pending (nothing pending at all, or a
+ * non-cancellable completion such as the ucall PIO's), the cancel must
+ * fail with EBUSY and leave the vCPU's event state as
+ * KVM_GET_VCPU_EVENTS reported it.
+ */
+static void check_cancel_refused(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events, after;
+	int r;
+
+	vcpu_events_get(vcpu, &events);
+	events.flags |= KVM_VCPUEVENT_CANCEL_HCALL;
+	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(r == -1 && errno == EBUSY,
+		    "Cancel with nothing to cancel: r = %d, errno = %d",
+		    r, errno);
+
+	events.flags &= ~KVM_VCPUEVENT_CANCEL_HCALL;
+	vcpu_events_get(vcpu, &after);
+	TEST_ASSERT(!memcmp(&events, &after, sizeof(events)),
+		    "Failed cancel changed the vCPU's events");
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
+	bool retried = false;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_FORWARD_HCALL));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_VCPU_EVENTS) &
+		     KVM_VCPU_EVENTS_CANCEL_HCALL);
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
+				break;
+			case STAGE_FAST:
+				handle_fast_hcall(vcpu);
+				break;
+			case STAGE_RESULT_FULL:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				vcpu->run->hyperv.u.hcall.result = FULL_RESULT;
+				break;
+			case STAGE_CANCEL_UD:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				cancel_hcall(vcpu, true);
+				/* Cancelled: the result must never reach the guest. */
+				vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+				break;
+			case STAGE_CANCEL_RETRY:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				if (!retried) {
+					/*
+					 * Cancel with nothing queued: the same
+					 * hypercall must exit a second time.
+					 */
+					cancel_hcall(vcpu, false);
+					vcpu->run->hyperv.u.hcall.result = 0;
+					retried = true;
+				} else {
+					vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+				}
+				break;
+			case STAGE_AFTER_CANCEL:
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
+			case STAGE_CANCEL_RETRY:
+				/*
+				 * The ucall PIO's own completion is pending
+				 * here: not cancellable, even with the
+				 * feature enabled.
+				 */
+				check_cancel_refused(vcpu);
+				break;
+			case STAGE_AFTER_CANCEL:
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
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

