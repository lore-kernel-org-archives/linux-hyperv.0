Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=nHOPnhSBBGtDeu5IxSCgTlXROxuGGr0bzcQpQDUDctoXNgSZjuWRJv9n37UpKLBNB4YD
	 feEEYMy1HwrfNkicy+PTblNU15/cQbmNXPHzrVkfXlLYcEEkojITRFGfkswST6KDKm1Kd
	 8tAgoMd7o6VV3bjE9H+LUCgGVTCM9yJrhYVrEVgMLA0L7Jl6UlASMV/6m9uEaerFE5vzC
	 7nq+YPWToUX6RzoRffX5+lfJAVqPaC7Ghd7PEB9W5GOygjBqZbJofIiR43phqo9S9M1d2
	 4kQeyPG7e5iwpI0btSAslI5/0EhRRZHn9gNY8xhNWYJixfC8rEwzzfKeYKkV4VkJSJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=MmkPacTIDMpk9ZOhjf3kRV3NcVYG9AoDWHfulpDFBfY=;
	b=aMCjxtgirHG+NQuSul6Duv8T1fRjPkoTMLeBM3yLJHkPE3ofoddzDFRsoI00CkGXLao/
	 WNexs0ema9yFGXNZlMXH33UVQMSPg50lUlPS2I8+c2oCybsHMQSGZkBy5Z0tDbCqzNIgE
	 qMLpZwEfOdI0H45N0Pp0rT7T/e0e4oIFhtSLaHXvE8JcGEnQhchqlP+yHmDeiJySNiqSa
	 3tkMwawuSzWFC5zjoUeLxDZuTWm6CONZpOGlIxk6IRQHSnk1NJiy11YlO6siTlCryLpz8
	 JX/6XfLYGK1YEsQUIm3MOVLC4fK8XC+CrIcF5kiPI/SYp+co7bG809TSzSj6zGVh0TA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KoVi4cdM;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B005606A332;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B005606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=KoVi4cdM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=MmkPacTIDMpk9ZOhjf3kRV3NcVYG9AoDWHfulpDFBfY=; b=KoVi4cdMrbfHUOtR0YyeydRVCp
	459bJWbs57Gq6oR75HaVCvgA6e6600BcY1DbcEQHacDNPCTHK1rp0L7KNsvoK9C67tHkRRXDIcmmo
	HT8vUbNgAsAcS2CtfdlPS4pZX9D002TYKWoH0PLYd2L1T/CPYm9ucElkFXwGi+R6/ZoK2zMOjH6Pw
	eMguqDE5gbAms5kXJQHQJxmDZC9KD60SmieNocEo6QGSQZXA62zGawbzrWO4XIeOVsqTKcoZBIPGf
	oO0IdCJ4YCnd/Uk37VbcJuRQsaPdA4cjvy11kxWZQnVboc2quixI4yhbjbAX63XigHXiNmJgLdz/j
	Oj7t44iw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPb-3QhR;
	Fri, 13 Nov 2026 18:34:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lt0-2Sst;
	Fri, 13 Nov 2026 18:34:49 +0000
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
Subject: [RFC PATCH v2 08/31] KVM: x86: hyperv: Let higher-VTL interrupts preempt a lower VTL
Date: Fri, 13 Nov 2026 18:34:24 +0000
Message-ID: <20261113183448.84094-9-dwmw2@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

In the TLFS, an interrupt pending for a higher VTL preempts execution
in a lower VTL (TLFS §15.2.4), and the secure kernel depends on it, for
example to freeze the other processors' VTL1 while it starts a new one.
KVM never looks at a suspended higher plane while a lower plane runs,
so the interrupt waits until the lower VTL calls up, and a Windows VSM
boot stalls.

kvm_higher_plane_with_event() reports the nearest higher plane with a
pending ExtINT, synthetic-timer request or LAPIC timer expiry, or an
interrupt posted to it while suspended. Such an event also makes the
lower vCPU runnable. Nothing is reported without
KVM_HYPERV_HCALL_VTL_CALLS, since only the VTL contract consumes it.

Interrupts force entry edge-triggered, one attempt per posting, not
level-triggered on the plane's IRR: a vector that stays latched,
because an entry was refused (no VP assist page yet) or the higher
plane's TPR masks it, would otherwise retry the entry on every run of
the lower plane and be replayed the moment the assist page is enabled.
Delivering a fixed vector to a non-zero plane sets
hv_apic_event_pending on it. The marker is cleared by a
KVM_EXIT_HYPERV_VTL_INTERRUPT exit for the plane, and by a run of the
plane itself that reaches event evaluation; a run aborted by the VTL
exit or KVM_REQ_PLANE_RESCHED bail-outs in vcpu_enter_guest() leaves it
set, since nothing would re-arm it for a TPR-masked vector.

With KVM_HYPERV_HCALL_VTL_CALLS alone, userspace switches planes: KVM
exits with the new KVM_EXIT_HYPERV_VTL_INTERRUPT naming the higher
plane, from vcpu_enter_guest() and from the halted path in vcpu_run(),
so the VMM enters that VTL and its view of the active VTL stays in sync.
With KVM_HYPERV_HCALL_VTL_SWITCH, kvm_hv_vtl_interrupt_entry() enters
the higher plane in the kernel, writing the INTERRUPT entry reason and
the preempted RAX/RCX into its control area through the entered plane.
The lower plane resumes at the preempted RIP; a failed write leaves the
event pending.

kvm_hv_vtl_entry_blocked() names the targets the in-kernel paths must
not enter: a plane that never ran, one userspace holds, and one
parked on a completion other than the hypercall one. Forced entry
refuses them, and in that mode kvm_higher_plane_with_event() skips
their events, or a halted lower VTL would spin through hlt/wake on an
event nothing can consume. In userspace mode the exit lets the VMM
consume them, so they still count.

The forced entry follows the VTL call's rules for what it writes and
carries: only the entry reason and RAX/RCX of the control area (the
VMM owns vina_asserted), and the FPU through the same run-loop carry,
which also leaves the event pending when the twins' fpstates differ.
A target parked in a hypercall of its own keeps the copied RAX, and
its pending completion only retires the vmcall.

A timer expiry counts once it has fired but not been injected, since
injection only happens when the plane runs. It is tested with
kvm_cpu_has_pending_timer(), the check that gates the injection:
apic_timer_expired() latches an expiry whatever the LVTT mask says, and
a higher VTL that arms its timer and then masks LVTT would otherwise
leave an event that nothing ever injects, forcing the lower VTL into
the higher one, or out to userspace, on every entry.

A higher plane's LAPIC timer can ride the VMX preemption timer, which
only counts in VMX non-root mode, so a suspended plane's timer would
never fire. When KVM_RUN on a non-zero plane ends with the hv timer in
use, move the timer to the hrtimer, which keeps counting while the
plane is parked, and move it back when the plane next runs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  |  27 ++++--
 arch/x86/include/asm/kvm_host.h |   9 ++
 arch/x86/kvm/hyperv.c           | 132 +++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h           |   7 ++
 arch/x86/kvm/lapic.c            |  31 +++++++
 arch/x86/kvm/lapic.h            |   3 +
 arch/x86/kvm/x86.c              | 148 +++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h        |   1 +
 8 files changed, 350 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 61cfda97fa29..b76c46cc5000 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7447,6 +7447,7 @@ EOI was received.
   #define KVM_EXIT_HYPERV_SYNIC          1
   #define KVM_EXIT_HYPERV_HCALL          2
   #define KVM_EXIT_HYPERV_SYNDBG         3
+  #define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
 			__u32 type;
 			__u32 plane;
 			union {
@@ -7482,8 +7483,9 @@ Indicates that the VCPU exits into userspace to process some tasks
 related to Hyper-V emulation.
 
 'plane' identifies the plane the exit concerns: the plane of the vCPU
-that triggered the exit.  On kernels without plane support the field
-was padding and reads as zero.
+that triggered the exit, or for KVM_EXIT_HYPERV_VTL_INTERRUPT the
+higher plane to be entered.  On kernels without plane support the
+field was padding and reads as zero.
 
 Valid values for 'type' are:
 
@@ -7521,6 +7523,17 @@ Hyper-V Synthetic debugger state change. Notification is used to either update
 the pending_page location or to send a control command (send the buffer located
 in send_page or recv a buffer to recv_page).
 
+	- KVM_EXIT_HYPERV_VTL_INTERRUPT -- the plane named by 'plane' has a
+
+pending event that preempts the current, lower plane (TLFS: higher VTL
+interrupts preempt lower VTLs).  The VMM is expected to perform a VTL
+entry into that plane.  Delivered only while KVM_HYPERV_HCALL_VTL_CALLS
+is enabled and in-kernel VTL switching (KVM_HYPERV_HCALL_VTL_SWITCH) is
+not, see section 7.50, and
+single-shot: if the VMM declines the entry, the event waits in the
+target plane for a cooperative entry rather than re-triggering the
+exit.
+
 ::
 
 		/* KVM_EXIT_ARM_NISV / KVM_EXIT_ARM_LDST64B */
@@ -9514,8 +9527,11 @@ instruction is already retired when the exit is delivered and
 captured-register contract instead: on a successful switch the calling
 VTL's RAX and RCX are restored to their captured values when it next
 runs; on failure userspace writes the error status into the guest's RAX
-itself (KVM_SET_REGS) before resuming the vCPU.  While this bit is
-clear the two calls are ordinary hypercalls that KVM does not implement.
+itself (KVM_SET_REGS) before resuming the vCPU.  A pending event for a
+higher plane surfaces as a KVM_EXIT_HYPERV_VTL_INTERRUPT exit (see
+section 5) telling the VMM to enter that plane.  While this bit is clear
+the two calls are ordinary hypercalls that KVM does not implement, and
+higher-plane events do not preempt a lower plane.
 
 KVM_HYPERV_HCALL_VTL_SWITCH: requires KVM_HYPERV_HCALL_VTL_CALLS, and
 KVM_ENABLE_CAP fails with -EINVAL if it is set alone.  KVM handles the
@@ -9523,7 +9539,8 @@ non-fast forms of HvCallVtlCall and HvCallVtlReturn itself where it can:
 the calling plane's vCPU is suspended mid-hypercall and its twin in the
 target plane resumed, with the VTL-shared register state (GPRs except
 RSP, CR2, FPU) carried across and the entered VTL's assist page updated
-as the TLFS specifies.  A transition KVM cannot handle (a
+as the TLFS specifies.  A pending event for a higher plane forces entry
+into that plane instead of exiting.  A transition KVM cannot handle (a
 fast-form call, no twin vCPU in the target plane, a target that cannot
 be entered) exits to userspace as described for
 KVM_HYPERV_HCALL_VTL_CALLS, so the VMM must still implement the
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 75861e54a041..74899a27e29e 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -755,6 +755,15 @@ int kvm_arch_vcpu_common_init(struct kvm_vcpu_common *common);
 void kvm_arch_vcpu_common_destroy(struct kvm_vcpu_common *common);
 
 struct kvm_vcpu_arch {
+	/*
+	 * Hyper-V VSM: an APIC event (fixed vector or NMI) was delivered to
+	 * this plane while it was suspended.  Set at delivery, cleared when
+	 * the plane next runs; a lower plane's run loop uses it to force a
+	 * VTL entry even when the vector is currently masked by this
+	 * plane's TPR (matching the reference host's apic_pending_vtls).
+	 */
+	bool hv_apic_event_pending;
+
 	/*
 	 * rip and regs accesses must go through
 	 * kvm_{register,rip}_{read,write} functions.
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3d55ca709c29..6b76e8ca845a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -3108,6 +3108,134 @@ static bool hv_vtl_fpstates_match(struct kvm_vcpu *a, struct kvm_vcpu *b)
 	       fa->xfeatures == fb->xfeatures;
 }
 
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
+ *  - never run (kvm_hv_plane_has_run()): it still holds reset state
+ *    (userspace owns HvCallEnableVpVtl and runs a plane's first entry
+ *    itself);
+ *  - held by userspace (KVM_PLANE_RUN_STATE_USER_HOLD): the VMM owns
+ *    releasing it;
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
+	if (!kvm_hv_plane_has_run(target))
+		return true;
+
+	if (target->plane_user_hold)
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
+	 * The FPU follows the entry as one image; with mismatched twin
+	 * fpstates the event stays pending for userspace to enter the
+	 * plane, as with any other entry the kernel cannot make.
+	 */
+	if (!hv_vtl_fpstates_match(vcpu, target))
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
+		/* As for a VTL call, vina_asserted belongs to the VMM. */
+		ctl.vtl_entry_reason = HV_VTL_ENTRY_REASON_INTERRUPT;
+		ctl.vtl_ret_x64rax = rax;
+		ctl.vtl_ret_x64rcx = rcx;
+		if (kvm_vcpu_write_guest(target, assist + HV_VTL_CONTROL_OFFSET,
+					 &ctl.vtl_entry_reason,
+					 sizeof(ctl.vtl_entry_reason)) ||
+		    kvm_vcpu_write_guest(target,
+					 assist + HV_VTL_CONTROL_OFFSET +
+					 offsetof(struct hv_vtl_control,
+						  vtl_ret_x64rax),
+					 &ctl.vtl_ret_x64rax,
+					 sizeof(ctl.vtl_ret_x64rax) +
+					 sizeof(ctl.vtl_ret_x64rcx)))
+			return false;
+	}
+
+	for (i = 0; i < ARRAY_SIZE(shared_gprs); i++)
+		kvm_register_write_raw(target, shared_gprs[i],
+				       kvm_register_read_raw(vcpu,
+							     shared_gprs[i]));
+	target->arch.cr2 = vcpu->arch.cr2;
+	vcpu->common->vtl_fpu_from = vcpu->plane_level;
+	vcpu->common->vtl_fpu_to = target->plane_level;
+
+	if (to_hv_vcpu(target)) {
+		to_hv_vcpu(target)->vtl_entry_rax = rax;
+		to_hv_vcpu(target)->vtl_entry_rcx = rcx;
+		to_hv_vcpu(target)->vtl_entry_regs_valid = true;
+	}
+
+	/*
+	 * The target resumes its suspended hypercall, if it has one.  Its
+	 * RAX is the shared RAX as copied from the entering plane just
+	 * above: GPRs are VTL-shared, so the retired hypercall's RAX must
+	 * match what every other shared register already shows.  As for a
+	 * VTL switch, the pending completion then only retires the vmcall.
+	 */
+	if (target->arch.complete_userspace_io) {
+		to_hv_vcpu(target)->hcall_kernel_result = true;
+		to_hv_vcpu(target)->hcall_resume_pending = false;
+	}
+
+	vcpu->plane_suspended = true;
+	kvm_vcpu_set_plane_stopped(vcpu);
+	target->plane_suspended = false;
+	kvm_vcpu_set_plane_runnable(target);
+	return true;
+}
+
 /*
  * In-kernel VTL call/return: switch between the plane vCPUs directly
  * instead of bouncing every transition through userspace.  Keeps the
@@ -3291,8 +3419,8 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 	 * observe (and rewrite) through HvCallGetVpRegisters.  A rewritten
 	 * RIP suppresses the deferred skip: the plane resumes exactly where
 	 * the higher VTL pointed it.  A target whose suspension already
-	 * retired its vmcall (forwarded switch) has no completion armed and
-	 * resumes where RIP points.
+	 * retired its vmcall (forwarded switch) or was a forced interrupt
+	 * entry has no completion armed and resumes where RIP points.
 	 */
 	kvm_rax_write_raw(target, resume);
 	if (target->arch.complete_userspace_io) {
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index fc64fd0fd54f..fbfbe0d52f9c 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -242,6 +242,9 @@ static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
 {
 	return READ_ONCE(to_kvm_hv(kvm)->hcall_features) & feature;
 }
+bool kvm_hv_vtl_interrupt_entry(struct kvm_vcpu *vcpu,
+				struct kvm_vcpu *target);
+bool kvm_hv_vtl_entry_blocked(struct kvm_vcpu *target);
 
 /*
  * Whether a plane has a guest context to enter: it has entered the guest
@@ -427,6 +430,10 @@ static inline void kvm_hv_nested_transtion_tlb_flush(struct kvm_vcpu *vcpu,
 
 int kvm_hv_vcpu_flush_tlb(struct kvm_vcpu *vcpu);
 #else /* CONFIG_KVM_HYPERV */
+static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
+{
+	return false;
+}
 static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
 					 struct pvclock_vcpu_time_info *hv_clock) {}
 static inline void kvm_hv_request_tsc_page_update(struct kvm *kvm) {}
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index b05b803104a9..ccf01b263ebf 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1448,6 +1448,13 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 
 		kvm_x86_call(deliver_interrupt)(apic, delivery_mode,
 						trig_mode, vector);
+
+		/*
+		 * Mark the posting of an interrupt to a higher plane for
+		 * the forced entry (see kvm_higher_plane_with_event()).
+		 */
+		if (vcpu->plane_level)
+			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
 		break;
 
 	case APIC_DM_REMRD:
@@ -2387,6 +2394,30 @@ void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu)
 	preempt_enable();
 }
 
+/*
+ * The hv timer only counts while the vCPU is in guest mode, which a
+ * suspended plane never reaches until something enters it.  Move the
+ * timer of a plane that may be parked to the hrtimer, and move it back
+ * once the plane runs again.
+ */
+void kvm_lapic_park_timer(struct kvm_vcpu *vcpu)
+{
+	if (!kvm_lapic_hv_timer_in_use(vcpu))
+		return;
+
+	kvm_lapic_switch_to_sw_timer(vcpu);
+	vcpu->arch.apic->lapic_timer.parked = true;
+}
+
+void kvm_lapic_unpark_timer(struct kvm_vcpu *vcpu)
+{
+	if (!lapic_in_kernel(vcpu) || !vcpu->arch.apic->lapic_timer.parked)
+		return;
+
+	vcpu->arch.apic->lapic_timer.parked = false;
+	kvm_lapic_switch_to_hv_timer(vcpu);
+}
+
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu)
 {
 	struct kvm_lapic *apic = vcpu->arch.apic;
diff --git a/arch/x86/kvm/lapic.h b/arch/x86/kvm/lapic.h
index 99374164398f..b8e165409ada 100644
--- a/arch/x86/kvm/lapic.h
+++ b/arch/x86/kvm/lapic.h
@@ -90,6 +90,7 @@ struct kvm_timer {
 	u32 timer_advance_ns;
 	atomic_t pending;			/* accumulated triggered timers */
 	bool hv_timer_in_use;
+	bool parked;				/* on the hrtimer while the plane is suspended */
 };
 
 struct kvm_lapic {
@@ -293,6 +294,8 @@ bool kvm_intr_is_single_vcpu(struct kvm_plane *plane, struct kvm_lapic_irq *irq,
 			     struct kvm_vcpu **dest_vcpu);
 void kvm_lapic_switch_to_sw_timer(struct kvm_vcpu *vcpu);
 void kvm_lapic_switch_to_hv_timer(struct kvm_vcpu *vcpu);
+void kvm_lapic_park_timer(struct kvm_vcpu *vcpu);
+void kvm_lapic_unpark_timer(struct kvm_vcpu *vcpu);
 void kvm_lapic_expired_hv_timer(struct kvm_vcpu *vcpu);
 bool kvm_lapic_hv_timer_in_use(struct kvm_vcpu *vcpu);
 void kvm_lapic_restart_hv_timer(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2046dd0d27c1..0933291298e0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8137,6 +8137,103 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
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
+	/*
+	 * A higher plane preempting a lower one is VTL semantics: without
+	 * KVM_HYPERV_HCALL_VTL_CALLS nothing consumes the event (no forced
+	 * entry, no VTL interrupt exit), so don't report one.
+	 */
+	if (!kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_CALLS))
+		return NULL;
+
+	for (i = vcpu->plane_level + 1; i < KVM_MAX_PLANES; i++) {
+		higher = vcpu->common->vcpus[i];
+		if (!higher)
+			continue;
+#ifdef CONFIG_KVM_HYPERV
+		/*
+		 * With in-kernel switching, an event on a plane the forced
+		 * entry would refuse (never run, user-held, parked on a
+		 * foreign completion) has no consumer until userspace
+		 * starts the plane; reporting it would wake a halted lower
+		 * VTL into an endless hlt/wake loop.  With userspace
+		 * switching the event is consumable via the interrupt exit,
+		 * so it does count.
+		 */
+		if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_SWITCH) &&
+		    kvm_hv_vtl_entry_blocked(higher))
+			continue;
+#endif
+		/*
+		 * Forced entry is edge-triggered on the posting of an
+		 * event, not level-triggered on the target's IRR, matching
+		 * the reference host's apic_pending_vtls bitmap: one entry
+		 * attempt per posted interrupt, via the hv_apic_event_pending
+		 * marker __apic_accept_irq sets.  A vector that stays
+		 * latched after a refused attempt (no VP assist page yet)
+		 * or that was masked by the plane's TPR waits for the next
+		 * cooperative entry or the next posted event; scanning the
+		 * IRR here instead would replay it the moment the assist
+		 * page is re-enabled.  A pending synthetic-timer request
+		 * counts as well: it can only be processed (and its
+		 * interrupt delivered) once the higher plane runs, so it
+		 * would otherwise never fire while the plane is suspended.
+		 * So does a LAPIC timer that has fired but not been
+		 * injected, tested with the same gate as the injection (an
+		 * expiry latched under a masked LVTT is never injected).
+		 */
+		if (READ_ONCE(higher->arch.hv_apic_event_pending) ||
+		    kvm_cpu_has_extint(higher) ||
+		    kvm_test_request(KVM_REQ_HV_STIMER, higher) ||
+		    kvm_cpu_has_pending_timer(higher))
+			return higher;
+	}
+	return NULL;
+}
+
+#ifdef CONFIG_KVM_HYPERV
+/*
+ * With userspace owning VTL transitions (KVM_HYPERV_HCALL_VTL_CALLS
+ * without KVM_HYPERV_HCALL_VTL_SWITCH), report a pending higher-plane
+ * event as an exit so userspace can enter the higher VTL.  Returns true
+ * when the exit was prepared.
+ */
+static bool kvm_hv_vtl_interrupt_exit(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu *higher;
+
+	if (!kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_CALLS) ||
+	    kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_SWITCH))
+		return false;
+
+	higher = kvm_higher_plane_with_event(vcpu);
+	if (!higher)
+		return false;
+
+	/*
+	 * Single-shot: if userspace refuses the entry (e.g. the target VTL
+	 * has no VP assist page yet), the event waits in the target's IRR
+	 * for a cooperative entry rather than re-triggering an exit storm.
+	 */
+	WRITE_ONCE(higher->arch.hv_apic_event_pending, false);
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
@@ -8628,12 +8725,37 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
 	}
 
+#ifdef CONFIG_KVM_HYPERV
+	if (kvm_hv_vtl_interrupt_exit(vcpu)) {
+		r = 0;
+		goto out;
+	}
+
+	if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_SWITCH)) {
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
 		goto out;
 	}
 
+	/*
+	 * This plane is running and about to evaluate its events: its
+	 * pended-while-suspended marker is consumed.  The clear must come
+	 * after the VTL-exit and plane-reschedule bail-outs above: a run
+	 * aborted there never evaluates the pended event, and nothing
+	 * re-arms the marker for a TPR-masked vector.
+	 */
+	WRITE_ONCE(vcpu->arch.hv_apic_event_pending, false);
+
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
 	    kvm_xen_has_interrupt(vcpu)) {
 		++vcpu->stat.req_event;
@@ -8973,7 +9095,8 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_has_events);
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_running(vcpu) || vcpu->arch.pv.pv_unhalted ||
-	       kvm_vcpu_has_events(vcpu);
+	       kvm_vcpu_has_events(vcpu) ||
+	       kvm_higher_plane_with_event(vcpu);
 }
 
 /* Called within kvm->srcu read side.  */
@@ -9068,6 +9191,17 @@ static int vcpu_run(struct kvm_vcpu *vcpu)
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
@@ -9312,6 +9446,8 @@ static int __kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, bool held)
 	kvm_load_guest_fpu(vcpu);
 
 	kvm_vcpu_srcu_read_lock(vcpu);
+	if (vcpu->plane_level)
+		kvm_lapic_unpark_timer(vcpu);
 
 	/*
 	 * Userspace holds plane 0 and no plane is runnable: return to it
@@ -9438,6 +9574,16 @@ static int __kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, bool held)
 	post_kvm_run_save(vcpu);
 	kvm_vcpu_srcu_read_unlock(vcpu);
 
+	/*
+	 * A non-zero plane may stay suspended indefinitely after this run
+	 * ends, and its hv timer only counts in VMX non-root mode.  Hand
+	 * the lapic timer to the hrtimer so it keeps firing while the
+	 * plane is parked; firing is what forces re-entry into the plane.
+	 * The timer goes back to the hv timer when the plane next runs.
+	 */
+	if (vcpu->plane_level)
+		kvm_lapic_park_timer(vcpu);
+
 	kvm_sigset_deactivate(vcpu);
 	vcpu_put(vcpu);
 	return r;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index d63076e53b8e..694409459cb8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -99,6 +99,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_SYNIC          1
 #define KVM_EXIT_HYPERV_HCALL          2
 #define KVM_EXIT_HYPERV_SYNDBG         3
+#define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
 	__u32 type;
 	__u32 plane;
 	union {
-- 
2.50.1

