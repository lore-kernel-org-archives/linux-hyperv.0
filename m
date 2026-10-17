Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F07348DB5E;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239909; cv=none; b=jYtokGGe+YrmhlxQ9QhK1TLFPiEyM4WQcyCOe2UWR/3vIkObpTNgsC8JbzzibaV5MiJSKE/RdODH2leGLooh/RwGHFndRCUGdSJRrLy1b4/Z3DjmoCoBEzYnJZDr+WthInPSo4gVDWc2Xmngw0AisLwwieXHgGX3Nthe0gZkrXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239909; c=relaxed/simple;
	bh=Vh9oWcqg7jnJ921aepMms9d5R+VDJXVcUUwZOycwXtE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nkMNIdTiwSdUwMTVWLAqT5ZFDR+soVA+9PrfLbl3epa/ikWy51m4rJoo0JF+udIUnFa8TZP0YNKV055OdFwwBAqy3ecW3+OXcq+wufnKwooNS6/0b0wqh8nO2IaenTlYeMNB+eBY4cIhiZJLMhqf1So8xYK/c6uitad/DZRAiuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PyIYjM37; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PyIYjM37"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=MTgcu8NLdcIrT6wwDvvYljAZLajakDjHwwZgsiKzKh8=; b=PyIYjM37TrpRkY3zhZTK1Thd39
	pk7kc6cBsQwVPF7pTL5uha9HwJILLpXhjjP9JnogJufzxjzJCcXAzO7fXDQ3O3tQUmkEO+2zG6T5/
	ia4WR4Of34IulMfBHhqkT4oTt4YlCJ2t58I6zSvu6uvHI6xM+eNrjpDsxO4TEbGMoK8HO9XE+CAqx
	Jmj8p6XGL6vvwGWlOkKeVJ8WNcw0Gor7/wzr7/tYFGUW24ZpSkeMr5dBzFXZZhPS6huKigvCgoHmd
	kx5p7F5Skj+9Jy27Y0sf38+goMJ0igVwjMmuWchsCofWqo+eUVM8D7+83ASHi2Ine/f3Bd1txs7EB
	FTEQdhCA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVCa-3GVO;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ymk-0gWs;
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
Subject: [RFC PATCH 28/55] KVM: x86: inhibit APICv when VM planes are enabled
Date: Sat, 17 Oct 2026 13:24:34 +0100
Message-ID: <20261017122501.610248-29-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

With APICv live on plane-0 vCPUs while their plane-1 twins use
software injection, the twins trip the APICv coherency checks: stale
vcpu-vs-VM activation state at vcpu_enter_guest(), and timer interrupt
injection against a vCPU that is not the running one. Cross-plane
event delivery (forced VTL entry, twin kicks, NMI folding) depends on
software-injection bookkeeping that hardware acceleration bypasses.

Add APICV_INHIBIT_REASON_PLANES, set it when a plane above 0 is
created, and include it in the VMX and AVIC required-inhibit masks;
__kvm_set_or_clear_apicv_inhibit() silently ignores a reason the
vendor mask does not carry. The reference VSM hypervisor likewise
force-disables APICv when VTLs are enabled.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h | 10 +++++++++-
 arch/x86/kvm/svm/svm.h          |  3 ++-
 arch/x86/kvm/vmx/main.c         |  3 ++-
 arch/x86/kvm/x86.c              | 10 ++++++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ba77d9375cd..5945b57c091d 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1436,6 +1436,13 @@ enum kvm_apicv_inhibit {
 	 */
 	APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG,
 
+	/*
+	 * APICv is inhibited when the VM has multiple planes (Hyper-V VTLs).
+	 * Cross-plane event delivery relies on software injection; hardware
+	 * acceleration on one twin would bypass it.
+	 */
+	APICV_INHIBIT_REASON_PLANES,
+
 	NR_APICV_INHIBIT_REASONS,
 };
 
@@ -1455,7 +1462,8 @@ enum kvm_apicv_inhibit {
 	__APICV_INHIBIT_REASON(PIT_REINJ),		\
 	__APICV_INHIBIT_REASON(SEV),			\
 	__APICV_INHIBIT_REASON(LOGICAL_ID_ALIASED),	\
-	__APICV_INHIBIT_REASON(PHYSICAL_ID_TOO_BIG)
+	__APICV_INHIBIT_REASON(PHYSICAL_ID_TOO_BIG),	\
+	__APICV_INHIBIT_REASON(PLANES)
 
 struct kvm_possible_nx_huge_pages {
 	/*
diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
index 7a1bf4f5b8e0..64438317d148 100644
--- a/arch/x86/kvm/svm/svm.h
+++ b/arch/x86/kvm/svm/svm.h
@@ -925,7 +925,8 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
 	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
 	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
 	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED) |	\
-	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG)	\
+	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG) |	\
+	BIT(APICV_INHIBIT_REASON_PLANES)		\
 )
 
 bool __init avic_hardware_setup(void);
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 572921bdfb32..81a8d398068b 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -876,7 +876,8 @@ static int vt_gmem_max_mapping_level(struct kvm *kvm, kvm_pfn_t pfn,
 	 BIT(APICV_INHIBIT_REASON_BLOCKIRQ) |			\
 	 BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
 	 BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |		\
-	 BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED))
+	 BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
+	 BIT(APICV_INHIBIT_REASON_PLANES))
 
 struct kvm_x86_ops vt_x86_ops __initdata = {
 	.name = KBUILD_MODNAME,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 3e2465b2fa2b..052821799120 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -13979,6 +13979,16 @@ int kvm_arch_plane_init(struct kvm *kvm, struct kvm_plane *plane,
 {
 	mutex_init(&plane->arch.apic_map_lock);
 
+	/*
+	 * Cross-plane event delivery (forced VTL entry, twin kicks, NMI
+	 * folding) relies on software injection via KVM_REQ_EVENT; hardware
+	 * APIC virtualization on one twin would bypass the bookkeeping the
+	 * other twin's plane depends on.  Mirrors the reference VSM
+	 * hypervisor, which force-disables APICv when VTLs are enabled.
+	 */
+	if (plane_level > 0)
+		kvm_set_apicv_inhibit(kvm, APICV_INHIBIT_REASON_PLANES);
+
 	return 0;
 }
 
-- 
2.50.1

