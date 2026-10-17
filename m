Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4FF49BB70;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239919; cv=none; b=B2ypouh4mTqBl+ylmU1AtgoQJRLaOxZXwyJUkwQxO+8MpXyb+Iumsas1rk78GaBGFzhUsa1P6PG1CxZDKk2Z4yIVa+FboYiwE3osIcDWKrCbO9GzYFqoCLrha8UEOQefoinaW9Nv3HConw/VnK4LsdVpfmvElwgD4FvTsz9kEpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239919; c=relaxed/simple;
	bh=J9dRjD1ZfGZ92mmh2CPWOLccOcT8Rk9mPK2VhjPeL2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l6pzprdSyE/tfGVscktyigLqoaCpUN7wQ7hO3rfpi7zJm6vdSPmfa4CMWDw5rg1ZnCIZEYaJ9IYi6IP5sNYQ/VVX8j0WoxctaEnyMxMwBgCAdH7qLdG5+6xs9z9xCX9CEMvSKL2aF1wp7IYUyLDi27Kcd/aCklCzBW/q6ffRPrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Q9c6DlOa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q9c6DlOa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gpKaeeTNjO8Hx0ukcJtpanqGTARh6GYYusE9YFi4UGs=; b=Q9c6DlOaMDH7BDTFzYuaOKCW4r
	ULMEdEDBa2GzBtEHJKQTcFOO5nBiupyNULOXB7k2opsUjcedGovhrRHvTi/DgvHBD0Kg8QHQ1KQEy
	U2SLWAYOOhiVFs5zqacmo/thieqnvMAw2LnI/KYSxno/gO6bDgVkr9MKIcmKLyTdPxC2dGjiSJXvs
	2bwiOQ6sXjA+iT+hhBrstHtU12Zy59v0WAV2Z6dWu6lkEd0icpHBFd5EUhPIYPd9+S0QmdAehSAcA
	cfLHUfFtPNajHizc9RbKWAO4vj+SecWYMlbx77FPelYZiXIszhv2wl0WnjZHoWODpU0MbL+ULXOsa
	M7OFqA0g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002Lfb-1wmx;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ynu-4BQ0;
	Sat, 17 Oct 2026 13:25:03 +0100
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
Subject: [RFC PATCH 45/55] KVM: selftests: Test a plane suspending with an undelivered interrupt
Date: Sat, 17 Oct 2026 13:24:51 +0100
Message-ID: <20261017122501.610248-46-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Pin the forced-VTL-entry re-arm: a plane-1 twin self-IPIs with IF
clear, runs on (consuming its single-shot hv_apic_event_pending
marker), and is then suspended by KVM_SET_PLANE_RUN_STATE exactly like
a userspace VTL switch.  Running plane 0 must report the suspended
twin's deliverable interrupt as a KVM_EXIT_HYPERV_VTL_INTERRUPT exit,
and the re-entered twin must receive the vector once it sets IF.  On a
kernel without the re-arm, plane 0 reaches its guest code and the
twin's interrupt is stranded in its IRR, which is the Windows VSM
hibernate deadlock in miniature.

The default selftest VM owns a fully in-kernel irqchip, which planes
refuse; add a kvm_force_split_irqchip override to the library (as in
the public planes tree) so a planes test can use the stock VM setup.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../testing/selftests/kvm/include/kvm_util.h  |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  11 +
 .../selftests/kvm/x86/planes_vtl_entry_test.c | 188 ++++++++++++++++++
 4 files changed, 201 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 66b16987d6e2..47c7a4c732eb 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -107,6 +107,7 @@ TEST_GEN_PROGS_x86 += x86/nested_vmsave_vmload_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/plane_x86_test
 TEST_GEN_PROGS_x86 += x86/planes_test
+TEST_GEN_PROGS_x86 += x86/planes_vtl_entry_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 204f1474f102..d628e31f8bb4 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -713,6 +713,7 @@ static inline bool is_smt_on(void)
 	return false;
 }
 
+extern bool kvm_force_split_irqchip;
 void vm_create_irqchip(struct kvm_vm *vm);
 
 /*
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index 3972c9e0486a..0bd8b29af6f7 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -1696,11 +1696,22 @@ void *addr_gpa2alias(struct kvm_vm *vm, gpa_t gpa)
 	return (void *) ((uintptr_t) region->host_alias + offset);
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
index 000000000000..3ad402d32ed1
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c
@@ -0,0 +1,188 @@
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
+
+#ifndef KVM_EXIT_HYPERV_VTL_INTERRUPT
+#define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+#endif
+
+#define TEST_VECTOR		0xe0
+#define TWIN_SYNC_PORT		0x7e
+#define TWIN_STACK_PAGES	4
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
+static void set_plane_run_state(int vcpu_fd, u32 state)
+{
+	int r = ioctl(vcpu_fd, KVM_SET_PLANE_RUN_STATE, &state);
+
+	TEST_ASSERT(!r, "KVM_SET_PLANE_RUN_STATE(%u) failed: errno %d",
+		    state, errno);
+}
+
+static void run_twin_expect_sync(struct kvm_vcpu *vcpu0,
+				 struct kvm_run *twin_run, uint8_t stage)
+{
+	int r = ioctl(vcpu0->fd, KVM_RUN, NULL);
+
+	TEST_ASSERT(!r, "KVM_RUN (twin runnable) failed: errno %d", errno);
+	TEST_ASSERT_EQ(twin_run->exit_reason, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(twin_run->io.port, TWIN_SYNC_PORT);
+	TEST_ASSERT_EQ(*((uint8_t *)twin_run + twin_run->io.data_offset), stage);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_run *twin_run;
+	struct kvm_vcpu *vcpu0;
+	struct kvm_vm *vm;
+	gva_t twin_stack;
+	int plane_fd, twin_fd, mmap_sz, r;
+
+	kvm_force_split_irqchip = true;
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	kvm_force_split_irqchip = false;
+
+	TEST_REQUIRE(vm_check_cap(vm, KVM_CAP_PLANES) >= 1);
+	TEST_REQUIRE(__vm_enable_cap(vm, KVM_CAP_PLANES, 2) == 0);
+
+	vcpu0 = vm_vcpu_add(vm, 0, plane0_guest_code);
+
+	plane_fd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL);
+	TEST_ASSERT(plane_fd >= 0, "KVM_CREATE_PLANE failed: errno %d", errno);
+	twin_fd = __kvm_ioctl(plane_fd, KVM_CREATE_VCPU, NULL);
+	TEST_ASSERT(twin_fd >= 0, "KVM_CREATE_VCPU on plane 1 failed: errno %d",
+		    errno);
+
+	mmap_sz = ioctl(vm->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	TEST_ASSERT(mmap_sz >= (int)sizeof(*twin_run),
+		    "KVM_GET_VCPU_MMAP_SIZE failed");
+	twin_run = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, MAP_SHARED,
+			twin_fd, 0);
+	TEST_ASSERT(twin_run != MAP_FAILED, "mmap of twin kvm_run failed");
+
+	vm_install_exception_handler(vm, TEST_VECTOR, twin_ipi_handler);
+
+	/*
+	 * The twin shares the mode and page tables with plane 0: reuse
+	 * plane 0's segment state and point it at its own code and stack.
+	 * RFLAGS keeps IF clear.
+	 */
+	vcpu_sregs_get(vcpu0, &sregs);
+	r = ioctl(twin_fd, KVM_SET_SREGS, &sregs);
+	TEST_ASSERT(!r, "KVM_SET_SREGS on twin failed: errno %d", errno);
+
+	twin_stack = vm_alloc_pages(vm, TWIN_STACK_PAGES);
+	r = ioctl(twin_fd, KVM_GET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_GET_REGS on twin failed: errno %d", errno);
+	regs.rip = (unsigned long)twin_guest_code;
+	regs.rsp = twin_stack + TWIN_STACK_PAGES * getpagesize() - 16;
+	regs.rflags = 0x2;
+	r = ioctl(twin_fd, KVM_SET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_SET_REGS on twin failed: errno %d", errno);
+
+	/*
+	 * Run the twin as a userspace VTL switch would: twin runnable,
+	 * plane 0 stopped.  The twin self-IPIs with IF clear, so the
+	 * vector lands in its IRR without being delivered, and the
+	 * second sync guarantees a fresh guest entry consumed the
+	 * forced-entry marker.
+	 */
+	set_plane_run_state(twin_fd, KVM_PLANE_RUN_STATE_RUNNABLE);
+	set_plane_run_state(vcpu0->fd, KVM_PLANE_RUN_STATE_STOPPED);
+	run_twin_expect_sync(vcpu0, twin_run, 1);
+	run_twin_expect_sync(vcpu0, twin_run, 2);
+
+	/* Suspend the twin with the vector still latched in its IRR. */
+	set_plane_run_state(twin_fd, KVM_PLANE_RUN_STATE_STOPPED);
+	set_plane_run_state(vcpu0->fd, KVM_PLANE_RUN_STATE_RUNNABLE);
+
+	/*
+	 * Plane 0 must not run the guest: the suspended twin still has a
+	 * deliverable interrupt, which must surface as a VTL interrupt
+	 * exit.  On a broken kernel the marker was consumed and plane 0
+	 * reaches its guest code.
+	 */
+	r = ioctl(vcpu0->fd, KVM_RUN, NULL);
+	TEST_ASSERT(!r, "KVM_RUN (plane 0) failed: errno %d", errno);
+	TEST_ASSERT(vcpu0->run->exit_reason == KVM_EXIT_HYPERV,
+		    "Expected KVM_EXIT_HYPERV, got %u (%s): the twin's pending "
+		    "interrupt was lost when it suspended",
+		    vcpu0->run->exit_reason,
+		    exit_reason_str(vcpu0->run->exit_reason));
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.type, KVM_EXIT_HYPERV_VTL_INTERRUPT);
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.plane, 1);
+
+	/* Enter the twin as userspace would, and let it take the vector. */
+	set_plane_run_state(twin_fd, KVM_PLANE_RUN_STATE_RUNNABLE);
+	set_plane_run_state(vcpu0->fd, KVM_PLANE_RUN_STATE_STOPPED);
+	run_twin_expect_sync(vcpu0, twin_run, 3);
+
+	kvm_munmap(twin_run, mmap_sz);
+	close(twin_fd);
+	close(plane_fd);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

