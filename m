Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BF948E0E7;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239910; cv=none; b=RvHpz5wbmEY/uOajf2uKabxOZSxiQ21wCGoS14EzpJt+PNB7JHTlqNUhvQlSQYbinMpg800Tdy0Y/Bn8tZRepWGzC1QF9l8PaRGrLqbU4muNGcVe73i9QaxhZLk+17K0wc9a+g4mTAGSBIh566JaJ25BUW3KUW/fRLD9W4EnKY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239910; c=relaxed/simple;
	bh=gpgbmpVTuvkUvr3Y8dEZrPoq9FOqDQ/toOH1EY1XBoY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t42BtTOIUhVAqwqqJhoEKfCx6GSVkRiMMx0lGEooY3B5eEFEqGIv3EEcLjKg4MoAuXUUCHmiDMoFmDvSXoScD185iviFXMHWB2GIrY7Y+t9L7BFMnEm32UhFxtGihrfucyLY+Ym0+K1APoDLXrOJ4FLuKdYr+G8mKW71h8eh1s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uc9rRUEc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uc9rRUEc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y76FpczcTSJWSvyAdqegtdV9pX7YeBM7KQZUWMNkzaI=; b=Uc9rRUEclejXaaWK88cDqniUmS
	lB2nhST8kO1A3NNCQRG2wN2asBVycFk/xIcaAq15boPbKgqBhdKLUqTywSLCA6HjYPNrt5bajPbzT
	WtIo9Z3rD/2doeo4BPHs3Q9SQNvL7tKGgr1YJYmh7dJ1W4LjQy0f9WoTAqoEwKKuwHpV0l1ys2SFt
	htoOyiN7udWscZQ1SPVXQQAJtvD3pGSQTzcYGKeXoh7O/7+WghKFI350kAtjnYETCF4ivss399/AQ
	9VO4ZzvNlHs4t94yEk0rAHkJTj+ljujrGpIncE5m0wfMLXH7DD/Iebohhvj9N/0Je9a7BhOgThiYS
	VXBUd9wQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVD3-3NqI;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnJ-2P48;
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
Subject: [RFC PATCH 36/55] KVM: x86: hyperv: Track the reference TSC page per plane
Date: Sat, 17 Oct 2026 13:24:42 +0100
Message-ID: <20261017122501.610248-37-dwmw2@infradead.org>
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

From: Mushahid Hussain <hmushi@amazon.co.uk>

HV_X64_MSR_REFERENCE_TSC is private to each Virtual Trust Level: the
secure VTL maps its own page.  The reference time behind the pages is
one clock per partition, so every page must show the same scale, offset
and sequence.

KVM keeps a single page address per VM.  A write from another plane
replaces it, the old page stops being updated and the new page starts a
sequence of its own.  Keep the MSR value per plane and write the shared
page contents to every enabled page.  The lowest enabled plane owns the
sequence number; disabling one plane's page keeps the others updated.

Assisted-by: LLM
[dwmw2: our tree already banks the MSR per plane (fbdffa08a242) with a
  one-shot copy for higher planes; replace that with the maintained
  pages, keeping the bank in kvm_hv rather than kvm_arch_plane. ]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |   6 +-
 arch/x86/kvm/hyperv.c           | 118 +++++++++++++++-----------------
 2 files changed, 58 insertions(+), 66 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 5945b57c091d..d913c68b18a7 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1255,8 +1255,10 @@ struct kvm_hv {
 	u64 hv_guest_os_id[KVM_MAX_PLANES];
 	u64 hv_hypercall[KVM_MAX_PLANES];
 	bool hv_forward_hcalls;
-	u64 hv_tsc_page;
-	/* Banked REFERENCE_TSC MSR values for non-zero planes (VTLs). */
+	/*
+	 * HV_X64_MSR_REFERENCE_TSC is private to each VTL, the reference time
+	 * it exposes is not: every enabled page gets the same contents.
+	 */
 	u64 hv_tsc_page_plane[KVM_MAX_PLANES];
 	enum hv_tsc_page_status hv_tsc_page_status;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 759589c6de87..2098daede7d3 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1224,6 +1224,49 @@ static inline bool tsc_page_update_unsafe(struct kvm_hv *hv)
 		hv->hv_tsc_emulation_control;
 }
 
+static bool hv_tsc_page_gfn(struct kvm_hv *hv, int plane, u64 *gfn)
+{
+	u64 msr = hv->hv_tsc_page_plane[plane];
+
+	if (!(msr & HV_X64_MSR_TSC_REFERENCE_ENABLE))
+		return false;
+
+	*gfn = msr >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
+	return true;
+}
+
+/* The lowest plane with an enabled page; it owns the sequence number. */
+static bool hv_first_tsc_page_gfn(struct kvm *kvm, u64 *gfn)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	int i;
+
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		if (hv_tsc_page_gfn(hv, i, gfn))
+			return true;
+	}
+
+	return false;
+}
+
+/* Write the first @len bytes of the reference page to every enabled plane. */
+static int hv_write_tsc_pages(struct kvm *kvm, size_t len)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	u64 gfn;
+	int i;
+
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		if (!hv_tsc_page_gfn(hv, i, &gfn))
+			continue;
+
+		if (kvm_write_guest(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, len))
+			return -EFAULT;
+	}
+
+	return 0;
+}
+
 void kvm_hv_setup_tsc_page(struct kvm *kvm,
 			   struct pvclock_vcpu_time_info *hv_clock)
 {
@@ -1241,10 +1284,9 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 	    hv->hv_tsc_page_status == HV_TSC_PAGE_UNSET)
 		return;
 
-	if (!(hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE))
+	if (!hv_first_tsc_page_gfn(kvm, &gfn))
 		return;
 
-	gfn = hv->hv_tsc_page >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
 	/*
 	 * Because the TSC parameters only vary when there is a
 	 * change in the master clock, do not bother with caching.
@@ -1267,8 +1309,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 	 * guest to use the time reference count MSR.
 	 */
 	hv->tsc_ref.tsc_sequence = 0;
-	if (kvm_write_guest(kvm, gfn_to_gpa(gfn),
-			    &hv->tsc_ref, sizeof(hv->tsc_ref.tsc_sequence)))
+	if (hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence)))
 		goto out_err;
 
 	if (!compute_tsc_page_parameters(hv_clock, &hv->tsc_ref))
@@ -1276,7 +1317,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 
 	/* Ensure sequence is zero before writing the rest of the struct.  */
 	smp_wmb();
-	if (kvm_write_guest(kvm, gfn_to_gpa(gfn), &hv->tsc_ref, sizeof(hv->tsc_ref)))
+	if (hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref)))
 		goto out_err;
 
 	/*
@@ -1290,8 +1331,7 @@ void kvm_hv_setup_tsc_page(struct kvm *kvm,
 	smp_wmb();
 
 	hv->tsc_ref.tsc_sequence = tsc_seq;
-	if (kvm_write_guest(kvm, gfn_to_gpa(gfn),
-			    &hv->tsc_ref, sizeof(hv->tsc_ref.tsc_sequence)))
+	if (hv_write_tsc_pages(kvm, sizeof(hv->tsc_ref.tsc_sequence)))
 		goto out_err;
 
 	hv->tsc_ref_from_guest = false;
@@ -1499,61 +1539,12 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 		hv->hv_hypercall[vcpu->plane_level] = data;
 		break;
 	}
-	case HV_X64_MSR_REFERENCE_TSC:
-		/*
-		 * The reference TSC page is a per-VTL instance.  Plane 0 keeps
-		 * the live masterclock-maintained page; a non-zero plane gets
-		 * a one-shot copy of the current parameters, which stay valid
-		 * while the masterclock is stable.
-		 */
-		if (vcpu->plane_level) {
-			struct ms_hyperv_tsc_page tsc_ref = {};
-			u32 tsc_seq;
-			u64 gfn;
-
-			hv->hv_tsc_page_plane[vcpu->plane_level] = data;
-			if (!(data & HV_X64_MSR_TSC_REFERENCE_ENABLE))
-				break;
-
-			/*
-			 * Copy only host-computed parameters.  After a
-			 * masterclock change under guest TSC emulation,
-			 * hv->tsc_ref holds values read back from the
-			 * plane-0 page, which the lowest VTL can write;
-			 * presenting those to another plane would let it
-			 * forge that plane's clock.  Without usable
-			 * parameters, publish an invalid (zero) sequence so
-			 * the plane falls back to the TIME_REF_COUNT MSR.
-			 */
-			if (hv->hv_tsc_page_status == HV_TSC_PAGE_SET &&
-			    !hv->tsc_ref_from_guest)
-				tsc_ref = hv->tsc_ref;
-
-			gfn = data >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
-			tsc_seq = tsc_ref.tsc_sequence;
-
-			/*
-			 * Write the body under a zero sequence, then the
-			 * real sequence, so a concurrent reader on this
-			 * plane never consumes torn parameters.
-			 */
-			tsc_ref.tsc_sequence = 0;
-			if (kvm_vcpu_write_guest(vcpu, gfn_to_gpa(gfn),
-						 &tsc_ref, sizeof(tsc_ref)))
-				return 1;
-
-			if (!tsc_seq)
-				break;
+	case HV_X64_MSR_REFERENCE_TSC: {
+		u64 gfn;
 
-			tsc_ref.tsc_sequence = tsc_seq;
-			if (kvm_vcpu_write_guest(vcpu, gfn_to_gpa(gfn),
-						 &tsc_ref,
-						 sizeof(tsc_ref.tsc_sequence)))
-				return 1;
-			break;
-		}
-		hv->hv_tsc_page = data;
-		if (hv->hv_tsc_page & HV_X64_MSR_TSC_REFERENCE_ENABLE) {
+		hv->hv_tsc_page_plane[vcpu->plane_level] = data;
+		/* Another plane's page may still be enabled: keep it updated. */
+		if (hv_first_tsc_page_gfn(kvm, &gfn)) {
 			if (!host)
 				hv->hv_tsc_page_status = HV_TSC_PAGE_GUEST_CHANGED;
 			else
@@ -1563,6 +1554,7 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 			hv->hv_tsc_page_status = HV_TSC_PAGE_UNSET;
 		}
 		break;
+	}
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 		return kvm_hv_msr_set_crash_data(kvm,
 						 msr - HV_X64_MSR_CRASH_P0,
@@ -1786,9 +1778,7 @@ static int kvm_hv_get_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 *pdata,
 		data = get_time_ref_counter(kvm);
 		break;
 	case HV_X64_MSR_REFERENCE_TSC:
-		data = vcpu->plane_level ?
-		       hv->hv_tsc_page_plane[vcpu->plane_level] :
-		       hv->hv_tsc_page;
+		data = hv->hv_tsc_page_plane[vcpu->plane_level];
 		break;
 	case HV_X64_MSR_CRASH_P0 ... HV_X64_MSR_CRASH_P4:
 		return kvm_hv_msr_get_crash_data(kvm,
-- 
2.50.1

