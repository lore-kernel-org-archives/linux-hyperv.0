Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4B849BB5A;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239920; cv=none; b=kTBYi5wv5vl19lAl6wx1Ug2bP6f3/Uoyvx1Dhq+O7I4RU29J2uJFHMejX5L83awa0HPlCaLGNj5YNC/MMRcW9wK7YvcGrCPzEoXuBnuwVtcM3RrEq86HXaKTI14sjt8Phk9Ra+/de/WwohjYu48JAo9kJgkcOZx/rvwetyGPxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239920; c=relaxed/simple;
	bh=oCDC5FL02Ha2LXppuDkilhsYipm4YrmDdo3S8XoDDSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNLyzSle7xHRaYzkgGmDv7GvBvfCPEPBOUzbPIz3U/BrPrVTW+E3N2QUTRnFoVPa4yT9wuiJfIUfgrawwP6Zx2cS2GfsSXxqVXhybKRlcGw3R0vMt8qabSjCXxMPrTEJYJTBugDufTBDYnhYFQOdUfrQfle34bFyEKW7d8c+uCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qJbDqX5S; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qJbDqX5S"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=vkktiuChNvXgAIyZFqLe6hzDNQgmQNcbrVQ9nG1vYmQ=; b=qJbDqX5SfPkCj6DpRP8qQl755f
	J3iC9hKchJOPqnvJcLcKc7rJ5MItE73EBIz8lqcZXOpo5e958kPSnEB4x4Nzi1RVznqaIw5rO12zj
	fYmvXMMJSlsPmoaZ5LpqDDMiHe8r4v2XHLSvG3mz9GrpTPZX7C9UdcaOTmEAqUbjM9fiApwG4YejV
	nIt8KVmsY8CbGWoe79Sq0PqtBA6MDWl9bMUFOpqhgNYtMjdF4Hoe08RiCpDGJq/TzqWalchTbMMxu
	f0dOfbMm0Gl7hnEptVQ2EG/GgSd2fuj9JOkdoAKp6FgA7WpBtY5qlMcEQXMR5bWAq/Hge0EDeOK/r
	5D7ToW2w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfD-1bsU;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TB-00000002Ykx-42Km;
	Sat, 17 Oct 2026 13:25:01 +0100
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
Subject: [RFC PATCH 03/55] KVM: selftests: Add VM plane infrastructure and tests
Date: Sat, 17 Oct 2026 13:24:09 +0100
Message-ID: <20261017122501.610248-4-dwmw2@infradead.org>
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

From: Paolo Bonzini <pbonzini@redhat.com>

Add plane and plane-vCPU wrappers to the selftest library and two tests:
plane_test (plane and plane vCPU creation, sibling rules, register state
isolation) and plane_x86_test (per-plane FPU, MSRs and LAPIC; MSI
delivery to a plane). Planes require a split IRQ chip, so the tests
create their VM with vm_create_barebones_irqchip(true).

The code is from the planes RFC's selftest work, already adapted to
the KVM_CREATE_VCPU on a plane fd shape of the posted series.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[hmushi: ported onto the posted series on kvm/next]
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>

[dwmw2: ported to this stack's uAPI: KVM_CAP_PLANES is a VM-level
 opt-in taking the plane count and must precede vCPU creation, so the
 tests enable it with 2 planes right after VM creation. The main()
 probe uses a split-irqchip VM, because kvm_arch_max_planes() reports
 1 without one, and skips when the opt-in is refused. Two subtest
 groups of the later planes series are not carried: the foreign-thread
 EBUSY test (this kernel does not restrict vCPU ioctls to the vCPU's
 own thread) and the userspace plane-switch group (this kernel drives
 plane switches through the Hyper-V VSM hypercalls).
 kvm_force_split_irqchip already exists here; all seven remaining
 subtests pass on this kernel.]
(re-done by hand from Mushahid's port)
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../testing/selftests/kvm/include/kvm_util.h  |  73 ++++
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  74 +++-
 .../testing/selftests/kvm/lib/x86/processor.c |  15 +
 tools/testing/selftests/kvm/plane_test.c      | 137 ++++++++
 .../selftests/kvm/x86/plane_x86_test.c        | 325 ++++++++++++++++++
 7 files changed, 622 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/plane_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/plane_x86_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 03da6e59e614..61e767a1e31b 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -66,6 +66,7 @@ TEST_GEN_PROGS_COMMON += kvm_page_table_test
 TEST_GEN_PROGS_COMMON += set_memory_region_test
 TEST_GEN_PROGS_COMMON += memslot_modification_stress_test
 TEST_GEN_PROGS_COMMON += memslot_perf_test
+TEST_GEN_PROGS_COMMON += plane_test
 
 # Compiled test targets
 TEST_GEN_PROGS_x86 = $(TEST_GEN_PROGS_COMMON)
@@ -102,6 +103,7 @@ TEST_GEN_PROGS_x86 += x86/nested_tsc_adjust_test
 TEST_GEN_PROGS_x86 += x86/nested_tsc_scaling_test
 TEST_GEN_PROGS_x86 += x86/nested_vmsave_vmload_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
+TEST_GEN_PROGS_x86 += x86/plane_x86_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/include/kvm_util.h b/tools/testing/selftests/kvm/include/kvm_util.h
index 4349aabc5d56..204f1474f102 100644
--- a/tools/testing/selftests/kvm/include/kvm_util.h
+++ b/tools/testing/selftests/kvm/include/kvm_util.h
@@ -74,6 +74,21 @@ struct kvm_vcpu {
 	u32 dirty_gfns_count;
 };
 
+struct kvm_plane {
+	struct list_head list;
+	uint32_t id;
+	int fd;
+	struct kvm_vm *vm;
+};
+
+struct kvm_plane_vcpu {
+	struct list_head list;
+	uint32_t id;
+	int fd;
+	struct kvm_vcpu *plane0;
+	struct kvm_plane *plane;
+};
+
 struct userspace_mem_regions {
 	struct rb_root gpa_tree;
 	struct rb_root hva_tree;
@@ -107,10 +122,13 @@ struct kvm_vm {
 	unsigned int va_bits;
 	u64 max_gfn;
 	struct list_head vcpus;
+	struct list_head planes;
+	struct list_head plane_vcpus;
 	struct userspace_mem_regions regions;
 	struct sparsebit *vpages_valid;
 	struct sparsebit *vpages_mapped;
 	bool has_irqchip;
+	bool has_split_irqchip;
 	gpa_t ucall_mmio_addr;
 	gva_t handlers;
 	u32 dirty_ring_size;
@@ -377,6 +395,21 @@ do {											\
 	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, vm);		\
 })
 
+static __always_inline void static_assert_is_plane(struct kvm_plane *plane) { }
+
+#define __plane_ioctl(plane, cmd, arg)				\
+({								\
+	static_assert_is_plane(plane);				\
+	kvm_do_ioctl((plane)->fd, cmd, arg);			\
+})
+
+#define plane_ioctl(plane, cmd, arg)				\
+({								\
+	int ret = __plane_ioctl(plane, cmd, arg);		\
+								\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (plane)->vm); \
+})
+
 static __always_inline void static_assert_is_vcpu(struct kvm_vcpu *vcpu) { }
 
 #define __vcpu_ioctl(vcpu, cmd, arg)				\
@@ -392,6 +425,21 @@ static __always_inline void static_assert_is_vcpu(struct kvm_vcpu *vcpu) { }
 	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (vcpu)->vm);	\
 })
 
+static __always_inline void static_assert_is_plane_vcpu(struct kvm_plane_vcpu *plane_vcpu) { }
+
+#define __plane_vcpu_ioctl(plane_vcpu, cmd, arg)		\
+({								\
+	static_assert_is_plane_vcpu(plane_vcpu);		\
+	kvm_do_ioctl((plane_vcpu)->fd, cmd, arg);		\
+})
+
+#define plane_vcpu_ioctl(plane_vcpu, cmd, arg)			\
+({								\
+	int ret = __plane_vcpu_ioctl(plane_vcpu, cmd, arg);	\
+								\
+	__TEST_ASSERT_VM_VCPU_IOCTL(!ret, #cmd, ret, (plane_vcpu)->plane0->vm); \
+})
+
 /*
  * Looks up and returns the value corresponding to the capability
  * (KVM_CAP_*) given by cap.
@@ -667,6 +715,17 @@ static inline bool is_smt_on(void)
 
 void vm_create_irqchip(struct kvm_vm *vm);
 
+/*
+ * Record the irqchip mode on the VM so that kvm_vm_restart() recreates
+ * the same mode, whatever kvm_force_split_irqchip says by then.
+ */
+static inline void vm_enable_split_irqchip(struct kvm_vm *vm)
+{
+	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+	vm->has_irqchip = true;
+	vm->has_split_irqchip = true;
+}
+
 static inline int __vm_create_guest_memfd(struct kvm_vm *vm, u64 size,
 					  u64 flags)
 {
@@ -717,6 +776,8 @@ void vm_mem_region_reload(struct kvm_vm *vm, u32 slot);
 void vm_mem_region_move(struct kvm_vm *vm, u32 slot, u64 new_gpa);
 void vm_mem_region_delete(struct kvm_vm *vm, u32 slot);
 struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id);
+struct kvm_plane *vm_plane_add(struct kvm_vm *vm, int plane_id);
+struct kvm_plane_vcpu *__vm_plane_vcpu_add(struct kvm_vcpu *vcpu, struct kvm_plane *plane);
 void vm_populate_gva_bitmap(struct kvm_vm *vm);
 gva_t vm_unused_gva_gap(struct kvm_vm *vm, size_t sz, gva_t min_gva);
 gva_t vm_alloc(struct kvm_vm *vm, size_t sz, gva_t min_gva);
@@ -1034,6 +1095,18 @@ static inline struct kvm_vm *vm_create_barebones(void)
 	return ____vm_create(VM_SHAPE_DEFAULT);
 }
 
+static inline struct kvm_vm *vm_create_barebones_irqchip(bool split)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+
+	if (split)
+		vm_enable_split_irqchip(vm);
+	else
+		vm_create_irqchip(vm);
+
+	return vm;
+}
+
 static inline struct kvm_vm *vm_create_barebones_type(unsigned long type)
 {
 	const struct vm_shape shape = {
diff --git a/tools/testing/selftests/kvm/include/x86/processor.h b/tools/testing/selftests/kvm/include/x86/processor.h
index 7cc09721e149..43be2d3faed9 100644
--- a/tools/testing/selftests/kvm/include/x86/processor.h
+++ b/tools/testing/selftests/kvm/include/x86/processor.h
@@ -1136,6 +1136,7 @@ static inline void vcpu_clear_cpuid_feature(struct kvm_vcpu *vcpu,
 
 u64 vcpu_get_msr(struct kvm_vcpu *vcpu, u64 msr_index);
 int _vcpu_set_msr(struct kvm_vcpu *vcpu, u64 msr_index, u64 msr_value);
+int _plane_vcpu_set_msr(struct kvm_plane_vcpu *plane_vcpu, u64 msr_index, u64 msr_value);
 
 /*
  * Assert on an MSR access(es) and pretty print the MSR name when possible.
diff --git a/tools/testing/selftests/kvm/lib/kvm_util.c b/tools/testing/selftests/kvm/lib/kvm_util.c
index e08967ef7b7b..3972c9e0486a 100644
--- a/tools/testing/selftests/kvm/lib/kvm_util.c
+++ b/tools/testing/selftests/kvm/lib/kvm_util.c
@@ -284,6 +284,8 @@ struct kvm_vm *____vm_create(struct vm_shape shape)
 	TEST_ASSERT(vm != NULL, "Insufficient Memory");
 
 	INIT_LIST_HEAD(&vm->vcpus);
+	INIT_LIST_HEAD(&vm->planes);
+	INIT_LIST_HEAD(&vm->plane_vcpus);
 	vm->regions.gpa_tree = RB_ROOT;
 	vm->regions.hva_tree = RB_ROOT;
 	hash_init(vm->regions.slot_hash);
@@ -596,7 +598,9 @@ void kvm_vm_restart(struct kvm_vm *vmp)
 	struct userspace_mem_region *region;
 
 	vm_open(vmp);
-	if (vmp->has_irqchip)
+	if (vmp->has_split_irqchip)
+		vm_enable_split_irqchip(vmp);
+	else if (vmp->has_irqchip)
 		vm_create_irqchip(vmp);
 
 	hash_for_each(vmp->regions.slot_hash, ctr, region, slot_node) {
@@ -788,11 +792,25 @@ static void vm_vcpu_rm(struct kvm_vm *vm, struct kvm_vcpu *vcpu)
 
 void kvm_vm_release(struct kvm_vm *vmp)
 {
+	struct kvm_plane_vcpu *plane_vcpu, *tmp_plane_vcpu;
+	struct kvm_plane *plane, *tmp_plane;
 	struct kvm_vcpu *vcpu, *tmp;
 
+	list_for_each_entry_safe(plane_vcpu, tmp_plane_vcpu, &vmp->plane_vcpus, list) {
+		kvm_close(plane_vcpu->fd);
+		list_del(&plane_vcpu->list);
+		free(plane_vcpu);
+	}
+
 	list_for_each_entry_safe(vcpu, tmp, &vmp->vcpus, list)
 		vm_vcpu_rm(vmp, vcpu);
 
+	list_for_each_entry_safe(plane, tmp_plane, &vmp->planes, list) {
+		kvm_close(plane->fd);
+		list_del(&plane->list);
+		free(plane);
+	}
+
 	kvm_close(vmp->fd);
 	kvm_close(vmp->kvm_fd);
 
@@ -1365,6 +1383,51 @@ struct kvm_vcpu *__vm_vcpu_add(struct kvm_vm *vm, u32 vcpu_id)
 	return vcpu;
 }
 
+/*
+ * Creates the plane with the ID given by plane_id in the VM specified by vm.
+ * No additional setup is done.  Returns the plane.
+ */
+struct kvm_plane *vm_plane_add(struct kvm_vm *vm, int plane_id)
+{
+	struct kvm_plane *plane;
+
+	plane = calloc(1, sizeof(*plane));
+	TEST_ASSERT(plane != NULL, "Insufficient Memory");
+
+	plane->fd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)(unsigned long)plane_id);
+	TEST_ASSERT_VM_VCPU_IOCTL(plane->fd >= 0, KVM_CREATE_PLANE, plane->fd, vm);
+	plane->vm = vm;
+	plane->id = plane_id;
+
+	/* Add to linked-list of planes. */
+	list_add(&plane->list, &vm->planes);
+
+	return plane;
+}
+
+/*
+ * Adds @vcpu's sibling in @plane.  No additional setup is done.  Returns the
+ * plane vCPU.
+ */
+struct kvm_plane_vcpu *__vm_plane_vcpu_add(struct kvm_vcpu *vcpu, struct kvm_plane *plane)
+{
+	struct kvm_plane_vcpu *plane_vcpu;
+
+	plane_vcpu = calloc(1, sizeof(*plane_vcpu));
+	TEST_ASSERT(plane_vcpu != NULL, "Insufficient Memory");
+
+	plane_vcpu->fd = __plane_ioctl(plane, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu->id);
+	TEST_ASSERT_VM_VCPU_IOCTL(plane_vcpu->fd >= 0, KVM_CREATE_VCPU, plane_vcpu->fd, plane->vm);
+	plane_vcpu->id = vcpu->id;
+	plane_vcpu->plane0 = vcpu;
+	plane_vcpu->plane = plane;
+
+	/* Add to linked-list of extra-plane VCPUs. */
+	list_add(&plane_vcpu->list, &plane->vm->plane_vcpus);
+
+	return plane_vcpu;
+}
+
 /*
  * Within the VM specified by @vm, locates the lowest starting guest virtual
  * address >= @min_gva, that has at least @sz unallocated bytes.  A
@@ -1644,11 +1707,12 @@ void vm_create_irqchip(struct kvm_vm *vm)
 	 * support for KVM_CREATE_IRQCHIP).
 	 */
 	r = __vm_ioctl(vm, KVM_CREATE_IRQCHIP, NULL);
-	if (r && errno == ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP))
-		vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
-	else
-		TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);
+	if (r && errno == ENOTTY && kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP)) {
+		vm_enable_split_irqchip(vm);
+		return;
+	}
 
+	TEST_ASSERT_VM_VCPU_IOCTL(!r, KVM_CREATE_IRQCHIP, r, vm);
 	vm->has_irqchip = true;
 }
 
diff --git a/tools/testing/selftests/kvm/lib/x86/processor.c b/tools/testing/selftests/kvm/lib/x86/processor.c
index 947fc31c0acb..8d8eb3552be1 100644
--- a/tools/testing/selftests/kvm/lib/x86/processor.c
+++ b/tools/testing/selftests/kvm/lib/x86/processor.c
@@ -1092,6 +1092,21 @@ int _vcpu_set_msr(struct kvm_vcpu *vcpu, u64 msr_index, u64 msr_value)
 	return __vcpu_ioctl(vcpu, KVM_SET_MSRS, &buffer.header);
 }
 
+int _plane_vcpu_set_msr(struct kvm_plane_vcpu *plane_vcpu, u64 msr_index, u64 msr_value)
+{
+	struct {
+		struct kvm_msrs header;
+		struct kvm_msr_entry entry;
+	} buffer = {};
+
+	memset(&buffer, 0, sizeof(buffer));
+	buffer.header.nmsrs = 1;
+	buffer.entry.index = msr_index;
+	buffer.entry.data = msr_value;
+
+	return __plane_vcpu_ioctl(plane_vcpu, KVM_SET_MSRS, &buffer.header);
+}
+
 void vcpu_args_set(struct kvm_vcpu *vcpu, unsigned int num, ...)
 {
 	va_list ap;
diff --git a/tools/testing/selftests/kvm/plane_test.c b/tools/testing/selftests/kvm/plane_test.c
new file mode 100644
index 000000000000..cfa90275b323
--- /dev/null
+++ b/tools/testing/selftests/kvm/plane_test.c
@@ -0,0 +1,137 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Red Hat, Inc.
+ *
+ * Test for architecture-neutral VM plane functionality
+ */
+#include <fcntl.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "asm/kvm.h"
+#include "linux/kvm.h"
+
+/*
+ * Port note (dwmw stack): KVM_CAP_PLANES is a VM-level opt-in that takes
+ * the plane count and must precede vCPU creation; planes are not
+ * always-on.  The upstream planes series' foreign-thread EBUSY subtest is
+ * omitted: this kernel does not restrict vCPU ioctls to the vCPU's own
+ * thread.  The assertions below are otherwise unchanged.
+ */
+#define NR_PLANES 2
+
+static void enable_planes(struct kvm_vm *vm)
+{
+	vm_enable_cap(vm, KVM_CAP_PLANES, NR_PLANES);
+}
+
+void test_create_plane_errors(int max_planes)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	int planefd, plane_vcpufd;
+
+	/* Planes require an in-kernel (split) IRQ chip. */
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+	vcpu = __vm_vcpu_add(vm, 0);
+
+	planefd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)(unsigned long)0);
+	TEST_ASSERT(planefd == -1 && errno == EEXIST,
+		    "Creating existing plane, expecting EEXIST. ret: %d, errno: %d",
+		    planefd, errno);
+
+	planefd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)(unsigned long)max_planes);
+	TEST_ASSERT(planefd == -1 && errno == EINVAL,
+		    "Creating plane %d, expecting EINVAL. ret: %d, errno: %d",
+		    max_planes, planefd, errno);
+
+	plane_vcpufd = __vm_ioctl(vm, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu->id);
+	TEST_ASSERT(plane_vcpufd == -1 && errno == EEXIST,
+		    "Creating existing vCPU for plane 0, expecting EEXIST. ret: %d, errno: %d",
+		    plane_vcpufd, errno);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("error conditions\n");
+}
+
+void test_create_plane(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_plane *plane;
+	int r;
+
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+	vcpu = __vm_vcpu_add(vm, 0);
+
+	plane = vm_plane_add(vm, 1);
+
+	/* A plane fd takes plane ioctls only; capabilities are a VM matter. */
+	r = __plane_ioctl(plane, KVM_CHECK_EXTENSION, (void *)(unsigned long)KVM_CAP_PLANES);
+	TEST_ASSERT(r == -1 && errno == ENOTTY,
+		    "KVM_CHECK_EXTENSION on a plane fd, expecting ENOTTY. ret: %d, errno: %d",
+		    r, errno);
+
+	r = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)(unsigned long)1);
+	TEST_ASSERT(r == -1 && errno == EEXIST,
+		    "Creating existing plane, expecting EEXIST. ret: %d, errno: %d",
+		    r, errno);
+
+	__vm_plane_vcpu_add(vcpu, plane);
+
+	r = __plane_ioctl(plane, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu->id);
+	TEST_ASSERT(r == -1 && errno == EEXIST,
+		    "Creating vCPU again for plane 1. ret: %d, errno: %d",
+		    r, errno);
+
+	r = __plane_ioctl(plane, KVM_RUN, (void *)(unsigned long)0);
+	TEST_ASSERT(r == -1 && errno == ENOTTY,
+		    "Running plane vCPU again for plane 1. ret: %d, errno: %d",
+		    r, errno);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("basic planefd and plane_vcpufd operation\n");
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vm *vm;
+	int cap_planes = 0;
+
+	/*
+	 * kvm_arch_max_planes() reports 1 without a split irqchip, so the
+	 * probe VM needs one even though the opt-in itself does not.  On
+	 * architectures without KVM_CAP_SPLIT_IRQCHIP the vm_enable_cap()
+	 * inside vm_create_barebones_irqchip() would assert, turning the
+	 * missing feature into a failure instead of a skip.
+	 */
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_SPLIT_IRQCHIP));
+
+	vm = vm_create_barebones_irqchip(true);
+
+	if (!__vm_enable_cap(vm, KVM_CAP_PLANES, NR_PLANES))
+		cap_planes = vm_check_cap(vm, KVM_CAP_PLANES);
+
+	kvm_vm_free(vm);
+	TEST_REQUIRE(cap_planes);
+
+	ksft_print_header();
+	ksft_set_plan(2);
+
+	pr_info("# KVM_CAP_PLANES: %d\n", cap_planes);
+
+	test_create_plane_errors(cap_planes);
+
+	if (cap_planes > 1)
+		test_create_plane();
+	else
+		ksft_test_result_skip("plane creation requires KVM_CAP_PLANES > 1\n");
+
+	ksft_finished();
+}
diff --git a/tools/testing/selftests/kvm/x86/plane_x86_test.c b/tools/testing/selftests/kvm/x86/plane_x86_test.c
new file mode 100644
index 000000000000..870be9c68050
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/plane_x86_test.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2025 Red Hat, Inc.
+ *
+ * Test for x86-specific VM plane functionality
+ */
+#include <fcntl.h>
+#include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+
+#include "test_util.h"
+
+#include "kvm_util.h"
+#include "processor.h"
+#include "apic.h"
+#include "asm/kvm.h"
+#include "linux/kvm.h"
+
+/*
+ * Port note (dwmw stack): KVM_CAP_PLANES is a VM-level opt-in that takes
+ * the plane count and must precede vCPU creation; planes are not
+ * always-on.  The KVM_CAP_PLANES_USERSPACE_SWITCH subtests of the
+ * upstream planes series (userspace plane switch, lower/not-runnable
+ * interrupt events, CPUID runtime bits, hugepage mixed attributes) are
+ * omitted: this kernel drives plane switches through the Hyper-V VSM
+ * hypercalls and has no userspace-switch capability.  The remaining
+ * subtests' assertions are unchanged.
+ */
+#define NR_PLANES 2
+
+static void enable_planes(struct kvm_vm *vm)
+{
+	vm_enable_cap(vm, KVM_CAP_PLANES, NR_PLANES);
+}
+
+static void test_plane_regs(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_plane *plane;
+	struct kvm_plane_vcpu *plane_vcpu;
+
+	struct kvm_regs regs0, regs1;
+
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+	vcpu = __vm_vcpu_add(vm, 0);
+	plane = vm_plane_add(vm, 1);
+	plane_vcpu = __vm_plane_vcpu_add(vcpu, plane);
+
+	vcpu_ioctl(vcpu, KVM_GET_REGS, &regs0);
+	plane_vcpu_ioctl(plane_vcpu, KVM_GET_REGS, &regs1);
+	regs0.rax = 0x12345678;
+	regs1.rax = 0x87654321;
+
+	vcpu_ioctl(vcpu, KVM_SET_REGS, &regs0);
+	plane_vcpu_ioctl(plane_vcpu, KVM_SET_REGS, &regs1);
+
+	vcpu_ioctl(vcpu, KVM_GET_REGS, &regs0);
+	plane_vcpu_ioctl(plane_vcpu, KVM_GET_REGS, &regs1);
+	TEST_ASSERT_EQ(regs0.rax, 0x12345678);
+	TEST_ASSERT_EQ(regs1.rax, 0x87654321);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("get/set regs for planes\n");
+}
+
+/*
+ * The planes of a VP share one TSC: a plane vCPU created later must take the
+ * TSC offset of its sibling, not start a new one.  Read the guest TSC on both
+ * fds back to back; the difference is the elapsed host time, not an offset.
+ */
+static void test_plane_tsc_offset(void)
+{
+	struct {
+		struct kvm_msrs header;
+		struct kvm_msr_entry entry;
+	} msrs0 = { .header.nmsrs = 1, .entry.index = MSR_IA32_TSC };
+	struct kvm_plane_vcpu *plane_vcpu;
+	struct kvm_plane *plane;
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	u64 tsc0, tsc1, bound;
+
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+	vcpu = __vm_vcpu_add(vm, 0);
+	plane = vm_plane_add(vm, 1);
+	plane_vcpu = __vm_plane_vcpu_add(vcpu, plane);
+
+	TEST_ASSERT_EQ(__vcpu_ioctl(vcpu, KVM_GET_MSRS, &msrs0.header), 1);
+	tsc0 = msrs0.entry.data;
+	TEST_ASSERT_EQ(__plane_vcpu_ioctl(plane_vcpu, KVM_GET_MSRS, &msrs0.header), 1);
+	tsc1 = msrs0.entry.data;
+
+	/* One second of guest TSC; an unshared offset is off by far more. */
+	bound = (u64)__vcpu_ioctl(vcpu, KVM_GET_TSC_KHZ, NULL) * 1000;
+	TEST_ASSERT(tsc1 >= tsc0 && tsc1 - tsc0 < bound,
+		    "plane 1 TSC 0x%lx is not plane 0 TSC 0x%lx plus elapsed time",
+		    tsc1, tsc0);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("plane vCPU shares the TSC offset\n");
+}
+
+/* Offset of XMM0 in the legacy XSAVE area.  */
+#define XSTATE_BV_OFFSET	(0x200/4)
+#define XMM_OFFSET		(0xa0/4)
+
+static void test_plane_fpu_nonshared(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_plane *plane;
+	struct kvm_plane_vcpu *plane_vcpu;
+
+	struct kvm_xsave xsave0, xsave1;
+
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+
+	vcpu = __vm_vcpu_add(vm, 0);
+	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vcpu);
+
+	plane = vm_plane_add(vm, 1);
+	plane_vcpu = __vm_plane_vcpu_add(vcpu, plane);
+
+	vcpu_ioctl(vcpu, KVM_GET_XSAVE, &xsave0);
+	xsave0.region[XSTATE_BV_OFFSET] |= XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
+	xsave0.region[XMM_OFFSET] = 0x12345678;
+	vcpu_ioctl(vcpu, KVM_SET_XSAVE, &xsave0);
+
+	plane_vcpu_ioctl(plane_vcpu, KVM_GET_XSAVE, &xsave1);
+	xsave1.region[XSTATE_BV_OFFSET] |= XFEATURE_MASK_FP | XFEATURE_MASK_SSE;
+	xsave1.region[XMM_OFFSET] = 0x87654321;
+	plane_vcpu_ioctl(plane_vcpu, KVM_SET_XSAVE, &xsave1);
+
+	memset(&xsave0, 0, sizeof(xsave0));
+	vcpu_ioctl(vcpu, KVM_GET_XSAVE, &xsave0);
+	TEST_ASSERT_EQ(xsave0.region[XMM_OFFSET], 0x12345678);
+
+	memset(&xsave1, 0, sizeof(xsave0));
+	plane_vcpu_ioctl(plane_vcpu, KVM_GET_XSAVE, &xsave1);
+	TEST_ASSERT_EQ(xsave1.region[XMM_OFFSET], 0x87654321);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("get/set FPU not shared across planes\n");
+}
+
+#define APIC_SPIV		0xF0
+#define APIC_IRR		0x200
+
+#define MYVEC			192
+
+/* Physical destination mode: destination id in address bits 19:12. */
+#define MAKE_MSI(cpu, vector) ((struct kvm_msi){			\
+	.address_lo = APIC_DEFAULT_GPA + (((cpu) & 0xff) << 12),	\
+	.address_hi = (cpu) & ~0xff,					\
+	.data = (vector),						\
+})
+
+static bool has_irr(struct kvm_lapic_state *apic, int vector)
+{
+	int word = vector >> 5;
+	int bit_in_word = vector & 31;
+	int bit = (APIC_IRR + word * 16) * CHAR_BIT + (bit_in_word & 31);
+
+	return apic->regs[bit >> 3] & (1 << (bit & 7));
+}
+
+static void do_enable_lapic(struct kvm_lapic_state *apic)
+{
+	/* set bit 8 */
+	apic->regs[APIC_SPIV + 1] |= 1;
+}
+
+static void test_plane_msi(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu;
+	struct kvm_plane *plane;
+	struct kvm_plane_vcpu *plane_vcpu;
+	int r;
+
+	struct kvm_msi msi = MAKE_MSI(0, MYVEC);
+	struct kvm_lapic_state lapic0, lapic1;
+
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+
+	vcpu = __vm_vcpu_add(vm, 0);
+	vcpu_init_cpuid(vcpu, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vcpu);
+
+	plane = vm_plane_add(vm, 1);
+	plane_vcpu = __vm_plane_vcpu_add(vcpu, plane);
+
+	vcpu_set_msr(vcpu, MSR_IA32_APICBASE,
+		     APIC_DEFAULT_GPA | MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic0);
+	do_enable_lapic(&lapic0);
+	vcpu_ioctl(vcpu, KVM_SET_LAPIC, &lapic0);
+
+	_plane_vcpu_set_msr(plane_vcpu, MSR_IA32_APICBASE,
+			    APIC_DEFAULT_GPA | MSR_IA32_APICBASE_ENABLE | X2APIC_ENABLE);
+	plane_vcpu_ioctl(plane_vcpu, KVM_GET_LAPIC, &lapic1);
+	do_enable_lapic(&lapic1);
+	plane_vcpu_ioctl(plane_vcpu, KVM_SET_LAPIC, &lapic1);
+
+	/* Deliver to plane 1 (via the plane fd); it must land only in plane 1. */
+	r = __plane_ioctl(plane, KVM_SIGNAL_MSI, &msi);
+	TEST_ASSERT(r == 1,
+		   "Delivering interrupt to plane 1. ret: %d, errno: %d", r, errno);
+
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic0);
+	TEST_ASSERT(!has_irr(&lapic0, MYVEC), "Vector clear in plane 0");
+	plane_vcpu_ioctl(plane_vcpu, KVM_GET_LAPIC, &lapic1);
+	TEST_ASSERT(has_irr(&lapic1, MYVEC), "Vector set in plane 1");
+
+	/* Deliver to plane 0 (via the vm fd); it must land in plane 0. */
+	r = __vm_ioctl(vm, KVM_SIGNAL_MSI, &msi);
+	TEST_ASSERT(r == 1,
+		   "Delivering interrupt to plane 0. ret: %d, errno: %d", r, errno);
+	vcpu_ioctl(vcpu, KVM_GET_LAPIC, &lapic0);
+	TEST_ASSERT(has_irr(&lapic0, MYVEC), "Vector set in plane 0");
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("signal MSI routed per plane\n");
+}
+
+/*
+ * MP_STATE is per plane vCPU: a plane vCPU whose id is not the BSP's starts
+ * uninitialized while its plane-0 sibling runs; setting it does not touch the
+ * sibling; an INIT signalled to the plane's LAPIC is accepted on the plane fd.
+ */
+static void test_plane_mp_state(void)
+{
+	struct kvm_vm *vm;
+	struct kvm_vcpu *vcpu0, *vcpu1;
+	struct kvm_plane *plane;
+	struct kvm_plane_vcpu *plane_vcpu0, *plane_vcpu1;
+	struct kvm_mp_state mp_state;
+	struct kvm_msi init_msi = MAKE_MSI(1, 0);
+	int r;
+
+	vm = vm_create_barebones_irqchip(true);
+	enable_planes(vm);
+
+	vcpu0 = __vm_vcpu_add(vm, 0);
+	vcpu_init_cpuid(vcpu0, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vcpu0);
+	vcpu1 = __vm_vcpu_add(vm, 1);
+	vcpu_init_cpuid(vcpu1, kvm_get_supported_cpuid());
+	vcpu_set_cpuid(vcpu1);
+
+	plane = vm_plane_add(vm, 1);
+	plane_vcpu0 = __vm_plane_vcpu_add(vcpu0, plane);
+	plane_vcpu1 = __vm_plane_vcpu_add(vcpu1, plane);
+
+	/* BSP id starts runnable in every plane, the others uninitialized. */
+	plane_vcpu_ioctl(plane_vcpu0, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_RUNNABLE);
+	plane_vcpu_ioctl(plane_vcpu1, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_UNINITIALIZED);
+	vcpu_ioctl(vcpu1, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_UNINITIALIZED);
+
+	/* Setting plane 1's state leaves plane 0's alone, and vice versa. */
+	mp_state.mp_state = KVM_MP_STATE_RUNNABLE;
+	plane_vcpu_ioctl(plane_vcpu1, KVM_SET_MP_STATE, &mp_state);
+	vcpu_ioctl(vcpu1, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_UNINITIALIZED);
+	plane_vcpu_ioctl(plane_vcpu1, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_RUNNABLE);
+
+	mp_state.mp_state = KVM_MP_STATE_HALTED;
+	vcpu_ioctl(vcpu1, KVM_SET_MP_STATE, &mp_state);
+	plane_vcpu_ioctl(plane_vcpu1, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_RUNNABLE);
+
+	mp_state.mp_state = KVM_MP_STATE_INIT_RECEIVED;
+	plane_vcpu_ioctl(plane_vcpu1, KVM_SET_MP_STATE, &mp_state);
+	plane_vcpu_ioctl(plane_vcpu1, KVM_GET_MP_STATE, &mp_state);
+	TEST_ASSERT_EQ(mp_state.mp_state, KVM_MP_STATE_INIT_RECEIVED);
+
+	/* An INIT to the plane's LAPIC is accepted on the plane fd. */
+	init_msi.data |= APIC_DM_INIT;
+	r = __plane_ioctl(plane, KVM_SIGNAL_MSI, &init_msi);
+	TEST_ASSERT(r == 1, "INIT to plane 1 vCPU 1. ret: %d, errno: %d", r, errno);
+
+	kvm_vm_free(vm);
+	ksft_test_result_pass("MP_STATE per plane vCPU\n");
+}
+
+int main(int argc, char *argv[])
+{
+	/*
+	 * kvm_arch_max_planes() reports 1 without a split irqchip, so the
+	 * probe VM needs one even though the opt-in itself does not.
+	 */
+	struct kvm_vm *vm = vm_create_barebones_irqchip(true);
+	int cap_planes = 0;
+
+	if (!__vm_enable_cap(vm, KVM_CAP_PLANES, NR_PLANES))
+		cap_planes = vm_check_cap(vm, KVM_CAP_PLANES);
+
+	kvm_vm_free(vm);
+	TEST_REQUIRE(cap_planes > 1);
+
+	ksft_print_header();
+	ksft_set_plan(5);
+
+	pr_info("# KVM_CAP_PLANES: %d\n", cap_planes);
+
+	test_plane_regs();
+	test_plane_tsc_offset();
+	test_plane_fpu_nonshared();
+	test_plane_msi();
+	test_plane_mp_state();
+
+	ksft_finished();
+}
-- 
2.50.1

