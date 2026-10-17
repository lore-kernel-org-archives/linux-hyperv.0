Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E562490BEC;
	Sat, 17 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239912; cv=none; b=LueT4dtp4ZuGCDfimbjg+dKkAY+bHwUnWd1rVoHntMyOqhFxaWpxVKDIzt8P//GrwE4XeNfsPTV+Pvd7EptSo01jOgqyWCbW+Fu8HLsNmpvc3HaeMhx5CBzI5QHjjkF918UGcXogZPVebrQ5VRMOZsnvpluEPatg8wGkkduFUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239912; c=relaxed/simple;
	bh=5k3Xo+xmKtrt3lSmJryex41ZoFo1GnIi75WcsMAxYlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdCjZYwi/m8SY9WSj2Y91MindeAuQ8WHhPlNbWJYlxnK2pmttUIOmPZq2Ua1U8ELtwuchRqLJocy5WG9Qk1GO3i5yk3QWiTXJOEzoQNmoqe6N5M3RsA6vg/jJ1FkOKL0EbIe1NH00bpfP+7YQw0Akx2XfBLhrK+YCBZqK+X9bGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=McUw3hGj; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="McUw3hGj"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/EWyCyVIsJ7rQk78dgU8SQgTJnoYpxSVJ3hL1dmNDcM=; b=McUw3hGj8eyAG3BV/f47eaHE5g
	YyfhOP1sN01U7ERLrYdN/ZNnV5SN8v8CzlKS5KpVdkphiKUqKjYHsuNUjwF/UM5vB+ht0wtFyY9md
	yv4BcmnJ8W/z2LxoGlvqvzQy743Y6lpSck8liELYgKQshJBG8sRrznCkNkkRgI0i2gyQGb8XJSh1x
	67sMjkrw5TKW5oZPzr9VrQhCSrbUlhCS/oTnmAcUgMIltS4DsDYi67qhpM2wR2gMSoR9nOm4FDYy+
	ksLfZDUuJwvTEHMgBlO/dvigFzxl2VvzEyKjO8qOMdbiQ58AI1d9fz0jfZdWZlG50LMy/STHfwtd5
	S+QcCUhA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVEW-2eOF;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002Yof-1iMC;
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
Subject: [RFC PATCH 54/55] KVM: Check every plane's protections before caching a gfn->hva
Date: Sat, 17 Oct 2026 13:25:00 +0100
Message-ID: <20261017122501.610248-55-dwmw2@infradead.org>
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

The gfn_to_hva_cache init and the pfncache refresh refuse to cache a
range carrying NR/NW attributes, but consulted only plane 0's array.
Cached accesses made in vCPU context for a non-zero plane vCPU (steal
time, PV EOI, pvclock) therefore enforced plane 0's protections only: a
plane-N guest could point a PV MSR at a gfn its own plane marked NW and
kvm_write_guest_offset_cached() wrote through it, while the uncached
paths correctly use the vCPU's own plane.

A cached translation has no plane context at use time, so refuse the
cache when ANY plane protects the range.  The attribute generation that
invalidates these caches is already partition-wide, so updates on any
plane force a re-check.  The plane array walk follows the existing
lock-free kvm->planes[] reader pattern (acquire paired with the
publishing release).

Fixes: a407d03e5697 ("KVM: Take memory protections into account for accesses with cached gfn->hva")
Fixes: dc506e2ff987 ("KVM: pfncache: Fail to refresh if it contains memory protections")
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 include/linux/kvm_host.h |  8 ++++++++
 virt/kvm/kvm_main.c      | 31 ++++++++++++++++++++++++++++++-
 virt/kvm/pfncache.c      |  3 ++-
 3 files changed, 40 insertions(+), 2 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 60923494eea5..6a1ac96d64ba 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2846,6 +2846,8 @@ bool kvm_plane_range_has_any_attrs(struct kvm_plane *plane, gfn_t start,
 				   gfn_t end);
 bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 					unsigned long mask);
+bool kvm_any_plane_range_has_rw_memory_protections(struct kvm *kvm,
+						   gfn_t start, gfn_t end);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
@@ -2889,6 +2891,12 @@ static inline bool kvm_range_has_any_memory_attributes(struct kvm *kvm,
 {
 	return false;
 }
+static inline bool kvm_any_plane_range_has_rw_memory_protections(struct kvm *kvm,
+								 gfn_t start,
+								 gfn_t end)
+{
+	return false;
+}
 static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 {
 	return 0;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 1c70bb70500c..f0b474b0547d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2779,6 +2779,34 @@ static bool kvm_plane_range_has_memory_attributes(struct kvm_plane *plane,
 	return false;
 }
 
+/*
+ * Returns true if any plane's attributes deny read or write anywhere in
+ * [@start, @end).  Cached gfn->hva translations carry no plane context
+ * at use time, so a cache must be refused when ANY plane protects the
+ * range, not just plane 0.
+ */
+bool kvm_any_plane_range_has_rw_memory_protections(struct kvm *kvm,
+						   gfn_t start, gfn_t end)
+{
+	unsigned long mask = KVM_MEMORY_ATTRIBUTE_NR | KVM_MEMORY_ATTRIBUTE_NW;
+	int i;
+
+	if (kvm_range_has_rw_memory_protections(kvm, start, end))
+		return true;
+
+	for (i = 1; i < KVM_MAX_PLANES; i++) {
+		/* Pairs with the release in kvm_create_plane(). */
+		struct kvm_plane *plane = smp_load_acquire(&kvm->planes[i]);
+
+		if (plane &&
+		    kvm_plane_range_has_memory_attributes(plane, start, end,
+							  mask))
+			return true;
+	}
+
+	return false;
+}
+
 static bool kvm_range_memory_attributes_need_sync(struct kvm_plane *plane,
 						  gfn_t start, gfn_t end,
 						  unsigned long attributes)
@@ -3939,7 +3967,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
 	 * check has to happen after storing the generation number.
 	 */
 	ghc->attrs_generation = kvm_mem_attributes_generation(kvm);
-	if (kvm_range_has_rw_memory_protections(kvm, start_gfn, end_gfn + 1)) {
+	if (kvm_any_plane_range_has_rw_memory_protections(kvm, start_gfn,
+							  end_gfn + 1)) {
 		ghc->hva = KVM_HVA_ERR_BAD;
 		return -EFAULT;
 	}
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index 39935740136d..6ad1c62e9cd8 100644
--- a/virt/kvm/pfncache.c
+++ b/virt/kvm/pfncache.c
@@ -304,7 +304,8 @@ static int __kvm_gpc_refresh(struct gfn_to_pfn_cache *gpc, gpa_t gpa, unsigned l
 			 * generation number.
 			 */
 			gpc->attrs_generation = kvm_mem_attributes_generation(kvm);
-			if (kvm_range_has_rw_memory_protections(kvm, gfn, gfn + 1)) {
+			if (kvm_any_plane_range_has_rw_memory_protections(kvm, gfn,
+									  gfn + 1)) {
 				gpc->uhva = KVM_HVA_ERR_BAD;
 				ret = -EFAULT;
 				goto out;
-- 
2.50.1

