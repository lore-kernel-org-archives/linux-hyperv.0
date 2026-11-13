Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=t2xL79KUK7tOR9XBkci4ojGnfEanKptMpbBYJnbsQyDEQCObhiIyTzWhX9eVEs/ENme+
	 jMYf7311FvU+DTnCBRkLTh2kzMK2JcOUkRt5rTL+LibsV2on+UtJ4rDCMa/3uCet9q2Sj
	 KpJWmGUNgaAsK8eYVSySgBXuNLCJ9Z+H6DTKWR0L7h/hkqNTCg9hCdJOkgxsiZzquuPHI
	 hcN8viYGI772AnB7uz0IqczX8zumsin7HPCPFp1hNxlMyZ14GdBuWvzISto+EMfMbvu5i
	 0x0hF5jZ6hxBjO2NZ1lu3M6D5YRADRnyJ0aRR7TB4Sdbn2OQ4SIpz5FV0qXjYNDRDCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=OsfdQpcDSkqN46L6UIV0k3Fy24iO77UPJBIKGT8Wqy4=;
	b=c7v1aJyAg/nYumaXdprEoQy/EhHijNuDwxL5qWqmTpxQ6/SnHmh3tDrTvljiGcnIP+E8
	 UnI51v7t/Vb8TcSqv3Wydse02WCv0kUsYTrtqakvjZiUP+NSykL/huvlLfOGZ31fA7m00
	 J60GgHhCf0lCOLaNnQcBzLEogO9JCu4axTQRCE8bici4r7Eb6xlDD3+8SQTL6ywDleyEV
	 hHqXv0pjEGn3g4+lV8A2DmXuP9quLLGQ6K8y6dRI+ifblltuL6K6Oc5Gto2CdppSpS5vq
	 rvuTOiOuWSYCrnZubQMsmeMwJ8tTSFR/LrkFAgmh9Ef+CwlVGQbxGqkcPp711tKkwFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b="ivR/EsdM";
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B0EB606A334;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5B0EB606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ivR/EsdM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OsfdQpcDSkqN46L6UIV0k3Fy24iO77UPJBIKGT8Wqy4=; b=ivR/EsdMs31tz43LqA0G2WPekI
	z0k31Ubk4aQtqBHUJLfvVIvt4YGt/xQrF/4L6nTN/jH8z9tFWa5jg6c7wr0l2XrDnGjZBlKDz6FKf
	KWKnXwjEd/7alp7FY6s9XkQ0K08Lk7Czl36Ky+0upy7mrA6TOHoxhemXYiYhM572ql92UKd8/rbXZ
	NqOoZxDudaeeSm/9u9ASs368QuEii94E/aj5MuDT69iRo/FDO0KggH+VBnlU9NI4i/bwcHj0q8ELj
	/B8Y8EBKCMTgH6ITmAutyidpgxtXKSY5adRRw1MJkfHdridpNI4PpRq8onPH5WSJQXAY6aeuywelY
	icWN+JbA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPf-3wE8;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lt9-30Te;
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
Subject: [RFC PATCH v2 10/31] KVM: x86: Keep APICv off on higher-plane vCPUs
Date: Fri, 13 Nov 2026 18:34:26 +0000
Message-ID: <20261113183448.84094-11-dwmw2@infradead.org>
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

A higher-plane twin is switched in software and spends most of its
time suspended. With APICv active, an interrupt posted to it sits in
the PIR, where the lower plane's checks for a pending higher-plane
event cannot reliably see it while the twin is not running.

Leave APICv inactive on every vCPU with a non-zero plane_level: at LAPIC
creation, and in __kvm_vcpu_update_apicv() so a later APICv update
cannot turn it back on. Higher planes use the legacy delivery path,
whose IRR the pending-event checks read directly.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/lapic.c | 8 +++++++-
 arch/x86/kvm/x86.c   | 6 +++++-
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/lapic.c b/arch/x86/kvm/lapic.c
index ccf01b263ebf..7842d0f53e9f 100644
--- a/arch/x86/kvm/lapic.c
+++ b/arch/x86/kvm/lapic.c
@@ -3192,7 +3192,13 @@ int kvm_create_lapic(struct kvm_vcpu *vcpu)
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
index 0fda04f6114a..8cd3415d23f6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8426,8 +8426,12 @@ void __kvm_vcpu_update_apicv(struct kvm_vcpu *vcpu)
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
-- 
2.50.1

