Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=aPAiPOTG43lFifuyyHYQ3DHOnZazxcgusCzgqXmQuY7Ku8gOWeWAG5hAleQ8ETG7DGi0
	 MLA806lx3qA+H7M8XFwihIQrczzjmu4jlLdcaCg+1Tid6dbBVFma/odensB9iVUF9Sm9V
	 hGu0yVEX0PXyDO647BJLjFGaj3gLEb4ZMZRa4s710RinnfOZhgbWBMS/apl5J0DsujCM1
	 yQXNmwfCYHYMYCM55sEn8ZNeSw5exrRaEYi6iUxZsr/WU++YWc8+QNksE7PqsAf2ii/56
	 pHpJEQAs472P8tZ6eh2ygfgj6r5N4F+3iMX6iDZihaeVOzN8zXQNrmyrSMosuEP5SWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=2Z9kBRIPqW9GlCn4jdy72fFAG++70JCnL18g2NIfbsQ=;
	b=sRQicVwiMJYufykLi0vcVdfPGTyRP0DdBY9tpmxSTIuUEudF36G/kMkIDDnz2lpsgY7D
	 YdmWaASwObhECfrtWwybhQEfE3m7Tx9TubKiNF6mENbjaWHaZjXULSg0f7mQwkHPgdKGy
	 aeeZwaG3Ncj18gIRpQnsAe3AgLBtd4Xr1vuOyGZbIqbfbfwi7A9k7CTgDE2br0kUCBl96
	 xoBGrRxjJf/6nIUm0RFcnOLqtm2F9Mcpz0HUHeNJTYFvB4SPr9GEVF6qW95VObRWFijMU
	 gUpFSW142m8QEKQ7tRkEndJAinElGSO8TwbIJmrTLuN6OfeIIfO2iwUszrL5bXNhB5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=seNCF1Ch;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3F606A329;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF3F606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=seNCF1Ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=2Z9kBRIPqW9GlCn4jdy72fFAG++70JCnL18g2NIfbsQ=; b=seNCF1ChjqbtwfLyzLuspnnUtd
	FAdxqPI014SkaJ+dcffuGhICEI+mOiTIAKlP17jBHzVJDMTpc3J58l+WxbFl8Yi6omRZoz3ar0Gyd
	KOMdPeG8uWAI5RYyYe8ZJqMje0fjn1zT39PaMavyl0wRmzpoqaHGqntIhFbICoWRLDwmYMsvGxqjW
	o6tDfXO8PjMFAX+Pia+AMnisNMKurcRGrZUI3JbayfDuobycxhgrt3lGnb0Osh17OxzTeSJacFvEb
	OUqTfVbbgb9UEy44oT7naNqHZjVRrTgXBUseXLS4ye6N+Skdt/SM0JOEPA15WeHvKD6H4RuDLRueQ
	ww2sbYXQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy2S-2x0h;
	Fri, 27 Nov 2026 15:27:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000PqK-1v9P;
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
Subject: [PATCH v3 05/15] KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
Date: Fri, 27 Nov 2026 15:27:20 +0000
Message-ID: <20261127152730.99319-6-dwmw2@infradead.org>
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

KVM fails every Hyper-V hypercall which it does not implement with
HV_STATUS_INVALID_HYPERCALL_CODE, so a VMM which implements more of the
TLFS never sees them.

Add a VM capability whose value is a mask of hypercall handling
features, as KVM_CAP_XEN_HVM and KVM_CAP_EXIT_HYPERCALL have;
KVM_ENABLE_CAP takes the subset to enable.  The first feature,
KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends those hypercalls, and extended
hypercalls in fast form, out through the existing KVM_EXIT_HYPERV_HCALL.
XMM state is reachable through the vCPU state ioctls.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 50 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           |  7 ++++-
 arch/x86/kvm/hyperv.h           |  8 ++++++
 arch/x86/kvm/x86.c              | 16 +++++++++++
 include/uapi/linux/kvm.h        |  4 +++
 6 files changed, 86 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6d4a11ce368c..782c010a08a0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7362,6 +7362,16 @@ Hyper-V SynIC state change. Notification is used to remap SynIC
 event/message pages and to enable/disable SynIC messages/events processing
 in userspace.
 
+	- KVM_EXIT_HYPERV_HCALL -- a hypercall for userspace to handle.
+
+'input' holds the hypercall control value and 'params' the two parameter
+registers.  Userspace sets 'result' to the hypercall result value before
+resuming the vCPU; KVM then writes it to the guest and advances past the
+hypercall instruction.  KVM leaves some hypercalls to userspace this
+way, HvCallPostMessage in some cases among them;
+KVM_CAP_HYPERV_FORWARD_HCALL (see section 7.49) adds the hypercalls KVM
+does not implement.
+
 	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
 
 Hyper-V Synthetic debugger state change. Notification is used to either update
@@ -9263,6 +9273,46 @@ KVM_CAP_X86_USER_SPACE_MSR and KVM_X86_SET_MSR_FILTER.
 A guest whose register state is protected is the exception: see the
 description of those exits.
 
+7.49 KVM_CAP_HYPERV_FORWARD_HCALL
+---------------------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] is a bitmask of KVM_HYPERV_HCALL_* features to enable
+:Returns: 0 on success, -EINVAL if args[0] contains an unsupported bit
+
+KVM_CHECK_EXTENSION for this capability returns a bitmask of the Hyper-V
+hypercall handling features that KVM implements.  KVM_ENABLE_CAP takes
+the subset that userspace wants active and replaces the previously
+enabled set; it can be called at any time.  A bit that
+KVM_CHECK_EXTENSION does not report is rejected with -EINVAL, so a VMM
+can enable exactly the features it was written for and learn which ones
+the kernel lacks.  The mask is reported in the int which
+KVM_CHECK_EXTENSION returns, so features only ever use bits 0 to 30.
+
+The defined bits are::
+
+  #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
+
+KVM_HYPERV_HCALL_FORWARD_UNKNOWN: a hypercall that KVM would otherwise
+fail with HV_STATUS_INVALID_HYPERCALL_CODE exits to userspace with
+KVM_EXIT_HYPERV_HCALL instead, and an extended hypercall in fast form
+exits the same way instead of failing with HV_STATUS_INVALID_PARAMETER.
+The VMM can then implement hypercalls that KVM does not.  The synthetic
+debugger hypercalls (HvCallResetDebugSession, HvCallPostDebugData,
+HvCallRetrieveDebugData) are an exception: while the synthetic debugger
+is not enabled they still fail in KVM, with HV_STATUS_INVALID_PARAMETER
+for the fast form of HvCallPostDebugData and HvCallRetrieveDebugData and
+with HV_STATUS_INVALID_HYPERCALL_CODE otherwise.
+
+For a fast hypercall, 'params' carries RDX and R8 from a 64-bit caller,
+or the EBX:ECX and EDI:ESI pairs from a 32-bit caller.  XMM input and
+output registers of a fast hypercall are read and written with the
+ordinary vCPU state ioctls (KVM_GET_XSAVE/KVM_SET_XSAVE or
+KVM_GET_FPU/KVM_SET_FPU) before the vCPU is resumed.  Hypercalls that
+KVM implements itself, and the CPUID-enforcement checks KVM applies
+before dispatching a hypercall, are unaffected.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 0e8150116e20..dcb0ce584f02 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1072,6 +1072,8 @@ struct kvm_hv {
 	struct mutex hv_lock;
 	u64 hv_guest_os_id;
 	u64 hv_hypercall;
+	/* KVM_HYPERV_HCALL_* features enabled by KVM_CAP_HYPERV_FORWARD_HCALL */
+	u64 hcall_features;
 	u64 hv_tsc_page;
 	enum hv_tsc_page_status hv_tsc_page_status;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 5d2e3617c952..e72539f9acc9 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2692,12 +2692,17 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		goto hypercall_userspace_exit;
 	}
 	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
-		if (unlikely(hc.fast)) {
+		if (unlikely(hc.fast) &&
+		    !kvm_hv_hcall_feature(vcpu->kvm,
+					  KVM_HYPERV_HCALL_FORWARD_UNKNOWN)) {
 			ret = HV_STATUS_INVALID_PARAMETER;
 			break;
 		}
 		goto hypercall_userspace_exit;
 	default:
+		if (kvm_hv_hcall_feature(vcpu->kvm,
+					 KVM_HYPERV_HCALL_FORWARD_UNKNOWN))
+			goto hypercall_userspace_exit;
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
 	}
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 622a6553e9ac..20d40261c75b 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -205,6 +205,14 @@ static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hyperv_enabled && to_kvm_hv(vcpu->kvm)->hv_guest_os_id;
 }
 
+/* Features reported and accepted by KVM_CAP_HYPERV_FORWARD_HCALL. */
+#define KVM_HYPERV_HCALL_SUPPORTED	KVM_HYPERV_HCALL_FORWARD_UNKNOWN
+
+static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
+{
+	return READ_ONCE(to_kvm_hv(kvm)->hcall_features) & feature;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
 
 void kvm_hv_irq_routing_update(struct kvm *kvm);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 31c6759f38b9..da22e7d9cacd 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2306,6 +2306,13 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_EXIT_HYPERCALL:
 		r = KVM_EXIT_HYPERCALL_VALID_MASK;
 		break;
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_CAP_HYPERV_FORWARD_HCALL:
+		/* KVM_CHECK_EXTENSION returns an int: only bits 0-30 report. */
+		BUILD_BUG_ON(KVM_HYPERV_HCALL_SUPPORTED > INT_MAX);
+		r = KVM_HYPERV_HCALL_SUPPORTED;
+		break;
+#endif
 	case KVM_CAP_SET_GUEST_DEBUG2:
 		return KVM_GUESTDBG_VALID_MASK;
 #ifdef CONFIG_KVM_XEN
@@ -4152,6 +4159,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		kvm->arch.hypercall_exit_enabled = cap->args[0];
 		r = 0;
 		break;
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_CAP_HYPERV_FORWARD_HCALL:
+		r = -EINVAL;
+		if (cap->args[0] & ~KVM_HYPERV_HCALL_SUPPORTED)
+			break;
+		WRITE_ONCE(to_kvm_hv(kvm)->hcall_features, cap->args[0]);
+		r = 0;
+		break;
+#endif
 	case KVM_CAP_EXIT_ON_EMULATION_FAILURE:
 		r = -EINVAL;
 		if (cap->args[0] & ~1)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index a146c0487960..5803c84cf8f8 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -126,6 +126,9 @@ struct kvm_hyperv_exit {
 	} u;
 };
 
+/* KVM_CAP_HYPERV_FORWARD_HCALL feature bits */
+#define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
+
 struct kvm_xen_exit {
 #define KVM_EXIT_XEN_HCALL          1
 	__u32 type;
@@ -1010,6 +1013,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
 #define KVM_CAP_X86_MSR_EXIT_INSN 253
+#define KVM_CAP_HYPERV_FORWARD_HCALL 254
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1

