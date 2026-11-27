Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=XqCe/IX7dK+3iKdCkr8QnHaTV8JsnFFtfc1HSIunAmieq0YzxuTQpqZ1yjiWA/PAZmRP
	 UknxarHrf3y4aPCm1HfVZnnUxU23ewkdXIVLH0T4Z5prApnyG44QZvM9/f1zdsdu713bP
	 SVmWntqLbiiEEYEtvBMhRkV4+qGeD/8qaHCk2zw8nAZoK7EHuttaqW8INZbJvilrm2iTs
	 vlprttzJBzhwY3F4G+Ll82pgAaGYcpRiAPCTgOmEIPWrgPbJmYjdJOX8heFzgrYfkqIho
	 3pHyUT2Q38C2P7paLHkNt/knOU3bTOGQs05xxE8pPMq4ZgdHVBqstOtIA+sfSxXEddQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ADSn3FnFgqtAOWcYXUxDlH2KFQoMtSP5mz2/h2aTrzw=;
	b=c7kh+3lJMJPPwrNRENbovVFcJiD6KsVeKdRfgKt6jV5NWg8JfR8TcDSHo2KToCpmUsQz
	 r3m8ypUc45aUXfYXNMP8G09TnpN8ULa9FuSIFXdj9SyG03aIvkfIiNZwiy67RV3OkjP6Y
	 Yf29YKrJ8i2z8Ho+m1EsgVAQ4SrrvGIchFrm3UuW79/T/FguFkP7QbPqaClw0DKy9XmX6
	 zM9XMWUwlOBfLg0g8WpEtX44HXy/mSqWrMEaSnUqgQ4SpWou00OXNQiZW9vjjVj2yXS0n
	 kNVRJlzYs/3Qps1KaIxDyU83lCt55wP8uZU5uN0Yrpxfu090Hp0rbEmmJO6+NlCR0/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Fjyfl2uJ;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDFC60A261B;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDDFC60A261B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Fjyfl2uJ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ADSn3FnFgqtAOWcYXUxDlH2KFQoMtSP5mz2/h2aTrzw=; b=Fjyfl2uJWuV2HADLUGU4INIiDM
	nqttURXalqQ5zCpUgdBiiC0oZiV8fGNoDHwtiY6JeRbkIU5cebIhidHyMIrJmAkb/kX629GXPn7r4
	nAo7Ru9ZtGOqMIhCtS8ttSMUzZyjoAEidvLX9NDkSTXBYU46kBj6+abES0+c1tAhKOXNlrDdo1LsQ
	bGMgGjjbwh11mzYBbtvxg16rl6Zrw7Kj6kvB+vUh8KnjqnmeFVEDRFVuHJjKwID8Qms9LwsFgKvZo
	IDCKXEJGKo7poil53gMLJ5pwuttOUV6nHlFEDXmw5jOcMYSJs98FGonsgBwHGBw2rS6vlccsboFrz
	+70W51qA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tko-2F4E;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pqa-2e6V;
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
Subject: [PATCH v3 09/15] KVM: x86: Add a per-vCPU register write filter
Date: Fri, 27 Nov 2026 15:27:24 +0000
Message-ID: <20261127152730.99319-10-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Let userspace veto guest register writes.
KVM_X86_SET_REG_WRITE_FILTER arms a mask on one register, and a write
which changes a masked bit exits with KVM_EXIT_X86_REG_WRITE first.
KVM_RUN means userspace performed it, and retires the instruction,
unless 'ret' says otherwise.

Only XCR0, which L2 shares, so KVM's XSETBV for L2 is filtered
too.  Without NextRIP the emulator raises the exit.

VMs with encrypted memory or protected state are refused, as is moving
an SEV context into a VM with filters armed.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  | 103 ++++++++++++++-
 arch/x86/include/asm/kvm_host.h |  12 ++
 arch/x86/include/uapi/asm/kvm.h |  13 ++
 arch/x86/kvm/emulate.c          |   5 +
 arch/x86/kvm/kvm_emulate.h      |   8 ++
 arch/x86/kvm/regs.h             |  21 +++
 arch/x86/kvm/svm/sev.c          |  22 +++
 arch/x86/kvm/svm/svm.c          |  21 ++-
 arch/x86/kvm/vmx/vmx.c          |   8 +-
 arch/x86/kvm/x86.c              | 228 +++++++++++++++++++++++++++++++-
 arch/x86/kvm/x86.h              |   2 +-
 include/uapi/linux/kvm.h        |  14 ++
 12 files changed, 449 insertions(+), 8 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index ea48247c2976..561d90c3b2d8 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6788,6 +6788,67 @@ if the guest_memfd memory was pinned in IOMMU page tables.
 
 See also: :ref:`KVM_SET_MEMORY_ATTRIBUTES`.
 
+4.147 KVM_X86_SET_REG_WRITE_FILTER
+----------------------------------
+
+:Capability: KVM_CAP_X86_REG_WRITE_FILTER
+:Architectures: x86
+:Type: vcpu ioctl
+:Parameters: struct kvm_x86_reg_write_filter
+:Returns: 0 on success, < 0 on error
+
+::
+
+  struct kvm_x86_reg_write_filter {
+	__u32 reg;		/* KVM_X86_REG_FILTER_* */
+	__u32 flags;		/* must be zero */
+	__u64 mask;		/* trigger bits; zero disarms the filter */
+	__u64 reserved[5];
+  };
+
+Arms (or, with a zero mask, disarms) a write filter on one register of
+the vCPU.  While a filter is armed, a write executed by the guest that
+changes any register bit set in ``mask`` does not take effect; the vCPU
+takes a KVM_EXIT_X86_REG_WRITE exit carrying the old and new values, and
+userspace decides what happens instead.  See the KVM_EXIT_X86_REG_WRITE
+documentation for the exit protocol.
+
+KVM_CHECK_EXTENSION on KVM_CAP_X86_REG_WRITE_FILTER returns a bitmask of
+the register classes the host can filter, ``BIT(KVM_X86_REG_FILTER_*)``,
+and zero on the fd of a VM on which no filter can be armed (see below).
+The classes are:
+
+  ========================== ============================================
+  KVM_X86_REG_FILTER_XCR0    XCR0, written by XSETBV
+  ========================== ============================================
+
+Only writes executed by the guest are filtered.  Writes from userspace
+(KVM_SET_SREGS, KVM_SET_XCRS and similar) and state loaded by RSM, INIT
+or SIPI do not trigger the filter.  Writes executed by a nested guest do
+not trigger the filter, whether or not L1 intercepts them: they change
+the nested guest's register.  XCR0 is the exception, because L1 and its
+nested guest share it: an XSETBV which L1 lets the nested guest execute
+is filtered like L1's own, and the exit is then taken with
+KVM_RUN_X86_GUEST_MODE set in kvm_run.flags.
+
+Writes executed in System Management Mode do not trigger the filter
+either: SMM code is platform firmware, above the filter's protection
+scope.  That holds only as far as the guest cannot run code of its own
+in SMM.  KVM delivers an SMI which the guest sends itself through its
+local APIC, and RSM loads control registers from the SMM state-save
+area, so a VMM which arms a filter against the guest's kernel has to
+keep that kernel out of SMRAM, with the SMM address space
+(KVM_CAP_MULTI_ADDRESS_SPACE) and firmware which locks it.
+
+The ioctl fails with -EINVAL if ``reg`` or any ``mask`` bit is not
+supported, or if ``flags`` or ``reserved`` are not zero.
+
+No filter can be armed on a VM whose guest memory is encrypted or whose
+register state is protected (SEV, SEV-ES, SEV-SNP, TDX): KVM cannot
+decode the instructions of such a guest.  The ioctl fails with -EINVAL
+there, and KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM fails with -EINVAL while a
+vCPU of the destination VM has a filter armed.
+
 .. _kvm_run:
 
 5. The kvm_run structure
@@ -6963,8 +7024,8 @@ to the byte array.
 .. note::
 
       For KVM_EXIT_IO, KVM_EXIT_MMIO, KVM_EXIT_OSI, KVM_EXIT_PAPR, KVM_EXIT_XEN,
-      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_TDX,
-      KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR the corresponding
+      KVM_EXIT_EPR, KVM_EXIT_HYPERCALL, KVM_EXIT_TDX, KVM_EXIT_X86_RDMSR,
+      KVM_EXIT_X86_WRMSR and KVM_EXIT_X86_REG_WRITE the corresponding
       operations are complete (and guest state is consistent) only after userspace
       has re-entered the kernel with KVM_RUN.  The kernel side will first finish
       incomplete operations and then check for pending signals.
@@ -7785,6 +7846,44 @@ The supported 'ret' values and their respective SW_EXITINFO2 encodings:
              a KVM-defined hypervisor value, as allowed by the GHCB)
   ======     =============================================================
 
+::
+
+		/* KVM_EXIT_X86_REG_WRITE */
+		struct {
+			__u8 insn_len;	/* of the instruction which wrote */
+			__u8 ret;	/* in: KVM_INSN_* */
+			__u8 pad[2];
+			__u32 reg;	/* KVM_X86_REG_FILTER_* */
+			__u64 old_value;
+			__u64 new_value;
+		} reg_write;
+
+Used on x86 systems.  The guest executed a write, to a register with a
+write filter armed by KVM_X86_SET_REG_WRITE_FILTER, that changes at
+least one of the filtered bits.  The write has not taken effect and the
+instruction has not retired: RIP still points at it.  ``reg`` identifies
+the register, ``old_value`` its current contents, ``new_value`` the
+value the guest tried to write and ``insn_len`` the length in bytes of
+the instruction, which is always valid and never zero.  The exit is
+taken before KVM validates the write: ``new_value`` may be one for which
+the instruction would have faulted.  ``pad`` is reserved and is zero.
+Userspace writes nothing to the structure but ``ret``.
+
+The exit needs completion.  KVM does not perform the write, ever, and
+sets ``ret`` to zero, KVM_INSN_COMPLETE.  Re-entering the vCPU with
+``ret`` still zero tells KVM that userspace has performed the write, or
+as much of it as the guest is to see, with KVM_SET_SREGS2, KVM_SET_XCRS
+or whatever sets the register: KVM retires the instruction as if it had
+executed and does not touch the register.
+
+For anything else, userspace sets ``ret`` to another of the KVM_INSN_*
+values (see :ref:`the description of completion <kvm_insn_action>`)
+before it re-enters the vCPU, and the instruction does not complete.
+KVM_INSN_GP refuses the write: KVM injects #GP(0), as the CPU does for a
+value it does not accept.  KVM_INSN_UD injects #UD, as the CPU does for
+an instruction it does not have.  With KVM_INSN_RESUME KVM does nothing,
+for a VMM which queues another exception, moves RIP itself, or hands the
+write to something else to decide.
 
 .. _cap_enable:
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index dcb0ce584f02..437e89ca93e1 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -220,6 +220,9 @@ enum x86_intercept_stage;
 
 #define KVM_NR_DB_REGS	4
 
+/* Register classes KVM_X86_SET_REG_WRITE_FILTER knows about */
+#define KVM_X86_NR_REG_WRITE_FILTERS	(KVM_X86_REG_FILTER_XCR0 + 1)
+
 #define PFERR_PRESENT_MASK	BIT(0)
 #define PFERR_WRITE_MASK	BIT(1)
 #define PFERR_USER_MASK		BIT(2)
@@ -264,6 +267,8 @@ struct kvm_caps {
 	u32  max_guest_tsc_khz;
 	/* number of bits of the fractional part of the TSC scaling ratio */
 	u8   tsc_scaling_ratio_frac_bits;
+	/* bit mask of KVM_X86_REG_FILTER_* register classes */
+	u32  supported_reg_write_filter;
 	/* maximum allowed value of TSC scaling ratio */
 	u64  max_tsc_scaling_ratio;
 	/* 1ull << kvm_caps.tsc_scaling_ratio_frac_bits */
@@ -860,6 +865,13 @@ struct kvm_vcpu_arch {
 	unsigned long cui_linear_rip;
 	int cui_rdmsr_imm_reg;
 
+	/*
+	 * KVM_X86_SET_REG_WRITE_FILTER state: a bitmask of armed register
+	 * classes and the per-register trigger masks.
+	 */
+	u32 reg_write_filter_armed;
+	u64 reg_write_filter[KVM_X86_NR_REG_WRITE_FILTERS];
+
 	gpa_t time;
 	s8  pvclock_tsc_shift;
 	u32 pvclock_tsc_mul;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 00ce265391e1..5a16a2ce4399 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -230,6 +230,19 @@ struct kvm_msr_filter {
 	struct kvm_msr_filter_range ranges[KVM_MSR_FILTER_MAX_RANGES];
 };
 
+/* Register classes for KVM_X86_SET_REG_WRITE_FILTER */
+#define KVM_X86_REG_FILTER_CR0		0
+#define KVM_X86_REG_FILTER_CR4		1
+#define KVM_X86_REG_FILTER_XCR0		2
+
+/* for KVM_X86_SET_REG_WRITE_FILTER */
+struct kvm_x86_reg_write_filter {
+	__u32 reg;		/* KVM_X86_REG_FILTER_* */
+	__u32 flags;		/* must be zero */
+	__u64 mask;		/* trigger bits; zero disarms the filter */
+	__u64 reserved[5];
+};
+
 struct kvm_cpuid_entry {
 	__u32 function;
 	__u32 eax;
diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index c1b21282187f..465b7d402f75 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -3784,6 +3784,7 @@ static int em_fxrstor(struct x86_emulate_ctxt *ctxt)
 static int em_xsetbv(struct x86_emulate_ctxt *ctxt)
 {
 	u32 eax, ecx, edx;
+	int rc;
 
 	if (!(ctxt->ops->get_cr(ctxt, 4) & X86_CR4_OSXSAVE))
 		return emulate_ud(ctxt);
@@ -3792,6 +3793,10 @@ static int em_xsetbv(struct x86_emulate_ctxt *ctxt)
 	edx = reg_read(ctxt, VCPU_REGS_RDX);
 	ecx = reg_read(ctxt, VCPU_REGS_RCX);
 
+	rc = ctxt->ops->filter_xcr_write(ctxt, ecx, ((u64)edx << 32) | eax);
+	if (rc != X86EMUL_CONTINUE)
+		return rc;
+
 	if (ctxt->ops->set_xcr(ctxt, ecx, ((u64)edx << 32) | eax))
 		return emulate_gp(ctxt, 0);
 
diff --git a/arch/x86/kvm/kvm_emulate.h b/arch/x86/kvm/kvm_emulate.h
index 10886bea82c9..5e18c0cc7f60 100644
--- a/arch/x86/kvm/kvm_emulate.h
+++ b/arch/x86/kvm/kvm_emulate.h
@@ -246,6 +246,14 @@ struct x86_emulate_ops {
 	int (*get_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 *xcr);
 	int (*set_xcr)(struct x86_emulate_ctxt *ctxt, u32 index, u64 xcr);
 
+	/*
+	 * Called by XSETBV before ->set_xcr().  Anything but
+	 * X86EMUL_CONTINUE means that a register write filter took the
+	 * write: the handler returns it and makes no change.
+	 */
+	int (*filter_xcr_write)(struct x86_emulate_ctxt *ctxt, u32 index,
+				u64 xcr);
+
 	gva_t (*get_untagged_addr)(struct x86_emulate_ctxt *ctxt, gva_t addr,
 				   unsigned int flags);
 
diff --git a/arch/x86/kvm/regs.h b/arch/x86/kvm/regs.h
index 97c17b120a57..9fbd6c37bf68 100644
--- a/arch/x86/kvm/regs.h
+++ b/arch/x86/kvm/regs.h
@@ -65,6 +65,27 @@ unsigned long kvm_get_cr8(struct kvm_vcpu *vcpu);
 void kvm_lmsw(struct kvm_vcpu *vcpu, unsigned long msw);
 int load_pdptrs(struct kvm_vcpu *vcpu, unsigned long cr3);
 
+int kvm_vcpu_ioctl_set_reg_write_filter(struct kvm_vcpu *vcpu,
+					struct kvm_x86_reg_write_filter *filter);
+bool __kvm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg, u64 changed_bits);
+void kvm_reg_write_user_space(struct kvm_vcpu *vcpu, u32 reg, u64 old_value,
+			      u64 new_value, u8 insn_len);
+
+/*
+ * Does a guest write of @new_value to @reg take a KVM_EXIT_X86_REG_WRITE
+ * exit?  Must be called before the write is performed, from a path that
+ * handles a write the guest itself executed; host-initiated writes are
+ * never filtered.
+ */
+static inline bool kvm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg,
+					  u64 old_value, u64 new_value)
+{
+	if (likely(!(vcpu->arch.reg_write_filter_armed & BIT(reg))))
+		return false;
+
+	return __kvm_reg_write_filtered(vcpu, reg, old_value ^ new_value);
+}
+
 static inline bool is_long_mode(struct kvm_vcpu *vcpu)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index b90c5f14c1ac..62c66e0f6448 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2149,6 +2149,24 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	return 0;
 }
 
+/*
+ * The destination becomes an SEV guest, which cannot have register write
+ * filters (KVM_X86_SET_REG_WRITE_FILTER refuses to arm them).  Refuse the
+ * move while any destination vCPU has one armed; the VMM can disarm first.
+ */
+static int sev_check_dest_reg_write_filters(struct kvm *dst)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, vcpu, dst) {
+		if (vcpu->arch.reg_write_filter_armed)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
 	struct kvm_sev_info *dst_sev = to_kvm_sev_info(kvm);
@@ -2198,6 +2216,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (ret)
 		goto out_source_vcpu;
 
+	ret = sev_check_dest_reg_write_filters(kvm);
+	if (ret)
+		goto out_source_vcpu;
+
 	/*
 	 * Allocate a new have_run_cpus for the destination, i.e. don't copy
 	 * the set of CPUs from the source.  If a CPU was used to run a vCPU in
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index e30ee80624b7..4ffb41234dc2 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2604,6 +2604,25 @@ static int rsm_interception(struct kvm_vcpu *vcpu)
 	return kvm_emulate_instruction_from_buffer(vcpu, rsm_ins_bytes, 2);
 }
 
+/*
+ * The length of the instruction whose intercept is being handled, or zero
+ * where the CPU does not tell (no NextRIP).
+ */
+static u8 svm_exit_insn_len(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	if (!nrips || !svm->vmcb->control.next_rip)
+		return 0;
+
+	return svm->vmcb->control.next_rip - kvm_rip_read(vcpu);
+}
+
+static int xsetbv_interception(struct kvm_vcpu *vcpu)
+{
+	return kvm_emulate_xsetbv(vcpu, svm_exit_insn_len(vcpu));
+}
+
 static bool check_selective_cr0_intercepted(struct kvm_vcpu *vcpu,
 					    unsigned long val)
 {
@@ -3496,7 +3515,7 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_WBINVD]                       = kvm_emulate_wbinvd,
 	[SVM_EXIT_MONITOR]			= kvm_emulate_monitor,
 	[SVM_EXIT_MWAIT]			= kvm_emulate_mwait,
-	[SVM_EXIT_XSETBV]			= kvm_emulate_xsetbv,
+	[SVM_EXIT_XSETBV]			= xsetbv_interception,
 	[SVM_EXIT_ICEBP]			= icebp_interception,
 	[SVM_EXIT_RDPRU]			= kvm_handle_invalid_op,
 	[SVM_EXIT_EFER_WRITE_TRAP]		= efer_trap,
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 82eb891f684c..aeae8eedd19f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -6143,6 +6143,12 @@ static int handle_monitor_trap(struct kvm_vcpu *vcpu)
 	return 1;
 }
 
+static int handle_xsetbv(struct kvm_vcpu *vcpu)
+{
+	/* The length is for the exit which a register write filter takes. */
+	return kvm_emulate_xsetbv(vcpu, vmcs_read32(VM_EXIT_INSTRUCTION_LEN));
+}
+
 static int handle_invpcid(struct kvm_vcpu *vcpu)
 {
 	u32 vmx_instruction_info;
@@ -6339,7 +6345,7 @@ static int (*kvm_vmx_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[EXIT_REASON_APIC_WRITE]              = handle_apic_write,
 	[EXIT_REASON_EOI_INDUCED]             = handle_apic_eoi_induced,
 	[EXIT_REASON_WBINVD]                  = kvm_emulate_wbinvd,
-	[EXIT_REASON_XSETBV]                  = kvm_emulate_xsetbv,
+	[EXIT_REASON_XSETBV]                  = handle_xsetbv,
 	[EXIT_REASON_TASK_SWITCH]             = handle_task_switch,
 	[EXIT_REASON_MCE_DURING_VMENTRY]      = handle_machine_check,
 	[EXIT_REASON_GDTR_IDTR]		      = handle_desc,
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index da22e7d9cacd..b559c7880e54 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -742,11 +742,106 @@ int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_set_xcr);
 
-int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
+bool __kvm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg, u64 changed_bits)
 {
+	/*
+	 * The filter covers the vCPU itself.  A write performed by or on
+	 * behalf of a nested guest is applied normally; whether it exits
+	 * is L1's business.  Not so for XCR0, which L1 and L2 share: an
+	 * XSETBV which L1 lets L2 make changes L1's register too.  Writes
+	 * in SMM are platform firmware's, above the filter's protection
+	 * scope; they are applied normally too.
+	 */
+	if (is_smm(vcpu))
+		return false;
+
+	if (is_guest_mode(vcpu) && reg != KVM_X86_REG_FILTER_XCR0)
+		return false;
+
+	return changed_bits & vcpu->arch.reg_write_filter[reg];
+}
+
+/*
+ * KVM_RUN after KVM_EXIT_X86_REG_WRITE: userspace has performed the write,
+ * or as much of it as it wants the guest to see, so all that is left is to
+ * retire the instruction, as for an MSR access which userspace completed.
+ * Userspace which wants anything else says that the instruction does not
+ * complete: KVM refuses the write with #GP or #UD, or leaves it alone.
+ *
+ * Returns 1 if that was all, 0 if the instruction is to be retired, or
+ * -EINVAL.
+ */
+static int kvm_reg_write_uncompleted(struct kvm_vcpu *vcpu)
+{
+	return kvm_insn_uncompleted(vcpu, READ_ONCE(vcpu->run->reg_write.ret));
+}
+
+static int complete_fast_reg_write(struct kvm_vcpu *vcpu)
+{
+	int r = kvm_reg_write_uncompleted(vcpu);
+
+	if (r)
+		return r;
+
+	return kvm_skip_emulated_instruction(vcpu);
+}
+
+static void kvm_fill_reg_write_exit(struct kvm_vcpu *vcpu, u32 reg,
+				    u64 old_value, u64 new_value, u8 insn_len)
+{
+	struct kvm_run *run = vcpu->run;
+
+	run->exit_reason = KVM_EXIT_X86_REG_WRITE;
+	memset(&run->reg_write, 0, sizeof(run->reg_write));
+	run->reg_write.insn_len = insn_len;
+	run->reg_write.reg = reg;
+	run->reg_write.old_value = old_value;
+	run->reg_write.new_value = new_value;
+}
+
+/*
+ * Exit to userspace with a write that passed kvm_reg_write_filtered(), made
+ * by an instruction of @insn_len bytes whose intercept is being handled.
+ * The write is not performed and the instruction does not retire: RIP is
+ * left pointing at it, and the completion retires it once userspace has
+ * performed the write.
+ */
+void kvm_reg_write_user_space(struct kvm_vcpu *vcpu, u32 reg, u64 old_value,
+			      u64 new_value, u8 insn_len)
+{
+	kvm_fill_reg_write_exit(vcpu, reg, old_value, new_value, insn_len);
+	vcpu->arch.complete_userspace_io = complete_fast_reg_write;
+}
+
+int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu, u8 insn_len)
+{
+	u32 index = kvm_ecx_read(vcpu);
+	u64 xcr = kvm_read_edx_eax(vcpu);
+
 	/* Note, #UD due to CR4.OSXSAVE=0 has priority over the intercept. */
-	if (kvm_x86_call(get_cpl)(vcpu) != 0 ||
-	    __kvm_set_xcr(vcpu, kvm_ecx_read(vcpu), kvm_read_edx_eax(vcpu))) {
+	if (kvm_x86_call(get_cpl)(vcpu) != 0) {
+		kvm_inject_gp(vcpu, 0);
+		return 1;
+	}
+
+	if (index == XCR_XFEATURE_ENABLED_MASK &&
+	    kvm_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_XCR0,
+				   vcpu->arch.xcr0, xcr)) {
+		/*
+		 * The exit reports the length of the instruction.  Where
+		 * the intercept does not provide it, let the emulator
+		 * raise the exit, as it does for an XSETBV which it meets
+		 * by itself.
+		 */
+		if (!insn_len)
+			return kvm_emulate_instruction(vcpu, 0);
+
+		kvm_reg_write_user_space(vcpu, KVM_X86_REG_FILTER_XCR0,
+					 vcpu->arch.xcr0, xcr, insn_len);
+		return 0;
+	}
+
+	if (__kvm_set_xcr(vcpu, index, xcr)) {
 		kvm_inject_gp(vcpu, 0);
 		return 1;
 	}
@@ -755,6 +850,65 @@ int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu)
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_emulate_xsetbv);
 
+/*
+ * KVM cannot decode the instructions of a guest whose memory is encrypted
+ * (has_protected_page_tables: every SEV and TDX guest), for the length
+ * which the exit reports, and a guest whose register state is protected
+ * does not report its writes the way the filter needs.
+ */
+static bool kvm_reg_write_filter_possible(struct kvm *kvm)
+{
+	return !kvm->arch.has_protected_state &&
+	       !kvm->arch.has_protected_page_tables;
+}
+
+int kvm_vcpu_ioctl_set_reg_write_filter(struct kvm_vcpu *vcpu,
+					struct kvm_x86_reg_write_filter *filter)
+{
+	u64 allowed;
+
+	if (filter->flags)
+		return -EINVAL;
+
+	if (memchr_inv(filter->reserved, 0, sizeof(filter->reserved)))
+		return -EINVAL;
+
+	if (filter->reg >= KVM_X86_NR_REG_WRITE_FILTERS ||
+	    !(kvm_caps.supported_reg_write_filter & BIT(filter->reg)))
+		return -EINVAL;
+
+	filter->reg = array_index_nospec(filter->reg,
+					 KVM_X86_NR_REG_WRITE_FILTERS);
+
+	if (!kvm_reg_write_filter_possible(vcpu->kvm))
+		return -EINVAL;
+
+	switch (filter->reg) {
+	case KVM_X86_REG_FILTER_CR0:
+		allowed = ~CR0_RESERVED_BITS;
+		break;
+	case KVM_X86_REG_FILTER_CR4:
+		allowed = ~CR4_RESERVED_BITS;
+		break;
+	case KVM_X86_REG_FILTER_XCR0:
+		allowed = kvm_caps.supported_xcr0 | XFEATURE_MASK_FP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (filter->mask & ~allowed)
+		return -EINVAL;
+
+	vcpu->arch.reg_write_filter[filter->reg] = filter->mask;
+	if (filter->mask)
+		vcpu->arch.reg_write_filter_armed |= BIT(filter->reg);
+	else
+		vcpu->arch.reg_write_filter_armed &= ~BIT(filter->reg);
+
+	return 0;
+}
+
 void kvm_invalidate_pcid(struct kvm_vcpu *vcpu, unsigned long pcid)
 {
 	struct kvm_mmu *mmu = vcpu->arch.mmu;
@@ -2414,6 +2568,12 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_PMU_CAPABILITY:
 		r = enable_pmu ? KVM_CAP_PMU_VALID_MASK : 0;
 		break;
+	case KVM_CAP_X86_REG_WRITE_FILTER:
+		if (kvm && !kvm_reg_write_filter_possible(kvm))
+			r = 0;
+		else
+			r = kvm_caps.supported_reg_write_filter;
+		break;
 	case KVM_CAP_DISABLE_QUIRKS2:
 		r = kvm_caps.supported_quirks;
 		break;
@@ -3889,6 +4049,15 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	case KVM_SET_DEVICE_ATTR:
 		r = kvm_vcpu_ioctl_device_attr(vcpu, ioctl, argp);
 		break;
+	case KVM_X86_SET_REG_WRITE_FILTER: {
+		struct kvm_x86_reg_write_filter filter;
+
+		r = -EFAULT;
+		if (copy_from_user(&filter, argp, sizeof(filter)))
+			goto out;
+		r = kvm_vcpu_ioctl_set_reg_write_filter(vcpu, &filter);
+		break;
+	}
 	case KVM_MEMORY_ENCRYPT_OP:
 		r = -ENOTTY;
 		if (!kvm_x86_ops.vcpu_mem_enc_ioctl)
@@ -5628,6 +5797,55 @@ static int emulator_set_cr(struct x86_emulate_ctxt *ctxt, int cr, ulong val)
 	return res;
 }
 
+/*
+ * The emulator raised the exit, so the emulator retires the instruction it
+ * decoded, as it does for an emulated MSR access which userspace completed,
+ * unless userspace says that the instruction does not complete.
+ */
+static int complete_emulated_reg_write(struct kvm_vcpu *vcpu)
+{
+	int r = kvm_reg_write_uncompleted(vcpu);
+
+	if (r)
+		return r;
+
+	return kvm_emulate_instruction(vcpu, EMULTYPE_NO_DECODE | EMULTYPE_SKIP |
+				       EMULTYPE_COMPLETE_USER_EXIT);
+}
+
+/*
+ * Exit to userspace with a filtered write which the emulator met, before
+ * it has any effect.
+ */
+static int emulator_reg_write_exit(struct x86_emulate_ctxt *ctxt, u32 reg,
+				   u64 old_value, u64 new_value)
+{
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+
+	kvm_fill_reg_write_exit(vcpu, reg, old_value, new_value,
+				ctxt->_eip - ctxt->eip);
+	vcpu->arch.complete_userspace_io = complete_emulated_reg_write;
+	return X86EMUL_IO_NEEDED;
+}
+
+/*
+ * Divert an emulated XSETBV into a KVM_EXIT_X86_REG_WRITE exit when it hits
+ * a write filter, before it has any effect.
+ */
+static int emulator_filter_xcr_write(struct x86_emulate_ctxt *ctxt, u32 index,
+				     u64 xcr)
+{
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+
+	if (index != XCR_XFEATURE_ENABLED_MASK ||
+	    !kvm_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_XCR0,
+				    vcpu->arch.xcr0, xcr))
+		return X86EMUL_CONTINUE;
+
+	return emulator_reg_write_exit(ctxt, KVM_X86_REG_FILTER_XCR0,
+				       vcpu->arch.xcr0, xcr);
+}
+
 static int emulator_get_cpl(struct x86_emulate_ctxt *ctxt)
 {
 	return kvm_x86_call(get_cpl)(emul_to_vcpu(ctxt));
@@ -5925,6 +6143,7 @@ static const struct x86_emulate_ops emulate_ops = {
 	.triple_fault        = emulator_triple_fault,
 	.get_xcr             = emulator_get_xcr,
 	.set_xcr             = emulator_set_xcr,
+	.filter_xcr_write    = emulator_filter_xcr_write,
 	.get_untagged_addr   = emulator_get_untagged_addr,
 	.is_canonical_addr   = emulator_is_canonical_addr,
 	.page_address_valid  = emulator_page_address_valid,
@@ -7152,6 +7371,9 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *ops)
 	if (boot_cpu_has(X86_FEATURE_XSAVE)) {
 		kvm_host.xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
 		kvm_caps.supported_xcr0 = kvm_host.xcr0 & KVM_SUPPORTED_XCR0;
+		/* XSETBV exits unconditionally on both VMX and SVM. */
+		kvm_caps.supported_reg_write_filter |=
+			BIT(KVM_X86_REG_FILTER_XCR0);
 	}
 
 	if (boot_cpu_has(X86_FEATURE_XSAVES)) {
diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
index 7e5ccbce9114..2e900788f707 100644
--- a/arch/x86/kvm/x86.h
+++ b/arch/x86/kvm/x86.h
@@ -496,7 +496,7 @@ int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
 		    int reason, bool has_error_code, u32 error_code);
 
 int __kvm_set_xcr(struct kvm_vcpu *vcpu, u32 index, u64 xcr);
-int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu);
+int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu, u8 insn_len);
 int kvm_emulate_rdpmc(struct kvm_vcpu *vcpu);
 
 int kvm_skip_emulated_instruction(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index e480544a3746..165fa36c2479 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -199,6 +199,7 @@ struct kvm_exit_snp_req_certs {
 #define KVM_EXIT_ARM_SEA          41
 #define KVM_EXIT_ARM_LDST64B      42
 #define KVM_EXIT_SNP_REQ_CERTS    43
+#define KVM_EXIT_X86_REG_WRITE    44
 
 /* For KVM_EXIT_INTERNAL_ERROR */
 /* Emulate instruction failed. */
@@ -512,6 +513,15 @@ struct kvm_run {
 		} arm_sea;
 		/* KVM_EXIT_SNP_REQ_CERTS */
 		struct kvm_exit_snp_req_certs snp_req_certs;
+		/* KVM_EXIT_X86_REG_WRITE */
+		struct {
+			__u8 insn_len;	/* of the instruction which wrote */
+			__u8 ret;	/* in: KVM_INSN_* */
+			__u8 pad[2];
+			__u32 reg;	/* KVM_X86_REG_FILTER_* */
+			__u64 old_value;
+			__u64 new_value;
+		} reg_write;
 		/* Fix the size of the union. */
 		char padding[256];
 	};
@@ -1017,6 +1027,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_GUEST_MEMFD_MEMORY_ATTRIBUTES 252
 #define KVM_CAP_X86_MSR_EXIT_INSN 253
 #define KVM_CAP_HYPERV_FORWARD_HCALL 254
+#define KVM_CAP_X86_REG_WRITE_FILTER 255
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
@@ -1707,4 +1718,7 @@ struct kvm_pre_fault_memory {
 	__u64 padding[5];
 };
 
+/* Available with KVM_CAP_X86_REG_WRITE_FILTER */
+#define KVM_X86_SET_REG_WRITE_FILTER	_IOW(KVMIO, 0xd6, struct kvm_x86_reg_write_filter)
+
 #endif /* __LINUX_KVM_H */
-- 
2.50.1

