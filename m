Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A684908D6;
	Sat, 17 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239912; cv=none; b=ITmluo7hAvZ5a9digzHVUeGBWsjce+BJfQ2+aqHdbCsquoZqEW6na1a1T9+XjlSPiXDKKXrWq17z6PNzN3i25PWz2UXMXZxMy3RrKr8HFj5uEy4+kHwRfxzuFEiF/HWyemFEOEb0K+TrwJuu0e1JvzwSpU9HgR+rksZE6UqBhYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239912; c=relaxed/simple;
	bh=uRPp8koHKdjts/Q58qNLakJQ6itcFu3gFf9DQim1LAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FDiY2P3atKCP/CXx2qhOnm9VCmD2Djp+kRfArtrFkwJP7Lpbv7sflL0fgk64MoO2iQlh+SyvFuB4BY9fsayqXFu7g/MxnLor8uglOGZNRZwLPRtqoKpc5PVWrjQ6WKWFr720Z54KtA19gOJ+VxxkCSkb/cMnrzjqRzXUb8EzFxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mnfMFEwB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mnfMFEwB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mv6hD5VZbXMLbFWDeSujUGk9u70wmEwN2+6LDT3MNZU=; b=mnfMFEwB1N0uhTJHDV5z+c+qTG
	aRKFXgRHMT5Q+CeFZHx3flR5ipOwjIOCNXGsxaMw4348LRo8Bs4O5I/7QiKYqGnT1tknKMfoIAg9G
	IUlSUFqe8bSy/x5imYGZBTcvn0aWVG/ISgad1nlOWsKa47aIVB4c34gHyCqA4W4NYS3Dg8XlLh5Cj
	paQN782Lt484EjkP70xm1APVOzh/6kWobiEgZ3LThsE6EhuuyShkD3S9t3Lfce60GMUU7dJ2Wyham
	dHrxFjPqImw2RINt5qcW0aHKCg/s8fZAQ/bgvCJZXjyG8Jg70zKSyvaqxzd9WNfYeMh28cIQpmzsl
	MqgLJYRw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVEG-1e9v;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002YoG-0omF;
	Sat, 17 Oct 2026 13:25:04 +0100
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
Subject: [RFC PATCH 49/55] KVM: SVM: Carry instruction state on reflected plane-protection faults
Date: Sat, 17 Oct 2026 13:24:55 +0100
Message-ID: <20261017122501.610248-50-dwmw2@infradead.org>
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

A plane-protection fault reflected to userspace becomes a TLFS GPA
intercept message, which carries the faulting instruction's length,
its bytes (for data accesses), and the fault-adjusted RFLAGS.  The
VMX exit handler harvests all of that from the VMCS, but
npf_interception() reflected the bare fault: on AMD the higher VTL
received intercept messages with instruction length 0, no instruction
bytes and RFLAGS.RF clear, failing the hyperv_vsm KUT
intercept-message tests ("Seen an expected read/write intercept
message").

Decode assists stash the raw fetch window (up to 15 bytes, not the
decoded length) in the VMCB for data accesses; run it through the
instruction decoder and report the decoded length and that many
bytes.  Set RFLAGS.RF before exiting: fault delivery gives the
restarted instruction RF=1, and VMX saves that fault-adjusted value
in guest RFLAGS on fault-type exits while SVM saves RF as it was
during execution.

An execute fault stores no bytes, and the length of the branch that
fetched the faulting page is not architecturally available on SVM
(VMX hardware reports it), so execute intercepts carry length 0.

The validity of the harvested state gets its own flag,
KVM_MEMORY_EXIT_FLAG_INSN_VALID, set by the VMX and SVM harvests only
when they populated the fields: VM_EXIT_INSTRUCTION_LEN is undefined
for EPT violations, all-zero insn_bytes is itself a valid x86
encoding, and kvm_prepare_memory_fault_exit() now clears
gva/insn_len/insn_bytes so no other memory-fault exit carries stale
values.  The flag bit (and PLANE_PROT before it) is enumerated by the
plane memory overlay capability, which also covers the extended
memory_fault layout.  The memory_attributes selftest asserted strict
equality on the exit flags; it now masks the informational flags out
and compares only the access that faulted.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/kvm/mmu/mmu.c                        |  2 +
 arch/x86/kvm/mmu/paging_tmpl.h                |  3 +
 arch/x86/kvm/svm/svm.c                        | 66 +++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c                        | 13 ++--
 include/linux/kvm_host.h                      | 12 ++++
 include/uapi/linux/kvm.h                      | 17 ++++-
 .../testing/selftests/kvm/memory_attributes.c |  6 +-
 7 files changed, 112 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 07a8de28c73d..9a0a5d3ad995 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4787,6 +4787,8 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 
 	if (kvm_faultin_memory_protections(vcpu, fault)) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+		if (kvm_arch_max_planes(kvm) > 1)
+			vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PLANE_PROT;
 		return -EFAULT;
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 78d1e5c9fbe4..f56ed74d4228 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -795,6 +795,9 @@ static int FNAME(page_fault)(struct kvm_vcpu *vcpu, struct kvm_page_fault *fault
 		if (walker.memory_attributes_fault) {
 			kvm_prepare_memory_fault_exit(vcpu, walker.gfn << PAGE_SHIFT,
 						      PAGE_SIZE, false, false, false);
+			if (kvm_arch_max_planes(vcpu->kvm) > 1)
+				vcpu->run->memory_fault.flags |=
+					KVM_MEMORY_EXIT_FLAG_PLANE_PROT;
 			return -EFAULT;
 		}
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 31e5b597c3b0..a30f6f888b51 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2012,6 +2012,72 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 				svm->vmcb->control.insn_bytes : NULL,
 				svm->vmcb->control.insn_len);
 
+	/*
+	 * A plane-protection fault reflected to userspace becomes a TLFS
+	 * GPA intercept message carrying the faulting instruction's length
+	 * and bytes; see the equivalent harvest in handle_ept_violation().
+	 * Decode assists stash the raw fetch window (up to 15 bytes, not
+	 * the decoded length) in the VMCB for data accesses; run it
+	 * through the decoder to report the real length.  A fetch fault
+	 * stores no bytes, and the length of the branch that fetched the
+	 * faulting page is not architecturally available on SVM, so an
+	 * execute intercept reports length 0 (VMX hardware supplies the
+	 * fetching instruction's length there).
+	 */
+	if (rc == -EFAULT &&
+	    vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT &&
+	    (vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PLANE_PROT)) {
+		unsigned int len = 0;
+
+		if (static_cpu_has(X86_FEATURE_DECODEASSISTS) &&
+		    svm->vmcb->control.insn_len &&
+		    x86_decode_emulated_instruction(vcpu, 0,
+						    svm->vmcb->control.insn_bytes,
+						    svm->vmcb->control.insn_len) ==
+								EMULATION_OK) {
+			struct x86_emulate_ctxt *ctxt = vcpu->arch.emulate_ctxt;
+
+			len = min_t(unsigned int, ctxt->_eip - ctxt->eip,
+				    sizeof(vcpu->run->memory_fault.insn_bytes));
+		}
+
+		vcpu->run->memory_fault.insn_len = len;
+		if (len) {
+			/*
+			 * Copy from the decoder's fetch cache, not from the
+			 * VMCB window: the decoder fetches any bytes beyond
+			 * the window from guest memory, so the decoded
+			 * length can exceed control.insn_len, and the
+			 * VMCB-sourced tail would be whatever an earlier
+			 * intercept left behind.
+			 */
+			memcpy(vcpu->run->memory_fault.insn_bytes,
+			       vcpu->arch.emulate_ctxt->fetch.data, len);
+			vcpu->run->memory_fault.flags |=
+				KVM_MEMORY_EXIT_FLAG_INSN_VALID;
+		}
+
+		/*
+		 * The reflected fault is delivered to the higher VTL like an
+		 * exception, and fault delivery gives the to-be-restarted
+		 * instruction RFLAGS.RF=1 (no instruction-breakpoint
+		 * re-trigger on the retry).  VMX saves the fault-adjusted RF
+		 * in guest RFLAGS on a fault-type exit and the TLFS message
+		 * carries that value; SVM saves RF as it was during
+		 * execution, so apply the fault adjustment by hand.
+		 *
+		 * Under NMI-window single-stepping the vmcb RFLAGS carries
+		 * KVM's own TF/RF, and the guest view lives in
+		 * nmi_singlestep_guest_rflags: set RF there too, or
+		 * svm_get_rflags() hides it from userspace and
+		 * disable_nmi_singlestep() wipes it from the vmcb when the
+		 * window closes.
+		 */
+		if (unlikely(svm->nmi_singlestep))
+			svm->nmi_singlestep_guest_rflags |= X86_EFLAGS_RF;
+		svm_set_rflags(vcpu, svm_get_rflags(vcpu) | X86_EFLAGS_RF);
+	}
+
 	if (rc > 0 && error_code & PFERR_GUEST_RMP_MASK)
 		sev_handle_rmp_fault(vcpu, gpa, error_code);
 
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 248d799b46e9..ec50e46404af 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -5987,9 +5987,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	 */
 	if (ret == -EFAULT &&
 	    vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT &&
-	    (vcpu->run->memory_fault.flags & (KVM_MEMORY_EXIT_FLAG_READ |
-					      KVM_MEMORY_EXIT_FLAG_WRITE |
-					      KVM_MEMORY_EXIT_FLAG_EXEC))) {
+	    (vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PLANE_PROT)) {
 		unsigned int len;
 
 		if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
@@ -6007,7 +6005,6 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 		len = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
 		len = min_t(unsigned int, len,
 			    sizeof(vcpu->run->memory_fault.insn_bytes));
-		vcpu->run->memory_fault.insn_len = len;
 		if (!(exit_qualification & EPT_VIOLATION_ACC_INSTR)) {
 			struct x86_exception e;
 
@@ -6019,10 +6016,16 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 			 */
 			if (kvm_read_guest_virt(vcpu, kvm_get_linear_rip(vcpu),
 						vcpu->run->memory_fault.insn_bytes,
-						len, &e))
+						len, &e)) {
 				memset(vcpu->run->memory_fault.insn_bytes, 0,
 				       sizeof(vcpu->run->memory_fault.insn_bytes));
+				len = 0;
+			}
 		}
+		vcpu->run->memory_fault.insn_len = len;
+		if (len)
+			vcpu->run->memory_fault.flags |=
+				KVM_MEMORY_EXIT_FLAG_INSN_VALID;
 	}
 	return ret;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bc576889c6f0..60923494eea5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2755,6 +2755,18 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 	vcpu->run->memory_fault.gpa = gpa;
 	vcpu->run->memory_fault.size = size;
 
+	/*
+	 * Clear the extended fields: only the x86 plane-protection harvest
+	 * fills them in (with the matching validity flags), and a leftover
+	 * from an earlier exit would otherwise masquerade as this fault's
+	 * instruction.  All-zero insn_bytes is a valid x86 encoding, so
+	 * zeroing alone is not a distinguishable "not provided" marker.
+	 */
+	vcpu->run->memory_fault.gva = 0;
+	vcpu->run->memory_fault.insn_len = 0;
+	memset(vcpu->run->memory_fault.insn_bytes, 0,
+	       sizeof(vcpu->run->memory_fault.insn_bytes));
+
 	vcpu->run->memory_fault.flags = 0;
 
 	if (is_write)
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 8224ef335ba1..76d7c87172fd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -481,10 +481,25 @@ struct kvm_run {
 #define KVM_MEMORY_EXIT_FLAG_EXEC       (1ULL << 2)
 #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
 #define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
+/* The fault was caused by the vCPU's plane's memory protections. */
+#define KVM_MEMORY_EXIT_FLAG_PLANE_PROT	(1ULL << 5)
+/*
+ * insn_len/insn_bytes are valid.  For an EXEC fault the faulting
+ * instruction itself cannot be read: insn_bytes stays zero, and
+ * insn_len is the length of the instruction which performed the
+ * fetch (reported by VMX hardware; not available on SVM).
+ */
+#define KVM_MEMORY_EXIT_FLAG_INSN_VALID	(1ULL << 6)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
-			/* set on plane-protection faults when available */
+			/*
+			 * gva/insn_len/insn_bytes are set on plane-protection
+			 * faults when available, and are zero on every other
+			 * memory-fault exit.  They are enumerated, along with
+			 * the PLANE_PROT and INSN_VALID flags, by the plane
+			 * memory overlay capability.
+			 */
 			__u64 gva;
 			__u32 insn_len;
 			__u8  insn_bytes[16];
diff --git a/tools/testing/selftests/kvm/memory_attributes.c b/tools/testing/selftests/kvm/memory_attributes.c
index 63dec49c2888..17b5bc6bddda 100644
--- a/tools/testing/selftests/kvm/memory_attributes.c
+++ b/tools/testing/selftests/kvm/memory_attributes.c
@@ -198,7 +198,11 @@ static void test_page_restricted(struct kvm_vcpu *vcpu, int op,
 	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MEMORY_FAULT);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.gpa, fault_paddr);
 	if (fault_reason)
-		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags, fault_reason);
+		TEST_ASSERT_EQ(vcpu->run->memory_fault.flags &
+			       ~(KVM_MEMORY_EXIT_FLAG_GVA_VALID |
+				 KVM_MEMORY_EXIT_FLAG_PLANE_PROT |
+				 KVM_MEMORY_EXIT_FLAG_INSN_VALID),
+			       fault_reason);
 	TEST_ASSERT_EQ(vcpu->run->memory_fault.size, vm->page_size);
 }
 
-- 
2.50.1

