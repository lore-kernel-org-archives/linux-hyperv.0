Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=oo/fUylNT0kfBHkZtDoTPMyrvq1DuOvYGFpMdupwoG8lMxfmKxdEoYT7yodRwr7mXJk2
	 7/YBxTF4moocqdw5Xg4wcKMI7kjNsxpNjF4ryHfi/59Mv91csXAgrZ35MZYPoq9yCAlzs
	 xM9Zx1VH+Gc1JhF3QkZ8hn9ZQVKYeoEy9G0ceP/tR+zZuPs7e2NzU9Xx5jqpCJmG3e77j
	 HYC6vzbg6bvFCHImNK7FU+SeFmWfbcTK0qT8mSV815sirHI1vAcr1VSmQIn86qj1T+PM1
	 2SS8C4dlygV56zkhedsZxoCzZbNTY5qiMk6y39Ig6njbbxLMyZLUz1zTe0oumI9ESBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=00w/klm5tO7c3albMdynTmGoD1cJ6pDZx+lmvoRT9VA=;
	b=x6iLkf6LGq8pXCrb+wIED9h5fr60hcllRSnXzmEME9qHvNPtGzahLRiUuDtedQK9R9UP
	 CLmPQb8CFEcOeGciAYFh5TWDPuKlx43lONo8XktjvYElihWVkpRuRwAmkvb0PS5P4OOdi
	 ggKQOE5bq7jM/C//v1OZXvkx3x571ETFsHfbPo0yBS+PjUV0V2K3gvdAES9/4F36Ezc4+
	 bdmS1VqfIqIYxMA8UXLvV9ehdRSXsRg+f8vGhUSEkw6cx3zFf8D/kJ5bCpL0pEDHGMQQs
	 hZQoEAGVKf1GZMAFK/yVfuzujb6jl+114Zee04fNBH11ImZ3I/ky7B6tyG7l0gDDCnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nWN9m8mc;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FF5606A88A;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 34FF5606A88A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nWN9m8mc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=00w/klm5tO7c3albMdynTmGoD1cJ6pDZx+lmvoRT9VA=; b=nWN9m8mceMQ8yI9NfJHNOH7Wny
	vCwtvadVcxKSIBkCl2E8zdWHuTueF5s9deXvOcf7gPSQRF4DAUdkFE9m9czu4rwHgidd0SJpEq9AN
	wK8xiWSH8atlzYaxZyswqIJWetlFH+238DYpjyuEqjwoaJgtsmZ3fkVTCCrivpZxea7+RTqWl9IGE
	UuAthqv2YQMzEA9sAy/xQyqrMd+4GSs7+2gGiq1k4cml3GDm+f+M5jn2qLl31bqYM87HRjazoxkx3
	VXb6jGwIISX1zldvOKnNj9gTyllDeQZmRYsK3F6aw0VhuibOUHOa9SCVXokAIU5UGye3WZOi1Pw0W
	jNUHBDMw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQv-236V;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Lu0-12sj;
	Fri, 13 Nov 2026 18:34:50 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	=?UTF-8?q?J=C3=B6rg=20R=C3=B6del?= <joro@8bytes.org>,
	joerg.roedel@amd.com,
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
Subject: [RFC PATCH v2 22/31] KVM: selftests: Test a plane suspending with an undelivered interrupt
Date: Fri, 13 Nov 2026 18:34:38 +0000
Message-ID: <20261113183448.84094-23-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113183448.84094-1-dwmw2@infradead.org>
References: <20261113183448.84094-1-dwmw2@infradead.org>
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

Pin the forced-VTL-entry re-arm: a plane-1 twin self-IPIs with IF
clear, runs on (consuming its single-shot hv_apic_event_pending
marker), and is then suspended by KVM_SET_PLANE_RUN_STATE exactly like
a userspace VTL switch.  Running plane 0 must report the suspended
twin's deliverable interrupt as a KVM_EXIT_HYPERV_VTL_INTERRUPT exit,
and the re-entered twin must receive the vector once it sets IF.  On a
kernel without the re-arm, plane 0 reaches its guest code and the
twin's interrupt is stranded in its IRR, which is the Windows VSM
hibernate deadlock in miniature.  The VM enables
KVM_HYPERV_HCALL_VTL_CALLS, which VTL interrupt exits require.

The default selftest VM owns a fully in-kernel irqchip, which planes
refuse; add a kvm_force_split_irqchip override to the library (as in
the public planes tree) so a planes test can use the stock VM setup.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 ++
 .../selftests/kvm/x86/planes_vtl_entry_test.c | 186 ++++++++++++++++++
 4 files changed, 199 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 8e1c0ffe81f6..250b324d0881 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -114,6 +114,7 @@ TEST_GEN_PROGS_x86 += x86/nested_x2apic_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/plane_x86_test
 TEST_GEN_PROGS_x86 += x86/planes_test
+TEST_GEN_PROGS_x86 += x86/planes_vtl_entry_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4818e3f5454c..01f7fe111188 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -853,6 +853,7 @@ static inline bool is_smt_on(void)
 	return false;
 }
 
+extern bool kvm_force_split_irqchip;
 void vm_create_irqchip(struct kvm_vm *vm);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 7e90f3b619ba..8ba1d0c011e9 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1802,11 +1802,22 @@ int kvm_gpa_to_guest_memfd(struct kvm_vm *vm, gpa_t gpa, off_t *fd_offset,
 	return region->region.guest_memfd;
 }
 
+/*
+ * Tests that need a split IRQ chip (x86 only), e.g. for VM planes, set this
+ * around VM creation to override the fully in-kernel default.
+ */
+bool kvm_force_split_irqchip;
+
 /* Create an interrupt controller chip for the specified VM. */
 void vm_create_irqchip(struct kvm_vm *vm)
 {
 	int r;
 
+	if (kvm_force_split_irqchip && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP)) {
+		vm_enable_split_irqchip(vm);
+		return;
+	}
+
 	/*
 	 * Allocate a fully in-kernel IRQ chip by default, but fall back to a
 	 * split model (x86 only) if that fails (KVM x86 allows compiling out
diff --git a/tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c b/tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c
new file mode 100644
index 000000000000..b0565b6c442b
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c
@@ -0,0 +1,186 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that an interrupt posted to a higher plane survives the plane
+ * suspending without having delivered it.
+ *
+ * A higher plane's pending interrupt forces entry into that plane via a
+ * single-shot marker (hv_apic_event_pending) that the plane consumes when
+ * it runs.  A plane that runs with IF clear until it suspends consumes
+ * the marker without delivering the vector, which used to strand the
+ * vector in the plane's IRR forever: with the marker gone, the lower
+ * plane never again exits with KVM_EXIT_HYPERV_VTL_INTERRUPT, and a
+ * guest waiting on the higher plane deadlocks.
+ *
+ * The test models the failing sequence: the plane-1 twin self-IPIs with
+ * IF clear, keeps running (consuming the marker), then is suspended by
+ * the run-state ioctl exactly like a userspace VTL switch.  Running
+ * plane 0 must then report a pending VTL interrupt for plane 1, and the
+ * re-entered twin must receive the vector once it sets IF.
+ */
+#include <errno.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "apic.h"
+#include "kselftest.h"
+
+#ifndef KVM_EXIT_HYPERV_VTL_INTERRUPT
+#define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+#endif
+
+#define TEST_VECTOR		0xe0
+#define TWIN_SYNC_PORT		0x7e
+
+static volatile bool twin_got_ipi;
+
+static void twin_sync(uint8_t stage)
+{
+	asm volatile("outb %0, %1" :: "a"(stage), "Nd"((uint16_t)TWIN_SYNC_PORT));
+}
+
+static void twin_ipi_handler(struct ex_regs *regs)
+{
+	twin_got_ipi = true;
+	x2apic_write_reg(APIC_EOI, 0);
+}
+
+/* Runs with IF clear: the initial RFLAGS has IF unset and nothing sets it. */
+static void twin_guest_code(void)
+{
+	x2apic_enable();
+	x2apic_write_reg(APIC_SELF_IPI, TEST_VECTOR);
+	twin_sync(1);
+	twin_sync(2);
+
+	/* Re-entered after suspension: open the window, take the vector. */
+	sti();
+	while (!twin_got_ipi)
+		cpu_relax();
+	twin_sync(3);
+	for (;;)
+		twin_sync(4);
+}
+
+static void plane0_guest_code(void)
+{
+	GUEST_SYNC(0);
+	GUEST_DONE();
+}
+
+static void set_run_states(struct kvm_vcpu *vcpu0, u64 state0,
+			   struct kvm_plane_vcpu *twin, u64 state1)
+{
+	plane_vcpu_ioctl(twin, KVM_SET_PLANE_RUN_STATE, &state1);
+	vcpu_ioctl(vcpu0, KVM_SET_PLANE_RUN_STATE, &state0);
+}
+
+/*
+ * The selected plane runs through plane 0's fd; vcpu_run() retries
+ * EINTR.  A twin exit is reported in the twin's own kvm_run.
+ */
+static void run_twin_expect_sync(struct kvm_vcpu *vcpu0,
+				 struct kvm_run *twin_run, uint8_t stage)
+{
+	vcpu_run(vcpu0);
+	TEST_ASSERT_EQ(twin_run->exit_reason, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(twin_run->io.port, TWIN_SYNC_PORT);
+	TEST_ASSERT_EQ(*((uint8_t *)twin_run + twin_run->io.data_offset), stage);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_plane_vcpu *twin;
+	struct kvm_plane *plane;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_run *twin_run;
+	struct kvm_vcpu *vcpu0;
+	struct kvm_vm *vm;
+	int mmap_sz;
+
+	kvm_force_split_irqchip = true;
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	kvm_force_split_irqchip = false;
+
+	TEST_REQUIRE(vm_check_cap(vm, KVM_CAP_PLANES) >= 1);
+	TEST_REQUIRE(__vm_enable_cap(vm, KVM_CAP_PLANES, 2) == 0);
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL) &
+		     KVM_HYPERV_HCALL_VTL_CALLS);
+	/* VTL interrupt exits belong to the userspace-switch VTL contract. */
+	vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+		      KVM_HYPERV_HCALL_VTL_CALLS);
+
+	ksft_print_header();
+	ksft_set_plan(1);
+
+	vcpu0 = vm_vcpu_add(vm, 0, plane0_guest_code);
+	plane = vm_plane_add(vm, 1);
+	twin = __vm_plane_vcpu_add(vcpu0, plane);
+
+	mmap_sz = __kvm_ioctl(vm->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	TEST_ASSERT(mmap_sz >= (int)sizeof(*twin_run),
+		    "KVM_GET_VCPU_MMAP_SIZE failed");
+	twin_run = kvm_mmap(mmap_sz, PROT_READ | PROT_WRITE, MAP_SHARED,
+			    twin->fd);
+
+	vm_install_exception_handler(vm, TEST_VECTOR, twin_ipi_handler);
+
+	/*
+	 * The twin shares the mode and page tables with plane 0: reuse
+	 * plane 0's segment state and point it at its own code and stack.
+	 * RFLAGS keeps IF clear.
+	 */
+	vcpu_sregs_get(vcpu0, &sregs);
+	plane_vcpu_ioctl(twin, KVM_SET_SREGS, &sregs);
+
+	plane_vcpu_ioctl(twin, KVM_GET_REGS, &regs);
+	regs.rip = (unsigned long)twin_guest_code;
+	regs.rsp = vm_alloc_stack(vm, 4);
+	regs.rflags = 0x2;
+	plane_vcpu_ioctl(twin, KVM_SET_REGS, &regs);
+
+	/*
+	 * Run the twin as a userspace VTL switch would: twin runnable,
+	 * plane 0 held.  The twin self-IPIs with IF clear, so the
+	 * vector lands in its IRR without being delivered, and the
+	 * second sync guarantees a fresh guest entry consumed the
+	 * forced-entry marker.
+	 */
+	set_run_states(vcpu0, KVM_PLANE_RUN_STATE_USER_HOLD,
+		       twin, 0);
+	run_twin_expect_sync(vcpu0, twin_run, 1);
+	run_twin_expect_sync(vcpu0, twin_run, 2);
+
+	/* Suspend the twin with the vector still latched in its IRR. */
+	set_run_states(vcpu0, 0,
+		       twin, KVM_PLANE_RUN_STATE_USER_HOLD);
+
+	/*
+	 * Plane 0 must not run the guest: the suspended twin still has a
+	 * deliverable interrupt, which must surface as a VTL interrupt
+	 * exit.  On a broken kernel the marker was consumed and plane 0
+	 * reaches its guest code.
+	 */
+	vcpu_run(vcpu0);
+	TEST_ASSERT(vcpu0->run->exit_reason == KVM_EXIT_HYPERV,
+		    "Expected KVM_EXIT_HYPERV, got %u (%s): the twin's pending interrupt was lost when it suspended",
+		    vcpu0->run->exit_reason,
+		    exit_reason_str(vcpu0->run->exit_reason));
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.type, KVM_EXIT_HYPERV_VTL_INTERRUPT);
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.plane, 1);
+
+	/* Enter the twin as userspace would, and let it take the vector. */
+	set_run_states(vcpu0, KVM_PLANE_RUN_STATE_USER_HOLD,
+		       twin, 0);
+	run_twin_expect_sync(vcpu0, twin_run, 3);
+	ksft_test_result_pass("suspended plane keeps its undelivered interrupt\n");
+
+	kvm_munmap(twin_run, mmap_sz);
+	kvm_vm_free(vm);
+	ksft_finished();
+}
-- 
2.50.1

