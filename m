Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=cSRKw+AUVD4VZQMuPuArZEeJBJuwz67DEaowY9OxqRV6po7bbiLHPnV4Fc0DcwKf7xIZ
	 Vzf8pFfFL1aGlu5MzZDx4z+6GbR3Ig0ivHYxUCGBBMiuZs4kSagwotzKYhlU+YBZ6kTD7
	 B8MnQqqJW88pTjjXjxgnMyafgDasEzXDXeVoIKelYFzoCImcu+YYA+0ZdI0AglJm080kc
	 PkkOcT0yT2rMa3yx5sA6MRfWTMYCFKJq0oMktErnv5kJnVXUhHjDQj9ALpY+nnTsqR8er
	 Rl+FpDzfoKg/HSxqqPXjkOXhDn/NAkFXNRiP9cuCspzwlQQz21985l4HtdqPaobnE0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=R9iXh39dZZCE3gaRA9kMFf1oh9f6gEsCdkgy+uiqVUs=;
	b=XJhHbuMCNE67pYl3/eXIkhq7G3obUwRQDG+wPCPlGG3MafVnJOSRYKEA/Gj0p+i1/eLW
	 aW1QiednA/W7Z+z2JlvvRhzvxeh7u4jJ7xW5YUZM/6uHDc/vbJ/kJiXH8FwOtOwOoQIvR
	 BBpFnWI0+C4lRCmwUWEioXe9xRN6Pn3FQc2BYs63KJoMcBiFoBTCLm7H9Kj0Vg3yN8TyY
	 RTUyuZud9s0E3VRo94rkQCauZyyycZUE8u9BvSl8f831VP1+DzFGMFbkAkuo4onkgM+u5
	 WvVRpWqbAbACzxHhJ8x/PqnvoVeVtKblHeJ4P+moVh0oEnQrOkyETEcMm5tehxZa1iQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=auwbJd4Z;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A49C606A336;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A49C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=auwbJd4Z
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=R9iXh39dZZCE3gaRA9kMFf1oh9f6gEsCdkgy+uiqVUs=; b=auwbJd4Zrq/Bkqepherrrz4c6g
	UIG2NN7ORU9r5BNxmoY6EWoez6jMr4fJuJOM+vtk8SYuWrEWxt5Z3BU6yoswe1kvXc1283dwHb0eU
	0zbparAVG+OUaWQ0Ovn1WxdJDIjzCjKocgnWejWlfzvBCxfPXxkDukaTpFwf3fV9mSHSUwDkCUcIs
	R49aSyaA7oPYulr4x1Y9jjxL3sPxWiLG83l1nG1Z5cKRah0WK66Lil8iKehkqy4OEUdC62j8ragjU
	IZAK4ijDPIAqcpyVeX4wu7elqljcMe9iMf1V/658KrRuBXHjBNvM8+CTWq/xrazvoImQEkUMXNy7h
	xft87+VA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQM-0Toj;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LtS-3pFO;
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
Subject: [RFC PATCH v2 14/31] KVM: VMX: Report GVA and instruction bytes on plane-protection faults
Date: Fri, 13 Nov 2026 18:34:30 +0000
Message-ID: <20261113183448.84094-15-dwmw2@infradead.org>
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

A plane memory-protection fault is reflected to userspace as
KVM_EXIT_MEMORY_FAULT, and a VSM VMM turns it into the TLFS GPA
intercept message for the higher VTL. That message carries the
guest-linear address and the faulting instruction's length and bytes,
none of which the exit reports.

Extend memory_fault with 'gva', 'insn_len' and 'insn_bytes', and a
KVM_MEMORY_EXIT_FLAG_GVA_VALID flag qualifying 'gva'. On VMX, fill them
in handle_ept_violation() while the exit state is still at hand: the
GVA from GUEST_LINEAR_ADDRESS when the exit qualification says it is
valid, the length from VM_EXIT_INSTRUCTION_LEN (architecturally
undefined for EPT violations, but provided by the hardware), and the
bytes read at the linear RIP unless the access was the instruction
fetch itself. The bytes are best effort and zeroed if the read fails.
The plane's protections can refuse that read as well (a protected code
or page-table page is the normal VSM layout), and a refused read
prepares a memory-fault exit of its own; save the exit being reported
around the read so the read cannot replace it.

The new fields fit in the existing kvm_run union and are documented as
present on kernels that advertise KVM_CAP_PLANE_MEMORY_OVERLAYS.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst | 14 ++++++++
 arch/x86/kvm/vmx/vmx.c         | 63 +++++++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h       |  6 ++++
 3 files changed, 82 insertions(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 99e18956f249..f1c64d721570 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7721,9 +7721,15 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
   #define KVM_MEMORY_EXIT_FLAG_WRITE    (1ULL << 1)
   #define KVM_MEMORY_EXIT_FLAG_EXEC     (1ULL << 2)
   #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+  #define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
+			/* set on plane-protection faults when available */
+			__u64 gva;
+			__u32 insn_len;
+			__u8  insn_bytes[16];
+			__u32 pad;
 		} memory_fault;
 
 KVM_EXIT_MEMORY_FAULT indicates the vCPU has encountered a memory fault that
@@ -7736,6 +7742,14 @@ describes properties of the faulting access that are likely pertinent:
  - KVM_MEMORY_EXIT_FLAG_PRIVATE - When set, indicates the memory fault occurred
    on a private memory access.  When clear, indicates the fault occurred on a
    shared access.
+ - KVM_MEMORY_EXIT_FLAG_GVA_VALID - When set, 'gva' holds the faulting guest
+   virtual address.
+
+The 'gva', 'insn_len' and 'insn_bytes' fields exist only on kernels
+which advertise KVM_CAP_PLANE_MEMORY_OVERLAYS (see section 8.48).  On
+plane memory-protection faults, 'insn_len' and 'insn_bytes' carry a
+best-effort copy of the faulting instruction when KVM could fetch it;
+an 'insn_len' of 0 means no instruction bytes are available.
 
 Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it
 accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 4e7eec9a0625..b5aa7110bf36 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -70,6 +70,7 @@
 #include "vmcs12.h"
 #include "vmx.h"
 #include "x86.h"
+#include "kvm_emulate.h"
 #include "x86_ops.h"
 #include "smm.h"
 #include "tss.h"
@@ -6050,6 +6051,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification = vt_get_exit_qual(vcpu);
 	gpa_t gpa;
+	int ret;
 
 	/*
 	 * EPT violation happened while executing iret from NMI,
@@ -6076,7 +6078,66 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	if (unlikely(allow_smaller_maxphyaddr && !kvm_vcpu_is_legal_gpa(vcpu, gpa)))
 		return kvm_emulate_instruction(vcpu, 0);
 
-	return __vt_handle_ept_violation(vcpu, gpa, exit_qualification);
+	ret = __vt_handle_ept_violation(vcpu, gpa, exit_qualification);
+
+	/*
+	 * A plane-protection fault reflected to userspace becomes a TLFS
+	 * GPA intercept message, which carries the guest-linear address
+	 * and the faulting instruction's bytes.  Harvest them while the
+	 * exit state is still at hand.
+	 */
+	if (ret == -EFAULT &&
+	    vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT &&
+	    (vcpu->run->memory_fault.flags & (KVM_MEMORY_EXIT_FLAG_READ |
+					      KVM_MEMORY_EXIT_FLAG_WRITE |
+					      KVM_MEMORY_EXIT_FLAG_EXEC))) {
+		unsigned int len;
+
+		if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
+			vcpu->run->memory_fault.gva =
+				vmcs_readl(GUEST_LINEAR_ADDRESS);
+			vcpu->run->memory_fault.flags |=
+				KVM_MEMORY_EXIT_FLAG_GVA_VALID;
+		}
+		/*
+		 * Architecturally undefined for EPT violations, but the
+		 * hardware provides the faulting (for a fetch: the
+		 * fetching) instruction's length here, and the TLFS
+		 * message carries exactly that.
+		 */
+		len = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
+		len = min_t(unsigned int, len,
+			    sizeof(vcpu->run->memory_fault.insn_bytes));
+		vcpu->run->memory_fault.insn_len = len;
+		if (!(exit_qualification & EPT_VIOLATION_ACC_INSTR)) {
+			typeof(vcpu->run->memory_fault) fault =
+				vcpu->run->memory_fault;
+			u32 exit_reason = vcpu->run->exit_reason;
+			struct x86_exception e;
+			int r;
+
+			/*
+			 * kvm_read_guest_virt() takes a linear address: RIP
+			 * is CS-relative, and the two coincide only when
+			 * CS.base is zero (64-bit mode, or a flat 32-bit
+			 * code segment).
+			 */
+			r = kvm_read_guest_virt(vcpu, kvm_get_linear_rip(vcpu),
+						fault.insn_bytes, len, &e);
+			/*
+			 * The plane's protections can refuse the read too (a
+			 * protected code or page-table page is the normal VSM
+			 * layout), and a refused read prepares a memory-fault
+			 * exit of its own.  Report the fault that was taken.
+			 */
+			vcpu->run->exit_reason = exit_reason;
+			vcpu->run->memory_fault = fault;
+			if (r)
+				memset(vcpu->run->memory_fault.insn_bytes, 0,
+				       sizeof(vcpu->run->memory_fault.insn_bytes));
+		}
+	}
+	return ret;
 }
 
 static int handle_ept_misconfig(struct kvm_vcpu *vcpu)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b260d4d8aa22..25626be71eb7 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -489,9 +489,15 @@ struct kvm_run {
 #define KVM_MEMORY_EXIT_FLAG_WRITE      (1ULL << 1)
 #define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
+#define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
+			/* set on plane-protection faults when available */
+			__u64 gva;
+			__u32 insn_len;
+			__u8  insn_bytes[16];
+			__u32 pad;
 		} memory_fault;
 		/* KVM_EXIT_TDX */
 		struct {
-- 
2.50.1

