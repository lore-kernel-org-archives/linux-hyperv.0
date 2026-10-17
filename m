Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE68749BB6D;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239918; cv=none; b=HdVtf1QXdXsiasLlgJXr6k7O87+Eg0k2DwNYjQ5KwXMqOXGbvcfM9enZWU6PdUdK+gZUfdJ11pr33YnS7ztnp2WJHR/QDIDmlS27nh6pCb0KqeZOmqEVuTVAD5zx6OK9tfIjrHBtZ3L30rzrl5L8T8XdLru6QzuOaCReTM9CPyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239918; c=relaxed/simple;
	bh=XfCqxI74Aa7TBSekiDIlAL+5UvuAGb/1sOZm3WC6wVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SUpnMJvCfOmXFaTKDrWA84DKjv4g89vz1wAKF8A63rOFCrZlKZ9vioSHN3cfiU66t6j6L47XAcs8nlOXFwRo4EoyRc6SRIxkVjU5Q8CKxwrjBQzMRdDEBxYB1O2ZqDbsZJ68c49keVsfxhCjZ8Gn9OU0g8oNW/FhrehAi0uJXz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZV2vVaw3; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZV2vVaw3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=M0zgIqRNN0kxeGE0VAlc8ttUC9jsMRxSkD892xseXNo=; b=ZV2vVaw3/CtUN79rVLZvlzpllr
	J3hPnPZP42/wr/s0PKyIEQN/KsOLEGVRj140Q6lRHG4z06EGtTJulGebw6c7KmlB6aIthOy8MObky
	T5JZwexJDMa/Jm6AT7QLBsNHherhOg3Zdx3Qx5SVXrHoRt8uxuMob4BNHOai5aTLtNwzD62qlQ+E2
	LnZfwC+jFe8lFw74jl0Gyn4ILKeNstRb3VFTnDqTLHZYzhKuHQJuddIAgT5C0+LQaTfnk61YN7zAK
	ZgRPfld5KAsYKX1vEFaHNvtvGtgwwX7vykTUUlTYCtAom7cWu4oCLlJsQ/KPp/HP0pgniXdh6Caxi
	A38QGdPA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TG-00000002Lfd-3FPU;
	Sat, 17 Oct 2026 12:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002YoQ-19Z6;
	Sat, 17 Oct 2026 13:25:04 +0100
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
Subject: [RFC PATCH 51/55] KVM: SVM: Keep TPR[3:0] across exits without a guest CR8 write
Date: Sat, 17 Oct 2026 13:24:57 +0100
Message-ID: <20261017122501.610248-52-dwmw2@infradead.org>
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

V_TPR holds only TPR[7:4], and sync_cr8_to_lapic() pushed it back into
the APIC after every VMRUN.  A guest that sets TASKPRI through the
APIC page or MSR loses the low nibble at the next exit: VTL1 in the
hyperv_vsm KUT writes 0xff and reads back 0xf0 ("VTL1 TASKPRI write
sticks"), and interrupts in the sub-class the guest meant to mask are
let through.  VMX keeps all eight TPR bits in the virtual-APIC page
and does not have this problem.

Hardware changes V_TPR only on a guest CR8 write.  Record the value
sync_lapic_to_cr8() loads on entry and push V_TPR back into the APIC
only when it differs, i.e. only when the guest actually wrote CR8.  A
CR8 write whose value matches the loaded TPR[7:4] is indistinguishable
from no write and now preserves TPR[3:0], where architecturally it
would clear it; the previous behaviour cleared TPR[3:0] on every exit
regardless.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/svm/svm.c | 11 ++++++++++-
 arch/x86/kvm/svm/svm.h |  9 +++++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 42a12f2ad612..46ab1f8e330f 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4320,7 +4320,15 @@ static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
 
 	if (!svm_is_intercept(svm, INTERCEPT_CR8_WRITE)) {
 		int cr8 = svm->vmcb->control.int_ctl & V_TPR_MASK;
-		kvm_set_cr8(vcpu, cr8);
+
+		/*
+		 * Hardware changes V_TPR only on a guest CR8 write.  Pushing
+		 * an unchanged value into the APIC would zero TPR[3:0] (CR8
+		 * maps TPR[7:4] alone), wiping the low nibble of a TASKPRI
+		 * value the guest set through the APIC page or MSR.
+		 */
+		if (cr8 != svm->v_tpr_entry)
+			kvm_set_cr8(vcpu, cr8);
 	}
 }
 
@@ -4335,6 +4343,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
 	cr8 = kvm_get_cr8(vcpu);
 	svm->vmcb->control.int_ctl &= ~V_TPR_MASK;
 	svm->vmcb->control.int_ctl |= cr8 & V_TPR_MASK;
+	svm->v_tpr_entry = cr8 & V_TPR_MASK;
 }
 
 static void svm_complete_soft_interrupt(struct kvm_vcpu *vcpu, u8 vector,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 64438317d148..746a2ae98c4c 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -316,6 +316,15 @@ struct vcpu_svm {
 
 	void *msrpm;
 
+	/*
+	 * V_TPR value written by sync_lapic_to_cr8() on the last entry.
+	 * sync_cr8_to_lapic() pushes V_TPR back into the APIC only when it
+	 * differs, i.e. when the guest wrote CR8 in guest mode: V_TPR holds
+	 * TPR[7:4] only, so an unconditional back-sync would zero TPR[3:0]
+	 * after every exit, losing the low nibble of an APIC TASKPRI write.
+	 */
+	u8 v_tpr_entry;
+
 	ulong nmi_iret_rip;
 
 	struct svm_nested_state nested;
-- 
2.50.1

