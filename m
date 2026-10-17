Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F6BC494808;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239915; cv=none; b=scwGk60FHxOutxjkJrzSB7ULxIXLpEImhrsfC2wW4YUXmJ55G8hngD26dwb5VztDQix4bhDZ0Qo/OwfHrTgIeFKO62x5giqV2u8fgcbsqIeQSK9vVhjVLBCPiklL/SbdBcWTb2cKEdF38XvFePSVhFtDMySQWwNnB0R0sYP53K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239915; c=relaxed/simple;
	bh=/acv95a6DOjDhTpCoFcJiDkfBUjrRtsdEr+aZY/pdEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfHSZ8A5DbN8mFeUCVHGqS6vjXUp4ErjJKNF3FjQUaXd6BHwp9r+RT16WflsWlgOGCaRxlIy5QNUlUFGmbNbHdsQ5Ebi0kRMRVRevymfYnH5/VCPIqSJPU++ZU1P50G/mEmNEX4sAErJ6Uk61zG4n6ahjdx97UtYEcrLphOPg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=pREaKwM0; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pREaKwM0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=hcNA5/OAXtlb2cLCnY1VGOxhhb5aVyolwmkQrP0IwqU=; b=pREaKwM0pHYcjonZfJcdaHkb80
	H6nLEbYIw80yIHuvFDtpkpDRLI3fMi2y24ITODdj2OjJ43jG31ZFW6mUIfYPvF7zKL10nzEiIhnAc
	rVmvrhSq9ua9Z6Mjoaf1c9bPpkMQlPBS2fbzmfSzHy79oju3n9crwBLGzsIcY8HS9SOEB5p8U4NXv
	3AH5tkdKeFQb8dofbvSQ4lnyKMl3M/sSZ0dh9IRfQ0LZvLM5P8v3vF8sBBt6SaJFh/Q7lqYDpSQwZ
	S5eOAu5xN7kcLdPl+P/qayeZNcSvC+kWwN/XXHhuc8qza9F0fSN247NM5t7zhpM2GDX8iGsBbuSUT
	XIxW27LA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002LfP-1w2B;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ymg-0Wkw;
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
Subject: [RFC PATCH 27/55] KVM: planes: fan out per-plane requests to twin vCPUs
Date: Sat, 17 Oct 2026 13:24:33 +0100
Message-ID: <20261017122501.610248-28-dwmw2@infradead.org>
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

A request raised on one plane's vCPU for a VM-wide reason — TLB flush
after a host-side zap, APIC page reload, obsolete-roots release — is
consumed by whichever twin runs first; the planes series does not yet
fan requests out to twins, so the other planes keep stale
translations. The plane-1 twin of a Windows VSM guest then runs on a
zapped root and the guest bugchecks.

Mark those three requests per-plane and make kvm_make_vcpu_request()
replicate any KVM_REQUEST_PER_PLANE request to every twin of the
target vCPU. Mode, pCPU and wait live in the shared common, so the
existing kick logic already reaches the twins.

Move the Hyper-V TLB-flush hypercalls onto the same fan-out. The
reference hypervisor's TLB is VTL-blind: both VTLs share one hardware
translation context, a flush from either VTL covers both, and the
hypercall does not return until the targets have left guest mode. The
secure kernel relies on all of that when it edits mappings the normal
kernel also uses — with per-plane TLB tags and the previous unwaited
kvm_make_request() plus kick for non-zero-plane callers, VTL0 read
stale PTEs and Windows bugchecked 0x1A (MEMORY_MANAGEMENT, 0x6102)
minutes into an SMP boot. Enqueue the flush entries for every twin of
each target VP and dispatch KVM_REQ_HV_TLB_FLUSH through the waiting
fan-out for callers in either VTL.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm_host.h |  6 ++-
 arch/x86/kvm/hyperv.c           | 65 ++++++++++++++++-----------------
 arch/x86/kvm/mmu/mmu.c          | 13 ++++---
 include/linux/kvm_host.h        |  3 +-
 virt/kvm/kvm_main.c             | 22 ++++++++++-
 5 files changed, 66 insertions(+), 43 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 834597791fe1..1ba77d9375cd 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -107,7 +107,8 @@
 	KVM_ARCH_REQ_FLAGS(15, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_GLOBAL_CLOCK_UPDATE	KVM_ARCH_REQ(16)
 #define KVM_REQ_APIC_PAGE_RELOAD \
-	KVM_ARCH_REQ_FLAGS(17, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+	KVM_ARCH_REQ_FLAGS(17, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
+			   KVM_REQUEST_PER_PLANE)
 #define KVM_REQ_HV_CRASH		KVM_ARCH_REQ(18)
 #define KVM_REQ_IOAPIC_EOI_EXIT		KVM_ARCH_PLANE_REQ(19)
 #define KVM_REQ_HV_RESET		KVM_ARCH_REQ(20)
@@ -125,7 +126,8 @@
 #define KVM_REQ_UPDATE_CPU_DIRTY_LOGGING \
 	KVM_ARCH_REQ_FLAGS(30, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_MMU_FREE_OBSOLETE_ROOTS \
-	KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+	KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
+			   KVM_REQUEST_PER_PLANE)
 #define KVM_REQ_HV_TLB_FLUSH \
 	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
 			   KVM_REQUEST_PER_PLANE)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 0d239f054856..759589c6de87 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2205,20 +2205,26 @@ static int kvm_hv_hypercall_check_params(struct kvm_vcpu *vcpu,
 }
 
 /*
- * A TLB flush hypercall flushes the caller's VTL view of the target VPs:
- * resolve the target to the vCPU of the caller's plane, which has its own
- * roots and TLB tag.  Fall back to plane 0 when the plane vCPU does not
- * exist (it then has no TLB to flush either).
+ * The reference hypervisor's TLB is VTL-blind: both VTLs share one hardware
+ * translation context, so a flush issued from either VTL covers both and
+ * the secure kernel relies on that when it edits mappings the normal kernel
+ * also uses.  Planes have separate roots and TLB tags, so match the
+ * contract by enqueueing the flush for every twin of the target VP.
  */
-static struct kvm_vcpu *hv_flush_plane_vcpu(struct kvm_vcpu *caller,
-					    struct kvm_vcpu *v)
+static void hv_tlb_flush_enqueue_all_planes(struct kvm_vcpu *v,
+					    u64 *entries, int count)
 {
-	struct kvm_vcpu *pv;
+	struct kvm_vcpu_hv_tlb_flush_fifo *fifo;
+	struct kvm_vcpu *twin;
+	int p;
 
-	if (!caller->plane_level)
-		return v;
-	pv = v->common->vcpus[caller->plane_level];
-	return pv ?: v;
+	for (p = 0; p < KVM_MAX_PLANES; p++) {
+		twin = v->common->vcpus[p];
+		if (!twin || !to_hv_vcpu(twin))
+			continue;
+		fifo = kvm_hv_get_tlb_flush_fifo(twin, false);
+		hv_tlb_flush_enqueue(twin, fifo, entries, count);
+	}
 }
 
 static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
@@ -2355,19 +2361,17 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 * analyze it here, flush TLB regardless of the specified address space.
 	 */
 	if (all_cpus && !is_guest_mode(vcpu)) {
-		kvm_for_each_vcpu(i, v, kvm) {
-			v = hv_flush_plane_vcpu(vcpu, v);
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
-			if (vcpu->plane_level) {
-				kvm_make_request(KVM_REQ_HV_TLB_FLUSH, v);
-				kvm_vcpu_kick(v);
-			}
-		}
+		kvm_for_each_vcpu(i, v, kvm)
+			hv_tlb_flush_enqueue_all_planes(v, tlb_flush_entries,
+							hc->rep_cnt);
 
-		if (!vcpu->plane_level)
-			kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
+		/*
+		 * KVM_REQ_HV_TLB_FLUSH is per-plane and fans out to every
+		 * twin; the WAIT in the fan-out is the barrier the TLFS
+		 * requires before the hypercall returns, for callers in
+		 * either VTL.
+		 */
+		kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
 	} else if (!is_guest_mode(vcpu)) {
 		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
 
@@ -2375,19 +2379,12 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
-			v = hv_flush_plane_vcpu(vcpu, v);
-			tlb_flush_fifo = kvm_hv_get_tlb_flush_fifo(v, false);
-			hv_tlb_flush_enqueue(v, tlb_flush_fifo,
-					     tlb_flush_entries, hc->rep_cnt);
-			if (vcpu->plane_level) {
-				kvm_make_request(KVM_REQ_HV_TLB_FLUSH, v);
-				kvm_vcpu_kick(v);
-			}
+			hv_tlb_flush_enqueue_all_planes(v, tlb_flush_entries,
+							hc->rep_cnt);
 		}
 
-		if (!vcpu->plane_level)
-			kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
-						    vcpu_mask);
+		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
+					    vcpu_mask);
 	} else {
 		struct kvm_vcpu_hv *hv_v;
 
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 4b11631d9e99..07a8de28c73d 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -6265,11 +6265,14 @@ void kvm_mmu_free_obsolete_roots(struct kvm_vcpu *vcpu)
 	int i;
 
 	/*
-	 * KVM_REQ_MMU_FREE_OBSOLETE_ROOTS is tracked in the request set
-	 * shared by all of the vCPU's planes, so the plane that consumes
-	 * the request is not necessarily the plane whose root is obsolete.
-	 * Service every plane: the inactive twins cannot be running (all
-	 * planes of a vCPU share one thread), so their MMUs are stable.
+	 * KVM_REQ_MMU_FREE_OBSOLETE_ROOTS fans out to every plane twin,
+	 * but each twin only consumes its own copy when it next runs, and
+	 * a plane that userspace never re-enters would pin its obsolete
+	 * roots indefinitely.  Service every plane from whichever twin
+	 * consumes its request first: the inactive twins cannot be
+	 * running (all planes of a vCPU share one thread), so their MMUs
+	 * are stable, and a twin's own later request finds nothing left
+	 * to free.
 	 */
 	for (i = 0; i < KVM_MAX_PLANES; i++) {
 		v = vcpu->common->vcpus[i];
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 30dbc28885fb..fdcf401ccb46 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -164,7 +164,8 @@ static inline bool kvm_is_error_gpa(gpa_t gpa)
  * Architecture-independent vcpu->requests bit members
  * Bits 3-7 are reserved for more arch-independent bits.
  */
-#define KVM_REQ_TLB_FLUSH		(0 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+#define KVM_REQ_TLB_FLUSH \
+	(0 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | KVM_REQUEST_PER_PLANE)
 #define KVM_REQ_VM_DEAD			(1 | KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
 #define KVM_REQ_UNBLOCK			2
 #define KVM_REQ_DIRTY_RING_SOFT_FULL	3
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fac30b8b6518..3e021683c8a8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -218,9 +218,29 @@ static void kvm_make_vcpu_request(struct kvm_vcpu *vcpu, unsigned int req,
 {
 	int cpu;
 
-	if (likely(!(req & KVM_REQUEST_NO_ACTION)))
+	if (likely(!(req & KVM_REQUEST_NO_ACTION))) {
 		__kvm_make_request(req, vcpu);
 
+		/*
+		 * A per-plane request raised on "the vCPU" (TLB flush after
+		 * a host-side zap, obsolete-roots reload, ...) concerns
+		 * every plane: fan it out to the twins, or the plane that
+		 * runs next consumes a bit the others still need.  Mode,
+		 * pCPU and wait are shared with the common, so the kick
+		 * logic below covers the twins too.
+		 */
+		if (req & KVM_REQUEST_PER_PLANE) {
+			struct kvm_vcpu *twin;
+			int p;
+
+			for (p = 0; p < KVM_MAX_PLANES; p++) {
+				twin = vcpu->common->vcpus[p];
+				if (twin && twin != vcpu)
+					__kvm_make_request(req, twin);
+			}
+		}
+	}
+
 	if (!(req & KVM_REQUEST_NO_WAKEUP) && kvm_vcpu_wake_up(vcpu))
 		return;
 
-- 
2.50.1

