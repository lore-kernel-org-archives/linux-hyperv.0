Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C633490BE8;
	Sat, 17 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239913; cv=none; b=qaffX8zjNFEs6AAA/clYQtKf8Yej04V/Fr+TOVV1GIMw2KeZYj25GP6AL2CU/0TQbd6GE8ZnIaCcycypoN5+7NqJv2okk0+8RPciplHkzExJfllWVHY7YyEWJM20IyZMuQIO/lqxqOiE6t5e1VRZR2bvLMSFaQHnXpyJjzbkE2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239913; c=relaxed/simple;
	bh=veUKksC2KzV2hirB18b4Do+WPZVfYQNBXv6XtFIMr18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PzF2DfzialmaBaNcd2kU0YkHZJ2S0t4biG/V37/eBnBDe4ElQVjFb2ZeqaXMW+id3onyic1uCv+1B67EiwDpP38ra5xJRORD48Dk4H1qFRTgYRjnNx4Hc/wDE9jeMDAu8sStm0E1zX2oPxc37v+bN2hV/ti/L0YdX/a5E2pvgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yh9IWBxS; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yh9IWBxS"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=INTbMeKlH+AchlfMmG/huX4mv14ySpFVRKOetdw8bb4=; b=Yh9IWBxShFNQCBCzbOCRv9NfPx
	xJw/X2RDkOliAEq/XiI87ibEVLysyOZ0+F/gUT6eROU10w1rSdDF2W0Py/VklUVnXemaWL8njXKWB
	nvci/Cg21eWxuK0dPIyo9iqM4i6PZPckRxvjJQ2zX/SNR8p+bq7A0f/YW3dAAXm1AXIFnQ132LqKY
	KrVKhtnlBL6UamXl3MwQnT4Iuhj3aWrOxkgU8s3Geeu/3chTrhkmYtoaGVcqny8cTiQ5l09SEEfxB
	fBExwqxQwjSonBxGGPnM8hZH3jjBNjzOZH+eG8wATSOkBwh6nZEYNgmdMenc5+NQQioHyaoiDiVKK
	s9SpPTEQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVEM-1nXS;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002YoL-0zX8;
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
Subject: [RFC PATCH 50/55] KVM: SVM: Trap descriptor-table loads for VTL register intercepts
Date: Sat, 17 Oct 2026 13:24:56 +0100
Message-ID: <20261017122501.610248-51-dwmw2@infradead.org>
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

A higher VTL arms register intercepts on IDTR/GDTR/LDTR/TR writes
(KVM_CAP_HYPERV_REG_INTERCEPT), and the emulator diverts an
intercepted load into a KVM_EXIT_HYPERV_REG_INTERCEPT exit instead of
applying it (hv_divert_dt_write()).  Only VMX armed the hardware exits
(SECONDARY_EXEC_DESC), so on AMD a VTL0 lidt/lgdt/lldt/ltr executed
unintercepted and the higher VTL never received its register intercept
messages: some twenty hyperv_vsm KUT register-intercept tests fail,
and a VTL1 that relies on the intercepts for kernel patch protection
silently loses them.

Arm the four VMCB descriptor-table load intercepts whenever
reg_intercept_control is non-zero, mirroring the all-or-nothing VMX
control, and route the exits into kvm_emulate_instruction(): a load
the divert check declines is applied by the emulator as before.
Store intercepts stay untrapped; the control has no bits for them.

The (dis)arming gets a dedicated kvm_x86_ops.update_hv_reg_intercepts()
op touching only the L1 controls, instead of riding on hooks with
lifecycles of their own: vmx_set_cr4() owned SECONDARY_EXEC_DESC for
UMIP emulation and a VTL0 set-then-clear of CR4.UMIP disarmed the very
lidt/lgdt trap hv_divert_dt_write() exists to catch; enabling the cap
through vcpu_after_set_cpuid() after an exit from L2 rewrote vmcs02
state that the next nested VM-exit threw away.  On VMX the op defers
while vmcs02 is loaded and nested_vmx_vmexit() refreshes vmcs01 after
switching back; on SVM it arms vmcb01, and
nested_vmcb02_recalc_intercepts() strips the LOAD_* bits from vmcb02
unless vmcb12 wants them, matching the VMX DESC strip.  The CR4 path
preserves the control while the intercepts are armed, and
hv_divert_dt_write() bails in guest mode so an L2 descriptor exit
which still reaches the emulator (UMIP emulation, for example) applies
the load normally.

Arming is refused with -EINVAL on SEV guests, failing KVM_ENABLE_CAP
before anything is armed (disarming still succeeds): the diverted
load needs full emulation, which encrypted guests cannot have.  On
SEV-ES desc_interception() hits svm_check_emulate_instruction()
returning X86EMUL_RETRY_INSTR, resuming at the same RIP with the
intercept still armed, so one descriptor-table load spins a vCPU (and
a host CPU) forever; on plain SEV the emulator has no instruction
bytes and injects #UD on an architecturally valid lgdt.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 arch/x86/include/asm/kvm-x86-ops.h |  1 +
 arch/x86/include/asm/kvm_host.h    |  7 ++++
 arch/x86/kvm/hyperv.h              | 16 ++++++++
 arch/x86/kvm/svm/nested.c          | 16 ++++++++
 arch/x86/kvm/svm/svm.c             | 66 ++++++++++++++++++++++++++++++
 arch/x86/kvm/vmx/main.c            | 10 +++++
 arch/x86/kvm/vmx/nested.c          |  1 +
 arch/x86/kvm/vmx/vmx.c             | 65 ++++++++++++++++++++++-------
 arch/x86/kvm/vmx/x86_ops.h         |  1 +
 arch/x86/kvm/x86.c                 | 19 ++++++---
 10 files changed, 183 insertions(+), 19 deletions(-)

diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index 4f96090c04c9..428daf81f258 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -140,6 +140,7 @@ KVM_X86_OP(get_feature_msr)
 KVM_X86_OP(check_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
 KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
+KVM_X86_OP(update_hv_reg_intercepts)
 KVM_X86_OP_OPTIONAL(migrate_timers)
 KVM_X86_OP(recalc_intercepts)
 KVM_X86_OP(complete_emulated_msr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index e03ae6493641..cf36baceaabc 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -2109,6 +2109,13 @@ struct kvm_x86_ops {
 	bool (*apic_init_signal_blocked)(struct kvm_vcpu *vcpu);
 	int (*enable_l2_tlb_flush)(struct kvm_vcpu *vcpu);
 
+	/*
+	 * Bring the L1 (vmcs01/vmcb01) descriptor-table intercepts in line
+	 * with hv_vcpu->reg_intercept_control.  Never touches L2 controls;
+	 * safe to call at any point, including with a vCPU in guest mode.
+	 */
+	int (*update_hv_reg_intercepts)(struct kvm_vcpu *vcpu);
+
 	void (*migrate_timers)(struct kvm_vcpu *vcpu);
 	void (*recalc_intercepts)(struct kvm_vcpu *vcpu);
 	int (*complete_emulated_msr)(struct kvm_vcpu *vcpu, int err);
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 5ba2bb2e649b..810055c71301 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -237,6 +237,18 @@ static inline bool kvm_hv_vcpu_suspended(struct kvm_vcpu *vcpu)
 	       READ_ONCE(vcpu->arch.hyperv->suspended);
 }
 
+/*
+ * True when a higher VTL armed descriptor-table write intercepts
+ * (HvRegisterCrInterceptControl) on this vCPU, i.e. when the vendor code
+ * must trap the L1 guest's descriptor-table loads for hv_divert_dt_write().
+ */
+static inline bool kvm_hv_dt_intercepts_armed(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	return hv_vcpu && hv_vcpu->reg_intercept_control;
+}
+
 static inline bool kvm_hv_is_tlb_flush_hcall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -328,6 +340,10 @@ static inline int kvm_hv_verify_vp_assist(struct kvm_vcpu *vcpu)
 {
 	return 0;
 }
+static inline bool kvm_hv_dt_intercepts_armed(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
 static inline u32 kvm_hv_get_vpindex(struct kvm_vcpu *vcpu)
 {
 	return vcpu->vcpu_idx;
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index b340dc9991ad..09b57ea115b0 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -156,6 +156,22 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
 	for (i = 0; i < MAX_INTERCEPT; i++)
 		vmcb02->control.intercepts[i] |= vmcb12_ctrl->intercepts[i];
 
+	/*
+	 * KVM arms the descriptor-table load intercepts in vmcb01 to divert
+	 * L1's loads into Hyper-V register-intercept exits (see
+	 * hv_divert_dt_write()); they do not apply to L2.  Drop them from
+	 * vmcb02 unless L1 wants the intercept itself, matching the
+	 * SECONDARY_EXEC_DESC strip in VMX's prepare_vmcs02().
+	 */
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_IDTR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_IDTR);
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_GDTR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_GDTR);
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_LDTR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_LDTR);
+	if (!vmcb12_is_intercept(vmcb12_ctrl, INTERCEPT_LOAD_TR))
+		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_LOAD_TR);
+
 	/* If SMI is not intercepted, ignore guest SMI intercept as well  */
 	if (!intercept_smi)
 		vmcb_clr_intercept(&vmcb02->control, INTERCEPT_SMI);
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index a30f6f888b51..42a12f2ad612 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -2084,6 +2084,17 @@ static int npf_interception(struct kvm_vcpu *vcpu)
 	return rc;
 }
 
+static int desc_interception(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * Descriptor-table write exits are armed only while a higher VTL
+	 * has register intercepts on them (reg_intercept_control); the
+	 * emulator diverts the write into a register-intercept exit via
+	 * hv_divert_dt_write() instead of applying it.
+	 */
+	return kvm_emulate_instruction(vcpu, 0);
+}
+
 static int db_interception(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *kvm_run = vcpu->run;
@@ -3365,6 +3376,10 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
 	[SVM_EXIT_WRITE_CR3]			= cr_interception,
 	[SVM_EXIT_WRITE_CR4]			= cr_interception,
 	[SVM_EXIT_WRITE_CR8]			= cr8_write_interception,
+	[SVM_EXIT_IDTR_WRITE]			= desc_interception,
+	[SVM_EXIT_GDTR_WRITE]			= desc_interception,
+	[SVM_EXIT_LDTR_WRITE]			= desc_interception,
+	[SVM_EXIT_TR_WRITE]			= desc_interception,
 	[SVM_EXIT_READ_DR0]			= dr_interception,
 	[SVM_EXIT_READ_DR1]			= dr_interception,
 	[SVM_EXIT_READ_DR2]			= dr_interception,
@@ -4758,6 +4773,49 @@ static bool svm_has_emulated_msr(struct kvm *kvm, u32 index)
 	return true;
 }
 
+static int svm_update_hv_reg_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_svm *svm = to_svm(vcpu);
+
+	/*
+	 * Trap descriptor-table loads while a higher VTL has register
+	 * intercepts armed on them (reg_intercept_control), and stop
+	 * trapping when they are disarmed; the emulator diverts a trapped
+	 * load into a register-intercept exit (hv_divert_dt_write()).
+	 * VMX arms the all-or-nothing SECONDARY_EXEC_DESC; the SVM
+	 * intercepts are per-register but armed as a block to match, and
+	 * an exit the emulator does not divert applies the load normally.
+	 *
+	 * The intercepts are armed in vmcb01 only: an L2 descriptor load
+	 * is never diverted, and nested_vmcb02_recalc_intercepts() keeps
+	 * these bits out of vmcb02 unless L1 asked for them itself.
+	 */
+	if (kvm_hv_dt_intercepts_armed(vcpu)) {
+		/*
+		 * The diverted load needs full emulation, which encrypted
+		 * guests cannot have: on SEV-ES and SNP the emulator cannot
+		 * read the registers, so svm_check_emulate_instruction()
+		 * retries at the same RIP with the intercept still armed and
+		 * every descriptor-table load livelocks the vCPU; on plain
+		 * SEV there are no instruction bytes to decode and a valid
+		 * lgdt takes a spurious #UD.  Refuse to arm.
+		 */
+		if (is_sev_guest(vcpu))
+			return -EINVAL;
+
+		svm_set_intercept(svm, INTERCEPT_LOAD_IDTR);
+		svm_set_intercept(svm, INTERCEPT_LOAD_GDTR);
+		svm_set_intercept(svm, INTERCEPT_LOAD_LDTR);
+		svm_set_intercept(svm, INTERCEPT_LOAD_TR);
+	} else {
+		svm_clr_intercept(svm, INTERCEPT_LOAD_IDTR);
+		svm_clr_intercept(svm, INTERCEPT_LOAD_GDTR);
+		svm_clr_intercept(svm, INTERCEPT_LOAD_LDTR);
+		svm_clr_intercept(svm, INTERCEPT_LOAD_TR);
+	}
+	return 0;
+}
+
 static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -4784,6 +4842,13 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu->common, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	/*
+	 * Re-arm the descriptor-table intercepts; setting guest CPUID does
+	 * not change reg_intercept_control, but keep the controls in sync
+	 * the same way vmx_vcpu_after_set_cpuid() does.
+	 */
+	svm_update_hv_reg_intercepts(vcpu);
+
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
@@ -5538,6 +5603,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
 
 	.recalc_intercepts = svm_recalc_intercepts,
+	.update_hv_reg_intercepts = svm_update_hv_reg_intercepts,
 	.complete_emulated_msr = svm_complete_emulated_msr,
 
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 81a8d398068b..24663bfc14b8 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -207,6 +207,15 @@ static void vt_recalc_intercepts(struct kvm_vcpu *vcpu)
 	vmx_recalc_intercepts(vcpu);
 }
 
+static int vt_update_hv_reg_intercepts(struct kvm_vcpu *vcpu)
+{
+	/* TDX doesn't allow descriptor-table loads to be intercepted. */
+	if (is_td_vcpu(vcpu))
+		return -EINVAL;
+
+	return vmx_update_hv_reg_intercepts(vcpu);
+}
+
 static int vt_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 {
 	if (is_td_vcpu(vcpu))
@@ -1018,6 +1027,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.check_emulate_instruction = vt_op(check_emulate_instruction),
 	.apic_init_signal_blocked = vt_op(apic_init_signal_blocked),
+	.update_hv_reg_intercepts = vt_op(update_hv_reg_intercepts),
 	.migrate_timers = vmx_migrate_timers,
 
 	.recalc_intercepts = vt_op(recalc_intercepts),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index 3fe88f29be7a..de5d72502e70 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5142,6 +5142,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	 * Update any VMCS fields that might have changed while vmcs02 was the
 	 * active VMCS.  The tracking is per-vCPU, not per-VMCS.
 	 */
+	vmx_update_hv_reg_intercepts(vcpu);
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, vmx->msr_autostore.nr);
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ec50e46404af..bc5b08ebaefb 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3535,6 +3535,42 @@ bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 	return true;
 }
 
+/*
+ * SECONDARY_EXEC_DESC has two consumers: UMIP emulation (descriptor-table
+ * reads must #GP when CR4.UMIP is set and the CPU cannot do it) and the
+ * Hyper-V VTL register intercepts (descriptor-table writes divert into
+ * KVM_EXIT_HYPERV_REG_INTERCEPT, see hv_divert_dt_write()).  Every arm or
+ * disarm of the control for one consumer must preserve the other's claim.
+ */
+static bool vmx_need_desc_exiting(struct kvm_vcpu *vcpu)
+{
+	return (vmx_umip_emulated() &&
+		kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP)) ||
+	       kvm_hv_dt_intercepts_armed(vcpu);
+}
+
+int vmx_update_hv_reg_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct vcpu_vmx *vmx = to_vmx(vcpu);
+
+	if (!(vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_DESC))
+		return 0;
+
+	/*
+	 * Only vmcs01 carries the register intercepts: prepare_vmcs02()
+	 * strips SECONDARY_EXEC_DESC unless vmcs12 or L2's UMIP emulation
+	 * wants it, so an L2 descriptor load is never diverted.  While
+	 * vmcs02 is loaded, leave it alone; nested_vmx_vmexit() refreshes
+	 * vmcs01 after switching back.
+	 */
+	if (vmx->loaded_vmcs != &vmx->vmcs01)
+		return 0;
+
+	secondary_exec_controls_changebit(vmx, SECONDARY_EXEC_DESC,
+					  vmx_need_desc_exiting(vcpu));
+	return 0;
+}
+
 void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 {
 	unsigned long old_cr4 = kvm_read_cr4(vcpu);
@@ -3558,8 +3594,16 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
 		if (cr4 & X86_CR4_UMIP) {
 			secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_DESC);
 			hw_cr4 &= ~X86_CR4_UMIP;
-		} else if (!is_guest_mode(vcpu) ||
-			!nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_DESC)) {
+		} else if (is_guest_mode(vcpu)) {
+			if (!nested_cpu_has2(get_vmcs12(vcpu), SECONDARY_EXEC_DESC))
+				secondary_exec_controls_clearbit(vmx,
+								 SECONDARY_EXEC_DESC);
+		} else if (!kvm_hv_dt_intercepts_armed(vcpu)) {
+			/*
+			 * Clearing CR4.UMIP must not disarm the control
+			 * while a higher VTL holds register intercepts on
+			 * the descriptor tables.
+			 */
 			secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_DESC);
 		}
 	}
@@ -5648,7 +5692,7 @@ static int handle_desc(struct kvm_vcpu *vcpu)
 	 * SECONDARY_EXEC_DESC control.
 	 */
 	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP) &&
-		     !(to_hv_vcpu(vcpu) && to_hv_vcpu(vcpu)->reg_intercept_control));
+		     !kvm_hv_dt_intercepts_armed(vcpu));
 	return kvm_emulate_instruction(vcpu, 0);
 }
 
@@ -8105,18 +8149,11 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	vmx_update_exception_bitmap(vcpu);
 
 	/*
-	 * Trap descriptor-table instructions when a higher VTL armed
-	 * register intercepts on them, and stop trapping when the
-	 * intercepts are disarmed.  Preserve the control when UMIP
-	 * emulation needs it (CR4.UMIP owns it then).
+	 * Setting the secondary exec controls above recomputed them from
+	 * scratch; re-arm descriptor-table exiting for the VTL register
+	 * intercepts and UMIP emulation.
 	 */
-	if (vmcs_config.cpu_based_2nd_exec_ctrl & SECONDARY_EXEC_DESC) {
-		if (to_hv_vcpu(vcpu) && to_hv_vcpu(vcpu)->reg_intercept_control)
-			secondary_exec_controls_setbit(vmx, SECONDARY_EXEC_DESC);
-		else if (!(vmx_umip_emulated() &&
-			   kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP)))
-			secondary_exec_controls_clearbit(vmx, SECONDARY_EXEC_DESC);
-	}
+	vmx_update_hv_reg_intercepts(vcpu);
 }
 
 static __init u64 vmx_get_perf_capabilities(void)
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index b75dfe7f039d..10db312faa8e 100644
--- a/arch/x86/kvm/vmx/x86_ops.h
+++ b/arch/x86/kvm/vmx/x86_ops.h
@@ -53,6 +53,7 @@ void vmx_deliver_interrupt(struct kvm_lapic *apic, int delivery_mode,
 void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu);
 bool vmx_has_emulated_msr(struct kvm *kvm, u32 index);
 void vmx_recalc_intercepts(struct kvm_vcpu *vcpu);
+int vmx_update_hv_reg_intercepts(struct kvm_vcpu *vcpu);
 void vmx_prepare_switch_to_guest(struct kvm_vcpu *vcpu);
 void vmx_update_exception_bitmap(struct kvm_vcpu *vcpu);
 int vmx_get_feature_msr(u32 msr, u64 *data);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index e2e54f06b092..5190aa7025e3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -6222,9 +6222,16 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			return r;
 		hv_vcpu = to_hv_vcpu(vcpu);
 		hv_vcpu->reg_intercept_control = cap->args[0];
-		/* Refresh the descriptor-table exiting controls. */
-		kvm_x86_call(vcpu_after_set_cpuid)(vcpu);
-		return 0;
+		/*
+		 * Refresh the descriptor-table exiting controls.  The vendor
+		 * op touches only the L1 controls, so it is safe here even
+		 * when the vCPU last exited from a nested guest and
+		 * vcpu_load() restored vmcs02/vmcb02.
+		 */
+		r = kvm_x86_call(update_hv_reg_intercepts)(vcpu);
+		if (r)
+			hv_vcpu->reg_intercept_control = 0;
+		return r;
 	}
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 		if (!kvm_x86_ops.enable_l2_tlb_flush)
@@ -8900,7 +8907,9 @@ static void emulator_get_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 /*
  * Divert a descriptor-table write into a register-intercept exit when the
  * higher VTL armed one: the write is not applied, and userspace delivers
- * the TLFS register-intercept message to the higher VTL.
+ * the TLFS register-intercept message to the higher VTL.  The intercept
+ * contract covers only the L1 guest; a descriptor load emulated on behalf
+ * of a nested (L2) guest, however its exit arrived, is applied normally.
  */
 static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 			       const struct desc_ptr *dt, u64 ctl_bit)
@@ -8909,7 +8918,7 @@ static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
 	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
-	if (!hv_vcpu || vcpu->plane_level ||
+	if (!hv_vcpu || vcpu->plane_level || is_guest_mode(vcpu) ||
 	    !(hv_vcpu->reg_intercept_control & ctl_bit))
 		return false;
 
-- 
2.50.1

