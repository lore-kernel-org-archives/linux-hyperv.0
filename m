Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594896;
	b=GFlHzOgnAEcP0qTyarjhHqlTQlfNc+T4H8/8HMc1YXOoQXR99xST7nEPTFmXfDamEGww
	 xHDoVgbjP7A4sr57+a88DKNY2HdgCBx6fCLi0uP0w0RH8pfCfnagX/agQP+itJdBxEzrf
	 KGenzlj2ZodsJy7noGXKRMXHj+BLWqJWcozmDe/GgyRkFYk4qIRBTFxKNANau/FDdedwH
	 PxDYlVe140L6YKWBY97eDosS4OgeOd4nAK77WcZkWIatvu6EdnKyc4J48qJBTlZDrGvQG
	 CUVktod9NrKgxuv68j4smz61lyPi3x68EvKAY/BPEAOcUmr+DwBYD4wolWlUdr+GziQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=sJxAT23in9mL622FFzvf/edwzVLEjYZRuEHg3HmkG0g=;
	b=KZIZXESKD7sW71rww6JdVByOjo0QpfJTouEHOPLNaB/X9CoVECKvnZababcfM/+egofa
	 vJXWH6gtC7G7QXB2kUZEujggwf6qUxQozfz+VoK/xhFbyCRgtM3/s6Z537PYebSmyQBP1
	 R2TP8fgWvi0ZgFXjACsijfLcJCKPOAyoinhYF7obp3GN4S0PNY58RRb6axM9qZrABYtpc
	 UsAfqOP97C9uytmCLETE+0tcf2xJj4Pe1VzqcDSizItA5zZrm8QqYPkuLHiTn6eKVS76s
	 zwwHd7PID/BaA2VoaArY57KXjq1hj+lU1bqb6EcSzicBZCNJaKCBOXIc+0VQM1xYlVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=J5WbgRz+;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEF460A5BC1;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFEF460A5BC1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=J5WbgRz+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=sJxAT23in9mL622FFzvf/edwzVLEjYZRuEHg3HmkG0g=; b=J5WbgRz+Akkyw6TCSbxJDxImCX
	njRIHGMevok37F42abhTICV1bZc9By8NpAadq2+cUPoZ5Cv4hcykv6CEeDDmdaVhJGsT5qIKsPZbZ
	C1FlTE4SoKRD2azwmJasm86YCy8u6YuSTjNiA9WRxbMK2X2WuZ3P+FPEHIjCBaJoPSFGYn9HQQ2lP
	gU7JJSRbWfz0l5MrV3e5QZYIosASvEbQunRoM1DOwL51H8irAy4Cy4UHxzPPw9AN5X1ZgJ+3wEPHu
	SN/MhsjSgdPouc+FXoB4JSrkE7xPlg2LNsk3MoKnmkfSuLYyCxHVzUQRm8HUapV/QiwOvawb1EQ2X
	tOnWSnrw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6v-0000000Bf08-0UJv;
	Fri, 13 Nov 2026 18:34:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000LuM-1uJp;
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
Subject: [RFC PATCH v2 27/31] KVM: SVM: Carry instruction state on reflected plane-protection faults
Date: Fri, 13 Nov 2026 18:34:43 +0000
Message-ID: <20261113183448.84094-28-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

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

Decode Assists store up to 15 bytes fetched from CS:RIP in the VMCB on a
data-access #NPF (the raw window, not the decoded length); run them
through the instruction decoder and report the decoded length and that
many bytes. When the window is empty (no Decode Assists, a fault while
fetching CS:RIP, or erratum 1096), decode from guest memory at RIP
instead, except for SEV guests whose memory KVM cannot read. The
decoder's own fetches can be refused by the plane's protections (a
protected code or page-table page is the normal VSM layout) and then
prepare a memory-fault exit of their own, so the exit being reported is
saved around the decode, as around the VMX read. Set RFLAGS.RF before
exiting: fault delivery gives the restarted
instruction RF=1, and VMX saves that fault-adjusted value in guest
RFLAGS on fault-type exits while SVM saves RF as it was during
execution.

An instruction-fetch #NPF stores no bytes (APM vol 2, "Nested and
Intercepted #PF"). The length an execute intercept carries is that of
the branch that fetched the faulting page, which VMX reports and SVM
does not record; decoding at RIP would describe the branch target
instead. Execute intercepts therefore carry length 0 on SVM.

SEV-ES and SEV-SNP guests get the bare fault: KVM cannot see the CS and
mode state the decoder would use, and RFLAGS lives in the encrypted
VMSA, where a VMCB write does nothing.

Both harvests act on KVM_MEMORY_EXIT_FLAG_PLANE_PROT, which marks a
memory-fault exit caused by the plane's memory attributes. It is set
where the attribute check refuses the access, by
kvm_mark_plane_prot_fault(): in the fault-in path, in the guest
page-table walker, in kvm_prepare_memory_fault_exit_for_range() (the
emulator's data accesses) and on the emulator's instruction fetch. So an
emulated access carries it as well as a guest #NPF. Inferring it from
the shape of a walker exit instead would also tag
nested_svm_get_tdp_pdptr()'s exit for an nCR3 outside guest memory, and
set RF on a fault that is not a plane intercept at all. Exits KVM cannot
attribute (an unmapped GPA, the hypercall buffer and kvmclock checks)
leave it clear.

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
and compares only the access that faulted. api.rst documents both
flags.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst                | 25 ++++-
 arch/x86/kvm/mmu/mmu.c                        |  1 +
 arch/x86/kvm/mmu/paging_tmpl.h                |  1 +
 arch/x86/kvm/svm/svm.c                        | 99 +++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c                        | 13 ++-
 arch/x86/kvm/x86.c                            |  1 +
 include/linux/kvm_host.h                      | 26 +++++
 include/uapi/linux/kvm.h                      | 17 +++-
 .../testing/selftests/kvm/memory_attributes.c |  6 +-
 virt/kvm/kvm_main.c                           |  2 +
 10 files changed, 180 insertions(+), 11 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1c30bb2806d3..21a057bd43be 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7756,6 +7756,8 @@ spec refer, https://github.com/riscv/riscv-sbi-doc.
   #define KVM_MEMORY_EXIT_FLAG_EXEC     (1ULL << 2)
   #define KVM_MEMORY_EXIT_FLAG_PRIVATE	(1ULL << 3)
   #define KVM_MEMORY_EXIT_FLAG_GVA_VALID	(1ULL << 4)
+  #define KVM_MEMORY_EXIT_FLAG_PLANE_PROT	(1ULL << 5)
+  #define KVM_MEMORY_EXIT_FLAG_INSN_VALID	(1ULL << 6)
 			__u64 flags;
 			__u64 gpa;
 			__u64 size;
@@ -7778,12 +7780,24 @@ describes properties of the faulting access that are likely pertinent:
    shared access.
  - KVM_MEMORY_EXIT_FLAG_GVA_VALID - When set, 'gva' holds the faulting guest
    virtual address.
+ - KVM_MEMORY_EXIT_FLAG_PLANE_PROT - When set, the access was refused by the
+   memory attributes of the vCPU's plane.  Reported on VMs with more than one
+   plane, for guest accesses, for KVM's walks of the guest page tables and
+   for accesses KVM makes while emulating an instruction.  Other memory-fault
+   exits, such as one for a GPA that no memslot maps, leave it clear.
+ - KVM_MEMORY_EXIT_FLAG_INSN_VALID - When set, 'insn_len' and 'insn_bytes'
+   describe the faulting instruction: 'insn_bytes' holds its first
+   'insn_len' bytes.  For an EXEC fault the faulting instruction cannot be
+   read; 'insn_bytes' stays zero and 'insn_len' is the length of the
+   instruction that performed the fetch, which only VMX reports.
 
 The 'gva', 'insn_len' and 'insn_bytes' fields exist only on kernels
 which advertise KVM_CAP_PLANE_MEMORY_OVERLAYS (see section 8.48).  On
-plane memory-protection faults, 'insn_len' and 'insn_bytes' carry a
-best-effort copy of the faulting instruction when KVM could fetch it;
-an 'insn_len' of 0 means no instruction bytes are available.
+x86, KVM fills them in on plane memory-protection faults taken by the
+guest when it can, and KVM_MEMORY_EXIT_FLAG_GVA_VALID and
+KVM_MEMORY_EXIT_FLAG_INSN_VALID say which of them are valid.  SEV-ES and
+SEV-SNP guests get neither.  Every other memory-fault exit leaves the
+fields zero.
 
 Note!  KVM_EXIT_MEMORY_FAULT is unique among all KVM exit reasons in that it
 accompanies a return code of '-1', not '0'!  errno will always be set to EFAULT
@@ -10175,7 +10189,10 @@ announces two things:
 
  - The extended KVM_EXIT_MEMORY_FAULT layout: 'memory_fault' carries
    the additional 'gva', 'insn_len' and 'insn_bytes' fields, with
-   KVM_MEMORY_EXIT_FLAG_GVA_VALID qualifying 'gva' (see section 5).
+   KVM_MEMORY_EXIT_FLAG_GVA_VALID qualifying 'gva' and
+   KVM_MEMORY_EXIT_FLAG_INSN_VALID qualifying 'insn_len' and
+   'insn_bytes', and the KVM_MEMORY_EXIT_FLAG_PLANE_PROT flag (see
+   section 5).
 
 9. Known KVM API problems
 =========================
diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 8061790e7357..91aadea42af4 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -4885,6 +4885,7 @@ static int kvm_mmu_faultin_pfn(struct kvm_vcpu *vcpu,
 
 	if (kvm_faultin_memory_protections(vcpu, fault)) {
 		kvm_mmu_prepare_memory_fault_exit(vcpu, fault);
+		kvm_mark_plane_prot_fault(vcpu);
 		return -EFAULT;
 	}
 
diff --git a/arch/x86/kvm/mmu/paging_tmpl.h b/arch/x86/kvm/mmu/paging_tmpl.h
index 377cd3e7c7d6..7bd0b0dba268 100644
--- a/arch/x86/kvm/mmu/paging_tmpl.h
+++ b/arch/x86/kvm/mmu/paging_tmpl.h
@@ -430,6 +430,7 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
 			walker->error = -EFAULT;
 			kvm_prepare_memory_fault_exit(vcpu, real_gpa & PAGE_MASK,
 						      PAGE_SIZE, false, false, false);
+			kvm_mark_plane_prot_fault(vcpu);
 			goto error;
 		}
 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index b87c12944108..cf049367523c 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2148,6 +2148,105 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 				svm->vmcb->control.insn_bytes : NULL,
 				svm->vmcb->control.insn_len);
 
+	/*
+	 * A plane-protection fault reflected to userspace becomes a TLFS
+	 * GPA intercept message carrying the faulting instruction's length
+	 * and bytes; see the equivalent harvest in handle_ept_violation().
+	 *
+	 * For a data access, Decode Assists store up to 15 bytes fetched
+	 * from CS:RIP (the raw window, not the decoded length) in the VMCB;
+	 * run them through the decoder to report the real length.  The
+	 * window can be empty: no Decode Assists, a fault while fetching
+	 * CS:RIP, or erratum 1096 (see svm_check_emulate_instruction()).
+	 * Then decode from guest memory at RIP instead, which KVM can only
+	 * do when it can read the guest's memory and registers.
+	 *
+	 * An instruction-fetch #NPF stores no bytes (APM vol 2, "Nested and
+	 * Intercepted #PF"), and the length an execute intercept carries is
+	 * that of the branch that fetched the faulting page, which VMX
+	 * hardware reports and SVM does not record.  Decoding at RIP would
+	 * describe the branch target instead, so an execute intercept
+	 * reports length 0.
+	 *
+	 * None of it applies to SEV-ES and SEV-SNP guests: KVM cannot see
+	 * the CS and mode state the decoder needs, and RFLAGS lives in the
+	 * encrypted VMSA, so they get the bare fault.
+	 */
+	if (rc == -EFAULT &&
+	    vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT &&
+	    (vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PLANE_PROT) &&
+	    !vcpu->arch.guest_state_protected) {
+		bool window = cpu_feature_enabled(X86_FEATURE_DECODEASSISTS) &&
+			      svm->vmcb->control.insn_len;
+		void *insn = window ? svm->vmcb->control.insn_bytes : NULL;
+		int insn_len = window ? svm->vmcb->control.insn_len : 0;
+		unsigned int len = 0;
+
+		if (!(error_code & PFERR_FETCH_MASK) &&
+		    (window || !is_sev_guest(vcpu))) {
+			typeof(vcpu->run->memory_fault) fault =
+				vcpu->run->memory_fault;
+			u32 exit_reason = vcpu->run->exit_reason;
+			int r;
+
+			/*
+			 * Fetching bytes beyond the window can hit the plane's
+			 * protections too (a protected code or page-table page
+			 * is the normal VSM layout), and the refused fetch
+			 * prepares a memory-fault exit of its own.  Report the
+			 * fault that was taken.
+			 */
+			r = x86_decode_emulated_instruction(vcpu, 0, insn,
+							    insn_len);
+			vcpu->run->exit_reason = exit_reason;
+			vcpu->run->memory_fault = fault;
+
+			if (r == EMULATION_OK) {
+				struct x86_emulate_ctxt *ctxt =
+					vcpu->arch.emulate_ctxt;
+
+				len = min_t(unsigned int, ctxt->_eip - ctxt->eip,
+					    sizeof(vcpu->run->memory_fault.insn_bytes));
+			}
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
index b5aa7110bf36..e5c22eafd5e0 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6088,9 +6088,7 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 	 */
 	if (ret == -EFAULT &&
 	    vcpu->run->exit_reason == KVM_EXIT_MEMORY_FAULT &&
-	    (vcpu->run->memory_fault.flags & (KVM_MEMORY_EXIT_FLAG_READ |
-					      KVM_MEMORY_EXIT_FLAG_WRITE |
-					      KVM_MEMORY_EXIT_FLAG_EXEC))) {
+	    (vcpu->run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_PLANE_PROT)) {
 		unsigned int len;
 
 		if (exit_qualification & EPT_VIOLATION_GVA_IS_VALID) {
@@ -6108,7 +6106,6 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 		len = vmcs_read32(VM_EXIT_INSTRUCTION_LEN);
 		len = min_t(unsigned int, len,
 			    sizeof(vcpu->run->memory_fault.insn_bytes));
-		vcpu->run->memory_fault.insn_len = len;
 		if (!(exit_qualification & EPT_VIOLATION_ACC_INSTR)) {
 			typeof(vcpu->run->memory_fault) fault =
 				vcpu->run->memory_fault;
@@ -6132,10 +6129,16 @@ static int handle_ept_violation(struct kvm_vcpu *vcpu)
 			 */
 			vcpu->run->exit_reason = exit_reason;
 			vcpu->run->memory_fault = fault;
-			if (r)
+			if (r) {
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
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 0d6c8adecb01..27317077f519 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5198,6 +5198,7 @@ static int kvm_fetch_guest_virt(struct x86_emulate_ctxt *ctxt,
 		if (!kvm_mem_attributes_may_exec(attrs)) {
 			kvm_prepare_memory_fault_exit(vcpu, gpa & PAGE_MASK, PAGE_SIZE,
 						      false, true, false);
+			kvm_mark_plane_prot_fault(vcpu);
 			return X86EMUL_MEMORY_FAULT;
 		}
 		return X86EMUL_IO_NEEDED;
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 5399d0065c97..ef95158ddd53 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -2824,6 +2824,18 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
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
@@ -2837,6 +2849,20 @@ static inline void kvm_prepare_memory_fault_exit(struct kvm_vcpu *vcpu,
 		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PRIVATE;
 }
 
+/*
+ * Mark a just-prepared memory-fault exit as caused by the vCPU's plane's
+ * memory attributes.  Every site that refuses an access on an attribute
+ * check calls this; other memory-fault exits (an unmapped GPA, a nested
+ * CR3 outside guest memory) leave KVM_MEMORY_EXIT_FLAG_PLANE_PROT clear.
+ * It is reported on VMs with more than one plane, which is what the flag
+ * was defined for.
+ */
+static inline void kvm_mark_plane_prot_fault(struct kvm_vcpu *vcpu)
+{
+	if (kvm_arch_max_planes(vcpu->kvm) > 1)
+		vcpu->run->memory_fault.flags |= KVM_MEMORY_EXIT_FLAG_PLANE_PROT;
+}
+
 static inline bool kvm_memslot_is_gmem_only(const struct kvm_memory_slot *slot)
 {
 	if (!IS_ENABLED(CONFIG_KVM_GUEST_MEMFD))
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 18845d9e02f2..0278fa03e532 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -490,10 +490,25 @@ struct kvm_run {
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
index 2883f6c772be..25e49ddd2623 100644
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
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 3eeb36b3f785..07882de23f3a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2726,12 +2726,14 @@ bool kvm_prepare_memory_fault_exit_for_range(struct kvm_vcpu *vcpu, gpa_t gpa,
 		if (!kvm_vcpu_mem_attributes_may_read_gfn(vcpu, gfn)) {
 			kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
 						      write, false, false);
+			kvm_mark_plane_prot_fault(vcpu);
 			return true;
 		}
 
 		if (write && !kvm_vcpu_mem_attributes_may_write_gfn(vcpu, gfn)) {
 			kvm_prepare_memory_fault_exit(vcpu, gfn_to_gpa(gfn), PAGE_SIZE,
 						      true, false, false);
+			kvm_mark_plane_prot_fault(vcpu);
 			return true;
 		}
 	}
-- 
2.50.1

