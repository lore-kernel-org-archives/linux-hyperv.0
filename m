Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22B3E6394;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=Qh9HbrueVvduQVFFbFlUmLiI/o8dV6jw+dbADdqiY1+hDBIScWNteygLIbjtQ4GUqmDmycEDaSea6eF9bRVbtpRL+HdfwAQgwIcKUaVCskMtv7yH3tJBLvCalmeH27I2/AFXiBxZqOeS0afXWKUF0h6j3YVq+WSXEGujIRxJdGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=LWpNYS2M4N7Sdbns/zrcHREtIf5zPxDmuIKyiHmQMDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=auSGAvW+rUoUREfLn2HyUIgATKh3n5M+b+0OpZRPKGIk+X9AUdE8mlSjYfQxwFektDyPHC5EVdOvlYefmkXxQehd7sd2OCAFmYKOke8kq6c9zh77SNvQ9EdTDVAxJA8eGUGx8473SWjeVMpdcRID2JRzIIimXBMck0MXR2bjoug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T+DW5Jbp; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T+DW5Jbp"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=bJk1mYeRahTsqyuXM+Ax627QX1n7rFbufDIM/kdUrek=; b=T+DW5JbpWR4eFGzRXe10zD9t4K
	Ja0FmuJQdraGXdyFxWUqfhKtPrT1kOqAj2wekp3UhTGy/0/g36JOP6jwjPVha94kaJ2YgXEJICGzN
	VxobSKnmc/vET6NnH20L1j81mcGTg8+Firt5cKkUJuCbc+vxYHJTy+fwuidttWdEo3z7QRRWWpQKi
	+A4m1lab+VP2JNbXN010igZDPrmw9mjVeEa0yzER5I4gNpwPcgl09Uxx+shxWWBMr4J+ilQ+L7XoH
	dj3d+mw6ZdhMx4AZeNeFYdN75f7iLBi8Svj1zwKqmBlEIOnIctKOLIuHOHmDOoCky9Ao8zgMLUCv7
	ONPSuphg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TC-0000000CVCB-0w53;
	Sat, 17 Oct 2026 12:25:02 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002Yl7-08RW;
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
Subject: [RFC PATCH 05/55] KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
Date: Sat, 17 Oct 2026 13:24:11 +0100
Message-ID: <20261017122501.610248-6-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A VMM implementing Hyper-V hypercalls that KVM does not know about,
such as the VSM set, has no way to receive them: kvm_hv_hypercall()
fails unknown codes with HV_STATUS_INVALID_HYPERCALL_CODE, and only
syndbg and slow-form extended hypercalls ever exit to userspace.

Add a VM capability which routes any hypercall KVM would have failed
as unknown out through the existing KVM_EXIT_HYPERV_HCALL exit, fast
forms included. The exit already carries the control value and both
parameters (RDX and R8 for fast calls), and XMM state is reachable
through the ordinary vCPU ioctls, so no new exit format is needed.
A future in-kernel accelerator for a specific hypercall can still
claim its code behind its own capability, with userspace handling as
the fallback.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst  | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/kvm_host.h |  1 +
 arch/x86/kvm/hyperv.c           |  5 ++++-
 arch/x86/kvm/x86.c              | 10 ++++++++++
 include/uapi/linux/kvm.h        |  1 +
 5 files changed, 42 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index bc63054ce7bd..ade8c91ef24b 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8986,6 +8986,32 @@ This capability must be enabled before any vCPU or extra plane has been
 created, and the chosen count cannot be changed afterwards; otherwise
 -EEXIST is returned.
 
+7.48 KVM_CAP_HYPERV_FORWARD_HCALL
+---------------------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] is 1 to enable forwarding, 0 to disable it
+
+When enabled, a Hyper-V hypercall that KVM would otherwise have failed
+with HV_STATUS_INVALID_HYPERCALL_CODE instead exits to userspace with
+KVM_EXIT_HYPERV_HCALL, and extended hypercalls in fast form exit the
+same way instead of failing with HV_STATUS_INVALID_PARAMETER.  This
+lets a VMM implement hypercalls KVM does not know, such as the Hyper-V
+VSM set.  The synthetic-debugger hypercalls (HvCallResetDebugSession,
+HvCallPostDebugData, HvCallRetrieveDebugData) are an exception: while
+the synthetic debugger is not enabled they still fail in KVM with
+HV_STATUS_INVALID_HYPERCALL_CODE and are not forwarded.
+
+The exit carries the control value and the input and output parameters
+(for fast hypercalls, RDX and R8 from a 64-bit caller, or the EBX:ECX
+and EDI:ESI pairs from a 32-bit caller).  Register argument and
+return state of fast hypercalls, such as the XMM registers, is read and
+written with the ordinary vCPU state ioctls before resuming the vCPU
+with ``hyperv.u.hcall.result`` set.  Hypercalls KVM implements itself,
+and the ordering of CPUID-enforcement checks against hypercall
+dispatch, are unaffected.
+
 7.49 KVM_CAP_HCALL_FAULT_EXIT
 ------------------------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e4c8691dc1e1..05670b5ae28a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1204,6 +1204,7 @@ struct kvm_hv {
 	struct mutex hv_lock;
 	u64 hv_guest_os_id;
 	u64 hv_hypercall;
+	bool hv_forward_hcalls;
 	u64 hv_tsc_page;
 	enum hv_tsc_page_status hv_tsc_page_status;
 
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 98a3c2aefdcd..ec669dafda6e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2777,12 +2777,15 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 	}
 	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
-		if (unlikely(hc.fast)) {
+		if (unlikely(hc.fast) &&
+		    !to_kvm_hv(vcpu->kvm)->hv_forward_hcalls) {
 			ret = HV_STATUS_INVALID_PARAMETER;
 			break;
 		}
 		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 	default:
+		if (to_kvm_hv(vcpu->kvm)->hv_forward_hcalls)
+			return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
 		ret = HV_STATUS_INVALID_HYPERCALL_CODE;
 		break;
 	}
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a9073436c734..8de596e00441 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4883,6 +4883,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
+	case KVM_CAP_HYPERV_FORWARD_HCALL:
 #endif
 	case KVM_CAP_HCALL_FAULT_EXIT:
 	case KVM_CAP_PCI_SEGMENT:
@@ -6886,6 +6887,15 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		mutex_unlock(&kvm->lock);
 		break;
 	}
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_CAP_HYPERV_FORWARD_HCALL:
+		r = -EINVAL;
+		if (cap->args[0] & ~1ULL)
+			break;
+		to_kvm_hv(kvm)->hv_forward_hcalls = !!cap->args[0];
+		r = 0;
+		break;
+#endif
 	case KVM_CAP_X2APIC_API:
 		r = -EINVAL;
 		if (cap->args[0] & ~KVM_X2APIC_API_VALID_FLAGS)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 839e9e83d21d..5567cf352907 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1015,6 +1015,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_S390_KEYOP 247
 #define KVM_CAP_S390_VSIE_ESAMODE 248
 #define KVM_CAP_PLANES 249
+#define KVM_CAP_HYPERV_FORWARD_HCALL 250
 #define KVM_CAP_HCALL_FAULT_EXIT 252
 
 struct kvm_irq_routing_irqchip {
-- 
2.50.1

