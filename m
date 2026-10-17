Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA96549BB5F;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239917; cv=none; b=nRhrbUVhxla6Aszp2I6/CHjJ7vkEGgIEXm7SaA7whcVkG/tTI8Cv8WS0JquyS8Xd/2w0lJChLNg5QHQzpwsWudW/4QxWJOWar38pPkbEsRYagxUI4ODYnG339gn3R/lST9pYCd4VS2BuOHeXx/k4Zo5sGjj2+kPtF9Ct0rjuSy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239917; c=relaxed/simple;
	bh=dOj6wP+V+GWw8xiz/KtJQz7qAUKGxy+PXofBbrnRQd8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FKADoUnZ61job6GhoYpsIDzgOsE96O9XJ/rkoiLE1cISNRouuR8MSFvNkHbi/bYGcqTgD5lSsnR0ONoVuAHh9mGCXlPIl/HvxX72Pr57d0AiIb4nJunIipm00lOpcfoSRV7vFl/DoxUR1sxC6rmGsSVJ+9cUD12h+nJ5kj6RUMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GzvwMrgp; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GzvwMrgp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=OMybf8GIoxb5hT8RLH9h9O0SFavkcz0FBTGpp9jkGAw=; b=GzvwMrgptj8Obf5LvV8VqIjL0N
	lRbHmZY7z1Q73o30CZYmMIglIUMQOgW1+pNvRjaOvC65sRINnj1ZadSkGYvdJn/dvG6bDESwq80T4
	Iryp+PyJQLD44Czs8rErH91Xu7blGw7/SJGnbqF5dtJa7CNsRPpazD3DbipmQ7WpGeI0H7RR+VrY3
	9O9yZFoqIjpwgM79kdu8ajBBGZ5Y9F6E9NV9UsXDOMqC8oBlT6+s1k0JwSsJWXm2e15Mv+Mj0dlMG
	eCiowyvZFiiRleS8QlOmKyfppR0vTvNp0hpb1Tzir5ZStMrL5QkDR9/qNmiIVc/T29sr/cruFDjOJ
	8FIJIXNg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TG-00000002Lff-3Fts;
	Sat, 17 Oct 2026 12:25:07 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002Yoj-1q1c;
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
Subject: [RFC PATCH 55/55] KVM: planes: Annotate the lockless twin-publication protocol
Date: Sat, 17 Oct 2026 13:25:01 +0100
Message-ID: <20261017122501.610248-56-dwmw2@infradead.org>
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

Plane twins are published with a plain store to common->vcpus[] plus an
smp_wmb() that pairs with online_vcpus, not with twin initialisation,
while the lockless readers grown across the series (the twin-kick
paths, the Hyper-V TLB-flush and stimer twin lookups, the SEND_IPI
target lookup, vcpu_for_each_plane) read the slots with a mixture of
READ_ONCE and bare loads.  x86-TSO hides the lot, but the protocol is
unannotated generic code: KCSAN reports it, and nothing stops a
reordered publication from exposing a half-initialised twin to a kick.

Publish the slot with smp_store_release(), make every lockless reader
use READ_ONCE (vcpu_for_each_plane included), and document the pairing
at the iterator.  Mutex-serialised lookups (the in-kernel VTL switch
runs under the shared vCPU mutex that twin creation also takes) stay
plain.  Also document KVM_REQUEST_PER_PLANE's two scopes at its
definition: the fan-out to twins happens in kvm_make_vcpu_request(),
while a direct kvm_make_request() marks only the twin it was given - a
distinction a future direct-raise caller would otherwise trip over.

No functional change on x86.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/hyperv.c    |  6 +++---
 include/linux/kvm_host.h | 13 ++++++++++++-
 virt/kvm/kvm_main.c      |  8 +++++++-
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index dbe1b83c1f28..8abc61f46608 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -612,7 +612,7 @@ static void stimer_mark_pending(struct kvm_vcpu_hv_stimer *stimer,
 		int p;
 
 		for (p = 0; p < vcpu->plane_level; p++) {
-			twin = vcpu->common->vcpus[p];
+			twin = READ_ONCE(vcpu->common->vcpus[p]);
 			if (twin) {
 				kvm_make_request(KVM_REQ_UNBLOCK, twin);
 				kvm_vcpu_kick(twin);
@@ -2370,7 +2370,7 @@ static void hv_tlb_flush_enqueue_all_planes(struct kvm_vcpu *v,
 	int p;
 
 	for (p = 0; p < KVM_MAX_PLANES; p++) {
-		twin = v->common->vcpus[p];
+		twin = READ_ONCE(v->common->vcpus[p]);
 		if (!twin || !to_hv_vcpu(twin))
 			continue;
 		fifo = kvm_hv_get_tlb_flush_fifo(twin, false);
@@ -2601,7 +2601,7 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 		 * VTL): deliver into that plane's APIC.
 		 */
 		if (target_plane) {
-			target = vcpu->common->vcpus[target_plane];
+			target = READ_ONCE(vcpu->common->vcpus[target_plane]);
 			if (!target)
 				continue;
 		}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6a1ac96d64ba..4d98de4c7523 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -159,6 +159,12 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
 #define KVM_REQUEST_NO_WAKEUP      BIT(8)
 #define KVM_REQUEST_WAIT           BIT(9)
 #define KVM_REQUEST_NO_ACTION      BIT(10)
+/*
+ * A KVM_REQUEST_PER_PLANE request has two scopes: raised through
+ * kvm_make_vcpu_request() (kicks, mass requests) it fans out to every
+ * plane twin of the vCPU, while a direct kvm_make_request() marks only
+ * the twin it was given.  A direct caller must pick the twin it means.
+ */
 #define KVM_REQUEST_PER_PLANE      BIT(11)
 /*
  * Architecture-independent vcpu->requests bit members
@@ -400,9 +406,14 @@ struct kvm_vcpu_common {
 	struct kvm_vcpu_arch_common arch;
 };
 
+/*
+ * The slot read pairs with the smp_store_release() publication in
+ * kvm_vcpu_finish_common() for iterators running outside the locks that
+ * serialise twin creation.
+ */
 #define vcpu_for_each_plane(common, i, v)			\
 	for ((i) = 0; (i) < KVM_MAX_PLANES; ++(i))		\
-		if (((v) = common->vcpus[(i)]) != NULL)
+		if (((v) = READ_ONCE(common->vcpus[(i)])) != NULL)
 
 /* Tracked per plane-VCPU - used for deciding which plane-vcpu to run */
 enum kvm_vcpu_state {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index f0b474b0547d..6031ba9a6667 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -563,7 +563,13 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 static void kvm_vcpu_finish_common(struct kvm_vcpu *vcpu)
 {
 	WARN_ON(vcpu->common->vcpus[vcpu->plane_level] != NULL);
-	vcpu->common->vcpus[vcpu->plane_level] = vcpu;
+	/*
+	 * Publish with release semantics so the lockless twin readers
+	 * (the kick paths, vcpu_for_each_plane, the hyperv twin lookups)
+	 * observe a fully initialised vCPU through their READ_ONCE of the
+	 * slot; the plain store relied on x86-TSO.
+	 */
+	smp_store_release(&vcpu->common->vcpus[vcpu->plane_level], vcpu);
 	smp_wmb();
 	if (vcpu->plane_level == 0) {
 		/*
-- 
2.50.1

