Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399EC494293;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=BmCP1Y3d6Kp9TerHPkV/NWToQzB3/DaCRNLLaaNiX5KTCmkSjo+5hBdR69QmwHrFHRfVuHLT3ZCss7fAYcnfjoI/Hp3OBY4FPS4PIQ1V12iR5VhXbhbdHIcqWneD2yr7szHkiB85L9uFBVIiITbFmtS6sQEcEw859L2eUxEykvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=+eLVMZaRtRfhp39b8b5gmU6SqJVY/BDTAQ/uvvKaKFQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dwbbe28pFiAzDcXZoqZMkVxHODB8QMO/keqJwPJvwbKml+ST8aHK6XySBX64YwGjO/SHWRv0eVYu2WuNcwgK6pf2e7AbS7J8lF2f2uLqT1tnewSUxM7GvOmZBGho5zIJ54dx6xl+hGLZk0Uyvnb4qkbTb3OOWtY5Zxbk+ItQKoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BHYcytaa; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BHYcytaa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=BWQ9xCxoUPDW0ekf2ca01FyVp2H9/ZL3zRkhryEgmkw=; b=BHYcytaajnDzoKRiuha7WjShO0
	MgUTNR+bS/6/MIPVzFhmdgug3B/A3SUyrNtKQaayvKibZfzYd4TvGZC67kdVOTp2At29r1ExTrkJZ
	5ngxJKDBnWuRe7AJJtfXWVVqvDU2cDDhh+ostkRnc0/Wy3SZssfTkm0WVL9iMnf1qs1AHTh+9Y2SZ
	N15x5mBedc2VdFuLIkWdmNmrlU2E46syYfVxv3NOGzlJ70jLrDN/IOxtsvEX3TCmLmc6V8BzWKcVz
	SllQewDfjRl4Ax2fpDXZAHA7mODM2CP6XpK8KsrqKdoVMuXmZykcu/xzYUI2S9ubnyAzM009X1h88
	Rd0wuHzw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfV-1xVH;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002YnR-2pDS;
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
Subject: [RFC PATCH 38/55] KVM: x86: hyperv: Publish an added reference TSC page at once
Date: Sat, 17 Oct 2026 13:24:44 +0100
Message-ID: <20261017122501.610248-39-dwmw2@infradead.org>
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

From: Mushahid Hussain <hmushi@amazon.co.uk>

When a plane enables its reference TSC page while another plane's page
is valid, KVM marks the partition's parameters changed and requests a
master clock update. The update writes sequence zero to every enabled
page, computes the parameters again, and writes them to every page. The
parameters have not changed, so the valid pages lose their validity for
nothing, and a guest that reads the time in that window falls back to
the time reference count register.

Write the current parameters to the page the plane enables, the struct
first and the sequence last, and leave the other pages and the status as
they are. Only the first page of the partition, or a change of the
parameters, takes the full update.

Assisted-by: LLM
[dwmw2: keep the tsc_ref_from_guest guard from fbdffa08a242: parameters
  read back from the plane-0 page never seed a higher plane's page; it
  gets a zero sequence instead, as the one-shot copy used to do. ]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c | 44 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index eebe48f5be23..2cf73f72836c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1235,6 +1235,39 @@ static bool hv_tsc_page_gfn(struct kvm_hv *hv, int plane, u64 *gfn)
 	return true;
 }
 
+/* Publish the current parameters to one plane's page: struct first, then sequence. */
+static int hv_publish_tsc_page(struct kvm *kvm, unsigned int plane, u64 gfn)
+{
+	struct kvm_hv *hv = to_kvm_hv(kvm);
+	struct ms_hyperv_tsc_page page = hv->tsc_ref;
+	u32 tsc_seq = page.tsc_sequence;
+
+	/*
+	 * Parameters read back from the plane-0 page under guest TSC
+	 * emulation are plane-0-writable; handing them to a higher plane
+	 * would let the lowest VTL forge that plane's clock.  Publish a
+	 * zero sequence there instead: the plane falls back to the
+	 * TIME_REF_COUNT MSR.
+	 */
+	if (plane && hv->tsc_ref_from_guest)
+		tsc_seq = 0;
+
+	page.tsc_sequence = 0;
+	if (kvm_write_guest_unprotected(kvm, gfn_to_gpa(gfn), &page, sizeof(page)))
+		return -EFAULT;
+
+	if (!tsc_seq)
+		return 0;
+
+	/* The struct is complete before the sequence makes it valid. */
+	smp_wmb();
+	page.tsc_sequence = tsc_seq;
+	if (kvm_write_guest_unprotected(kvm, gfn_to_gpa(gfn), &page,
+					sizeof(page.tsc_sequence)))
+		return -EFAULT;
+	return 0;
+}
+
 /* The lowest plane with an enabled page; it owns the sequence number. */
 static bool hv_first_tsc_page_gfn(struct kvm *kvm, u64 *gfn)
 {
@@ -1542,6 +1575,17 @@ static int kvm_hv_set_msr_pw(struct kvm_vcpu *vcpu, u32 msr, u64 data,
 	case HV_X64_MSR_REFERENCE_TSC: {
 		u64 gfn;
 
+		/* The parameters are valid already: publish them to this page only. */
+		if (!host && hv->hv_tsc_page_status == HV_TSC_PAGE_SET &&
+		    (data & HV_X64_MSR_TSC_REFERENCE_ENABLE)) {
+			/* The caller holds hv_lock. */
+			hv->hv_tsc_page_plane[vcpu->plane_level] = data;
+			gfn = data >> HV_X64_MSR_TSC_REFERENCE_ADDRESS_SHIFT;
+			if (hv_publish_tsc_page(kvm, vcpu->plane_level, gfn))
+				hv->hv_tsc_page_status = HV_TSC_PAGE_BROKEN;
+			break;
+		}
+
 		hv->hv_tsc_page_plane[vcpu->plane_level] = data;
 		/* Another plane's page may still be enabled: keep it updated. */
 		if (hv_first_tsc_page_gfn(kvm, &gfn)) {
-- 
2.50.1

