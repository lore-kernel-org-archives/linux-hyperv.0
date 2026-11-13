Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589546;
	b=EDXXmih0jb8sjlMpjKO24sYb/xWpjSFP0WPSv/SXhEw9cjU3TWyHbbYP4wktyUq2chd6
	 1i8b9j1SF3Vy6ZeYv5xYApi8z05jZTB8ni9hObTD+qPmx0RuaIP/kPnUfLY31PEStQXYp
	 jy9NFAGyo3NhzrdyJc7jqt6wnhhwObUCQT4kuBRhkUUig3s/4dTCEbW9wKPfRroGEgx1+
	 9JYpVpZIhdEoPNGzqKddO0+gaAD1UrEHqumwh0vjahdxSaylimFn56KMdp+6HltBwvupl
	 JtWjHR7+dsYVlcfWUdVARgf6j4D7DXN9oh75BhRU+NMt/vxwtjLDKHsmI1+GQP47mcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589546;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=r4kolSWIQmB5Rco3QGYsut9S6KaTlLdaFXzI+IEU1KU=;
	b=LMYm4U2jlWE63JWM/lhAML5w04GTMAokg0lzSMQjNyXE7zwi9veoxzrbzUzUMH5TzUIW
	 M4Gh5gJPhXxfcxPUmTCVgp5hnICNsDFKO8tOKuxENHoYkRX6Q6u5Fyg7cdH3XHt9jd6Zu
	 d7QvpDmTyLHPJc6B2xVKwh9w+DRrVpaY6wlYKaQY2ZVUqU1o2e5Wvcql1IGY9my7BVRFq
	 pTmW0e707BFHYaswsv3qWs4oM6TyRxpNrY4i/FGeUe2u3C1oeoFIzOSV7KMHuuALj+7NA
	 Z3bbrePUd20LPN1AgCCUoHs/9shA9yRfKUHlrqtDg1Cw8MyrpkNaG/b7DxtuIWerRAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=EAFC0cDO;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3942606A330;
	Fri, 13 Nov 2026 17:05:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C3942606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=EAFC0cDO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=r4kolSWIQmB5Rco3QGYsut9S6KaTlLdaFXzI+IEU1KU=; b=EAFC0cDOVy0JxPEa6TVaTElOqg
	PYB1xooaLl6cyS29P7xnRqZkxiuR/5CHWCxlI00W5GMNpVEys1vixF9oT4mh2OLJtKZHQ3ScPnbyt
	+AEvvzZhtHu694XwKUN5/wUKwwpzDr946Y31b7XUtZXORjsa5sNAnFXxywhI32gKRD7Fa/AnFgh3B
	u1nM0WKc2U/LXSNEw25x/5oKah3w4CA5eKLKRBcvX/yqIy768oBu7CpKnL18HhRXh+O8GiEnewHF3
	ILvVr9HAu5Xx4jHomxmwL/Qg8Lxjd0lRXs5ylI0aiyYZVRLyS9Gbj8sqm5SWFnsQHbgrn+qb1aGZB
	mempxCdQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuiY-0000000BYhE-2A09;
	Fri, 13 Nov 2026 17:05:38 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRuiV-00000000KcJ-3RA0;
	Fri, 13 Nov 2026 17:05:35 +0000
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 1/4] KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
Date: Fri, 13 Nov 2026 10:05:32 -0700
Message-ID: <20261113170535.79246-2-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113170535.79246-1-dwmw2@infradead.org>
References: <20261113170535.79246-1-dwmw2@infradead.org>
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
index 8dff2fc1972e..79f128958df5 100644
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
+#define KVM_CAP_HYPERV_FORWARD_HCALL 255
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1

