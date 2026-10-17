Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A394429803;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239908; cv=none; b=qWn+6FOEsoyvoi2jH0xqVQ44CUfzEOvThwDnPKUiVTWntL6s3GP2N4C4RBq0qLik2CADqQ7dlvJyTrouvzlVSgtBsU0+g6h8n5rTcTwTyYDUL3StX8EO4trWiNPt3ZacZmVHDliP1c0UAJ5VSmsbh1l1ryi37fsVgIUbW4c/ZIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239908; c=relaxed/simple;
	bh=EdNJE8nsrv2gQ1P+023l3H/rmBoAKuuBjr/pt/ysCe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d75s7oSRDjofjWWTsCabemBAYd9nCyQX60WDpJmdMALiKeV98x6YC5Z25WL+J0ABgEKZIliuNoMYzZdn7Ft2bndVbE2XXrJyQe6lCrKqS7Zd6q7bhY1RAvyODrgkFSYpYZFXrgucwUK2OTO0XHJWOuFXTAk5sClBUUjhGiIMsA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C3+TRrsZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C3+TRrsZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=DxaL2iW2qw0lcd/aZ0U76T4CgYFPlUAXsADikihu4L4=; b=C3+TRrsZJKP0qlDF4u2c9Gc95d
	9nEcuw2LFUjSgNKwU4zlc2enZc9F8zgLkMVNlqncof3seCIlzIr1UTcL0ypj5PbmwC/yD6/ILDj2L
	tn6bSKypAhOySiZ+KNigT+NRVTvlPX1uMepR8XDma42v6VyztcVpTyhgBFHAD8rtBrcEGmbKkKSYR
	qMQZcjZICPsH6Cvnbgdj77KcHEneQv4Ul3SDsBYx1atxFFVzc4/Vxgi2Xo2IZsVHrvTWNh4sXmOK8
	zPj/T+AcednIXtn+x44FuJZiL5qItitkUm19J6D2FzVwximZrXPUzpt0uIGWqzjyYs3p7l0Ea5QNI
	ry5GNIfQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCS-3xDs;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Ym7-2xZi;
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
Subject: [RFC PATCH 19/55] KVM: x86: hyperv: don't arm PV EOI for a higher plane's VP assist page
Date: Sat, 17 Oct 2026 13:24:25 +0100
Message-ID: <20261017122501.610248-20-dwmw2@infradead.org>
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

Registering the VP assist page arms the PV EOI / APIC assist
optimisation through a gfn_to_hva cache, and that cache refuses ranges
carrying RW memory protections in plane 0's view. The Windows secure
kernel places its VTL1 assist page in memory it has protected against
VTL0, so the MSR write failed and VTL1 had no assist page at all: no
VTL entry reasons, no VTL-return register control, no boot.

Register the page without arming PV EOI when the vCPU is in a plane
above 0. KVM then never sets the no-EOI-required bit for that plane,
so the guest always performs a real EOI; only the fast path is lost.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/hyperv.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 797c5cbfbbaf..ea80536caa48 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -1609,7 +1609,8 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
 			hv_vcpu->hv_vapic = data;
-			if (kvm_lapic_set_pv_eoi(vcpu, 0, 0))
+			if (!vcpu->plane_level &&
+			    kvm_lapic_set_pv_eoi(vcpu, 0, 0))
 				return 1;
 			break;
 		}
@@ -1627,9 +1628,24 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 			return 1;
 		hv_vcpu->hv_vapic = data;
 		kvm_vcpu_mark_page_dirty(vcpu, gfn);
-		if (kvm_lapic_set_pv_eoi(vcpu,
-					    gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
-					    sizeof(struct hv_vp_assist_page)))
+
+		/*
+		 * The gfn_to_hva cache behind the PV EOI / APIC assist
+		 * optimization validates against plane 0's memory
+		 * attributes, and a higher plane's VP assist page may
+		 * live on a page the plane protected against plane 0
+		 * (the Windows secure kernel's does). Don't arm PV EOI
+		 * there: pv_eoi.msr_val stays clear, which keeps
+		 * kvm_hv_assist_page_enabled() false for the plane, so
+		 * every assist-page consumer behind it (PV EOI, nested
+		 * enlightened VMCS, the SVM VP-assist read) is disabled
+		 * and KVM never touches the page's contents.  The guest
+		 * always performs a real EOI.
+		 */
+		if (!vcpu->plane_level &&
+		    kvm_lapic_set_pv_eoi(vcpu,
+					 gfn_to_gpa(gfn) | KVM_MSR_ENABLED,
+					 sizeof(struct hv_vp_assist_page)))
 			return 1;
 		break;
 	}
-- 
2.50.1

