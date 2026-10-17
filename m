Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2B494298;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=ZymFE1lDGJkRoyldQCamPQ5Uz/6fJD2kiIRBV9FW/Xsw+gUNpaSO4II5RMBm+e3/ckApSXVGoQKlfestId7L59Y+sSUUPuvhJvZxtW2qpaQZygu4zFTxA0mEDpUpUFDYqEuVft60k5XKvoBtHYJr4t1HOQamRFNcCsyrGKCLJ9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=kN2jO2ofGvwSN/NOSNtM9Q8PCQunXuMGA5ir6/XKexE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KnhEWB1sGMGVYOQDUHJ91PLizDWfvsT2yJx64fWk6RYIj98T0liqhUM7a+HdKq6VVb2O44on/VoFmI478MaF2Clhg26D2W8wBttcm/V1byrsj57MzX+m/rTJ0ghcuSybzPBP4tnpGt1YEdrjEnbdflSOm1FCATz65otmDNgJrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T30MJfuj; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T30MJfuj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=PUE06KD80pNWd8TOutTZYi8qhSQaf8Ga2miXUzkADlY=; b=T30MJfujxRWJ/wv9sX5rkx/rbD
	DqQtIi2OxwYddtaLgM0iMvK7iBMPhvrEN8PtyDqCTN6G7rFiTMZnR4No64AGxOnQY12BgCSjLVheD
	HcSAWhtryo90oz6z002YZl7x4cZiMvcu71w7yAQpzqmsANJOyKLXEIa3wVsN6KWeUdhMJws9u8Lfv
	Lqelj0JEwUdaB9SbBIgmosf4GL5dK9LSOXeOrdQ7tU3p7A7jfFis3RExVEbV7oD38vSzqrSbaebtw
	qAFaMeJY8xnCBWnqwFHhT3E7Didbtv7c2qE/Z63cWCTdmFX+wSf2t3CjYUMdzEinGXsmqNESEzoq4
	cVoh39/w==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002Lfa-1xJ1;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ynm-3ouj;
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
Subject: [RFC PATCH 43/55] KVM: x86: Derive runtime CPUID bits from the executing plane
Date: Sat, 17 Oct 2026 13:24:49 +0100
Message-ID: <20261017122501.610248-44-dwmw2@infradead.org>
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

From: Mushahid Hussain <hmushi@amazon.co.uk>

Some CPUID bits follow registers of the vCPU: CPUID.1:ECX.OSXSAVE
follows CR4.OSXSAVE, CPUID.7:ECX.OSPKE follows CR4.PKE, CPUID.1:EDX.APIC
follows the APIC enable, CPUID.1:ECX.MWAIT follows MISC_ENABLE, and the
XSAVE area sizes in leaf 0xD follow XCR0 and XSS. KVM keeps the CPUID
table of a vCPU in the state its planes share, and refreshes those bits
into the table from the state of whichever vCPU runs when the table is
dirty. The planes of a vCPU have their own control registers, so after
one plane sets CR4.OSXSAVE, CPUID on every plane of that vCPU reports
OSXSAVE until a plane with it clear refreshes the table, and the other
way round. The architecture requires CPUID to describe the processor
that executes it, and for a plane that is the plane's own registers.

A Windows guest with Virtual Secure Mode shows the leak. Its secure
kernel runs on a plane whose CR4.OSXSAVE is clear while the normal
kernel on the other plane has set it. The secure kernel executes the
usual probe, CPUID.1 followed by a test of OSXSAVE, reads the bit set
and executes XGETBV, which raises #UD because its own CR4 does not
permit it.

Compute the bits that follow vCPU registers when CPUID is emulated,
from the registers of the vCPU that executes it, and no longer refresh
the shared table on that path. The table keeps the view of plane 0 for
KVM_GET_CPUID2 and KVM_SET_CPUID2, which act on the plane 0 vCPU, and
their refresh stays as it is.

Assisted-by: LLM

(re-done by hand from the reference VSM implementation)
[dwmw2: dropped the plane selftest hunk; this branch has no
 plane_x86_test.c.  The per-VTL OSXSAVE contract is pinned by the VSM
 conformance suite instead.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst |   7 +++
 arch/x86/kvm/cpuid.c           | 108 +++++++++++++++++++++++----------
 arch/x86/kvm/cpuid.h           |   5 +-
 3 files changed, 87 insertions(+), 33 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 215547802377..d75987c1d325 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -370,6 +370,13 @@ cpu's hardware control block.
 VCPUs for non-zero planes can only be created if the VCPU the same index has
 already been created for plane zero.
 
+The planes of a vCPU share its CPUID model, set through the plane 0 fd with
+KVM_SET_CPUID2.  The CPUID bits that follow a vCPU's own registers (OSXSAVE
+from CR4.OSXSAVE, OSPKE from CR4.PKE, the APIC enable, MWAIT from
+MISC_ENABLE, and the XSAVE area sizes from XCR0 and XSS) reflect the plane
+that executes CPUID, since every plane has these registers of its own.
+KVM_GET_CPUID2 returns them as plane 0 sees them.
+
 4.8 KVM_GET_DIRTY_LOG
 ---------------------
 
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index f744e7845843..a71888749a29 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -171,6 +171,9 @@ static int kvm_check_cpuid(struct kvm_vcpu *vcpu)
 
 static u32 kvm_apply_cpuid_pv_features_quirk(struct kvm_vcpu *vcpu);
 static void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu);
+static void kvm_cpuid_apply_runtime(struct kvm_vcpu *vcpu, u32 function,
+				    u32 index, u32 *eax, u32 *ebx, u32 *ecx,
+				    u32 *edx);
 
 /* Check whether the supplied CPUID data is equal to what is already set for the vCPU. */
 static int kvm_cpuid_check_equal(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
@@ -278,50 +281,51 @@ static u64 cpuid_get_supported_xss(struct kvm_vcpu *vcpu)
 	return (best->ecx | ((u64)best->edx << 32)) & kvm_caps.supported_xss;
 }
 
-static __always_inline void kvm_update_feature_runtime(struct kvm_vcpu *vcpu,
-						       struct kvm_cpuid_entry2 *entry,
-						       unsigned int x86_feature,
-						       bool has_feature)
-{
-	cpuid_entry_change(entry, x86_feature, has_feature);
-	guest_cpu_cap_change(vcpu->common, x86_feature, has_feature);
-}
-
+/* The table keeps plane 0's view of the runtime bits for KVM_GET_CPUID2. */
 static void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 {
 	struct kvm_cpuid_entry2 *best;
 
+	/*
+	 * Compute from the plane-0 twin no matter which plane triggered
+	 * the refresh: KVM_SET_CPUID runs this for every plane in turn,
+	 * and KVM_GET_CPUID2 is reachable from any plane's fd.
+	 */
+	if (vcpu->common->vcpus[0])
+		vcpu = vcpu->common->vcpus[0];
+
 	vcpu->common->arch.cpuid_dynamic_bits_dirty = false;
 
 	best = kvm_find_cpuid_entry(vcpu, 1);
 	if (best) {
-		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSXSAVE,
-					   kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE));
-
-		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_APIC,
-					   vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE);
-
+		kvm_cpuid_apply_runtime(vcpu, 1, 0, &best->eax, &best->ebx,
+					&best->ecx, &best->edx);
+		guest_cpu_cap_change(vcpu->common, X86_FEATURE_OSXSAVE,
+				     cpuid_entry_has(best, X86_FEATURE_OSXSAVE));
+		guest_cpu_cap_change(vcpu->common, X86_FEATURE_APIC,
+				     cpuid_entry_has(best, X86_FEATURE_APIC));
 		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT))
-			kvm_update_feature_runtime(vcpu, best, X86_FEATURE_MWAIT,
-						   vcpu->arch.ia32_misc_enable_msr &
-						   MSR_IA32_MISC_ENABLE_MWAIT);
+			guest_cpu_cap_change(vcpu->common, X86_FEATURE_MWAIT,
+					     cpuid_entry_has(best, X86_FEATURE_MWAIT));
 	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 7, 0);
-	if (best)
-		kvm_update_feature_runtime(vcpu, best, X86_FEATURE_OSPKE,
-					   kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE));
-
+	if (best) {
+		kvm_cpuid_apply_runtime(vcpu, 7, 0, &best->eax, &best->ebx,
+					&best->ecx, &best->edx);
+		guest_cpu_cap_change(vcpu->common, X86_FEATURE_OSPKE,
+				     cpuid_entry_has(best, X86_FEATURE_OSPKE));
+	}
 
 	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 0);
 	if (best)
-		best->ebx = xstate_required_size(vcpu->arch.xcr0, false);
+		kvm_cpuid_apply_runtime(vcpu, 0xd, 0, &best->eax, &best->ebx,
+					&best->ecx, &best->edx);
 
 	best = kvm_find_cpuid_entry_index(vcpu, 0xD, 1);
-	if (best && (cpuid_entry_has(best, X86_FEATURE_XSAVES) ||
-		     cpuid_entry_has(best, X86_FEATURE_XSAVEC)))
-		best->ebx = xstate_required_size(vcpu->arch.xcr0 |
-						 vcpu->arch.ia32_xss, true);
+	if (best)
+		kvm_cpuid_apply_runtime(vcpu, 0xd, 1, &best->eax, &best->ebx,
+					&best->ecx, &best->edx);
 }
 
 bool kvm_cpuid_has_hyperv(struct kvm_vcpu *vcpu)
@@ -2121,17 +2125,58 @@ get_out_of_range_cpuid_entry(struct kvm_vcpu *vcpu, u32 *fn_ptr, u32 index)
 	return kvm_find_cpuid_entry_index(vcpu, basic->eax, index);
 }
 
+/*
+ * The planes share the CPUID table but not CR4, the APIC enable, MISC_ENABLE
+ * or XCR0/XSS: the bits that follow those come from the executing plane.
+ */
+static void kvm_cpuid_apply_runtime(struct kvm_vcpu *vcpu, u32 function,
+				    u32 index, u32 *eax, u32 *ebx, u32 *ecx,
+				    u32 *edx)
+{
+	switch (function) {
+	case 1:
+		*ecx &= ~feature_bit(OSXSAVE);
+		if (kvm_is_cr4_bit_set(vcpu, X86_CR4_OSXSAVE))
+			*ecx |= feature_bit(OSXSAVE);
+
+		*edx &= ~feature_bit(APIC);
+		if (vcpu->arch.apic_base & MSR_IA32_APICBASE_ENABLE)
+			*edx |= feature_bit(APIC);
+
+		if (!kvm_check_has_quirk(vcpu->kvm, KVM_X86_QUIRK_MISC_ENABLE_NO_MWAIT)) {
+			*ecx &= ~feature_bit(MWAIT);
+			if (vcpu->arch.ia32_misc_enable_msr &
+			    MSR_IA32_MISC_ENABLE_MWAIT)
+				*ecx |= feature_bit(MWAIT);
+		}
+		break;
+	case 7:
+		if (index)
+			break;
+		*ecx &= ~feature_bit(OSPKE);
+		if (kvm_is_cr4_bit_set(vcpu, X86_CR4_PKE))
+			*ecx |= feature_bit(OSPKE);
+		break;
+	case 0xd:
+		if (index == 0)
+			*ebx = xstate_required_size(vcpu->arch.xcr0, false);
+		else if (index == 1 &&
+			 (*eax & (feature_bit(XSAVES) | feature_bit(XSAVEC))))
+			*ebx = xstate_required_size(vcpu->arch.xcr0 |
+						    vcpu->arch.ia32_xss, true);
+		break;
+	default:
+		break;
+	}
+}
+
 bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 	       u32 *ecx, u32 *edx, bool exact_only)
 {
 	u32 orig_function = *eax, function = *eax, index = *ecx;
-	struct kvm_vcpu_common *common = vcpu->common;
 	struct kvm_cpuid_entry2 *entry;
 	bool exact, used_max_basic = false;
 
-	if (common->arch.cpuid_dynamic_bits_dirty)
-		kvm_update_cpuid_runtime(vcpu);
-
 	entry = kvm_find_cpuid_entry_index(vcpu, function, index);
 	exact = !!entry;
 
@@ -2145,6 +2190,7 @@ bool kvm_cpuid(struct kvm_vcpu *vcpu, u32 *eax, u32 *ebx,
 		*ebx = entry->ebx;
 		*ecx = entry->ecx;
 		*edx = entry->edx;
+		kvm_cpuid_apply_runtime(vcpu, function, index, eax, ebx, ecx, edx);
 		if (function == 7 && index == 0) {
 			u64 data;
 			if ((*ebx & (feature_bit(RTM) | feature_bit(HLE))) &&
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 873377404899..2720e1820d7d 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -273,8 +273,9 @@ static __always_inline bool guest_cpu_cap_has(struct kvm_vcpu *vcpu,
 	struct kvm_vcpu_common *common = vcpu->common;
 
 	/*
-	 * Except for MWAIT, querying dynamic feature bits is disallowed, so
-	 * that KVM can defer runtime updates until the next CPUID emulation.
+	 * Except for MWAIT, querying dynamic feature bits is disallowed: the
+	 * guest gets them from the state of the plane that executes CPUID, and
+	 * the table copy is refreshed only for the CPUID ioctls.
 	 */
 	BUILD_BUG_ON(x86_feature == X86_FEATURE_APIC ||
 		     x86_feature == X86_FEATURE_OSXSAVE ||
-- 
2.50.1

