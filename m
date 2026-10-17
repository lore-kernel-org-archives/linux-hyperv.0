Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6062249E14B;
	Sat, 17 Oct 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239919; cv=none; b=cSGIu3usuFQ0Fkwy+Mbi0iKzITD7HtgQ7kd/P5KBeK0m5thcJw6Ftvthsc/My78c2tmEMFmIwfYDQoaCNNbHDKDR/GBJRhsShgVV2eXZcAiSTbfwO+5eO4wDN8wHnRLdUuvFUSpiuXailzOVEyq3WT++fn9f9Nx55RE0C+QeAfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239919; c=relaxed/simple;
	bh=/LsXguQhmSy6cUDt/D5aWgMQWux/IuGLv1mKrD1Vnk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mkwyIAjN1pax4ct6KHW93PYZyqomBPsNGHeDnApmoaHaeAxG3etBucUybkOSria1fU6nH2A6MVLno82LVjFeSpi5MZs9t2hY/q6iXi6mh1zYbRfqU7X5s9PfdRwkPLw8m/5CVmnKvy77XZ1IuACH74f9Ul7tttPG0xC7SvnkYRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mfWP3tB7; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mfWP3tB7"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=c3Ad41yLZWa1cG22U8FT3RHf8ZklcirDatDO4x4kl/g=; b=mfWP3tB7tvEm0nqDbGsyqD5o2M
	G8+I35xRkkk8MsB7ozxCk5hJc1yo8mkEDoBd1fCJbnU+9wX/baqPLHeuU0c0LVYrlVU5O6zb9LILN
	1tjcSka4jxTSIwyW/UEodmKy8T/vlTK/5OgKVqiwak8S7funVqIjfnMTvHkZjzyKL9m6Vm3vSF7zE
	Oozr5b0Aa7esVlf0oxEGoLCRzt/Y5bCYhTHs3TgiZPkw/dmzSuMycusc1bRmcH3rDD+9dr7CWnLIJ
	03/k1EjCNFm2wIqXS9GT2Vnl0rbmugPrdBtZNEyyhuzrC/Ks+bGgUWm05hFARmjGtq5nl/tgU4BzJ
	D2OD2jug==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfJ-1bD0;
	Sat, 17 Oct 2026 12:25:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Ylu-2bKq;
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
Subject: [RFC PATCH 17/55] KVM: x86: hyper-v: flush the calling plane's TLB on flush hypercalls
Date: Sat, 17 Oct 2026 13:24:23 +0100
Message-ID: <20261017122501.610248-18-dwmw2@infradead.org>
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

From: David Woodhouse <dwmw@amazon.co.uk>

The Hyper-V TLB flush hypercalls resolve their target vCPUs through
the plane-0 array, so a flush issued from a non-zero plane flushed
only the plane-0 vCPUs and the caller's own plane kept stale
translations. The Windows secure kernel repopulated a PFN-database
page table entry, flushed, then took a fatal page fault on the very
address it had just mapped, because VTL1's TLB still held the old
read-only zero-page translation.

Resolve each flush target to the vCPU of the calling plane (falling
back to plane 0 where no such plane vCPU exists — it then has no TLB
to flush either) and raise the flush request on that vCPU directly.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/hyperv.c | 34 ++++++++++++++++++++++++++++++++--
 1 file changed, 32 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index eefc18c750f1..797c5cbfbbaf 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2122,6 +2122,23 @@ static int kvm_hv_hypercall_check_params(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/*
+ * A TLB flush hypercall flushes the caller's VTL view of the target VPs:
+ * resolve the target to the vCPU of the caller's plane, which has its own
+ * roots and TLB tag.  Fall back to plane 0 when the plane vCPU does not
+ * exist (it then has no TLB to flush either).
+ */
+static struct kvm_vcpu *hv_flush_plane_vcpu(struct kvm_vcpu *caller,
+					    struct kvm_vcpu *v)
+{
+	struct kvm_vcpu *pv;
+
+	if (!caller->plane_level)
+		return v;
+	pv = v->common->vcpus[caller->plane_level];
+	return pv ?: v;
+}
+
 static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -2257,12 +2274,18 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	if (all_cpus && !is_guest_mode(vcpu)) {
 		kvm_for_each_vcpu(i, v, kvm) {
+			v = hv_flush_plane_vcpu(vcpu, v);
 			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
 			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
 					     tlb_flush_entries, hc->rep_cnt);
+			if (vcpu->plane_level) {
+				kvm_make_request(KVM_REQ_HV_TLB_FLUSH, v);
+				kvm_vcpu_kick(v);
+			}
 		}
 
-		kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
+		if (!vcpu->plane_level)
+			kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
 	} else if (!is_guest_mode(vcpu)) {
 		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
 
@@ -2270,12 +2293,19 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
+			v = hv_flush_plane_vcpu(vcpu, v);
 			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
 			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
 					     tlb_flush_entries, hc->rep_cnt);
+			if (vcpu->plane_level) {
+				kvm_make_request(KVM_REQ_HV_TLB_FLUSH, v);
+				kvm_vcpu_kick(v);
+			}
 		}
 
-		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
+		if (!vcpu->plane_level)
+			kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
+						    vcpu_mask);
 	} else {
 		struct kvm_vcpu_hv *hv_v;
 
-- 
2.50.1

