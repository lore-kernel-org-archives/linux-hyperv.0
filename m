Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=q0DEG8VtKJ7dKcoRFZNwpay4ZGiPk5VOyGSlPR93Boh/5vT0b4fxjVoGZgEJJgqh2/63
	 Vvx0CUV8CdmoZQAj7saPccv6bq9xnzQtaUyRZs4+cLZXFQA7mRB1w+Au26OR5WkPW2JwE
	 cbvK8uVyHItWaDkX24qLNVeCFSOv7L9BEFx8SFCI60dEI/U+e2ACEMJYJr8acL1jzkDla
	 BWexBXRuw4mDRnWORB3ixk84ZTkgikCQxySCPBJZqERQR+JnhzcWNHkVv25Arrg6j44t/
	 N8d+71/ymFI4jjcv4id1GlD6jfMGYKDt1NGlduWH9tfx5jdNdv121CeMCPYqRNvYP3g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=FIPdlMqs9rKhDSjU59l6252g88uGwqQmR/fw3UuZ0xc=;
	b=u0u4iDKRgKLyIWAeu0noUOI0R3SNnmiuToAL0j8d1QZAvjwd9nYQrwmTp52XyTwn26v5
	 oGBFYLU6Gw1+MDqb7KwrQX2cKQffln6OpkmvGa7CJkICOWW/p5p5wDm1FcuYJdmdqEqpL
	 Vfp8Ei8qRImF4XFNVAsb/InD13iUXNGf4XvTtBDstADraEvCavyORzRtWJUKuiWzm2ZnR
	 0ah5kx09xRFQyY8V6I6/3Y7YACrveA801GVghgAzzk6p73b7+pIXywAHlPiKbI3ukkaCG
	 T8sLMQG1nes3UJ84USx37zBof1Rk6z3WPE7pBOlUKFg+yHia6bVY6XyaiywEoigWPeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nU0HkPQ7;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE02606A323;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE02606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nU0HkPQ7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FIPdlMqs9rKhDSjU59l6252g88uGwqQmR/fw3UuZ0xc=; b=nU0HkPQ7PJL1u0qcbfUp8n0+kz
	gN13PpDts7f7FBCMYh6/y+kQDtm0XEuxZPlXZEsgzOxHnxGV2UqZGzoVSj5gb/KKxHUEju41TlBas
	Yo0y890/FtCoXrQFUwz8VtCkp2MsDPpHW+t+Zq5dkw/xNtekIEqcYjnA/aRst/IFTy7TnY1Wyjgcg
	yosP+262j8O0OIJFg7HH8+jQmviM9rfSsr/7XyT8TBezpc4+x3FFzE+Wqgx0Bd+Zhpglqbfai1/Mp
	1QosqdWk9ud0v0qsEHflOUWoWS7XWOhgUp+d3N3bdzySkpqjjMgF7Btego0HjRsfK7KhJ5E0D+mIo
	OqsRjXdQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy2k-38k2;
	Fri, 27 Nov 2026 15:27:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000PqO-2345;
	Fri, 27 Nov 2026 15:27:30 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-doc@vger.kernel.org,
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
	Zack Rusin <zack.rusin@broadcom.com>,
	Doug Covelli <doug.covelli@broadcom.com>,
	Jim Mattson <jmattson@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v3 06/15] KVM: x86: hyper-v: Let userspace leave a hypercall uncompleted
Date: Fri, 27 Nov 2026 15:27:21 +0000
Message-ID: <20261127152730.99319-7-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127152730.99319-1-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
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

A VMM handling KVM_EXIT_HYPERV_HCALL can only complete the hypercall:
KVM writes the result and advances RIP.  The TLFS has some raise #UD
at the instruction instead: a VTL return from the lowest VTL, for one.

Add a 'ret' field to the exit, which takes KVM_INSN_*: zero completes
as before, KVM_INSN_UD and KVM_INSN_GP inject the exception, and
KVM_INSN_RESUME does nothing, so an exception which userspace queued
is taken at the hypercall.  It is opt-in (KVM_HYPERV_HCALL_RET):
existing VMMs never zeroed the union.

Link: https://lore.kernel.org/kvm/avuDUNAU_a933zvp@seanjc-mac.roam.internal/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 25 +++++++++++++++++++++++++
 arch/x86/kvm/hyperv.c          | 20 +++++++++++++++++++-
 arch/x86/kvm/hyperv.h          |  3 ++-
 include/uapi/linux/kvm.h       |  3 +++
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 782c010a08a0..ea48247c2976 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7336,6 +7336,8 @@ EOI was received.
 					__u64 input;
 					__u64 result;
 					__u64 params[2];
+					__u8 ret;
+					__u8 pad3[7];
 				} hcall;
 				struct {
 					__u32 msr;
@@ -7372,6 +7374,23 @@ way, HvCallPostMessage in some cases among them;
 KVM_CAP_HYPERV_FORWARD_HCALL (see section 7.49) adds the hypercalls KVM
 does not implement.
 
+KVM sets 'ret' to zero, KVM_INSN_COMPLETE, which means that the
+hypercall completes as described above.  With KVM_HYPERV_HCALL_RET
+enabled, userspace may set 'ret' to another of the KVM_INSN_* values
+instead (see :ref:`the description of completion <kvm_insn_action>`),
+and the hypercall does not complete: KVM writes no result and leaves RIP
+at the hypercall instruction.  KVM_INSN_UD and KVM_INSN_GP inject #UD
+and #GP(0), the exceptions which Hyper-V raises when it refuses a
+hypercall itself.  KVM_INSN_RESUME injects nothing: a VMM which wants
+another exception (e.g. #PF with the address in exception_payload)
+queues it with KVM_SET_VCPU_EVENTS before it resumes the vCPU, and the
+guest takes it at the hypercall instruction.  'pad3' is reserved and is
+zero.
+
+For a guest whose register state is protected (SEV-ES, SEV-SNP, TDX)
+'ret' is ignored, with or without KVM_HYPERV_HCALL_RET: the hypercall
+completes.
+
 	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
 
 Hyper-V Synthetic debugger state change. Notification is used to either update
@@ -9293,6 +9312,7 @@ KVM_CHECK_EXTENSION returns, so features only ever use bits 0 to 30.
 The defined bits are::
 
   #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
+  #define KVM_HYPERV_HCALL_RET			(1ULL << 1)
 
 KVM_HYPERV_HCALL_FORWARD_UNKNOWN: a hypercall that KVM would otherwise
 fail with HV_STATUS_INVALID_HYPERCALL_CODE exits to userspace with
@@ -9313,6 +9333,11 @@ KVM_GET_FPU/KVM_SET_FPU) before the vCPU is resumed.  Hypercalls that
 KVM implements itself, and the CPUID-enforcement checks KVM applies
 before dispatching a hypercall, are unaffected.
 
+KVM_HYPERV_HCALL_RET: KVM honours the 'ret' field of every
+KVM_EXIT_HYPERV_HCALL exit, whichever hypercall caused it, and fails
+KVM_RUN with -EINVAL for a value it does not define.  Without it the
+field is ignored and every such exit completes.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e72539f9acc9..67c9d20547d8 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2430,7 +2430,22 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 {
-	return kvm_hv_hypercall_complete(vcpu, vcpu->run->hyperv.u.hcall.result);
+	/*
+	 * Userspace may say that the hypercall does not complete: the result
+	 * stays unwritten and RIP at the instruction, where the guest takes
+	 * the exception that userspace asked for, or queued itself.  Not so
+	 * for a guest with protected state, whose hypercall can only complete.
+	 */
+	if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_RET)) {
+		u8 ret = READ_ONCE(vcpu->run->hyperv.u.hcall.ret);
+		int r = kvm_insn_uncompleted(vcpu, ret);
+
+		if (r)
+			return r;
+	}
+
+	return kvm_hv_hypercall_complete(vcpu,
+					 READ_ONCE(vcpu->run->hyperv.u.hcall.result));
 }
 
 static u16 kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
@@ -2716,6 +2731,9 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	vcpu->run->hyperv.u.hcall.input = hc.param;
 	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
+	vcpu->run->hyperv.u.hcall.ret = 0;
+	memset(vcpu->run->hyperv.u.hcall.pad3, 0,
+	       sizeof(vcpu->run->hyperv.u.hcall.pad3));
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
 	return 0;
 }
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 20d40261c75b..5b6220b17e77 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -206,7 +206,8 @@ static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 }
 
 /* Features reported and accepted by KVM_CAP_HYPERV_FORWARD_HCALL. */
-#define KVM_HYPERV_HCALL_SUPPORTED	KVM_HYPERV_HCALL_FORWARD_UNKNOWN
+#define KVM_HYPERV_HCALL_SUPPORTED	(KVM_HYPERV_HCALL_FORWARD_UNKNOWN | \
+					 KVM_HYPERV_HCALL_RET)
 
 static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
 {
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 5803c84cf8f8..e480544a3746 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -113,6 +113,8 @@ struct kvm_hyperv_exit {
 			__u64 input;
 			__u64 result;
 			__u64 params[2];
+			__u8 ret;	/* in: KVM_INSN_* */
+			__u8 pad3[7];
 		} hcall;
 		struct {
 			__u32 msr;
@@ -128,6 +130,7 @@ struct kvm_hyperv_exit {
 
 /* KVM_CAP_HYPERV_FORWARD_HCALL feature bits */
 #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
+#define KVM_HYPERV_HCALL_RET			(1ULL << 1)
 
 struct kvm_xen_exit {
 #define KVM_EXIT_XEN_HCALL          1
-- 
2.50.1

