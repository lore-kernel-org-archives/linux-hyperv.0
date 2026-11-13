Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594897;
	b=PyU5ppXIJ3CM5GdXr4dhvPd6JaAqmac6GjYwX0nN2r6tN/8dh3GBOoFVZh1cXtwmxJNy
	 hWFbSXmdAdFs4jUU7pm2If228dEOe29IFDQRbhVEf/1z8ohNb/gUmiA8CSkyKrlhMiPrU
	 cmrpmG5vT23xn1VV7Dnp8qo50hNTXWNaQbfPFcqWGraXRvziKxj/oA1TeRjOxuZfStDcJ
	 MkwR2NxjtJ86jaEuiQWtTEA99eDbGXylbFwPIk51RnQvEDjj8KJvyICQ9TsPwqSP16UGr
	 Kg9tW5hxXSYdX8FqYsu2QRfSnNhCArMgR8jMAKwaKPIYHnyTxleqEJ3tbv4oRqNMrxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594897;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=+/G3xbUKgtqZ3Kc6MYvEXpKu+pwk0E+3Sd8UbxnvfZM=;
	b=OD8jOchYhtqVew4clXnjF//su54EqWj8+gqGucKgLIbhmcMHZ+7L45Bu9/qKUeMMcGZr
	 hnP8jv6VWWjsuKKpVT0bc/VMKV0YQ8EfLd7H6on6lDQDutj1jnt+K3jlDX8LY2R7kSLLO
	 4Ca+c6C60q0YS19tcJAAsdjddBhv9ZfxosHUDc/SGDfOtmohWf7DXdAjx8xX8OeW2Jj19
	 Al058OjLf/6I0YiUTsMT3ZNrw7glfbUt5DGMF2Rhr4Y6xGE7MMTxeJVfioUWSpX1MIMnh
	 iu0+2A2jt8PK5jaAQuar2wi+W6/XVyW73C0DMRDM0ZeN2j+NQnUzc1NRNcHKPfqNpAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Sqq0E32Y;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25188606A886;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25188606A886
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Sqq0E32Y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=+/G3xbUKgtqZ3Kc6MYvEXpKu+pwk0E+3Sd8UbxnvfZM=; b=Sqq0E32YiCWzjHiRxTzbsandNa
	F2xHaAcfCvEeRyXAkjrB3WfebpbNz0T+sk/oiOYpqDEmp/YGxHr1zUon0wpl48i9leGByBOtTuD5O
	OdsDDUMqBKA0o67fKCOCWyBcFyZsQ6+cAuTJ2eBxtdr54Fyjnc6rfIbGtb4NpJopsz7fbzKoXNmZt
	rc/xxOLaX98RdnxkxSBXXJANXRGSVjaFAmpOC86s9LMwdC+1GFEsC4M/ba4jyrs7WXCrjiOint0Ps
	aZCiiC2Ri6YB+GgEmhr/wiDlnF/pZuVYVMfWlcMyaYwGCMWrfDErAPDe8p4qwkYO6TzCHV94mC3Ju
	skktTxUw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQl-1apz;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Lts-0dk4;
	Fri, 13 Nov 2026 18:34:50 +0000
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
Subject: [RFC PATCH v2 20/31] KVM: x86: hyperv: Honour in_vtl in synthetic cluster IPIs
Date: Fri, 13 Nov 2026 18:34:36 +0000
Message-ID: <20261113183448.84094-21-dwmw2@infradead.org>
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

A guest using VSM names the target VTL of HvCallSendSyntheticClusterIpi
and HvCallSendSyntheticClusterIpiEx in the input's in_vtl field (TLFS
hv_input_vtl, the byte after the vector). KVM treats that byte as
reserved: the fast form of HvCallSendSyntheticClusterIpi fails any
input with bits above 31 set with HV_STATUS_INVALID_HYPERCALL_INPUT,
and the other forms ignore it.

Decode in_vtl in both the memory and the fast forms and deliver the IPI
into that plane's twin of each targeted VP, or into the sender's own
plane when use_target_vtl is clear. A VP with no twin in the target
plane is skipped. Reserved bits 7:5 of in_vtl are rejected with
HV_STATUS_INVALID_HYPERCALL_INPUT before anything is delivered.

A target VTL above the caller's is refused with HV_STATUS_ACCESS_DENIED,
also for an empty EX set.
Under the VTL privilege model a VTL may interrupt its own level and
lower ones, but never a more privileged one (TLFS §15.9). The target
plane is therefore always at or below the caller's, and so below
KVM_MAX_PLANES.

struct hv_send_ipi and struct hv_send_ipi_ex are shared with the Linux
guest code, which now clears in_vtl and the remaining reserved bytes
separately.

The target twin is looked up without the locks that serialise twin
creation, so read the slot with READ_ONCE() to pair with its
publication.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 arch/x86/hyperv/hv_apic.c   |  3 +-
 arch/x86/kvm/hyperv.c       | 69 ++++++++++++++++++++++++++++++++++---
 include/hyperv/hvgdk_mini.h |  3 +-
 include/hyperv/hvhdk_mini.h |  3 +-
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/arch/x86/hyperv/hv_apic.c b/arch/x86/hyperv/hv_apic.c
index 95f1782d1e17..3655b744395d 100644
--- a/arch/x86/hyperv/hv_apic.c
+++ b/arch/x86/hyperv/hv_apic.c
@@ -125,7 +125,8 @@ static bool __send_ipi_mask_ex(const struct cpumask *mask, int vector,
 		goto ipi_mask_ex_done;
 
 	ipi_arg->vector = vector;
-	ipi_arg->reserved = 0;
+	ipi_arg->in_vtl.as_uint8 = 0;
+	memset(ipi_arg->reserved, 0, sizeof(ipi_arg->reserved));
 	ipi_arg->vp_set.valid_bank_mask = 0;
 
 	/*
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 3494f3b29809..8a33127169fa 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2683,7 +2683,8 @@ static s64 kvm_hv_flush_tlb(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 }
 
 static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
-				    u64 *sparse_banks, u64 valid_bank_mask)
+				    u64 *sparse_banks, u64 valid_bank_mask,
+				    int target_plane)
 {
 	struct kvm_lapic_irq irq = {
 		.delivery_mode = APIC_DM_FIXED,
@@ -2693,16 +2694,44 @@ static void kvm_hv_send_ipi_to_many(struct kvm *kvm, u32 vector,
 	unsigned long i;
 
 	kvm_for_each_vcpu(i, vcpu, kvm) {
+		struct kvm_vcpu *target = vcpu;
+
 		if (sparse_banks &&
 		    !hv_is_vp_in_sparse_set(kvm_hv_get_vpindex(vcpu),
 					    valid_bank_mask, sparse_banks))
 			continue;
 
+		/*
+		 * TLFS: the IPI targets the VPs' in_vtl (or the sender's
+		 * VTL): deliver into that plane's APIC.
+		 */
+		if (target_plane) {
+			target = READ_ONCE(vcpu->common->vcpus[target_plane]);
+			if (!target)
+				continue;
+		}
+
 		/* We fail only when APIC is disabled */
-		kvm_apic_set_irq(vcpu, &irq, NULL);
+		kvm_apic_set_irq(target, &irq, NULL);
 	}
 }
 
+/*
+ * TLFS: in_vtl bit 4 selects an explicit target VTL.  A VTL may interrupt
+ * its own level and lower ones, never a higher one (TLFS 15.9, "VTL
+ * Interrupt Management": each VTL sends and receives interrupts without
+ * interference from a less secure VTL).  Returns the target plane, or -1
+ * for a target above the caller's.
+ */
+static int hv_send_ipi_target_plane(struct kvm_vcpu *vcpu, u8 in_vtl)
+{
+	if (!(in_vtl & 0x10))
+		return vcpu->plane_level;
+	if ((in_vtl & 0xf) > vcpu->plane_level)
+		return -1;
+	return in_vtl & 0xf;
+}
+
 static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -2712,6 +2741,8 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 	struct hv_send_ipi send_ipi;
 	u64 valid_bank_mask;
 	u32 vector;
+	u8 in_vtl = 0;
+	int target_plane;
 	bool all_cpus;
 	int r;
 
@@ -2729,13 +2760,28 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			sparse_banks[0] = send_ipi.cpu_mask;
 			vector = send_ipi.vector;
+			in_vtl = send_ipi.in_vtl.as_uint8;
 		} else {
 			/* 'reserved' part of hv_send_ipi should be 0 */
-			if (unlikely(hc->ingpa >> 32 != 0))
+			if (unlikely(hc->ingpa >> 40 != 0))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
 			sparse_banks[0] = hc->outgpa;
 			vector = (u32)hc->ingpa;
+			in_vtl = (hc->ingpa >> 32) & 0xff;
 		}
+
+		/*
+		 * Only hv_input_vtl.target_vtl (bits 3:0) and
+		 * use_target_vtl (bit 4) are defined; reserved_z (7:5)
+		 * must be zero in every form of the hypercall, before
+		 * anything is delivered.
+		 */
+		if (unlikely(in_vtl & 0xe0))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+		target_plane = hv_send_ipi_target_plane(vcpu, in_vtl);
+		if (target_plane < 0)
+			return HV_STATUS_ACCESS_DENIED;
+
 		all_cpus = false;
 		valid_bank_mask = BIT_ULL(0);
 
@@ -2745,12 +2791,24 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 			if (unlikely(kvm_vcpu_read_guest(vcpu, hc->ingpa, &send_ipi_ex,
 							 sizeof(send_ipi_ex))))
 				return HV_STATUS_INVALID_HYPERCALL_INPUT;
+			in_vtl = send_ipi_ex.in_vtl.as_uint8;
 		} else {
 			send_ipi_ex.vector = (u32)hc->ingpa;
 			send_ipi_ex.vp_set.format = hc->outgpa;
 			send_ipi_ex.vp_set.valid_bank_mask = sse128_lo(hc->xmm[0]);
+			in_vtl = (hc->ingpa >> 32) & 0xff;
 		}
 
+		/*
+		 * As above: hv_input_vtl bits 7:5 are reserved, and a target
+		 * VTL above the caller's is refused even for an empty set.
+		 */
+		if (unlikely(in_vtl & 0xe0))
+			return HV_STATUS_INVALID_HYPERCALL_INPUT;
+		target_plane = hv_send_ipi_target_plane(vcpu, in_vtl);
+		if (target_plane < 0)
+			return HV_STATUS_ACCESS_DENIED;
+
 		trace_kvm_hv_send_ipi_ex(send_ipi_ex.vector,
 					 send_ipi_ex.vp_set.format,
 					 send_ipi_ex.vp_set.valid_bank_mask);
@@ -2783,9 +2841,10 @@ static int kvm_hv_send_ipi(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
 		return HV_STATUS_INVALID_HYPERCALL_INPUT;
 
 	if (all_cpus)
-		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0);
+		kvm_hv_send_ipi_to_many(kvm, vector, NULL, 0, target_plane);
 	else
-		kvm_hv_send_ipi_to_many(kvm, vector, sparse_banks, valid_bank_mask);
+		kvm_hv_send_ipi_to_many(kvm, vector, sparse_banks,
+					valid_bank_mask, target_plane);
 
 ret_success:
 	return HV_STATUS_SUCCESS;
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 8346b2212c8c..21fcdd085a9b 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1356,7 +1356,8 @@ struct hv_input_set_vp_registers {
 /* HvCallSendSyntheticClusterIpi hypercall */
 struct hv_send_ipi {	 /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI */
 	u32 vector;
-	u32 reserved;
+	union hv_input_vtl in_vtl;
+	u8 reserved[3];
 	u64 cpu_mask;
 } __packed;
 
diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
index 57b70efe60d4..6ded425453df 100644
--- a/include/hyperv/hvhdk_mini.h
+++ b/include/hyperv/hvhdk_mini.h
@@ -465,7 +465,8 @@ struct hv_input_unmap_device_interrupt {
 
 struct hv_send_ipi_ex { /* HV_INPUT_SEND_SYNTHETIC_CLUSTER_IPI_EX */
 	u32 vector;
-	u32 reserved;
+	union hv_input_vtl in_vtl;
+	u8 reserved[3];
 	struct hv_vpset vp_set;
 } __packed;
 
-- 
2.50.1

