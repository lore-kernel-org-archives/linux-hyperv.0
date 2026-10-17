Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5F448122C;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239913; cv=none; b=YrJKAEmlLwHOzkDVryn1hEIENSHlJWI26KcqH3740joFWAbYwDiRJ8TsGhqOOa6PUcQlsNF3T2NeAR6omfxYSd92UTmrF0P5erqadk60oPkVW6I985igYu5i0OuGjabJPI2+LdwxoywJ5/v8XNFp4tAeYE3qC8aLYIOsEflgRsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239913; c=relaxed/simple;
	bh=6jhzkZYrPTlFh6StAmVRaHPvasTc1nBDl5YovxkhW3k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYbZmBWIcV1inCgOTvg2+TgxDNfXXKEq7pjaXrm87XLgEyHhOPuWIo/MkSUK8S1c09EX9d5+XCvsx5agx5Q0dDBwhBgOeuZoekzOaMx6vhftRzZBiT66NQx9nIENHU7H5smkHgyr5G4kEF7LINntFoYHELJhXih/ucBpVzmq2X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ahs/bZq+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ahs/bZq+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=Lkg5cZBKVebJPiQrCEG0WiJDrka8E6YMhfLLBbhY5s0=; b=Ahs/bZq+w8zuDk3nOzXBcRSsw/
	RcAC7d1F1fqpSIcYEMRDudse8NC+8Axg/lCrxfj+BW4T6PFE5QCQgPUGiUY4QE31xZlLToM82OKQ6
	6PdnZLlRVgNFR9kcQ7sCFYeFw2OyhdI2T4ouKa4V2rixO9UPmRkuBqbeXGZAdp9XeFLRCgTDGgjRY
	0fzs+04bs7i8FBcsRhhc0cX2lcI/N8W5e7DkbOGYiTZXxD4fYcCepHKN96duBL15Pbbe0OoPourYs
	x1mKE+njplVv/rP8oyz8YlpkmASpHHb0uVK389gEmisZXXDif74XrdTVSVhtYSQ+0ZYPUjNgGoPPu
	n2/J+8IQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCJ-2gVR;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Yle-1tOd;
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
Subject: [RFC PATCH 13/55] KVM: implement per-plane memory attributes
Date: Sat, 17 Oct 2026 13:24:19 +0100
Message-ID: <20261017122501.610248-14-dwmw2@infradead.org>
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

Memory attributes lived solely on struct kvm and the page role carried
no plane identity, so every plane shared one attribute array and one
set of TDP roots. A VTL1 guest protecting VTL0 pages therefore revoked
its *own* access too: the Windows secure kernel's first
HvCallModifyVtlProtectionMask made its own hypercall page
non-executable, and the next VTL transition died on an unhandled
protection fault.

Give each non-zero plane its own attribute xarray (plane 0 keeps
kvm->mem_attrs, which also carries partition-wide attributes such as
KVM_MEMORY_ATTRIBUTE_PRIVATE), accept KVM_SET_MEMORY_ATTRIBUTES on
plane fds restricted to the NR/NW/NX protection bits, and add the
plane to kvm_mmu_page_role so each plane builds its own roots with its
own protections applied at fault time.

Guest accesses are checked against the attributes of the plane doing
the accessing, not plane 0's: the vCPU-context hva lookups,
kvm_vcpu_map(), the guest page read/write helpers (which gain a
kvm_plane argument; the VM-level variants keep checking plane 0), and
the software page walker's PTE reads. Without that, a higher plane is
refused access to pages it has itself protected against plane 0 — the
secure kernel's VP assist page registration and the page walks through
its own protected page tables both fail exactly there.

Hugepage mixed-attribute tracking still follows plane 0 only; faults
on other planes clamp to 4KiB whenever the plane carries any attribute
within the maximal mapping range.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h |   2 +-
 arch/x86/kvm/mmu/mmu.c          |  78 +++++++++++----
 arch/x86/kvm/mmu/paging_tmpl.h  |   4 +-
 include/linux/kvm_host.h        |  52 ++++++++++
 virt/kvm/kvm_main.c             | 172 +++++++++++++++++++++++++-------
 5 files changed, 251 insertions(+), 57 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 05670b5ae28a..17dfd232ba58 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -366,7 +366,7 @@ union kvm_mmu_page_role {
 		unsigned guest_mode:1;
 		unsigned passthrough:1;
 		unsigned is_mirror:1;
-		unsigned :4;
+		unsigned plane:4;
 
 		/*
 		 * This is left at the top of the word so that
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index d94c34af52ee..177b2e71bf35 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3143,7 +3143,9 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 		return false;
 
 	for (i = 0; i < nr_pages; i++, gfn++, sptep++) {
-		if (kvm_get_memory_attributes(vcpu->kvm, gfn)) {
+		if (kvm_get_memory_attributes(vcpu->kvm, gfn) ||
+		    (vcpu->plane_level &&
+		     kvm_plane_get_memory_attributes(vcpu->plane, gfn))) {
 			kvm_release_page_clean(pages[i]);
 			continue;
 		}
@@ -4626,7 +4628,7 @@ static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned int access = ACC_ALL | ACC_READ_MASK;
-	unsigned long attrs = kvm_get_memory_attributes(kvm, gfn);
+	unsigned long attrs = kvm_plane_get_memory_attributes(vcpu->plane, gfn);
 	if (!attrs)
 		return access;
 
@@ -4651,6 +4653,19 @@ static int kvm_faultin_memory_protections(struct kvm_vcpu *vcpu,
 	if (unlikely(!fault->slot))
 		return RET_PF_CONTINUE;
 
+	/*
+	 * Hugepage mixed-attribute tracking only covers plane 0; clamp
+	 * non-zero-plane faults to 4KiB when the plane carries any attribute
+	 * in the largest possible mapping range.
+	 */
+	if (vcpu->plane_level && fault->max_level > PG_LEVEL_4K) {
+		gfn_t base = gfn_round_for_level(fault->gfn, fault->max_level);
+
+		if (kvm_plane_range_has_any_attrs(vcpu->plane, base,
+				base + KVM_PAGES_PER_HPAGE(fault->max_level)))
+			fault->max_level = PG_LEVEL_4K;
+	}
+
 	access = kvm_get_gfn_protections(vcpu, fault->gfn);
 	if (access == (ACC_ALL | ACC_READ_MASK))
 		return RET_PF_CONTINUE;
@@ -5783,6 +5798,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.base.guest_mode = is_guest_mode(vcpu);
 	role.ext.valid = 1;
 
+	role.base.plane = vcpu->plane_level;
+
 	if (!____is_cr0_pg(regs)) {
 		role.base.direct = 1;
 		return role;
@@ -5868,6 +5885,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.level = kvm_mmu_get_tdp_level(vcpu);
 	role.direct = true;
 	role.has_4_byte_gpte = false;
+	role.plane = vcpu->plane_level;
 
 	return role;
 }
@@ -5991,6 +6009,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	role.base.ad_disabled = !accessed_dirty;
 	role.base.guest_mode = true;
 	role.base.access = ACC_ALL;
+	role.base.plane = vcpu->plane_level;
 
 	role.ext.word = 0;
 	role.ext.execonly = execonly;
@@ -8113,12 +8132,36 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
 	return true;
 }
 
+/*
+ * There are special considerations when applying a memory protection
+ * attribute against a page containing guest PTEs, because virtual
+ * addresses that require traversing that page need to fault.
+ *
+ * When using shadow paging, the PTEs that the CPU actually walks
+ * do not have any information about attributes (unlike TDP where
+ * the attributes become part of the TDP permission bits).  Since
+ * this should be a rare occasion, just invalidate all the mmu roots
+ * if shadow paging is in use and attributes do cover a guest PTE.
+ */
+static bool kvm_mmu_zap_if_gpte_page(struct kvm *kvm,
+				     struct kvm_gfn_range *range)
+{
+	struct kvm_mmu_page *sp;
+
+	for (gfn_t gfn = range->start; gfn < range->end; gfn++) {
+		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
+			__kvm_mmu_zap_all_fast_front_half(kvm);
+			return false;
+		}
+	}
+	return false;
+}
+
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range)
 {
 	unsigned long attrs = range->arg.attributes;
 	struct kvm_memory_slot *slot = range->slot;
-	struct kvm_mmu_page *sp;
 	int level;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -8175,24 +8218,21 @@ bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 		}
 	}
 
+	return kvm_mmu_zap_if_gpte_page(kvm, range);
+}
+
+bool kvm_arch_post_set_plane_memory_attributes(struct kvm *kvm,
+					       struct kvm_gfn_range *range)
+{
+	lockdep_assert_held_write(&kvm->mmu_lock);
+	lockdep_assert_held(&kvm->slots_lock);
+
 	/*
-	 * There are special considerations when applying an memory protection
-	 * attibute against a page containing guest PTEs, because virtual
-	 * addresses that requires traversing that page need to fault.
-	 *
-	 * When using shadow paging, the PTEs that the CPU actually walks
-	 * do not have any information about attributes (unlike TDP where
-	 * the attributes become part of the TDP permission bits).  Since
-	 * this should be a rare occasion, just invalidate all the mmu roots
-	 * if shadow paging is in use and attributes do cover a guest PTE.
+	 * Non-zero planes get no hugepage mixed-attribute tracking (their
+	 * faults are clamped to 4KiB while attributes are present); only
+	 * the shadow-paging gPTE invalidation applies.
 	 */
-	for (gfn_t gfn = range->start; gfn < range->end; gfn++) {
-		for_each_gfn_valid_sp_with_gptes(kvm, sp, gfn) {
-			__kvm_mmu_zap_all_fast_front_half(kvm);
-			return false;
-		}
-	}
-	return false;
+	return kvm_mmu_zap_if_gpte_page(kvm, range);
 }
 
 void kvm_arch_post_set_memory_attributes_unlocked(struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index e48b8db54961..78d1e5c9fbe4 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -403,13 +403,13 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(kvm_is_error_hva(host_addr)))
 			goto error;
 
-		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(real_gpa))) {
+		if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gpa_to_gfn(real_gpa))) {
 			walker->memory_attributes_fault = true;
 			walker->gfn = gpa_to_gfn(real_gpa);
 			goto error;
 		}
 
-		if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))
+		if (!kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gpa_to_gfn(real_gpa)))
 			walker->pte_writable[walker->level - 1] = false;
 
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5bdae2127578..7071ff74d4ea 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -884,6 +884,16 @@ struct kvm_plane {
 	/* Per-Plane VCPU array */
 	struct xarray vcpu_array;
 
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	/*
+	 * Per-plane memory attributes, used only for non-zero planes.
+	 * Plane 0's attributes live in kvm->mem_attrs, which also carries
+	 * partition-wide attributes such as KVM_MEMORY_ATTRIBUTE_PRIVATE.
+	 * Protected by slots_lock (for writes) and RCU (for reads).
+	 */
+	struct xarray mem_attrs;
+#endif
+
 	struct kvm_arch_plane arch;
 };
 
@@ -2736,6 +2746,18 @@ static inline unsigned long kvm_get_memory_attributes(struct kvm *kvm, gfn_t gfn
 	return xa_to_value(xa_load(&kvm->mem_attrs.array, gfn));
 }
 
+static inline struct xarray *kvm_plane_mem_attr_array(struct kvm_plane *plane)
+{
+	return plane->level ? &plane->mem_attrs :
+			      &plane->kvm->mem_attrs.array;
+}
+
+static inline unsigned long kvm_plane_get_memory_attributes(struct kvm_plane *plane,
+							    gfn_t gfn)
+{
+	return xa_to_value(xa_load(kvm_plane_mem_attr_array(plane), gfn));
+}
+
 static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 {
 	RCU_LOCKDEP_WARN(!lockdep_is_held(&kvm->slots_lock) &&
@@ -2752,12 +2774,21 @@ static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 
 bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 				     unsigned long mask, unsigned long attrs);
+bool kvm_plane_range_has_any_attrs(struct kvm_plane *plane, gfn_t start,
+				   gfn_t end);
 bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 					unsigned long mask);
 bool kvm_arch_pre_set_memory_attributes(struct kvm *kvm,
 					struct kvm_gfn_range *range);
 bool kvm_arch_post_set_memory_attributes(struct kvm *kvm,
 					 struct kvm_gfn_range *range);
+/*
+ * As kvm_arch_post_set_memory_attributes(), but for an update of a
+ * non-zero plane's attributes, which has no hugepage mixed-attribute
+ * tracking to maintain.
+ */
+bool kvm_arch_post_set_plane_memory_attributes(struct kvm *kvm,
+					       struct kvm_gfn_range *range);
 void kvm_arch_post_set_memory_attributes_unlocked(struct kvm *kvm);
 bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs);
 u64 kvm_supported_mem_attributes(struct kvm *kvm);
@@ -2810,6 +2841,27 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
 	return kvm_mem_attributes_may_write(attrs);
 }
 
+/*
+ * vCPU-context accesses are checked against the vCPU's own plane's
+ * memory attributes: a higher plane is not subject to the protections
+ * it imposes on a lower plane's view of a page.
+ */
+static inline int kvm_vcpu_mem_attributes_may_read_gfn(struct kvm_vcpu *vcpu,
+							gfn_t gfn)
+{
+	unsigned long attrs = kvm_plane_get_memory_attributes(vcpu->plane, gfn);
+
+	return kvm_mem_attributes_may_read(attrs);
+}
+
+static inline int kvm_vcpu_mem_attributes_may_write_gfn(struct kvm_vcpu *vcpu,
+							 gfn_t gfn)
+{
+	unsigned long attrs = kvm_plane_get_memory_attributes(vcpu->plane, gfn);
+
+	return kvm_mem_attributes_may_write(attrs);
+}
+
 static inline bool kvm_range_has_rw_memory_protections(struct kvm *kvm,
 						       gfn_t start, gfn_t end)
 {
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 2d2dc7828e1f..ef23ee3ce04a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1231,6 +1231,9 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 	plane->level = plane_level;
 
 	xa_init(&plane->vcpu_array);
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_init(&plane->mem_attrs);
+#endif
 
 	if (kvm_arch_plane_init(kvm, plane, plane_level))
 		goto out_free_plane;
@@ -1247,6 +1250,9 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 
 static void kvm_destroy_one_plane(struct kvm_plane *plane)
 {
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	xa_destroy(&plane->mem_attrs);
+#endif
 	kvm_arch_plane_destroy(plane);
 	kvm_free_plane(plane);
 }
@@ -2646,6 +2652,28 @@ bool kvm_range_has_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	return true;
 }
 
+/* Returns true if _any_ gfn in [@start, @end) has any attribute in @plane. */
+bool kvm_plane_range_has_any_attrs(struct kvm_plane *plane, gfn_t start,
+				   gfn_t end)
+{
+	XA_STATE(xas, kvm_plane_mem_attr_array(plane), start);
+	void *entry;
+
+	guard(rcu)();
+	xas_for_each(&xas, entry, end - 1) {
+		if (xas_retry(&xas, entry))
+			continue;
+		/*
+		 * Only count real attribute values: xa_reserve()
+		 * placeholders from an in-flight (or failed) attribute
+		 * update are not attributes.
+		 */
+		if (xa_is_value(entry))
+			return true;
+	}
+	return false;
+}
+
 /*
  * Returns true if _any_ gfns in the range [@start, @end) have attributes that
  * match _any_ bit in @mask.
@@ -2679,7 +2707,28 @@ bool kvm_range_has_any_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end
 	return false;
 }
 
-static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
+/*
+ * Returns true if _any_ gfn in [@start, @end) has attributes matching
+ * _any_ bit in @mask in @plane's attribute array.
+ */
+static bool kvm_plane_range_has_memory_attributes(struct kvm_plane *plane,
+						  gfn_t start, gfn_t end,
+						  unsigned long mask)
+{
+	XA_STATE(xas, kvm_plane_mem_attr_array(plane), start);
+	void *entry;
+
+	guard(rcu)();
+	xas_for_each(&xas, entry, end - 1) {
+		if (xas_retry(&xas, entry))
+			continue;
+		if (xa_is_value(entry) && (xa_to_value(entry) & mask))
+			return true;
+	}
+	return false;
+}
+
+static bool kvm_range_memory_attributes_need_sync(struct kvm_plane *plane,
 						  gfn_t start, gfn_t end,
 						  unsigned long attributes)
 {
@@ -2688,7 +2737,7 @@ static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
 	if (attributes & mask)
 		return true;
 
-	return kvm_range_has_any_memory_attributes(kvm, start, end, mask);
+	return kvm_plane_range_has_memory_attributes(plane, start, end, mask);
 }
 
 static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
@@ -2763,9 +2812,11 @@ static bool kvm_pre_set_memory_attributes(struct kvm *kvm,
 }
 
 /* Set @attributes for the gfn range [@start, @end). */
-static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attributes)
+static int kvm_plane_set_mem_attributes(struct kvm_plane *plane, gfn_t start,
+					gfn_t end, unsigned long attributes)
 {
+	struct kvm *kvm = plane->kvm;
+	struct xarray *attr_array = kvm_plane_mem_attr_array(plane);
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
 		.end = end,
@@ -2791,13 +2842,17 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	entry = attributes ? xa_mk_value(attributes) : NULL;
 
+	if (plane->level)
+		post_set_range.handler = kvm_arch_post_set_plane_memory_attributes;
+
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range has the desired attributes. */
-	if (kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
+	if (!plane->level &&
+	    kvm_range_has_memory_attributes(kvm, start, end, ~0, attributes))
 		goto out_unlock;
 
-	sync = kvm_range_memory_attributes_need_sync(kvm, start, end,
+	sync = kvm_range_memory_attributes_need_sync(plane, start, end,
 						     attributes);
 
 	trace_kvm_vm_set_mem_attributes(start, end, attributes, sync,
@@ -2808,9 +2863,19 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * partway through setting the new attributes.
 	 */
 	for (i = start; i < end; i++) {
-		r = xa_reserve(&kvm->mem_attrs.array, i, GFP_KERNEL_ACCOUNT);
-		if (r)
+		r = xa_reserve(attr_array, i, GFP_KERNEL_ACCOUNT);
+		if (r) {
+			/*
+			 * Nothing was stored yet; drop the reservations
+			 * already made so they don't sit in the array
+			 * (and pin their nodes) for the VM's lifetime.
+			 * xa_release() only removes reserved entries, so
+			 * pre-existing attribute values are untouched.
+			 */
+			while (i-- > start)
+				xa_release(attr_array, i);
 			goto out_unlock;
+		}
 
 		cond_resched();
 	}
@@ -2818,8 +2883,7 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	found_memslot = kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
-				    GFP_KERNEL_ACCOUNT));
+		r = xa_err(xa_store(attr_array, i, entry, GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
 		cond_resched();
 	}
@@ -2829,6 +2893,15 @@ static int kvm_vm_set_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 			  kvm->mem_attrs.generation + 1);
 
 	if (found_memslot) {
+		/*
+		 * The post-set handler differs by plane: hugepage
+		 * mixed-attribute tracking only follows plane 0's
+		 * attributes (faults on other planes with attributes
+		 * present are clamped to 4KiB mappings instead), but the
+		 * shadow-paging invalidation of mappings through
+		 * attribute-covered guest page tables is needed on every
+		 * plane.
+		 */
 		kvm_handle_gfn_range(kvm, &post_set_range);
 		KVM_MMU_LOCK(kvm);
 		kvm_mmu_invalidate_end(kvm);
@@ -2850,6 +2923,16 @@ bool __weak kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned lon
 	return false;
 }
 
+/*
+ * Only reachable on architectures which support planes; those provide a
+ * real implementation.
+ */
+bool __weak kvm_arch_post_set_plane_memory_attributes(struct kvm *kvm,
+						      struct kvm_gfn_range *range)
+{
+	return false;
+}
+
 bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
 {
 	if (attrs & ~kvm_supported_mem_attributes(kvm))
@@ -2862,9 +2945,10 @@ bool kvm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
 	return true;
 }
 
-static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
+static int kvm_vm_ioctl_set_mem_attributes(struct kvm_plane *plane,
 					   struct kvm_memory_attributes *attrs)
 {
+	struct kvm *kvm = plane->kvm;
 	gfn_t start, end;
 
 	/* flags is currently not used. */
@@ -2872,6 +2956,10 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 		return -EINVAL;
 	if (!kvm_mem_attributes_valid(kvm, attrs->attributes))
 		return -EINVAL;
+	/* Partition-wide attributes have no meaning on a non-zero plane. */
+	if (plane->level &&
+	    (attrs->attributes & ~(unsigned long)KVM_MEMORY_ATTRIBUTE_PROT))
+		return -EINVAL;
 	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
 		return -EINVAL;
 	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
@@ -2887,7 +2975,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 	 */
 	BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
 
-	return kvm_vm_set_mem_attributes(kvm, start, end, attrs->attributes);
+	return kvm_plane_set_mem_attributes(plane, start, end,
+					    attrs->attributes);
 }
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
 
@@ -3024,17 +3113,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(gfn_to_hva);
 
 unsigned long kvm_vcpu_gfn_to_hva(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
-	struct kvm *kvm = vcpu->kvm;
 	unsigned long addr;
 
 	addr = gfn_to_hva_many(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return addr;
 
-	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+	if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn))
 		return KVM_HVA_ERR_BAD;
 
-	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+	if (!kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn))
 		return KVM_HVA_ERR_RO_BAD;
 
 	return addr;
@@ -3087,10 +3175,10 @@ unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *w
 	if (kvm_is_error_hva(addr))
 		return addr;
 
-	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
+	if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn))
 		return KVM_HVA_ERR_BAD;
 
-	if (writable && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+	if (writable && !kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn))
 		*writable = false;
 
 	return addr;
@@ -3431,9 +3519,9 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 		.pin = true,
 	};
 
-	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
+	if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn))
 		return -EFAULT;
-	if (writable && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+	if (writable && !kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn))
 		return -EFAULT;
 
 	map->pinned_page = NULL;
@@ -3496,7 +3584,8 @@ static int next_segment(unsigned long len, int offset)
 }
 
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
-static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+static int __kvm_read_guest_page(struct kvm_plane *plane,
+				 struct kvm_memory_slot *slot,
 				 gfn_t gfn, void *data, int offset, int len,
 				 unsigned long attr)
 {
@@ -3511,7 +3600,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 
-	attrs = kvm_get_memory_attributes(kvm, gfn);
+	attrs = kvm_plane_get_memory_attributes(plane, gfn);
 	if (attrs & attr)
 		return -EFAULT;
 
@@ -3526,8 +3615,8 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len,
-				     KVM_MEMORY_ATTRIBUTE_NR);
+	return __kvm_read_guest_page(kvm->planes[0], slot, gfn, data, offset,
+				     len, KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3536,8 +3625,8 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
-				     KVM_MEMORY_ATTRIBUTE_NR);
+	return __kvm_read_guest_page(vcpu->plane, slot, gfn, data, offset,
+				     len, KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3546,8 +3635,8 @@ int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
-				     KVM_MEMORY_ATTRIBUTE_NX);
+	return __kvm_read_guest_page(vcpu->plane, slot, gfn, data, offset,
+				     len, KVM_MEMORY_ATTRIBUTE_NX);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_fetch_guest_page);
 
@@ -3591,7 +3680,7 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest);
 
-static int __kvm_read_guest_atomic(struct kvm *kvm,
+static int __kvm_read_guest_atomic(struct kvm_plane *plane,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
 				   void *data, int offset, unsigned long len)
 {
@@ -3601,7 +3690,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm,
 	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
 		return -EFAULT;
 
-	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+	if (!kvm_mem_attributes_may_read(kvm_plane_get_memory_attributes(plane, gfn)))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3622,12 +3711,12 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->plane, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
 /* Copy @len bytes from @data into guest memory at '(@gfn * PAGE_SIZE) + @offset' */
-static int __kvm_write_guest_page(struct kvm *kvm,
+static int __kvm_write_guest_page(struct kvm_plane *plane, struct kvm *kvm,
 				  struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
@@ -3641,7 +3730,7 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 
-	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+	if (!kvm_mem_attributes_may_write(kvm_plane_get_memory_attributes(plane, gfn)))
 		return -EFAULT;
 
 	r = __copy_to_user((void __user *)addr + offset, data, len);
@@ -3656,7 +3745,8 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(kvm->planes[0], kvm, slot, gfn, data,
+				      offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest_page);
 
@@ -3665,7 +3755,8 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(vcpu->plane, vcpu->kvm, slot, gfn, data,
+				      offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_write_guest_page);
 
@@ -5182,6 +5273,17 @@ static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsig
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
+#ifdef CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES
+	case KVM_SET_MEMORY_ATTRIBUTES: {
+		void __user *argp = (void __user *)arg;
+		struct kvm_memory_attributes attrs;
+
+		if (copy_from_user(&attrs, argp, sizeof(attrs)))
+			return -EFAULT;
+		r = kvm_vm_ioctl_set_mem_attributes(plane, &attrs);
+		break;
+	}
+#endif
 	default:
 		r = -ENOTTY;
 	}
@@ -5926,7 +6028,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		if (copy_from_user(&attrs, argp, sizeof(attrs)))
 			goto out;
 
-		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
+		r = kvm_vm_ioctl_set_mem_attributes(kvm->planes[0], &attrs);
 		break;
 	}
 #endif /* CONFIG_KVM_GENERIC_MEMORY_ATTRIBUTES */
-- 
2.50.1

