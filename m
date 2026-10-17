Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF1484B95BF;
	Sat, 17 Oct 2026 12:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239932; cv=none; b=QW7Rg8v67zfiCMYaF4Fp9tjtuf96et01ae6XgHOpDFCMqL6q+iOahg2zI8EGmiDRdKWZUrsQwpiQ4ZwyJ71FptugJoYR4Hfch3fTWvqajhp2UjutI987SrAUlPg9B6WmpTWnp8uaGOpoywIpOJj/tuFLJ90QBirg7IYtz7Rsfl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239932; c=relaxed/simple;
	bh=Ix54dgrrrjDzfbyzVb23q1EZVYEi8mzWNOJ4L0CHj5o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TuwgbQSnFEuof44d1TI2dgVOHyvzO4dRE8Od+x+8TrYkVJ2qOuhSiCeRSVQ6eXsbJ8u9txQPKdElTxlsgrn0xFWXvAmMI/+hE8fkqHMhr1NDGJsQnaQ277n7f6JM1m4uYgBphjZbiYCh3RTiZTuVDhDQ1BBB5nQrXWFiRpvkdlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PHKJCPds; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PHKJCPds"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=LkaYA0NxGAqHXsGOuKUNiMJOYBmdONRvlzliqE6a0+I=; b=PHKJCPds6Byy4wJvn2ZFTx9qIG
	u+4lEhFo1T1y1EgsQe2ReLNmz1T/pH7lKO6MjvSXKoUHlpFBC3sRj11BYbHXaLaZFBgX+4bLXq3UD
	NS6kAZq3x3VNV2KJVvd8ghAvDu68yoUedsSSb6cmL25bQJb9NMzO+2+cjIU5XvaHwViMtUzaddaTB
	H9FrVu5EcOl47LsfyzXgczjkWzINMfZvGGmA5vQHoKiOXeYMHRRUZmGFf1UB04bneLZFCQFwIt0TI
	RpQ6/ECTH5VS8camyTcHRg0cTMZO3ngSEV3qJYPr7QjbpI2JjorwUBZK/f8tyqD8ANqhfCJIk9ehp
	bEc4HfYQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfO-1ZpC;
	Sat, 17 Oct 2026 12:25:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YmS-47fA;
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
Subject: [RFC PATCH 24/55] WIP: KVM: x86: deliver events to suspended higher planes
Date: Sat, 17 Oct 2026 13:24:30 +0100
Message-ID: <20261017122501.610248-25-dwmw2@infradead.org>
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

A suspended plane's events must preempt the lower plane running on the
same vCPU, but nothing told the running twin:

- An interrupt, local-APIC timer or Hyper-V stimer landing on a
  stopped twin only kicked the twin itself — a no-op while it is
  parked. Kick the lower twins too, with KVM_REQ_UNBLOCK so a sibling
  already past its event checks aborts the in-flight vmentry.
- A parked plane's lapic timer rode the VMX preemption timer, which
  only counts in guest mode, so it never fired while the plane was
  suspended. Hand it to the hrtimer when a non-zero plane's KVM_RUN
  ends.
- KVM_REQ_HV_STIMER was a shared request, so the running plane
  consumed the twin's request without processing the twin's stimers.
  Make it per-plane.
- kvm_higher_plane_with_event() now also reports a
  pending-but-not-injected apic timer.
- Suppress KVM_EXIT_HYPERV_SYNIC for non-zero planes: userspace's
  SynIC device models plane 0 only, and treated a twin's SIMP move as
  a plane-0 overlay relocation, carrying stale overlay contents to the
  new GPA.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/kvm/hyperv.c           | 27 +++++++++++++++++++
 arch/x86/kvm/lapic.c            | 46 ++++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.c              | 19 ++++++++++++--
 4 files changed, 90 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 74810e0e9ed7..c54f47c52a59 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -112,7 +112,7 @@
 #define KVM_REQ_IOAPIC_EOI_EXIT		KVM_ARCH_PLANE_REQ(19)
 #define KVM_REQ_HV_RESET		KVM_ARCH_REQ(20)
 #define KVM_REQ_HV_EXIT			KVM_ARCH_REQ(21)
-#define KVM_REQ_HV_STIMER		KVM_ARCH_REQ(22)
+#define KVM_REQ_HV_STIMER		KVM_ARCH_PLANE_REQ(22)
 #define KVM_REQ_LOAD_EOI_EXITMAP	KVM_ARCH_REQ(23)
 #define KVM_REQ_GET_NESTED_STATE_PAGES	KVM_ARCH_REQ(24)
 #define KVM_REQ_APICV_UPDATE \
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ca31054ed065..4551e011bf56 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -247,6 +247,15 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
 	struct kvm_vcpu *vcpu = hv_synic_to_vcpu(synic);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
+	/*
+	 * Userspace's SynIC device models plane 0 only; a higher plane's
+	 * exit would be mistaken for a plane-0 page move and relocate the
+	 * overlay the VMM keeps for SIMP/SIEFP.  Higher-plane SynICs are
+	 * handled fully in-kernel.
+	 */
+	if (vcpu->plane_level)
+		return;
+
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNIC;
 	hv_vcpu->exit.u.synic.msr = msr;
 	hv_vcpu->exit.u.synic.control = synic->control;
@@ -598,6 +607,24 @@ static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 	kvm_make_request(KVM_REQ_HV_STIMER, vcpu);
 	if (vcpu_kick)
 		kvm_vcpu_kick(vcpu);
+
+	/*
+	 * A pending stimer on a suspended higher plane is only processed
+	 * once that plane runs; kick the lower twins so the running one
+	 * re-evaluates pending higher-plane events and forces entry.
+	 */
+	if (vcpu_kick && vcpu->plane_level) {
+		struct kvm_vcpu *twin;
+		int p;
+
+		for (p = 0; p < vcpu->plane_level; p++) {
+			twin = vcpu->common->vcpus[p];
+			if (twin) {
+				kvm_make_request(KVM_REQ_UNBLOCK, twin);
+				kvm_vcpu_kick(twin);
+			}
+		}
+	}
 }
 
 static void stimer_cleanup(struct kvm_vcpu_hv_stimer *stimer)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index dc7a08831a54..f89156c26972 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1436,6 +1436,26 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 
 		kvm_x86_call(deliver_interrupt)(apic, delivery_mode,
 						trig_mode, vector);
+
+		/*
+		 * An interrupt for a higher plane must preempt a lower
+		 * plane running on the same vCPU: kicking only the (stopped)
+		 * target twin wakes a blocked sibling via the shared wait,
+		 * but a sibling executing in guest mode needs an explicit
+		 * kick to re-evaluate pending higher-plane events.
+		 */
+		if (vcpu->plane_level) {
+			struct kvm_vcpu *twin;
+			int p;
+
+			for (p = 0; p < vcpu->plane_level; p++) {
+				twin = vcpu->common->vcpus[p];
+				if (twin) {
+					kvm_make_request(KVM_REQ_UNBLOCK, twin);
+					kvm_vcpu_kick(twin);
+				}
+			}
+		}
 		break;
 
 	case APIC_DM_REMRD:
@@ -2060,6 +2080,24 @@ static void apic_timer_expired(struct kvm_lapic *apic, bool from_timer_fn)
 	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
 	if (from_timer_fn)
 		kvm_vcpu_kick(vcpu);
+
+	/*
+	 * A pending timer on a suspended higher plane only gets injected
+	 * once that plane runs again; kick the lower twins so the running
+	 * one re-evaluates pending higher-plane events and forces entry.
+	 */
+	if (vcpu->plane_level) {
+		struct kvm_vcpu *twin;
+		int p;
+
+		for (p = 0; p < vcpu->plane_level; p++) {
+			twin = vcpu->common->vcpus[p];
+			if (twin) {
+				kvm_make_request(KVM_REQ_UNBLOCK, twin);
+				kvm_vcpu_kick(twin);
+			}
+		}
+	}
 }
 
 static void start_sw_tscdeadline(struct kvm_lapic *apic)
@@ -3107,7 +3145,13 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
 	 * that vCPU creation is guaranteed to run with a deterministic value,
 	 * the request will ensure the vCPU gets the correct state before VM-Entry.
 	 */
-	if (enable_apicv) {
+	/*
+	 * Higher-plane twins are software-switched and mostly suspended;
+	 * hardware interrupt virtualization on them only leaves pending
+	 * vectors in the PIR where a suspended plane's state cannot be
+	 * reliably observed.  Keep them on the legacy delivery path.
+	 */
+	if (enable_apicv && !vcpu->plane_level) {
 		apic->apicv_active = true;
 		kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 374330f61eb2..4b12ec7ee100 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -11226,7 +11226,9 @@ static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
 		 */
 		if (kvm_cpu_has_extint(higher) ||
 		    kvm_apic_has_interrupt(higher) != -1 ||
-		    kvm_test_request(KVM_REQ_HV_STIMER, higher))
+		    kvm_test_request(KVM_REQ_HV_STIMER, higher) ||
+		    (higher->arch.apic &&
+		     atomic_read(&higher->arch.apic->lapic_timer.pending)))
 			return higher;
 	}
 	return NULL;
@@ -11336,8 +11338,12 @@ void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
 	down_read(&vcpu->kvm->arch.apicv_update_lock);
 	preempt_disable();
 
-	/* Do not activate APICV when APIC is disabled */
+	/*
+	 * Do not activate APICV when APIC is disabled, nor on higher-plane
+	 * twins (see kvm_create_lapic).
+	 */
 	activate = kvm_vcpu_apicv_activated(vcpu) &&
+		   !vcpu->plane_level &&
 		   (kvm_get_apic_mode(vcpu) != LAPIC_MODE_DISABLED);
 
 	if (apic->apicv_active == activate)
@@ -12566,6 +12572,15 @@ static int __kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	post_kvm_run_save(vcpu);
 	kvm_vcpu_srcu_read_unlock(vcpu);
 
+	/*
+	 * A non-zero plane may stay suspended indefinitely after this run
+	 * ends, and its hv timer only counts in VMX non-root mode.  Hand
+	 * the lapic timer to the hrtimer so it keeps firing while the
+	 * plane is parked; firing is what forces re-entry into the plane.
+	 */
+	if (vcpu->plane_level && kvm_lapic_hv_timer_in_use(vcpu))
+		kvm_lapic_switch_to_sw_timer(vcpu);
+
 	kvm_sigset_deactivate(vcpu);
 	vcpu_put(vcpu);
 	return r;
-- 
2.50.1

