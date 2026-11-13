Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594895;
	b=LLu1zQbir82wy8PJEEPXRQNoqQvabZeumZEh2nLjB7IRhlXzDdvUVG/i01AVg1DITLYZ
	 VnsPKIkJ2stT00lViKQ2gvpXCaysAOYJu5NMYZ3K9edsDoWByqedHvvQ/IqQL94w9NSdU
	 NcXTIoWppkvjHVBQ1+ZYEnmJ5l25eL4KGtZIT5ruyBAdYm1KOrYBdI/fhtZmn83F3M6/H
	 S10nYapdApBO7+GWa7/KP1MnAkKzM5gEvQ3wbY7b8Hg6Gaa/OoFWAaCtm4vwCuUVZlxWQ
	 19uUOlxAZZ0rHDNE+yGAZXXPWlM8/IUE9cBMYf9VgBGSkCrLapKYX0XTtAiTuzrNKNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=jEH7w2x3WM75UBvsKf5hXIw6Fe3crCnDiCj/2uAeTW4=;
	b=iFAlDbBtLBQ9Bzt3AI3n6yJCCiuoYR81d+uXj9kdlbGRX5vPBP7EJ+JVOQNrkSSHXNt6
	 7GGCEjYCCub64BxB0F7XQRE3dZoQprJ7oIpMerAy94UUHvTBnZ2iDvcb2khSFO0BucsbD
	 jv9Q9Y+XTcU8WSDW5ji9PP4hkA1XsAGvwApaKx5+NjUocq7RHjoKGsVDXbkQ9MQHPkyp4
	 wSY8NAqIpF4/pUlFgBEZT3BJDKNxxAbrPqm9R4Q0xjeecTduzn8EsJ6DK9sb6T+d5WCDD
	 NP0F5s778p6BKR3uMmXBPi5n5Sdo3aLIHQi5gS2VZvvRJ+KNoO19655QJb7GuwPzUIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=A6EK9s7L;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF1860A5BC0;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEF1860A5BC0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=A6EK9s7L
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=jEH7w2x3WM75UBvsKf5hXIw6Fe3crCnDiCj/2uAeTW4=; b=A6EK9s7Lyq3N/0XryMfhdlkpMM
	6dASSBpyRk6qQ/QP1A1iL9LmB6XMGJY0YHFHpzy2XELcGwiOhY1L4NXJJlfl9QkL1ZOh+UaEL6o4c
	yN9DkDWTLniXoMA2iZkHl71qNF7y8G+BoGb7jlOW2v2Ua6pCJVLnqA16PweYMUS8CfBnHuaCYbyeK
	A3MMW7Ghxcf/90U0jQNaUYA9bVvDmKBZtmvzwtuv2+cjTDhuXklLkCn+4Knb+Y7ZRrXl2kWP2XPPd
	qtObtnkdXEyiQj5BGhja59FkUMhFfTQZh1YnWZYOZmxdzrDeAdLVkQUjxBE51uZmvYD+IRGsTMbdh
	QiZEJNaA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bf02-38X3;
	Fri, 13 Nov 2026 18:34:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LtJ-3RBi;
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
Subject: [RFC PATCH v2 12/31] KVM: x86: Kick lower twins when an event lands on a suspended plane
Date: Fri, 13 Nov 2026 18:34:28 +0000
Message-ID: <20261113183448.84094-13-dwmw2@infradead.org>
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
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

An interrupt or synthetic timer expiry posted to a suspended higher
plane raises a per-plane request on that plane's vCPU and kicks it. The
kick reaches the lower twin running on the same vCPU thread, since the
twins share their mode and wait queue, but the per-plane request does
not: a twin that is already past its event checks enters the guest
anyway, and the event does not preempt it until something else makes it
exit.

Add kvm_kick_lower_twins(), which raises KVM_REQ_UNBLOCK, a request in
the word the twins share, and kicks, so the running twin aborts a
vmentry in flight and re-evaluates pending higher-plane events. Call it
after delivering a fixed interrupt to a non-zero plane and whenever a
synthetic timer is marked pending, including the retry paths that call
stimer_mark_pending() with vcpu_kick false: a timer that expires again
on a parked plane through a retry must preempt the lower plane too. A
LAPIC timer expiry already raises KVM_REQ_UNBLOCK and kicks in
apic_timer_expired(), so that path needs nothing more.

The kick is skipped when the event cannot be consumed: without
KVM_HYPERV_HCALL_VTL_CALLS, or, with in-kernel switching, on a plane the
forced entry would refuse. kvm_higher_plane_event_consumable() holds
that rule, and kvm_higher_plane_with_event() now uses it too.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c |  7 +++++
 arch/x86/kvm/lapic.c  |  9 ++++---
 arch/x86/kvm/x86.c    | 63 +++++++++++++++++++++++++++++--------------
 arch/x86/kvm/x86.h    |  2 ++
 4 files changed, 58 insertions(+), 23 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 6b76e8ca845a..d2ad255ae212 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -611,6 +611,13 @@ static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 	kvm_make_request(KVM_REQ_HV_STIMER, vcpu);
 	if (vcpu_kick)
 		kvm_vcpu_kick(vcpu);
+
+	/*
+	 * A pending stimer on a suspended higher plane is only processed
+	 * once that plane runs, so it must preempt the lower plane, on
+	 * the retry paths (vcpu_kick == false) too.
+	 */
+	kvm_kick_lower_twins(vcpu);
 }
 
 static void stimer_cleanup(struct kvm_vcpu_hv_stimer *stimer)
diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 7842d0f53e9f..79e4998da644 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1450,11 +1450,14 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 						trig_mode, vector);
 
 		/*
-		 * Mark the posting of an interrupt to a higher plane for
-		 * the forced entry (see kvm_higher_plane_with_event()).
+		 * An interrupt for a higher plane preempts a lower one: mark
+		 * the posting for the forced entry, and make the running
+		 * lower twin look.
 		 */
-		if (vcpu->plane_level)
+		if (vcpu->plane_level) {
 			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+			kvm_kick_lower_twins(vcpu);
+		}
 		break;
 
 	case APIC_DM_REMRD:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 8cd3415d23f6..99a18f9da769 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8249,6 +8249,47 @@ static int kvm_check_and_inject_events(struct kvm_vcpu *vcpu,
 	return r;
 }
 
+/*
+ * Whether an event pending on the suspended plane @higher can be consumed.
+ * A higher plane preempting a lower one is VTL semantics: without
+ * KVM_HYPERV_HCALL_VTL_CALLS nothing consumes the event (no forced entry,
+ * no VTL interrupt exit).  With in-kernel switching, an event on a plane
+ * the forced entry would refuse (never run, user-held, parked on a
+ * foreign completion) has no consumer until userspace starts the plane;
+ * reporting it would wake a halted lower VTL into an endless hlt/wake
+ * loop.  With userspace switching the event is consumable via the
+ * interrupt exit, so it does count.
+ */
+bool kvm_higher_plane_event_consumable(struct kvm_vcpu *higher)
+{
+	if (!kvm_hv_hcall_feature(higher->kvm, KVM_HYPERV_HCALL_VTL_CALLS))
+		return false;
+#ifdef CONFIG_KVM_HYPERV
+	if (kvm_hv_hcall_feature(higher->kvm, KVM_HYPERV_HCALL_VTL_SWITCH) &&
+	    kvm_hv_vtl_entry_blocked(higher))
+		return false;
+#endif
+	return true;
+}
+
+/*
+ * An event posted to a suspended higher plane must make the lower twin
+ * running on the same vCPU thread re-evaluate pending higher-plane events,
+ * including when it is already past its event checks on the way into the
+ * guest.  KVM_REQ_UNBLOCK lives in the request word the twins share, so
+ * it aborts that twin's vmentry, and the kick reaches whichever twin is
+ * running (or waiting).  Nothing is kicked for an event that cannot be
+ * consumed.
+ */
+void kvm_kick_lower_twins(struct kvm_vcpu *vcpu)
+{
+	if (!vcpu->plane_level || !kvm_higher_plane_event_consumable(vcpu))
+		return;
+
+	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+	kvm_vcpu_kick(vcpu);
+}
+
 /*
  * A pending interrupt for a higher plane preempts this one: the higher
  * VTL's interrupts take priority over lower-VTL execution (TLFS 15.2.4),
@@ -8260,32 +8301,14 @@ static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
 	struct kvm_vcpu *higher;
 	int i;
 
-	/*
-	 * A higher plane preempting a lower one is VTL semantics: without
-	 * KVM_HYPERV_HCALL_VTL_CALLS nothing consumes the event (no forced
-	 * entry, no VTL interrupt exit), so don't report one.
-	 */
 	if (!kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_CALLS))
 		return NULL;
 
 	for (i = vcpu->plane_level + 1; i < KVM_MAX_PLANES; i++) {
 		higher = vcpu->common->vcpus[i];
-		if (!higher)
+		if (!higher || !kvm_higher_plane_event_consumable(higher))
 			continue;
-#ifdef CONFIG_KVM_HYPERV
-		/*
-		 * With in-kernel switching, an event on a plane the forced
-		 * entry would refuse (never run, user-held, parked on a
-		 * foreign completion) has no consumer until userspace
-		 * starts the plane; reporting it would wake a halted lower
-		 * VTL into an endless hlt/wake loop.  With userspace
-		 * switching the event is consumable via the interrupt exit,
-		 * so it does count.
-		 */
-		if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_SWITCH) &&
-		    kvm_hv_vtl_entry_blocked(higher))
-			continue;
-#endif
+
 		/*
 		 * Forced entry is edge-triggered on the posting of an
 		 * event, not level-triggered on the target's IRR, matching
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index e5a91c5cc969..649d4b8ac2d4 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -533,6 +533,8 @@ void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 				     u32 size);
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
+bool kvm_higher_plane_event_consumable(struct kvm_vcpu *higher);
+void kvm_kick_lower_twins(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
 
-- 
2.50.1

