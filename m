Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430725;
	b=n9xMbQJElU7aAIqQ8mj3EsPj0lDVHcS5mu7jVf11dgzx48s/cJ7jhHNZ645PaE2aP6GW
	 6jp+2lTxvG7dEzGmWL1stPtz/63B6b4mCD1YaOnitS/LfnLbRQZbf6UY0H6hZMKexPTyj
	 vzsjVY/jD/Ypk+UjBZrjL0ipdxvj3qGZ7VWZUSthrXINfiagD/WLGhdBnNW3jMF1C0Cdw
	 oJYS4WXj7E4giedZKavzQ0mOYmyXokhN1xKOadypv0iSnzmxlm1NHyHRwxr+VbmVn0cYL
	 TSrzBNk1SGRM73CHu15gIZanHc09kwsmRouQffYk2pfX59zcToDgAw258EUYAfzydPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430725;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=6K0JX6VQO+jmFT3oox7919dmm7iUkG/qSpaX7PM7Owg=;
	b=dcqCj0x6IIAX5o7/xrWq8EZt/gPMENIdiChahXkf0AFXBGnJCAt+/6Mn4ZoXRKxmWRAi
	 2M1M2Z1AwAPUEDgQ5qDL08gdg7WjQhX8MGVL4sArEDnqldQpy9X2Cw2EiT2Gbh+L10hTa
	 VLiOgMGc5ih9ZrnjZi3cAWH0pvfEBbJLYRJtYpXvlKQ2sABN7rK5LwtoSxIowsiHFiCYp
	 xH3L9zclqwcoq264rZjfVjFt6MxlTwqYt/aLzVMSV+QlV0BR0QorWdRF25ywZiQWu8u4G
	 aaOE0TR4Y3ejOagYNQ3Z8Oae9jX1bn4Jg9OkEouOktn6WTZrCE2RUAbWha4NhDp5qig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=iEGUQjfu;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C54606A89D;
	Wed, 11 Nov 2026 20:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C54606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=iEGUQjfu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=6K0JX6VQO+jmFT3oox7919dmm7iUkG/qSpaX7PM7Owg=; b=iEGUQjfuJGLM9x8YFhki7GVZ73
	A24YB2Dc7L7qvRdL7KLN97zCDL6KN0mbTEQ/CKvfCMxJDi7VCyl4gPNFnRd4LAlftkbeSn9BMpYWL
	nHXSs+tgagLrApQRx+B4E0VXxJwjEm5IPGIWJEd5N31X61gos9+kgmZUxOsV9O9DTFcZTV8Fz3/uY
	z0+8hRlZrXl2fdCcnuSMedJzbB16ouxcON2/K8x1OoOYrSZbxkBsQndmqTeTUROm3L1jrhqa1eugW
	sZZ6BkX3gvolCyQd9b7QgNLf+oTIjR3Rl4uLDleULJ+GWNAqgGyX3CqaMn7PEnSqCJpPKs0YB7CZq
	3rx99pRg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFOx-00000009ZGu-26oS;
	Wed, 11 Nov 2026 20:58:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRFOu-0000000HZ7t-35A7;
	Wed, 11 Nov 2026 20:58:36 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
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
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 4/4] KVM: selftests: Add Hyper-V hypercall forwarding test
Date: Wed, 11 Nov 2026 12:58:36 -0800
Message-ID: <20261111205836.4186584-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111205836.4186584-1-dwmw2@infradead.org>
References: <20261111205836.4186584-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Cover KVM_CAP_HYPERV_FORWARD_HCALL:

 - the feature mask reports forwarding and RAISE_UD, and rejects bits
   it does not report;
 - with nothing enabled, an unknown hypercall fails in KVM;
 - with forwarding enabled, it exits to userspace in memory-based and
   fast form with the control value and parameters, and the guest
   sees the status userspace supplies (and, for the fast form, the XMM
   output userspace writes through KVM_SET_FPU);
 - the result reaches the guest as the full 64-bit value userspace
   wrote, bit 63 included;
 - KVM_HYPERV_HCALL_UD in 'flags' fails KVM_RUN with EINVAL until
   RAISE_UD is enabled, and then raises #UD at the hypercall;
 - KVM reports every exit with 'flags' cleared, even after a completion
   that set them;
 - disabling everything restores the in-kernel failure.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 268 ++++++++++++++++++
 2 files changed, 269 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..cc01edd07064 100644
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
index 000000000000..5afc99ed533c
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
@@ -0,0 +1,268 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_CAP_HYPERV_FORWARD_HCALL: the feature mask KVM reports and
+ * accepts, Hyper-V hypercalls that KVM does not implement exiting to
+ * userspace in memory-based and fast form, with userspace supplying the
+ * result and the XMM output, and a userspace completion raising #UD
+ * through the exit's flags.
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
+	STAGE_RAISE_UD,
+	STAGE_FLAGS_CLEARED,
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
+	/* With KVM_HYPERV_HCALL_RAISE_UD, the UD flag faults the call. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT_EQ(vector, UD_VECTOR);
+	GUEST_SYNC(STAGE_RAISE_UD);
+
+	/* The next exit starts with the flags cleared again. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa + PAGE_SIZE,
+				    pgs_gpa + 2 * PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, USERSPACE_STATUS);
+	GUEST_SYNC(STAGE_FLAGS_CLEARED);
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
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.flags, 0);
+}
+
+/*
+ * Without KVM_HYPERV_HCALL_RAISE_UD, KVM_HYPERV_HCALL_UD is an unknown
+ * flag: KVM_RUN must fail with EINVAL and leave the exit pending.
+ */
+static void check_flags_refused(struct kvm_vcpu *vcpu)
+{
+	int r;
+
+	vcpu->run->hyperv.u.hcall.flags = KVM_HYPERV_HCALL_UD;
+	r = __vcpu_run(vcpu);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "KVM_RUN with an unenabled hcall flag: r = %d, errno = %d",
+		    r, errno);
+	vcpu->run->hyperv.u.hcall.flags = 0;
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
+	TEST_ASSERT(supported & KVM_HYPERV_HCALL_RAISE_UD,
+		    "KVM_HYPERV_HCALL_RAISE_UD not reported");
+
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
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_FORWARD_HCALL));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_set_hv_cpuid(vcpu);
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
+				check_flags_refused(vcpu);
+				vcpu->run->hyperv.u.hcall.result = FULL_RESULT;
+				break;
+			case STAGE_RAISE_UD:
+				check_hcall_exit(vcpu, HVCALL_TEST_CODE,
+						 hcall_gpa + getpagesize(),
+						 hcall_gpa + 2 * getpagesize());
+				vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
+				vcpu->run->hyperv.u.hcall.flags = KVM_HYPERV_HCALL_UD;
+				break;
+			case STAGE_FLAGS_CLEARED:
+				/* check_hcall_exit() asserts the stale UD is gone. */
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
+			case STAGE_RESULT_FULL:
+				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+					      KVM_HYPERV_HCALL_FORWARD_UNKNOWN |
+					      KVM_HYPERV_HCALL_RAISE_UD);
+				break;
+			case STAGE_FLAGS_CLEARED:
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

