Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF1C49BB6B;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239921; cv=none; b=JYt+KmvzCnxjBbi0ZTZ9ql8A0/dUx1CiwV0nNmztt7YwxHa6C/33su2TAFdg4mfXyC5L26Y58ll3P6dPniAuLERNb6NfwB4dO0RiqY9eo56czYWQ2igoOqlLinypk0STRWpFi1VE7SwxWB8eu5qpBDoyGnUhcmK2nvdC2GzzkOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239921; c=relaxed/simple;
	bh=GGISYxBVMFwwmjIudiwkLQW2EBD5hrqUQjbmkYhAPRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hEuVSsDV15BdIgWD95AoV6n/wRsJKkAjtOZM4Vx97iUNc4AQkvmJPHSSOTfMtYCUaDalcniU4Tl/OaFNY7xQXCfhtAFgoig2kw4oktM+OI0y3dRKWzsBu7zb6bkCJrrUQ0b0/bcgg+BP8Qp9wkHxfCKe+Z+xl3H3s8+erFJGnDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q9Q0dKWP; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q9Q0dKWP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Ykge/B5ISm51mdf1roR9yJS+HCjWgrC1b43pwMOXgXQ=; b=q9Q0dKWPyC2w9TyoqC4TevCqLh
	lxeQLzeDcO/dl+4ImxgPs9RIllyiu9EBzs70csScA9OOjohyLJgO9G29tT1z/CeQNlbCzO7siHc6g
	M0gE1AGmUoL9hhmFnVKr/tRlsF9abURweNNgMsTDwECJsr8Uc5Vu3LJeV2+8RXPxPRtmjOg5Kz8+g
	Bg4w73CF8Jr/d8YYmGLLjOmda5/FGi3jpAL58rRxlGSN0YRCI5gaO8b0svU4vABohIVnZgckBTTfk
	PWTfU3jyVhk46U5nUmCqbZCQ4bpED4xb5Flrm0A5LSMpv0vHSIpjYzs8FiSPeltI5XFzTek7+K4ay
	E1ICrNqA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TG-00000002Lfe-3G7Y;
	Sat, 17 Oct 2026 12:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002Yob-1ZBX;
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
Subject: [RFC PATCH 53/55] KVM: SVM: Hedge the v_tpr_entry comment
Date: Sat, 17 Oct 2026 13:24:59 +0100
Message-ID: <20261017122501.610248-54-dwmw2@infradead.org>
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

The comment claimed V_TPR "differs, i.e. when the guest wrote CR8":
differing implies a write, but a write does not imply differing. A
same-value CR8 write is invisible to the back-sync, so TPR[3:0]
survives where the architectural write would clear it — a documented
tradeoff of commit f34c595cb8a5 ("KVM: SVM: Keep TPR[3:0] across
exits without a guest CR8 write"), which deserves stating at the
field rather than only in that commit's message. No functional
change.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/svm/svm.h | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 746a2ae98c4c..24d34697fe65 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -319,9 +319,13 @@ struct vcpu_svm {
 	/*
 	 * V_TPR value written by sync_lapic_to_cr8() on the last entry.
 	 * sync_cr8_to_lapic() pushes V_TPR back into the APIC only when it
-	 * differs, i.e. when the guest wrote CR8 in guest mode: V_TPR holds
-	 * TPR[7:4] only, so an unconditional back-sync would zero TPR[3:0]
-	 * after every exit, losing the low nibble of an APIC TASKPRI write.
+	 * differs: V_TPR holds TPR[7:4] only, so an unconditional back-sync
+	 * would zero TPR[3:0] after every exit, losing the low nibble of an
+	 * APIC TASKPRI write.  A differing V_TPR implies a guest CR8 write,
+	 * but not the converse: a CR8 write of the same value is
+	 * indistinguishable from no write, so TPR[3:0] survives it where
+	 * the architectural write (and the intercepted path through
+	 * kvm_lapic_set_tpr()) would clear it.
 	 */
 	u8 v_tpr_entry;
 
-- 
2.50.1

