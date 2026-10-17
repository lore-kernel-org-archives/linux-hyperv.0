Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB72B49BB68;
	Sat, 17 Oct 2026 12:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239921; cv=none; b=XsXZVO+Vx3gXVGlNPM+NsrW8H9GOOsxAN/0hZg50zVWOv/TAAhHQAEU/7Uw9j+P0kcgtmKLFr/piN4X6ZhnrCfWYZ1ALHgRJOhEOTAoLUpJ4truKtCb9aloeCXuB6hTFTdMN+yDoZdUg3D2xYYqYBMvRayh4CLaLX7G4WbOgD9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239921; c=relaxed/simple;
	bh=yvLoWk+JCdSpssyWz2vZZpG37/b5JCXoWs5ZKCrYDW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BMVJmyPH2PG4tZVnhQb5YBSQXIhwOtl4xU8MeKeJxb8Le0cxZffIPScpJBPKjaNRtK27Cf1GOumRHHikT0I3Rl6wWwFdJ86wmsL83o2Sp9QarQ+GU99SaFN7e03DW/eI6zoeR9y8d/iIFgfuo3W7K9nO+933Ou7OIsUSOF5+4qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ZUpX/ICx; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ZUpX/ICx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=85xhLKU/vn8G2sySUZ9gvUaw1K46WSLN0RTc8IO28iA=; b=ZUpX/ICxW5BLOUYpJ4WCT/KvNM
	Htz8zQ23C1J6ZowV47CW/iB/oM4lkY6AgZ3IRXvgrYOowUBtu7jx40z+GlcTilsq8yeKr1FIRw2v7
	clgTtdsRd/g9mpOJ4nmf6VZwFUSI8oETfJETvXqHgp6kb8DFcFwESe/+896gGyaUbfYIpImLFlSVg
	e/j6e0nCxbL/uwGJYgOzRpxsv0oAZSYdSNX+ltqoOarAVucnC0e1q+rytquVk+LPgR2R6aFoFOQ9e
	KkMsT8T1raNUTd+AesPdNfUuxrAWpFKERNy8xsBeLGGGaYoE1Os+ysBhODeHwk4N4sJJCej7UhBDu
	G1WO8okw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfW-1xoE;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnV-32hp;
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
Subject: [RFC PATCH 39/55] KVM: x86: hyperv: Harden the per-plane reference TSC page updates
Date: Sat, 17 Oct 2026 13:24:45 +0100
Message-ID: <20261017122501.610248-40-dwmw2@infradead.org>
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

From: Mushahid Hussain <hmushi@amazon.co.uk>

The per-plane reference TSC pages were updated through
kvm_write_guest_unprotected(), which bypasses the memory attribute
checks entirely: a plane writing HV_X64_MSR_REFERENCE_TSC had KVM
write the first 24 bytes of an arbitrary gfn of its choosing even
where that plane's own attributes forbid it, which is precisely the
protection a higher VTL counts on.  The sequence stream was also
seeded from the lowest enabled plane's page — guest-writable memory,
normally VTL0's — so VTL0 could stage S-1 on its own page (S being the
sequence live on VTL1's page), force a rewrite with an MSR write and
have a VTL1 reader which sampled S accept a torn body: guest-steered
time in a higher trust level.  And a failed update marked the whole
partition HV_TSC_PAGE_BROKEN, leaving every page at sequence zero for
the rest of the guest's life although the previous parameters still
described a valid clock.

Access each plane's page as the plane that owns it, with
kvm_plane_write_guest() and kvm_plane_read_guest() checking the given
plane's attributes (not exported to vendor modules: their only
callers live in kvm.ko, and the helpers bypass the usual "as the
vCPU's own plane" accessors).  Author the sequence host-side
(hv_tsc_sequence: monotonic, never read back from a page), invalidate
a page with a discrete zero-sequence write before touching its body,
invalidate synchronously on guest enables, make a guest MSR write
under TSC emulation take the recompute path, and invalidate any
enabled page whose content does not match the adopted parameters.

A refused access or a failed parameter computation now degrades only
the affected plane: its page is tracked in a per-plane
hv_tsc_page_broken bitmap and skipped until the plane writes its MSR
again or the next clock update retries, while the other planes' pages
are still maintained.  The pages are left invalid rather than
republishing the previous parameters: that fallback (TIME_REF_COUNT
answering from kvmclock) is always correct, and the previous
scale/offset would advertise a clock that had just stopped being
TSC-based.  Nothing marks the partition broken any more.

Assisted-by: LLM
[dwmw2: folded in the plane-aware accessor conversion, the host-side
 sequence authorship and invalidation protocol, the per-plane broken
 tracking replacing the partition-wide HV_TSC_PAGE_BROKEN restore
 logic, and the removal of the helper exports; the original keep-the-
 previous-values restore was dropped because parameters read back from
 the plane-0 page (tsc_ref_from_guest) written to a higher plane's
 page with hypervisor authority would let VTL0 forge its clock.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  14 ++-
 arch/x86/kvm/hyperv.c           | 216 ++++++++++++++++++++++++--------
 include/linux/kvm_host.h        |   6 +-
 virt/kvm/kvm_main.c             |  48 +++++--
 4 files changed, 218 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index d913c68b18a7..153c076e91bc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1233,8 +1233,6 @@ enum hv_tsc_page_status {
 	HV_TSC_PAGE_HOST_CHANGED,
 	/* TSC page was properly set up and is currently active  */
 	HV_TSC_PAGE_SET,
-	/* TSC page was set up with an inaccessible GPA */
-	HV_TSC_PAGE_BROKEN,
 };
 
 #ifdef CONFIG_KVM_HYPERV
@@ -1260,6 +1258,18 @@ struct kvm_hv {
 	 * it exposes is not: every enabled page gets the same contents.
 	 */
 	u64 hv_tsc_page_plane[KVM_MAX_PLANES];
+	/*
+	 * Planes whose reference TSC page could not be written, typically
+	 * because the plane's own memory attributes forbid the write.  Such
+	 * a page is left alone until the plane writes its MSR again.
+	 */
+	DECLARE_BITMAP(hv_tsc_page_broken, KVM_MAX_PLANES);
+	/*
+	 * The last sequence number published to the planes' pages.  Host-
+	 * authored and monotonic; never seeded from the (guest-writable)
+	 * pages themselves.
+	 */
+	u32 hv_tsc_sequence;
 	enum hv_tsc_page_status hv_tsc_page_status;
 
 	/* Hyper-v based guest crash (NT kernel bugcheck) parameters */
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 2cf73f72836c..e6ef0f93096e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1231,12 +1231,20 @@ static bool hv_tsc_page_gfn(struct kvm_hv *hv, int plane, u64 *gfn)
 	if (!(msr & HV_X64_MSR_TSC_REFERENCE_ENABLE))
 		return false;
 
+	if (test_bit(plane, hv->hv_tsc_page_broken))
+		return false;
+
 	*gfn = msr >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
 	return true;
 }
 
-/* Publish the current parameters to one plane's page: struct first, then sequence. */
-static int hv_publish_tsc_page(struct kvm *kvm, unsigned int plane, u64 gfn)
+/*
+ * Publish the current parameters to one plane's page: struct first, then
+ * sequence.  The write is subject to the owning plane's own memory
+ * attributes; a plane whose page cannot be written loses only that page,
+ * and keeps whatever the page last held, until it writes its MSR again.
+ */
+static void hv_publish_tsc_page(struct kvm *kvm, unsigned int plane, u64 gfn)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	struct ms_hyperv_tsc_page page = hv->tsc_ref;
@@ -1252,38 +1260,55 @@ static int hv_publish_tsc_page(struct kvm *kvm, unsigned int plane, u64 gfn)
 	if (plane && hv->tsc_ref_from_guest)
 		tsc_seq = 0;
 
+	/*
+	 * The page may hold a live sequence from an earlier enable, over
+	 * parameters that have since changed.  Invalidate it with a discrete
+	 * write first: the stores of one long copy are not ordered as seen
+	 * by another vCPU, so folding the zero sequence into the body write
+	 * would let a reader pair the old sequence with a half-written body.
+	 */
 	page.tsc_sequence = 0;
-	if (kvm_write_guest_unprotected(kvm, gfn_to_gpa(gfn), &page, sizeof(page)))
-		return -EFAULT;
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn), &page,
+				  sizeof(page.tsc_sequence)))
+		goto broken;
+
+	/* Ensure the sequence is zero before the body changes. */
+	smp_wmb();
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn), &page,
+				  sizeof(page)))
+		goto broken;
 
 	if (!tsc_seq)
-		return 0;
+		return;
 
 	/* The struct is complete before the sequence makes it valid. */
 	smp_wmb();
 	page.tsc_sequence = tsc_seq;
-	if (kvm_write_guest_unprotected(kvm, gfn_to_gpa(gfn), &page,
-					sizeof(page.tsc_sequence)))
-		return -EFAULT;
-	return 0;
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn), &page,
+				  sizeof(page.tsc_sequence)))
+		goto broken;
+	return;
+
+broken:
+	set_bit(plane, hv->hv_tsc_page_broken);
 }
 
 /* The lowest plane with an enabled page; it owns the sequence number. */
-static bool hv_first_tsc_page_gfn(struct kvm *kvm, u64 *gfn)
+static int hv_first_tsc_page(struct kvm *kvm, u64 *gfn)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	int i;
 
 	for (i = 0; i < KVM_MAX_PLANES; i++) {
 		if (hv_tsc_page_gfn(hv, i, gfn))
-			return true;
+			return i;
 	}
 
-	return false;
+	return -1;
 }
 
 /* Write the first @len bytes of the reference page to every enabled plane. */
-static int hv_write_tsc_pages(struct kvm *kvm, size_t len)
+static void hv_write_tsc_pages(struct kvm *kvm, size_t len)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	u64 gfn;
@@ -1293,11 +1318,54 @@ static int hv_write_tsc_pages(struct kvm *kvm, size_t len)
 		if (!hv_tsc_page_gfn(hv, i, &gfn))
 			continue;
 
-		if (kvm_write_guest_unprotected(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, len))
-			return -EFAULT;
+		/*
+		 * A plane whose own attributes refuse the write loses only
+		 * its page; the other planes' pages stay maintained.
+		 */
+		if (kvm_plane_write_guest(kvm->planes[i], gfn_to_gpa(gfn),
+					  &hv->tsc_ref, len))
+			set_bit(i, hv->hv_tsc_page_broken);
 	}
+}
 
-	return 0;
+/* Invalidate one plane's page: its readers fall back to TIME_REF_COUNT. */
+static void hv_invalidate_tsc_page(struct kvm *kvm, unsigned int plane, u64 gfn)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	u32 tsc_seq = 0;
+
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn),
+				  &tsc_seq, sizeof(tsc_seq)))
+		set_bit(plane, hv->hv_tsc_page_broken);
+}
+
+/*
+ * Under guest TSC emulation the parameters come from plane @src_plane's
+ * page, which is guest-writable: they must not reach a higher plane's page
+ * with hypervisor authority.  A higher plane's page either already holds
+ * the same contents (every page gets the same stream, so a page carried
+ * across migration matches) or was never published — enabled from the host
+ * side while the update was pending — and would serve whatever its memory
+ * last held.  Invalidate the pages that do not match.
+ */
+static void hv_invalidate_mismatched_tsc_pages(struct kvm *kvm, int src_plane)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	struct ms_hyperv_tsc_page page;
+	u64 gfn;
+	int i;
+
+	for (i = src_plane + 1; i < KVM_MAX_PLANES; i++) {
+		if (!hv_tsc_page_gfn(hv, i, &gfn))
+			continue;
+
+		if (!kvm_plane_read_guest(kvm->planes[i], gfn_to_gpa(gfn),
+					  &page, sizeof(page)) &&
+		    !memcmp(&page, &hv->tsc_ref, sizeof(page)))
+			continue;
+
+		hv_invalidate_tsc_page(kvm, i, gfn);
+	}
 }
 
 void kvm_hv_setup_tsc_page(struct kvm *kvm,
@@ -1305,6 +1373,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	u32 tsc_seq;
+	int plane;
 	u64 gfn;
 
 	BUILD_BUG_ON(sizeof(tsc_seq) != sizeof(hv->tsc_ref.tsc_sequence));
@@ -1312,28 +1381,46 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 
 	guard(mutex)(&hv->hv_lock);
 
-	if (hv->hv_tsc_page_status == HV_TSC_PAGE_BROKEN ||
-	    hv->hv_tsc_page_status == HV_TSC_PAGE_SET ||
+	if (hv->hv_tsc_page_status == HV_TSC_PAGE_SET ||
 	    hv->hv_tsc_page_status == HV_TSC_PAGE_UNSET)
 		return;
 
-	if (!hv_first_tsc_page_gfn(kvm, &gfn))
-		return;
+	if (tsc_page_update_unsafe(hv)) {
+		/*
+		 * The guest has opted for TSC emulation after migration: the
+		 * lowest enabled plane's page carries the parameters to keep.
+		 * The reads are subject to the owning plane's read attribute;
+		 * a plane whose page cannot be read loses that page and the
+		 * next enabled plane takes over.
+		 */
+		for (;;) {
+			plane = hv_first_tsc_page(kvm, &gfn);
+			if (plane < 0)
+				return;
+
+			if (likely(!kvm_plane_read_guest(kvm->planes[plane],
+							 gfn_to_gpa(gfn), &tsc_seq,
+							 sizeof(tsc_seq))))
+				break;
 
-	/*
-	 * Because the TSC parameters only vary when there is a
-	 * change in the master clock, do not bother with caching.
-	 */
-	if (unlikely(kvm_read_guest(kvm, gfn_to_gpa(gfn),
-				    &tsc_seq, sizeof(tsc_seq))))
-		goto out_err;
+			set_bit(plane, hv->hv_tsc_page_broken);
+		}
 
-	if (tsc_seq && tsc_page_update_unsafe(hv)) {
-		if (kvm_read_guest(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, sizeof(hv->tsc_ref)))
-			goto out_err;
+		if (tsc_seq) {
+			if (kvm_plane_read_guest(kvm->planes[plane],
+						 gfn_to_gpa(gfn), &hv->tsc_ref,
+						 sizeof(hv->tsc_ref))) {
+				/* Status is unchanged: the next update retries. */
+				set_bit(plane, hv->hv_tsc_page_broken);
+				return;
+			}
 
-		hv->tsc_ref_from_guest = true;
-		hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
+			hv->tsc_ref_from_guest = true;
+			hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
+			hv_invalidate_mismatched_tsc_pages(kvm, plane);
+			return;
+		}
+	} else if (hv_first_tsc_page(kvm, &gfn) < 0) {
 		return;
 	}
 
@@ -1342,37 +1429,43 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 	 * guest to use the time reference count MSR.
 	 */
 	hv->tsc_ref.tsc_sequence = 0;
-	if (hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence)))
-		goto out_err;
+	hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence));
 
+	/*
+	 * If the master clock is not currently TSC-based, the pages cannot
+	 * describe it: leave them invalid, with their readers on the
+	 * TIME_REF_COUNT fallback, and retry on the next clock update.
+	 * Republishing the previous parameters would advertise a clock that
+	 * no longer matches the one TIME_REF_COUNT answers from.
+	 */
 	if (!compute_tsc_page_parameters(hv_clock, &hv->tsc_ref))
-		goto out_err;
+		return;
 
 	/* Ensure sequence is zero before writing the rest of the struct.  */
 	smp_wmb();
-	if (hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref)))
-		goto out_err;
+	hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref));
 
 	/*
 	 * Now switch to the TSC page mechanism by writing the sequence.
+	 * The sequence is host-authored and monotonic, never read back from
+	 * the pages themselves: they are guest-writable, and a lower plane
+	 * which could steer the next value could stage it on a higher
+	 * plane's page in advance, and have that plane's seqlock accept a
+	 * torn read across this rewrite.
 	 */
-	tsc_seq++;
+	tsc_seq = hv->hv_tsc_sequence + 1;
 	if (tsc_seq == 0xFFFFFFFF || tsc_seq == 0)
 		tsc_seq = 1;
+	hv->hv_tsc_sequence = tsc_seq;
 
 	/* Write the struct entirely before the non-zero sequence.  */
 	smp_wmb();
 
 	hv->tsc_ref.tsc_sequence = tsc_seq;
-	if (hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence)))
-		goto out_err;
+	hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence));
 
 	hv->tsc_ref_from_guest = false;
 	hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
-	return;
-
-out_err:
-	hv->hv_tsc_page_status = HV_TSC_PAGE_BROKEN;
 }
 
 void kvm_hv_request_tsc_page_update(struct kvm *kvm)
@@ -1575,20 +1668,43 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 	case HV_X64_MSR_REFERENCE_TSC: {
 		u64 gfn;
 
-		/* The parameters are valid already: publish them to this page only. */
+		/* A newly written MSR is a fresh attempt at the page. */
+		clear_bit(vcpu->plane_level, hv->hv_tsc_page_broken);
+
+		hv->hv_tsc_page_plane[vcpu->plane_level] = data;
+
+		/*
+		 * The parameters are valid already: publish them to this page
+		 * only.  Not under guest TSC emulation: those parameters are
+		 * the frozen migration-time snapshot, and a guest MSR write
+		 * is the trigger for computing fresh ones (GUEST_CHANGED
+		 * below), as it was before the pages were tracked per plane.
+		 */
 		if (!host && hv->hv_tsc_page_status == HV_TSC_PAGE_SET &&
+		    !hv->tsc_ref_from_guest &&
 		    (data & HV_X64_MSR_TSC_REFERENCE_ENABLE)) {
 			/* The caller holds hv_lock. */
-			hv->hv_tsc_page_plane[vcpu->plane_level] = data;
 			gfn = data >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
-			if (hv_publish_tsc_page(kvm, vcpu->plane_level, gfn))
-				hv->hv_tsc_page_status = HV_TSC_PAGE_BROKEN;
+			hv_publish_tsc_page(kvm, vcpu->plane_level, gfn);
 			break;
 		}
 
-		hv->hv_tsc_page_plane[vcpu->plane_level] = data;
+		/*
+		 * The publish below is deferred to a plane-0 vCPU processing
+		 * the masterclock update; until then the page holds whatever
+		 * its memory last held — possibly a forged clock a lower
+		 * plane staged there.  Invalidate it now, so this plane reads
+		 * TIME_REF_COUNT until the real parameters arrive.  Not for
+		 * host writes: a page restored across migration keeps its
+		 * contents for the TSC-emulation readback.
+		 */
+		if (!host && (data & HV_X64_MSR_TSC_REFERENCE_ENABLE)) {
+			gfn = data >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
+			hv_invalidate_tsc_page(kvm, vcpu->plane_level, gfn);
+		}
+
 		/* Another plane's page may still be enabled: keep it updated. */
-		if (hv_first_tsc_page_gfn(kvm, &gfn)) {
+		if (hv_first_tsc_page(kvm, &gfn) >= 0) {
 			if (!host)
 				hv->hv_tsc_page_status = HV_TSC_PAGE_GUEST_CHANGED;
 			else
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index beae4f2a982a..bc576889c6f0 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1551,8 +1551,10 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn, const void *data,
 			 int offset, int len);
 int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 		    unsigned long len);
-int kvm_write_guest_unprotected(struct kvm *kvm, gpa_t gpa, const void *data,
-				unsigned long len);
+int kvm_plane_write_guest(struct kvm_plane *plane, gpa_t gpa, const void *data,
+			  unsigned long len);
+int kvm_plane_read_guest(struct kvm_plane *plane, gpa_t gpa, void *data,
+			 unsigned long len);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
 int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 72fe64e5d4a1..1c70bb70500c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3832,24 +3832,49 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest);
 
-/* Write a page KVM maintains for the guest; plane protections do not apply. */
-int kvm_write_guest_unprotected(struct kvm *kvm, gpa_t gpa, const void *data,
-				unsigned long len)
+/*
+ * Write a page KVM maintains for the guest on behalf of plane @plane,
+ * honouring that plane's memory attributes rather than plane 0's.
+ */
+int kvm_plane_write_guest(struct kvm_plane *plane, gpa_t gpa, const void *data,
+			  unsigned long len)
 {
+	struct kvm *kvm = plane->kvm;
 	gfn_t gfn = gpa >> PAGE_SHIFT;
 	int seg;
 	int offset = offset_in_page(gpa);
+	int ret;
 
 	while ((seg = next_segment(len, offset)) != 0) {
-		struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
-		unsigned long addr;
+		ret = __kvm_write_guest_page(plane, kvm,
+					     gfn_to_memslot(kvm, gfn), gfn,
+					     data, offset, seg);
+		if (ret < 0)
+			return ret;
+		offset = 0;
+		len -= seg;
+		data += seg;
+		++gfn;
+	}
+	return 0;
+}
 
-		addr = gfn_to_hva_many(slot, gfn, NULL);
-		if (kvm_is_error_hva(addr))
-			return -EFAULT;
-		if (__copy_to_user((void __user *)addr + offset, data, seg))
-			return -EFAULT;
-		mark_page_dirty_in_slot(kvm, slot, gfn);
+/* Read counterpart of kvm_plane_write_guest(). */
+int kvm_plane_read_guest(struct kvm_plane *plane, gpa_t gpa, void *data,
+			 unsigned long len)
+{
+	struct kvm *kvm = plane->kvm;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int seg;
+	int offset = offset_in_page(gpa);
+	int ret;
+
+	while ((seg = next_segment(len, offset)) != 0) {
+		ret = __kvm_read_guest_page(plane, gfn_to_memslot(kvm, gfn),
+					    gfn, data, offset, seg,
+					    KVM_MEMORY_ATTRIBUTE_NR);
+		if (ret < 0)
+			return ret;
 		offset = 0;
 		len -= seg;
 		data += seg;
@@ -3857,7 +3882,6 @@ int kvm_write_guest_unprotected(struct kvm *kvm, gpa_t gpa, const void *data,
 	}
 	return 0;
 }
-EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest_unprotected);
 
 int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 		         unsigned long len)
-- 
2.50.1

