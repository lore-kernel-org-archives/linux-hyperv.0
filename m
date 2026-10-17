Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6044D4915B2;
	Sat, 17 Oct 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239919; cv=none; b=XTaM3a22LHNL7Vj778CGV4pxYmP1h3o2Y3lQwC+HOBdsUeMgbeQYbWTc1qg4vu+7mPlF+U+cOGNlrL2a1it0W4lDbVGlNuKEFSDiksqrobOkFd9SFXqFTgdRs+fm1/hD/cg3LqZBFKiQAkdaEce2YXQy7bVZZKCVVOMM1JAKcLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239919; c=relaxed/simple;
	bh=7r5Ht9ZsGh/lZucm/pDXX+TOLzFxEFFqPqVN1bFEKvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJcG4Wr/QdMhJ/eCWanUf4xp+Z/D00z4OmpEYfsfXcvZF5DO2qIgVCHmp1dP/RG3Efriu6wLHrjE/D8sUiTTuVtc+f8wX/0l4nUc7ikPZpKpRVYNIoNRcQ4IczsfxzAxntgl30npclA2hnjNqIvmxSkesanEHQFG8blwpnv2THY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oQ+s8AQt; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oQ+s8AQt"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=hIpX2z4J/zHLuiT0wf9BCHicolLiglUK/HfkUxZ79rg=; b=oQ+s8AQtnmJNCD1Di3vDl/iA5S
	sfJZgLnqM1JNdrY6gpFUSQiWp19IeKGYfuhQwMTbUmSldfABFm8QlHnwkLV0zUo3YUGHXNuE5cSwm
	4wibULF/sCDGZsT6O1L1VoamVYMTMaqe7CZH2qfCV4zz8cUNDbYY1TSKre1/cAqZ4FxfM+UnC8uQ6
	cnC1pHMPxb9dz2yLsn5FEHkRt2301Yvc59+79uZ4pw2Fh6Tv1L0Lh29VCeLaqIqG1YjkWNYzWQTvd
	aAnt9agolj8zLCrBGyC1PqqmnC+AyrvsXsYSYt6+l2JK2jSCpB1LJ1WTT+OomPeDIl28xLmR2EYRe
	nb7/GXuA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfK-1cEo;
	Sat, 17 Oct 2026 12:25:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Ylz-2lw3;
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
Subject: [RFC PATCH 18/55] KVM: x86/mmu: free obsolete roots of all planes
Date: Sat, 17 Oct 2026 13:24:24 +0100
Message-ID: <20261017122501.610248-19-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

KVM_REQ_MMU_FREE_OBSOLETE_ROOTS lives in the request set shared by all
planes of a vCPU. A fast zap (e.g. memslot deletion) invalidates
*every* plane's TDP roots and raises the request once per vCPU, but
whichever plane enters the guest next consumes the shared bit and
frees only its own obsolete roots. The other planes keep an obsolete
root with a valid-looking root.hpa, kvm_mmu_reload() does nothing for
them, and every page fault bails out in is_page_fault_stale() with
RET_PF_RETRY: the vCPU livelocks taking the same EPT violation
forever. Observed with a Windows VSM guest spinning at ~18k EPT
violations/s after a memslot update during boot, the root obsolete
(inv=1 obs=1) and the request already consumed (req=0).

Service every plane twin in kvm_mmu_free_obsolete_roots(). The
inactive twins cannot be running (all planes of a vCPU share one
thread), so their MMUs are stable.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/mmu/mmu.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 177b2e71bf35..cdebb5c324fe 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6234,8 +6234,23 @@ static void __kvm_mmu_free_obsolete_roots(struct kvm *kvm, struct kvm_mmu *mmu)
 
 void kvm_mmu_free_obsolete_roots(struct kvm_vcpu *vcpu)
 {
-	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.root_mmu);
-	__kvm_mmu_free_obsolete_roots(vcpu->kvm, &vcpu->arch.guest_mmu);
+	struct kvm_vcpu *v;
+	int i;
+
+	/*
+	 * KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is tracked in the request set
+	 * shared by all of the vCPU's planes, so the plane that consumes
+	 * the request is not necessarily the plane whose root is obsolete.
+	 * Service every plane: the inactive twins cannot be running (all
+	 * planes of a vCPU share one thread), so their MMUs are stable.
+	 */
+	for (i = 0; i < KVM_MAX_PLANES; i++) {
+		v = vcpu->common->vcpus[i];
+		if (!v)
+			continue;
+		__kvm_mmu_free_obsolete_roots(v->kvm, &v->arch.root_mmu);
+		__kvm_mmu_free_obsolete_roots(v->kvm, &v->arch.guest_mmu);
+	}
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_mmu_free_obsolete_roots);
 
-- 
2.50.1

