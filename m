Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=I/fJX9NJSOO8Aq34ZX4W2X4Os9RIyk0Y0HpHmTgLXjrC50MhgHR2roy99Hhl4nSk0P6a
	 oi4RzhTgFyXCIbUuOZqhMcY0vQz3Gxg/QQTaeScls6XnkVlK2cLEPGNex2UPAFtzi6252
	 8+H3kD/z/aA8qQ5oj/QC36CEtM4Tl8pi1Fe6eEa44dOVZ/LJRlt5zxARb9rnkIbYiSZ7P
	 2uUSfiL1yH8EsoLFDEGvxMWGFGFzy5VpZsBtJtU0L8oeVTv/SdzXh46Ki15v5iNv3auLj
	 EXNYsDJHvdQ0FmwAwMFKt4SWTrYQgyzwywgvebF2jwBXv4qryXwhbt3KdO3MkF2ahjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=0Cl0a5kPfo+ipQHDzIEiC2qq51g/gbiIgXYfpno780k=;
	b=gg/Klmq5pfchAI18FbHKQO/N//1d5aOEZycsQ4lnDOeigmi55MJ5c+x8H5kjfiMdn/cX
	 /CdEm8gSGc1vaw5rW1geXKlWdzZ6+C1gHNpiXquilkDGctvFEgmHqVSQTv17cYoX3SVNT
	 +2f2qDtrYuvFrZZd5wrB3zJI/8JjRvMjam+oXsTkzNWNc723vVYTvxm1+eJOLsjd1GWMM
	 LvkHqQP0LrgaEou0INvGql/JGeCUle5/2ZqQ1t6owg0go5EtRPvOXEitdNJf4Vxuxa5wP
	 GjdgIxXW3ZF4Hlz3mSsxBuwOPnhFbP/UNrf+jRLHuikIAY614AmPfv1iuU2TTUkhkRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=K8KTZBxL;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFE6606A331;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFE6606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=K8KTZBxL
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=0Cl0a5kPfo+ipQHDzIEiC2qq51g/gbiIgXYfpno780k=; b=K8KTZBxL+9sQDaY2yF3OL5WtVO
	jdAL4E2z5Ca7niqdsgARkfgqeFdpMVDJJWkrnLDt7UnFe8fEfrdj7xYwzdt6PY43NKBaNdrO7vUgU
	PmX3qOMhxNVLc3a2qEfCve16SfG1EFIPbWg8j1LzTUb00+l6P3vTiq6RzZNtCKxspnXFwZSRe9MH0
	qgjIQi/jztLzAdCOI6/eB68boLODjPeJyq6+Tbggv72q7vcHGaC7FEr5dRA9V8eJEnXLy9/WiVRIE
	Fj52RuhFf1F1XmmnBuQdNafLvsD88Mx3WGFMBSkvkuOFmBUOeEGVfjYsl9GVbxtF+cUU6W5Y5IcbY
	P8p/EHkA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPW-2Mhd;
	Fri, 13 Nov 2026 18:34:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lsn-1Swt;
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
Subject: [RFC PATCH v2 05/31] KVM: x86: hyperv: Don't arm PV EOI for a higher plane's VP assist page
Date: Fri, 13 Nov 2026 18:34:21 +0000
Message-ID: <20261113183448.84094-6-dwmw2@infradead.org>
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

Registering the VP assist page arms the PV EOI / APIC assist
optimisation through a gfn_to_hva cache, and that cache refuses ranges
carrying RW memory protections in plane 0's view. The Windows secure
kernel places its VTL1 assist page in memory it has protected against
VTL0, so the MSR write failed and VTL1 had no assist page at all: no
VTL entry reasons, no VTL-return register control, no boot.

Register the page without arming PV EOI when the vCPU is in a plane
above 0. KVM then never sets the no-EOI-required bit for that plane,
so the guest always performs a real EOI; only the fast path is lost.
kvm_hv_assist_page_enabled() reports false for any plane above 0, so
that nothing else (MSR_KVM_PV_EOI_EN on that plane included) can arm
the assist-page consumers there.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/kvm/hyperv.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 65c39b30dae7..8969e964cc0c 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -939,7 +939,12 @@ bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	if (!hv_vcpu)
+	/*
+	 * A higher plane's assist page is never armed for KVM's own use
+	 * (see HV_X64_MSR_VP_ASSIST_PAGE), however pv_eoi.msr_val came to
+	 * be set: MSR_KVM_PV_EOI_EN can arm a one-byte cache on that plane.
+	 */
+	if (!hv_vcpu || vcpu->plane_level)
 		return false;
 
 	if (!(hv_vcpu->hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
@@ -1867,7 +1872,8 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
 
 		if (!(data & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE)) {
 			hv_vcpu->hv_vapic = data;
-			if (kvm_lapic_set_pv_eoi(vcpu, 0, 0))
+			if (!vcpu->plane_level &&
+			    kvm_lapic_set_pv_eoi(vcpu, 0, 0))
 				return 1;
 			break;
 		}
@@ -1885,9 +1891,23 @@ static int kvm_hv_set_msr(struct kvm_vcpu *vcpu, u32 msr, u64 data, bool host)
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
+		 * there, and kvm_hv_assist_page_enabled() stays false for
+		 * the plane, so every assist-page consumer behind it (PV
+		 * EOI, nested enlightened VMCS, the SVM VP-assist read) is
+		 * disabled and KVM never touches the page's contents.  The
+		 * guest always performs a real EOI.
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

