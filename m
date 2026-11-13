Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=u3gUMCtKYEWHlvlBkoqwNNFWP3ZUo1SBsZcZCxWNeRuLnrcJf9BLypGrlSoj9ezOVxab
	 fmIJoIdauHea77xoI49GMz7AbHbqSjTvjl2trja7NJfsZjXuc6qa5AlODyxLehCYrM6BP
	 N7a0zmNb5RIJAKtW+xO27CeAIlpqv1zFJ/UT1VOwJj3B7Pd2Z9fxJsgC5ARgwbJb3oAf2
	 A75OKSWrlXPLO4l8Y7acajsDDtgRSGuMVLBf4Yl1kjet+q0IRjL/9EQ5WuQOx6S6Wy4Gl
	 OezTv0XQmGQmYHL2CJsvWwgN9es9UPNHawn8SrfxyMJzcTlEJK2sfmzrvUytoFvUxPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=J1/Kxj2YwTmtjzatT+p/HdoiY2qX+qQEOa7rehL3ApE=;
	b=Jv2q9Kdezdf+0FELlzIn4GA9RTMHw0h3z+HN58RdK9hOKq5LrqxMRKfNtjDAmd3IlMv/
	 mktnwcIcnXbeE/yUJFFbGggfEtTethnGrLw7iEiDzVTBexC1NXxG3CvETHcWmpj+P/OLy
	 gyk7MgtZzDNJwXv7S47T3uEhvkCno5bT/XqkZU7aOU0Wn0NGzxwY5HTDoYXVOY6B+GYR2
	 DHgg5slTHP22voldcRRcixI9WXQdgeFwqDstci11sO+9W1FsUSeMPzj/KmP6bY0Bk9cBP
	 e2LuhzpPUOVN+ymzH7dBai76KrPtaENF5RL6iNaoIuFhzrNNanwjqB1W8CtrgfdIGdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ikNeSZ17;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF2D606A32E;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AF2D606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ikNeSZ17
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=J1/Kxj2YwTmtjzatT+p/HdoiY2qX+qQEOa7rehL3ApE=; b=ikNeSZ177i5qeLEBioFuXkf3mO
	vp1pw0lYreO0yqtPPcc8PERAd7LzGwYz7ONQDiCB6sewkTagn6UlxU/gdZR507PFhRGIMwTrURw+C
	jvgkwDCWW7JBA7JhxqxAWNOX/FKtrbPmcndOJwY2L1wUB1J6h0hwmZYMjapboWO/VyakRcPVemsoB
	NQypowWZKpr2PtV83FOFhbEAFilGw59U9QP2puqgRtlRWWo9Gdswt3LiBvQWGH1S/GmC0RJRo9mrI
	sxti/1wy46Nlj+gpnGNqEsGoiE8PXRuBgciyi96aKPVO1tHSmZyG3RBTd4GSZG8fj8K19SRxU2Wi+
	esHSpzQA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPU-1qu6;
	Fri, 13 Nov 2026 18:34:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lsf-0zhb;
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
Subject: [RFC PATCH v2 03/31] KVM: x86: hyperv: Maintain a reference TSC page for each plane
Date: Fri, 13 Nov 2026 18:34:19 +0000
Message-ID: <20261113183448.84094-4-dwmw2@infradead.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

HV_X64_MSR_REFERENCE_TSC is private to each Virtual Trust Level: the
secure kernel maps its own page from VTL1, as the normal kernel does
from VTL0. With one partition-wide MSR, VTL1 enabling its page replaced
VTL0's, and the normal kernel fell back to a TIME_REF_COUNT MSR read (a
VM exit) on every clock read.

The reference time behind the pages is one clock per partition, so
every page shows the same scale, offset and sequence. Keep the MSR per
plane, and have every masterclock update write the shared parameters
to every enabled page. A plane that enables its page while another
page is valid gets the current parameters at once, rather than an
update that invalidates every page for nothing. A host-side MSR
restore leaves the page alone, so a page migrated with the guest keeps
its contents.

The pages are guest-writable, so KVM never trusts what it reads back
from them; the TSC-emulation case below keeps such values away from
higher planes. A page is invalidated with a discrete zero-sequence write
before its body changes: the stores of one long copy are not ordered as
another vCPU sees them. The new sequence must also differ from the one
the page held, or a reader that sampled the old sequence accepts a torn
read across the rewrite. A host-side counter (hv_tsc_sequence) is not
enough for that. It is not migrated, so on a destination it restarts
below the sequence on the restored pages, and the first publish there
can repeat it. And under TSC emulation the pages carry a sequence the
guest wrote: VTL0 could stage a value on a higher plane's page and pump
recomputes, one MSR write at a time, until the counter reaches it. So
each update takes the highest of hv_tsc_sequence and every enabled
page's current sequence, plus one, skipping 0, 0xFFFFFFFF and any value
a page holds. The pages can push the sequence past their values but
never make KVM repeat one, and the choice needs no new migrated state.
When a plane enables its page while the parameters are valid, the
parameters go to that page alone, unless the page holds the current
sequence over a different body: then it takes the full update. A page
that already shows exactly the current contents is left alone.

Each page is written and read as the plane that owns it
(kvm_plane_write_guest(), kvm_plane_read_guest()), under that plane's
own memory attributes. A refused access costs only that plane: its page
is marked in a per-plane broken bitmap and KVM stops maintaining it,
leaving whatever it last held, until the plane writes its MSR again.
When the master clock is not TSC-based, no parameters can be computed
and every enabled page is left invalid, with its readers on the
TIME_REF_COUNT fallback, until a later clock update succeeds.

With HV_X64_MSR_TSC_EMULATION_CONTROL set (reenlightenment, restored
across migration), kvm_hv_setup_tsc_page() keeps the parameters it
reads back from the lowest enabled plane's page, with the reserved
field cleared, and invalidates any other page that does not match them.
That page is writable by the lowest VTL, so its contents must not become
a higher VTL's clock: a higher plane's TIME_REF_COUNT, synthetic timers
and timer message timestamps answer from kvmclock rather than from the
read-back parameters, and an MSR write in this state takes a full
update instead of being handed them. Without the first part, VTL0
could stage parameters on its own page, arm TSC emulation and wait for
any masterclock update (migration, KVM_SET_CLOCK, host suspend): KVM
would invalidate VTL1's page and leave the secure kernel reading a
TIME_REF_COUNT that VTL0 chose.

Co-developed-by: Mushahid Hussain <hmushi@amazon.co.uk>
Not-signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  |   7 +
 arch/x86/include/asm/kvm_host.h |  28 ++-
 arch/x86/kvm/hyperv.c           | 377 ++++++++++++++++++++++++++++----
 include/linux/kvm_host.h        |   4 +
 virt/kvm/kvm_main.c             |  50 +++++
 5 files changed, 416 insertions(+), 50 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d83275cc189e..1a7884776ed5 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6884,6 +6884,13 @@ in the future may use the plane id when planes are supported by hardware (as is
 the case for VMPLs in AMD), or if KVM supports accelerated plane switch
 operations (as might be the case for Hyper-V VTLs).
 
+On x86, the Hyper-V partition-wide MSRs HV_X64_MSR_GUEST_OS_ID,
+HV_X64_MSR_HYPERCALL and HV_X64_MSR_REFERENCE_TSC are banked per plane,
+matching their per-VTL instances in the TLFS: an MSR access reads or
+writes the instance belonging to the plane of the vCPU fd that performs
+it.  A migrating VMM must therefore save and restore these MSRs through
+a vCPU fd of every plane, not just plane 0.
+
 .. _KVM_GET_PLANE_RUN_STATE:
 
 4.148 KVM_GET_PLANE_RUN_STATE / KVM_SET_PLANE_RUN_STATE
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index c642a20f3b5f..1ce0b81833b9 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1081,8 +1081,6 @@ enum hv_tsc_page_status {
 	HV_TSC_PAGE_HOST_CHANGED,
 	/* TSC page was properly set up and is currently active  */
 	HV_TSC_PAGE_SET,
-	/* TSC page was set up with an inaccessible GPA */
-	HV_TSC_PAGE_BROKEN,
 };
 
 #ifdef CONFIG_KVM_HYPERV
@@ -1098,7 +1096,24 @@ struct kvm_hv {
 	 */
 	u64 hv_guest_os_id[KVM_MAX_PLANES];
 	u64 hv_hypercall[KVM_MAX_PLANES];
-	u64 hv_tsc_page;
+	/*
+	 * HV_X64_MSR_REFERENCE_TSC is private to each VTL, the reference time
+	 * it exposes is not: every enabled page gets the same contents.
+	 */
+	u64 hv_tsc_page_plane[KVM_MAX_PLANES];
+	/*
+	 * Planes whose reference TSC page could not be written, typically
+	 * because the plane's own memory attributes forbid the write.  Such
+	 * a page is left alone until the plane writes its MSR again.
+	 */
+	DECLARE_BITMAP(hv_tsc_page_broken, KVM_MAX_PLANES);
+	/*
+	 * The last sequence number published to the planes' pages.  Not
+	 * migrated: the next sequence is also chosen to differ from every
+	 * sequence the (guest-writable) pages hold, so it never repeats a
+	 * live one.
+	 */
+	u32 hv_tsc_sequence;
 	enum hv_tsc_page_status hv_tsc_page_status;
 
 	/* Hyper-v based guest crash (NT kernel bugcheck) parameters */
@@ -1106,6 +1121,13 @@ struct kvm_hv {
 	u64 hv_crash_ctl;
 
 	struct ms_hyperv_tsc_page tsc_ref;
+	/*
+	 * tsc_ref was read back from the lowest enabled plane's page (guest
+	 * TSC emulation after migration) rather than computed by the host;
+	 * such values are writable by that plane and must never seed a
+	 * higher plane's page.
+	 */
+	bool tsc_ref_from_guest;
 
 	struct idr conn_to_evt;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 387fff64597d..c76236711208 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -575,21 +575,27 @@ static void synic_init(struct kvm_vcpu_hv_synic *synic)
 	}
 }
 
-static u64 get_time_ref_counter(struct kvm *kvm)
+/* The partition reference time as seen by @vcpu's plane. */
+static u64 get_time_ref_counter(struct kvm_vcpu *vcpu)
 {
+	struct kvm *kvm = vcpu->kvm;
 	struct kvm_hv *hv = to_kvm_hv(kvm);
-	struct kvm_vcpu *vcpu;
 	u64 tsc;
 
 	/*
 	 * Fall back to get_kvmclock_ns() when TSC page hasn't been set up,
-	 * is broken, disabled or being updated.
+	 * is broken, disabled or being updated.  A higher plane falls back
+	 * too when the parameters were read back from a guest page under
+	 * TSC emulation: the lowest VTL can write that page, so trusting
+	 * it here would let it forge the reference time of a higher VTL,
+	 * which kvm_hv_setup_tsc_page() already refuses to do through that
+	 * VTL's own page.
 	 */
-	if (hv->hv_tsc_page_status != HV_TSC_PAGE_SET)
+	if (hv->hv_tsc_page_status != HV_TSC_PAGE_SET ||
+	    (vcpu->plane_level && hv->tsc_ref_from_guest))
 		return div_u64(get_kvmclock_ns(kvm), 100);
 
-	vcpu = kvm_get_vcpu(kvm, 0);
-	tsc = kvm_read_l1_tsc(vcpu, rdtsc());
+	tsc = kvm_read_l1_tsc(kvm_get_vcpu(kvm, 0), rdtsc());
 	return mul_u64_u64_shr(tsc, hv->tsc_ref.tsc_scale, 64)
 		+ hv->tsc_ref.tsc_offset;
 }
@@ -653,7 +659,7 @@ static int stimer_start(struct kvm_vcpu_hv_stimer *stimer)
 	ktime_t ktime_now;
 	ktime_t deadline;
 
-	time_now = get_time_ref_counter(hv_stimer_to_vcpu(stimer)->kvm);
+	time_now = get_time_ref_counter(hv_stimer_to_vcpu(stimer));
 	ktime_now = ktime_get();
 
 	if (stimer->config.periodic) {
@@ -844,7 +850,7 @@ static int stimer_send_msg(struct kvm_vcpu_hv_stimer *stimer)
 	bool no_retry = stimer->config.periodic;
 
 	payload->expiration_time = stimer->exp_time;
-	payload->delivery_time = get_time_ref_counter(vcpu->kvm);
+	payload->delivery_time = get_time_ref_counter(vcpu);
 	return synic_deliver_msg(to_hv_synic(vcpu),
 				 stimer->config.sintx, msg,
 				 no_retry);
@@ -899,7 +905,7 @@ void kvm_hv_process_stimers(struct kvm_vcpu *vcpu)
 
 				if (exp_time) {
 					time_now =
-						get_time_ref_counter(vcpu->kvm);
+						get_time_ref_counter(vcpu);
 					if (time_now >= exp_time)
 						stimer_expiration(stimer);
 				}
@@ -1187,11 +1193,225 @@ static inline bool tsc_page_update_unsafe(struct kvm_hv *hv)
 		hv->hv_tsc_emulation_control;
 }
 
+static bool hv_tsc_page_gfn(struct kvm_hv *hv, int plane, u64 *gfn)
+{
+	u64 msr = hv->hv_tsc_page_plane[plane];
+
+	if (!(msr & HV_X64_MSR_TSC_REFERENCE_ENABLE))
+		return false;
+
+	if (test_bit(plane, hv->hv_tsc_page_broken))
+		return false;
+
+	*gfn = msr >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
+	return true;
+}
+
+/*
+ * Publish the current parameters to one plane's page: struct first, then
+ * sequence.  The write is subject to the owning plane's own memory
+ * attributes; a plane whose page cannot be written loses only that page,
+ * and keeps whatever the page last held, until it writes its MSR again.
+ *
+ * The caller holds hv_lock and publishes only host-computed parameters
+ * (!tsc_ref_from_guest).  A page that already holds exactly the current
+ * contents is left as it is.  Returns false, having written nothing, when
+ * the page holds the current sequence over a different body: republishing
+ * that sequence would let a reader that sampled it before the rewrite
+ * accept a torn read, so the caller must fall back to a full update, which
+ * picks a fresh sequence.
+ */
+static bool hv_publish_tsc_page(struct kvm *kvm, unsigned int plane, u64 gfn)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	struct ms_hyperv_tsc_page page = hv->tsc_ref;
+	u32 tsc_seq = page.tsc_sequence;
+	struct ms_hyperv_tsc_page cur;
+
+	if (kvm_plane_read_guest(kvm->planes[plane], gfn_to_gpa(gfn), &cur,
+				 sizeof(cur)))
+		goto broken;
+
+	if (cur.tsc_sequence == tsc_seq)
+		return !memcmp(&cur, &page, sizeof(cur));
+
+	/*
+	 * The page may hold a live sequence from an earlier enable, over
+	 * parameters that have since changed.  Invalidate it with a discrete
+	 * write first: the stores of one long copy are not ordered as seen
+	 * by another vCPU, so folding the zero sequence into the body write
+	 * would let a reader pair the old sequence with a half-written body.
+	 */
+	page.tsc_sequence = 0;
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn), &page,
+				  sizeof(page.tsc_sequence)))
+		goto broken;
+
+	/* Ensure the sequence is zero before the body changes. */
+	smp_wmb();
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn), &page,
+				  sizeof(page)))
+		goto broken;
+
+	if (!tsc_seq)
+		return true;
+
+	/* The struct is complete before the sequence makes it valid. */
+	smp_wmb();
+	page.tsc_sequence = tsc_seq;
+	if (kvm_plane_write_guest(kvm->planes[plane], gfn_to_gpa(gfn), &page,
+				  sizeof(page.tsc_sequence)))
+		goto broken;
+	return true;
+
+broken:
+	set_bit(plane, hv->hv_tsc_page_broken);
+	return true;
+}
+
+/* The lowest plane with an enabled page; it owns the sequence number. */
+static int hv_first_tsc_page(struct kvm *kvm, u64 *gfn)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	int i;
+
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		if (hv_tsc_page_gfn(hv, i, gfn))
+			return i;
+	}
+
+	return -1;
+}
+
+/* Write the first @len bytes of the reference page to every enabled plane. */
+static void hv_write_tsc_pages(struct kvm *kvm, size_t len)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	u64 gfn;
+	int i;
+
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		if (!hv_tsc_page_gfn(hv, i, &gfn))
+			continue;
+
+		/*
+		 * A plane whose own attributes refuse the write loses only
+		 * its page; the other planes' pages stay maintained.
+		 */
+		if (kvm_plane_write_guest(kvm->planes[i], gfn_to_gpa(gfn),
+					  &hv->tsc_ref, len))
+			set_bit(i, hv->hv_tsc_page_broken);
+	}
+}
+
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
+}
+
+static bool hv_tsc_seq_valid(u32 seq, const u32 *seen, int nr_seen)
+{
+	int i;
+
+	if (seq == 0 || seq == 0xFFFFFFFF)
+		return false;
+
+	for (i = 0; i < nr_seen; i++) {
+		if (seq == seen[i])
+			return false;
+	}
+
+	return true;
+}
+
+/*
+ * Pick the sequence for the next publish.  It must differ from the sequence
+ * every enabled page holds now: a reader that sampled that sequence before
+ * the rewrite would otherwise accept a body that changed under it.
+ * hv_tsc_sequence alone does not ensure that.  It is not migrated, so a
+ * destination restarts it below the sequence of the restored pages, and
+ * under TSC emulation the pages carry a sequence the guest wrote.  Take the
+ * highest of hv_tsc_sequence and the pages' sequences, then step past any
+ * value a page holds.  The pages can only push the result past their own
+ * values; they cannot make KVM republish one of them.
+ *
+ * Must run before the pages are invalidated.  A page its own plane cannot
+ * read is marked broken, as a refused write would mark it.
+ */
+static u32 hv_next_tsc_sequence(struct kvm *kvm)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	u32 seen[KVM_MAX_PLANES + 1];
+	u32 seq, hi = hv->hv_tsc_sequence;
+	int i, nr_seen = 0;
+	u64 gfn;
+
+	seen[nr_seen++] = hv->tsc_ref.tsc_sequence;
+
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		if (!hv_tsc_page_gfn(hv, i, &gfn))
+			continue;
+
+		if (kvm_plane_read_guest(kvm->planes[i], gfn_to_gpa(gfn),
+					 &seq, sizeof(seq))) {
+			set_bit(i, hv->hv_tsc_page_broken);
+			continue;
+		}
+
+		seen[nr_seen++] = seq;
+	}
+
+	for (i = 0; i < nr_seen; i++)
+		hi = max(hi, seen[i]);
+
+	seq = hi + 1;
+	while (!hv_tsc_seq_valid(seq, seen, nr_seen))
+		seq++;
+
+	return seq;
+}
+
 void kvm_hv_setup_tsc_page(struct kvm *kvm,
 			   struct pvclock_vcpu_time_info *hv_clock)
 {
 	struct kvm_hv *hv = to_kvm_hv(kvm);
 	u32 tsc_seq;
+	int plane;
 	u64 gfn;
 
 	BUILD_BUG_ON(sizeof(tsc_seq) != sizeof(hv->tsc_ref.tsc_sequence));
@@ -1199,68 +1419,92 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 
 	guard(mutex)(&hv->hv_lock);
 
-	if (hv->hv_tsc_page_status == HV_TSC_PAGE_BROKEN ||
-	    hv->hv_tsc_page_status == HV_TSC_PAGE_SET ||
+	if (hv->hv_tsc_page_status == HV_TSC_PAGE_SET ||
 	    hv->hv_tsc_page_status == HV_TSC_PAGE_UNSET)
 		return;
 
-	if (!(hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE))
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
 
-	gfn = hv->hv_tsc_page >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
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
 
-		hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
+			/*
+			 * reserved1 is whatever the guest left there; it must
+			 * not reach another plane's page with a later publish.
+			 */
+			hv->tsc_ref.reserved1 = 0;
+			hv->tsc_ref_from_guest = true;
+			hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
+			hv_invalidate_mismatched_tsc_pages(kvm, plane);
+			return;
+		}
+	} else if (hv_first_tsc_page(kvm, &gfn) < 0) {
 		return;
 	}
 
+	tsc_seq = hv_next_tsc_sequence(kvm);
+
 	/*
 	 * While we're computing and writing the parameters, force the
 	 * guest to use the time reference count MSR.
 	 */
 	hv->tsc_ref.tsc_sequence = 0;
-	if (kvm_write_guest(kvm, gfn_to_gpa(gfn),
-			    &hv->tsc_ref, sizeof(hv->tsc_ref.tsc_sequence)))
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
-	if (kvm_write_guest(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, sizeof(hv->tsc_ref)))
-		goto out_err;
+	hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref));
 
 	/*
-	 * Now switch to the TSC page mechanism by writing the sequence.
+	 * Now switch to the TSC page mechanism by writing the sequence.  It
+	 * differs from every sequence the pages held before the rewrite, so
+	 * a reader that sampled one of those cannot accept the new body.
 	 */
-	tsc_seq++;
-	if (tsc_seq == 0xFFFFFFFF || tsc_seq == 0)
-		tsc_seq = 1;
+	hv->hv_tsc_sequence = tsc_seq;
 
 	/* Write the struct entirely before the non-zero sequence.  */
 	smp_wmb();
 
 	hv->tsc_ref.tsc_sequence = tsc_seq;
-	if (kvm_write_guest(kvm, gfn_to_gpa(gfn),
-			    &hv->tsc_ref, sizeof(hv->tsc_ref.tsc_sequence)))
-		goto out_err;
+	hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence));
 
+	hv->tsc_ref_from_guest = false;
 	hv->hv_tsc_page_status = HV_TSC_PAGE_SET;
-	return;
-
-out_err:
-	hv->hv_tsc_page_status = HV_TSC_PAGE_BROKEN;
 }
 
 void kvm_hv_request_tsc_page_update(struct kvm *kvm)
@@ -1460,9 +1704,47 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		hv->hv_hypercall[vcpu->plane_level] = data;
 		break;
 	}
-	case HV_X64_MSR_REFERENCE_TSC:
-		hv->hv_tsc_page = data;
-		if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE) {
+	case HV_X64_MSR_REFERENCE_TSC: {
+		u64 gfn;
+
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
+		if (!host && hv->hv_tsc_page_status == HV_TSC_PAGE_SET &&
+		    !hv->tsc_ref_from_guest &&
+		    (data & HV_X64_MSR_TSC_REFERENCE_ENABLE)) {
+			/* The caller holds hv_lock. */
+			gfn = data >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
+			if (hv_publish_tsc_page(kvm, vcpu->plane_level, gfn))
+				break;
+			/* The page holds the current sequence: full update. */
+		}
+
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
+		/* Another plane's page may still be enabled: keep it updated. */
+		if (hv_first_tsc_page(kvm, &gfn) >= 0) {
 			if (!host)
 				hv->hv_tsc_page_status = HV_TSC_PAGE_GUEST_CHANGED;
 			else
@@ -1472,6 +1754,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 			hv->hv_tsc_page_status = HV_TSC_PAGE_UNSET;
 		}
 		break;
+	}
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 		return kvm_hv_msr_set_crash_data(kvm,
 						 msr - HV_X64_MSR_CRASH_P0,
@@ -1676,10 +1959,10 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		data = hv->hv_hypercall[vcpu->plane_level];
 		break;
 	case HV_X64_MSR_TIME_REF_COUNT:
-		data = get_time_ref_counter(kvm);
+		data = get_time_ref_counter(vcpu);
 		break;
 	case HV_X64_MSR_REFERENCE_TSC:
-		data = hv->hv_tsc_page;
+		data = hv->hv_tsc_page_plane[vcpu->plane_level];
 		break;
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 		return kvm_hv_msr_get_crash_data(kvm,
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index a9ca853dfb8a..d9e2767ed45d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1549,6 +1549,10 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn, const void *data,
 			 int offset, int len);
 int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 		    unsigned long len);
+int kvm_plane_write_guest(struct kvm_plane *plane, gpa_t gpa, const void *data,
+			  unsigned long len);
+int kvm_plane_read_guest(struct kvm_plane *plane, gpa_t gpa, void *data,
+			 unsigned long len);
 int kvm_write_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 			   void *data, unsigned long len);
 int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 65c33dbaa245..49d67a337c14 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -3978,6 +3978,56 @@ int kvm_write_guest(struct kvm *kvm, gpa_t gpa, const void *data,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_write_guest);
 
+/*
+ * Write a page KVM maintains for the guest on behalf of plane @plane,
+ * honouring that plane's memory attributes rather than plane 0's.
+ */
+int kvm_plane_write_guest(struct kvm_plane *plane, gpa_t gpa, const void *data,
+			  unsigned long len)
+{
+	struct kvm *kvm = plane->kvm;
+	gfn_t gfn = gpa >> PAGE_SHIFT;
+	int seg;
+	int offset = offset_in_page(gpa);
+	int ret;
+
+	while ((seg = next_segment(len, offset)) != 0) {
+		ret = __kvm_write_guest_page(plane, gfn_to_memslot(kvm, gfn),
+					     gfn, data, offset, seg);
+		if (ret < 0)
+			return ret;
+		offset = 0;
+		len -= seg;
+		data += seg;
+		++gfn;
+	}
+	return 0;
+}
+
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
+		offset = 0;
+		len -= seg;
+		data += seg;
+		++gfn;
+	}
+	return 0;
+}
+
 int kvm_vcpu_write_guest(struct kvm_vcpu *vcpu, gpa_t gpa, const void *data,
 		         unsigned long len)
 {
-- 
2.50.1

