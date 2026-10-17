Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB7B493643;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239915; cv=none; b=SXF4yfZyo0ZO8g9W/hITEglMJUuwejVb+MPrl6HXE2lp75UJiwO6M50dDmCIefReajCV8OCmlomIGRsgXS2/0w3zKU1z4Cg7YXhoiioow/RFpvCbwnRcDcY5eeSvAlB+EFBVD/2Uz0mKgbByF03vCaTxKFqn5MQobB3ZbzMpV2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239915; c=relaxed/simple;
	bh=9OZzLLdtRGITcwl4NkwZq1KkzGInCqxcIJ3Kj5l+ZEk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DVmjgpJf9Gv0vxHTvf+4wmLzNbVEf72I6pNeyS3PpbwFr4SqSMBVGRVu7I61BK1xzPRDvJWYCv2Pu3Qs4ij4dKFpzgPkRWO9QTUFAMrM8690XQNVXbMtrsWr8nqC1is3juUz4obItB2w6iCWke8ECafKhMrTAqukm5N0Jky1mMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PiNCpGvT; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PiNCpGvT"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=GhIRKFeGlpUc3ofug/B/DXVsuSCLfK/2wSp9S7ZRGEQ=; b=PiNCpGvTgU4gOQhQGv3pA2eLJu
	Y+d5BlSK6l1fSfpUKB3XcUSTdoIUychMst+t0fb9lNp7mYpp0aG+m09iInlILK/EN/oYK+moZ2NN6
	ToVqZ+KAljFvypdaVEIeVXYeYqfCLE0g99siWUv0lbGJqaU6z8koqQsAZeIBDLsTwWcsykAODIfdZ
	c6aYK+B6bOWBfC+na4bqVc3ZlaIqpRtOTBsBGKVAZI3UbPOoGP1g9IUV0O3gKWaNmNV4xO8gCQUmV
	lK2CkUehNm5yAx2m+G+D8yhW6GY/JysOmfMlYXy3bYC1XNbaS1e5jK3nMJDRp8gb3d7KYlRKYOe/8
	jHU6D2Iw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfH-1bdD;
	Sat, 17 Oct 2026 12:25:05 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Yla-1iCl;
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
Subject: [RFC PATCH 12/55] KVM: x86: initialise Hyper-V state on every plane vCPU
Date: Sat, 17 Oct 2026 13:24:18 +0100
Message-ID: <20261017122501.610248-13-dwmw2@infradead.org>
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

When userspace sets a Hyper-V CPUID, kvm_set_cpuid() walks the vCPU's
planes to allocate the per-plane kvm_vcpu_hv, but passes the plane-0
vCPU to kvm_hv_vcpu_init() on every iteration. Non-zero plane vCPUs
are left without hv_vcpu, which trips the
WARN_ON_ONCE(vcpu->arch.hyperv_enabled) in kvm_hv_set_cpuid() and
leaves their vp_index and SynIC state uninitialised until a lazy init
path happens to run. Pass the plane vCPU being iterated.

A twin created after KVM_SET_CPUID never passes through
kvm_set_cpuid() at all: it shares the common CPUID, and
kvm_arch_vcpu_create() syncs it through kvm_vcpu_after_set_cpuid(),
so that walk cannot cover it and the twin hits the same WARN with an
empty cpuid_cache. Allocate the context in kvm_vcpu_after_set_cpuid()
when the CPUID has the Hyper-V signature and the vCPU doesn't have
one yet. The allocation is idempotent, so the kvm_set_cpuid() path is
unaffected; if it fails, treat Hyper-V as disabled for the vCPU
exactly as a failing kvm_set_cpuid() would have.

Also admit KVM_ENABLE_CAP on plane vCPU fds, so userspace can enable
per-vCPU capabilities such as KVM_CAP_HYPERV_SYNIC2 on a plane vCPU
before it first runs.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/cpuid.c | 18 +++++++++++++++---
 arch/x86/kvm/cpuid.h |  1 +
 arch/x86/kvm/x86.c   | 20 +++++++++++++++++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index fab075bb6fdc..fe8a793b1643 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -324,7 +324,7 @@ static void kvm_update_cpuid_runtime(struct kvm_vcpu *vcpu)
 						 vcpu->arch.ia32_xss, true);
 }
 
-static bool kvm_cpuid_has_hyperv(struct kvm_vcpu *vcpu)
+bool kvm_cpuid_has_hyperv(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_KVM_HYPERV
 	struct kvm_cpuid_entry2 *entry;
@@ -380,6 +380,7 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	struct kvm_cpuid_entry2 *best;
 	struct kvm_cpuid_entry2 *entry;
 	bool allow_gbpages;
+	bool hyperv_enabled;
 	int i;
 
 	memset(common->arch.cpu_caps, 0, sizeof(common->arch.cpu_caps));
@@ -456,7 +457,18 @@ void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 					 __cr4_reserved_bits(guest_cpu_cap_has, vcpu);
 #undef __kvm_cpu_cap_has
 
-	kvm_hv_set_cpuid(vcpu, kvm_cpuid_has_hyperv(vcpu));
+	hyperv_enabled = kvm_cpuid_has_hyperv(vcpu);
+
+	/*
+	 * A plane twin created after KVM_SET_CPUID shares the common CPUID
+	 * without passing through kvm_set_cpuid(), which is what allocates
+	 * the Hyper-V context for the planes that exist at set time;
+	 * allocate it here for a late-created twin.
+	 */
+	if (hyperv_enabled && kvm_hv_vcpu_init(vcpu))
+		hyperv_enabled = false;
+
+	kvm_hv_set_cpuid(vcpu, hyperv_enabled);
 
 	/* Invoke the vendor callback only after the above state is updated. */
 	kvm_x86_call(vcpu_after_set_cpuid)(vcpu);
@@ -565,7 +577,7 @@ static int kvm_set_cpuid(struct kvm_vcpu *vcpu, struct kvm_cpuid_entry2 *e2,
 #ifdef CONFIG_KVM_HYPERV
 	if (kvm_cpuid_has_hyperv(vcpu)) {
 		vcpu_for_each_plane(common, i, v) {
-			r = kvm_hv_vcpu_init(vcpu);
+			r = kvm_hv_vcpu_init(v);
 			if (r)
 				goto err;
 		}
diff --git a/arch/x86/kvm/cpuid.h b/arch/x86/kvm/cpuid.h
index 75abf447eabf..873377404899 100644
--- a/arch/x86/kvm/cpuid.h
+++ b/arch/x86/kvm/cpuid.h
@@ -19,6 +19,7 @@ static inline void kvm_finalize_cpu_caps(void)
 }
 
 void kvm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
+bool kvm_cpuid_has_hyperv(struct kvm_vcpu *vcpu);
 struct kvm_cpuid_entry2 *kvm_find_cpuid_entry2(struct kvm_cpuid_entry2 *entries,
 					       int nent, u32 function, u64 index);
 /*
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 2c41c53e4d4f..0828889db149 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6286,6 +6286,7 @@ static int kvm_get_reg_list(struct kvm_vcpu *vcpu,
 bool kvm_arch_is_vcpu_plane_ioctl(unsigned ioctl)
 {
 	switch (ioctl) {
+	case KVM_ENABLE_CAP:
 	case KVM_GET_DEBUGREGS:
 	case KVM_SET_DEBUGREGS:
 	case KVM_GET_LAPIC:
@@ -13135,9 +13136,24 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu->arch.hv_root_tdp = INVALID_PAGE;
 #endif
 
+	/*
+	 * A plane twin created after KVM_SET_CPUID shares CPUID that may
+	 * already advertise Hyper-V.  Allocate the Hyper-V context now so
+	 * a failure fails the creation; left to kvm_vcpu_after_set_cpuid()
+	 * below, an -ENOMEM silently downgrades just this twin to no
+	 * Hyper-V (its MSRs fail) while the shared CPUID still advertises
+	 * the Hyper-V signature, and nothing short of another full
+	 * KVM_SET_CPUID repairs it.
+	 */
+	if (kvm_cpuid_has_hyperv(vcpu)) {
+		r = kvm_hv_vcpu_init(vcpu);
+		if (r)
+			goto free_guest_fpu;
+	}
+
 	r = kvm_x86_call(vcpu_create)(vcpu);
 	if (r)
-		goto free_guest_fpu;
+		goto free_hv;
 
 	kvm_xen_init_vcpu(vcpu);
 	vcpu_load(vcpu);
@@ -13148,6 +13164,8 @@ int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 	vcpu_put(vcpu);
 	return 0;
 
+free_hv:
+	kvm_hv_vcpu_uninit(vcpu);
 free_guest_fpu:
 	fpu_free_guest_fpstate(&vcpu->arch.guest_fpu);
 free_emulate_ctxt:
-- 
2.50.1

