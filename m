Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537648E0F3;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=bnKrPV+GLcaD/0WRh/k95wj5g6IH3PE5KUeylDlfMAaiP7Qmx4gkYBthDCXU3UVhKCd5+3Llpf8aDJBzWq2rE5Az014dJg2dtiOBxNF2wahLax4ExLR8WZcBdU1v8vB1eQBUDwQspueu5uiGxkxsnYAwMHgu1qO4dGnjc9h/1XA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=YmWAPTdE7JFm//2wSpZq0zHg7fsmkAideAHQvDZaLHY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/16LlKAWy1W+gp1ndenjB439skxXyT4kDASrX49C1Te9DCatMZmQSPBVOB45FVXZ85hwBX/YCwsogrxms85yqlj94vI1pMZNEL+lWWfrrjoiSYUA5huT1oX0TwfaRmPwK/GUO97dfoZz//dRp+gCQL8ZqweKfmPIKAZeiR2als=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=t6sKPgYK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t6sKPgYK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=XWh5KNFkAmFOR6TEW9zxrjvHeSZgS19hqXogLIStBpI=; b=t6sKPgYKWd3z1SZ/xz0SwuRZrR
	KE8rNOk+RmfWpRD9pmqeHKThGNOLVTLN1wBwIUaQmGBqOjjxDXZXe1w8Dv15+etDGeBmOb0iQ4zfM
	rSLKBjg+Rj/fOBs0GMpTTwapD17vi3fLv5LyeyDvG2g9UYYUNsGRTaOl8G6C1Fy6B7q9KgiXqfoHT
	WhdQSJU4g3lwzF8ITERyUgWdIPISLFG62vlPSM0EaZHfxg7xZvQ3NooEvct46rEGCIPty43Tu3ps+
	ICWrfHqn3g0fv47bnv7moGprQloZolf8022Bq3yIKA+CSyigawMwa0JAaQPsBLd60SSC+5+/LFdQc
	p9ZRBhFQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TD-0000000CVCd-3GKG;
	Sat, 17 Oct 2026 12:25:03 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ymx-1DL7;
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
Subject: [RFC PATCH 31/55] KVM: planes: Kick the running twin's pCPU, not the request target's
Date: Sat, 17 Oct 2026 13:24:37 +0100
Message-ID: <20261017122501.610248-32-dwmw2@infradead.org>
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

The remote kick paths (kvm_make_vcpus_request_mask(),
kvm_make_all_cpus_request(), __kvm_vcpu_kick()) read
READ_ONCE(vcpu->cpu) of the plane-0 vCPU. But vcpu->cpu is per plane
vCPU — kvm_arch_vcpu_load() refreshes only the loaded twin's copy —
while vcpu->mode is shared in kvm_vcpu_common. When the vCPU thread
has migrated pCPUs while a non-zero plane was loaded, the shared mode
reads IN_GUEST_MODE but the IPI goes to plane 0's stale pCPU: a flush
hypercall returns HV_STATUS_SUCCESS while the twin keeps running on
stale translations, breaking the TLFS guarantee that the flush covers
the whole VP.

Read the pCPU from common->current_vcpu, whose cpu field every
kvm_arch_vcpu_load() refreshes, in both kick paths. Also read the twin
array with READ_ONCE in the per-plane request fan-out and correct the
comment there: mode and wait are shared with the common, the pCPU is
not.

Found by Sashiko review.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 virt/kvm/kvm_main.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ae998cef3c36..fa639a659138 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -225,16 +225,16 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 		 * A per-plane request raised on "the vCPU" (TLB flush after
 		 * a host-side zap, obsolete-roots reload, ...) concerns
 		 * every plane: fan it out to the twins, or the plane that
-		 * runs next consumes a bit the others still need.  Mode,
-		 * pCPU and wait are shared with the common, so the kick
-		 * logic below covers the twins too.
+		 * runs next consumes a bit the others still need.  Mode and
+		 * wait live in the common and the kick below targets the
+		 * running twin's pCPU, so it covers the twins too.
 		 */
 		if (req & KVM_REQUEST_PER_PLANE) {
 			struct kvm_vcpu *twin;
 			int p;
 
 			for (p = 0; p < KVM_MAX_PLANES; p++) {
-				twin = vcpu->common->vcpus[p];
+				twin = READ_ONCE(vcpu->common->vcpus[p]);
 				if (twin && twin != vcpu)
 					__kvm_make_request(req, twin);
 			}
@@ -255,7 +255,14 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 	 * finalized. See kvm_vcpu_kick() for more details on handling requests.
 	 */
 	if (kvm_request_needs_ipi(vcpu, req)) {
-		cpu = READ_ONCE(vcpu->cpu);
+		/*
+		 * vcpu->cpu is per plane vCPU and kvm_arch_vcpu_load()
+		 * refreshes only the loaded twin's, so this plane's copy
+		 * can point at a pCPU the thread has long left while a
+		 * twin runs elsewhere.  The mode just checked is shared;
+		 * the IPI must go where the running twin actually is.
+		 */
+		cpu = READ_ONCE(READ_ONCE(vcpu->common->current_vcpu)->cpu);
 		if (cpu != -1 && cpu != current_cpu)
 			__cpumask_set_cpu(cpu, tmp);
 	}
@@ -4334,7 +4341,13 @@ void __kvm_vcpu_kick(struct kvm_vcpu *vcpu, bool wait)
 	 * vCPU also requires it to leave IN_GUEST_MODE.
 	 */
 	if (kvm_arch_vcpu_should_kick(vcpu)) {
-		cpu = READ_ONCE(vcpu->cpu);
+		/*
+		 * Target the running twin's pCPU: this plane's vcpu->cpu
+		 * goes stale whenever the thread migrates while another
+		 * plane is loaded, and the IN_GUEST_MODE just observed is
+		 * the (shared) mode of whichever twin runs.
+		 */
+		cpu = READ_ONCE(READ_ONCE(vcpu->common->current_vcpu)->cpu);
 		if (cpu != me && (unsigned int)cpu < nr_cpu_ids && cpu_online(cpu)) {
 			/*
 			 * Use a reschedule IPI to kick the vCPU if the caller
-- 
2.50.1

