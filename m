Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430725;
	b=Eov2NYpOdLVRVa2dqWZ66Wm8f1syhzzxw7pk1zx+laCtosujT/pLCxawGyUbENsG0Z0s
	 SMWB1Ilud4zn1dUTTEnucctlVe82KALpvZW8BQcU1tSjRFe7ZXQxEbSDa56z9KPEtqf88
	 AJQR9bomPI38VO8gsT7AA+S/bUZRiCYdGX6CUUxABrB9obY39Cgq0BZgn8PJmjimnQp4k
	 7rzHMgfq89KgpvKf5xi4X+mucoBy0VzuTlnyb+zzuVVt0bmj8b331LOJswUg8MJMyjJQI
	 nGIikhi2UG7QP4q5z+QjtcYzj5eP10L4PjBmAQLonPsIGSHJJIf8WZgTbr4W7W1XBAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430725;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=gTJsOKDD7wAV8NZbzwiA4Er+p/shyfsz0JYLA7ccPEM=;
	b=dIXW+7gYIvz9RHay9ZJJ5SVL4XbCOeS/lWHmGQchlMpTEEM+4m/Uw/Bcc0h0CjdDYRCj
	 XcfpFz2M3cjHn8/9Xwo2CfhUy5PcSGojUFXl+gPk+hjVAg4JJoOAM1giu3c7BEfKQh90I
	 HblRoVQXg++Wu5uh8Vhmbj9pz6ijqDzxWFVeYXM7bigRMMC/3Zt5wfdrgq4pMv7Z/sKnO
	 d3qazlJv5DYgfVnU5FDUMtiObevu83zZCuPu+y1i+YUNw3tTAYBFtvQwSJnUWj8kxu7rE
	 Hz12IumpQbO/gZEN8K18iuAslfv4642SNDu3lZAw4/3vCZw4JCkVwJJ7yfuRVTnn2AQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gk995H2f;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C88606A89E;
	Wed, 11 Nov 2026 20:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14C88606A89E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=gk995H2f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=gTJsOKDD7wAV8NZbzwiA4Er+p/shyfsz0JYLA7ccPEM=; b=gk995H2fMPoKeHseWslF05O4AV
	IS95CFc5dk4QxqlBhCT4je8UPE9WjwDpKYmd3hnV6EHnP5jTrCwMcEA4L5+/2Iz2FS89INrmnvMcN
	XPO1QLos3Vaj7YSAgilJO9xy9kDs9OTxc6bBFko17bBIipzUe6fm2iNPhR0UNSbPkA0fUNlzMmrUP
	GCogw2c4V8LdN0f9UY2HopfPpV5/WqWBNaAP4HnJprrWsUin9PV1IYgPrazZHr2HvcXepb6TfrJzC
	f2NIxjuiH5kPw8pKRqhVWq0tvxzgQwWX07BP2NiNYBDiKWgr+3zte2spb6WTaJ1OVYv0O+Cch3SkU
	fvVetfDQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFOx-00000009ZGt-26fq;
	Wed, 11 Nov 2026 20:58:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRFOu-0000000HZ7k-2e2P;
	Wed, 11 Nov 2026 20:58:36 +0000
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
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 2/4] KVM: x86: hyper-v: Let userspace fault a forwarded hypercall
Date: Wed, 11 Nov 2026 12:58:34 -0800
Message-ID: <20261111205836.4186584-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261111205836.4186584-1-dwmw2@infradead.org>
References: <20261111205836.4186584-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The TLFS specifies that some hypercalls raise #UD at the hypercall
instruction when they are invalid in the caller's state, rather than
completing with an error status. A VMM implementing such a hypercall
behind KVM_EXIT_HYPERV_HCALL can only return a status, which writes
RAX, advances RIP and completes the call.

Give the hcall member of struct kvm_hyperv_exit a 'flags' field after
the parameters, and add KVM_HYPERV_HCALL_RAISE_UD to
KVM_CAP_HYPERV_FORWARD_HCALL. With it enabled, a completion with
KVM_HYPERV_HCALL_UD set in 'flags' queues a #UD at the unadvanced RIP
and ignores 'result'. It applies to every KVM_EXIT_HYPERV_HCALL
completion, not only to forwarded hypercalls, and 'result' stays a
plain 64-bit value.

KVM zeroes 'flags' when it reports the exit, so a VMM that has never
heard of the field leaves it alone. A completion with any other bit set,
or with KVM_HYPERV_HCALL_UD set while RAISE_UD is not enabled, fails
KVM_RUN with -EINVAL and leaves the completion pending for userspace to
correct. The new field fits within the existing union, whose largest
member is still syndbg, so struct kvm_run does not change size.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 16 ++++++++++++++++
 arch/x86/kvm/hyperv.c          | 30 +++++++++++++++++++++++++++++-
 arch/x86/kvm/hyperv.h          |  3 ++-
 include/uapi/linux/kvm.h       |  3 +++
 4 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 092f6f9ad8a0..25ed1027fb08 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7286,6 +7286,8 @@ EOI was received.
 					__u64 input;
 					__u64 result;
 					__u64 params[2];
+  #define KVM_HYPERV_HCALL_UD		(1ULL << 0)
+					__u64 flags;
 				} hcall;
 				struct {
 					__u32 msr;
@@ -7323,6 +7325,12 @@ and memory-based extended hypercalls exit this way;
 KVM_CAP_HYPERV_FORWARD_HCALL (see section 7.48) adds the hypercalls KVM
 does not implement.
 
+KVM sets 'flags' to zero when it reports the exit.  With that
+capability's KVM_HYPERV_HCALL_RAISE_UD feature enabled, userspace may set
+KVM_HYPERV_HCALL_UD there to raise #UD at the hypercall instruction
+instead of completing the hypercall.  KVM_RUN fails with EINVAL, leaving
+the exit pending, if 'flags' holds any other bit.
+
 	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
 
 Hyper-V Synthetic debugger state change. Notification is used to either update
@@ -9210,6 +9218,7 @@ features it was written for and learn which ones the kernel lacks.
 The defined bits are::
 
   #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
+  #define KVM_HYPERV_HCALL_RAISE_UD		(1ULL << 1)
 
 KVM_HYPERV_HCALL_FORWARD_UNKNOWN: a hypercall that KVM would otherwise
 fail with HV_STATUS_INVALID_HYPERCALL_CODE exits to userspace with
@@ -9230,6 +9239,13 @@ KVM_GET_FPU/KVM_SET_FPU) before the vCPU is resumed.  Hypercalls that
 KVM implements itself, and the CPUID-enforcement checks KVM applies
 before dispatching a hypercall, are unaffected.
 
+KVM_HYPERV_HCALL_RAISE_UD: userspace may complete a KVM_EXIT_HYPERV_HCALL
+exit with KVM_HYPERV_HCALL_UD set in 'flags', and KVM then raises #UD at
+the hypercall instruction instead of completing the hypercall, ignoring
+'result'.  This is for hypercalls that the TLFS specifies to fault
+rather than fail with a status.  When enabled, it applies to every
+KVM_EXIT_HYPERV_HCALL completion, forwarded or not.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e72539f9acc9..2a2bc54775fe 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2430,7 +2430,34 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 {
-	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
+	u64 result = vcpu->run->hyperv.u.hcall.result;
+	u64 flags = vcpu->run->hyperv.u.hcall.flags;
+	u64 valid = 0;
+
+	if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_RAISE_UD))
+		valid |= KVM_HYPERV_HCALL_UD;
+
+	/*
+	 * Fail KVM_RUN on flags KVM does not know (or that were not enabled),
+	 * and leave the completion pending so that userspace can fix them.
+	 */
+	if (flags & ~valid) {
+		vcpu->arch.complete_userspace_io =
+			kvm_hv_hypercall_complete_userspace;
+		return -EINVAL;
+	}
+
+	/*
+	 * The VMM judged the hypercall to fault rather than return a
+	 * status: leave RIP at the hypercall instruction and raise #UD
+	 * there.
+	 */
+	if (flags & KVM_HYPERV_HCALL_UD) {
+		kvm_queue_exception(vcpu, UD_VECTOR);
+		return 1;
+	}
+
+	return kvm_hv_hypercall_complete(vcpu, result);
 }
 
 static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
@@ -2716,6 +2743,7 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	vcpu->run->hyperv.u.hcall.input = hc.param;
 	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
+	vcpu->run->hyperv.u.hcall.flags = 0;
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
 	return 0;
 }
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 20d40261c75b..7c6a21f02d71 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -206,7 +206,8 @@ static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 }
 
 /* Features reported and accepted by KVM_CAP_HYPERV_FORWARD_HCALL. */
-#define KVM_HYPERV_HCALL_SUPPORTED	KVM_HYPERV_HCALL_FORWARD_UNKNOWN
+#define KVM_HYPERV_HCALL_SUPPORTED	(KVM_HYPERV_HCALL_FORWARD_UNKNOWN | \
+					 KVM_HYPERV_HCALL_RAISE_UD)
 
 static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
 {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 7194c213a742..09b8b8c84380 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -113,6 +113,8 @@ struct kvm_hyperv_exit {
 			__u64 input;
 			__u64 result;
 			__u64 params[2];
+#define KVM_HYPERV_HCALL_UD		(1ULL << 0)
+			__u64 flags;
 		} hcall;
 		struct {
 			__u32 msr;
@@ -128,6 +130,7 @@ struct kvm_hyperv_exit {
 
 /* KVM_CAP_HYPERV_FORWARD_HCALL feature bits */
 #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
+#define KVM_HYPERV_HCALL_RAISE_UD		(1ULL << 1)
 
 struct kvm_xen_exit {
 #define KVM_EXIT_XEN_HCALL          1
-- 
2.50.1

