Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=CF6yekziqPiEZtbop2z8FDPmFZcfKsGe7S/xYslEDbq4pmBhJoxisFUKgbYxQaVlXajp
	 Qmvxs0q4bhBUVjeUTBg6aFOlNnQZiAnuuLr9WlLpNUncXAadib66KEfCN91pf5vvhrjtl
	 Zom5M4OjduVIJ2IkYceQOq7WvJS7kLpt9o18UVeXIxXnpWK9+rB6a2tRJVc1R5bmSRDmA
	 pm/k3/cB41UtFRYTawG1gyfaPyxMDwq3uSiqS31bpBrzbbwzPrLDfb1uq17PeMhWCsTRr
	 Zni4Rhp6JKzsk/RH9hiZ7S1UaP2N0QnFvX14FzKVngxlsy/lYHgUeMA3L/uNr5wM0iw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=Av973Nox7Fu8Eqm4T5WSaU/355N4hXed3Vjfzs/dbBs=;
	b=lS8O2Q06HDDloQCVagVsf4fApIGVwwIq2WwcReDQjCYcZ4pdgrN89pFvYfVZ0Fo63Rfb
	 LWJt/APaemYK20ZpJplhHQcFOz800K8G1g6azg34AcJ+pTN/k4cXa4sVecKzBMsXVfqPE
	 CqkZUjYyFpUc3FBpibf20jKw6xkRdGvwjHbr8LyKINtNbIZspql3jjkfzRF/C6y9fg7GZ
	 a87IGEFqVobKEkeAZe+RBtu1TlOx2HImAl+4Q/KQNPJh+KGAEUXhCBBThks7o0ZDLGjeQ
	 wN0GvqYf961ffaHZ1PG36ufxdjknKOiDOLJwnPFbKTirTwMauv4jdpsgvWd1PwTY0EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=AJs1KRlj;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDE2606A321;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EDE2606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=AJs1KRlj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Av973Nox7Fu8Eqm4T5WSaU/355N4hXed3Vjfzs/dbBs=; b=AJs1KRljtopTI5mC+0i1sOOp+w
	jLiXrp4yJnT0W9nzfrNV1z+VnD1XpGSl5CeZl8Q3kKZEa40r8HVrMXk2wENZhadn5ZeakTXM6N3Zt
	mY/juT5pXDlygy4B1u/12KijdTP0+TGWffAKjMgHIzMCv9eVJSAbgZxTLJj45663ahgM/T4aVlSmS
	xPfsgRi9KbczD/dQoq/FJ4B3LiDb/hkhWIU8hWtGyDZtoXg8Y7hVekwwnE1g/SUDe4yMBPSCKj9Vy
	zYZh9RNKHOujWJLoTfmLbCm0gWZ5pQqyKocw+YeG4PZRXy8E5n+hoLzpEa0kYcvvNtMfYgqJvcSss
	ki1Wl9vA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy3f-4BRU;
	Fri, 27 Nov 2026 15:27:31 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pqr-3NC3;
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
Subject: [PATCH v3 13/15] KVM: x86: Add descriptor-table registers to the write filter
Date: Fri, 27 Nov 2026 15:27:28 +0000
Message-ID: <20261127152730.99319-14-dwmw2@infradead.org>
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

Add GDTR, IDTR, LDTR and TR.  These have no per-bit semantics, so the
mask must be all ones and every LGDT, LIDT, LLDT or LTR exits.

VMX uses descriptor-table exiting, which UMIP emulation must now
share.  SVM uses the four load intercepts, which init_vmcb() has to
re-arm after a shutdown.

The exit gains old_limit and new_limit, for GDTR and IDTR.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 40 +++++++++++++++++-----
 arch/x86/include/asm/kvm_host.h |  2 +-
 arch/x86/include/uapi/asm/kvm.h |  4 +++
 arch/x86/kvm/emulate.c          | 28 +++++++++++++++
 arch/x86/kvm/kvm_emulate.h      | 10 ++++++
 arch/x86/kvm/regs.h             | 22 ++++++++++++
 arch/x86/kvm/svm/nested.c       | 16 +++++++++
 arch/x86/kvm/svm/svm.c          | 51 ++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/vmx.c          | 60 ++++++++++++++++++++++++++++-----
 arch/x86/kvm/x86.c              | 51 ++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h        |  2 ++
 11 files changed, 268 insertions(+), 18 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index a5192d1ca599..3ed1b07ad849 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6822,8 +6822,21 @@ The classes are:
   KVM_X86_REG_FILTER_CR0     CR0, written by MOV to CR0, CLTS and LMSW
   KVM_X86_REG_FILTER_CR4     CR4, written by MOV to CR4
   KVM_X86_REG_FILTER_XCR0    XCR0, written by XSETBV
+  KVM_X86_REG_FILTER_GDTR    GDTR, written by LGDT
+  KVM_X86_REG_FILTER_IDTR    IDTR, written by LIDT
+  KVM_X86_REG_FILTER_LDTR    LDTR, written by LLDT
+  KVM_X86_REG_FILTER_TR      TR, written by LTR
   ========================== ============================================
 
+For the descriptor-table registers, ``mask`` must be all ones, or zero
+to disarm: any load of the register triggers the filter, regardless of
+the old contents (reloading the same LDT selector re-reads the
+descriptor).  The exit reports the base and limit the guest tried to
+load for GDTR/IDTR, and the selector (in ``new_value``, before any
+descriptor validation) for LDTR/TR.  Userspace which performs an LLDT or
+LTR itself has to read the descriptor from the guest's GDT, load the
+hidden state from it and, for LTR, mark the TSS busy.
+
 Only writes executed by the guest are filtered.  Writes from userspace
 (KVM_SET_SREGS, KVM_SET_XCRS and similar), CR0/CR4 loads performed as
 part of VM entry and VM exit of a nested guest, and state loaded by RSM,
@@ -6851,6 +6864,12 @@ guest, a nested VM-exit loads CR0 and CR4 from the host-state fields of
 the VMCS, which the guest writes.  A VMM which arms a CR0 or CR4 filter
 against the guest's kernel has to accept those, or not expose VMX.
 
+The same goes for the descriptor-table registers, of which only the
+LGDT, LIDT, LLDT and LTR instructions are filtered: a hardware task
+switch loads TR and LDTR; with VMX exposed to the guest, a nested
+VM-exit loads GDTR, IDTR and TR from the host-state fields of the VMCS
+and makes LDTR unusable; and with SVM exposed, VMLOAD loads TR and LDTR.
+
 Filtering a CR0 or CR4 bit that KVM otherwise lets the guest own (for
 example CR0.TS) forces interception of writes to that register, with the
 attendant cost on write-heavy bits; the per-bit mask exists so that only
@@ -7872,18 +7891,23 @@ The supported 'ret' values and their respective SW_EXITINFO2 encodings:
 			__u32 reg;	/* KVM_X86_REG_FILTER_* */
 			__u64 old_value;
 			__u64 new_value;
+			__u32 old_limit;	/* GDTR/IDTR only */
+			__u32 new_limit;	/* GDTR/IDTR only */
 		} reg_write;
 
 Used on x86 systems.  The guest executed a write, to a register with a
 write filter armed by KVM_X86_SET_REG_WRITE_FILTER, that changes at
-least one of the filtered bits.  The write has not taken effect and the
-instruction has not retired: RIP still points at it.  ``reg`` identifies
-the register, ``old_value`` its current contents, ``new_value`` the
-value the guest tried to write and ``insn_len`` the length in bytes of
-the instruction, which is always valid and never zero.  The exit is
-taken before KVM validates the write: ``new_value`` may be one for which
-the instruction would have faulted.  ``pad`` is reserved and is zero.
-Userspace writes nothing to the structure but ``ret``.
+least one of the filtered bits (any load, for the descriptor-table
+registers).  The write has not taken effect and the instruction has not
+retired: RIP still points at it.  ``reg`` identifies the register,
+``old_value`` its current contents, ``new_value`` the value the guest
+tried to write and ``insn_len`` the length in bytes of the instruction,
+which is always valid and never zero.  For GDTR and IDTR the values are
+the base addresses and the ``*_limit`` fields carry the limits; for LDTR
+and TR they are the selectors.  The exit is taken before KVM validates
+the write: ``new_value`` may be one for which the instruction would have
+faulted.  ``pad`` is reserved and is zero.  Userspace writes nothing to
+the structure but ``ret``.
 
 The exit needs completion.  KVM does not perform the write, ever, and
 sets ``ret`` to zero, KVM_INSN_COMPLETE.  Re-entering the vCPU with
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 3e0365f5557a..c17a7022a575 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -221,7 +221,7 @@ enum x86_intercept_stage;
 #define KVM_NR_DB_REGS	4
 
 /* Register classes KVM_X86_SET_REG_WRITE_FILTER knows about */
-#define KVM_X86_NR_REG_WRITE_FILTERS	(KVM_X86_REG_FILTER_XCR0 + 1)
+#define KVM_X86_NR_REG_WRITE_FILTERS	(KVM_X86_REG_FILTER_TR + 1)
 
 #define PFERR_PRESENT_MASK	BIT(0)
 #define PFERR_WRITE_MASK	BIT(1)
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 5a16a2ce4399..623d66ff5562 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -234,6 +234,10 @@ struct kvm_msr_filter {
 #define KVM_X86_REG_FILTER_CR0		0
 #define KVM_X86_REG_FILTER_CR4		1
 #define KVM_X86_REG_FILTER_XCR0		2
+#define KVM_X86_REG_FILTER_GDTR		3
+#define KVM_X86_REG_FILTER_IDTR		4
+#define KVM_X86_REG_FILTER_LDTR		5
+#define KVM_X86_REG_FILTER_TR		6
 
 /* for KVM_X86_SET_REG_WRITE_FILTER */
 struct kvm_x86_reg_write_filter {
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 9a4aebcccc95..b40e347c498f 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3375,9 +3375,20 @@ static int em_sldt(struct x86_emulate_ctxt *ctxt)
 static int em_lldt(struct x86_emulate_ctxt *ctxt)
 {
 	u16 sel = ctxt->src.val;
+	int rc;
 
 	/* Disable writeback. */
 	ctxt->dst.type = OP_NONE;
+
+	/*
+	 * The filter check must precede any architectural effect, and sits
+	 * here rather than in ->set_segment() so that a task switch, which
+	 * loads LDTR through set_segment as well, is not diverted.
+	 */
+	rc = ctxt->ops->filter_dt_write(ctxt, KVM_X86_REG_FILTER_LDTR, sel, 0);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
+
 	return load_segment_descriptor(ctxt, sel, VCPU_SREG_LDTR);
 }
 
@@ -3389,9 +3400,21 @@ static int em_str(struct x86_emulate_ctxt *ctxt)
 static int em_ltr(struct x86_emulate_ctxt *ctxt)
 {
 	u16 sel = ctxt->src.val;
+	int rc;
 
 	/* Disable writeback. */
 	ctxt->dst.type = OP_NONE;
+
+	/*
+	 * The filter check must precede load_segment_descriptor(): that
+	 * path marks the TSS descriptor busy in the GDT, and the exit must
+	 * leave nothing behind.  Userspace performs the load itself, or
+	 * leaves it uncompleted and the LTR runs again.
+	 */
+	rc = ctxt->ops->filter_dt_write(ctxt, KVM_X86_REG_FILTER_TR, sel, 0);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
+
 	return load_segment_descriptor(ctxt, sel, VCPU_SREG_TR);
 }
 
@@ -3489,6 +3512,11 @@ static int em_lgdt_lidt(struct x86_emulate_ctxt *ctxt, bool lgdt)
 	    emul_is_noncanonical_address(desc_ptr.address, ctxt,
 					 X86EMUL_F_DT_LOAD))
 		return emulate_gp(ctxt, 0);
+	rc = ctxt->ops->filter_dt_write(ctxt, lgdt ? KVM_X86_REG_FILTER_GDTR :
+						     KVM_X86_REG_FILTER_IDTR,
+					desc_ptr.address, desc_ptr.size);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
 	if (lgdt)
 		ctxt->ops->set_gdt(ctxt, &desc_ptr);
 	else
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 311ff6a01079..981ba90926b9 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -224,6 +224,16 @@ struct x86_emulate_ops {
 	 */
 	int (*filter_cr_write)(struct x86_emulate_ctxt *ctxt, int cr,
 			       ulong val);
+	/*
+	 * Likewise for a descriptor-table load: @reg is the
+	 * KVM_X86_REG_FILTER_* class, @value the base (GDTR/IDTR) or
+	 * selector (LDTR/TR), @limit the limit (GDTR/IDTR only).  Only the
+	 * LGDT/LIDT/LLDT/LTR instructions are checked; loads on other
+	 * instructions' behalf (task switches, RSM) are not register
+	 * writes by the guest and stay unfiltered.
+	 */
+	int (*filter_dt_write)(struct x86_emulate_ctxt *ctxt, u32 reg,
+			       u64 value, u32 limit);
 	int (*cpl)(struct x86_emulate_ctxt *ctxt);
 	ulong (*get_effective_dr7)(struct x86_emulate_ctxt *ctxt);
 	ulong (*get_dr)(struct x86_emulate_ctxt *ctxt, int dr);
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 9fbd6c37bf68..c4509175810b 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -65,6 +65,11 @@ unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
+#define KVM_REG_WRITE_FILTER_DT_MASK	(BIT(KVM_X86_REG_FILTER_GDTR) | \
+					 BIT(KVM_X86_REG_FILTER_IDTR) | \
+					 BIT(KVM_X86_REG_FILTER_LDTR) | \
+					 BIT(KVM_X86_REG_FILTER_TR))
+
 int kvm_vcpu_ioctl_set_reg_write_filter(struct kvm_vcpu *vcpu,
 					struct kvm_x86_reg_write_filter *filter);
 bool __kvm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg, u64 changed_bits);
@@ -86,6 +91,23 @@ static inline bool kvm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg,
 	return __kvm_reg_write_filtered(vcpu, reg, old_value ^ new_value);
 }
 
+/*
+ * The descriptor-table variant: any LGDT, LIDT, LLDT or LTR triggers an
+ * armed filter, regardless of the old contents.
+ */
+static inline bool kvm_dt_write_filtered(struct kvm_vcpu *vcpu, u32 reg)
+{
+	if (likely(!(vcpu->arch.reg_write_filter_armed & BIT(reg))))
+		return false;
+
+	return __kvm_reg_write_filtered(vcpu, reg, ~0ULL);
+}
+
+static inline bool kvm_reg_write_filter_dt_armed(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.reg_write_filter_armed & KVM_REG_WRITE_FILTER_DT_MASK;
+}
+
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 07554089ec05..618728034472 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -172,6 +172,22 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
 	for (i = 0; i < MAX_INTERCEPT; i++)
 		vmcb02->control.intercepts[i] |= vmcb12_ctrl->intercepts[i];
 
+	/*
+	 * KVM arms the descriptor-table load intercepts in vmcb01 for the
+	 * register write filters (KVM_X86_SET_REG_WRITE_FILTER), which
+	 * cover only L1.  Drop them from vmcb02 unless L1 wants the
+	 * intercept itself, matching the SECONDARY_EXEC_DESC strip in
+	 * VMX's prepare_vmcs02().
+	 */
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_GDTR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_GDTR);
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_IDTR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_IDTR);
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_LDTR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_LDTR);
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_TR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_TR);
+
 	/* If SMI is not intercepted, ignore guest SMI intercept as well  */
 	if (!intercept_smi)
 		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_SMI);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index c91467a59e20..47913ba03d3e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1135,6 +1135,30 @@ static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
 	svm_recalc_msr_intercepts(vcpu);
 }
 
+/*
+ * The descriptor-table load intercepts are armed in vmcb01 as a block,
+ * matching VMX's all-or-nothing SECONDARY_EXEC_DESC; an exit the emulator
+ * does not divert applies the load normally.
+ * nested_vmcb02_recalc_intercepts() keeps them out of vmcb02 unless L1
+ * asked for them itself.
+ */
+static void svm_recalc_dt_load_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (kvm_reg_write_filter_dt_armed(vcpu)) {
+		svm_set_intercept(svm, INTERCEPT_LOAD_GDTR);
+		svm_set_intercept(svm, INTERCEPT_LOAD_IDTR);
+		svm_set_intercept(svm, INTERCEPT_LOAD_LDTR);
+		svm_set_intercept(svm, INTERCEPT_LOAD_TR);
+	} else {
+		svm_clr_intercept(svm, INTERCEPT_LOAD_GDTR);
+		svm_clr_intercept(svm, INTERCEPT_LOAD_IDTR);
+		svm_clr_intercept(svm, INTERCEPT_LOAD_LDTR);
+		svm_clr_intercept(svm, INTERCEPT_LOAD_TR);
+	}
+}
+
 static void svm_update_reg_write_filter(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1149,6 +1173,8 @@ static void svm_update_reg_write_filter(struct kvm_vcpu *vcpu)
 	 */
 	if (vcpu->arch.reg_write_filter_armed & BIT(KVM_X86_REG_FILTER_CR0))
 		svm_set_intercept(svm, INTERCEPT_CR0_WRITE);
+
+	svm_recalc_dt_load_intercepts(vcpu);
 }
 
 static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
@@ -1317,6 +1343,13 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 
 	svm_hv_init_vmcb(vmcb);
 
+	/*
+	 * A reset does not touch the register write filters, but a SHUTDOWN
+	 * clears the VMCB: re-arm the intercepts which the filters need.
+	 * The reset's svm_set_cr0() takes care of INTERCEPT_CR0_WRITE.
+	 */
+	svm_recalc_dt_load_intercepts(vcpu);
+
 	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
@@ -2099,6 +2132,17 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 	return rc;
 }
 
+static int desc_interception(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Descriptor-table load exits are armed only while a write filter
+	 * covers one of the descriptor-table registers; the emulator
+	 * diverts a filtered load into a KVM_EXIT_X86_REG_WRITE exit and
+	 * applies an unfiltered one normally.
+	 */
+	return kvm_emulate_instruction(vcpu, 0);
+}
+
 static int db_interception(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
@@ -3523,6 +3567,10 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_WRITE_CR3]			= cr_interception,
 	[SVM_EXIT_WRITE_CR4]			= cr_interception,
 	[SVM_EXIT_WRITE_CR8]			= cr8_write_interception,
+	[SVM_EXIT_GDTR_WRITE]			= desc_interception,
+	[SVM_EXIT_IDTR_WRITE]			= desc_interception,
+	[SVM_EXIT_LDTR_WRITE]			= desc_interception,
+	[SVM_EXIT_TR_WRITE]			= desc_interception,
 	[SVM_EXIT_READ_DR0]			= dr_interception,
 	[SVM_EXIT_READ_DR1]			= dr_interception,
 	[SVM_EXIT_READ_DR2]			= dr_interception,
@@ -5786,6 +5834,9 @@ static __init void svm_set_cpu_caps(void)
 	kvm_caps.supported_reg_write_filter |= BIT(KVM_X86_REG_FILTER_CR0) |
 					       BIT(KVM_X86_REG_FILTER_CR4);
 
+	/* As can the four descriptor-table load intercepts. */
+	kvm_caps.supported_reg_write_filter |= KVM_REG_WRITE_FILTER_DT_MASK;
+
 	/* CPUID 0x80000008 */
 	if (boot_cpu_has(X86_FEATURE_LS_CFG_SSBD) ||
 	    boot_cpu_has(X86_FEATURE_AMD_SSBD))
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index d785bcf52a3f..9f322c672466 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3611,13 +3611,25 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		hw_cr4 |= KVM_PMODE_VM_CR4_ALWAYS_ON;
 
 	if (vmx_umip_emulated()) {
+		bool clear = false;
+
 		if (cr4 & X86_CR4_UMIP) {
 			secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_DESC);
 			hw_cr4 &= ~X86_CR4_UMIP;
-		} else if (!is_guest_mode(vcpu) ||
-			!nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_DESC)) {
-			secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_DESC);
+		} else if (is_guest_mode(vcpu)) {
+			clear = !nested_cpu_has2(get_vmcs12(vcpu),
+						 SECONDARY_EXEC_DESC);
+		} else {
+			/*
+			 * Clearing CR4.UMIP must not disarm the control
+			 * while a descriptor-table write filter relies
+			 * on it.
+			 */
+			clear = !kvm_reg_write_filter_dt_armed(vcpu);
 		}
+
+		if (clear)
+			secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_DESC);
 	}
 
 	vcpu->arch.cr4 = cr4;
@@ -4579,19 +4591,38 @@ void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
 }
 
 /*
- * Refresh the interception that the register write filter needs: a
- * filtered CR0/CR4 bit must be host-owned in the vmcs01 guest/host masks
- * so that the guest's writes to it actually exit.  For vmcs01, which must
- * be loaded.
+ * SECONDARY_EXEC_DESC has two consumers: UMIP emulation (descriptor-table
+ * reads must #GP when CR4.UMIP is set and the CPU cannot do it) and the
+ * descriptor-table write filters.  Every arm or disarm of the control for
+ * one consumer must preserve the other's claim.
+ */
+static bool vmx_need_desc_exiting(struct kvm_vcpu *vcpu)
+{
+	return (vmx_umip_emulated() &&
+		kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP)) ||
+	       kvm_reg_write_filter_dt_armed(vcpu);
+}
+
+/*
+ * Refresh the interception that the register write filters need: a
+ * filtered CR0/CR4 bit must be host-owned in the vmcs01 guest/host masks,
+ * and a descriptor-table filter needs SECONDARY_EXEC_DESC, so that the
+ * guest's writes actually exit.  For vmcs01, which must be loaded.
  *
  * This is all a nested VM-exit needs, for a filter which changed while
  * vmcs02 was loaded: it loads L1's CR0 and CR4 afresh.
  */
 void vmx_refresh_reg_write_filter(struct kvm_vcpu *vcpu)
 {
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
 	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits(vcpu);
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
-	set_cr4_guest_host_mask(to_vmx(vcpu));
+	set_cr4_guest_host_mask(vmx);
+
+	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_DESC)
+		secondary_exec_controls_changebit(vmx, SECONDARY_EXEC_DESC,
+						  vmx_need_desc_exiting(vcpu));
 }
 
 /*
@@ -5733,7 +5764,13 @@ static int handle_desc(struct kvm_vcpu *vcpu)
 	 */
 	BUILD_BUG_ON(KVM_POSSIBLE_CR4_GUEST_BITS & X86_CR4_UMIP);
 
-	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP));
+	/*
+	 * Descriptor-table exits are also armed by the write filters; only
+	 * an exit with neither UMIP emulation nor a filter armed indicates
+	 * a stale SECONDARY_EXEC_DESC control.
+	 */
+	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP) &&
+		     !kvm_reg_write_filter_dt_armed(vcpu));
 	return kvm_emulate_instruction(vcpu, 0);
 }
 
@@ -8749,6 +8786,11 @@ __init int vmx_hardware_setup(void)
 	kvm_caps.supported_reg_write_filter |= BIT(KVM_X86_REG_FILTER_CR0) |
 					       BIT(KVM_X86_REG_FILTER_CR4);
 
+	/* Descriptor-table filters need descriptor-table exiting. */
+	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_DESC)
+		kvm_caps.supported_reg_write_filter |=
+			KVM_REG_WRITE_FILTER_DT_MASK;
+
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	if (enable_ept)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7fe4b559ed73..e32edbd9777e 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -895,6 +895,20 @@ int kvm_vcpu_ioctl_set_reg_write_filter(struct kvm_vcpu *vcpu,
 	case KVM_X86_REG_FILTER_XCR0:
 		allowed = kvm_caps.supported_xcr0 | XFEATURE_MASK_FP;
 		break;
+	case KVM_X86_REG_FILTER_GDTR:
+	case KVM_X86_REG_FILTER_IDTR:
+	case KVM_X86_REG_FILTER_LDTR:
+	case KVM_X86_REG_FILTER_TR:
+		/*
+		 * A descriptor-table load triggers regardless of the old
+		 * contents (reloading the same LDT selector re-reads the
+		 * descriptor), so the only meaningful masks are all ones
+		 * and, to disarm, zero.
+		 */
+		if (filter->mask && filter->mask != ~0ULL)
+			return -EINVAL;
+		allowed = ~0ULL;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -5885,6 +5899,42 @@ static int emulator_filter_cr_write(struct x86_emulate_ctxt *ctxt, int cr,
 	return emulator_reg_write_exit(ctxt, reg, old_value, new_value);
 }
 
+static int emulator_filter_dt_write(struct x86_emulate_ctxt *ctxt, u32 reg,
+				    u64 value, u32 limit)
+{
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	struct kvm_segment seg;
+	struct desc_ptr dt;
+	u32 old_limit = 0;
+	u64 old_value;
+
+	if (!kvm_dt_write_filtered(vcpu, reg))
+		return X86EMUL_CONTINUE;
+
+	switch (reg) {
+	case KVM_X86_REG_FILTER_GDTR:
+		kvm_x86_call(get_gdt)(vcpu, &dt);
+		old_value = dt.address;
+		old_limit = dt.size;
+		break;
+	case KVM_X86_REG_FILTER_IDTR:
+		kvm_x86_call(get_idt)(vcpu, &dt);
+		old_value = dt.address;
+		old_limit = dt.size;
+		break;
+	default:
+		kvm_get_segment(vcpu, &seg, reg == KVM_X86_REG_FILTER_LDTR ?
+					    VCPU_SREG_LDTR : VCPU_SREG_TR);
+		old_value = seg.selector;
+		break;
+	}
+
+	emulator_reg_write_exit(ctxt, reg, old_value, value);
+	vcpu->run->reg_write.old_limit = old_limit;
+	vcpu->run->reg_write.new_limit = limit;
+	return X86EMUL_IO_NEEDED;
+}
+
 static int emulator_get_cpl(struct x86_emulate_ctxt *ctxt)
 {
 	return kvm_x86_call(get_cpl)(emul_to_vcpu(ctxt));
@@ -6158,6 +6208,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.get_cr              = emulator_get_cr,
 	.set_cr              = emulator_set_cr,
 	.filter_cr_write     = emulator_filter_cr_write,
+	.filter_dt_write     = emulator_filter_dt_write,
 	.cpl                 = emulator_get_cpl,
 	.get_effective_dr7   = emulator_get_effective_dr7,
 	.get_dr              = emulator_get_dr,
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 165fa36c2479..566b98bb5823 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -521,6 +521,8 @@ struct kvm_run {
 			__u32 reg;	/* KVM_X86_REG_FILTER_* */
 			__u64 old_value;
 			__u64 new_value;
+			__u32 old_limit;	/* GDTR/IDTR only */
+			__u32 new_limit;	/* GDTR/IDTR only */
 		} reg_write;
 		/* Fix the size of the union. */
 		char padding[256];
-- 
2.50.1

