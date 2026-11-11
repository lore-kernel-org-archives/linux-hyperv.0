Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430725;
	b=P+IhqMaeHS1VvWdxcpQtpBj41UK89pffoQWYRb2UhjAfdRIT21ayfOPCLJYRVyS/hUvB
	 KlMZVscJxswdUxIaqto66KQTSee/QaVimCeZIkGk4EzRpRInqa3CmMxdGb4r6Tkxblf4G
	 fXeUBVSTj00RfArEq2yBRqeQ1TQRf7oqda7FzZxijOMnfjXjk92ZvlINezY2HtTETcE2A
	 Qtiv+2EalDwKcuy4AFFRpgIRhow0WHtTqp0maRnHqG+ixPTnaFq/y9CHupBgkZhGQQtbS
	 Y9bDU2y7THa4FfEo7YFWqm7lMuj219R0xy/5reewsk6rEf4R6oWMTkyz4LnJRz4tXdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430725;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=dome5fqoVGfpsjSJgZWU5i54tZyBrmW6npW+H6ZvLLM=;
	b=WZ6wzT7MnOqqJAKSlNtfcEUp/HxVJcRYH2uqLhPqWJPXyabj1TDJCRw6PMz8Sf/jvadu
	 fwM1V4Q2xeqIvU8vjAQPz6/Q3m+2cxFHoE1YzQMuirE/z9JB5OYVY+/QY1/YQ/wHd0VVg
	 4tb56wsOXeMfSx39hEmlpdHtJzzDG3AGcW/VXUwmmZeevWjl3HRA1EO31afrS5WvnGR1r
	 4f3X46z3BnTvpnMKVIDpYiyvNtB5nZMzE1oNDV94nTBaU6hgu6nRdoy0y/eSQeNvnsbb9
	 HG239pKwhZFA4KhACRreq1aK1qG1SapCSeIBbUqy3QXMlT3yjqOnT+j96OyHUnM3dow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=I+k4aFJr;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BBF606A89C;
	Wed, 11 Nov 2026 20:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14BBF606A89C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=I+k4aFJr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=dome5fqoVGfpsjSJgZWU5i54tZyBrmW6npW+H6ZvLLM=; b=I+k4aFJrAfYpQqzL5iMhIm16Nq
	3ZBtgaf6TesW8Pp6mraNXlG7dyUNjgHD09SJfZaPSHFEn8JV5zrYJGE7BraAd7Cv1AV+0BWTbJWqb
	iRevFPcdiKtlBYbnQbHcZXUlNgW9EyL5X2k2BXJCodDY3HzNWMYSZifIhW0at2lKvDmp6WkgQz1S1
	QZIZttv5J+tRnWQd+rrg0uVVQFLYOz7fcFamiCR0jTIILCCD1r1cGKQ6S8xbRHS4lpClDQrpyKOaE
	BW5MlUUsCJ+sfyc74PpRTAcmYk7+hqLgixc4xUUsNCNIckOd3y27ik3WzYZgQE5hUBJnqIOqlHqdh
	c0twW3FA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFOx-00000009ZGs-26fG;
	Wed, 11 Nov 2026 20:58:39 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRFOu-0000000HZ7h-2WHE;
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
Subject: [PATCH 1/4] KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
Date: Wed, 11 Nov 2026 12:58:33 -0800
Message-ID: <20261111205836.4186584-2-dwmw2@infradead.org>
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

A VMM that implements Hyper-V hypercalls KVM does not know about has
no way to receive them. kvm_hv_hypercall() fails an unknown code with
HV_STATUS_INVALID_HYPERCALL_CODE, and only a fixed set (the synthetic
debugger, memory-based extended hypercalls, HvCallPostMessage and the
HvCallSignalEvent fallback) ever exits to userspace.

Add a VM capability whose KVM_CHECK_EXTENSION value is a bitmask of the
hypercall handling features the kernel implements, as KVM_CAP_XEN_HVM
and KVM_CAP_EXIT_HYPERCALL do. KVM_ENABLE_CAP takes the subset to
enable and rejects any bit the kernel does not report, so a VMM can
probe for exactly the behaviour it relies on.

The first feature, KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends a hypercall
KVM would have failed as unknown, and an extended hypercall in fast
form, out through the existing KVM_EXIT_HYPERV_HCALL. That exit already
carries the control value and both parameter registers, and XMM state
is reachable through the ordinary vCPU state ioctls, so no new exit
format is needed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 49 +++++++++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  2 ++
 arch/x86/kvm/hyperv.c           |  7 ++++-
 arch/x86/kvm/hyperv.h           |  8 ++++++
 arch/x86/kvm/x86.c              | 14 ++++++++++
 include/uapi/linux/kvm.h        |  4 +++
 6 files changed, 83 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index e95c9cda085d..092f6f9ad8a0 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7312,6 +7312,17 @@ Hyper-V SynIC state change. Notification is used to remap SynIC
 event/message pages and to enable/disable SynIC messages/events processing
 in userspace.
 
+	- KVM_EXIT_HYPERV_HCALL -- a hypercall for userspace to handle.
+
+'input' holds the hypercall control value and 'params' the two parameter
+registers.  Userspace sets 'result' to the hypercall result value before
+resuming the vCPU; KVM then writes it to the guest and advances past the
+hypercall instruction.  HvCallPostMessage, HvCallSignalEvent for a
+connection with no registered eventfd, the synthetic debugger hypercalls
+and memory-based extended hypercalls exit this way;
+KVM_CAP_HYPERV_FORWARD_HCALL (see section 7.48) adds the hypercalls KVM
+does not implement.
+
 	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
 
 Hyper-V Synthetic debugger state change. Notification is used to either update
@@ -9181,6 +9192,44 @@ enabled, cmma can't be enabled anymore and pfmfi and the storage key
 interpretation are disabled. If cmma has already been enabled or the
 hpage_2g module parameter is not set to 1, -EINVAL is returned.
 
+7.48 KVM_CAP_HYPERV_FORWARD_HCALL
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
+enabled set; it can be called at any time.  A bit that KVM_CHECK_EXTENSION
+does not report is rejected with -EINVAL, so a VMM can enable exactly the
+features it was written for and learn which ones the kernel lacks.
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
+for the fast form of HvCallPostDebugData and HvCallRetrieveDebugData
+and with HV_STATUS_INVALID_HYPERCALL_CODE otherwise.
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
index 1ee4b127004d..fce46ae26137 100644
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
index 26e7beaff8a0..d8de7742a0da 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2305,6 +2305,11 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_EXIT_HYPERCALL:
 		r = KVM_EXIT_HYPERCALL_VALID_MASK;
 		break;
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_CAP_HYPERV_FORWARD_HCALL:
+		r = KVM_HYPERV_HCALL_SUPPORTED;
+		break;
+#endif
 	case KVM_CAP_SET_GUEST_DEBUG2:
 		return KVM_GUESTDBG_VALID_MASK;
 #ifdef CONFIG_KVM_XEN
@@ -4144,6 +4149,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
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
index 8dff2fc1972e..7194c213a742 100644
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
@@ -1000,6 +1003,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PPC_COMPAT_CAPS 250
 #define KVM_CAP_ARM_PMU_V3_STRICT 251
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
+#define KVM_CAP_HYPERV_FORWARD_HCALL 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1

