Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE1648DB23;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239912; cv=none; b=G7xFxZZvvYzO1gsCWkPd8zG6tyMqXyXGhU0zNAEbjnuCnwYiHKDQkxMMQC+uecVs4SzqK0BeLlBEWUgGixsus95Yhl40zZTbCVXFE+RrkYxDaBxzVeNC3c7cM6RsD+qwTL83qLGPzkCLLCXafwcZwyRhorOA9e7sM9pnr9isuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239912; c=relaxed/simple;
	bh=tDeunYUFuEWzu5ownnoauD9CXI8XrCcW5m5E9n1BdJg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y10sH9s+dRPc9zRybjScqML+onOsW5k/yv4x8+hhSjqav42J6bUsYaikDDPiJ+LnqH/4c4lRaXXw/QIyA8mj0rdLtT1scAPpYXazsKe7IQ+8Ze51x1E94lbJDNXIS1cfwiNacn9cq2YQoIuT1HCr0PsAPzAgqwEsSNz7xZYDC+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jtd7czLh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jtd7czLh"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Qxl3wPtwLoHLa2mlOVBNAW9sJp1d4+b6Xncxzwd7ct4=; b=jtd7czLhqhbfFJVwihYPzfhPCO
	dd4JLfDPjVnp/NzGNZudzo0NT5h4fipy78NGxj9FrZVM/oo7nUUt5CZzuKHyH4O8xRddJl6ogYunN
	sWMz8keXqbsKRUoYesFxPWrX4QyGI5E70WpcL/ZvVT8h24QJy5VyLtexJlP5pN4d+CYXZLlgykf6v
	RuEe8c2YyLD6cC757Vd44EXVsPv7ozhXPo4QIXUSK2gyQjIPuwyZoJTQjPNo2b188OzYQHMCkqpVN
	6D5B7s40k61aT6dQl6ktILBiXDw6XvrByZ4zHFn0Q9IyenSd28fPjnvzXdACJ57klBfTIWStXUTmb
	974Fr6kA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVCW-2B5A;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YmW-08zh;
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
Subject: [RFC PATCH 25/55] WIP: KVM: per-plane memory overlays, richer protection-fault exits
Date: Sat, 17 Oct 2026 13:24:31 +0100
Message-ID: <20261017122501.610248-26-dwmw2@infradead.org>
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

The pieces the VSM contract tests need:

- KVM_SET_PLANE_MEMORY_OVERLAY maps one page of userspace memory over
  a GPA for a single plane. TLFS overlay pages (SynIC SIMP in
  particular) show each VTL a private page while the other VTLs keep
  seeing the guest RAM underneath; per-plane EPT roots make a
  per-plane pfn override in the fault path sufficient. Mappings for a
  plane with overlays stay 4KiB so a neighbouring fault's huge page
  cannot span an overlaid gfn, and kvm_tdp_mmu_recover_huge_pages()
  skips nonzero-plane roots so a later promotion cannot widen the
  plane's attribute or overlay clamps back out (planes keep no lpage
  tracking by design; their fault path rebuilds each mapping at the
  largest level the plane allows). The overlay update runs under the
  kvm_mmu_invalidate_begin()/end() protocol with the gfn registered,
  as the mmu notifiers do, so a concurrent lockless fault cannot
  install an SPTE for the old backing after the zap.

- SynIC message delivery reads and writes the overlay through the same
  lookup, and fails with -EFAULT when a higher plane's SIMP page has
  no overlay installed yet, rather than falling through to
  kvm_vcpu_write_guest_page() and corrupting underlay RAM that plane 0
  owns; the sender retries once the overlay appears. A non-zero
  plane's SynIC exits carry the plane instead of being suppressed, so
  the VMM can keep its plane-0 device state separate.

- A plane-protection fault reflected as KVM_EXIT_MEMORY_FAULT now
  carries the guest-linear address and the faulting instruction's
  length and bytes (via VM_EXIT_INSTRUCTION_LEN and a guest-virt
  read), which the TLFS GPA-intercept message requires. LLDT joins
  LGDT/LIDT in the descriptor-write divert, reporting the written
  selector.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst |  62 ++++++++
 arch/x86/kvm/hyperv.c          |  82 +++++++---
 arch/x86/kvm/mmu/mmu.c         |  29 +++-
 arch/x86/kvm/mmu/tdp_mmu.c     |  23 ++-
 arch/x86/kvm/vmx/vmx.c         |  51 ++++++-
 arch/x86/kvm/x86.c             |  14 ++
 include/linux/kvm_host.h       |  17 +++
 include/uapi/linux/kvm.h       |  17 +++
 virt/kvm/kvm_main.c            | 271 +++++++++++++++++++++++++++++++++
 9 files changed, 541 insertions(+), 25 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 3ef57b3b050b..215547802377 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6657,6 +6657,38 @@ stop policy.
 The run state is distinct from KVM_GET/SET_MP_STATE, which describes
 the architectural state of a vCPU within its plane.
 
+4.149 KVM_SET_PLANE_MEMORY_OVERLAY
+----------------------------------
+
+:Capability: KVM_CAP_PLANE_MEMORY_OVERLAYS
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_plane_memory_overlay (in)
+:Returns: 0 on success, <0 on error
+
+::
+
+  struct kvm_plane_memory_overlay {
+	__u32 plane;
+	__u32 flags;
+	__u64 gfn;
+	__u64 uaddr;		/* page-aligned; 0 removes the overlay */
+  };
+
+Installs, replaces or removes a memory overlay for a single guest page
+frame on one plane.  While an overlay is installed, translations of
+'gfn' for vCPUs of 'plane' resolve to the (pinned) page at 'uaddr' in
+the calling process instead of to the memslot backing; other planes are
+unaffected.  Hyper-V VSM uses this for per-VTL overlay pages such as
+the SynIC message and event-flags pages.
+
+'flags' must be zero and 'uaddr' must be page-aligned.  At most
+KVM_CHECK_EXTENSION(KVM_CAP_PLANE_MEMORY_OVERLAYS) distinct gfns can
+carry an overlay per plane at any one time; further installs fail with
+-ENOSPC until an overlay is removed.  An overlay cannot be installed
+over a private or guest_memfd-only gfn (-EINVAL).  Passing 'uaddr' == 0
+removes the overlay for 'gfn', if any.
+
 5. The kvm_run structure
 ========================
 
@@ -7387,9 +7419,15 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
   #define KVM_MEMORY_EXIT_FLAG_WRITE    (1ULL << 1)
   #define KVM_MEMORY_EXIT_FLAG_EXEC     (1ULL << 2)
   #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+  #define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
+			/* set on plane-protection faults when available */
+			__u64 gva;
+			__u32 insn_len;
+			__u8  insn_bytes[16];
+			__u32 pad;
 		} memory_fault;
 
 KVM_EXIT_MEMORY_FAULT indicates the vCPU has encountered a memory fault that
@@ -7402,6 +7440,14 @@ describes properties of the faulting access that are likely pertinent:
  - KVM_MEMORY_EXIT_FLAG_PRIVATE - When set, indicates the memory fault occurred
    on a private memory access.  When clear, indicates the fault occurred on a
    shared access.
+ - KVM_MEMORY_EXIT_FLAG_GVA_VALID - When set, 'gva' holds the faulting guest
+   virtual address.
+
+The 'gva', 'insn_len' and 'insn_bytes' fields exist only on kernels
+which advertise KVM_CAP_PLANE_MEMORY_OVERLAYS (see section 8.48).  On
+plane memory-protection faults, 'insn_len' and 'insn_bytes' carry a
+best-effort copy of the faulting instruction when KVM could fetch it;
+an 'insn_len' of 0 means no instruction bytes are available.
 
 Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it
 accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT
@@ -9676,6 +9722,22 @@ take care to differentiate between these cases.
 The presence of this capability indicates that the nested KVM guest can
 start in ESA mode.
 
+8.48 KVM_CAP_PLANE_MEMORY_OVERLAYS
+----------------------------------
+
+:Architectures: x86
+
+A positive return from KVM_CHECK_EXTENSION(KVM_CAP_PLANE_MEMORY_OVERLAYS)
+announces two things:
+
+ - The KVM_SET_PLANE_MEMORY_OVERLAY vm ioctl (section 4.149).  The
+   returned value is the number of gfns which can carry an overlay
+   simultaneously on each plane.
+
+ - The extended KVM_EXIT_MEMORY_FAULT layout: 'memory_fault' carries
+   the additional 'gva', 'insn_len' and 'insn_bytes' fields, with
+   KVM_MEMORY_EXIT_FLAG_GVA_VALID qualifying 'gva' (see section 5).
+
 9. Known KVM API problems
 =========================
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 4551e011bf56..d4e44ae3f6e8 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -247,16 +247,8 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
 	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	/*
-	 * Userspace's SynIC device models plane 0 only; a higher plane's
-	 * exit would be mistaken for a plane-0 page move and relocate the
-	 * overlay the VMM keeps for SIMP/SIEFP.  Higher-plane SynICs are
-	 * handled fully in-kernel.
-	 */
-	if (vcpu->plane_level)
-		return;
-
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNIC;
+	hv_vcpu->exit.plane = vcpu->plane_level;
 	hv_vcpu->exit.u.synic.msr = msr;
 	hv_vcpu->exit.u.synic.control = synic->control;
 	hv_vcpu->exit.u.synic.evt_page = synic->evt_page;
@@ -358,6 +350,7 @@ static void syndbg_exit(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNDBG;
+	hv_vcpu->exit.plane = vcpu->plane_level;
 	hv_vcpu->exit.u.syndbg.msr = msr;
 	hv_vcpu->exit.u.syndbg.control = syndbg->control.control;
 	hv_vcpu->exit.u.syndbg.send_page = syndbg->control.send_page;
@@ -783,6 +776,51 @@ static int stimer_get_count(struct kvm_vcpu_hv_stimer *stimer, u64 *pcount)
 	return 0;
 }
 
+/*
+ * SIMP accessors: a plane overlay page, when installed by userspace,
+ * carries the live message page for this plane; the memslot holds only
+ * the underlay the other planes see.
+ */
+static int synic_msg_page_read(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
+			       int offset, int len)
+{
+	unsigned long uaddr = kvm_plane_overlay_uaddr(vcpu->plane, gfn);
+
+	if (uaddr)
+		return copy_from_user(data, (void __user *)(uaddr + offset),
+				      len) ? -EFAULT : 0;
+	/*
+	 * Mirror the write side: without an overlay a higher plane's
+	 * message page is backed by underlay memory that plane 0 controls.
+	 * Deciding deliverability from plane-0-writable bytes would let a
+	 * lower VTL plant a non-HVMSG_NONE type and silently swallow a
+	 * no_retry (periodic stimer) message; fail so the delivery is
+	 * retried once the overlay appears.
+	 */
+	if (vcpu->plane_level)
+		return -EFAULT;
+	return kvm_vcpu_read_guest_page(vcpu, gfn, data, offset, len);
+}
+
+static int synic_msg_page_write(struct kvm_vcpu *vcpu, gfn_t gfn,
+				const void *data, int offset, int len)
+{
+	unsigned long uaddr = kvm_plane_overlay_uaddr(vcpu->plane, gfn);
+
+	if (uaddr)
+		return copy_to_user((void __user *)(uaddr + offset), data,
+				    len) ? -EFAULT : 0;
+	/*
+	 * Never write a higher plane's messages into guest RAM: without an
+	 * overlay installed that memory is the underlay every other plane
+	 * sees, and silently corrupting plane-0-owned pages is far worse
+	 * than retrying the message once the overlay appears.
+	 */
+	if (vcpu->plane_level)
+		return -EFAULT;
+	return kvm_vcpu_write_guest_page(vcpu, gfn, data, offset, len);
+}
+
 static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			     struct hv_message *src_msg, bool no_retry)
 {
@@ -803,10 +841,10 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 	 * is only called in vcpu context so the entire update is atomic from
 	 * guest POV and thus the exact order here doesn't matter.
 	 */
-	r = kvm_vcpu_read_guest_page(vcpu, msg_page_gfn, &hv_hdr.message_type,
-				     msg_off + offsetof(struct hv_message,
-							header.message_type),
-				     sizeof(hv_hdr.message_type));
+	r = synic_msg_page_read(vcpu, msg_page_gfn, &hv_hdr.message_type,
+				msg_off + offsetof(struct hv_message,
+						   header.message_type),
+				sizeof(hv_hdr.message_type));
 	if (r < 0)
 		return r;
 
@@ -815,20 +853,20 @@ static int synic_deliver_msg(struct kvm_vcpu_hv_synic *synic, u32 sint,
 			return 0;
 
 		hv_hdr.message_flags.msg_pending = 1;
-		r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn,
-					      &hv_hdr.message_flags,
-					      msg_off +
-					      offsetof(struct hv_message,
-						       header.message_flags),
-					      sizeof(hv_hdr.message_flags));
+		r = synic_msg_page_write(vcpu, msg_page_gfn,
+					 &hv_hdr.message_flags,
+					 msg_off +
+					 offsetof(struct hv_message,
+						  header.message_flags),
+					 sizeof(hv_hdr.message_flags));
 		if (r < 0)
 			return r;
 		return -EAGAIN;
 	}
 
-	r = kvm_vcpu_write_guest_page(vcpu, msg_page_gfn, src_msg, msg_off,
-				      sizeof(src_msg->header) +
-				      src_msg->header.payload_size);
+	r = synic_msg_page_write(vcpu, msg_page_gfn, src_msg, msg_off,
+				 sizeof(src_msg->header) +
+				 src_msg->header.payload_size);
 	if (r < 0)
 		return r;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index cdebb5c324fe..4b11631d9e99 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4620,7 +4620,13 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	if (fault->slot->flags & KVM_MEM_READONLY)
 		fault->host_access &= ~ACC_WRITE_MASK;
 
-	fault->max_level = kvm_max_level_for_order(max_order);
+	/*
+	 * Only ever narrow max_level: the overlay check in
+	 * __kvm_mmu_faultin_pfn() may already have clamped it to 4KiB, and
+	 * a huge gmem mapping must not span an overlaid gfn.
+	 */
+	fault->max_level = min(fault->max_level,
+			       kvm_max_level_for_order(max_order));
 	return RET_PF_CONTINUE;
 }
 
@@ -4682,8 +4688,29 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				 struct kvm_page_fault *fault)
 {
 	unsigned int foll = fault->write ? FOLL_WRITE : 0;
+	struct page *overlay;
 	bool writable;
 
+	/*
+	 * A plane overlay page (VSM SynIC SIMP/SIEFP etc.) replaces the
+	 * memslot translation for this plane only.  The page is pinned
+	 * for the overlay's lifetime, so no refcounting here.
+	 */
+	/*
+	 * Keep this plane's mappings at 4KiB while it has overlays: a huge
+	 * mapping established by a neighbouring gfn's fault would span the
+	 * overlaid gfn and bypass the override below.
+	 */
+	if (READ_ONCE(vcpu->plane->nr_overlays)) {
+		fault->max_level = PG_LEVEL_4K;
+
+		overlay = kvm_plane_overlay_page(vcpu->plane, fault->gfn);
+		if (overlay) {
+			fault->pfn = page_to_pfn(overlay);
+			return RET_PF_CONTINUE;
+		}
+	}
+
 	if (fault->is_private || kvm_memslot_is_gmem_only(fault->slot))
 		return kvm_mmu_faultin_pfn_gmem(vcpu, fault);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 1e56a4784160..d5d0b2bc547c 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1871,8 +1871,29 @@ void kvm_tdp_mmu_recover_huge_pages(struct kvm *kvm,
 	struct kvm_mmu_page *root;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id)
+	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id) {
+		/*
+		 * kvm_mmu_max_mapping_level() consults only plane-0 state
+		 * (lpage_info and plane-0 private attributes).  Nonzero
+		 * planes carry per-plane memory attributes and memory
+		 * overlays whose fault-time 4KiB clamps a huge SPTE would
+		 * undo, extending one page's protections or overlay
+		 * backing over gfns the plane maps differently.  Leave
+		 * those roots alone; their fault path rebuilds mappings at
+		 * the largest level the plane allows.
+		 *
+		 * Plane 0 can carry overlays too (kvm->planes[0] always
+		 * exists and KVM_SET_PLANE_MEMORY_OVERLAY accepts plane 0),
+		 * and the same reasoning applies: a recovered huge SPTE
+		 * would either span an overlaid gfn with the memslot
+		 * backing, or huge-align the pinned overlay page's pfn and
+		 * map ~2MiB of unrelated host memory around it.
+		 */
+		if (root->role.plane ||
+		    READ_ONCE(kvm->planes[root->role.plane]->nr_overlays))
+			continue;
 		recover_huge_pages_range(kvm, root, slot);
+	}
 }
 
 /*
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index e1c5f1608b09..248d799b46e9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -70,6 +70,7 @@
 #include "vmcs12.h"
 #include "vmx.h"
 #include "x86.h"
+#include "kvm_emulate.h"
 #include "x86_ops.h"
 #include "smm.h"
 #include "vmx_onhyperv.h"
@@ -5949,6 +5950,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification = vmx_get_exit_qual(vcpu);
 	gpa_t gpa;
+	int ret;
 
 	/*
 	 * EPT violation happened while executing iret from NMI,
@@ -5975,7 +5977,54 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	if (unlikely(allow_smaller_maxphyaddr && !kvm_vcpu_is_legal_gpa(vcpu, gpa)))
 		return kvm_emulate_instruction(vcpu, 0);
 
-	return __vmx_handle_ept_violation(vcpu, gpa, exit_qualification);
+	ret = __vmx_handle_ept_violation(vcpu, gpa, exit_qualification);
+
+	/*
+	 * A plane-protection fault reflected to userspace becomes a TLFS
+	 * GPA intercept message, which carries the guest-linear address
+	 * and the faulting instruction's bytes.  Harvest them while the
+	 * exit state is still at hand.
+	 */
+	if (ret == -EFAULT &&
+	    vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT &&
+	    (vcpu->run->memory_fault.flags & (KVM_MEMORY_EXIT_FLAG_READ |
+					      KVM_MEMORY_EXIT_FLAG_WRITE |
+					      KVM_MEMORY_EXIT_FLAG_EXEC))) {
+		unsigned int len;
+
+		if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
+			vcpu->run->memory_fault.gva =
+				vmcs_readl(GUEST_LINEAR_ADDRESS);
+			vcpu->run->memory_fault.flags |=
+				KVM_MEMORY_EXIT_FLAG_GVA_VALID;
+		}
+		/*
+		 * Architecturally undefined for EPT violations, but the
+		 * hardware provides the faulting (for a fetch: the
+		 * fetching) instruction's length here, and the TLFS
+		 * message carries exactly that.
+		 */
+		len = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+		len = min_t(unsigned int, len,
+			    sizeof(vcpu->run->memory_fault.insn_bytes));
+		vcpu->run->memory_fault.insn_len = len;
+		if (!(exit_qualification & EPT_VIOLATION_ACC_INSTR)) {
+			struct x86_exception e;
+
+			/*
+			 * kvm_read_guest_virt() takes a linear address: RIP
+			 * is CS-relative, and the two coincide only when
+			 * CS.base is zero (64-bit mode, or a flat 32-bit
+			 * code segment).
+			 */
+			if (kvm_read_guest_virt(vcpu, kvm_get_linear_rip(vcpu),
+						vcpu->run->memory_fault.insn_bytes,
+						len, &e))
+				memset(vcpu->run->memory_fault.insn_bytes, 0,
+				       sizeof(vcpu->run->memory_fault.insn_bytes));
+		}
+	}
+	return ret;
 }
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4b12ec7ee100..10e14ab3e2ca 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8858,8 +8858,10 @@ static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 
 #define HV_CR_INTERCEPT_GDTR_WRITE	BIT_ULL(15)
 #define HV_CR_INTERCEPT_IDTR_WRITE	BIT_ULL(16)
+#define HV_CR_INTERCEPT_LDTR_WRITE	BIT_ULL(17)
 #define HV_X64_REGISTER_IDTR_ID		0x00070000
 #define HV_X64_REGISTER_GDTR_ID		0x00070001
+#define HV_X64_REGISTER_LDTR_ID		0x00060006
 
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
@@ -8947,6 +8949,18 @@ static void emulator_set_segment(struct x86_emulate_ctxt *ctxt, u16 selector,
 	var.unusable = !var.present;
 	var.padding = 0;
 
+	if (seg == VCPU_SREG_LDTR) {
+		struct desc_ptr sel_as_dt = {
+			.address = selector,
+			.size = 0,
+		};
+
+		/* The intercept message carries the written selector. */
+		if (hv_divert_dt_write(ctxt, HV_X64_REGISTER_LDTR_ID,
+				       &sel_as_dt, HV_CR_INTERCEPT_LDTR_WRITE))
+			return;
+	}
+
 	kvm_set_segment(vcpu, &var, seg);
 	return;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a76615f2c3dc..cb8c4798df12 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -927,9 +927,26 @@ struct kvm_plane {
 	struct xarray mem_attrs;
 #endif
 
+	/*
+	 * VSM overlay pages: per-plane gfn -> pinned user page overriding
+	 * the memslot translation for this plane only.  Written under
+	 * kvm->slots_lock; readers tolerate a transient stale view, the
+	 * post-update zap makes the EPT coherent.
+	 */
+#define KVM_PLANE_MAX_OVERLAYS 64
+	struct kvm_plane_overlay {
+		gfn_t gfn;
+		unsigned long uaddr;
+		struct page *page;
+	} overlays[KVM_PLANE_MAX_OVERLAYS];
+	int nr_overlays;
+
 	struct kvm_arch_plane arch;
 };
 
+struct page *kvm_plane_overlay_page(struct kvm_plane *plane, gfn_t gfn);
+unsigned long kvm_plane_overlay_uaddr(struct kvm_plane *plane, gfn_t gfn);
+
 struct kvm {
 #ifdef KVM_HAVE_MMU_RWLOCK
 	rwlock_t mmu_lock;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 9e453f215e68..843cef8f4cbf 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -480,9 +480,15 @@ struct kvm_run {
 #define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
 #define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+#define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
+			/* set on plane-protection faults when available */
+			__u64 gva;
+			__u32 insn_len;
+			__u8  insn_bytes[16];
+			__u32 pad;
 		} memory_fault;
 		/* KVM_EXIT_TDX */
 		struct {
@@ -1038,6 +1044,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_HCALL_FAULT_EXIT 252
 #define KVM_CAP_HYPERV_VTL_SWITCH 253
 #define KVM_CAP_HYPERV_REG_INTERCEPT 254
+#define KVM_CAP_PLANE_MEMORY_OVERLAYS 257
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1394,6 +1401,16 @@ struct kvm_s390_keyop {
 #define KVM_CREATE_PLANE	  _IO(KVMIO, 0xe4)
 #define KVM_GET_PLANE_RUN_STATE	  _IOR(KVMIO, 0xe5, __u32)
 #define KVM_SET_PLANE_RUN_STATE	  _IOW(KVMIO, 0xe6, __u32)
+
+/* Map one page of userspace memory over a GPA for a single plane (VSM
+ * overlay pages: SynIC SIMP/SIEFP, hypercall page, VP assist page). */
+struct kvm_plane_memory_overlay {
+	__u32 plane;
+	__u32 flags;
+	__u64 gfn;
+	__u64 uaddr;		/* page-aligned; 0 removes the overlay */
+};
+#define KVM_SET_PLANE_MEMORY_OVERLAY	  _IOW(KVMIO, 0xe7, struct kvm_plane_memory_overlay)
 #define   KVM_PLANE_RUN_STATE_STOPPED	0
 #define   KVM_PLANE_RUN_STATE_RUNNABLE	1
 #define   KVM_PLANE_RUN_STATE_KERNEL_STOPPED	2
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4197496f7176..5856672bbf6d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1251,6 +1251,14 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 
 static void kvm_destroy_one_plane(struct kvm_plane *plane)
 {
+	int i;
+
+	for (i = 0; i < plane->nr_overlays; i++)
+		if (plane->overlays[i].page)
+			unpin_user_pages_dirty_lock(&plane->overlays[i].page,
+						    1, true);
+	plane->nr_overlays = 0;
+
 #ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
 	xa_destroy(&plane->mem_attrs);
 #endif
@@ -5629,6 +5637,8 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		 * VM actually has.
 		 */
 		return KVM_MAX_PLANES;
+	case KVM_CAP_PLANE_MEMORY_OVERLAYS:
+		return KVM_PLANE_MAX_OVERLAYS;
 	default:
 		break;
 	}
@@ -5896,6 +5906,258 @@ do {										\
 		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
 } while (0)
 
+struct page *kvm_plane_overlay_page(struct kvm_plane *plane, gfn_t gfn)
+{
+	int i, n = READ_ONCE(plane->nr_overlays);
+
+	/* pairs with the smp_wmb() publishing a new entry */
+	smp_rmb();
+	for (i = 0; i < n; i++) {
+		if (READ_ONCE(plane->overlays[i].gfn) != gfn)
+			continue;
+		/* pairs with the smp_store_release() updating an entry */
+		return smp_load_acquire(&plane->overlays[i].page);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_plane_overlay_page);
+
+unsigned long kvm_plane_overlay_uaddr(struct kvm_plane *plane, gfn_t gfn)
+{
+	int i, n = READ_ONCE(plane->nr_overlays);
+
+	smp_rmb();
+	for (i = 0; i < n; i++) {
+		if (READ_ONCE(plane->overlays[i].gfn) != gfn)
+			continue;
+		/*
+		 * The acquire pairs with the smp_store_release() updating
+		 * an entry: a reader which observes the new page also
+		 * observes the uaddr written before it.
+		 */
+		if (smp_load_acquire(&plane->overlays[i].page))
+			return READ_ONCE(plane->overlays[i].uaddr);
+		return 0;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_plane_overlay_uaddr);
+
+/*
+ * The invalidation window registered around an overlay update must
+ * cover every gfn whose in-flight fault could install a huge leaf
+ * spanning the overlaid gfn, i.e. the naturally-aligned region of the
+ * widest stage-2 huge mapping any plane-capable architecture supports
+ * (a 1GiB page on x86).  A narrower window lets a racing fault on a
+ * neighbouring gfn, which sampled nr_overlays and mmu_invalidate_seq
+ * before the update, pass mmu_invalidate_retry_gfn() and install a
+ * huge SPTE over the overlay after the zap.
+ */
+#define KVM_PLANE_OVERLAY_INVAL_PAGES	(SZ_1G >> PAGE_SHIFT)
+
+static void kvm_plane_overlay_invalidate_add(struct kvm *kvm, gfn_t gfn)
+{
+	gfn_t start = ALIGN_DOWN(gfn, KVM_PLANE_OVERLAY_INVAL_PAGES);
+
+	kvm_mmu_invalidate_range_add(kvm, start,
+				     start + KVM_PLANE_OVERLAY_INVAL_PAGES);
+}
+
+/*
+ * Drop every translation of @gfn, in all address spaces and all planes'
+ * roots.  A huge leaf spanning the gfn intersects the single-page range
+ * and is zapped with it.  Hardware TLBs are not flushed here.
+ */
+static void kvm_plane_overlay_unmap(struct kvm *kvm, gfn_t gfn)
+{
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
+	struct kvm_memslot_iter iter;
+	struct kvm_memslots *slots;
+	int i;
+
+	KVM_MMU_LOCK(kvm);
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, gfn, gfn + 1) {
+			struct kvm_gfn_range range = {
+				.slot = iter.slot,
+				.start = gfn,
+				.end = gfn + 1,
+				.attr_filter = KVM_FILTER_PRIVATE |
+					       KVM_FILTER_SHARED,
+				.may_block = true,
+			};
+
+			kvm_unmap_gfn_range(kvm, &range);
+		}
+	}
+	KVM_MMU_UNLOCK(kvm);
+#else
+	kvm_arch_flush_shadow_all(kvm);
+#endif
+}
+
+static int kvm_vm_ioctl_set_plane_overlay(struct kvm *kvm,
+					  struct kvm_plane_memory_overlay *ov)
+{
+	struct kvm_plane_overlay *e = NULL;
+	struct page *page = NULL, *old_page = NULL;
+	struct kvm_plane *plane;
+	bool moved = false;
+	gfn_t moved_gfn = 0;
+	int i, r;
+
+	if (ov->flags || ov->plane >= KVM_MAX_PLANES)
+		return -EINVAL;
+	if (ov->uaddr & ~PAGE_MASK)
+		return -EINVAL;
+	plane = kvm->planes[ov->plane];
+	if (!plane)
+		return -EINVAL;
+
+	if (ov->uaddr) {
+		r = pin_user_pages_fast(ov->uaddr, 1,
+					FOLL_WRITE | FOLL_LONGTERM, &page);
+		if (r != 1)
+			return r < 0 ? r : -EFAULT;
+	}
+
+	mutex_lock(&kvm->slots_lock);
+	for (i = 0; i < plane->nr_overlays; i++) {
+		if (plane->overlays[i].gfn == ov->gfn) {
+			e = &plane->overlays[i];
+			break;
+		}
+	}
+
+	/*
+	 * Removing an overlay which was never installed changes nothing;
+	 * don't zap and flush for it.
+	 */
+	if (!ov->uaddr && !e) {
+		mutex_unlock(&kvm->slots_lock);
+		return 0;
+	}
+
+	/*
+	 * guest_memfd-backed and private gfns have their own backing
+	 * contract which an ordinary pinned user page cannot substitute
+	 * for, and kvm_mmu_faultin_pfn_gmem() does not consult overlays.
+	 * Both the private attribute and the memslot flags are stable
+	 * under slots_lock.
+	 */
+	if (ov->uaddr) {
+		struct kvm_memory_slot *slot = gfn_to_memslot(kvm, ov->gfn);
+
+		if ((slot && kvm_memslot_is_gmem_only(slot)) ||
+		    kvm_mem_is_private(kvm, ov->gfn)) {
+			mutex_unlock(&kvm->slots_lock);
+			unpin_user_page(page);
+			return -EINVAL;
+		}
+	}
+
+	if (ov->uaddr) {
+		if (!e) {
+			if (plane->nr_overlays >= KVM_PLANE_MAX_OVERLAYS) {
+				mutex_unlock(&kvm->slots_lock);
+				unpin_user_page(page);
+				return -ENOSPC;
+			}
+			e = &plane->overlays[plane->nr_overlays];
+			e->gfn = ov->gfn;
+			e->uaddr = ov->uaddr;
+			e->page = page;
+			/*
+			 * Publish the fully-initialised entry before
+			 * raising the count; pairs with the smp_rmb() in
+			 * the lockless readers.
+			 */
+			smp_wmb();
+			WRITE_ONCE(plane->nr_overlays, plane->nr_overlays + 1);
+		} else {
+			old_page = e->page;
+			WRITE_ONCE(e->uaddr, ov->uaddr);
+			/*
+			 * Order the uaddr store before the page store; a
+			 * reader which acquires the new page must see the
+			 * uaddr it belongs to.
+			 */
+			smp_store_release(&e->page, page);
+		}
+	} else if (e) {
+		struct kvm_plane_overlay *tail =
+			&plane->overlays[plane->nr_overlays - 1];
+
+		old_page = e->page;
+		WRITE_ONCE(e->page, NULL);
+		WRITE_ONCE(e->uaddr, 0);
+
+		/*
+		 * Reclaim the slot: move the tail entry into the vacated
+		 * one and shrink the array.  A lockless reader scanning
+		 * with the old count can miss the moved entry entirely
+		 * (it may already have passed the vacated slot), so the
+		 * moved gfn is added to the invalidation window below and
+		 * any such in-flight fault retries.  The cleared tail is
+		 * harmless to a stale-count reader: the live copy sits at
+		 * a lower index and is found first.
+		 */
+		if (e != tail) {
+			moved = true;
+			moved_gfn = tail->gfn;
+			WRITE_ONCE(e->gfn, tail->gfn);
+			WRITE_ONCE(e->uaddr, tail->uaddr);
+			/* pairs with smp_load_acquire() in the readers */
+			smp_store_release(&e->page, tail->page);
+		}
+		WRITE_ONCE(plane->nr_overlays, plane->nr_overlays - 1);
+		WRITE_ONCE(tail->page, NULL);
+		WRITE_ONCE(tail->uaddr, 0);
+		WRITE_ONCE(tail->gfn, 0);
+	}
+	/*
+	 * Bump the invalidation sequence across the update and zap: a
+	 * concurrent fault resolves the overlay pfn locklessly before
+	 * taking mmu_lock, and without a sequence change
+	 * is_page_fault_stale() would let it install an SPTE for the OLD
+	 * backing after the zap, mapping a page this function is about
+	 * to unpin.
+	 */
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_begin(kvm);
+	kvm_plane_overlay_invalidate_add(kvm, ov->gfn);
+	if (moved)
+		kvm_plane_overlay_invalidate_add(kvm, moved_gfn);
+	KVM_MMU_UNLOCK(kvm);
+
+	mutex_unlock(&kvm->slots_lock);
+
+	/*
+	 * Drop any translation mapping the old or new backing.  The unmap
+	 * removes the SPTEs but does not flush hardware TLBs: a vCPU that
+	 * mapped the gfn before the update still holds a translation to
+	 * the old backing in its TLB (tagged by the live ASID on SVM,
+	 * which nothing else invalidates).  Flush before the old page is
+	 * unpinned: KVM_REQ_TLB_FLUSH is a per-plane request, so the
+	 * fan-out in kvm_make_vcpu_request() reaches every plane twin and
+	 * each flushes its own hardware context.
+	 */
+	kvm_plane_overlay_unmap(kvm, ov->gfn);
+	if (moved)
+		kvm_plane_overlay_unmap(kvm, moved_gfn);
+	kvm_flush_remote_tlbs(kvm);
+
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_end(kvm);
+	KVM_MMU_UNLOCK(kvm);
+
+	if (old_page)
+		unpin_user_pages_dirty_lock(&old_page, 1, true);
+	return 0;
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -5906,6 +6168,15 @@ static long kvm_vm_ioctl(struct file *filp,
 	if (kvm->mm != current->mm || kvm->vm_dead)
 		return -EIO;
 	switch (ioctl) {
+	case KVM_SET_PLANE_MEMORY_OVERLAY: {
+		struct kvm_plane_memory_overlay ov;
+
+		r = -EFAULT;
+		if (copy_from_user(&ov, argp, sizeof(ov)))
+			goto out;
+		r = kvm_vm_ioctl_set_plane_overlay(kvm, &ov);
+		break;
+	}
 	case KVM_CREATE_PLANE:
 		r = kvm_vm_ioctl_create_plane(kvm, arg);
 		break;
-- 
2.50.1

