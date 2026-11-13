Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594896;
	b=TuH75PmmAZZHDVtgNgyyuNlTwHzxa9lbKySftvuuyeeDyro9KaZY66kBjE9PuGcFtQRx
	 o5Clz5rkqO1vxuYQ1fgcXmksfDjo4Ng7uTb10r4TA7r3BV84sl0Ky1oIAyBor5JSmLJoW
	 ys3jZaHCC6JxLPVXLPHRr+kB9vXdvGEjZG0rTZ8ptHCs52P9zvRt9y+99kUviCokDgNoV
	 i63a/JBYvZseCy2EKVnfbk0suhsSnimXuLZV3ERvuF6b5GjzLBY2QbV9ykXXBHxBgbgSc
	 F21Bv1P96KaMRBKYxzc7TIrHNvZN8a+VGMQvbgblJgVEdVAyzFmpxxXjxfjBEm8GMig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=u4h+WdEok1WAfCZ1w/fvmpBfwwG2V/AHupGr6OofkmE=;
	b=HhNg6dahQCDa1yngjil7AJtCjOL7cpAqPJLW0PkjxWOlTD2oAstlBPoJCsSXO/tJw843
	 1lrWMXzNZjodo2lgl0F5RQvGUNK8uJKvb4Qjv7yrV6Gc0eOIFADnt/lFrOJKq3WRWIrFS
	 aMqx94W+k3JrgSLX70P3P5FrE8736aytVcHgmk61/7NyIi60+zDZMcz/6lsySsUc7Bxpl
	 G83KVSzqiWeLxb84FhexVbJnGnFQ3Fxkwk4CU36XJ3A+jdDpjhWvgcLwyYmUsM+p9MkSp
	 SQs9q1dJLRs1ZFsMPF9NQnyzVX/bhtnrhU/5/vbSGK/8GRYjUufUuemjQc3hMIxgtKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Rg3YCRnS;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66A360A5BC9;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B66A360A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Rg3YCRnS
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=u4h+WdEok1WAfCZ1w/fvmpBfwwG2V/AHupGr6OofkmE=; b=Rg3YCRnStE7JZEzZeXhYb+JMwu
	89pH9rd6Ugo1QOnkzSRrfVEKTJuVs4j5WV3u7faG5eVeJJPpNHmbW17tTxKsjA/YM/3KT6sWGTBe+
	awJ8DbbDtY0deGNIu2J4uNbyKwGT+iY6LEmJjJmkxOXzeVLvNvy3dq9JXvtOWcs1LfOpIP5rcvv8i
	8zqqwXfiOXAtV8F7XKEzuoLADsWlRsw4MiyqlyBzUXKFaOV3jDp5RV2DUTaY3CNI+gCimmVEBRKtu
	Ii1azPiEZrJc/1x19MiUd8Sd0USOgfXhQ2xgwDK9sDjPVzBdbioCFG1h+4BrLtn8tmKstF5XUkGPf
	CjvumV1Q==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bezx-3A1w;
	Fri, 13 Nov 2026 18:34:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LsX-0LiW;
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
Subject: [RFC PATCH v2 01/31] KVM: Implement per-plane memory attributes
Date: Fri, 13 Nov 2026 18:34:17 +0000
Message-ID: <20261113183448.84094-2-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Memory attributes lived solely on struct kvm and the page role carried
no plane identity, so every plane shared one attribute array and one
set of TDP roots. A VTL1 guest protecting VTL0 pages therefore revoked
its *own* access too: the Windows secure kernel's first
HvCallModifyVtlProtectionMask made its own hypercall page
non-executable, and the next VTL transition died on an unhandled
protection fault.

Give each non-zero plane its own attribute xarray. Plane 0 keeps
kvm->mem_attrs, which also carries partition-wide attributes such as
KVM_MEMORY_ATTRIBUTE_PRIVATE. KVM_SET_MEMORY_ATTRIBUTES is accepted on
plane fds, restricted to the NR/NW/NX protection bits, and the plane
joins kvm_mmu_page_role so each plane builds its own roots with its own
protections applied at fault time.

Guest accesses are checked against the attributes of the plane doing
the access, not plane 0's:

 - the vCPU-context hva lookups and kvm_vcpu_map();
 - the guest page read/write helpers, which gain a kvm_plane argument
   (the VM-level variants keep checking plane 0);
 - the software page walker's PTE reads;
 - the emulator's memory-fault classification (an access its own plane
   protects becomes KVM_EXIT_MEMORY_FAULT, not MMIO) and its instruction
   fetch NX check;
 - the slow-form Hyper-V hypercall inputs (TLB flush, send IPI and the
   sparse VP sets and flush entries they read) and the pvclock wall
   clock written by an MSR, all of which run with the issuing vCPU at
   hand and so switch from kvm_read_guest()/kvm_write_guest() to the
   vCPU variants.

Without that, a higher plane is refused access to pages it has itself
protected against plane 0; the secure kernel's VP assist page
registration and the walks through its own protected page tables both
fail exactly there.

Cached gfn->hva translations (gfn_to_hva_cache and pfncache, used for
steal time, PV EOI and pvclock) have no plane context at use time, so
they are refused when *any* plane protects the range with NR or NW.

Hugepage mixed-attribute tracking still follows plane 0 only. Faults
on other planes clamp to 4KiB whenever the plane carries any attribute
within the maximal mapping range, and TDP MMU huge-page recovery skips
their roots, so a recovered 2MiB or 1GiB SPTE cannot lift a 4KiB
protection on a neighbouring gfn.

The plane arrays are memcg-accounted like plane 0's. An attribute update
that fails part-way now releases the xa_reserve() placeholders it left
behind, on the VM fd as well as on plane fds, so a failed update cannot
look like an attribute to the range lookups.

role.smm gives up its eighth bit to make room for role.plane. It
only had a whole byte to be faster to load, and it stays at the top
of the word so kvm_memslots_for_spte_role() still extracts it with a
shift.

Mushahid Hussain supplied the !KVM_GENERIC_MEMORY_ATTRIBUTES stub of
kvm_plane_get_memory_attributes() that keeps the other architectures
building.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  |  10 +-
 arch/x86/include/asm/kvm_host.h |  20 ++--
 arch/x86/kvm/hyperv.c           |  35 +++---
 arch/x86/kvm/mmu/mmu.c          |  78 ++++++++++---
 arch/x86/kvm/mmu/paging_tmpl.h  |   4 +-
 arch/x86/kvm/mmu/tdp_mmu.c      |  14 ++-
 arch/x86/kvm/msrs.c             |  20 ++--
 arch/x86/kvm/x86.c              |   3 +-
 include/linux/kvm_host.h        |  67 +++++++++++
 virt/kvm/kvm_main.c             | 199 +++++++++++++++++++++++++-------
 virt/kvm/pfncache.c             |   3 +-
 11 files changed, 355 insertions(+), 98 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index caf6a959135e..d83275cc189e 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6468,7 +6468,7 @@ Returns -EINVAL if called on a protected VM.
 
 :Capability: KVM_CAP_MEMORY_ATTRIBUTES
 :Architectures: x86
-:Type: vm ioctl
+:Type: vm ioctl (all planes)
 :Parameters: struct kvm_memory_attributes (in)
 :Returns: 0 on success, <0 on error
 
@@ -6517,6 +6517,14 @@ time are:
  - KVM_MEMORY_ATTRIBUTE_PRIVATE - Which marks the associated gfn as being guest
    private memory.
 
+On the fd of a plane other than plane 0, the attributes apply to that plane
+only, and only KVM_MEMORY_ATTRIBUTE_NR, KVM_MEMORY_ATTRIBUTE_NW and
+KVM_MEMORY_ATTRIBUTE_NX are accepted; any other bit fails with -EINVAL.
+Partition-wide attributes such as KVM_MEMORY_ATTRIBUTE_PRIVATE are set on
+the VM fd.  Huge pages follow plane 0's attributes only: a fault on another
+plane is mapped with 4KiB pages wherever that plane has any attribute in the
+range.
+
 Note, there is no "get" API.  Userspace is responsible for explicitly tracking
 the state of a gfn/page as needed.
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 55b8cee894f7..69c32ce22b56 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -324,11 +324,11 @@ extern struct kvm_host_values kvm_host;
  * the number of unique SPs that can theoretically be created is 2^n, where n
  * is the number of bits that are used to compute the role.
  *
- * But, even though there are 21 bits in the mask below, not all combinations
+ * But, even though there are 25 bits in the mask below, not all combinations
  * of modes and flags are possible:
  *
  *   - invalid shadow pages are not accounted, mirror pages are not shadowed,
- *     so the bits are effectively 19.
+ *     so the bits are effectively 23.
  *
  *   - quadrant will only be used if has_4_byte_gpte=1 (non-PAE paging);
  *     execonly and ad_disabled are only used for nested EPT which has
@@ -342,8 +342,15 @@ extern struct kvm_host_values kvm_host;
  *   - on top of this, smap_andnot_wp is only set if cr0_wp=0,
  *     therefore these two bits only give rise to 3 possibilities.
  *
+ *   - plane only takes values below the VM's plane count, one value for a
+ *     VM without planes.
+ *
  * Therefore, the maximum number of possible upper-level shadow pages for a
- * single gfn is a bit less than 2^14.
+ * single gfn is a bit less than 2^14 per plane in use.  KVM_CAP_PLANES
+ * refuses more than one plane without TDP, which leaves only nested guests'
+ * shadow pages write-tracked.  Up to 4 planes stay below 2^16; with more,
+ * the bound no longer holds and an overflow is caught by the WARN in
+ * update_gfn_write_track().
  */
 union kvm_mmu_page_role {
 	u32 word;
@@ -371,15 +378,14 @@ union kvm_mmu_page_role {
 		 */
 		unsigned cr4_smep:1;
 
-		unsigned:3;
+		unsigned plane:4;
 
 		/*
 		 * This is left at the top of the word so that
 		 * kvm_memslots_for_spte_role can extract it with a
-		 * simple shift.  While there is room, give it a whole
-		 * byte so it is also faster to load it from memory.
+		 * simple shift.
 		 */
-		unsigned smm:8;
+		unsigned smm:7;
 	};
 };
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 56473abf60fd..9ebcad807c69 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1915,7 +1915,7 @@ struct kvm_hv_hcall {
 };
 
 
-static int kvm_hv_get_hc_data(struct kvm *kvm, struct kvm_hv_hcall *hc,
+static int kvm_hv_get_hc_data(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc,
 			      u16 orig_cnt, u16 cnt_cap, u64 *data)
 {
 	/*
@@ -1944,24 +1944,25 @@ static int kvm_hv_get_hc_data(struct kvm *kvm, struct kvm_hv_hcall *hc,
 		return 0;
 	}
 
-	return kvm_read_guest(kvm, hc->ingpa + hc->data_offset, data,
+	return kvm_vcpu_read_guest(vcpu, hc->ingpa + hc->data_offset, data,
 			      cnt * sizeof(*data));
 }
 
-static u64 kvm_get_sparse_vp_set(struct kvm *kvm, struct kvm_hv_hcall *hc,
+static u64 kvm_get_sparse_vp_set(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc,
 				 u64 *sparse_banks)
 {
 	if (hc->var_cnt > HV_MAX_SPARSE_VCPU_BANKS)
 		return -EINVAL;
 
 	/* Cap var_cnt to ignore banks that cannot contain a legal VP index. */
-	return kvm_hv_get_hc_data(kvm, hc, hc->var_cnt, KVM_HV_MAX_SPARSE_VCPU_SET_BITS,
+	return kvm_hv_get_hc_data(vcpu, hc, hc->var_cnt, KVM_HV_MAX_SPARSE_VCPU_SET_BITS,
 				  sparse_banks);
 }
 
-static int kvm_hv_get_tlb_flush_entries(struct kvm *kvm, struct kvm_hv_hcall *hc, u64 entries[])
+static int kvm_hv_get_tlb_flush_entries(struct kvm_vcpu *vcpu,
+					struct kvm_hv_hcall *hc, u64 entries[])
 {
-	return kvm_hv_get_hc_data(kvm, hc, hc->rep_cnt, hc->rep_cnt, entries);
+	return kvm_hv_get_hc_data(vcpu, hc, hc->rep_cnt, hc->rep_cnt, entries);
 }
 
 static void hv_tlb_flush_enqueue(struct kvm_vcpu *vcpu, u64 *entries, int count,
@@ -2151,8 +2152,8 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			flush.processor_mask = sse128_lo(hc->xmm[0]);
 			hc->consumed_xmm_halves = 1;
 		} else {
-			if (unlikely(kvm_read_guest(kvm, hc->ingpa,
-						    &flush, sizeof(flush))))
+			if (unlikely(kvm_vcpu_read_guest(vcpu, hc->ingpa,
+							 &flush, sizeof(flush))))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			hc->data_offset = sizeof(flush);
 		}
@@ -2181,8 +2182,8 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			       &hc->xmm[0], sizeof(hc->xmm[0]));
 			hc->consumed_xmm_halves = 2;
 		} else {
-			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &flush_ex,
-						    sizeof(flush_ex))))
+			if (unlikely(kvm_vcpu_read_guest(vcpu, hc->ingpa, &flush_ex,
+							 sizeof(flush_ex))))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			hc->data_offset = sizeof(flush_ex);
 		}
@@ -2203,7 +2204,7 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			if (!hc->var_cnt)
 				goto ret_success;
 
-			if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks))
+			if (kvm_get_sparse_vp_set(vcpu, hc, sparse_banks))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 		}
 
@@ -2225,7 +2226,7 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	    hc->rep_cnt > ARRAY_SIZE(__tlb_flush_entries)) {
 		tlb_flush_entries = NULL;
 	} else {
-		if (kvm_hv_get_tlb_flush_entries(kvm, hc, __tlb_flush_entries))
+		if (kvm_hv_get_tlb_flush_entries(vcpu, hc, __tlb_flush_entries))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 		tlb_flush_entries = __tlb_flush_entries;
 	}
@@ -2331,8 +2332,8 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 
 	if (hc->code == HVCALL_SEND_IPI) {
 		if (!hc->fast) {
-			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi,
-						    sizeof(send_ipi))))
+			if (unlikely(kvm_vcpu_read_guest(vcpu, hc->ingpa, &send_ipi,
+							 sizeof(send_ipi))))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			sparse_banks[0] = send_ipi.cpu_mask;
 			vector = send_ipi.vector;
@@ -2349,8 +2350,8 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		trace_kvm_hv_send_ipi(vector, sparse_banks[0]);
 	} else {
 		if (!hc->fast) {
-			if (unlikely(kvm_read_guest(kvm, hc->ingpa, &send_ipi_ex,
-						    sizeof(send_ipi_ex))))
+			if (unlikely(kvm_vcpu_read_guest(vcpu, hc->ingpa, &send_ipi_ex,
+							 sizeof(send_ipi_ex))))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 		} else {
 			send_ipi_ex.vector = (u32)hc->ingpa;
@@ -2381,7 +2382,7 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		else
 			hc->consumed_xmm_halves = 1;
 
-		if (kvm_get_sparse_vp_set(kvm, hc, sparse_banks))
+		if (kvm_get_sparse_vp_set(vcpu, hc, sparse_banks))
 			return HV_STATUS_INVALID_HYPERCALL_INPUT;
 	}
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8a829c93a37f..669a1a2a6e3c 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -3254,7 +3254,9 @@ static bool kvm_mmu_prefetch_sptes(struct kvm_vcpu *vcpu, gfn_t gfn, u64 *sptep,
 		return false;
 
 	for (i = 0; i < nr_pages; i++, gfn++, sptep++) {
-		if (kvm_get_vm_memory_attributes(vcpu->kvm, gfn)) {
+		if (kvm_get_vm_memory_attributes(vcpu->kvm, gfn) ||
+		    (vcpu->plane_level &&
+		     kvm_plane_get_memory_attributes(vcpu->plane, gfn))) {
 			kvm_release_page_clean(pages[i]);
 			continue;
 		}
@@ -4721,7 +4723,7 @@ static inline unsigned kvm_get_gfn_protections(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	struct kvm *kvm = vcpu->kvm;
 	unsigned int access = vcpu->arch.mmu->root_role.access;
-	unsigned long attrs = kvm_get_vm_memory_attributes(kvm, gfn);
+	unsigned long attrs = kvm_plane_get_memory_attributes(vcpu->plane, gfn);
 	if (!attrs)
 		return access;
 
@@ -4749,6 +4751,19 @@ static int kvm_faultin_memory_protections(struct kvm_vcpu *vcpu,
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
 	if (access == ACC_ALL)
 		return RET_PF_CONTINUE;
@@ -6057,6 +6072,8 @@ static union kvm_cpu_role kvm_calc_cpu_role(struct kvm_vcpu *vcpu,
 	role.base.guest_mode = is_guest_mode(vcpu);
 	role.ext.valid = 1;
 
+	role.base.plane = vcpu->plane_level;
+
 	if (!____is_cr0_pg(regs)) {
 		role.base.direct = 1;
 		return role;
@@ -6149,6 +6166,7 @@ kvm_calc_tdp_mmu_root_page_role(struct kvm_vcpu *vcpu,
 	role.level = kvm_mmu_get_tdp_level(vcpu);
 	role.direct = true;
 	role.has_4_byte_gpte = false;
+	role.plane = vcpu->plane_level;
 
 	/* All TDP pages are supervisor-executable */
 	role.access = ACC_ALL;
@@ -6287,6 +6305,7 @@ kvm_calc_shadow_ept_root_page_role(struct kvm_vcpu *vcpu, bool accessed_dirty,
 	role.base.ad_disabled = !accessed_dirty;
 	role.base.guest_mode = true;
 	role.base.access = ACC_ALL;
+	role.base.plane = vcpu->plane_level;
 
 	role.ext.word = 0;
 	role.ext.execonly = execonly;
@@ -8383,12 +8402,36 @@ static bool hugepage_has_attrs(struct kvm *kvm, struct kvm_memory_slot *slot,
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
 bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
 					    struct kvm_gfn_range *range)
 {
 	unsigned long attrs = range->arg.attributes;
 	struct kvm_memory_slot *slot = range->slot;
-	struct kvm_mmu_page *sp;
 	int level;
 
 	lockdep_assert_held_write(&kvm->mmu_lock);
@@ -8445,24 +8488,21 @@ bool kvm_arch_post_set_vm_memory_attributes(struct kvm *kvm,
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
 
 void kvm_arch_post_set_vm_memory_attributes_unlocked(struct kvm *kvm)
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 1403bd9e878c..377cd3e7c7d6 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -426,14 +426,14 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 		if (unlikely(kvm_is_error_hva(host_addr)))
 			goto error;
 
-		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gpa_to_gfn(real_gpa))) {
+		if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gpa_to_gfn(real_gpa))) {
 			walker->error = -EFAULT;
 			kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK,
 						      PAGE_SIZE, false, false, false);
 			goto error;
 		}
 
-		if (!kvm_mem_attributes_may_write_gfn(vcpu->kvm, gpa_to_gfn(real_gpa)))
+		if (!kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gpa_to_gfn(real_gpa)))
 			walker->pte_writable[walker->level - 1] = false;
 
 		ptep_user = (pt_element_t __user *)((void *)host_addr + offset);
diff --git a/arch/x86/kvm/mmu/tdp_mmu.c b/arch/x86/kvm/mmu/tdp_mmu.c
index dce44b9ce73a..356efffe0b16 100644
--- a/arch/x86/kvm/mmu/tdp_mmu.c
+++ b/arch/x86/kvm/mmu/tdp_mmu.c
@@ -1828,8 +1828,20 @@ void kvm_tdp_mmu_recover_huge_pages(struct kvm *kvm,
 	struct kvm_mmu_page *root;
 
 	lockdep_assert_held_read(&kvm->mmu_lock);
-	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id)
+	for_each_valid_tdp_mmu_root_yield_safe(kvm, root, slot->as_id) {
+		/*
+		 * kvm_mmu_max_mapping_level() consults only plane-0 state
+		 * (lpage_info and plane-0 private attributes).  Nonzero
+		 * planes carry per-plane memory attributes whose fault-time
+		 * 4KiB clamps a huge SPTE would undo, extending one page's
+		 * protections over gfns the plane maps differently.  Leave
+		 * those roots alone; their fault path rebuilds mappings at
+		 * the largest level the plane allows.
+		 */
+		if (root->role.plane)
+			continue;
 		recover_huge_pages_range(kvm, root, slot);
+	}
 }
 
 /*
diff --git a/arch/x86/kvm/msrs.c b/arch/x86/kvm/msrs.c
index 4d51d782f88e..595306a31531 100644
--- a/arch/x86/kvm/msrs.c
+++ b/arch/x86/kvm/msrs.c
@@ -1231,7 +1231,7 @@ static void kvm_get_xstate_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 	kvm_access_xstate_msr(vcpu, msr_info, MSR_TYPE_R);
 }
 
-static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_ofs)
+static void kvm_write_wall_clock(struct kvm_vcpu *vcpu, gpa_t wall_clock, int sec_hi_ofs)
 {
 	int version;
 	int r;
@@ -1242,7 +1242,7 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_o
 	if (!wall_clock)
 		return;
 
-	r = kvm_read_guest(kvm, wall_clock, &version, sizeof(version));
+	r = kvm_vcpu_read_guest(vcpu, wall_clock, &version, sizeof(version));
 	if (r)
 		return;
 
@@ -1251,25 +1251,25 @@ static void kvm_write_wall_clock(struct kvm *kvm, gpa_t wall_clock, int sec_hi_o
 
 	++version;
 
-	if (kvm_write_guest(kvm, wall_clock, &version, sizeof(version)))
+	if (kvm_vcpu_write_guest(vcpu, wall_clock, &version, sizeof(version)))
 		return;
 
-	wall_nsec = kvm_get_wall_clock_epoch(kvm);
+	wall_nsec = kvm_get_wall_clock_epoch(vcpu->kvm);
 
 	wc.nsec = do_div(wall_nsec, NSEC_PER_SEC);
 	wc.sec = (u32)wall_nsec; /* overflow in 2106 guest time */
 	wc.version = version;
 
-	kvm_write_guest(kvm, wall_clock, &wc, sizeof(wc));
+	kvm_vcpu_write_guest(vcpu, wall_clock, &wc, sizeof(wc));
 
 	if (sec_hi_ofs) {
 		wc_sec_hi = wall_nsec >> 32;
-		kvm_write_guest(kvm, wall_clock + sec_hi_ofs,
-				&wc_sec_hi, sizeof(wc_sec_hi));
+		kvm_vcpu_write_guest(vcpu, wall_clock + sec_hi_ofs,
+				     &wc_sec_hi, sizeof(wc_sec_hi));
 	}
 
 	version++;
-	kvm_write_guest(kvm, wall_clock, &version, sizeof(version));
+	kvm_vcpu_write_guest(vcpu, wall_clock, &version, sizeof(version));
 }
 
 static void kvm_write_system_time(struct kvm_vcpu *vcpu, gpa_t system_time,
@@ -1668,14 +1668,14 @@ int kvm_set_msr_common(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		vcpu->kvm->arch.wall_clock = data;
-		kvm_write_wall_clock(vcpu->kvm, data, 0);
+		kvm_write_wall_clock(vcpu, data, 0);
 		break;
 	case MSR_KVM_WALL_CLOCK:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE))
 			return KVM_MSR_RET_UNSUPPORTED;
 
 		vcpu->kvm->arch.wall_clock = data;
-		kvm_write_wall_clock(vcpu->kvm, data, 0);
+		kvm_write_wall_clock(vcpu, data, 0);
 		break;
 	case MSR_KVM_SYSTEM_TIME_NEW:
 		if (!guest_pv_has(vcpu, KVM_FEATURE_CLOCKSOURCE2))
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d12844b6ca49..7246450533c7 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5144,7 +5144,8 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 	ret = kvm_vcpu_fetch_guest_page(vcpu, gpa >> PAGE_SHIFT, val,
 					offset, bytes);
 	if (unlikely(ret < 0)) {
-		unsigned long attrs = kvm_get_vm_memory_attributes(vcpu->kvm, gpa_to_gfn(gpa));
+		unsigned long attrs = kvm_plane_get_memory_attributes(vcpu->plane,
+								      gpa_to_gfn(gpa));
 
 		if (!kvm_mem_attributes_may_exec(attrs)) {
 			kvm_prepare_memory_fault_exit(vcpu, gpa & PAGE_MASK, PAGE_SIZE,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 74cbb32d7834..a9ca853dfb8a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -895,6 +895,16 @@ struct kvm_plane {
 	/* Per-Plane VCPU array */
 	struct xarray vcpu_array;
 
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
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
 
@@ -2825,6 +2835,29 @@ void kvm_arch_post_set_vm_memory_attributes_unlocked(struct kvm *kvm);
 bool kvm_range_has_any_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 					    unsigned long mask);
 u64 kvm_supported_vm_mem_attributes(struct kvm *kvm);
+bool kvm_plane_range_has_any_attrs(struct kvm_plane *plane, gfn_t start,
+				   gfn_t end);
+bool kvm_any_plane_range_has_rw_memory_protections(struct kvm *kvm,
+						   gfn_t start, gfn_t end);
+/*
+ * As kvm_arch_post_set_vm_memory_attributes(), but for an update of a
+ * non-zero plane's attributes, which has no hugepage mixed-attribute
+ * tracking to maintain.
+ */
+bool kvm_arch_post_set_plane_memory_attributes(struct kvm *kvm,
+					       struct kvm_gfn_range *range);
+
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
 
 static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 {
@@ -2859,10 +2892,23 @@ static inline unsigned long kvm_get_vm_memory_attributes(struct kvm *kvm, gfn_t
 	return 0;
 }
 
+static inline bool kvm_any_plane_range_has_rw_memory_protections(struct kvm *kvm,
+								 gfn_t start,
+								 gfn_t end)
+{
+	return false;
+}
+
 static inline u64 kvm_mem_attributes_generation(struct kvm *kvm)
 {
 	return 0;
 }
+
+static inline unsigned long kvm_plane_get_memory_attributes(struct kvm_plane *plane,
+							    gfn_t gfn)
+{
+	return 0;
+}
 #endif  /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
 #ifdef CONFIG_KVM_PRIVATE_MEMATTR_VM
@@ -2907,6 +2953,27 @@ static inline int kvm_mem_attributes_may_write_gfn(struct kvm *kvm, gfn_t gfn)
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
index e0a327fbbaff..65c33dbaa245 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1290,6 +1290,9 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 	plane->level = plane_level;
 
 	xa_init(&plane->vcpu_array);
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	xa_init_flags(&plane->mem_attrs, XA_FLAGS_ACCOUNT);
+#endif
 
 	if (kvm_arch_plane_init(kvm, plane, plane_level))
 		goto out_free_plane;
@@ -1305,6 +1308,9 @@ static struct kvm_plane *kvm_create_plane(struct kvm *kvm, unsigned plane_level)
 
 static void kvm_destroy_one_plane(struct kvm_plane *plane)
 {
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
+	xa_destroy(&plane->mem_attrs);
+#endif
 	kvm_arch_plane_destroy(plane);
 	kvm_free_plane(plane);
 }
@@ -2708,13 +2714,13 @@ bool kvm_prepare_memory_fault_exit_for_range(struct kvm_vcpu *vcpu, gpa_t gpa,
 
 	last = gpa_to_gfn(gpa + size - 1);
 	for (gfn = gpa_to_gfn(gpa); gfn <= last; gfn++) {
-		if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn)) {
+		if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn)) {
 			kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
 						      write, false, false);
 			return true;
 		}
 
-		if (write && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn)) {
+		if (write && !kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn)) {
 			kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
 						      true, false, false);
 			return true;
@@ -2834,7 +2840,68 @@ bool kvm_range_has_any_vm_memory_attributes(struct kvm *kvm, gfn_t start, gfn_t
 
 #define KVM_MEMORY_ATTRIBUTE_NEEDS_SYNC_MASK KVM_MEMORY_ATTRIBUTE_PROT
 
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
+		/*
+		 * Only count real attribute values: xa_reserve()
+		 * placeholders from an in-flight (or failed) attribute
+		 * update are not attributes.
+		 */
+		if (xa_is_value(entry) && (xa_to_value(entry) & mask))
+			return true;
+	}
+	return false;
+}
+
+/* Returns true if _any_ gfn in [@start, @end) has any attribute in @plane. */
+bool kvm_plane_range_has_any_attrs(struct kvm_plane *plane, gfn_t start,
+				   gfn_t end)
+{
+	return kvm_plane_range_has_memory_attributes(plane, start, end, ~0UL);
+}
+
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
+		/* Pairs with the release in kvm_vm_ioctl_create_plane(). */
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
+static bool kvm_range_memory_attributes_need_sync(struct kvm_plane *plane,
 						  gfn_t start, gfn_t end,
 						  unsigned long attributes)
 {
@@ -2843,7 +2910,7 @@ static bool kvm_range_memory_attributes_need_sync(struct kvm *kvm,
 	if (attributes & mask)
 		return true;
 
-	return kvm_range_has_any_vm_memory_attributes(kvm, start, end, mask);
+	return kvm_plane_range_has_memory_attributes(plane, start, end, mask);
 }
 
 static __always_inline bool kvm_handle_gfn_range(struct kvm *kvm,
@@ -2918,9 +2985,11 @@ static bool kvm_pre_set_vm_memory_attributes(struct kvm *kvm,
 }
 
 /* Set @attributes for the gfn range [@start, @end). */
-static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
-				     unsigned long attributes)
+static int kvm_plane_set_mem_attributes(struct kvm_plane *plane, gfn_t start,
+					gfn_t end, unsigned long attributes)
 {
+	struct kvm *kvm = plane->kvm;
+	struct xarray *attr_array = kvm_plane_mem_attr_array(plane);
 	struct kvm_mmu_notifier_range pre_set_range = {
 		.start = start,
 		.end = end,
@@ -2946,13 +3015,17 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 
 	entry = attributes ? xa_mk_value(attributes) : NULL;
 
+	if (plane->level)
+		post_set_range.handler = kvm_arch_post_set_plane_memory_attributes;
+
 	mutex_lock(&kvm->slots_lock);
 
 	/* Nothing to do if the entire range has the desired attributes. */
-	if (kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
+	if (!plane->level &&
+	    kvm_range_has_vm_memory_attributes(kvm, start, end, ~0, attributes))
 		goto out_unlock;
 
-	sync = kvm_range_memory_attributes_need_sync(kvm, start, end,
+	sync = kvm_range_memory_attributes_need_sync(plane, start, end,
 						     attributes);
 
 	trace_kvm_set_vm_mem_attributes(start, end, attributes, sync,
@@ -2964,9 +3037,19 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	 * allocates, so no reservations are needed when clearing.
 	 */
 	for (i = start; entry && i < end; i++) {
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
@@ -2974,8 +3057,7 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
 	found_memslot = kvm_handle_gfn_range(kvm, &pre_set_range);
 
 	for (i = start; i < end; i++) {
-		r = xa_err(xa_store(&kvm->mem_attrs.array, i, entry,
-				    GFP_KERNEL_ACCOUNT));
+		r = xa_err(xa_store(attr_array, i, entry, GFP_KERNEL_ACCOUNT));
 		KVM_BUG_ON(r, kvm);
 		cond_resched();
 	}
@@ -2985,6 +3067,15 @@ static int kvm_set_vm_mem_attributes(struct kvm *kvm, gfn_t start, gfn_t end,
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
@@ -3006,6 +3097,16 @@ bool __weak kvm_arch_mem_attributes_supported_prot(struct kvm *kvm, unsigned lon
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
 bool kvm_vm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
 {
 	if (attrs & ~kvm_supported_vm_mem_attributes(kvm))
@@ -3018,9 +3119,10 @@ bool kvm_vm_mem_attributes_valid(struct kvm *kvm, unsigned long attrs)
 	return true;
 }
 
-static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
+static int kvm_vm_ioctl_set_mem_attributes(struct kvm_plane *plane,
 					   struct kvm_memory_attributes *attrs)
 {
+	struct kvm *kvm = plane->kvm;
 	gfn_t start, end;
 
 	/* flags is currently not used. */
@@ -3028,6 +3130,10 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 		return -EINVAL;
 	if (!kvm_vm_mem_attributes_valid(kvm, attrs->attributes))
 		return -EINVAL;
+	/* Partition-wide attributes have no meaning on a non-zero plane. */
+	if (plane->level &&
+	    (attrs->attributes & ~(unsigned long)KVM_MEMORY_ATTRIBUTE_PROT))
+		return -EINVAL;
 	if (attrs->size == 0 || attrs->address + attrs->size < attrs->address)
 		return -EINVAL;
 	if (!PAGE_ALIGNED(attrs->address) || !PAGE_ALIGNED(attrs->size))
@@ -3043,7 +3149,8 @@ static int kvm_vm_ioctl_set_mem_attributes(struct kvm *kvm,
 	 */
 	BUILD_BUG_ON(sizeof(attrs->attributes) != sizeof(unsigned long));
 
-	return kvm_set_vm_mem_attributes(kvm, start, end, attrs->attributes);
+	return kvm_plane_set_mem_attributes(plane, start, end,
+					    attrs->attributes);
 }
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
 
@@ -3200,17 +3307,16 @@ EXPORT_SYMBOL_FOR_KVM_INTERNAL(gfn_to_hva);
 
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
@@ -3263,10 +3369,10 @@ unsigned long kvm_vcpu_gfn_to_hva_prot(struct kvm_vcpu *vcpu, gfn_t gfn, bool *w
 	if (kvm_is_error_hva(addr))
 		return addr;
 
-	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
+	if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn))
 		return KVM_HVA_ERR_BAD;
 
-	if (writable && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+	if (writable && !kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn))
 		*writable = false;
 
 	return addr;
@@ -3610,9 +3716,9 @@ int __kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map,
 	if (WARN_ON_ONCE(map->hva))
 		kvm_vcpu_unmap(vcpu, map);
 
-	if (!kvm_mem_attributes_may_read_gfn(vcpu->kvm, gfn))
+	if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn))
 		return -EFAULT;
-	if (writable && !kvm_mem_attributes_may_write_gfn(vcpu->kvm, gfn))
+	if (writable && !kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn))
 		return -EFAULT;
 
 	map->pinned_page = NULL;
@@ -3675,7 +3781,8 @@ static int next_segment(unsigned long len, int offset)
 }
 
 /* Copy @len bytes from guest memory at '(@gfn * PAGE_SIZE) + @offset' to @data */
-static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
+static int __kvm_read_guest_page(struct kvm_plane *plane,
+				 struct kvm_memory_slot *slot,
 				 gfn_t gfn, void *data, int offset, int len,
 				 unsigned long attr)
 {
@@ -3690,7 +3797,7 @@ static int __kvm_read_guest_page(struct kvm *kvm, struct kvm_memory_slot *slot,
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 
-	attrs = kvm_get_vm_memory_attributes(kvm, gfn);
+	attrs = kvm_plane_get_memory_attributes(plane, gfn);
 	if (attrs & attr)
 		return -EFAULT;
 
@@ -3705,8 +3812,8 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(kvm, slot, gfn, data, offset, len,
-				     KVM_MEMORY_ATTRIBUTE_NR);
+	return __kvm_read_guest_page(kvm->planes[0], slot, gfn, data, offset,
+				     len, KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_read_guest_page);
 
@@ -3715,8 +3822,8 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
-				     KVM_MEMORY_ATTRIBUTE_NR);
+	return __kvm_read_guest_page(vcpu->plane, slot, gfn, data, offset,
+				     len, KVM_MEMORY_ATTRIBUTE_NR);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_page);
 
@@ -3725,8 +3832,8 @@ int kvm_vcpu_fetch_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(vcpu->kvm, slot, gfn, data, offset, len,
-				     KVM_MEMORY_ATTRIBUTE_NX);
+	return __kvm_read_guest_page(vcpu->plane, slot, gfn, data, offset,
+				     len, KVM_MEMORY_ATTRIBUTE_NX);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_fetch_guest_page);
 
@@ -3770,7 +3877,7 @@ int kvm_vcpu_read_guest(struct kvm_vcpu *vcpu, gpa_t gpa, void *data, unsigned l
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest);
 
-static int __kvm_read_guest_atomic(struct kvm *kvm,
+static int __kvm_read_guest_atomic(struct kvm_plane *plane,
 				   struct kvm_memory_slot *slot, gfn_t gfn,
 				   void *data, int offset, unsigned long len)
 {
@@ -3780,7 +3887,7 @@ static int __kvm_read_guest_atomic(struct kvm *kvm,
 	if (WARN_ON_ONCE(offset + len > PAGE_SIZE))
 		return -EFAULT;
 
-	if (!kvm_mem_attributes_may_read_gfn(kvm, gfn))
+	if (!kvm_mem_attributes_may_read(kvm_plane_get_memory_attributes(plane, gfn)))
 		return -EFAULT;
 
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
@@ -3801,12 +3908,12 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	int offset = offset_in_page(gpa);
 
-	return __kvm_read_guest_atomic(vcpu->kvm, slot, gfn, data, offset, len);
+	return __kvm_read_guest_atomic(vcpu->plane, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_read_guest_atomic);
 
 /* Copy @len bytes from @data into guest memory at '(@gfn * PAGE_SIZE) + @offset' */
-static int __kvm_write_guest_page(struct kvm *kvm,
+static int __kvm_write_guest_page(struct kvm_plane *plane,
 				  struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
@@ -3820,13 +3927,13 @@ static int __kvm_write_guest_page(struct kvm *kvm,
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
 
-	if (!kvm_mem_attributes_may_write_gfn(kvm, gfn))
+	if (!kvm_mem_attributes_may_write(kvm_plane_get_memory_attributes(plane, gfn)))
 		return -EFAULT;
 
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(kvm, memslot, gfn);
+	mark_page_dirty_in_slot(plane->kvm, memslot, gfn);
 	return 0;
 }
 
@@ -3835,7 +3942,8 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(kvm->planes[0], slot, gfn, data,
+				      offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest_page);
 
@@ -3844,7 +3952,8 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(vcpu->plane, slot, gfn, data,
+				      offset, len);
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_vcpu_write_guest_page);
 
@@ -3925,7 +4034,8 @@ static int __kvm_gfn_to_hva_cache_init(struct kvm *kvm,
 	 * check has to happen after storing the generation number.
 	 */
 	ghc->attrs_generation = kvm_mem_attributes_generation(kvm);
-	if (kvm_range_has_rw_memory_protections(kvm, start_gfn, end_gfn + 1)) {
+	if (kvm_any_plane_range_has_rw_memory_protections(kvm, start_gfn,
+							  end_gfn + 1)) {
 		ghc->hva = KVM_HVA_ERR_BAD;
 		return -EFAULT;
 	}
@@ -5425,6 +5535,17 @@ static long __kvm_plane_ioctl(struct kvm_plane *plane, unsigned int ioctl, unsig
 		break;
 	}
 #endif /* CONFIG_HAVE_KVM_IRQ_ROUTING */
+#ifdef CONFIG_KVM_VM_MEMORY_ATTRIBUTES
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
@@ -6211,7 +6332,7 @@ static long kvm_vm_ioctl(struct file *filp,
 		if (copy_from_user(&attrs, argp, sizeof(attrs)))
 			goto out;
 
-		r = kvm_vm_ioctl_set_mem_attributes(kvm, &attrs);
+		r = kvm_vm_ioctl_set_mem_attributes(kvm->planes[0], &attrs);
 		break;
 	}
 #endif /* CONFIG_KVM_VM_MEMORY_ATTRIBUTES */
diff --git a/virt/kvm/pfncache.c b/virt/kvm/pfncache.c
index ed8884a6d240..4a665aa4aada 100644
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

