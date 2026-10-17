Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA8449BB60;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239921; cv=none; b=C1CDBQtRB2EfAjs++uOecDLckIREyv0eGwbec1WhywzAYlxXKF0JB2wDAxi5o5Lz7O3pp25DV9mb69EtBb8sWgwwoRJhq3hkErM7bi0DVRoC63mEQ51ebDKMl2z0O/m2GAo1ZHCQE8L0PvHoNKgIMVU7Pau7SdHicHSBr/V3xgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239921; c=relaxed/simple;
	bh=Q1GD2IfvWrGSdnyzTqnclo9htDDEnlYi2H720WVqwck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fb2SfWl8edYpkvrEhL/bK0RuyRAd3aeO0E5hp9JZK+luvAMgAdCScK4HU+8+trkOGmCauHYk1fRdrQvC8p5/p4+Xx++1I9ESJLvF0W7hv/2fv0w9HBmSGu/5HPJfeun5sJeWdbf5+eyz8Wn7VBzR2PVG7jenPFdqCrdNCfCG+c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=baXLDNjv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="baXLDNjv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=ZEi03/qKxEAeQiRbFOUZoXqpCEEJe+GipCOBPLnwej8=; b=baXLDNjvpEnydaQ45sYROrcd46
	1C5+M21I8AjDCugEVTbvHHXcQwZBnnA3zBbyBS9QyOo2icoQYbdKX8fk13d6QZHw5P+ysAONNXGG3
	evrpWzj0I9CiSXtc/hJDq51F5R7uiJMk15bqFpKiup1SiGU3VZuSsv0MYz9ZZINlQwRywoPT+oxi7
	IhgGO1UKogTL43hTqULJ0xvKr03JfsRqLhmArn8PHt4+Dibsb1GJk8hXK866oy1qBcMATdRjYuxpJ
	WRUDrlsyNifcrSK6ufdzRZuaKiulJ8IY9qA9diJ5WmYp3agVTAyTZYA+d1crACpgd3qFRdMDzs/qn
	t3ZVHepw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfN-1arV;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YmO-3vNo;
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
Subject: [RFC PATCH 23/55] WIP: userspace VTL interrupt entry and register intercepts
Date: Sat, 17 Oct 2026 13:24:29 +0100
Message-ID: <20261017122501.610248-24-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Windows VSM boot stalls and PatchGuard-induced triple faults traced to
missing host behaviours, all confirmed against the reference VSM host:

- A pending interrupt for a suspended higher VTL must preempt the
  lower VTL. In userspace-switch mode, report it as a new
  KVM_EXIT_HYPERV_VTL_INTERRUPT exit — from the halted/block path too,
  since a halted lower VTL never reaches vcpu_enter_guest() — so
  userspace enters the higher VTL itself and its view of the active
  VTL stays in sync. kvm_higher_plane_with_event() tests raw
  pending-ness (kvm_apic_has_interrupt), because a suspended plane
  carries a stale apicv_active that makes
  kvm_cpu_has_injectable_intr() report false.

- The in-kernel forced entry, like the in-kernel VTL switch, writes
  the entered VTL's control area through the *entered* plane's
  context, since the assist page may be protected against the lower
  VTL; on failure a VTL call forwards to userspace and a forced entry
  stays pending. The refusal conditions live in
  kvm_hv_vtl_entry_blocked(), which also gates
  kvm_higher_plane_with_event() in in-kernel mode: an armed event on a
  plane that cannot be entered (never run, stopped by userspace,
  parked on a non-hypercall completion owning the shared run union)
  must not keep waking a halted lower VTL that has no way to consume
  it. A plane which has never entered the guest holds reset state and
  userspace owns the HvCallEnableVpVtl tracking (the reference host
  fails such calls with HV_STATUS_INVALID_VP_STATE), so hand it the
  switch and leave the event pending. The resume value is
  guest-derived in every switch flavour, so
  KVM_HV_HCALL_RESULT_RAISE_UD is masked out of it, and a target with
  no completion armed receives it directly in RAX, as the TLFS
  register-restore contract on VTL return requires.

- RAX/RCX of the lower VTL are captured at in-kernel VTL entry and
  restored on an assist-less, non-fast return; vtl_entry_regs_valid
  tracks whether the capture is live. A return finding it clear (the
  entry was performed by userspace, or predates a migration — the
  capture has no GET/SET exposure) is forwarded to userspace, which
  owns restoring the lower VTL's registers.

- plane_user_stopped is a pure userspace-policy latch: only
  KVM_SET_PLANE_RUN_STATE writes it, and no runnable plane can carry
  it (it is cleared at the single RUNNABLE choke point). In-kernel
  suspensions get their own plane_kernel_stopped flag, reported and
  restorable as KVM_PLANE_RUN_STATE_KERNEL_STOPPED, with the same
  plane-0 event gating. The in-kernel VTL switch and the forced entry
  refuse a user-stopped target (forwarding the switch to userspace or
  leaving the event pending), and the kvm_vcpu_select_plane() fallback
  refuses a user-stopped plane 0: KVM_RUN fails with -EINVAL,
  surfacing the VMM's ordering bug instead of resuming a plane the VMM
  parked mid-hypercall.

- The secure kernel arms HvRegisterCrInterceptControl
  descriptor-table write intercepts for VTL0, then PatchGuard runs its
  protected patching window under an intercepted lidt. The write must
  *not* be applied — the window would execute with a genuinely null
  IDT and the first event triple-faults the guest. Add a per-vCPU
  KVM_CAP_HYPERV_REG_INTERCEPT that arms the control word, trap the
  descriptor-table instructions (SECONDARY_EXEC_DESC, dropped again
  when the intercepts disarm), and divert armed writes into a
  KVM_EXIT_HYPERV_REG_INTERCEPT exit with RIP rewound to the
  intercepted instruction: the higher VTL owns completion, and
  Windows' patch-protection probe matches its reflected #GP(0) against
  the probe RIP.

- HvCallSendSyntheticClusterIpi(Ex) honours the input's in_vtl field
  (both the memory and fast forms carry it after the vector),
  delivering to the resolved plane's twins; reserved bits 7:5 are
  rejected with HV_STATUS_INVALID_HYPERCALL_INPUT before anything is
  delivered, as on the reference host.

- hv_inkernel_vtl_switch is written under kvm->lock but read
  locklessly from vCPU context; the accesses carry
  WRITE_ONCE/READ_ONCE so each individual check reads a coherent
  value. A VMM that flips the cap while vCPUs run owns the
  consequences of catching a transition in flight.

Also includes debug instrumentation, to be stripped before posting.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst  |  31 ++--
 arch/x86/hyperv/hv_apic.c       |   3 +-
 arch/x86/include/asm/kvm_host.h |  21 ++-
 arch/x86/kvm/hyperv.c           | 257 +++++++++++++++++++++++++++++---
 arch/x86/kvm/hyperv.h           |   3 +
 arch/x86/kvm/vmx/vmx.c          |  23 ++-
 arch/x86/kvm/x86.c              | 210 +++++++++++++++++++++++++-
 include/hyperv/hvgdk_mini.h     |   3 +-
 include/hyperv/hvhdk_mini.h     |   3 +-
 include/linux/kvm_host.h        |  12 ++
 include/uapi/linux/kvm.h        |  13 ++
 virt/kvm/kvm_main.c             |  35 ++++-
 12 files changed, 571 insertions(+), 43 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index c9283994014a..3ef57b3b050b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6628,19 +6628,32 @@ a vCPU fd of every plane, not just plane 0.
 :Returns: 0 on success, <0 on error
 
 Reads or sets the per-plane run state of a vCPU:
-KVM_PLANE_RUN_STATE_STOPPED (0) or KVM_PLANE_RUN_STATE_RUNNABLE (1).
+KVM_PLANE_RUN_STATE_STOPPED (0), KVM_PLANE_RUN_STATE_RUNNABLE (1) or
+KVM_PLANE_RUN_STATE_KERNEL_STOPPED (2).
 
 When a vCPU thread calls KVM_RUN, KVM executes the lowest-numbered plane
-whose vCPU is runnable, falling back to plane 0.  A VMM implementing a
-software privilege model (such as Hyper-V VSM) switches planes by
-marking the target plane's vCPU runnable and the current one stopped
-before re-entering KVM_RUN.  Pending events for plane 0 make it runnable
-again on their own only as long as userspace has not explicitly stopped
-it with this ioctl; a VMM-stopped plane 0 keeps its events pending until
-the VMM makes it runnable, so a software privilege model can keep a
-higher plane running undisturbed.  The ioctl is accepted on any plane's
+whose vCPU is runnable, falling back to plane 0.  If no plane is
+runnable and userspace has stopped plane 0, KVM_RUN fails with -EINVAL
+instead of overriding the stop.  A VMM implementing a software privilege
+model (such as Hyper-V VSM) switches planes by marking the target
+plane's vCPU runnable and the current one stopped before re-entering
+KVM_RUN.  Pending events for plane 0 make it runnable again on their own
+only as long as userspace has not explicitly stopped it with this ioctl;
+a VMM-stopped plane 0 keeps its events pending until the VMM makes it
+runnable, so a software privilege model can keep a higher plane running
+undisturbed.  In-kernel plane transitions never override a userspace
+stop: a guest-initiated VTL switch targeting a stopped plane is
+forwarded to userspace instead.  The ioctl is accepted on any plane's
 vCPU fd.
 
+KVM_PLANE_RUN_STATE_KERNEL_STOPPED is reported for a plane that KVM
+itself suspended (such as the lower plane of an in-kernel VTL switch);
+such a plane becomes runnable again on the matching in-kernel transition
+without userspace involvement.  Setting it stops the plane without
+recording a userspace stop, so restoring previously read run states
+round-trips a kernel suspension without converting it into userspace
+stop policy.
+
 The run state is distinct from KVM_GET/SET_MP_STATE, which describes
 the architectural state of a vCPU within its plane.
 
diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index a8de503def37..533304c29603 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -127,7 +127,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		goto ipi_mask_ex_done;
 
 	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
+	ipi_arg->in_vtl.as_uint8 = 0;
+	memset(ipi_arg->reserved, 0, sizeof(ipi_arg->reserved));
 	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	/*
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 537ea6cded7a..74810e0e9ed7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -732,13 +732,32 @@ struct kvm_vcpu_hv {
 		u32 vp_id;
 	} nested;
 
+	/*
+	 * HvRegisterCrInterceptControl value the higher VTL armed for the
+	 * lower VTL (userspace VSM): descriptor-table write bits divert
+	 * the emulated write into a KVM_EXIT_HYPERV_REG_INTERCEPT exit.
+	 */
+	u64 reg_intercept_control;
+	struct {
+		u32 reg;
+		u8 insn_len;
+		bool pending;
+		u64 base;
+		u32 limit;
+		u64 rip;
+	} reg_intercept;
+
 	/*
 	 * RAX/RCX of the lower VTL captured at VTL entry, restored on a
 	 * non-fast VTL return when this plane has no VP assist page to
-	 * carry them in its VTL control area.
+	 * carry them in its VTL control area.  Only valid between an
+	 * in-kernel VTL entry and the matching return: a plane entered by
+	 * userspace, or restored from migration, has no captured values
+	 * and its assist-less return is forwarded to userspace.
 	 */
 	u64 vtl_entry_rax;
 	u64 vtl_entry_rcx;
+	bool vtl_entry_regs_valid;
 };
 
 struct kvm_hypervisor_cpuid {
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 2f57f89cd8ea..ca31054ed065 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2364,7 +2364,8 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 }
 
 static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
-				    u64 *sparse_banks, u64 valid_bank_mask)
+				    u64 *sparse_banks, u64 valid_bank_mask,
+				    int target_plane)
 {
 	struct kvm_lapic_irq irq = {
 		.delivery_mode = APIC_DM_FIXED,
@@ -2374,13 +2375,25 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 	unsigned long i;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvm_vcpu *target = vcpu;
+
 		if (sparse_banks &&
 		    !hv_is_vp_in_sparse_set(kvm_hv_get_vpindex(vcpu),
 					    valid_bank_mask, sparse_banks))
 			continue;
 
+		/*
+		 * TLFS: the IPI targets the VPs' in_vtl (or the sender's
+		 * VTL): deliver into that plane's APIC.
+		 */
+		if (target_plane) {
+			target = vcpu->common->vcpus[target_plane];
+			if (!target)
+				continue;
+		}
+
 		/* We fail only when APIC is disabled */
-		kvm_apic_set_irq(vcpu, &irq, NULL);
+		kvm_apic_set_irq(target, &irq, NULL);
 	}
 }
 
@@ -2393,6 +2406,8 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	struct hv_send_ipi send_ipi;
 	u64 valid_bank_mask;
 	u32 vector;
+	u8 in_vtl = 0;
+	int target_plane;
 	bool all_cpus;
 	int r;
 
@@ -2410,13 +2425,25 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			sparse_banks[0] = send_ipi.cpu_mask;
 			vector = send_ipi.vector;
+			in_vtl = send_ipi.in_vtl.as_uint8;
 		} else {
 			/* 'reserved' part of hv_send_ipi should be 0 */
-			if (unlikely(hc->ingpa >> 32 != 0))
+			if (unlikely(hc->ingpa >> 40 != 0))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			sparse_banks[0] = hc->outgpa;
 			vector = (u32)hc->ingpa;
+			in_vtl = (hc->ingpa >> 32) & 0xff;
 		}
+
+		/*
+		 * Only hv_input_vtl.target_vtl (bits 3:0) and
+		 * use_target_vtl (bit 4) are defined; reserved_z (7:5)
+		 * must be zero in every form of the hypercall, before
+		 * anything is delivered.
+		 */
+		if (unlikely(in_vtl & 0xe0))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 		all_cpus = false;
 		valid_bank_mask = BIT_ULL(0);
 
@@ -2426,12 +2453,18 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi_ex,
 						    sizeof(send_ipi_ex))))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+			in_vtl = send_ipi_ex.in_vtl.as_uint8;
 		} else {
 			send_ipi_ex.vector = (u32)hc->ingpa;
 			send_ipi_ex.vp_set.format = hc->outgpa;
 			send_ipi_ex.vp_set.valid_bank_mask = sse128_lo(hc->xmm[0]);
+			in_vtl = (hc->ingpa >> 32) & 0xff;
 		}
 
+		/* As above: hv_input_vtl bits 7:5 are reserved. */
+		if (unlikely(in_vtl & 0xe0))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
 					 send_ipi_ex.vp_set.format,
 					 send_ipi_ex.vp_set.valid_bank_mask);
@@ -2463,10 +2496,19 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	if ((vector < HV_IPI_LOW_VECTOR) || (vector > HV_IPI_HIGH_VECTOR))
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
+	/* TLFS: in_vtl bit 4 selects an explicit target VTL. */
+	if (in_vtl & 0x10)
+		target_plane = in_vtl & 0xf;
+	else
+		target_plane = vcpu->plane_level;
+	if (target_plane >= KVM_MAX_PLANES)
+		return HV_STATUS_INVALID_HYPERCALL_INPUT;
+
 	if (all_cpus)
-		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0);
+		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0, target_plane);
 	else
-		kvm_hv_send_ipi_to_many(kvm, vector, sparse_banks, valid_bank_mask);
+		kvm_hv_send_ipi_to_many(kvm, vector, sparse_banks,
+					valid_bank_mask, target_plane);
 
 ret_success:
 	return HV_STATUS_SUCCESS;
@@ -2772,6 +2814,116 @@ static u64 hv_vtl_assist_page_gpa(struct kvm_vcpu *vcpu)
  * Returns -ENOENT when the transition cannot be handled here (no twin
  * plane); the caller forwards the hypercall to userspace unchanged.
  */
+/*
+ * Enter a higher VTL because it has a pending interrupt (TLFS: higher
+ * VTL interrupts preempt lower VTL execution).  The lower VTL is
+ * suspended mid-instruction, not in a hypercall, so no completion is
+ * pended for it: it resumes at the preempted RIP when the higher VTL
+ * returns, and the entered VTL's control area carries the INTERRUPT
+ * entry reason with the preempted RAX/RCX.
+ */
+#define HV_VTL_ENTRY_REASON_INTERRUPT	2
+
+/*
+ * States in which the in-kernel paths must not enter a plane:
+ *
+ *  - never entered the guest: it still holds reset state (userspace owns
+ *    HvCallEnableVpVtl and runs a plane's first entry itself);
+ *  - stopped by userspace with KVM_SET_PLANE_RUN_STATE: the VMM owns
+ *    restarting it;
+ *  - parked on a non-hypercall completion (MMIO, PIO): the completion
+ *    owns the shared run union, which the resume protocol would clobber.
+ *
+ * The forced interrupt entry refuses such a target (the event stays
+ * pending), and kvm_higher_plane_with_event() must not report its
+ * pending event as a wakeup either, or a halted lower VTL spins through
+ * hlt/wake with nothing able to consume the event.
+ */
+bool kvm_hv_vtl_entry_blocked(struct kvm_vcpu *target)
+{
+	if (target->arch.last_vmentry_cpu == -1)
+		return true;
+
+	if (target->plane_user_stopped)
+		return true;
+
+	if (target->arch.complete_userspace_io &&
+	    target->arch.complete_userspace_io != kvm_hv_hypercall_complete_userspace)
+		return true;
+
+	return false;
+}
+
+bool kvm_hv_vtl_interrupt_entry(struct kvm_vcpu *vcpu,
+				struct kvm_vcpu *target)
+{
+	u64 rax = kvm_rax_read(vcpu), rcx = kvm_rcx_read(vcpu);
+	struct hv_vtl_control ctl;
+	u64 assist;
+	int i;
+
+	static const int shared_gprs[] = {
+		VCPU_REGS_RAX, VCPU_REGS_RBX, VCPU_REGS_RCX, VCPU_REGS_RDX,
+		VCPU_REGS_RSI, VCPU_REGS_RDI, VCPU_REGS_RBP,
+		VCPU_REGS_R8, VCPU_REGS_R9, VCPU_REGS_R10, VCPU_REGS_R11,
+		VCPU_REGS_R12, VCPU_REGS_R13, VCPU_REGS_R14, VCPU_REGS_R15,
+	};
+
+	/* The event stays pending until the plane can be entered. */
+	if (kvm_hv_vtl_entry_blocked(target))
+		return false;
+
+	/*
+	 * Write the entered plane's control area through the entered
+	 * plane's vCPU: the write must pass that plane's own memory
+	 * attributes and memslot view, not the suspending plane's (which
+	 * typically has no access to the higher VTL's assist page).  On
+	 * failure leave both planes untouched; the event stays pending in
+	 * the target and the entry is retried.
+	 */
+	assist = hv_vtl_assist_page_gpa(target);
+	if (assist) {
+		ctl = (struct hv_vtl_control) {
+			.vtl_entry_reason = HV_VTL_ENTRY_REASON_INTERRUPT,
+			.vtl_ret_x64rax = rax,
+			.vtl_ret_x64rcx = rcx,
+		};
+		if (kvm_vcpu_write_guest(target, assist + HV_VTL_CONTROL_OFFSET,
+					 &ctl, sizeof(ctl)))
+			return false;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(shared_gprs); i++)
+		kvm_register_write_raw(target, shared_gprs[i],
+				       kvm_register_read_raw(vcpu,
+							     shared_gprs[i]));
+	target->arch.cr2 = vcpu->arch.cr2;
+	vcpu->common->vtl_fpu_from = vcpu->plane_level;
+
+	if (to_hv_vcpu(target)) {
+		to_hv_vcpu(target)->vtl_entry_rax = rax;
+		to_hv_vcpu(target)->vtl_entry_rcx = rcx;
+		to_hv_vcpu(target)->vtl_entry_regs_valid = true;
+	}
+
+	/*
+	 * The target resumes its suspended hypercall, if it has one.  The
+	 * resume value is the shared RAX as copied from the entering plane
+	 * just above: GPRs are VTL-shared, so the retired hypercall's RAX
+	 * must match what every other shared register already shows.  The
+	 * value is guest-derived; strip the VMM-only RAISE_UD control bit
+	 * so the completion cannot be made to inject #UD by the guest.
+	 */
+	if (target->arch.complete_userspace_io)
+		vcpu->run->hyperv.u.hcall.result = kvm_rax_read(target) &
+						   ~KVM_HV_HCALL_RESULT_RAISE_UD;
+
+	vcpu->plane_kernel_stopped = true;
+	kvm_vcpu_set_plane_stopped(vcpu);
+	kvm_vcpu_set_plane_runnable(target);
+	return true;
+}
+
 static int hv_vtl_switch_limit = -1;
 module_param(hv_vtl_switch_limit, int, 0644);
 
@@ -2797,6 +2949,35 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 		return -ENOENT;
 	target = vcpu->common->vcpus[to];
 
+	/*
+	 * A VMM-stopped plane stays stopped until the VMM restarts it.
+	 * Forward the switch so userspace can apply its own policy.
+	 */
+	if (target->plane_user_stopped)
+		return -ENOENT;
+
+	/*
+	 * The resume protocol below delivers the result through the
+	 * target's armed hypercall completion.  A target parked on any
+	 * other completion (MMIO, PIO) owns the shared run union; writing
+	 * hcall.result over it would feed the pending completion garbage
+	 * and lose the resume value.  Forward such a switch to userspace.
+	 */
+	if (target->arch.complete_userspace_io &&
+	    target->arch.complete_userspace_io != kvm_hv_hypercall_complete_userspace)
+		return -ENOENT;
+
+	/*
+	 * Userspace owns HvCallEnableVpVtl state; the kernel only knows a
+	 * plane vCPU exists, and VMMs create those at setup time.  Refuse
+	 * to call into a plane that has never entered the guest: it still
+	 * holds reset state, and the reference host fails such a call with
+	 * HV_STATUS_INVALID_VP_STATE.  Forwarding lets userspace apply its
+	 * enablement tracking (and run the plane's first entry itself).
+	 */
+	if (!is_return && target->arch.last_vmentry_cpu == -1)
+		return -ENOENT;
+
 	/*
 	 * Debug budget on in-kernel switches, counted per VM and only for
 	 * switches that pass the eligibility checks above (a forwarded
@@ -2816,9 +2997,39 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 						&ctl, sizeof(ctl)))
 				return -ENOENT;
 		} else {
+			/*
+			 * No captured entry registers to restore: this plane
+			 * was last entered by userspace (or the capture was
+			 * lost across migration).  Forward the return so
+			 * userspace restores the lower VTL's RAX/RCX itself.
+			 */
+			if (!to_hv_vcpu(vcpu)->vtl_entry_regs_valid)
+				return -ENOENT;
+
 			ctl.vtl_ret_x64rax = to_hv_vcpu(vcpu)->vtl_entry_rax;
 			ctl.vtl_ret_x64rcx = to_hv_vcpu(vcpu)->vtl_entry_rcx;
 		}
+	} else if (!is_return) {
+		/*
+		 * Write the entered VTL's control area through the entered
+		 * plane's vCPU: the write must pass that plane's memory
+		 * attributes and memslot view, and the higher VTL normally
+		 * protects its assist page against the caller's plane.
+		 * Fail before any state moves (mirroring the read above);
+		 * userspace then owns the switch.
+		 */
+		assist = hv_vtl_assist_page_gpa(target);
+		if (assist) {
+			ctl = (struct hv_vtl_control) {
+				.vtl_entry_reason = HV_VTL_ENTRY_REASON_VTL_CALL,
+				.vtl_ret_x64rax = rax,
+				.vtl_ret_x64rcx = rcx,
+			};
+			if (kvm_vcpu_write_guest(target,
+						 assist + HV_VTL_CONTROL_OFFSET,
+						 &ctl, sizeof(ctl)))
+				return -ENOENT;
+		}
 	}
 
 	/* VTL-shared state: GPRs except RSP (RIP/RFLAGS stay private). */
@@ -2830,26 +3041,17 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 	vcpu->common->vtl_fpu_from = cur;
 
 	if (!is_return) {
-		assist = hv_vtl_assist_page_gpa(target);
-		if (assist) {
-			ctl = (struct hv_vtl_control) {
-				.vtl_entry_reason = HV_VTL_ENTRY_REASON_VTL_CALL,
-				.vtl_ret_x64rax = rax,
-				.vtl_ret_x64rcx = rcx,
-			};
-			kvm_vcpu_write_guest(vcpu,
-					     assist + HV_VTL_CONTROL_OFFSET,
-					     &ctl, sizeof(ctl));
-		}
 		if (to_hv_vcpu(target)) {
 			to_hv_vcpu(target)->vtl_entry_rax = rax;
 			to_hv_vcpu(target)->vtl_entry_rcx = rcx;
+			to_hv_vcpu(target)->vtl_entry_regs_valid = true;
 		}
 		resume = rax;
 	} else {
 		if (!fast)
 			kvm_rcx_write(target, ctl.vtl_ret_x64rcx);
 		resume = fast ? rax : ctl.vtl_ret_x64rax;
+		to_hv_vcpu(vcpu)->vtl_entry_regs_valid = false;
 	}
 
 	/*
@@ -2859,9 +3061,27 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 	 * exactly as when userspace drives the switch; until then its
 	 * suspended RIP stays at the vmcall, which the higher VTL can
 	 * observe (and rewrite) through HvCallGetVpRegisters.
+	 *
+	 * The resume value is guest-derived in all three cases (the
+	 * caller's RAX on a call or a fast return, the control area on a
+	 * non-fast return): strip the VMM-only RAISE_UD control bit so
+	 * the completion cannot be made to inject #UD into the suspended
+	 * plane.
 	 */
+	resume &= ~KVM_HV_HCALL_RESULT_RAISE_UD;
 	if (target->arch.complete_userspace_io)
 		vcpu->run->hyperv.u.hcall.result = resume;
+	else
+		/*
+		 * No completion is armed when the target's suspension
+		 * already retired its vmcall (forwarded switch) or was a
+		 * forced interrupt entry: RIP is already where the plane
+		 * resumes, so deliver the resume RAX directly.  Without
+		 * this the GPR copy above leaves the switching plane's raw
+		 * RAX in place and a non-fast return never restores the
+		 * control-area value.
+		 */
+		kvm_rax_write(target, resume);
 
 	/*
 	 * Suspend the current plane in its uncompleted hypercall; the
@@ -2869,9 +3089,8 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 	 */
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
 
-	vcpu->plane_user_stopped = true;
+	vcpu->plane_kernel_stopped = true;
 	kvm_vcpu_set_plane_stopped(vcpu);
-	target->plane_user_stopped = false;
 	kvm_vcpu_set_plane_runnable(target);
 	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
 	return 0;
@@ -3050,7 +3269,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
 			break;
 		}
-		if (to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch &&
+		if (READ_ONCE(to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch) &&
 		    !hc.fast &&
 		    !kvm_hv_vtl_switch(vcpu, hc.code == HVCALL_VTL_RETURN)) {
 			/*
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 0593fe4333d3..0b81ba482201 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -102,6 +102,9 @@ static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 }
 
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
+bool kvm_hv_vtl_interrupt_entry(struct kvm_vcpu *vcpu,
+				struct kvm_vcpu *target);
+bool kvm_hv_vtl_entry_blocked(struct kvm_vcpu *target);
 
 void kvm_hv_irq_routing_update(struct kvm *kvm);
 int kvm_hv_synic_set_irq(struct kvm_kernel_irq_routing_entry *e, struct kvm *kvm,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d10aa5f60cad..e1c5f1608b09 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5640,7 +5640,14 @@ static int handle_desc(struct kvm_vcpu *vcpu)
 	 */
 	BUILD_BUG_ON(KVM_POSSIBLE_CR4_GUEST_BITS & X86_CR4_UMIP);
 
-	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP));
+	/*
+	 * Descriptor-table exits are also armed when a higher VTL registers
+	 * DT intercepts (reg_intercept_control); only an exit with neither
+	 * UMIP emulation nor an armed intercept indicates a stale
+	 * SECONDARY_EXEC_DESC control.
+	 */
+	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP) &&
+		     !(to_hv_vcpu(vcpu) && to_hv_vcpu(vcpu)->reg_intercept_control));
 	return kvm_emulate_instruction(vcpu, 0);
 }
 
@@ -8044,6 +8051,20 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
+
+	/*
+	 * Trap descriptor-table instructions when a higher VTL armed
+	 * register intercepts on them, and stop trapping when the
+	 * intercepts are disarmed.  Preserve the control when UMIP
+	 * emulation needs it (CR4.UMIP owns it then).
+	 */
+	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_DESC) {
+		if (to_hv_vcpu(vcpu) && to_hv_vcpu(vcpu)->reg_intercept_control)
+			secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_DESC);
+		else if (!(vmx_umip_emulated() &&
+			   kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP)))
+			secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_DESC);
+	}
 }
 
 static __init u64 vmx_get_perf_capabilities(void)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index aa8e14a45568..374330f61eb2 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4885,6 +4885,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_SYS_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_FORWARD_HCALL:
 	case KVM_CAP_HYPERV_VTL_SWITCH:
+	case KVM_CAP_HYPERV_REG_INTERCEPT:
 #endif
 	case KVM_CAP_HCALL_FAULT_EXIT:
 	case KVM_CAP_PCI_SEGMENT:
@@ -6144,6 +6145,19 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			}
 			return r;
 		}
+	case KVM_CAP_HYPERV_REG_INTERCEPT: {
+		struct kvm_vcpu_hv *hv_vcpu;
+		int r;
+
+		r = kvm_hv_vcpu_init(vcpu);
+		if (r)
+			return r;
+		hv_vcpu = to_hv_vcpu(vcpu);
+		hv_vcpu->reg_intercept_control = cap->args[0];
+		/* Refresh the descriptor-table exiting controls. */
+		kvm_x86_call(vcpu_after_set_cpuid)(vcpu);
+		return 0;
+	}
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 		if (!kvm_x86_ops.enable_l2_tlb_flush)
 			return -ENOTTY;
@@ -6931,7 +6945,7 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = -EINVAL;
 		if (cap->args[0] & ~1ULL)
 			break;
-		to_kvm_hv(kvm)->hv_inkernel_vtl_switch = !!cap->args[0];
+		WRITE_ONCE(to_kvm_hv(kvm)->hv_inkernel_vtl_switch, !!cap->args[0]);
 		r = 0;
 		break;
 #endif
@@ -8814,14 +8828,55 @@ static void emulator_get_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 	kvm_x86_call(get_idt)(emul_to_vcpu(ctxt), dt);
 }
 
+/*
+ * Divert a descriptor-table write into a register-intercept exit when the
+ * higher VTL armed one: the write is not applied, and userspace delivers
+ * the TLFS register-intercept message to the higher VTL.
+ */
+static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
+			       const struct desc_ptr *dt, u64 ctl_bit)
+{
+#ifdef CONFIG_KVM_HYPERV
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	if (!hv_vcpu || vcpu->plane_level ||
+	    !(hv_vcpu->reg_intercept_control & ctl_bit))
+		return false;
+
+	hv_vcpu->reg_intercept.reg = hv_reg;
+	hv_vcpu->reg_intercept.base = dt->address;
+	hv_vcpu->reg_intercept.limit = dt->size;
+	hv_vcpu->reg_intercept.rip = ctxt->eip;
+	hv_vcpu->reg_intercept.insn_len = ctxt->_eip - ctxt->eip;
+	hv_vcpu->reg_intercept.pending = true;
+	return true;
+#else
+	return false;
+#endif
+}
+
+#define HV_CR_INTERCEPT_GDTR_WRITE	BIT_ULL(15)
+#define HV_CR_INTERCEPT_IDTR_WRITE	BIT_ULL(16)
+#define HV_X64_REGISTER_IDTR_ID		0x00070000
+#define HV_X64_REGISTER_GDTR_ID		0x00070001
+
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
+	if (hv_divert_dt_write(ctxt, HV_X64_REGISTER_GDTR_ID, dt,
+			       HV_CR_INTERCEPT_GDTR_WRITE))
+		return;
 	kvm_x86_call(set_gdt)(emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	kvm_x86_call(set_idt)(emul_to_vcpu(ctxt), dt);
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+
+	if (hv_divert_dt_write(ctxt, HV_X64_REGISTER_IDTR_ID, dt,
+			       HV_CR_INTERCEPT_IDTR_WRITE))
+		return;
+	kvm_x86_call(set_idt)(vcpu, dt);
 }
 
 static unsigned long emulator_get_cached_segment_base(
@@ -9607,6 +9662,44 @@ int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(x86_decode_emulated_instruction);
 
+#ifdef CONFIG_KVM_HYPERV
+/*
+ * Complete a descriptor-table write that hv_divert_dt_write() diverted
+ * during the emulation that just finished: rewind RIP and build the
+ * KVM_EXIT_HYPERV_REG_INTERCEPT exit.  Consuming the record before
+ * x86_emulate_instruction() returns means it never outlives the emulation
+ * call: no stale rewind can fire on a later KVM_RUN, and disarming the cap
+ * or migrating the vCPU can never see a half-delivered intercept.
+ */
+static int complete_hv_reg_intercept(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	hv_vcpu->reg_intercept.pending = false;
+
+	/*
+	 * The intercepted instruction must not retire: the emulator advanced
+	 * RIP when it diverted the write, but the higher VTL owns
+	 * completion.  It either applies the write and advances RIP itself,
+	 * disarms the intercept so re-execution succeeds, or queues an
+	 * exception that must fault AT the instruction (the
+	 * kernel-patch-protection LIDT probe matches the faulting RIP
+	 * against the probe site).
+	 */
+	kvm_rip_write(vcpu, hv_vcpu->reg_intercept.rip);
+	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
+	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_REG_INTERCEPT;
+	vcpu->run->hyperv.plane = vcpu->plane_level;
+	vcpu->run->hyperv.u.reg_intercept.reg = hv_vcpu->reg_intercept.reg;
+	vcpu->run->hyperv.u.reg_intercept.insn_len =
+		hv_vcpu->reg_intercept.insn_len;
+	vcpu->run->hyperv.u.reg_intercept.base = hv_vcpu->reg_intercept.base;
+	vcpu->run->hyperv.u.reg_intercept.limit = hv_vcpu->reg_intercept.limit;
+	vcpu->run->hyperv.u.reg_intercept.rip = hv_vcpu->reg_intercept.rip;
+	return 0;
+}
+#endif
+
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len)
 {
@@ -9826,6 +9919,15 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	} else
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = true;
 
+#ifdef CONFIG_KVM_HYPERV
+	{
+		struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+		if (hv_vcpu && hv_vcpu->reg_intercept.pending)
+			r = complete_hv_reg_intercept(vcpu);
+	}
+#endif
+
 	return r;
 }
 
@@ -11083,6 +11185,77 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+/*
+ * A pending interrupt for a higher plane preempts this one: the higher
+ * VTL's interrupts take priority over lower-VTL execution (TLFS 15.2.4),
+ * and the secure kernel relies on it, e.g. to freeze the other processors'
+ * VTL1 while starting a new one.
+ */
+static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *higher;
+	int i;
+
+	for (i = vcpu->plane_level + 1; i < KVM_MAX_PLANES; i++) {
+		higher = vcpu->common->vcpus[i];
+		if (!higher)
+			continue;
+#ifdef CONFIG_KVM_HYPERV
+		/*
+		 * With in-kernel switching, an event on a plane the forced
+		 * entry would refuse (never run, user-stopped, parked on a
+		 * foreign completion) has no consumer until userspace
+		 * starts the plane; reporting it would wake a halted lower
+		 * VTL into an endless hlt/wake loop.  With userspace
+		 * switching the event is consumable via the interrupt exit,
+		 * so it does count.
+		 */
+		if (READ_ONCE(to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch) &&
+		    kvm_hv_vtl_entry_blocked(higher))
+			continue;
+#endif
+		/*
+		 * Test raw pending-ness, not injectability:
+		 * kvm_cpu_has_injectable_intr() reports false on an
+		 * APICv-active vCPU, and a suspended plane may carry a
+		 * stale apicv_active until it next runs.  A pending
+		 * synthetic-timer request counts as well: it can only be
+		 * processed (and its interrupt delivered) once the higher
+		 * plane runs, so it would otherwise never fire while the
+		 * plane is suspended.
+		 */
+		if (kvm_cpu_has_extint(higher) ||
+		    kvm_apic_has_interrupt(higher) != -1 ||
+		    kvm_test_request(KVM_REQ_HV_STIMER, higher))
+			return higher;
+	}
+	return NULL;
+}
+
+#ifdef CONFIG_KVM_HYPERV
+/*
+ * With userspace owning VTL transitions, report a pending higher-plane
+ * event as an exit so userspace can enter the higher VTL.  Returns true
+ * when the exit was prepared.
+ */
+static bool kvm_hv_vtl_interrupt_exit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *higher;
+
+	if (READ_ONCE(to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch))
+		return false;
+
+	higher = kvm_higher_plane_with_event(vcpu);
+	if (!higher)
+		return false;
+
+	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
+	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_VTL_INTERRUPT;
+	vcpu->run->hyperv.plane = higher->plane_level;
+	return true;
+}
+#endif
+
 static inline bool kvm_check_plane0_events(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *vcpu_plane0;
@@ -11548,13 +11721,30 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	}
 
 	if (kvm_check_plane0_events(vcpu) &&
-	    !vcpu->common->vcpus[0]->plane_user_stopped) {
+	    !vcpu->common->vcpus[0]->plane_user_stopped &&
+	    !vcpu->common->vcpus[0]->plane_kernel_stopped) {
 		kvm_vcpu_set_plane_runnable(vcpu->common->vcpus[0]);
 
 		kvm_make_request(KVM_REQ_EVENT, vcpu);
 		kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
 	}
 
+#ifdef CONFIG_KVM_HYPERV
+	if (kvm_hv_vtl_interrupt_exit(vcpu)) {
+		r = 0;
+		goto out;
+	}
+
+	if (READ_ONCE(to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch)) {
+		struct kvm_vcpu *higher = kvm_higher_plane_with_event(vcpu);
+
+		if (higher && kvm_hv_vtl_interrupt_entry(vcpu, higher)) {
+			kvm_make_request(KVM_REQ_EVENT, higher);
+			kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+		}
+	}
+#endif
+
 	if (kvm_check_request(KVM_REQ_PLANE_RESCHED, vcpu)) {
 		vcpu->common->plane_switch = true;
 		r = 0;
@@ -11904,7 +12094,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_has_events);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_running(vcpu) || vcpu->arch.pv.pv_unhalted ||
-	       kvm_vcpu_has_events(vcpu);
+	       kvm_vcpu_has_events(vcpu) ||
+	       kvm_higher_plane_with_event(vcpu);
 }
 
 /* Called within kvm->srcu read side.  */
@@ -11999,6 +12190,17 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
 		if (r <= 0)
 			break;
 
+#ifdef CONFIG_KVM_HYPERV
+		/*
+		 * A halted lower VTL never reaches vcpu_enter_guest, but a
+		 * pending higher-VTL event must still preempt it.
+		 */
+		if (!kvm_vcpu_running(vcpu) && kvm_hv_vtl_interrupt_exit(vcpu)) {
+			r = 0;
+			break;
+		}
+#endif
+
 		kvm_clear_request(KVM_REQ_UNBLOCK, vcpu);
 		if (kvm_xen_has_pending_events(vcpu))
 			kvm_xen_inject_pending_events(vcpu);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index e1b6ee863777..956e9fb7ec33 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1346,7 +1346,8 @@ struct hv_input_set_vp_registers {
 /* HvCallSendSyntheticClusterIpi hypercall */
 struct hv_send_ipi {	 /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI */
 	u32 vector;
-	u32 reserved;
+	union hv_input_vtl in_vtl;
+	u8 reserved[3];
 	u64 cpu_mask;
 } __packed;
 
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index b4cb2fa26e9b..a2180b35f646 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -464,7 +464,8 @@ struct hv_input_unmap_device_interrupt {
 
 struct hv_send_ipi_ex { /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI_EX */
 	u32 vector;
-	u32 reserved;
+	union hv_input_vtl in_vtl;
+	u8 reserved[3];
 	struct hv_vpset vp_set;
 } __packed;
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 79b3ec2b95b8..a76615f2c3dc 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -427,8 +427,20 @@ struct kvm_vcpu {
 	 * Set when userspace stopped this plane with
 	 * KVM_SET_PLANE_RUN_STATE: pending plane-0 events then no longer
 	 * make plane 0 runnable on their own, the VMM owns the switch.
+	 * Only the ioctl sets it; in-kernel plane transitions never
+	 * override it, and kvm_vcpu_set_plane_runnable() clears it so a
+	 * runnable plane cannot carry a stale latch.
 	 */
 	bool plane_user_stopped;
+	/*
+	 * Set when an in-kernel VTL switch suspends this plane: plane-0
+	 * events are gated exactly as for a userspace stop, but
+	 * KVM_GET_PLANE_RUN_STATE reports the state as
+	 * KVM_PLANE_RUN_STATE_KERNEL_STOPPED so that a save/restore
+	 * round trip does not convert a transient kernel suspension
+	 * into userspace stop policy.
+	 */
+	bool plane_kernel_stopped;
 
 	/* S390 only */
 	bool valid_wakeup;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b50f92135acd..9e453f215e68 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -99,6 +99,8 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_SYNIC          1
 #define KVM_EXIT_HYPERV_HCALL          2
 #define KVM_EXIT_HYPERV_SYNDBG         3
+#define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+#define KVM_EXIT_HYPERV_REG_INTERCEPT  5
 	__u32 type;
 	__u32 plane;
 	union {
@@ -114,6 +116,15 @@ struct kvm_hyperv_exit {
 			__u64 result;
 			__u64 params[2];
 		} hcall;
+		struct {
+			__u32 reg;
+			__u8 insn_len;
+			__u8 pad[3];
+			__u64 base;
+			__u32 limit;
+			__u32 pad2;
+			__u64 rip;
+		} reg_intercept;
 		struct {
 			__u32 msr;
 			__u32 pad2;
@@ -1026,6 +1037,7 @@ struct kvm_enable_cap {
 #define KVM_HV_HCALL_RESULT_RAISE_UD	(1ULL << 63)
 #define KVM_CAP_HCALL_FAULT_EXIT 252
 #define KVM_CAP_HYPERV_VTL_SWITCH 253
+#define KVM_CAP_HYPERV_REG_INTERCEPT 254
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1384,6 +1396,7 @@ struct kvm_s390_keyop {
 #define KVM_SET_PLANE_RUN_STATE	  _IOW(KVMIO, 0xe6, __u32)
 #define   KVM_PLANE_RUN_STATE_STOPPED	0
 #define   KVM_PLANE_RUN_STATE_RUNNABLE	1
+#define   KVM_PLANE_RUN_STATE_KERNEL_STOPPED	2
 
 /*
  * ioctls for vcpu fds
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ef6e59a15846..4197496f7176 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5023,9 +5023,14 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		break;
 	}
 	case KVM_GET_PLANE_RUN_STATE: {
-		u32 state = vcpu->plane_state == RUNNABLE ?
-			    KVM_PLANE_RUN_STATE_RUNNABLE :
-			    KVM_PLANE_RUN_STATE_STOPPED;
+		u32 state;
+
+		if (vcpu->plane_state == RUNNABLE)
+			state = KVM_PLANE_RUN_STATE_RUNNABLE;
+		else if (vcpu->plane_user_stopped)
+			state = KVM_PLANE_RUN_STATE_STOPPED;
+		else
+			state = KVM_PLANE_RUN_STATE_KERNEL_STOPPED;
 
 		r = -EINVAL;
 		if (kvm_arch_max_planes(vcpu->kvm) <= 1)
@@ -5052,13 +5057,15 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		if (copy_from_user(&state, argp, sizeof(state)))
 			goto out;
 		r = -EINVAL;
-		if (state > KVM_PLANE_RUN_STATE_RUNNABLE)
+		if (state > KVM_PLANE_RUN_STATE_KERNEL_STOPPED)
 			goto out;
 		if (state == KVM_PLANE_RUN_STATE_RUNNABLE) {
-			vcpu->plane_user_stopped = false;
 			kvm_vcpu_set_plane_runnable(vcpu);
 		} else {
-			vcpu->plane_user_stopped = true;
+			vcpu->plane_user_stopped =
+				state == KVM_PLANE_RUN_STATE_STOPPED;
+			vcpu->plane_kernel_stopped =
+				state == KVM_PLANE_RUN_STATE_KERNEL_STOPPED;
 			kvm_vcpu_set_plane_stopped(vcpu);
 		}
 		r = 0;
@@ -5319,6 +5326,13 @@ static struct file_operations kvm_plane_fops = {
 
 void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu)
 {
+	/*
+	 * A runnable plane must not carry a stale stop latch: the latches
+	 * gate the plane-0 event wakeup, and KVM_GET_PLANE_RUN_STATE could
+	 * not report the inconsistency.
+	 */
+	vcpu->plane_user_stopped = false;
+	vcpu->plane_kernel_stopped = false;
 	vcpu->plane_state = RUNNABLE;
 	vcpu->common->plane_switch = true;
 	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
@@ -5349,7 +5363,16 @@ struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu)
 	}
 
 	if (ret == NULL) {
+		/*
+		 * Never force a userspace-stopped plane 0 to run: it may be
+		 * suspended mid-hypercall, and the VMM owns restarting it.
+		 * KVM_RUN fails instead, surfacing the VMM's ordering bug.
+		 */
 		ret = common->vcpus[0];
+		if (ret->plane_user_stopped)
+			return NULL;
+
+		ret->plane_kernel_stopped = false;
 		ret->plane_state = RUNNABLE;
 	}
 
-- 
2.50.1

