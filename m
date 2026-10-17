Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA934854EF;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239908; cv=none; b=N/sqJtiW5Z8pbTGc8LHz7nzNIERgnanS22/v4c7xko6bAMrsg96HEbZdIzakvnaZaFTQ4fGgcRaVGacLTQzeoVhKsPrckjs/kIhJ2sRjaTDIvKkiKE83NqrxgMgepZwCobEomoOKeSvIQ8qJvmIycAQ2NgiOqWZu1wHZJskIPM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239908; c=relaxed/simple;
	bh=BejauQzFrld1ZMluPY+3eUfKhGly2e8eZ57+5gGNiog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tO0A5xwuPQqC7usJtgCj5jIU9S4sIZfPETbu/bhQ+jG7Z1APWEdI/L30Ewfcf9vjecY5Lprncs3dvW8jICxPnmQMWEUm6W8XTWakaGye5MRZ0pzoDsmcYHO3FpuqM0H5TxaBxz2B/gStudqVxfkWYCpvxxXLRoizPHoyBrl0Tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ghtflaVv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ghtflaVv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gxAPZ7ZY0/3MPeaQ5DFZd+yjtQRD0c8y3nHEtC5jnIM=; b=ghtflaVvspBpLjoXh/TtuczVoR
	xy6vRhAC76kO96kGvyZmzDc0Mu/sxg7VSKh88Sxl3UVQk7TxghABztVTM95HqtG+gx0/b6zRg1auz
	+ApWCLN1ycY0lIx4eNZci1vOs6ppege33EHLIYq8N7Cim8SpTnIQnk08m8J7DTkpgng7L8n9dJiEk
	c/xoyMoCOPJXrWVy1S/gXXhSv2F/UkmQPZ139nVsIPYqJkCTzdN3NzlJZq4LELQKlSmkV4DIX957r
	wD7xj0tUwgfxEi1YGtOm2qHomaepSCwaic2QbkFpShWYtauvGPG61UZye4H7PXq2Eh+oIYYfm/TMr
	d8I0daCQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCC-1Jrl;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YlB-0HFg;
	Sat, 17 Oct 2026 13:25:02 +0100
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
	David Woodhouse <dwmw@amazon.co.uk>,
	nh-open-source@amazon.com
Subject: [RFC PATCH 06/55] KVM: selftests: Add Hyper-V hypercall forwarding test
Date: Sat, 17 Oct 2026 13:24:12 +0100
Message-ID: <20261017122501.610248-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Drive an unimplemented hypercall code through the three interesting
shapes: forwarding disabled (the guest sees
HV_STATUS_INVALID_HYPERCALL_CODE from KVM itself), a slow-form call
(the exit carries the control value and GPAs, and the userspace-chosen
result reaches the guest), and a fast-form call (RDX and R8 in the
exit parameters, XMM0 visible through KVM_GET_FPU).

The tools copy of linux/kvm.h picks up the KVM_CAP_HYPERV_FORWARD_HCALL
capability number for the test.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/include/uapi/linux/kvm.h                |   1 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 144 ++++++++++++++++++
 3 files changed, 146 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index dcd12f58186e..586c0d6c168c 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1015,6 +1015,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_PLANES 249
+#define KVM_CAP_HYPERV_FORWARD_HCALL 250
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 5883359c1a5d..14e385750ed1 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -85,6 +85,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_cpuid
 TEST_GEN_PROGS_x86 += x86/hyperv_evmcs
 TEST_GEN_PROGS_x86 += x86/hyperv_extended_hypercalls
 TEST_GEN_PROGS_x86 += x86/hyperv_features
+TEST_GEN_PROGS_x86 += x86/hyperv_forward_hcall
 TEST_GEN_PROGS_x86 += x86/hyperv_ipi
 TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
diff --git a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
new file mode 100644
index 000000000000..47f786ca3e4b
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_CAP_HYPERV_FORWARD_HCALL: Hyper-V hypercalls that KVM does
+ * not implement exit to userspace instead of failing with
+ * HV_STATUS_INVALID_HYPERCALL_CODE, in both slow and fast form, and
+ * userspace supplies the result the guest observes.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+
+/* A hypercall code KVM does not implement: HvCallGetVpRegisters. */
+#define HVCALL_TEST_CODE	0x50
+
+#define FAST_PARAM0		0x1122334455667788ULL
+#define FAST_PARAM1		0x99aabbccddeeff00ULL
+#define XMM_MARKER		0x5157ca11c0ffee00ULL
+#define USERSPACE_STATUS	0x55AA
+
+static void guest_code(gpa_t pgs_gpa)
+{
+	__sse128_u marker;
+	u64 status;
+	u8 vector;
+
+	marker.as_u64[0] = XMM_MARKER;
+	marker.as_u64[1] = XMM_MARKER + 1;
+
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_HYPERCALL, pgs_gpa);
+
+	/* Forwarding disabled: KVM itself fails the call. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa,
+				    pgs_gpa + PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status & 0xffff, HV_STATUS_INVALID_HYPERCALL_CODE);
+	GUEST_SYNC(1);
+
+	/* Forwarding enabled: userspace supplies the status. */
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE, pgs_gpa,
+				    pgs_gpa + PAGE_SIZE, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status & 0xffff, 0);
+	GUEST_SYNC(2);
+
+	/* Fast form: register parameters reach userspace. */
+	write_sse_reg(0, &marker.vec);
+	vector = __hyperv_hypercall(HVCALL_TEST_CODE | HV_HYPERCALL_FAST_BIT,
+				    FAST_PARAM0, FAST_PARAM1, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status & 0xffff, USERSPACE_STATUS);
+
+	GUEST_DONE();
+}
+
+static void handle_forwarded_hcall(struct kvm_vcpu *vcpu, u64 expect_control,
+				   u64 expect_in, u64 expect_out, u64 result)
+{
+	struct kvm_run *run = vcpu->run;
+
+	TEST_ASSERT_EQ(run->exit_reason, KVM_EXIT_HYPERV);
+	TEST_ASSERT_EQ(run->hyperv.type, KVM_EXIT_HYPERV_HCALL);
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.input, expect_control);
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.params[0], expect_in);
+	TEST_ASSERT_EQ(run->hyperv.u.hcall.params[1], expect_out);
+
+	run->hyperv.u.hcall.result = result;
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	gva_t hcall_page;
+	gpa_t hcall_gpa;
+	struct kvm_fpu fpu;
+	struct ucall uc;
+	int stage;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_FORWARD_HCALL));
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+	vcpu_set_hv_cpuid(vcpu);
+
+	/* Hypercall page plus an input and an output page. */
+	hcall_page = vm_alloc_pages(vm, 3);
+	memset(addr_gva2hva(vm, hcall_page), 0x0, 3 * getpagesize());
+	hcall_gpa = addr_gva2gpa(vm, hcall_page);
+
+	vcpu_args_set(vcpu, 1, hcall_gpa);
+
+	for (stage = 1;; stage++) {
+		vcpu_run(vcpu);
+
+		if (vcpu->run->exit_reason == KVM_EXIT_HYPERV) {
+			switch (stage) {
+			case 2:
+				handle_forwarded_hcall(vcpu, HVCALL_TEST_CODE,
+						       hcall_gpa,
+						       hcall_gpa + getpagesize(),
+						       0);
+				break;
+			case 3:
+				handle_forwarded_hcall(vcpu,
+						       HVCALL_TEST_CODE | HV_HYPERCALL_FAST_BIT,
+						       FAST_PARAM0, FAST_PARAM1,
+						       USERSPACE_STATUS);
+				/*
+				 * Fast-call register state is reachable with
+				 * the ordinary vCPU state ioctls.
+				 */
+				vcpu_fpu_get(vcpu, &fpu);
+				TEST_ASSERT_EQ(*(u64 *)&fpu.xmm[0][0], XMM_MARKER);
+				TEST_ASSERT_EQ(*(u64 *)&fpu.xmm[0][8], XMM_MARKER + 1);
+				break;
+			default:
+				TEST_FAIL("Unexpected hypercall exit in stage %d", stage);
+			}
+			stage--;	/* same guest stage continues */
+			continue;
+		}
+
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], stage);
+			if (stage == 1)
+				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, 1);
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
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

