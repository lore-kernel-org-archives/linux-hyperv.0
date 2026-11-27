Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=MXTRRkZOBMBjcEKWIAHpmOajaqBVjTvqW6GNKKcjfrnbHJZ05mxQbeUVhPYn5XrpKML6
	 I5Z4OCKBvXnAdHjKQwbuFqhIKh0xVPFwiWQ95pdWtx/IcXWUDT7hr8TGMDORf/oskG0De
	 qgILPYr+bNsJSyigsWZqdo5HDimIHFi67JBKJ5xja9WMBa/qAKPsG59QJmw/9vI3NUrLH
	 4N5o/LDe0QZnEOJG4Dbz2wOglWhbav30FXL2JYcVqIsPmgwYbCtQU7iTrBmEHg0yF0M8X
	 vYfBfK/JZlZpX4W9MFNYzNE8K+QEpcRatyPC6bJznHtB03a4w/dBeflhsR12tTSQ0qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=TWmd9+GxWKlZ+gfuxLpEDFCj6tyXaab+RqmwaOj/H9I=;
	b=zR0azfkvEd25fwZYLwjjrJbzbPdA9ConP5/ldm/0/gcO0lLq4gMpgqOHcY4GmpSC+wz2
	 C1fn098s4aETsB2mbicc8OHaHb8qqFdVVcN9ljEYCkqeb/CkYwXPUqr0Gh71lhBI9OGFG
	 JXDR342lNMyL/CwEpbfWvaSE4K7OUK/YhcjmbEY9tc3PXcqpv64dMhUYaykQn/MawsAYp
	 kGM48PBTbK6lrvsE8hxOusAafPHnVZjbibYxZDJpOjdrCjFkMGlRsY0+G0mUHp64R+a/b
	 BuJ7PGyLNC3HRZr3P50zKddtyaCW/L15ZaasG0vTfsiRdyTPGcIwCdJZL/zNo3Oy62w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=BC5BzPv8;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4E606A326;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE4E606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=BC5BzPv8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=TWmd9+GxWKlZ+gfuxLpEDFCj6tyXaab+RqmwaOj/H9I=; b=BC5BzPv86RpYvckCraBvRDkVGF
	sCDFwNfkqL63P7HoXzrqKf6F70ojoHzaGqvUQBn2OcEncaAPng7nHG3zxkBCp+fjVM3O9Mo1rPl16
	EuykgxPXZxmVnXJYW/jtqGAJtsiZLaoS+N1jov5tRNLysx7FRfemOjzqqW8SoqKudLOR8SUvOhWlm
	fRDPTwrMrEhpqs75MeSgLAAivCjXg0oAl5smDvt2CSX8Qp4Y1S8y74yNwH2d3sEohKZxeziQbTfDI
	CZzbGL2EOtBHtYV9VxZA5dAFgsdp8Q4tGyjFuHAeBbptEXVMiShD0SY/AQRLlHdj+h6xeGkNKBorl
	QlwJiFpQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy3R-3uqJ;
	Fri, 27 Nov 2026 15:27:31 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pqi-2y2s;
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
Subject: [PATCH v3 11/15] KVM: VMX: Support CR0 and CR4 write filters
Date: Fri, 27 Nov 2026 15:27:26 +0000
Message-ID: <20261127152730.99319-12-dwmw2@infradead.org>
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

Add the vendor hook which applies a changed filter.  VMX makes filtered
bits host-owned in vmcs01 so that writes to them exit, and checks the
filter in handle_cr().  CLTS can exit again, so it is only a KVM_BUG
when no filter explains it.  When bits change owner, read them from the
guest first and refresh the read shadows.

L2 is not filtered.  With a CR4 filter armed, nested entry recomputes
CR4 ownership for a clean vmcs12 too, which prepare_vmcs02_rare() skips.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst     |  28 ++++++--
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   7 ++
 arch/x86/kvm/vmx/main.c            |  13 ++++
 arch/x86/kvm/vmx/nested.c          |  27 +++++--
 arch/x86/kvm/vmx/vmx.c             | 109 +++++++++++++++++++++++++++--
 arch/x86/kvm/vmx/vmx.h             |  14 +++-
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 |   3 +
 9 files changed, 187 insertions(+), 16 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 561d90c3b2d8..a5192d1ca599 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6819,16 +6819,19 @@ and zero on the fd of a VM on which no filter can be armed (see below).
 The classes are:
 
   ========================== ============================================
+  KVM_X86_REG_FILTER_CR0     CR0, written by MOV to CR0, CLTS and LMSW
+  KVM_X86_REG_FILTER_CR4     CR4, written by MOV to CR4
   KVM_X86_REG_FILTER_XCR0    XCR0, written by XSETBV
   ========================== ============================================
 
 Only writes executed by the guest are filtered.  Writes from userspace
-(KVM_SET_SREGS, KVM_SET_XCRS and similar) and state loaded by RSM, INIT
-or SIPI do not trigger the filter.  Writes executed by a nested guest do
-not trigger the filter, whether or not L1 intercepts them: they change
-the nested guest's register.  XCR0 is the exception, because L1 and its
-nested guest share it: an XSETBV which L1 lets the nested guest execute
-is filtered like L1's own, and the exit is then taken with
+(KVM_SET_SREGS, KVM_SET_XCRS and similar), CR0/CR4 loads performed as
+part of VM entry and VM exit of a nested guest, and state loaded by RSM,
+INIT or SIPI do not trigger the filter.  Writes executed by a nested
+guest do not trigger the filter, whether or not L1 intercepts them: they
+change the nested guest's register.  XCR0 is the exception, because L1
+and its nested guest share it: an XSETBV which L1 lets the nested guest
+execute is filtered like L1's own, and the exit is then taken with
 KVM_RUN_X86_GUEST_MODE set in kvm_run.flags.
 
 Writes executed in System Management Mode do not trigger the filter
@@ -6840,6 +6843,19 @@ area, so a VMM which arms a filter against the guest's kernel has to
 keep that kernel out of SMRAM, with the SMM address space
 (KVM_CAP_MULTI_ADDRESS_SPACE) and firmware which locks it.
 
+Nor does a control register load which the guest brings about without
+writing the register.  A hardware task switch sets CR0.TS; it can only
+set that bit, and there is no task switch in 64-bit mode, so a filter on
+CR0.PG keeps it away from a 64-bit guest.  With VMX exposed to the
+guest, a nested VM-exit loads CR0 and CR4 from the host-state fields of
+the VMCS, which the guest writes.  A VMM which arms a CR0 or CR4 filter
+against the guest's kernel has to accept those, or not expose VMX.
+
+Filtering a CR0 or CR4 bit that KVM otherwise lets the guest own (for
+example CR0.TS) forces interception of writes to that register, with the
+attendant cost on write-heavy bits; the per-bit mask exists so that only
+the bits userspace actually cares about pay it.
+
 The ioctl fails with -EINVAL if ``reg`` or any ``mask`` bit is not
 supported, or if ``flags`` or ``reserved`` are not zero.
 
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 4dde4e3e608a..1e98d1c98303 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -143,6 +143,7 @@ KVM_X86_OP(check_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
 KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
 KVM_X86_OP_OPTIONAL(migrate_timers)
+KVM_X86_OP_OPTIONAL(update_reg_write_filter)
 KVM_X86_OP(recalc_intercepts)
 KVM_X86_OP(complete_emulated_msr)
 KVM_X86_OP(vcpu_deliver_sipi_vector)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 437e89ca93e1..3e0365f5557a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1745,6 +1745,13 @@ struct kvm_x86_ops {
 	int (*enable_l2_tlb_flush)(struct kvm_vcpu *vcpu);
 
 	void (*migrate_timers)(struct kvm_vcpu *vcpu);
+
+	/*
+	 * A register write filter changed: bring the interception which the
+	 * armed filters need in line with vcpu->arch.reg_write_filter.
+	 */
+	void (*update_reg_write_filter)(struct kvm_vcpu *vcpu);
+
 	void (*recalc_intercepts)(struct kvm_vcpu *vcpu);
 	int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
 
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index d75170a6199e..f902b0afabc9 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -219,6 +219,18 @@ static int vt_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 	return vmx_complete_emulated_msr(vcpu, err);
 }
 
+static void vt_update_reg_write_filter(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * KVM_X86_SET_REG_WRITE_FILTER refuses to arm a filter on a VM with
+	 * protected state, so there is never anything to apply for TDX.
+	 */
+	if (is_td_vcpu(vcpu))
+		return;
+
+	vmx_update_reg_write_filter(vcpu);
+}
+
 #ifdef CONFIG_KVM_SMM
 static int vt_smi_allowed(struct kvm_vcpu *vcpu, bool for_injection)
 {
@@ -1137,6 +1149,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 	.check_emulate_instruction = vt_op(check_emulate_instruction),
 	.apic_init_signal_blocked = vt_op(apic_init_signal_blocked),
 	.migrate_timers = vmx_migrate_timers,
+	.update_reg_write_filter = vt_op(update_reg_write_filter),
 
 	.recalc_intercepts = vt_op(recalc_intercepts),
 	.complete_emulated_msr = vt_op(complete_emulated_msr),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 879183c1bfa5..cd1083b2c344 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -2805,9 +2805,24 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, struct vmcs12 *vmcs12,
 	 * trap. Note that CR0.TS also needs updating - we do this later.
 	 */
 	vmx_update_exception_bitmap(vcpu);
-	vcpu->arch.cr0_guest_owned_bits &= ~vmcs12->cr0_guest_host_mask;
+	/*
+	 * Recompute from scratch rather than narrowing the current (vmcs01)
+	 * value: a register write filter (KVM_X86_SET_REG_WRITE_FILTER)
+	 * forces its bits host-owned there, but covers only L1's writes.
+	 */
+	vcpu->arch.cr0_guest_owned_bits = vmx_guest_owned_cr0_bits() &
+					  ~vmcs12->cr0_guest_host_mask;
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
+	/*
+	 * Likewise for CR4, which prepare_vmcs02_rare() computes only when
+	 * vmcs12 is dirty: the nested VM-exit left L1's set behind, which
+	 * with a filter armed has fewer bits than vmcs02 lets L2 own, and
+	 * KVM would then not read such a bit back from GUEST_CR4.
+	 */
+	if (vcpu->arch.reg_write_filter[KVM_X86_REG_FILTER_CR4])
+		set_cr4_guest_host_mask(vmx);
+
 	if (vcpu->arch.nested_run_pending &&
 	    (vmcs12->vm_entry_controls & VM_ENTRY_LOAD_IA32_PAT)) {
 		vmcs_write64(GUEST_IA32_PAT, vmcs12->guest_ia32_pat);
@@ -4823,10 +4838,11 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
 	 * Note that calling vmx_set_cr0 is important, even if cr0 hasn't
 	 * actually changed, because vmx_set_cr0 refers to efer set above.
 	 *
-	 * CR0_GUEST_HOST_MASK is already set in the original vmcs01
-	 * (KVM doesn't change it);
+	 * CR0_GUEST_HOST_MASK is already correct in vmcs01:
+	 * __nested_vmx_vmexit() refreshed it after switching back, in case
+	 * a register write filter changed while vmcs02 was loaded.
 	 */
-	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits(vcpu);
 	vmx_set_cr0(vcpu, vmcs12->host_cr0);
 
 	/* Same as above - no reason to call set_cr4_guest_host_mask().  */
@@ -4992,7 +5008,7 @@ static void nested_vmx_restore_host_state(struct kvm_vcpu *vcpu)
 	 */
 	vmx_set_efer(vcpu, nested_vmx_get_vmcs01_guest_efer(vmx));
 
-	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits(vcpu);
 	vmx_set_cr0(vcpu, vmcs_readl(CR0_READ_SHADOW));
 
 	vcpu->arch.cr4_guest_owned_bits = ~vmcs_readl(CR4_GUEST_HOST_MASK);
@@ -5172,6 +5188,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	 * Update any VMCS fields that might have changed while vmcs02 was the
 	 * active VMCS.  The tracking is per-vCPU, not per-VMCS.
 	 */
+	vmx_refresh_reg_write_filter(vcpu);
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, vmx->msr_autostore.nr);
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index aeae8eedd19f..d785bcf52a3f 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4563,12 +4563,69 @@ void set_cr4_guest_host_mask(struct vcpu_vmx *vmx)
 		vcpu->arch.cr4_guest_owned_bits &= ~X86_CR4_TLBFLUSH_BITS;
 		vcpu->arch.cr4_guest_owned_bits &= ~X86_CR4_PDPTR_BITS;
 	}
-	if (is_guest_mode(&vmx->vcpu))
+	if (is_guest_mode(&vmx->vcpu)) {
 		vcpu->arch.cr4_guest_owned_bits &=
 			~get_vmcs12(vcpu)->cr4_guest_host_mask;
+	} else {
+		/*
+		 * A write filter (KVM_X86_SET_REG_WRITE_FILTER) forces
+		 * interception of L1's writes to the filtered bits.  It
+		 * covers only L1, so the vmcs02 mask is left alone.
+		 */
+		vcpu->arch.cr4_guest_owned_bits &=
+			~vcpu->arch.reg_write_filter[KVM_X86_REG_FILTER_CR4];
+	}
 	vmcs_writel(CR4_GUEST_HOST_MASK, ~vcpu->arch.cr4_guest_owned_bits);
 }
 
+/*
+ * Refresh the interception that the register write filter needs: a
+ * filtered CR0/CR4 bit must be host-owned in the vmcs01 guest/host masks
+ * so that the guest's writes to it actually exit.  For vmcs01, which must
+ * be loaded.
+ *
+ * This is all a nested VM-exit needs, for a filter which changed while
+ * vmcs02 was loaded: it loads L1's CR0 and CR4 afresh.
+ */
+void vmx_refresh_reg_write_filter(struct kvm_vcpu *vcpu)
+{
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits(vcpu);
+	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
+	set_cr4_guest_host_mask(to_vmx(vcpu));
+}
+
+/*
+ * A filter changed.  While vmcs02 is loaded there is nothing to do yet:
+ * __nested_vmx_vmexit() refreshes vmcs01 after switching back.
+ */
+void vmx_update_reg_write_filter(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+	unsigned long cr0, cr4;
+
+	if (vmx->loaded_vmcs != &vmx->vmcs01)
+		return;
+
+	/*
+	 * The guest changes the bits it owns without an exit, and KVM reads
+	 * them back from GUEST_CR0/GUEST_CR4 only on demand, and only those
+	 * it knows the guest to own.  Read them all before any changes
+	 * owner, or the cached value of such a bit stays stale for ever.
+	 */
+	cr0 = kvm_read_cr0(vcpu);
+	cr4 = kvm_read_cr4(vcpu);
+
+	vmx_refresh_reg_write_filter(vcpu);
+
+	/*
+	 * The guest reads a bit which the host owns from the read shadow,
+	 * and CLTS and LMSW exit or not by it: it has to hold the current
+	 * value of the bits which the host has just taken.
+	 */
+	vmcs_writel(CR0_READ_SHADOW, cr0);
+	vmcs_writel(CR4_READ_SHADOW, cr4);
+}
+
 static u32 vmx_pin_based_exec_ctrl(struct vcpu_vmx *vmx)
 {
 	u32 pin_based_exec_ctrl = vmcs_config.pin_based_exec_ctrl;
@@ -4976,7 +5033,7 @@ static void init_vmcs(struct kvm_vcpu *vcpu)
 	/* 22.2.1, 20.8.1 */
 	vm_entry_controls_set(vmx, vmx_get_initial_vmentry_ctrl());
 
-	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits();
+	vcpu->arch.cr0_guest_owned_bits = vmx_l1_guest_owned_cr0_bits(vcpu);
 	vmcs_writel(CR0_GUEST_HOST_MASK, ~vcpu->arch.cr0_guest_owned_bits);
 
 	set_cr4_guest_host_mask(vmx);
@@ -5680,6 +5737,21 @@ static int handle_desc(struct kvm_vcpu *vcpu)
 	return kvm_emulate_instruction(vcpu, 0);
 }
 
+/*
+ * Send an intercepted write which a register write filter catches to
+ * userspace instead of performing it.
+ */
+static bool vmx_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg,
+				   unsigned long old, unsigned long val)
+{
+	if (!kvm_reg_write_filtered(vcpu, reg, old, val))
+		return false;
+
+	kvm_reg_write_user_space(vcpu, reg, old, val,
+				 vmcs_read32(VM_EXIT_INSTRUCTION_LEN));
+	return true;
+}
+
 static int handle_cr(struct kvm_vcpu *vcpu)
 {
 	unsigned long exit_qualification, val;
@@ -5697,6 +5769,9 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		trace_kvm_cr_write(cr, val);
 		switch (cr) {
 		case 0:
+			if (vmx_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_CR0,
+						   kvm_read_cr0(vcpu), val))
+				return 0;
 			err = handle_set_cr0(vcpu, val);
 			return kvm_complete_insn_gp(vcpu, err);
 		case 3:
@@ -5705,6 +5780,9 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 			err = kvm_set_cr3(vcpu, val);
 			return kvm_complete_insn_gp(vcpu, err);
 		case 4:
+			if (vmx_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_CR4,
+						   kvm_read_cr4(vcpu), val))
+				return 0;
 			err = handle_set_cr4(vcpu, val);
 			return kvm_complete_insn_gp(vcpu, err);
 		case 8: {
@@ -5727,8 +5805,23 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 		}
 		break;
 	case 2: /* clts */
-		KVM_BUG(1, vcpu->kvm, "Guest always owns CR0.TS");
-		return -EIO;
+		val = kvm_read_cr0(vcpu);
+		/* Trace the write whether or not it is filtered, as for MOV. */
+		trace_kvm_cr_write(0, val & ~X86_CR0_TS);
+		if (vmx_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_CR0,
+					   val, val & ~X86_CR0_TS))
+			return 0;
+		/*
+		 * The guest owns CR0.TS unless a write filter on it forced
+		 * it host-owned, and the filter never reaches into vmcs02.
+		 */
+		if (KVM_BUG(is_guest_mode(vcpu) ||
+			    !(vcpu->arch.reg_write_filter[KVM_X86_REG_FILTER_CR0] &
+			      X86_CR0_TS), vcpu->kvm, "Unexpected CLTS exit"))
+			return -EIO;
+
+		err = kvm_set_cr0(vcpu, val & ~X86_CR0_TS);
+		return kvm_complete_insn_gp(vcpu, err);
 	case 1: /*mov from cr*/
 		switch (cr) {
 		case 3:
@@ -5748,6 +5841,10 @@ static int handle_cr(struct kvm_vcpu *vcpu)
 	case 3: /* lmsw */
 		val = (exit_qualification >> LMSW_SOURCE_DATA_SHIFT) & 0x0f;
 		trace_kvm_cr_write(0, (kvm_read_cr0_bits(vcpu, ~0xful) | val));
+		if (vmx_reg_write_filtered(vcpu, KVM_X86_REG_FILTER_CR0,
+					   kvm_read_cr0(vcpu),
+					   kvm_read_cr0_bits(vcpu, ~0x0eul) | val))
+			return 0;
 		kvm_lmsw(vcpu, val);
 
 		return kvm_skip_emulated_instruction(vcpu);
@@ -8648,6 +8745,10 @@ __init int vmx_hardware_setup(void)
 	kvm_caps.has_bus_lock_exit = cpu_has_vmx_bus_lock_detection();
 	kvm_caps.has_notify_vmexit = cpu_has_notify_vmexit();
 
+	/* The guest/host masks can force any CR0/CR4 bit host-owned. */
+	kvm_caps.supported_reg_write_filter |= BIT(KVM_X86_REG_FILTER_CR0) |
+					       BIT(KVM_X86_REG_FILTER_CR4);
+
 	set_bit(0, vmx_vpid_bitmap); /* 0 is reserved for host */
 
 	if (enable_ept)
diff --git a/arch/x86/kvm/vmx/vmx.h b/arch/x86/kvm/vmx/vmx.h
index 74cd50f29fa4..80b17d69f9c1 100644
--- a/arch/x86/kvm/vmx/vmx.h
+++ b/arch/x86/kvm/vmx/vmx.h
@@ -315,6 +315,7 @@ int vmx_set_efer(struct kvm_vcpu *vcpu, u64 efer);
 void vmx_set_cr0(struct kvm_vcpu *vcpu, unsigned long cr0);
 void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4);
 void set_cr4_guest_host_mask(struct vcpu_vmx *vmx);
+void vmx_refresh_reg_write_filter(struct kvm_vcpu *vcpu);
 void ept_save_pdptrs(struct kvm_vcpu *vcpu);
 void vmx_get_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
 void __vmx_set_segment(struct kvm_vcpu *vcpu, struct kvm_segment *var, int seg);
@@ -592,7 +593,7 @@ BUILD_CONTROLS_SHADOW(tertiary_exec, TERTIARY_VM_EXEC_CONTROL, 64)
 				 BIT(VCPU_REG_EXIT_INFO_1) |	\
 				 BIT(VCPU_REG_EXIT_INFO_2))
 
-static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
+static inline unsigned long vmx_guest_owned_cr0_bits(void)
 {
 	unsigned long bits = KVM_POSSIBLE_CR0_GUEST_BITS;
 
@@ -610,6 +611,17 @@ static inline unsigned long vmx_l1_guest_owned_cr0_bits(void)
 	return bits;
 }
 
+static inline unsigned long vmx_l1_guest_owned_cr0_bits(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * A write filter (KVM_X86_SET_REG_WRITE_FILTER) forces interception
+	 * of L1's writes to the filtered bits.  It covers only L1:
+	 * prepare_vmcs02() computes the nested masks without it.
+	 */
+	return vmx_guest_owned_cr0_bits() &
+	       ~vcpu->arch.reg_write_filter[KVM_X86_REG_FILTER_CR0];
+}
+
 static __always_inline struct kvm_vmx *to_kvm_vmx(struct kvm *kvm)
 {
 	return container_of(kvm, struct kvm_vmx, kvm);
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index cd72684d075d..0da766f1998f 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -45,6 +45,7 @@ int vmx_check_intercept(struct kvm_vcpu *vcpu,
 			struct x86_exception *exception);
 bool vmx_apic_init_signal_blocked(struct kvm_vcpu *vcpu);
 void vmx_migrate_timers(struct kvm_vcpu *vcpu);
+void vmx_update_reg_write_filter(struct kvm_vcpu *vcpu);
 void vmx_set_virtual_apic_mode(struct kvm_vcpu *vcpu);
 void vmx_hwapic_isr_update(struct kvm_vcpu *vcpu, int max_isr);
 int vmx_sync_pir_to_irr(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 4e6f0cb80288..7fe4b559ed73 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -760,6 +760,7 @@ bool __kvm_reg_write_filtered(struct kvm_vcpu *vcpu, u32 reg, u64 changed_bits)
 
 	return changed_bits & vcpu->arch.reg_write_filter[reg];
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(__kvm_reg_write_filtered);
 
 /*
  * KVM_RUN after KVM_EXIT_X86_REG_WRITE: userspace has performed the write,
@@ -812,6 +813,7 @@ void kvm_reg_write_user_space(struct kvm_vcpu *vcpu, u32 reg, u64 old_value,
 	kvm_fill_reg_write_exit(vcpu, reg, old_value, new_value, insn_len);
 	vcpu->arch.complete_userspace_io = complete_fast_reg_write;
 }
+EXPORT_SYMBOL_FOR_KVM_INTERNAL(kvm_reg_write_user_space);
 
 int kvm_emulate_xsetbv(struct kvm_vcpu *vcpu, u8 insn_len)
 {
@@ -906,6 +908,7 @@ int kvm_vcpu_ioctl_set_reg_write_filter(struct kvm_vcpu *vcpu,
 	else
 		vcpu->arch.reg_write_filter_armed &= ~BIT(filter->reg);
 
+	kvm_x86_call(update_reg_write_filter)(vcpu);
 	return 0;
 }
 
-- 
2.50.1

