Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A1723E3141;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=XAibYGgE3oCjr4wFojA0q/ceNJFK0+On4GCpgIB8Gwh+TROH28GrIsNSr6J6jf/H5XZHLL+53CevHriWgKWreOCeBwGU2kcHItsNT21acUdZ1iUGm4sBeL+/F0HRTVJwjuB7yCC5sBU1EbIF/WJ5vB/A2XNdsHVviO6wv71kiK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=ApWJTmQLM5kBRmH9Z005pGADOjN7eGdNjg3kodctWb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FZxPDS3VevO4j0ULcN1fxsUZioYrH52ok3yggvCwCz1i0Q6zbxM9PXoufV0uzBSDRG8NQi7m1OJITs7/WkkEy93fkAz+Vr+Sx2lj5d8QqoPOprSN3kdSf2meAW9YsbKeYv0puIN/tcFCTMOViKSFw5703y5a4uv1CjGNIIHv4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ju6q0N0u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ju6q0N0u"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=7ARJOUQcl+1ibhuvMgnL7DEPIiHAQh/yHpzYeA1wcrY=; b=Ju6q0N0uXu0f5TShQr04+DS98C
	wBfPF0RC9vS7oxomnKBAxyQrIwRLPGT2JPF9V2zfRxrJLwEHoEeaslRSKynhS5zNPryajKuM8yCMq
	B0c/Iybil40TSBVaH3Hw+eDEt3NHiDyjdG86sS1mFTHR7ywoTYIwO+UVpvQmr2X5h0h/0HmAa0htk
	Pr/TnjG+OZeRN4ZsKRl8Ki2/TtMyx+IX0XuzEky6Kjtu8HTMKSmJ0zOPpjG/7TBQ9Pp+w0jDoiVXC
	pKDgo/Ihnc5i+NEZU+Bigrd5efBbkjcMM81mrCjUN/0o94A69FncxJGCdYVC3AD5Jc3X0GqNosGuY
	3SczitXw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCH-21oT;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YlO-13MM;
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
Subject: [RFC PATCH 09/55] KVM: x86: hyper-v: Let userspace fault a forwarded hypercall
Date: Sat, 17 Oct 2026 13:24:15 +0100
Message-ID: <20261017122501.610248-10-dwmw2@infradead.org>
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

The architectural failure mode for an invalid VTL transition is #UD at
the VMCALL, not a hypercall status — a status would advance RIP and
complete the call. Define a result flag for the forwarded-hypercall
completion which queues #UD at the unadvanced RIP and ignores the rest
of the result.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/hyperv.c          | 14 +++++++++++++-
 include/uapi/linux/kvm.h       |  8 ++++++++
 tools/include/uapi/linux/kvm.h |  9 +++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ec669dafda6e..e41d101e327a 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2473,7 +2473,19 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 {
-	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
+	u64 result = vcpu->run->hyperv.u.hcall.result;
+
+	/*
+	 * A hypercall the VMM judged malformed beyond returning a status
+	 * (such as a VTL call that is invalid in the current state) faults
+	 * at the instruction instead of completing.
+	 */
+	if (result & KVM_HV_HCALL_RESULT_RAISE_UD) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	}
+
+	return kvm_hv_hypercall_complete(vcpu, result);
 }
 
 static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 2aeb8c5172cb..b55e28be5181 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1016,6 +1016,14 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_PLANES 249
 #define KVM_CAP_HYPERV_FORWARD_HCALL 250
+
+/*
+ * Userspace completion of a forwarded Hyper-V hypercall (KVM_EXIT_HYPERV_HCALL
+ * under KVM_CAP_HYPERV_FORWARD_HCALL): setting this bit in the result makes
+ * KVM raise #UD at the faulting instruction instead of completing the
+ * hypercall; all other result bits are then ignored.
+ */
+#define KVM_HV_HCALL_RESULT_RAISE_UD	(1ULL << 63)
 #define KVM_CAP_HCALL_FAULT_EXIT 252
 
 struct kvm_irq_routing_irqchip {
diff --git a/tools/include/uapi/linux/kvm.h b/tools/include/uapi/linux/kvm.h
index 8d9f7e6bba19..b55e28be5181 100644
--- a/tools/include/uapi/linux/kvm.h
+++ b/tools/include/uapi/linux/kvm.h
@@ -1017,6 +1017,15 @@ struct kvm_enable_cap {
 #define KVM_CAP_PLANES 249
 #define KVM_CAP_HYPERV_FORWARD_HCALL 250
 
+/*
+ * Userspace completion of a forwarded Hyper-V hypercall (KVM_EXIT_HYPERV_HCALL
+ * under KVM_CAP_HYPERV_FORWARD_HCALL): setting this bit in the result makes
+ * KVM raise #UD at the faulting instruction instead of completing the
+ * hypercall; all other result bits are then ignored.
+ */
+#define KVM_HV_HCALL_RESULT_RAISE_UD	(1ULL << 63)
+#define KVM_CAP_HCALL_FAULT_EXIT 252
+
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
 	__u32 pin;
-- 
2.50.1

