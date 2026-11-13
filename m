Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=MYsS53zV56/YLXDh3sEFyxli9wiiG9hCZ9QKkSShjjd5BRhzC4F80NNCoC2+agdObXU7
	 1/EL49i2sannbHYrLCogWGvGkuMVJ1O7zWNVao+/7K/jk01p4U+3m2oonwMDkiSrTX/hS
	 Euc+hhgHuQQiMJJieXUr8NfxSxV2tClEfL0Hm5uY31q4zfttWlVsxtCGHhXGZ+ntnQgwF
	 55b7L3OeA4pEjlMUIEBXE7JMnFXXuEMCcXBYJH/E72YhWjg2rs5VGDKuaPdVwn6OmVzjj
	 F86wn0yLTxuw8ylgfjdNTpPg0e/jhhGYQhfjWvLbnn6EBFI0aybGGGnLSiEcHfBEGgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=EY1jAy9xqxdqlTDEIZOP/6uxD2DtesdtQKnPvIrypYY=;
	b=h1PqargWLn6x/AgEVUAHFvi0TIOBde9MCSE7jE5PiVb6Gt3PDKIxvI/ygdVL8yzQiLE4
	 KsQJEq4OPcO/wTR753hVcOymGmdkDfIvjRC0B4r92CB6N1VmRieG3nttWT2lzMweROUva
	 960rDMsqdRG6INhhyWi1UmEH4BVzJmQbUGRi+6mHbig8njGf3Zeh0vA2f7bJtvP4PKv8Z
	 lRyj59OqFicwqbngz/8hzV2EwZ8KhrptqgHJWZ4LvxqQ/+00GvOpPgeB7J1Zd/4n4KuTw
	 Lx/tEcCSoatu89eysjcSSG13FJbO+tp0KVmN1PuNxdpxXd/hxVryR7PIuniTYV7b2Yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gePMfFXl;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D55606A885;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 24D55606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=gePMfFXl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EY1jAy9xqxdqlTDEIZOP/6uxD2DtesdtQKnPvIrypYY=; b=gePMfFXlM5uUyVVex2S8XUiIZT
	zlvQtIL8aI7Ed+EwmxwqEP9X3bsGQMB6O85z3W4+giuynHYckAF0cLOA1+GrgtVt7JrkVUWUGHwN0
	OEJ9NK6LICTLB3dZQ7/NqNqjFXc3BtVFeN3tMwSsgcoK5CDGdw+IvucDRzNJ6Drh83BYeVhg74Pct
	OyiMfzf0K9hazbu5ZzPvVtD/wUWY6oPi9Pug5lLQOPviiNDQaxmJpCYPeYs/YdTDyhHIFEowccKut
	5tFjmNMpi6bADMWVpqw9/emo1autHpujpMNN0FdFGQxKvQqaHhwNEVbiFWmJnKcYbZ6peGyQf7fYJ
	3ae9lC+A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQi-1U9A;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Ltn-0TS6;
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
Subject: [RFC PATCH v2 19/31] KVM: x86: Fold an NMI for a higher plane back to plane 0
Date: Fri, 13 Nov 2026 18:34:35 +0000
Message-ID: <20261113183448.84094-20-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

An NMI aimed at a higher plane is injected into that plane, so the
secure kernel takes a real NMI inside VTL1 and bugchecks (0x18B).

For a non-zero plane, inject the NMI into the plane-0 twin instead, to
be delivered once the VTL returns. Set the higher plane's
hv_apic_event_pending marker so the NMI still forces one entry into
it, and kick through __kvm_kick_lower_twins(), the ungated half of
kvm_kick_lower_twins(), since plane 0 takes the NMI whether or not
anything consumes the higher plane's event.
kvm_higher_plane_with_event() counts a higher plane's pending NMI state
(KVM_REQ_NMI, nmi_queued, nmi_pending) as an event as well: the fold
never leaves NMI state there, but KVM_SET_VCPU_EVENTS on the plane's
own fd can.

When the targeted plane is the selected one and halted, the fold must
still break its HLT, as an NMI would on hardware. Its own event checks
see no NMI and plane 0's events are only examined on guest entry, so
kvm_arch_vcpu_runnable() counts the posting marker the fold leaves on
a non-zero plane, and kvm_check_plane0_events() counts plane 0's
nmi_queued, where the folded NMI waits until it is processed.

Plane 0 is looked up without the locks that serialise twin creation,
so its slot is read once, with READ_ONCE(), to pair with its
publication.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/lapic.c | 26 ++++++++++++++++++++++++--
 arch/x86/kvm/x86.c   | 35 ++++++++++++++++++++++++++++++-----
 arch/x86/kvm/x86.h   |  1 +
 3 files changed, 55 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index 81bf72e83e8c..d33226c44488 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -1476,8 +1476,30 @@ static int __apic_accept_irq(struct kvm_lapic *apic, int delivery_mode,
 
 	case APIC_DM_NMI:
 		result = 1;
-		kvm_inject_nmi(vcpu);
-		kvm_vcpu_kick(vcpu);
+		/*
+		 * An NMI aimed at a higher plane forces entry into that
+		 * plane (reason INTERRUPT, below) but the NMI itself is
+		 * folded back to plane 0 and delivered there after the VTL
+		 * returns.  Matches the Nitro VSM implementation, which never
+		 * delivers an NMI inside a higher VTL.
+		 */
+		if (vcpu->plane_level) {
+			struct kvm_vcpu *twin;
+
+			WRITE_ONCE(vcpu->arch.hv_apic_event_pending, true);
+			twin = READ_ONCE(vcpu->common->vcpus[0]);
+			if (twin)
+				kvm_inject_nmi(twin);
+			/*
+			 * Plane 0 takes the NMI whether or not VTL semantics
+			 * are on, so don't gate this kick the way
+			 * kvm_kick_lower_twins() does.
+			 */
+			__kvm_kick_lower_twins(vcpu);
+		} else {
+			kvm_inject_nmi(vcpu);
+			kvm_vcpu_kick(vcpu);
+		}
 		break;
 
 	case APIC_DM_INIT:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 165eb105e112..c2c9b5a181b9 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8301,16 +8301,22 @@ bool kvm_higher_plane_event_consumable(struct kvm_vcpu *higher)
  * including when it is already past its event checks on the way into the
  * guest.  KVM_REQ_UNBLOCK lives in the request word the twins share, so
  * it aborts that twin's vmentry, and the kick reaches whichever twin is
- * running (or waiting).  Nothing is kicked for an event that cannot be
- * consumed.
+ * running (or waiting).  kvm_kick_lower_twins() kicks nothing for an
+ * event that cannot be consumed; __kvm_kick_lower_twins() is the ungated
+ * kick, for an event that a lower plane takes itself.
  */
+void __kvm_kick_lower_twins(struct kvm_vcpu *vcpu)
+{
+	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
+	kvm_vcpu_kick(vcpu);
+}
+
 void kvm_kick_lower_twins(struct kvm_vcpu *vcpu)
 {
 	if (!vcpu->plane_level || !kvm_higher_plane_event_consumable(vcpu))
 		return;
 
-	kvm_make_request(KVM_REQ_UNBLOCK, vcpu);
-	kvm_vcpu_kick(vcpu);
+	__kvm_kick_lower_twins(vcpu);
 }
 
 /*
@@ -8353,6 +8359,9 @@ static struct kvm_vcpu *kvm_higher_plane_with_event(struct kvm_vcpu *vcpu)
 		if (READ_ONCE(higher->arch.hv_apic_event_pending) ||
 		    kvm_cpu_has_extint(higher) ||
 		    kvm_test_request(KVM_REQ_HV_STIMER, higher) ||
+		    kvm_test_request(KVM_REQ_NMI, higher) ||
+		    atomic_read(&higher->arch.nmi_queued) ||
+		    higher->arch.nmi_pending ||
 		    kvm_cpu_has_pending_timer(higher))
 			return higher;
 	}
@@ -8403,6 +8412,7 @@ static inline bool kvm_check_plane0_events(struct kvm_vcpu *vcpu)
 
 	return kvm_cpu_has_injectable_intr(vcpu_plane0) ||
 		vcpu_plane0->arch.nmi_pending ||
+		atomic_read(&vcpu_plane0->arch.nmi_queued) ||
 		vcpu_plane0->arch.smi_pending;
 }
 
@@ -9254,11 +9264,26 @@ bool kvm_vcpu_has_events(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_has_events);
 
+/*
+ * An NMI aimed at a higher plane is folded to plane 0 and leaves only the
+ * plane's own posting marker behind (see __apic_accept_irq()).  When that
+ * plane is the selected one and sits in HLT, nothing else wakes it: its
+ * own event checks see no NMI, and plane 0's events are only examined
+ * when the plane enters the guest.  The marker is consumed on that entry,
+ * so the NMI breaks the HLT once, as it would on hardware.
+ */
+static bool kvm_plane_nmi_folded(struct kvm_vcpu *vcpu)
+{
+	return vcpu->plane_level &&
+	       READ_ONCE(vcpu->arch.hv_apic_event_pending);
+}
+
 int kvm_arch_vcpu_runnable(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_running(vcpu) || vcpu->arch.pv.pv_unhalted ||
 	       kvm_vcpu_has_events(vcpu) ||
-	       kvm_higher_plane_with_event(vcpu);
+	       kvm_higher_plane_with_event(vcpu) ||
+	       kvm_plane_nmi_folded(vcpu);
 }
 
 /* Called within kvm->srcu read side.  */
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 649d4b8ac2d4..00dc866c08c3 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -534,6 +534,7 @@ void __user *__x86_set_memory_region(struct kvm *kvm, int id, gpa_t gpa,
 int memslot_rmap_alloc(struct kvm_memory_slot *slot, unsigned long npages);
 
 bool kvm_higher_plane_event_consumable(struct kvm_vcpu *higher);
+void __kvm_kick_lower_twins(struct kvm_vcpu *vcpu);
 void kvm_kick_lower_twins(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_reset_bsp(struct kvm_vcpu *vcpu);
 bool kvm_vcpu_is_bsp(struct kvm_vcpu *vcpu);
-- 
2.50.1

