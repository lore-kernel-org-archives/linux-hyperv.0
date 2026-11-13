Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=cTj8eYPWOv9oZljsZ7z1MrRdIQn5ZMi+POaa9qj+z4LfXkGCgfA3TTKK6nQ62cQXfOXi
	 Rr7QDnE+TqwJBIO3Lv0CJWaUIBOAX7aee6vus+1QGZuPLNxeAjMZpqw4dUhlzePOiKIfx
	 fNOdW27T7jGLdmhRXanXHFLw1QL0v2CzdxukVPJvYdQJ/v3TGHdDrKhLrNiJ+ByZWlZH+
	 RDA+VjfdGAHeFfattDAnLra7i+VT7y9x2N7NFf5sC7gAugbJcgIAcCtyS5BK3gr5e8dee
	 Xx6/Jb5DGmKDiUdRWsZYP14bWm7lpsVBNTF7r8Ycuvrg3Gm6yD4bgSvnvTblVnHS4vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=/WqO646IdUqxWnilMTwK/CDvkieJdx4BpTrbDaCZSsA=;
	b=RV/ifm6EKlxWNkjjom/KPjiA1+KR3Ni0uq7dz5dSVj/hvIUTLcU8R+hBVPhfmzyslcP1
	 XjblCUct9Ol+8nuhAOob61QTUwC6u1nI9w2UEfhZk6rl/Mlb0a+Pe3Kp3idQJljSgA4J4
	 GmM5hU+nguY1nxo+Cy6L1ynSbUFJB1NZflP1fNMoP/r27VSauVdrnPSHbCnWAs/V3zpZx
	 AdMgETDEohzOxG38id6ekaFH8dktmo8koGYHyvsNuAElp0XwIxErkfUZ15JXOS9qxLf0G
	 mhoSy//aLjTWzo5+Zh5tJG/PFzsz2rECtT0lqjN2qdR4S2RzF8OeBhA+O+vfXH2u2IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=h12w1uXZ;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02235606A33B;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02235606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=h12w1uXZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=/WqO646IdUqxWnilMTwK/CDvkieJdx4BpTrbDaCZSsA=; b=h12w1uXZXr0VxxlkJMIDbgr4iV
	niMeSS+q3vLuKqI+JbXXrhwTvI9AJiVynwjSNsVOuZlHYz7AqvMEhExx6sLsrFW8CMJZTmeeq0oRU
	LOQtMSSSpZ6jDB3hx77B+BRGmncsxd+S1YW1YgtleFMS1UKM13KiFIQ2I/DUSoWOPn2H7780sR+5q
	YRr091RcUaGbvQPBM4CL/tBQZqOM3z27b4bk+WMk+uB4uOTWm3gNDbD8XCZWTx+fo7Had5wyQDiGA
	vhtquhQG4mHooASWDhM+dFcUXSbhaH5PKJD7VRCEOAZgY0hb9FyiyBHAm/j2H2r402GWz0G+C6D/G
	H1KmUfFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQP-0uuL;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lta-4Bjz;
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
Subject: [RFC PATCH v2 16/31] KVM: Add per-plane memory overlays
Date: Fri, 13 Nov 2026 18:34:32 +0000
Message-ID: <20261113183448.84094-17-dwmw2@infradead.org>
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

TLFS overlay pages, the SynIC message page (SIMP) in particular, show
each VTL a private page at a GPA while the other VTLs keep seeing the
guest RAM underneath. With planes, all planes share the memslots, so a
VMM has no way to give a single plane a different backing for one gfn.

Add the KVM_SET_PLANE_MEMORY_OVERLAY vm ioctl, which pins one page of
userspace memory and maps it over a gfn for a single plane, replaces
it, or removes it when 'uaddr' is 0. KVM_CAP_PLANE_MEMORY_OVERLAYS
reports the per-plane limit (KVM_PLANE_MAX_OVERLAYS, 64). An overlay
cannot cover a private or guest_memfd-only gfn.

On x86, per-plane EPT roots make a per-plane pfn override in
__kvm_mmu_faultin_pfn() sufficient. While a plane has overlays its
mappings stay at 4KiB, so a neighbouring fault's huge page cannot span
an overlaid gfn, and the gmem path only ever narrows max_level.
kvm_tdp_mmu_recover_huge_pages() skips non-zero-plane roots, and plane
0 roots while plane 0 has overlays, so a later promotion cannot widen
a plane's attribute or overlay clamps back out. Planes keep no lpage
tracking; their fault path rebuilds each mapping at the largest level
the plane allows.

The overlay update runs under the kvm_mmu_invalidate_start()/end()
protocol with the gfn registered, as the mmu notifiers do, so a
concurrent lockless fault cannot install an SPTE for the old backing
after the zap. Overlays are unpinned when the plane is destroyed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst |  48 ++++++
 arch/x86/kvm/mmu/mmu.c         |  29 +++-
 arch/x86/kvm/mmu/tdp_mmu.c     |  17 +-
 include/linux/kvm_host.h       |  17 ++
 include/uapi/linux/kvm.h       |  11 ++
 virt/kvm/kvm_main.c            | 278 +++++++++++++++++++++++++++++++++
 6 files changed, 395 insertions(+), 5 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b742ca327130..1c30bb2806d3 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6965,6 +6965,38 @@ plane has KVM_PLANE_RUN_STATE_INACTIVE.
 
 .. _kvm_run:
 
+4.149 KVM_SET_PLANE_MEMORY_OVERLAY
+----------------------------------
+
+:Capability: KVM_CAP_PLANE_MEMORY_OVERLAYS
+:Architectures: x86
+:Type: vm ioctl
+:Parameters: struct kvm_plane_memory_overlay (in)
+:Returns: 0 on success, <0 on error
+
+::
+
+  struct kvm_plane_memory_overlay {
+	__u32 plane;
+	__u32 flags;
+	__u64 gfn;
+	__u64 uaddr;		/* page-aligned; 0 removes the overlay */
+  };
+
+Installs, replaces or removes a memory overlay for a single guest page
+frame on one plane.  While an overlay is installed, translations of
+'gfn' for vCPUs of 'plane' resolve to the (pinned) page at 'uaddr' in
+the calling process instead of to the memslot backing; other planes are
+unaffected.  Hyper-V VSM uses this for per-VTL overlay pages such as
+the SynIC message and event-flags pages.
+
+'flags' must be zero and 'uaddr' must be page-aligned.  At most
+KVM_CHECK_EXTENSION(KVM_CAP_PLANE_MEMORY_OVERLAYS) distinct gfns can
+carry an overlay per plane at any one time; further installs fail with
+-ENOSPC until an overlay is removed.  An overlay cannot be installed
+over a private or guest_memfd-only gfn (-EINVAL).  Passing 'uaddr' == 0
+removes the overlay for 'gfn', if any.
+
 5. The kvm_run structure
 ========================
 
@@ -10129,6 +10161,22 @@ take care to differentiate between these cases.
 The presence of this capability indicates that the nested KVM guest can
 start in ESA mode.
 
+8.48 KVM_CAP_PLANE_MEMORY_OVERLAYS
+----------------------------------
+
+:Architectures: x86
+
+A positive return from KVM_CHECK_EXTENSION(KVM_CAP_PLANE_MEMORY_OVERLAYS)
+announces two things:
+
+ - The KVM_SET_PLANE_MEMORY_OVERLAY vm ioctl (section 4.149).  The
+   returned value is the number of gfns which can carry an overlay
+   simultaneously on each plane.
+
+ - The extended KVM_EXIT_MEMORY_FAULT layout: 'memory_fault' carries
+   the additional 'gva', 'insn_len' and 'insn_bytes' fields, with
+   KVM_MEMORY_EXIT_FLAG_GVA_VALID qualifying 'gva' (see section 5).
+
 9. Known KVM API problems
 =========================
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 669a1a2a6e3c..8061790e7357 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4715,7 +4715,13 @@ static int kvm_mmu_faultin_pfn_gmem(struct kvm_vcpu *vcpu,
 	if (fault->slot->flags & KVM_MEM_READONLY)
 		fault->host_access &= ~ACC_WRITE_MASK;
 
-	fault->max_level = kvm_max_level_for_order(max_order);
+	/*
+	 * Only ever narrow max_level: the overlay check in
+	 * __kvm_mmu_faultin_pfn() may already have clamped it to 4KiB, and
+	 * a huge gmem mapping must not span an overlaid gfn.
+	 */
+	fault->max_level = min(fault->max_level,
+			       kvm_max_level_for_order(max_order));
 	return RET_PF_CONTINUE;
 }
 
@@ -4780,8 +4786,29 @@ static int __kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 				 struct kvm_page_fault *fault)
 {
 	unsigned int foll = fault->write ? FOLL_WRITE : 0;
+	struct page *overlay;
 	bool writable;
 
+	/*
+	 * A plane overlay page (VSM SynIC SIMP/SIEFP etc.) replaces the
+	 * memslot translation for this plane only.  The page is pinned
+	 * for the overlay's lifetime, so no refcounting here.
+	 */
+	/*
+	 * Keep this plane's mappings at 4KiB while it has overlays: a huge
+	 * mapping established by a neighbouring gfn's fault would span the
+	 * overlaid gfn and bypass the override below.
+	 */
+	if (READ_ONCE(vcpu->plane->nr_overlays)) {
+		fault->max_level = PG_LEVEL_4K;
+
+		overlay = kvm_plane_overlay_page(vcpu->plane, fault->gfn);
+		if (overlay) {
+			fault->pfn = page_to_pfn(overlay);
+			return RET_PF_CONTINUE;
+		}
+	}
+
 	if (fault->is_private || kvm_memslot_is_gmem_only(fault->slot))
 		return kvm_mmu_faultin_pfn_gmem(vcpu, fault);
 
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index 356efffe0b16..3c2f97345998 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1832,13 +1832,22 @@ void kvm_tdp_mmu_recover_huge_pages(struct kvm *kvm,
 		/*
 		 * kvm_mmu_max_mapping_level() consults only plane-0 state
 		 * (lpage_info and plane-0 private attributes).  Nonzero
-		 * planes carry per-plane memory attributes whose fault-time
-		 * 4KiB clamps a huge SPTE would undo, extending one page's
-		 * protections over gfns the plane maps differently.  Leave
+		 * planes carry per-plane memory attributes and memory
+		 * overlays whose fault-time 4KiB clamps a huge SPTE would
+		 * undo, extending one page's protections or overlay
+		 * backing over gfns the plane maps differently.  Leave
 		 * those roots alone; their fault path rebuilds mappings at
 		 * the largest level the plane allows.
+		 *
+		 * Plane 0 can carry overlays too (kvm->planes[0] always
+		 * exists and KVM_SET_PLANE_MEMORY_OVERLAY accepts plane 0),
+		 * and the same reasoning applies: a recovered huge SPTE
+		 * would either span an overlaid gfn with the memslot
+		 * backing, or huge-align the pinned overlay page's pfn and
+		 * map ~2MiB of unrelated host memory around it.
 		 */
-		if (root->role.plane)
+		if (root->role.plane ||
+		    READ_ONCE(kvm->planes[root->role.plane]->nr_overlays))
 			continue;
 		recover_huge_pages_range(kvm, root, slot);
 	}
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 09ed84886550..27155ac0522a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -928,9 +928,26 @@ struct kvm_plane {
 	struct xarray mem_attrs;
 #endif
 
+	/*
+	 * VSM overlay pages: per-plane gfn -> pinned user page overriding
+	 * the memslot translation for this plane only.  Written under
+	 * kvm->slots_lock; readers tolerate a transient stale view, the
+	 * post-update zap makes the EPT coherent.
+	 */
+#define KVM_PLANE_MAX_OVERLAYS 64
+	struct kvm_plane_overlay {
+		gfn_t gfn;
+		unsigned long uaddr;
+		struct page *page;
+	} overlays[KVM_PLANE_MAX_OVERLAYS];
+	int nr_overlays;
+
 	struct kvm_arch_plane arch;
 };
 
+struct page *kvm_plane_overlay_page(struct kvm_plane *plane, gfn_t gfn);
+unsigned long kvm_plane_overlay_uaddr(struct kvm_plane *plane, gfn_t gfn);
+
 struct kvm {
 #ifdef KVM_HAVE_MMU_RWLOCK
 	rwlock_t mmu_lock;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 25626be71eb7..18845d9e02f2 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1049,6 +1049,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_HYPERV_FORWARD_HCALL 255
 #define KVM_CAP_PLANES_SHARE 256
 #define KVM_CAP_HYPERV_REG_INTERCEPT 257
+#define KVM_CAP_PLANE_MEMORY_OVERLAYS 260
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1411,6 +1412,16 @@ struct kvm_s390_keyop {
 #define   KVM_PLANE_RUN_STATE_SUSPENDED	(1ULL << 1)
 #define   KVM_PLANE_RUN_STATE_INACTIVE	(1ULL << 2)
 
+/* Map one page of userspace memory over a GPA for a single plane (VSM
+ * overlay pages: SynIC SIMP/SIEFP, hypercall page, VP assist page). */
+struct kvm_plane_memory_overlay {
+	__u32 plane;
+	__u32 flags;
+	__u64 gfn;
+	__u64 uaddr;		/* page-aligned; 0 removes the overlay */
+};
+#define KVM_SET_PLANE_MEMORY_OVERLAY	  _IOW(KVMIO, 0xe7, struct kvm_plane_memory_overlay)
+
 /*
  * ioctls for vcpu fds
  */
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 0a3cfdc624d7..4b1df1a592e9 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1309,6 +1309,14 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 
 static void kvm_destroy_one_plane(struct kvm_plane *plane)
 {
+	int i;
+
+	for (i = 0; i < plane->nr_overlays; i++)
+		if (plane->overlays[i].page)
+			unpin_user_pages_dirty_lock(&plane->overlays[i].page,
+						    1, true);
+	plane->nr_overlays = 0;
+
 #ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
 	xa_destroy(&plane->mem_attrs);
 #endif
@@ -5953,6 +5961,8 @@ static int kvm_vm_ioctl_check_extension_generic(struct kvm *kvm, long arg)
 		 * VM actually has.
 		 */
 		return KVM_MAX_USER_PLANES;
+	case KVM_CAP_PLANE_MEMORY_OVERLAYS:
+		return KVM_PLANE_MAX_OVERLAYS;
 	default:
 		break;
 	}
@@ -6227,6 +6237,265 @@ do {										\
 		     sizeof_field(struct kvm_userspace_memory_region2, field));	\
 } while (0)
 
+struct page *kvm_plane_overlay_page(struct kvm_plane *plane, gfn_t gfn)
+{
+	int i, n = READ_ONCE(plane->nr_overlays);
+
+	/* pairs with the smp_wmb() publishing a new entry */
+	smp_rmb();
+	for (i = 0; i < n; i++) {
+		if (READ_ONCE(plane->overlays[i].gfn) != gfn)
+			continue;
+		/* pairs with the smp_store_release() updating an entry */
+		return smp_load_acquire(&plane->overlays[i].page);
+	}
+	return NULL;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_plane_overlay_page);
+
+unsigned long kvm_plane_overlay_uaddr(struct kvm_plane *plane, gfn_t gfn)
+{
+	int i, n = READ_ONCE(plane->nr_overlays);
+
+	smp_rmb();
+	for (i = 0; i < n; i++) {
+		if (READ_ONCE(plane->overlays[i].gfn) != gfn)
+			continue;
+		/*
+		 * The acquire pairs with the smp_store_release() updating
+		 * an entry: a reader which observes the new page also
+		 * observes the uaddr written before it.
+		 */
+		if (smp_load_acquire(&plane->overlays[i].page))
+			return READ_ONCE(plane->overlays[i].uaddr);
+		return 0;
+	}
+	return 0;
+}
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_plane_overlay_uaddr);
+
+/*
+ * The invalidation window registered around an overlay update must
+ * cover every gfn whose in-flight fault could install a huge leaf
+ * spanning the overlaid gfn, i.e. the naturally-aligned region of the
+ * widest stage-2 huge mapping any plane-capable architecture supports
+ * (a 1GiB page on x86).  A narrower window lets a racing fault on a
+ * neighbouring gfn, which sampled nr_overlays and mmu_invalidate_seq
+ * before the update, pass mmu_invalidate_retry_gfn() and install a
+ * huge SPTE over the overlay after the zap.
+ */
+#define KVM_PLANE_OVERLAY_INVAL_PAGES	(SZ_1G >> PAGE_SHIFT)
+
+static void kvm_plane_overlay_invalidate_add(struct kvm *kvm, gfn_t gfn)
+{
+	gfn_t start = ALIGN_DOWN(gfn, KVM_PLANE_OVERLAY_INVAL_PAGES);
+
+	kvm_mmu_invalidate_range_add(kvm, start,
+				     start + KVM_PLANE_OVERLAY_INVAL_PAGES);
+}
+
+/*
+ * Drop every translation of @gfn, in all address spaces and all planes'
+ * roots.  A huge leaf spanning the gfn intersects the single-page range
+ * and is zapped with it.  Hardware TLBs are not flushed here.
+ */
+static void kvm_plane_overlay_unmap(struct kvm *kvm, gfn_t gfn)
+{
+#ifdef CONFIG_KVM_GENERIC_MMU_NOTIFIER
+	struct kvm_memslot_iter iter;
+	struct kvm_memslots *slots;
+	int i;
+
+	KVM_MMU_LOCK(kvm);
+	for (i = 0; i < kvm_arch_nr_memslot_as_ids(kvm); i++) {
+		slots = __kvm_memslots(kvm, i);
+
+		kvm_for_each_memslot_in_gfn_range(&iter, slots, gfn, gfn + 1) {
+			struct kvm_gfn_range range = {
+				.slot = iter.slot,
+				.start = gfn,
+				.end = gfn + 1,
+				.attr_filter = KVM_FILTER_PRIVATE |
+					       KVM_FILTER_SHARED,
+				.may_block = true,
+			};
+
+			kvm_unmap_gfn_range(kvm, &range);
+		}
+	}
+	KVM_MMU_UNLOCK(kvm);
+#else
+	kvm_arch_flush_shadow_all(kvm);
+#endif
+}
+
+static int kvm_vm_ioctl_set_plane_overlay(struct kvm *kvm,
+					  struct kvm_plane_memory_overlay *ov)
+{
+	struct kvm_plane_overlay *e = NULL;
+	struct page *page = NULL, *old_page = NULL;
+	struct kvm_plane *plane;
+	bool moved = false;
+	gfn_t moved_gfn = 0;
+	int i, r;
+
+	if (ov->flags || ov->plane >= KVM_MAX_PLANES)
+		return -EINVAL;
+	if (ov->uaddr & ~PAGE_MASK)
+		return -EINVAL;
+	/*
+	 * Read under kvm->lock: KVM_CREATE_PLANE publishes and, on its
+	 * error path, unpublishes-and-frees the plane under that lock, so
+	 * a pointer observed here is either NULL or a plane that lives
+	 * until VM teardown.
+	 */
+	scoped_guard(mutex, &kvm->lock)
+		plane = kvm->planes[ov->plane];
+	if (!plane)
+		return -EINVAL;
+
+	if (ov->uaddr) {
+		r = pin_user_pages_fast(ov->uaddr, 1,
+					FOLL_WRITE | FOLL_LONGTERM, &page);
+		if (r != 1)
+			return r < 0 ? r : -EFAULT;
+	}
+
+	mutex_lock(&kvm->slots_lock);
+	for (i = 0; i < plane->nr_overlays; i++) {
+		if (plane->overlays[i].gfn == ov->gfn) {
+			e = &plane->overlays[i];
+			break;
+		}
+	}
+
+	/*
+	 * Removing an overlay which was never installed changes nothing;
+	 * don't zap and flush for it.
+	 */
+	if (!ov->uaddr && !e) {
+		mutex_unlock(&kvm->slots_lock);
+		return 0;
+	}
+
+	/*
+	 * guest_memfd-backed and private gfns have their own backing
+	 * contract which an ordinary pinned user page cannot substitute
+	 * for, and kvm_mmu_faultin_pfn_gmem() does not consult overlays.
+	 * Both the private attribute and the memslot flags are stable
+	 * under slots_lock.
+	 */
+	if (ov->uaddr) {
+		struct kvm_memory_slot *slot = gfn_to_memslot(kvm, ov->gfn);
+
+		if ((slot && kvm_memslot_is_gmem_only(slot)) ||
+		    kvm_is_private_gfn(kvm, ov->gfn)) {
+			mutex_unlock(&kvm->slots_lock);
+			unpin_user_page(page);
+			return -EINVAL;
+		}
+	}
+
+	if (ov->uaddr) {
+		if (!e) {
+			if (plane->nr_overlays >= KVM_PLANE_MAX_OVERLAYS) {
+				mutex_unlock(&kvm->slots_lock);
+				unpin_user_page(page);
+				return -ENOSPC;
+			}
+			e = &plane->overlays[plane->nr_overlays];
+			e->gfn = ov->gfn;
+			e->uaddr = ov->uaddr;
+			e->page = page;
+			/*
+			 * Publish the fully-initialised entry before
+			 * raising the count; pairs with the smp_rmb() in
+			 * the lockless readers.
+			 */
+			smp_wmb();
+			WRITE_ONCE(plane->nr_overlays, plane->nr_overlays + 1);
+		} else {
+			old_page = e->page;
+			WRITE_ONCE(e->uaddr, ov->uaddr);
+			/*
+			 * Order the uaddr store before the page store; a
+			 * reader which acquires the new page must see the
+			 * uaddr it belongs to.
+			 */
+			smp_store_release(&e->page, page);
+		}
+	} else if (e) {
+		struct kvm_plane_overlay *tail =
+			&plane->overlays[plane->nr_overlays - 1];
+
+		old_page = e->page;
+		WRITE_ONCE(e->page, NULL);
+		WRITE_ONCE(e->uaddr, 0);
+
+		/*
+		 * Reclaim the slot: move the tail entry into the vacated
+		 * one and shrink the array.  A lockless reader scanning
+		 * with the old count can miss the moved entry entirely
+		 * (it may already have passed the vacated slot), so the
+		 * moved gfn is added to the invalidation window below and
+		 * any such in-flight fault retries.  The cleared tail is
+		 * harmless to a stale-count reader: the live copy sits at
+		 * a lower index and is found first.
+		 */
+		if (e != tail) {
+			moved = true;
+			moved_gfn = tail->gfn;
+			WRITE_ONCE(e->gfn, tail->gfn);
+			WRITE_ONCE(e->uaddr, tail->uaddr);
+			/* pairs with smp_load_acquire() in the readers */
+			smp_store_release(&e->page, tail->page);
+		}
+		WRITE_ONCE(plane->nr_overlays, plane->nr_overlays - 1);
+		WRITE_ONCE(tail->page, NULL);
+		WRITE_ONCE(tail->uaddr, 0);
+		WRITE_ONCE(tail->gfn, 0);
+	}
+	/*
+	 * Bump the invalidation sequence across the update and zap: a
+	 * concurrent fault resolves the overlay pfn locklessly before
+	 * taking mmu_lock, and without a sequence change
+	 * is_page_fault_stale() would let it install an SPTE for the OLD
+	 * backing after the zap, mapping a page this function is about
+	 * to unpin.
+	 */
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_start(kvm);
+	kvm_plane_overlay_invalidate_add(kvm, ov->gfn);
+	if (moved)
+		kvm_plane_overlay_invalidate_add(kvm, moved_gfn);
+	KVM_MMU_UNLOCK(kvm);
+
+	mutex_unlock(&kvm->slots_lock);
+
+	/*
+	 * Drop any translation mapping the old or new backing.  The unmap
+	 * removes the SPTEs but does not flush hardware TLBs: a vCPU that
+	 * mapped the gfn before the update still holds a translation to
+	 * the old backing in its TLB (tagged by the live ASID on SVM,
+	 * which nothing else invalidates).  Flush before the old page is
+	 * unpinned: KVM_REQ_TLB_FLUSH is a per-plane request, so the
+	 * fan-out in kvm_make_vcpu_request() reaches every plane twin and
+	 * each flushes its own hardware context.
+	 */
+	kvm_plane_overlay_unmap(kvm, ov->gfn);
+	if (moved)
+		kvm_plane_overlay_unmap(kvm, moved_gfn);
+	kvm_flush_remote_tlbs(kvm);
+
+	KVM_MMU_LOCK(kvm);
+	kvm_mmu_invalidate_end(kvm);
+	KVM_MMU_UNLOCK(kvm);
+
+	if (old_page)
+		unpin_user_pages_dirty_lock(&old_page, 1, true);
+	return 0;
+}
+
 static long kvm_vm_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -6237,6 +6506,15 @@ static long kvm_vm_ioctl(struct file *filp,
 	if (kvm->mm != current->mm || kvm->vm_dead)
 		return -EIO;
 	switch (ioctl) {
+	case KVM_SET_PLANE_MEMORY_OVERLAY: {
+		struct kvm_plane_memory_overlay ov;
+
+		r = -EFAULT;
+		if (copy_from_user(&ov, argp, sizeof(ov)))
+			goto out;
+		r = kvm_vm_ioctl_set_plane_overlay(kvm, &ov);
+		break;
+	}
 	case KVM_CREATE_PLANE:
 		r = kvm_vm_ioctl_create_plane(kvm, arg);
 		break;
-- 
2.50.1

