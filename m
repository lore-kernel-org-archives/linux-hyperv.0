Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=kNzY3Zx2nAZp+78khF2Y54TccyEjBfa7bUXYPmNO37PTzeUCriXbIc9WZwzoiDfeUYUf
	 obqhoSZC2yERjC+wEbrxyKMjAgnfbG6xKHSE36OIB7U5PGd10s0oUpLoy4Eyv6uDxmUOh
	 byfckPNU5vkvk8gd0IubLreo2Fm4FVzFSIMdDN9Loo9wDuxcpAxOWzfIaFZU5UTzhMz4L
	 cNm93x210iyrYemxIzSBi6vaD0A5A0MBO39touFMdWwDWQipSILSrRvqllaeU69ONFJZT
	 OktK/izbFYwWOHfxa+vqP3wHGz+lk5E0SjEI0PNgDiI+LfGWAce//3mNFX5EnEklXXg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=RFjZrZyzRZHYPexghm1fB/dAz6WRQaGXQodRS4ebBdk=;
	b=PzRRxPd9Qof3PHgvHbYT4xbatKM5BOakFLgX3hRI50iuGvAcVblsfRFx6D2QS1iz7J4o
	 B8uVC1SXhleIfccliQuJ3YgJwuHDjz3Dqbpw+wr/+2WuwygJEtFGifjtgdO0JwWuHQzQO
	 K/Ltrjg9udlrMi2QlRfqhbKe+7qGY+6s1uF4v96IvXp7rqk5V4wSf/3AJPkkQz6K88u8z
	 Yoil6NtiS62mBk28+Ih9k/B/2FdgaNbxIGDwSpKm6x9N8w75fvUQF54e57iYWEDAdkDXM
	 70b6+aFnuYZBv7gmMt4WOteabuTzJx8XfTh+1g6EUtI7cPiWBrSJD8RLNna69lwMO8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=L2seJnyB;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73006606A896;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73006606A896
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=L2seJnyB
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=RFjZrZyzRZHYPexghm1fB/dAz6WRQaGXQodRS4ebBdk=; b=L2seJnyBdJ/ExdzRQZKgTFiKqB
	hbFYFM6t03vH9Cw7U/UZwqkVKq59Fv2j95fEKgnUzkemXcH5jrSIq3fToAJRTJPYEO+gX4MfdQmF2
	8nyItFsPP3tkuTxMKIegs5Ok3Zjo3xJSqrUHn+PlJikD4TCG1iuGBFjvSGJP0QlMpIIpoxyTIlfQr
	B9NG+kN6tApq+vfAo86wq8IfwvpgHYr7p7MzbOWuOmX9dxb2McwZB4SW409TMs/H8xTvwANl4kaLy
	s1STTb9OMHyYrNlrYnUFAlG78FiLtHH5XDWmgBQVO+jBT5DiIIMjwT3qaA4qmA9xYvvfk/hkZJztr
	s8iJu8HQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gRC-31JA;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000LuQ-23tN;
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
Subject: [RFC PATCH v2 28/31] KVM: SVM: Keep TPR[3:0] across exits without a guest CR8 write
Date: Fri, 13 Nov 2026 18:34:44 +0000
Message-ID: <20261113183448.84094-29-dwmw2@infradead.org>
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

V_TPR holds only TPR[7:4]. While KVM does not intercept CR8 writes,
sync_cr8_to_lapic() pushes V_TPR back into the local APIC after every
VMRUN, whether or not the guest touched CR8. A guest that sets the TPR
through the APIC page or the x2APIC MSR therefore loses TPR[3:0] at the
next exit: it writes 0xff, reads back 0xf0, and interrupts in the
priority sub-class it meant to mask are delivered. VMX keeps all eight
TPR bits in the virtual-APIC page and does not have this problem.

Hardware changes V_TPR only on a guest CR8 write. Record the value
sync_lapic_to_cr8() loads on entry and push V_TPR back into the APIC
only when it differs, which only a guest CR8 write can make it do. A
CR8 write whose value matches the loaded TPR[7:4] is indistinguishable
from no write and now preserves TPR[3:0], where architecturally it
would clear it; the previous behaviour cleared TPR[3:0] on every exit
regardless.

Found while implementing Hyper-V VSM on KVM planes.

Fixes: d7bf8221a303 ("KVM: SVM: sync V_TPR with LAPIC.TPR if CR8 write intercept is disabled")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/svm/svm.c | 11 ++++++++++-
 arch/x86/kvm/svm/svm.h | 13 +++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index cf049367523c..9bfcc7684504 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -4622,7 +4622,15 @@ static inline void sync_cr8_to_lapic(struct kvm_vcpu *vcpu)
 
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
 
@@ -4637,6 +4645,7 @@ static inline void sync_lapic_to_cr8(struct kvm_vcpu *vcpu)
 	cr8 = kvm_get_cr8(vcpu);
 	svm->vmcb->control.int_ctl &= ~V_TPR_MASK;
 	svm->vmcb->control.int_ctl |= cr8 & V_TPR_MASK;
+	svm->v_tpr_entry = cr8 & V_TPR_MASK;
 }
 
 static void svm_complete_soft_interrupt(struct kvm_vcpu *vcpu, u8 vector,
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index e7fced399e05..3dfa8b20152b 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -323,6 +323,19 @@ struct vcpu_svm {
 
 	void *msrpm;
 
+	/*
+	 * V_TPR value written by sync_lapic_to_cr8() on the last entry.
+	 * sync_cr8_to_lapic() pushes V_TPR back into the APIC only when it
+	 * differs: V_TPR holds TPR[7:4] only, so an unconditional back-sync
+	 * would zero TPR[3:0] after every exit, losing the low nibble of an
+	 * APIC TASKPRI write.  A differing V_TPR implies a guest CR8 write,
+	 * but not the converse: a CR8 write of the same value is
+	 * indistinguishable from no write, so TPR[3:0] survives it where
+	 * the architectural write (and the intercepted path through
+	 * kvm_lapic_set_tpr()) would clear it.
+	 */
+	u8 v_tpr_entry;
+
 	ulong nmi_iret_rip;
 
 	struct svm_nested_state nested;
-- 
2.50.1

