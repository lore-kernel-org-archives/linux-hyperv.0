Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=2kjyPZ9YWyRui1jShvG0w7Szd3buJ6qB/6tWBrw9rCPCW9Jl+J1Dnt8VU0tpfT2U6/mE
	 1khokBGbIWL7hUgLujbzwjs5DLAQlQ8OCjL1CNB8VwZE7SNAP5FkKnwlUTk/99AFd7wDC
	 59OwGanRVq05DSgdFRO1iKTx2WPDr6CJPHwSoIoJR8OXmFHR+NVY6kvhulCuNMDAYoR6D
	 gAgqQ78TCbhPH+Q227CoP99eDw1yWzyK1e2M3sbNQ/4h0rS8fBDpXsigNmxYhDCgw0wf1
	 OUCbfPcEoTbAJZMMK8uD8dASH4jPAoJaXhO7JpmdfNK9jtsPHSe4hjVhDQNt/VPz0dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=LcvsoidMFAtdfAb9au7KsTG7xrFv7NmzWeU8RJx8W8A=;
	b=3FwSus92mFfMzm4eqKW5dQtgFCB1DTl7GSIvO8/f82LGOsQ35QzaV5ANW5tGM0azawKm
	 ch6fWPYchrBfA/IApGKBXz2G3N/w/0TY2K9/lgPkdTGpr6xYpHyFXYr8M8ZhgCHOOyelK
	 z1Jzb2KgQR1qA1PEP+JQes+t5GVznauoj/vr2yDDCqceaqs/+xobjDTIbTbFbPh+xLqJW
	 m5fbzosEiXbMQjw1LTTvq/oF0XLAqqdPnDNuG++g9AyYC+yDVqS18yIs6z4xpO8CFIyRO
	 d+qhWp4ei6YoIjEGf0OiOg7A3mrWWMgQjUTHQJHSclJZiPOipZaOj41/HEmxTyBTrWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=c6rqEX9m;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFCF606A330;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AFCF606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=c6rqEX9m
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=LcvsoidMFAtdfAb9au7KsTG7xrFv7NmzWeU8RJx8W8A=; b=c6rqEX9m5zzw/3Ms8IkU5jHzpF
	jrGvghyToHcjrkCmV3IMcsl2e2kLyEFbO9QoCMynCr1/FrPWsid1g2R0bhDPKGBhp1ufEmAhKsvqs
	qYWcpN2TmNN1S6WlgsGYMP6v44DtV2/yATSlOkoLtsCm3eTAe2QShplm5tm9tGdkjSjHNS8YwEDzz
	c+DNCXxxUDTaJQ3NQTpdKEHlCyGZv4GGahSH8n0wdq4RojxzXocRTuXMAezZiLlR/k7LHVdxy8FJU
	XTAbCWMjwj1KD3vWT2elTHGxBBz2/rXGPooUmPSkUXtFrvKCu1O+nK9eMKt07SKJKPVNC/NFZAVbZ
	j0nKaA0g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPV-27SD;
	Fri, 13 Nov 2026 18:34:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lsj-18rI;
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
Subject: [RFC PATCH v2 04/31] KVM: x86: hyperv: Flush every plane twin on TLB flush hypercalls
Date: Fri, 13 Nov 2026 18:34:20 +0000
Message-ID: <20261113183448.84094-5-dwmw2@infradead.org>
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

The Hyper-V TLB flush hypercalls resolve their target vCPUs through
the plane-0 array, so a flush only ever reached the plane-0 vCPUs, and
the caller's own plane and every other plane kept stale translations.
Two Windows VSM failures come from this. The secure kernel repopulated
a PFN-database page table entry, flushed, then took a fatal page fault
on the very address it had just mapped, because VTL1's TLB still held
the old read-only zero-page translation. And an SMP boot bugchecks 0x1A
(MEMORY_MANAGEMENT, 0x6102) minutes in, when VTL0 reads stale PTEs that
the secure kernel has already edited in mappings both VTLs use.

The TLFS lets a flush cover more than the caller asked for, and does
not return from the hypercall until the targets have left guest mode.
Enqueue the flush entries for every twin of each target VP, and raise
KVM_REQ_HV_TLB_FLUSH through the waiting request fan-out, so the
hypercall waits for every plane, whichever VTL issued it. Make the
request per plane: it lives in the request word the twins share, and a
plane-0 twin consuming it with an empty fifo would otherwise drop a
flush queued for another plane.

The walk reaches twins whose mutex the caller does not hold, so it
leaves the Hyper-V context check to hv_tlb_flush_enqueue(), which reads
it with to_hv_vcpu_safe() and skips a twin that has none yet.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/include/asm/kvm_host.h |  3 ++-
 arch/x86/kvm/hyperv.c           | 41 ++++++++++++++++++++++++++++++---
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 1ce0b81833b9..f46a3494aacc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -129,7 +129,8 @@
 	KVM_ARCH_REQ_FLAGS(31, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
 			   KVM_REQUEST_PER_PLANE)
 #define KVM_REQ_HV_TLB_FLUSH \
-	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP)
+	KVM_ARCH_REQ_FLAGS(32, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
+			   KVM_REQUEST_PER_PLANE)
 #define KVM_REQ_VMSA_PAGE_RELOAD \
 	KVM_ARCH_REQ_FLAGS(33, KVM_REQUEST_WAIT | KVM_REQUEST_NO_WAKEUP | \
 			       KVM_REQUEST_PER_PLANE)
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index c76236711208..65c39b30dae7 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2385,6 +2385,32 @@ static int kvm_hv_hypercall_check_params(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+/*
+ * The Windows secure kernel edits mappings that the normal kernel also
+ * uses, and expects a flush issued from either VTL to cover both.  Planes
+ * have separate roots and TLB tags, so enqueue the flush for every twin
+ * of the target VP; the TLFS lets a flush cover more than the caller
+ * asked for.
+ */
+static void hv_tlb_flush_enqueue_all_planes(struct kvm_vcpu *v,
+					    u64 *entries, int count)
+{
+	struct kvm_vcpu *twin;
+	int p;
+
+	for (p = 0; p < KVM_MAX_PLANES; p++) {
+		twin = READ_ONCE(v->common->vcpus[p]);
+		if (!twin)
+			continue;
+		/*
+		 * The caller does not hold the twin's mutex; the enqueue
+		 * looks up the twin's Hyper-V context with to_hv_vcpu_safe()
+		 * and skips a twin that has none yet.
+		 */
+		hv_tlb_flush_enqueue(twin, entries, count, false);
+	}
+}
+
 static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -2521,8 +2547,15 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	 */
 	if (all_cpus && !is_guest_mode(vcpu)) {
 		kvm_for_each_vcpu(i, v, kvm)
-			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, false);
+			hv_tlb_flush_enqueue_all_planes(v, tlb_flush_entries,
+							hc->rep_cnt);
 
+		/*
+		 * KVM_REQ_HV_TLB_FLUSH is per-plane and fans out to every
+		 * twin; the WAIT in the fan-out is the barrier the TLFS
+		 * requires before the hypercall returns, for callers in
+		 * either VTL.
+		 */
 		kvm_make_all_cpus_request(kvm, KVM_REQ_HV_TLB_FLUSH);
 	} else if (!is_guest_mode(vcpu)) {
 		sparse_set_to_vcpu_mask(kvm, sparse_banks, valid_bank_mask, vcpu_mask);
@@ -2531,10 +2564,12 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			v = kvm_get_vcpu(kvm, i);
 			if (!v)
 				continue;
-			hv_tlb_flush_enqueue(v, tlb_flush_entries, hc->rep_cnt, false);
+			hv_tlb_flush_enqueue_all_planes(v, tlb_flush_entries,
+							hc->rep_cnt);
 		}
 
-		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH, vcpu_mask);
+		kvm_make_vcpus_request_mask(kvm, KVM_REQ_HV_TLB_FLUSH,
+					    vcpu_mask);
 	} else {
 		struct kvm_vcpu_hv *hv_v;
 
-- 
2.50.1

