Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A838481FCE;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=dfEC1FBQHlnwMJx1ag+QiVK9uuUBF1OpiysgkmEtLx+wrCEdCVdiLqK5+K1uAPeurI5db0fBDKN8pHnSMOuNJJPOyhAPWFl1Ms4pT5KVOv2HCVuoTOBa7SzgxF1O4Pq3Ffmm3yLUceb0vbH6PgSljWODKHH4l3qh5qiFjbtsLjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=sBON1RG9BsSU3KWfkh6w0X1UHH5oGf4hgfSVHoseM1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GyU5YSEOcQmPyZ+Qb/e0PS+H72ELv6/Y23xm2LK2QfoTdsGmN7f5Vpp9MvJQ+zFLZypeNJ01RjEyuoSYp3tf3rzuNygWsoT+la7ZKl4Bp8Ak2w1/QnYgoemWBPnIWPt9IHpB9G5+X+4RM5Walqrq4riOjjIckuqYRDClw0QVmFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=r9WV1PXX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="r9WV1PXX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=1M5ipK6aKfOauxJ0t57kI5nmTe6Da3BLA0LA33BSfZQ=; b=r9WV1PXXckIqMsukAyGwggUZdm
	Y/w0xKJNly2vQsTmWQwFMI6xxdo/Ziou4XkIhfoA+JWyfh8vo0KgxMlTnXmKdS3K+jidWbIL6g2Nq
	QSIA+bZT/QMVI+jz2qlfii7ARBCCjJ2FKiFWeXGP9v/D3DB84i2JtSgZoz1V8ws21p8/Y9jyY2FhF
	pIPy8bP3/h03vlBOqR9Kf5I+JN6rewWPtTDeCXNEK26NA9+dKL43L/YHaCWdxLbv9Ys+7hxhqG9Fm
	yr4k7vMmurfZyw2MTdao8aGT0fQzV2Nzow+V21a1HuvELURIL6nfZFZqeEOd30Y6gq/HDVYbdeX95
	uoIznpKA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVCX-1CZA;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ymb-0Mcg;
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
Subject: [RFC PATCH 26/55] WIP: KVM: x86: VSM event-delivery parity fixes from Windows boot triage
Date: Sat, 17 Oct 2026 13:24:32 +0100
Message-ID: <20261017122501.610248-27-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

All derived from the reference host's behaviour, and verified against
its VSM unit-test suite (still green) and Windows Server 2025 VBS
boot:

- Forced entry into a higher plane is edge-triggered, as on the
  reference host, which attempts one forced entry per posted
  interrupt. Delivery of a fixed vector or NMI to a suspended higher
  plane sets hv_apic_event_pending; the evaluation triggers on that
  marker and the consumable requests (stimer, NMI, APIC timer), not
  on a scan of the plane's IRR — a vector still latched after a
  refused entry waits for the target's next cooperative entry or next
  posted event instead of retrying on every run of the lower plane.
  The marker is cleared only by a run that actually reaches event
  evaluation; a run aborted by the VTL-exit or KVM_REQ_PLANE_RESCHED
  bail-outs leaves it set, since delivery never re-arms it. A vector
  masked by the higher VTL's TPR still forces exactly one entry.
- One exception to single-shot: a plane that suspends (VtlReturn or
  the run-state ioctl) with a vector still latched in its IRR re-arms
  its marker, via kvm_arch_vcpu_plane_stopped() from
  kvm_vcpu_set_plane_stopped(). Evaluating does not imply delivering:
  Windows hibernation posts vector 0xE0 to a twin mid-run with IF
  clear, the run consumes the marker without injecting, and the
  suspended twin's vector is stranded — VTL0 freezes all processors,
  spins on the secure kernel and wedges the VM at 100% host CPU. A
  re-armed marker cannot storm: the deliverability gate still applies,
  and a plane that reached suspension has run before, so userspace can
  enter it again.
- NMIs aimed at a higher plane fold back to plane 0 for delivery
  after the VTL returns; the higher plane only sees the forced entry.
  A real NMI inside VTL1 bugchecks the secure kernel (0x18B).
- VTL1 exempted from the reserved-bits check on Hyper-V vAPIC MSR
  writes: the secure kernel writes HV_X64_MSR_EOI with stale upper
  bits, and the reference host truncates for VTL1.
- KVM_REQ_HV_TLB_FLUSH made per-plane: a shared request could be
  consumed by the running twin, leaving the targeted plane's TLB
  stale.
- Lower-twin kicks on the stimer retry (vcpu_kick=false) paths.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h | 12 ++++-
 arch/x86/kvm/hyperv.c           |  3 +-
 arch/x86/kvm/lapic.c            | 39 ++++++++++++++-
 arch/x86/kvm/x86.c              | 89 +++++++++++++++++++++++++++++----
 include/linux/kvm_host.h        |  1 +
 virt/kvm/kvm_main.c             |  5 ++
 6 files changed, 135 insertions(+), 14 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c54f47c52a59..834597791fe1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -127,7 +127,8 @@
 #define KVM_REQ_MMU_FREE_OBSOLETE_ROOTS \
 	KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_HV_TLB_FLUSH \
-	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
+			   KVM_REQUEST_PER_PLANE)
 #define KVM_REQ_UPDATE_PROTECTED_GUEST_STATE \
 	KVM_ARCH_REQ_FLAGS(34, KVM_REQUEST_WAIT | KVM_REQUEST_PER_PLANE)
 
@@ -854,6 +855,15 @@ int kvm_arch_vcpu_common_init(struct kvm_vcpu_common *common);
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
index d4e44ae3f6e8..0d239f054856 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -605,8 +605,9 @@ static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 	 * A pending stimer on a suspended higher plane is only processed
 	 * once that plane runs; kick the lower twins so the running one
 	 * re-evaluates pending higher-plane events and forces entry.
+	 * This applies to retry paths too (vcpu_kick == false).
 	 */
-	if (vcpu_kick && vcpu->plane_level) {
+	if (vcpu->plane_level) {
 		struct kvm_vcpu *twin;
 		int p;
 
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index f89156c26972..32cace3c89f4 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1448,6 +1448,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 			struct kvm_vcpu *twin;
 			int p;
 
+			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
 			for (p = 0; p < vcpu->plane_level; p++) {
 				twin = vcpu->common->vcpus[p];
 				if (twin) {
@@ -1474,8 +1475,31 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 
 	case APIC_DM_NMI:
 		result = 1;
-		kvm_inject_nmi(vcpu);
-		kvm_vcpu_kick(vcpu);
+		/*
+		 * An NMI aimed at a higher plane forces entry into that
+		 * plane (reason INTERRUPT, below) but the NMI itself is
+		 * folded back to plane 0: the reference host never delivers
+		 * an NMI inside a higher VTL, it re-queues it to VTL0's
+		 * context for delivery after the VTL returns.
+		 */
+		if (vcpu->plane_level) {
+			struct kvm_vcpu *twin;
+			int p;
+
+			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+			if (vcpu->common->vcpus[0])
+				kvm_inject_nmi(vcpu->common->vcpus[0]);
+			for (p = 0; p < vcpu->plane_level; p++) {
+				twin = vcpu->common->vcpus[p];
+				if (twin) {
+					kvm_make_request(KVM_REQ_UNBLOCK, twin);
+					kvm_vcpu_kick(twin);
+				}
+			}
+		} else {
+			kvm_inject_nmi(vcpu);
+			kvm_vcpu_kick(vcpu);
+		}
 		break;
 
 	case APIC_DM_INIT:
@@ -3535,6 +3559,17 @@ int kvm_hv_vapic_msr_write(struct kvm_vcpu *vcpu, u32 reg, u64 data)
 	if (!lapic_in_kernel(vcpu))
 		return 1;
 
+	/*
+	 * Bits 63:32 are reserved in non-ICR registers, but the Windows
+	 * secure kernel leaves stale data in the high bits when writing
+	 * the Hyper-V vAPIC MSRs from a higher VTL.  The reference host
+	 * exempts those writes and truncates; a #GP here is a VTL1
+	 * bugcheck.  The exemption covers only this PV path: a native
+	 * x2APIC WRMSR takes the architectural #GP whatever the plane.
+	 */
+	if (vcpu->plane_level && reg != APIC_ICR)
+		data = (u32)data;
+
 	return kvm_lapic_msr_write(vcpu->arch.apic, reg, data);
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 10e14ab3e2ca..3e2465b2fa2b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11229,18 +11229,26 @@ static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
 			continue;
 #endif
 		/*
-		 * Test raw pending-ness, not injectability:
-		 * kvm_cpu_has_injectable_intr() reports false on an
-		 * APICv-active vCPU, and a suspended plane may carry a
-		 * stale apicv_active until it next runs.  A pending
-		 * synthetic-timer request counts as well: it can only be
-		 * processed (and its interrupt delivered) once the higher
-		 * plane runs, so it would otherwise never fire while the
-		 * plane is suspended.
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
 		 */
-		if (kvm_cpu_has_extint(higher) ||
-		    kvm_apic_has_interrupt(higher) != -1 ||
+		if (READ_ONCE(higher->arch.hv_apic_event_pending) ||
+		    kvm_cpu_has_extint(higher) ||
 		    kvm_test_request(KVM_REQ_HV_STIMER, higher) ||
+		    kvm_test_request(KVM_REQ_NMI, higher) ||
+		    atomic_read(&higher->arch.nmi_queued) ||
+		    higher->arch.nmi_pending ||
 		    (higher->arch.apic &&
 		     atomic_read(&higher->arch.apic->lapic_timer.pending)))
 			return higher;
@@ -11265,6 +11273,14 @@ static bool kvm_hv_vtl_interrupt_exit(struct kvm_vcpu *vcpu)
 	if (!higher)
 		return false;
 
+	/*
+	 * Single-shot, as in the reference host: if userspace refuses
+	 * the entry (e.g. the target VTL has no VP assist page yet),
+	 * the event waits in the target's IRR for a cooperative entry
+	 * rather than re-triggering an exit storm.
+	 */
+	WRITE_ONCE(higher->arch.hv_apic_event_pending, false);
+
 	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
 	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_VTL_INTERRUPT;
 	vcpu->run->hyperv.plane = higher->plane_level;
@@ -11286,6 +11302,50 @@ static inline bool kvm_check_plane0_events(struct kvm_vcpu *vcpu)
 		vcpu_plane0->arch.smi_pending;
 }
 
+/*
+ * A higher plane that suspends with an interrupt still latched in its IRR
+ * must keep its hv_apic_event_pending marker armed.  The running plane
+ * consumes the marker in vcpu_enter_guest() before evaluating events, but
+ * evaluating does not imply delivering: a plane that keeps IF clear until
+ * it suspends (e.g. the secure kernel finishing a VTL round trip), or
+ * whose PPR masks the vector for the whole run, parks the vector in its
+ * IRR with the marker already consumed.  Nothing re-posts the interrupt,
+ * so the deliverability-gated forced entry in kvm_higher_plane_with_event()
+ * would never fire again and the plane would never see the vector; a lower
+ * VTL spinning on the suspended VTL's response then wedges the VM.
+ *
+ * Re-arming cannot re-create the refused-entry exit storm the single-shot
+ * marker guards against: the forced-entry gate still requires the vector
+ * to be deliverable by the plane's own priority state.
+ */
+void kvm_arch_vcpu_plane_stopped(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * The hv_apic_event_pending marker drives the Hyper-V VSM forced
+	 * entry (see kvm_higher_plane_with_event()).  This hook also runs
+	 * from __sev_snp_run_vmpl() for guest-architectural VMPL switches:
+	 * without the Hyper-V gate, every SNP VMPL switch away from a
+	 * plane with a latched IRR would feed VSM-flavoured wakeups and
+	 * exits to a VM that has no VSM at all.
+	 */
+	if (!vcpu->arch.hyperv_enabled)
+		return;
+
+	/*
+	 * A plane that reached suspension normally has run before; the
+	 * exception is userspace parking a never-run plane it had already
+	 * injected an interrupt into.  Forced entry into a never-run
+	 * plane is always refused, so don't arm an attempt that cannot
+	 * succeed; the IRR is evaluated on the plane's first real entry.
+	 */
+	if (vcpu->arch.last_vmentry_cpu == -1)
+		return;
+
+	if (vcpu->plane_level && lapic_in_kernel(vcpu) &&
+	    kvm_lapic_find_highest_irr(vcpu) != -1)
+		WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+}
+
 static void process_nmi(struct kvm_vcpu *vcpu)
 {
 	unsigned int limit;
@@ -11771,6 +11831,15 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index cb8c4798df12..30dbc28885fb 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -493,6 +493,7 @@ static inline void kvm_vcpu_cancel_vtl_fpu_carry(struct kvm_vcpu_common *common)
 
 void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu);
 void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu);
+void kvm_arch_vcpu_plane_stopped(struct kvm_vcpu *vcpu);
 struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu);
 
 static inline bool kvm_vcpu_wants_to_run(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5856672bbf6d..fac30b8b6518 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5347,9 +5347,14 @@ void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_set_plane_runnable);
 
+void __weak kvm_arch_vcpu_plane_stopped(struct kvm_vcpu *vcpu)
+{
+}
+
 void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu)
 {
 	vcpu->plane_state = STOPPED;
+	kvm_arch_vcpu_plane_stopped(vcpu);
 	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_set_plane_stopped);
-- 
2.50.1

