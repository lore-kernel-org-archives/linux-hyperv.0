Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32944494275;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239916; cv=none; b=P296M1CuDTSvT9AdNtY5wAWT4wQeRiR5vPOlKaRdZhLdGTONILbB9ejbL7N2lpxYHEZqg5a51zzvYZvrLfk4kBI3ukr6WQO6QK2rWl7fP9mnigcuun6sOIzPl6jNClLIpzuBjYYf1rJZ2Mgk5OVI/jJDJhCVfoHsjPUTUzNpN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239916; c=relaxed/simple;
	bh=jCMBi6eQ/grnVl9SAjrVnQbaYKWvYt+K0IXqlP6h4Yg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JKLNiX5h58tLZuOQmbwa6xwF1fZ6kAC1QyBxYOfXTG/agh3b/V7545xsd8FM2V+4tcjT7T421NXiJJvf9Ho18BruN6Yams2T6jbk8iE5Cc+QQsg3O0Tj3P6+tbipwz5LYBaot/3YUpQOb7AgKqCwiPc07OeNI6LQeQmGtK8t0Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I8a4inbr; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I8a4inbr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=SoNlLzNl8fCdPsYt+DggQWC2t367O6T7w20hEwEgKSs=; b=I8a4inbrxkczwdBGaxhIweIx5g
	MQ8D0yKP9psJweH5umZKuLiwhs5+E9vy2sY7IR1fObpiUQODT3K0G2FOES68W9CyJahq/UtT0bRxl
	MD/wkkI2oI+jye0pvmSeoZatVq+vmfBYsd1/1T3TXh7CqKoJXtPXXjlLLeikVcO8XiMQKoicehPRL
	UbTzLcVt20DQOnDmdYFSr6tLDfSRCN1ToIngJfcZCd8eVmuv4aTm/ZBwCCnm+cFG/AKWykDEJXOCV
	yHiBYeEy8vELSpu7ICQXccuu9HlgBcNDCFRLpbEucLdpKy/27r+0uQsK7cQlniKZ9k7NMYug9vyOL
	pZj+3gSw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfE-1ZpZ;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TB-00000002Yl3-4BFw;
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
Subject: [RFC PATCH 04/55] KVM: selftests: Add x86 planes lifecycle test
Date: Sat, 17 Oct 2026 13:24:10 +0100
Message-ID: <20261017122501.610248-5-dwmw2@infradead.org>
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

Cover KVM_CAP_PLANES argument validation and ordering, plane creation
bounds, plane vCPU creation, and per-plane isolation of vCPU register
state.

The tools copy of linux/kvm.h is synced to pick up the VM planes
definitions the test builds against.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/include/uapi/linux/kvm.h                |  40 +++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 tools/testing/selftests/kvm/x86/planes_test.c | 120 ++++++++++++++++++
 3 files changed, 156 insertions(+), 5 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_test.c

diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index fe2f500c932d..dcd12f58186e 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -11,6 +11,7 @@
 #include <linux/const.h>
 #include <linux/types.h>
 #include <linux/compiler.h>
+#include <linux/stddef.h>
 #include <linux/ioctl.h>
 #include <asm/kvm.h>
 
@@ -145,6 +146,13 @@ struct kvm_exit_snp_req_certs {
 	__u64 ret;
 };
 
+struct kvm_plane_event_exit {
+#define KVM_PLANE_EVENT_CREATE_VCPU	1
+	__u32 cause;
+	__u32 plane;
+	__u64 extra[8];
+};
+
 #define KVM_S390_GET_SKEYS_NONE   1
 #define KVM_S390_SKEYS_MAX        1048576
 
@@ -192,6 +200,7 @@ struct kvm_exit_snp_req_certs {
 #define KVM_EXIT_ARM_SEA          41
 #define KVM_EXIT_ARM_LDST64B      42
 #define KVM_EXIT_SNP_REQ_CERTS    43
+#define KVM_EXIT_PLANE_EVENT      44
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -456,6 +465,9 @@ struct kvm_run {
 		} notify;
 		/* KVM_EXIT_MEMORY_FAULT */
 		struct {
+#define KVM_MEMORY_EXIT_FLAG_READ       (1ULL << 0)
+#define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
+#define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 			__u64 flags;
 			__u64 gpa;
@@ -496,6 +508,8 @@ struct kvm_run {
 		} arm_sea;
 		/* KVM_EXIT_SNP_REQ_CERTS */
 		struct kvm_exit_snp_req_certs snp_req_certs;
+		/* KVM_EXIT_PLANE_EVENT */
+		struct kvm_plane_event_exit plane_event;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -542,7 +556,7 @@ struct kvm_coalesced_mmio {
 
 struct kvm_coalesced_mmio_ring {
 	__u32 first, last;
-	struct kvm_coalesced_mmio coalesced_mmio[];
+	__DECLARE_FLEX_ARRAY(struct kvm_coalesced_mmio, coalesced_mmio);
 };
 
 #define KVM_COALESCED_MMIO_MAX \
@@ -592,7 +606,7 @@ struct kvm_clear_dirty_log {
 /* for KVM_SET_SIGNAL_MASK */
 struct kvm_signal_mask {
 	__u32 len;
-	__u8  sigset[];
+	__DECLARE_FLEX_ARRAY(__u8, sigset);
 };
 
 /* for KVM_TPR_ACCESS_REPORTING */
@@ -703,6 +717,11 @@ struct kvm_enable_cap {
 #define KVM_VM_TYPE_ARM_IPA_SIZE_MASK	0xffULL
 #define KVM_VM_TYPE_ARM_IPA_SIZE(x)		\
 	((x) & KVM_VM_TYPE_ARM_IPA_SIZE_MASK)
+
+#define KVM_VM_TYPE_ARM_PROTECTED	(1UL << 31)
+#define KVM_VM_TYPE_ARM_MASK		(KVM_VM_TYPE_ARM_IPA_SIZE_MASK | \
+					 KVM_VM_TYPE_ARM_PROTECTED)
+
 /*
  * ioctls for /dev/kvm fds:
  */
@@ -724,6 +743,11 @@ struct kvm_enable_cap {
 #define KVM_GET_EMULATED_CPUID	  _IOWR(KVMIO, 0x09, struct kvm_cpuid2)
 #define KVM_GET_MSR_FEATURE_INDEX_LIST    _IOWR(KVMIO, 0x0a, struct kvm_msr_list)
 
+/*
+ * Maximum number of supported planes
+ */
+#define KVM_MAX_PLANES	16
+
 /*
  * Extension capability list.
  */
@@ -989,6 +1013,8 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_SEA_TO_USER 245
 #define KVM_CAP_S390_USER_OPEREXEC 246
 #define KVM_CAP_S390_KEYOP 247
+#define KVM_CAP_S390_VSIE_ESAMODE 248
+#define KVM_CAP_PLANES 249
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1051,7 +1077,7 @@ struct kvm_irq_routing_entry {
 struct kvm_irq_routing {
 	__u32 nr;
 	__u32 flags;
-	struct kvm_irq_routing_entry entries[];
+	__DECLARE_FLEX_ARRAY(struct kvm_irq_routing_entry, entries);
 };
 
 #define KVM_IRQFD_FLAG_DEASSIGN (1 << 0)
@@ -1142,7 +1168,7 @@ struct kvm_dirty_tlb {
 
 struct kvm_reg_list {
 	__u64 n; /* number of regs */
-	__u64 reg[];
+	__DECLARE_FLEX_ARRAY(__u64, reg);
 };
 
 struct kvm_one_reg {
@@ -1224,6 +1250,8 @@ enum kvm_device_type {
 #define KVM_DEV_TYPE_LOONGARCH_EIOINTC	KVM_DEV_TYPE_LOONGARCH_EIOINTC
 	KVM_DEV_TYPE_LOONGARCH_PCHPIC,
 #define KVM_DEV_TYPE_LOONGARCH_PCHPIC	KVM_DEV_TYPE_LOONGARCH_PCHPIC
+	KVM_DEV_TYPE_LOONGARCH_DMSINTC,
+#define KVM_DEV_TYPE_LOONGARCH_DMSINTC	KVM_DEV_TYPE_LOONGARCH_DMSINTC
 	KVM_DEV_TYPE_ARM_VGIC_V5,
 #define KVM_DEV_TYPE_ARM_VGIC_V5	KVM_DEV_TYPE_ARM_VGIC_V5
 
@@ -1340,6 +1368,8 @@ struct kvm_s390_keyop {
 #define KVM_GET_DEVICE_ATTR	  _IOW(KVMIO,  0xe2, struct kvm_device_attr)
 #define KVM_HAS_DEVICE_ATTR	  _IOW(KVMIO,  0xe3, struct kvm_device_attr)
 
+#define KVM_CREATE_PLANE	  _IO(KVMIO, 0xe4)
+
 /*
  * ioctls for vcpu fds
  */
@@ -1610,7 +1640,7 @@ struct kvm_stats_desc {
 #ifdef __KERNEL__
 	char name[KVM_STATS_NAME_SIZE];
 #else
-	char name[];
+	__DECLARE_FLEX_ARRAY(char, name);
 #endif
 };
 
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 61e767a1e31b..5883359c1a5d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -104,6 +104,7 @@ TEST_GEN_PROGS_x86 += x86/nested_tsc_scaling_test
 TEST_GEN_PROGS_x86 += x86/nested_vmsave_vmload_test
 TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/plane_x86_test
+TEST_GEN_PROGS_x86 += x86/planes_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/x86/planes_test.c b/tools/testing/selftests/kvm/x86/planes_test.c
new file mode 100644
index 000000000000..3517175580d3
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_test.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test the KVM_CAP_PLANES opt-in and the plane lifecycle uAPI: plane
+ * creation bounds, plane vCPU creation, and the independence of
+ * per-plane vCPU register state.
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "kvm_util.h"
+
+static int plane_vcpu_fd(int plane_fd, int vcpu_id)
+{
+	return __kvm_ioctl(plane_fd, KVM_CREATE_VCPU, (void *)(unsigned long)vcpu_id);
+}
+
+static void test_enable_cap_bounds(void)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+
+	/* Planes require a split irqchip; the cap itself does not. */
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 0), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, KVM_MAX_PLANES + 1), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	vm_enable_cap(vm, KVM_CAP_PLANES, KVM_MAX_PLANES);
+
+	kvm_vm_free(vm);
+}
+
+static void test_enable_cap_too_late(void)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+	int vcpu_fd;
+
+	vcpu_fd = __vm_ioctl(vm, KVM_CREATE_VCPU, NULL);
+	TEST_ASSERT(vcpu_fd >= 0, "KVM_CREATE_VCPU failed: errno %d", errno);
+
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 2), -1);
+	TEST_ASSERT_EQ(errno, EEXIST);
+
+	close(vcpu_fd);
+	kvm_vm_free(vm);
+}
+
+static void test_plane_lifecycle(void)
+{
+	struct kvm_vm *vm = vm_create_barebones();
+	struct kvm_regs regs0, regs1;
+	int plane_fd, vcpu0_fd, vcpu1_fd;
+	int r;
+
+	vm_enable_cap(vm, KVM_CAP_SPLIT_IRQCHIP, 24);
+
+	/* Without the opt-in a VM has a single plane. */
+	TEST_ASSERT_EQ(vm_check_cap(vm, KVM_CAP_PLANES), 1);
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	vm_enable_cap(vm, KVM_CAP_PLANES, 2);
+	TEST_ASSERT_EQ(vm_check_cap(vm, KVM_CAP_PLANES), 2);
+
+	/* The configured count is a hard bound, and reconfiguration a hard no. */
+	TEST_ASSERT_EQ(__vm_ioctl(vm, KVM_CREATE_PLANE, (void *)2UL), -1);
+	TEST_ASSERT_EQ(errno, EINVAL);
+
+	plane_fd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL);
+	TEST_ASSERT(plane_fd >= 0, "KVM_CREATE_PLANE failed: errno %d", errno);
+
+	TEST_ASSERT_EQ(__vm_enable_cap(vm, KVM_CAP_PLANES, 3), -1);
+	TEST_ASSERT_EQ(errno, EEXIST);
+
+	/*
+	 * A plane cannot host planes of its own.  Plane fds that do not
+	 * implement KVM_CHECK_EXTENSION at all satisfy that trivially.
+	 */
+	r = __kvm_ioctl(plane_fd, KVM_CHECK_EXTENSION, (void *)KVM_CAP_PLANES);
+	TEST_ASSERT(r == 0 || (r == -1 && errno == ENOTTY),
+		    "plane fd reports nested plane support: %d", r);
+
+	vcpu0_fd = __vm_ioctl(vm, KVM_CREATE_VCPU, NULL);
+	TEST_ASSERT(vcpu0_fd >= 0, "KVM_CREATE_VCPU failed: errno %d", errno);
+
+	vcpu1_fd = plane_vcpu_fd(plane_fd, 0);
+	TEST_ASSERT(vcpu1_fd >= 0,
+		    "KVM_CREATE_VCPU on plane 1 failed: errno %d", errno);
+
+	/* Register state is per plane: write plane 1, plane 0 unaffected. */
+	kvm_ioctl(vcpu1_fd, KVM_GET_REGS, &regs1);
+	regs1.rbx = 0x5157ca11;	/* arbitrary marker */
+	kvm_ioctl(vcpu1_fd, KVM_SET_REGS, &regs1);
+
+	kvm_ioctl(vcpu0_fd, KVM_GET_REGS, &regs0);
+	TEST_ASSERT(regs0.rbx != 0x5157ca11,
+		    "plane 0 RBX changed by plane 1 KVM_SET_REGS");
+
+	memset(&regs1, 0, sizeof(regs1));
+	kvm_ioctl(vcpu1_fd, KVM_GET_REGS, &regs1);
+	TEST_ASSERT_EQ(regs1.rbx, 0x5157ca11);
+
+	close(vcpu1_fd);
+	close(vcpu0_fd);
+	close(plane_fd);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PLANES));
+
+	test_enable_cap_bounds();
+	test_enable_cap_too_late();
+	test_plane_lifecycle();
+
+	return 0;
+}
-- 
2.50.1

