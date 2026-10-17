Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E084908BD;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=mUKQerX/4HHfn2Y3F4oIPlMl9C2y7kfGarCS01RCp5sRlJIDOx35KYf7RA7yrP3MRCa52J0Oad3DF0Mx2Tyr3MJmL05uXEXTMHpLpXA+alSnjC0+RTlix78U52xpQ6B3DH+MFhbk/FErhWKLkw7MLq6GysRTPqxC0Adv8Xkhcss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=e4NVwWxSygRZVzQpMQXwy7eP31A7NwBkmnOaqFmpKWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBSm8p+KzfV8ZQKCk3x3nEFPPNPOfBnrTV4/N8NYwJMbeoaktvZFCo29Ow0Lc3vR6zx0H25t8AaFK8YAtVfKuVJtezAln2wAeuUF5g49J/nFe0EoUq0M1/65Pgby7PftCYBxV+xArBovYwwx80X+pb5RPKt5YuCxoE8NH150JFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hkwAhEUr; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hkwAhEUr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=QtFNYlu2JpzTLIvleMoSefldT0KV8NO6x0YOGWgR15k=; b=hkwAhEUr2rO3JnT+V7xHmJ/7QH
	vBy49GRMcYFDu6g1CrSWYuG+IjnOCSh/JjUkiJ6vVv9ak+KqwGFAmu34AuhUcLPlIoCBIkyLL4Nvl
	L9zLjkCHEZnaeBf9D1LnFrm2sK/387dB8fMgi0iNSMMRm53hxPNaS+OEJkRbV9cJAVHEKXv+ktitF
	vrfL29QWoY1pgao8A1V4DvYRdNZ02dEidlYq7A2uhxsBy9Zrd8KUU86k8mGyQla/vJ+FkJftPnyYq
	l4j+aF/261yo6UEG/UEUWQq3ygc6RwhgDJR/HrZeFf/U75RwX1CH95VfBcZbmuQ/HEsMsL38Rj0jZ
	BRZkrBHg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVDW-0Gov;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Yni-3esr;
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
Subject: [RFC PATCH 42/55] KVM: x86: Gate forced VTL entry on interrupt deliverability
Date: Sat, 17 Oct 2026 13:24:48 +0100
Message-ID: <20261017122501.610248-43-dwmw2@infradead.org>
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

A fixed vector posted to a higher plane forces a VTL entry even when
the higher VTL's TPR masks it, so the secure kernel is entered with
reason INTERRUPT and nothing to deliver.  The TLFS (15.9, "VTL
Interrupt Management") holds such an interrupt pending without
switching: only a deliverable interrupt preempts the lower VTL.

Gate the forced-entry evaluation on the higher plane's APIC reporting
a deliverable vector under its PPR.  A masked vector keeps its posted
marker instead of consuming the single entry attempt, so the entry
fires if a later VTL round trip leaves the vector deliverable; the
higher plane still consumes its own marker when it runs.  Each marker
is consumed only by its own approved clause, in both the userspace
exit and the in-kernel refusal paths: an exit triggered by extint, a
stimer or the LAPIC timer while the posted vector is still masked
leaves the APIC marker armed.

NMIs move to a marker of their own, hv_nmi_event_pending, and keep
forcing entry unconditionally: the NMI is folded back to plane 0 at
acceptance, so the higher plane's APIC carries nothing the PPR gate
could see.  The marker is armed wherever NMI state is posted to a
non-zero plane (kvm_inject_nmi() and the vCPU-events ioctl, which is
allowlisted on plane fds), and the level-triggered NMI state
(KVM_REQ_NMI, nmi_queued, nmi_pending) does not feed the gate: a
posting earns exactly one wakeup, like the APIC event path, instead
of keeping the gate permanently true for a parked higher plane.

The in-kernel switch consumes the markers on a refused entry attempt
too.  The only refusal left on that path is a failing VTL-control
write (blocked planes are filtered in kvm_higher_plane_with_event()),
which stays failed until an overlay or memory-attribute change; the
event remains latched in the plane's own pending state for its next
entry, rather than repeating the failing guest write on every exit of
the lower plane and keeping the vCPU from ever blocking.

Matches the deliverability gating of the reference VSM
implementation (its kvm_plane_has_interrupt); the production Nitro
Hypervisor remains PPR-blind, and the conformance suite's TPR-masked
test probes for either behaviour.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h |  21 +++++--
 arch/x86/kvm/lapic.c            |   2 +-
 arch/x86/kvm/x86.c              | 104 ++++++++++++++++++++++++--------
 3 files changed, 96 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6d864aa71b5b..6d3bae46ecab 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -861,14 +861,25 @@ void kvm_arch_vcpu_common_destroy(struct kvm_vcpu_common *common);
 
 struct kvm_vcpu_arch {
 	/*
-	 * Hyper-V VSM: an APIC event (fixed vector or NMI) was delivered to
-	 * this plane while it was suspended.  Set at delivery, cleared when
-	 * the plane next runs; a lower plane's run loop uses it to force a
-	 * VTL entry even when the vector is currently masked by this
-	 * plane's TPR (matching the reference host's apic_pending_vtls).
+	 * Hyper-V VSM: a fixed APIC vector was delivered to this plane
+	 * while it was suspended.  Set at delivery, cleared when the plane
+	 * next runs; a lower plane's run loop uses it to force a VTL entry
+	 * once the vector is deliverable under this plane's PPR (TLFS 15.9:
+	 * an interrupt the higher VTL's priority masks is held pending and
+	 * the VTL does not switch).  While masked, the marker is held, so
+	 * the entry fires when a VTL round trip leaves the vector
+	 * deliverable.
 	 */
 	bool hv_apic_event_pending;
 
+	/*
+	 * Hyper-V VSM: an NMI was aimed at this (higher) plane.  Forces a
+	 * VTL entry unconditionally: the NMI itself is folded back to
+	 * plane 0 (reference host behaviour), so the higher plane's APIC
+	 * carries no trace of it and the PPR gate above cannot apply.
+	 */
+	bool hv_nmi_event_pending;
+
 	/*
 	 * rip and regs accesses must go through
 	 * kvm_{register,rip}_{read,write} functions.
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 32cace3c89f4..03894f302985 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1486,7 +1486,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 			struct kvm_vcpu *twin;
 			int p;
 
-			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+			WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, true);
 			if (vcpu->common->vcpus[0])
 				kvm_inject_nmi(vcpu->common->vcpus[0]);
 			for (p = 0; p < vcpu->plane_level; p++) {
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d82b457e6714..89203909db36 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1071,6 +1071,13 @@ void kvm_inject_nmi(struct kvm_vcpu *vcpu)
 {
 	atomic_inc(&vcpu->arch.nmi_queued);
 	kvm_make_request(KVM_REQ_NMI, vcpu);
+	/*
+	 * NMI state posted to a suspended higher plane earns one entry
+	 * attempt through the single-shot marker, like the APIC event
+	 * path; the queued NMI itself is delivered when the plane runs.
+	 */
+	if (vcpu->plane_level)
+		WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, true);
 }
 
 void kvm_queue_exception_e(struct kvm_vcpu *vcpu, unsigned nr, u32 error_code)
@@ -5809,8 +5816,13 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 	if (events->flags & KVM_VCPUEVENT_VALID_NMI_PENDING) {
 		vcpu->arch.nmi_pending = 0;
 		atomic_set(&vcpu->arch.nmi_queued, events->nmi.pending);
-		if (events->nmi.pending)
+		if (events->nmi.pending) {
 			kvm_make_request(KVM_REQ_NMI, vcpu);
+			/* One entry attempt for a parked higher plane. */
+			if (vcpu->plane_level)
+				WRITE_ONCE(vcpu->arch.hv_nmi_event_pending,
+					   true);
+		}
 	}
 	kvm_x86_call(set_nmi_mask)(vcpu, events->nmi.masked);
 
@@ -11286,25 +11298,36 @@ static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
 #endif
 		/*
 		 * Forced entry is edge-triggered on the posting of an
-		 * event, not level-triggered on the target's IRR, matching
-		 * the reference host's apic_pending_vtls bitmap: one entry
-		 * attempt per posted interrupt, via the hv_apic_event_pending
-		 * marker __apic_accept_irq sets.  A vector that stays
+		 * event, not level-triggered on the target's IRR: one
+		 * entry attempt per posted interrupt, via the
+		 * hv_apic_event_pending marker __apic_accept_irq sets.
+		 * The attempt is gated on deliverability (TLFS 15.9: an
+		 * interrupt the higher VTL's priority mask blocks is held
+		 * pending and the VTL does not switch).  A masked vector
+		 * holds its marker, so the entry fires if a VTL round
+		 * trip leaves the vector deliverable; the plane consumes
+		 * its own marker when it runs.  A vector that stays
 		 * latched after a refused attempt (no VP assist page yet)
-		 * or that was masked by the plane's TPR waits for the next
-		 * cooperative entry or the next posted event; scanning the
-		 * IRR here instead would replay it the moment the assist
-		 * page is re-enabled.  A pending synthetic-timer request
-		 * counts as well: it can only be processed (and its
-		 * interrupt delivered) once the higher plane runs, so it
-		 * would otherwise never fire while the plane is suspended.
+		 * waits for the next cooperative entry or the next posted
+		 * event; scanning the IRR here instead would replay it
+		 * the moment the assist page is re-enabled.  NMIs force
+		 * entry ungated through their own single-shot marker, set
+		 * wherever NMI state is posted to a higher plane (the
+		 * higher APIC carries nothing to gate on; the NMI itself
+		 * is folded back to plane 0 on the APIC path).  A pending
+		 * synthetic-timer request counts as well: it can only be
+		 * processed (and its interrupt delivered) once the higher
+		 * plane runs, so it would otherwise never fire while the
+		 * plane is suspended.
+		 *
+		 * The reference host forces entry even for a TPR-masked
+		 * vector; the suite's TPR test probes for both behaviours.
 		 */
-		if (READ_ONCE(higher->arch.hv_apic_event_pending) ||
+		if ((READ_ONCE(higher->arch.hv_apic_event_pending) &&
+		     higher->arch.apic && kvm_apic_has_interrupt(higher) >= 0) ||
+		    READ_ONCE(higher->arch.hv_nmi_event_pending) ||
 		    kvm_cpu_has_extint(higher) ||
 		    kvm_test_request(KVM_REQ_HV_STIMER, higher) ||
-		    kvm_test_request(KVM_REQ_NMI, higher) ||
-		    atomic_read(&higher->arch.nmi_queued) ||
-		    higher->arch.nmi_pending ||
 		    (higher->arch.apic &&
 		     atomic_read(&higher->arch.apic->lapic_timer.pending)))
 			return higher;
@@ -11333,9 +11356,17 @@ static bool kvm_hv_vtl_interrupt_exit(struct kvm_vcpu *vcpu)
 	 * Single-shot, as in the reference host: if userspace refuses
 	 * the entry (e.g. the target VTL has no VP assist page yet),
 	 * the event waits in the target's IRR for a cooperative entry
-	 * rather than re-triggering an exit storm.
-	 */
-	WRITE_ONCE(higher->arch.hv_apic_event_pending, false);
+	 * rather than re-triggering an exit storm.  Each marker is
+	 * consumed only by its own approved attempt: when this exit was
+	 * triggered by another clause (extint, stimer, timer) while the
+	 * posted vector is still masked, the APIC marker stays armed so
+	 * a VTL round trip that unmasks the vector can retrigger the
+	 * entry.
+	 */
+	if (READ_ONCE(higher->arch.hv_apic_event_pending) &&
+	    higher->arch.apic && kvm_apic_has_interrupt(higher) >= 0)
+		WRITE_ONCE(higher->arch.hv_apic_event_pending, false);
+	WRITE_ONCE(higher->arch.hv_nmi_event_pending, false);
 
 	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
 	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_VTL_INTERRUPT;
@@ -11874,9 +11905,32 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (READ_ONCE(to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch)) {
 		struct kvm_vcpu *higher = kvm_higher_plane_with_event(vcpu);
 
-		if (higher && kvm_hv_vtl_interrupt_entry(vcpu, higher)) {
-			kvm_make_request(KVM_REQ_EVENT, higher);
-			kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+		if (higher) {
+			if (kvm_hv_vtl_interrupt_entry(vcpu, higher)) {
+				kvm_make_request(KVM_REQ_EVENT, higher);
+				kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+			} else {
+				/*
+				 * Single-shot in in-kernel mode too: the
+				 * refusal (a failing control-area write;
+				 * blocked planes are filtered in
+				 * kvm_higher_plane_with_event()) cannot
+				 * succeed until external action, so consume
+				 * the markers rather than repeating the
+				 * failing guest write on every exit.  The
+				 * event stays latched in the plane's own
+				 * pending state for its next entry.  A
+				 * still-masked vector keeps its marker; only
+				 * its own approved attempt consumes it.
+				 */
+				if (READ_ONCE(higher->arch.hv_apic_event_pending) &&
+				    higher->arch.apic &&
+				    kvm_apic_has_interrupt(higher) >= 0)
+					WRITE_ONCE(higher->arch.hv_apic_event_pending,
+						   false);
+				WRITE_ONCE(higher->arch.hv_nmi_event_pending,
+					   false);
+			}
 		}
 	}
 #endif
@@ -11889,12 +11943,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
 	/*
 	 * This plane is running and about to evaluate its events: its
-	 * pended-while-suspended marker is consumed.  The clear must come
+	 * pended-while-suspended markers are consumed.  The clear must come
 	 * after the VTL-exit and plane-reschedule bail-outs above: a run
-	 * aborted there never evaluates the pended event, and nothing
-	 * re-arms the marker for a TPR-masked vector.
+	 * aborted there never evaluates the pended event.
 	 */
 	WRITE_ONCE(vcpu->arch.hv_apic_event_pending, false);
+	WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, false);
 
 	if (kvm_check_request(KVM_REQ_EVENT, vcpu) || req_int_win ||
 	    kvm_xen_has_interrupt(vcpu)) {
-- 
2.50.1

