Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=d0a4sh53tvdaCPe/hYrv4OJFL5oCKHnIhUDsJ8as+75L/kZonnYEvwALVhup/dg8yz21
	 HdTBd8q/2kUSIp+PJYHS8UqatWcBfk+M4eOA5HSGwmSrn7ZxEY7XIpWXTfVq9nvHRowEq
	 Pm3nAAt0qPRlLGQKrMrrahhivcWwOXQT2TvcZiP3DDcrrTVBTKGDmQYn3YFhSvXiP4aAa
	 LEqoHAhPDKBa8gRSv7z3l5mU5JJ9DPn5UzkbKaaHUri1ES/ep3lpRiK08k0XM60jPAhKU
	 IsxzjERfZxAfZE6+GuWNQwYUFsqUZEeC9xQLXqKb4IWgb2AQ5U80i2Kf+HsUqVsielw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=JuFCu/x6jJ8+dtQueV7h4jWX81lw30gbJTBeku4qRe0=;
	b=QjZtmWF75RXgjeR1giaZUDMPB9bEQox3I8z8Pq90VjxLZhuzuySMpd2XftUtruUbS/uw
	 xru37MfXhAgWif6iFbLBod+YFETDL1qzjtalONRw2yBYb+r5L3YXH7CdG3691SeMSnVPr
	 bYHrPKpvsv3Fm2n12AOuwDUGyfJJAQKDVrpUPsbnBcovwdAK+SFYmuRDUarm+TSbT8Mou
	 VAB8iDtwz/K/RHxihVZnVce3XBgGqsYmMTsLhNG0Mgg3OkXMnoFWQeF2OmaszqY69gmu7
	 yhIILAjzh78tsWsz0U9L62NEKrwKzZBWF9SNO4rYoFez2mxDSvdhyPDUeOdKBrD4zBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=K+FoDa2v;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1B606A884;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24C1B606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=K+FoDa2v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=JuFCu/x6jJ8+dtQueV7h4jWX81lw30gbJTBeku4qRe0=; b=K+FoDa2vWl9BLPMsAwln1EZqxL
	ZArkKJD4qDork+4x4SCAe7BzdnKMPmN/JYpA39lM0JqPUKdjMe97egK2ED2BkqbfYn+vZ/h4oyVAb
	HUZgeflLkzwG6pJ1MIO/I9OerPvrAqhID3DfaVkC5Ttf30PdXis5M3n/IzM2obnMWlq9wpwFgwv/E
	HXMpSM/PtOI31ypTF0D0CJj6b20kbcE3LZ0eztwYWLK/eMwXP/ya0OySkYv9aYZItbhyGraok7iCq
	GpzgYiLxXPpI7NfRVjfWqvB44NDcHlt7LJrtHSG8hu9ZWewCyzHd0SL/ZMpLyGHywvXxpbJjZkbDh
	1Q+pme9Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQs-1ot2;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Ltw-0qfk;
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
Subject: [RFC PATCH v2 21/31] KVM: x86: Gate and re-arm forced VTL entry on interrupt deliverability
Date: Fri, 13 Nov 2026 18:34:37 +0000
Message-ID: <20261113183448.84094-22-dwmw2@infradead.org>
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

A fixed vector posted to a higher plane forces a VTL entry even when
the higher VTL's TPR masks it, so the secure kernel is entered with
reason INTERRUPT and nothing to deliver. The TLFS (§15.9, "VTL
Interrupt Management") holds such an interrupt pending without
switching: only a *deliverable* interrupt preempts the lower VTL.

Gate forced entry on the higher plane's APIC reporting a deliverable
vector under its PPR. A masked vector keeps its posted marker instead
of consuming the single entry attempt, so the entry fires if a later
VTL round trip leaves the vector deliverable; the higher plane still
consumes its own marker when it runs. Each marker is consumed only by
its own clause, in both the userspace exit and the in-kernel refusal
paths, so an exit triggered by ExtINT, a stimer or the LAPIC timer
while the posted vector is still masked leaves the APIC marker armed.
The gate and the consumption share kvm_vtl_event_deliverable() and
kvm_vtl_event_consume(), so the two cannot drift apart.

NMIs get a marker of their own, hv_nmi_event_pending, and keep forcing
entry unconditionally; the NMI is folded back to plane 0 on
acceptance, so the higher plane's APIC has nothing the PPR gate could
see.

 - The marker is armed wherever NMI state is posted to a non-zero
   plane: the APIC fold and KVM_SET_VCPU_EVENTS on the plane's fd. No
   other path reaches a higher plane: KVM_NMI is not on the plane-fd
   allowlist, and sync_regs apply to plane 0, whose fd runs KVM_RUN.
 - It is also what breaks the HLT of a halted selected plane that the
   fold targets (kvm_arch_vcpu_runnable()).
 - The level-triggered NMI state (KVM_REQ_NMI, nmi_queued,
   nmi_pending) no longer feeds the gate. A posting earns exactly one
   wakeup, as on the APIC path, rather than holding the gate true for
   a parked higher plane.
 - KVM_SET_VCPU_EVENTS that retracts the plane's own NMI takes back the
   marker it earned. A marker left by an NMI folded to plane 0 stays,
   since that NMI is not the plane's. vCPU reset clears both markers.

The in-kernel switch consumes the markers on a refused entry attempt
too. The only refusal left on that path is a failing VTL-control write
(blocked planes are filtered in kvm_higher_plane_with_event()), which
stays failed until an overlay or memory-attribute change. The event
stays latched in the plane's own pending state for its next entry,
instead of repeating the failing guest write on every exit of the
lower plane and keeping the vCPU from ever blocking.

The hyperv_vsm conformance test for TPR-masked vectors accepts either
behaviour.

The marker is single-shot, and consuming it does not mean the vector
was delivered. Windows hibernation posts vector 0xE0 to a
VTL1 twin mid-run with IF clear: the run consumes the marker without
injecting, the twin suspends with the vector in its IRR, and nothing
posts it again. VTL0 freezes all processors, spins waiting on the
secure kernel, and wedges the VM at 100% host CPU. A migration loses the
marker the same way: KVM_SET_LAPIC restores the IRR without going
through __apic_accept_irq(), so a vector posted to a suspended VTL1
just before the save never forces an entry on the destination.

Add a kvm_arch_vcpu_plane_stopped() hook, called from
kvm_vcpu_set_plane_stopped() for both a VtlReturn and the run-state
ioctl, with an empty weak default. On x86 it re-arms
hv_apic_event_pending when a non-zero plane stops with a vector latched
in its IRR, and KVM_SET_LAPIC on a stopped non-zero plane does the
same, so a destination re-derives the marker whichever of the two it
restores last. A re-armed marker cannot storm: the deliverability gate
on forced entry still applies.

An NMI posted to the plane itself is lost the same way: a run with
NMIs blocked (inside an NMI handler, before IRET) consumes
hv_nmi_event_pending and leaves the NMI latched, and the lower VTL
waiting on the higher one wedges. The hook re-arms hv_nmi_event_pending
too when the plane stops with an NMI injected, pending, queued or
requested. The NMI clause is ungated, so this costs at most one forced
entry each time the plane is stopped.

Nothing is armed for a plane whose event cannot be consumed
(kvm_higher_plane_event_consumable()), which also keeps VMs without
KVM_HYPERV_HCALL_VTL_CALLS out of it; that matters because the hook also
runs when __sev_snp_run_vmpl() switches VMPLs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  22 +++-
 arch/x86/kvm/hyperv.c           |   6 +-
 arch/x86/kvm/lapic.c            |   2 +-
 arch/x86/kvm/x86.c              | 190 +++++++++++++++++++++++++++-----
 include/linux/kvm_host.h        |   1 +
 virt/kvm/kvm_main.c             |   5 +
 6 files changed, 190 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0fa3196fba36..eeafc303cb02 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -756,14 +756,26 @@ void kvm_arch_vcpu_common_destroy(struct kvm_vcpu_common *common);
 
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
+	 * plane 0 (see APIC_DM_NMI in __apic_accept_irq()), so the higher
+	 * plane's APIC carries no trace of it and the PPR gate above cannot
+	 * apply.
+	 */
+	bool hv_nmi_event_pending;
+
 	/*
 	 * rip and regs accesses must go through
 	 * kvm_{register,rip}_{read,write} functions.
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8a33127169fa..20b29798463e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -3291,8 +3291,10 @@ bool kvm_hv_vtl_interrupt_entry(struct kvm_vcpu *vcpu,
 	 * plane's vCPU: the write must pass that plane's own memory
 	 * attributes and memslot view, not the suspending plane's (which
 	 * typically has no access to the higher VTL's assist page).  On
-	 * failure leave both planes untouched; the event stays pending in
-	 * the target and the entry is retried.
+	 * failure leave both planes untouched.  The event stays latched in
+	 * the target's own pending state, but the caller consumes the
+	 * single-shot forced-entry markers, so no retry follows: the event
+	 * waits for the target's next entry or a newly posted event.
 	 */
 	assist = hv_vtl_assist_page_gpa(target);
 	if (assist) {
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index d33226c44488..b30b310a53b8 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1486,7 +1486,7 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 		if (vcpu->plane_level) {
 			struct kvm_vcpu *twin;
 
-			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+			WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, true);
 			twin = READ_ONCE(vcpu->common->vcpus[0]);
 			if (twin)
 				kvm_inject_nmi(twin);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c2c9b5a181b9..0d6c8adecb01 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2833,6 +2833,8 @@ static int kvm_vcpu_ioctl_get_lapic(struct kvm_vcpu *vcpu,
 	return kvm_apic_get_state(vcpu, s);
 }
 
+static void kvm_rearm_higher_plane_event(struct kvm_vcpu *vcpu);
+
 static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 				    struct kvm_lapic_state *s)
 {
@@ -2845,6 +2847,9 @@ static int kvm_vcpu_ioctl_set_lapic(struct kvm_vcpu *vcpu,
 	if (r)
 		return r;
 
+	if (vcpu->plane_level && vcpu->plane_state == STOPPED)
+		kvm_rearm_higher_plane_event(vcpu);
+
 	return 0;
 }
 
@@ -3220,10 +3225,27 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 
 	vcpu->arch.nmi_injected = events->nmi.injected;
 	if (events->flags & KVM_VCPUEVENT_VALID_NMI_PENDING) {
+		bool had_nmi = kvm_get_nr_pending_nmis(vcpu) ||
+			       atomic_read(&vcpu->arch.nmi_queued) ||
+			       kvm_test_request(KVM_REQ_NMI, vcpu);
+
 		vcpu->arch.nmi_pending = 0;
 		atomic_set(&vcpu->arch.nmi_queued, events->nmi.pending);
-		if (events->nmi.pending)
+		if (events->nmi.pending) {
 			kvm_make_request(KVM_REQ_NMI, vcpu);
+			/* One entry attempt for a parked higher plane. */
+			if (vcpu->plane_level)
+				WRITE_ONCE(vcpu->arch.hv_nmi_event_pending,
+					   true);
+		} else if (had_nmi) {
+			/*
+			 * A retracted NMI takes back the entry attempt it
+			 * earned.  Without an NMI of the plane's own, the
+			 * marker stands for one folded to plane 0 by the
+			 * APIC, which this ioctl does not touch.
+			 */
+			WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, false);
+		}
 	}
 	kvm_x86_call(set_nmi_mask)(vcpu, events->nmi.masked);
 
@@ -8319,6 +8341,35 @@ void kvm_kick_lower_twins(struct kvm_vcpu *vcpu)
 	__kvm_kick_lower_twins(vcpu);
 }
 
+/*
+ * The posted-interrupt clause of the forced-entry gate: the plane's APIC
+ * marker is armed and its APIC reports a vector deliverable under its own
+ * priority state.  kvm_higher_plane_with_event() fires on it and
+ * kvm_vtl_event_consume() clears the marker only when it holds, so the two
+ * must use this one test.
+ */
+static bool kvm_vtl_event_deliverable(struct kvm_vcpu *higher)
+{
+	return READ_ONCE(higher->arch.hv_apic_event_pending) &&
+	       higher->arch.apic && kvm_apic_has_interrupt(higher) >= 0;
+}
+
+#ifdef CONFIG_KVM_HYPERV
+/*
+ * Consume the single-shot markers for one forced-entry attempt.  Each
+ * marker is consumed only by its own clause: when the attempt was
+ * triggered by another one (ExtINT, a stimer, the LAPIC timer) while the
+ * posted vector is still masked, the APIC marker stays armed so a VTL
+ * round trip that unmasks the vector can retrigger the entry.
+ */
+static void kvm_vtl_event_consume(struct kvm_vcpu *higher)
+{
+	if (kvm_vtl_event_deliverable(higher))
+		WRITE_ONCE(higher->arch.hv_apic_event_pending, false);
+	WRITE_ONCE(higher->arch.hv_nmi_event_pending, false);
+}
+#endif
+
 /*
  * A pending interrupt for a higher plane preempts this one: the higher
  * VTL's interrupts take priority over lower-VTL execution (TLFS 15.2.4),
@@ -8340,28 +8391,39 @@ static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
 
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
-		 * So does a LAPIC timer that has fired but not been
-		 * injected, tested with the same gate as the injection (an
-		 * expiry latched under a masked LVTT is never injected).
+		 * waits for the next cooperative entry or the next posted
+		 * event; scanning the IRR here instead would replay it
+		 * the moment the assist page is re-enabled.  NMIs force
+		 * entry ungated through their own single-shot marker, set
+		 * wherever NMI state is posted to a higher plane: the APIC
+		 * path, which folds the NMI itself back to plane 0, and
+		 * KVM_SET_VCPU_EVENTS on the plane's own fd (the higher APIC
+		 * carries nothing to gate on).  A pending
+		 * synthetic-timer request counts as well: it can only be
+		 * processed (and its interrupt delivered) once the higher
+		 * plane runs, so it would otherwise never fire while the
+		 * plane is suspended.  So does a LAPIC timer that has fired
+		 * but not been injected, tested with the same gate as the
+		 * injection (an expiry latched under a masked LVTT is never
+		 * injected).
+		 *
+		 * Unlike this gate, the Nitro VSM implementation forces
+		 * entry even for a TPR-masked vector.
 		 */
-		if (READ_ONCE(higher->arch.hv_apic_event_pending) ||
+		if (kvm_vtl_event_deliverable(higher) ||
+		    READ_ONCE(higher->arch.hv_nmi_event_pending) ||
 		    kvm_cpu_has_extint(higher) ||
 		    kvm_test_request(KVM_REQ_HV_STIMER, higher) ||
-		    kvm_test_request(KVM_REQ_NMI, higher) ||
-		    atomic_read(&higher->arch.nmi_queued) ||
-		    higher->arch.nmi_pending ||
 		    kvm_cpu_has_pending_timer(higher))
 			return higher;
 	}
@@ -8392,7 +8454,7 @@ static bool kvm_hv_vtl_interrupt_exit(struct kvm_vcpu *vcpu)
 	 * has no VP assist page yet), the event waits in the target's IRR
 	 * for a cooperative entry rather than re-triggering an exit storm.
 	 */
-	WRITE_ONCE(higher->arch.hv_apic_event_pending, false);
+	kvm_vtl_event_consume(higher);
 
 	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
 	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_VTL_INTERRUPT;
@@ -8416,6 +8478,60 @@ static inline bool kvm_check_plane0_events(struct kvm_vcpu *vcpu)
 		vcpu_plane0->arch.smi_pending;
 }
 
+/*
+ * A stopped higher plane with an interrupt latched in its IRR must have
+ * its hv_apic_event_pending marker armed, or the posting-triggered forced
+ * entry in kvm_higher_plane_with_event() never fires for that vector.
+ * Two paths leave the marker unset:
+ *
+ *  - The running plane consumes the marker in vcpu_enter_guest() before
+ *    evaluating events, but evaluating does not imply delivering: a plane
+ *    that keeps IF clear until it suspends (e.g. the secure kernel
+ *    finishing a VTL round trip), or whose PPR masks the vector for the
+ *    whole run, parks the vector in its IRR with the marker consumed.
+ *  - KVM_SET_LAPIC restores the IRR without going through
+ *    __apic_accept_irq(), so a vector posted to a suspended plane before
+ *    a save reaches the migration destination with no marker.
+ *
+ * Either way nothing posts the interrupt again, and a lower VTL spinning
+ * on the suspended VTL's response wedges the VM.  Re-arming cannot
+ * re-create the refused-entry exit storm the single-shot marker guards
+ * against: the forced-entry gate still requires the vector to be
+ * deliverable by the plane's own priority state.  A plane whose event
+ * cannot be consumed (kvm_higher_plane_event_consumable()) needs no
+ * marker; it evaluates its IRR when it next runs.  That check also covers
+ * VMs without KVM_HYPERV_HCALL_VTL_CALLS, which matters because the
+ * stop hook runs from __sev_snp_run_vmpl() too: an SNP VMPL switch away
+ * from a plane with a latched IRR must not feed VSM-flavoured wakeups and
+ * exits to a VM that has no VSM at all.
+ */
+static void kvm_rearm_higher_plane_event(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->plane_level || !kvm_higher_plane_event_consumable(vcpu))
+		return;
+
+	if (lapic_in_kernel(vcpu) && kvm_lapic_find_highest_irr(vcpu) != -1)
+		WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+
+	/*
+	 * The same holds for an NMI posted to the plane itself
+	 * (KVM_SET_VCPU_EVENTS on its fd): a run with NMIs blocked (an NMI
+	 * handler that has not reached IRET) consumes the marker and leaves
+	 * the NMI latched.  The NMI clause of the gate is ungated, so each
+	 * re-arm costs one forced entry per suspension, and the plane runs
+	 * in each of them; no refused-entry storm can follow.
+	 */
+	if (vcpu->arch.nmi_injected || kvm_get_nr_pending_nmis(vcpu) ||
+	    atomic_read(&vcpu->arch.nmi_queued) ||
+	    kvm_test_request(KVM_REQ_NMI, vcpu))
+		WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, true);
+}
+
+void kvm_arch_vcpu_plane_stopped(struct kvm_vcpu *vcpu)
+{
+	kvm_rearm_higher_plane_event(vcpu);
+}
+
 static void process_nmi(struct kvm_vcpu *vcpu)
 {
 	unsigned int limit;
@@ -8906,9 +9022,24 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_SWITCH)) {
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
+				 * pending state for its next entry.
+				 */
+				kvm_vtl_event_consume(higher);
+			}
 		}
 	}
 #endif
@@ -8921,12 +9052,12 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 
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
@@ -9266,7 +9397,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_has_events);
 
 /*
  * An NMI aimed at a higher plane is folded to plane 0 and leaves only the
- * plane's own posting marker behind (see __apic_accept_irq()).  When that
+ * plane's own hv_nmi_event_pending marker behind (see __apic_accept_irq()).  When that
  * plane is the selected one and sits in HLT, nothing else wakes it: its
  * own event checks see no NMI, and plane 0's events are only examined
  * when the plane enters the guest.  The marker is consumed on that entry,
@@ -9275,7 +9406,7 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_has_events);
 static bool kvm_plane_nmi_folded(struct kvm_vcpu *vcpu)
 {
 	return vcpu->plane_level &&
-	       READ_ONCE(vcpu->arch.hv_apic_event_pending);
+	       READ_ONCE(vcpu->arch.hv_nmi_event_pending);
 }
 
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
@@ -10524,6 +10655,9 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 	atomic_set(&vcpu->arch.nmi_queued, 0);
 	vcpu->arch.nmi_pending = 0;
 	vcpu->arch.nmi_injected = false;
+	/* The events the forced-entry markers stand for are gone too. */
+	WRITE_ONCE(vcpu->arch.hv_apic_event_pending, false);
+	WRITE_ONCE(vcpu->arch.hv_nmi_event_pending, false);
 	kvm_clear_interrupt_queue(vcpu);
 	kvm_clear_exception_queue(vcpu);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 27155ac0522a..5399d0065c97 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -504,6 +504,7 @@ static inline void kvm_vcpu_init_vtl_fpu_carry(struct kvm_vcpu_common *common)
 
 void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu);
 void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu);
+void kvm_arch_vcpu_plane_stopped(struct kvm_vcpu *vcpu);
 struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu, bool *held);
 
 static inline bool kvm_vcpu_wants_to_run(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 4b1df1a592e9..3eeb36b3f785 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -5658,9 +5658,14 @@ void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu)
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

