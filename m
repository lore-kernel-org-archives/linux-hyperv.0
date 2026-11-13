Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594895;
	b=uOGBnlhWZZScBjQEGmzP++CONDuY09eY9ltkB0mv5pNGWDGluVJ45P4HveC12fE8HnYU
	 tkivqy4dyJvSzNJqozN1U6Q9R0EnD8OUSdlJbEohBVuZT4Q8hoodVI542RF+DiyT0ddtS
	 5eqIxciqsNueZ34OhrYq7IhfdPHKBO5I3lDVpW0RNwLXKTPvuEyUHm4Wo449kTTLU0x97
	 f0Q/+iBBkC+QlzF3U6n//5Nt2d/5vsyOztmZueFSqkWoRQeTERr6ct2tBjyam/d1ZhRMv
	 zNGyARnzV2zhpdYycacCABZOsea27i7SoMwgi9cLl5I6p1Umw6cGzmOA6MRZl4e+i2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=UtOAbCpBWQG/gnr5MalsDCFvRw4xx7ZZSs5JKgN0uV4=;
	b=C+ISuqHrbkfQApDtycSUrHggpR3+WpS0oW3NKl2r/RfmhVL74yJI8NknQotc+G01hXgR
	 H9raFGqueFB9gSbu+dNRWacxWThVTXqq0xKwC9er++PfZ7/b805eaPjkd+xvUPxZSFFF1
	 jfpiyxXl5maYeYU8Cb0Tl/ivHck5OoUwkMG0VxT2PWYjZ5upw/xco8DwgKpUUdXvdlhqz
	 E3JxRbdFuXa2hOK+y5GzErWWk90tyJqHRE8br0AeKDiJrIQzuW2ZO9IKWudBzKRtQx7i6
	 gq58nEay77eSXeY6Du+qXXzTa++0VEyZaIC+U2bls/IMzHuwQxPFPugIxrglCz4YJzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Xyps9gOf;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A9360A5BC8;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B5A9360A5BC8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=Xyps9gOf
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=UtOAbCpBWQG/gnr5MalsDCFvRw4xx7ZZSs5JKgN0uV4=; b=Xyps9gOfP49PNqVODCskiK4S90
	/3FDAFDz5WhUajvtjev3I5w1ViZMBJqlfxjGN8lbIMehHxTY/jEnZIMjiT6ARXdC8eTNozF41CUWy
	uS6iLFdACHX2uxT3vLYHY2vVHNPI+fT97aiH9J1QKj80t6SeA4cRF/6HNJ4dr8m4Ujas96/YXqtTW
	sKpCZf4jNGoFtqVX0NphqsqiHTmrJmoWJH5G5NPuWncqv6+SFSJ2bpQeXWew9zjZrBF1rq4N/jecj
	Y1J/xWejo9HVPwm3ltjCNQN5Ctx78LZvA36q5jTAzW51XiSf5TJMoUlyR1W/zbFcgdJmxTUVZL6YW
	1qRI3voQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bf00-3AzK;
	Fri, 13 Nov 2026 18:34:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lt5-2prL;
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
Subject: [RFC PATCH v2 09/31] KVM: x86: hyperv: Divert intercepted descriptor-table loads
Date: Fri, 13 Nov 2026 18:34:25 +0000
Message-ID: <20261113183448.84094-10-dwmw2@infradead.org>
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

The secure kernel arms descriptor-table write intercepts for VTL0 with
HvRegisterCrInterceptControl, and PatchGuard then runs its protected
patching window under an intercepted LIDT. The write must not be
applied: the window would run with a genuinely null IDT and the first
event triple-faults the guest. KVM has no notion of the intercept, so
it loads the IDT.

Add a per-vCPU KVM_CAP_HYPERV_REG_INTERCEPT through which the VMM sets
the control word. While a descriptor-table write bit is armed, the
vendor code traps descriptor-table loads, and the emulator diverts an
armed LGDT or LIDT executed in plane 0 into a
KVM_EXIT_HYPERV_REG_INTERCEPT exit instead of applying it. The exit
carries the HV_X64_REGISTER_* id, the base and limit the guest tried to
load, and the RIP and length of the instruction. RIP is rewound to the
instruction: the higher VTL owns completion, and Windows'
patch-protection probe matches its reflected #GP(0) against the probe
RIP. The diverted write is consumed before x86_emulate_instruction()
returns, so it never outlives the emulation.

api.rst documents the exit and its reg_intercept payload.

VMX traps with SECONDARY_EXEC_DESC; SVM arms the four VMCB
descriptor-table load intercepts as a block to match the all-or-nothing
VMX control, and routes the exits into kvm_emulate_instruction(). A
load the divert check declines is applied by the emulator as before.
Store intercepts stay untrapped, as the control has no bits for them.

The (dis)arming gets its own kvm_x86_ops.update_hv_reg_intercepts(),
touching only the L1 controls, rather than riding on hooks with
lifecycles of their own:

 - vmx_set_cr4() owns SECONDARY_EXEC_DESC for UMIP emulation, so a
   VTL0 set-then-clear of CR4.UMIP would disarm the very lidt/lgdt trap
   this exists for. The CR4 path preserves the control while the
   intercepts are armed.
 - On VMX the op defers while vmcs02 is loaded, and nested_vmx_vmexit()
   refreshes vmcs01 after switching back, rather than writing vmcs02
   state that the next nested VM-exit would throw away.
 - On SVM it arms vmcb01, and nested_vmcb02_recalc_intercepts() strips
   the LOAD_* bits from vmcb02 unless vmcb12 wants them, matching the
   VMX DESC strip. hv_divert_dt_write() bails in guest mode, so an L2
   descriptor exit that still reaches the emulator (UMIP emulation,
   for example) applies the load normally.
 - init_vmcb() re-applies the SVM intercepts, since reg_intercept_control
   survives a vCPU reset: a guest SHUTDOWN clears the VMCB and resets
   the vCPU, and must not leave them disarmed behind the higher VTL's
   back.

Arming is refused with -EINVAL where the diverted load cannot be
emulated, before anything is armed; disarming always succeeds:

 - TDX does not allow descriptor-table loads to be intercepted.
 - On SEV-ES, desc_interception() hits svm_check_emulate_instruction()
   returning X86EMUL_RETRY_INSTR, which resumes at the same RIP with
   the intercept still armed, so one descriptor-table load would spin a
   vCPU (and a host CPU) forever.
 - On plain SEV, the emulator has no instruction bytes and would inject
   #UD on an architecturally valid lgdt.

For the same reason KVM_CAP_VM_MOVE_ENC_CONTEXT_FROM refuses to turn a
VM into an SEV guest while any of its vCPUs has the intercepts armed;
the VMM can disarm first. A failure to re-apply the intercepts after
that is a broken invariant, so svm_vcpu_after_set_cpuid() and
init_vmcb() warn and disarm rather than leave reg_intercept_control
claiming intercepts the VMCB does not have.

The cap stays refused on plane fds, like the other unaudited vCPU caps:
the divert only ever applies to plane 0.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst     |  19 +++++
 arch/x86/include/asm/kvm-x86-ops.h |   1 +
 arch/x86/include/asm/kvm_host.h    |   7 ++
 arch/x86/kvm/hyperv.h              |  40 ++++++++++
 arch/x86/kvm/svm/nested.c          |  16 ++++
 arch/x86/kvm/svm/sev.c             |  24 ++++++
 arch/x86/kvm/svm/svm.c             |  90 ++++++++++++++++++++++
 arch/x86/kvm/vmx/main.c            |  13 ++++
 arch/x86/kvm/vmx/nested.c          |   1 +
 arch/x86/kvm/vmx/vmx.c             |  65 +++++++++++++++-
 arch/x86/kvm/vmx/x86_ops.h         |   1 +
 arch/x86/kvm/x86.c                 | 120 ++++++++++++++++++++++++++++-
 include/uapi/linux/kvm.h           |  11 +++
 13 files changed, 401 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index b76c46cc5000..83daee450284 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7448,6 +7448,7 @@ EOI was received.
   #define KVM_EXIT_HYPERV_HCALL          2
   #define KVM_EXIT_HYPERV_SYNDBG         3
   #define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+  #define KVM_EXIT_HYPERV_REG_INTERCEPT  5
 			__u32 type;
 			__u32 plane;
 			union {
@@ -7465,6 +7466,15 @@ EOI was received.
   #define KVM_HYPERV_HCALL_UD		(1ULL << 0)
 					__u64 flags;
 				} hcall;
+				struct {
+					__u32 reg;
+					__u8 insn_len;
+					__u8 pad[3];
+					__u64 base;
+					__u32 limit;
+					__u32 pad2;
+					__u64 rip;
+				} reg_intercept;
 				struct {
 					__u32 msr;
 					__u32 pad2;
@@ -7534,6 +7544,15 @@ single-shot: if the VMM declines the entry, the event waits in the
 target plane for a cooperative entry rather than re-triggering the
 exit.
 
+	- KVM_EXIT_HYPERV_REG_INTERCEPT -- a descriptor-table write that a
+
+higher plane intercepted (KVM_CAP_HYPERV_REG_INTERCEPT) has been
+diverted to userspace instead of being applied.  'reg_intercept'
+carries the HV_X64_REGISTER_* id of the written register, the
+descriptor-table base and limit the guest tried to load, and the RIP
+and length of the writing instruction.  The vCPU's RIP has been
+rewound to that instruction; the higher plane owns its completion.
+
 ::
 
 		/* KVM_EXIT_ARM_NISV / KVM_EXIT_ARM_LDST64B */
diff --git a/arch/x86/include/asm/kvm-x86-ops.h b/arch/x86/include/asm/kvm-x86-ops.h
index c50d7ba07ff4..1b56c290c412 100644
--- a/arch/x86/include/asm/kvm-x86-ops.h
+++ b/arch/x86/include/asm/kvm-x86-ops.h
@@ -143,6 +143,7 @@ KVM_X86_OP(get_feature_msr)
 KVM_X86_OP(check_emulate_instruction)
 KVM_X86_OP(apic_init_signal_blocked)
 KVM_X86_OP_OPTIONAL(enable_l2_tlb_flush)
+KVM_X86_OP(update_hv_reg_intercepts)
 KVM_X86_OP_OPTIONAL(migrate_timers)
 KVM_X86_OP(recalc_intercepts)
 KVM_X86_OP(complete_emulated_msr)
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 74899a27e29e..fe8fddab6039 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1803,6 +1803,13 @@ struct kvm_x86_ops {
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
index fbfbe0d52f9c..069c59788bf6 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -116,6 +116,21 @@ struct kvm_vcpu_hv {
 		u32 vp_id;
 	} nested;
 
+	/*
+	 * HvRegisterCrInterceptControl value the higher VTL armed for the
+	 * lower VTL (userspace VSM): descriptor-table write bits divert
+	 * the emulated write into a KVM_EXIT_HYPERV_REG_INTERCEPT exit.
+	 */
+	u64 reg_intercept_control;
+	struct {
+		u32 reg;
+		u8 insn_len;
+		bool pending;
+		u64 base;
+		u32 limit;
+		u64 rip;
+	} reg_intercept;
+
 	/*
 	 * RAX/RCX of the lower VTL captured at VTL entry, restored on a
 	 * non-fast VTL return when this plane has no VP assist page to
@@ -197,6 +212,26 @@ static inline struct kvm_vcpu_hv *to_hv_vcpu(struct kvm_vcpu *vcpu)
 	return vcpu->arch.hyperv;
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
+static inline void kvm_hv_disarm_dt_intercepts(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	if (hv_vcpu)
+		hv_vcpu->reg_intercept_control = 0;
+}
+
 static inline struct kvm_vcpu_hv_synic *to_hv_synic(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -434,6 +469,11 @@ static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
 {
 	return false;
 }
+static inline bool kvm_hv_dt_intercepts_armed(struct kvm_vcpu *vcpu)
+{
+	return false;
+}
+static inline void kvm_hv_disarm_dt_intercepts(struct kvm_vcpu *vcpu) {}
 static inline void kvm_hv_setup_tsc_page(struct kvm *kvm,
 					 struct pvclock_vcpu_time_info *hv_clock) {}
 static inline void kvm_hv_request_tsc_page_update(struct kvm *kvm) {}
diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index 75b02a84f2df..1836828436a9 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -172,6 +172,22 @@ void nested_vmcb02_recalc_intercepts(struct vcpu_svm *svm)
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
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a63822defc3b..79e78c7f56b3 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -35,6 +35,7 @@
 #include "svm.h"
 #include "svm_ops.h"
 #include "cpuid.h"
+#include "hyperv.h"
 #include "trace.h"
 #include "lapic.h"
 
@@ -2161,6 +2162,25 @@ static int sev_check_source_vcpus(struct kvm *dst, struct kvm *src)
 	return 0;
 }
 
+/*
+ * The destination becomes an SEV guest, which cannot have the Hyper-V
+ * descriptor-table register intercepts (svm_update_hv_reg_intercepts()
+ * refuses to arm them).  Refuse the move while any destination vCPU has
+ * them armed; the VMM can disarm first.
+ */
+static int sev_check_dest_reg_intercepts(struct kvm *dst)
+{
+	struct kvm_vcpu *vcpu;
+	unsigned long i;
+
+	kvm_for_each_vcpu(i, vcpu, dst) {
+		if (kvm_hv_dt_intercepts_armed(vcpu))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
 int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 {
 	struct kvm_sev_info *dst_sev = to_kvm_sev_info(kvm);
@@ -2210,6 +2230,10 @@ int sev_vm_move_enc_context_from(struct kvm *kvm, unsigned int source_fd)
 	if (ret)
 		goto out_source_vcpu;
 
+	ret = sev_check_dest_reg_intercepts(kvm);
+	if (ret)
+		goto out_source_vcpu;
+
 	/*
 	 * Allocate a new have_run_cpus for the destination, i.e. don't copy
 	 * the set of CPUs from the source.  If a CPU was used to run a vCPU in
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 5f07ddfafca4..b87c12944108 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -1142,6 +1142,65 @@ static void svm_recalc_intercepts(struct kvm_vcpu *vcpu)
 	svm_recalc_msr_intercepts(vcpu);
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
+/*
+ * Re-apply the descriptor-table intercepts from reg_intercept_control.
+ * Arming is refused up front for guests that cannot have it (the
+ * enable-cap and sev_vm_move_enc_context_from() both check), so a failure
+ * here is a broken invariant: disarm, rather than leave the controls and
+ * reg_intercept_control disagreeing.
+ */
+static void svm_refresh_hv_reg_intercepts(struct kvm_vcpu *vcpu)
+{
+	if (!WARN_ON_ONCE(svm_update_hv_reg_intercepts(vcpu)))
+		return;
+
+	kvm_hv_disarm_dt_intercepts(vcpu);
+	svm_update_hv_reg_intercepts(vcpu);
+}
+
 static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 {
 	struct vcpu_svm *svm = to_svm(vcpu);
@@ -1308,6 +1367,14 @@ static void init_vmcb(struct kvm_vcpu *vcpu, bool init_event)
 
 	svm_hv_init_vmcb(vmcb);
 
+	/*
+	 * The descriptor-table intercepts follow reg_intercept_control,
+	 * which a reset does not touch: re-apply them, or a SHUTDOWN (which
+	 * clears the VMCB and resets the vCPU) leaves them disarmed while
+	 * the higher VTL still believes them armed.
+	 */
+	svm_refresh_hv_reg_intercepts(vcpu);
+
 	kvm_make_request(KVM_REQ_RECALC_INTERCEPTS, vcpu);
 
 	vmcb_mark_all_dirty(vmcb);
@@ -2087,6 +2154,17 @@ static int npf_interception(struct kvm_vcpu *vcpu)
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
@@ -3461,6 +3539,10 @@ static int (*const svm_exit_handlers[])(struct kvm_vcpu *vcpu) = {
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
@@ -4931,6 +5013,13 @@ static void svm_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 	if (guest_cpuid_is_intel_compatible(vcpu))
 		guest_cpu_cap_clear(vcpu->common, X86_FEATURE_V_VMSAVE_VMLOAD);
 
+	/*
+	 * Re-arm the descriptor-table intercepts; setting guest CPUID does
+	 * not change reg_intercept_control, but keep the controls in sync
+	 * the same way vmx_vcpu_after_set_cpuid() does.
+	 */
+	svm_refresh_hv_reg_intercepts(vcpu);
+
 	if (is_sev_guest(vcpu))
 		sev_vcpu_after_set_cpuid(svm);
 }
@@ -5681,6 +5770,7 @@ struct kvm_x86_ops svm_x86_ops __initdata = {
 	.apic_init_signal_blocked = svm_apic_init_signal_blocked,
 
 	.recalc_intercepts = svm_recalc_intercepts,
+	.update_hv_reg_intercepts = svm_update_hv_reg_intercepts,
 	.complete_emulated_msr = svm_complete_emulated_msr,
 
 	.vcpu_deliver_sipi_vector = svm_vcpu_deliver_sipi_vector,
diff --git a/arch/x86/kvm/vmx/main.c b/arch/x86/kvm/vmx/main.c
index 14d21d02bff4..6efbb7062201 100644
--- a/arch/x86/kvm/vmx/main.c
+++ b/arch/x86/kvm/vmx/main.c
@@ -211,6 +211,18 @@ static void vt_recalc_intercepts(struct kvm_vcpu *vcpu)
 	vmx_recalc_intercepts(vcpu);
 }
 
+static int vt_update_hv_reg_intercepts(struct kvm_vcpu *vcpu)
+{
+	/*
+	 * TDX doesn't allow descriptor-table loads to be intercepted, so
+	 * arming fails; disarming has nothing to undo and succeeds.
+	 */
+	if (is_td_vcpu(vcpu))
+		return kvm_hv_dt_intercepts_armed(vcpu) ? -EINVAL : 0;
+
+	return vmx_update_hv_reg_intercepts(vcpu);
+}
+
 static int vt_complete_emulated_msr(struct kvm_vcpu *vcpu, int err)
 {
 	if (is_td_vcpu(vcpu))
@@ -1147,6 +1159,7 @@ struct kvm_x86_ops vt_x86_ops __initdata = {
 
 	.check_emulate_instruction = vt_op(check_emulate_instruction),
 	.apic_init_signal_blocked = vt_op(apic_init_signal_blocked),
+	.update_hv_reg_intercepts = vt_op(update_hv_reg_intercepts),
 	.migrate_timers = vmx_migrate_timers,
 
 	.recalc_intercepts = vt_op(recalc_intercepts),
diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
index c980ecf9202a..a33b6bd0e8a4 100644
--- a/arch/x86/kvm/vmx/nested.c
+++ b/arch/x86/kvm/vmx/nested.c
@@ -5177,6 +5177,7 @@ void __nested_vmx_vmexit(struct kvm_vcpu *vcpu, u32 vm_exit_reason,
 	 * Update any VMCS fields that might have changed while vmcs02 was the
 	 * active VMCS.  The tracking is per-vCPU, not per-VMCS.
 	 */
+	vmx_update_hv_reg_intercepts(vcpu);
 	vmcs_write32(VM_EXIT_MSR_STORE_COUNT, vmx->msr_autostore.nr);
 	vmcs_write32(VM_EXIT_MSR_LOAD_COUNT, vmx->msr_autoload.host.nr);
 	vmcs_write32(VM_ENTRY_MSR_LOAD_COUNT, vmx->msr_autoload.guest.nr);
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 2d85205cebb4..4e7eec9a0625 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3595,6 +3595,42 @@ bool vmx_is_valid_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
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
@@ -3618,8 +3654,16 @@ void vmx_set_cr4(struct kvm_vcpu *vcpu, unsigned long cr4)
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
@@ -5698,7 +5742,14 @@ static int handle_desc(struct kvm_vcpu *vcpu)
 	 */
 	BUILD_BUG_ON(KVM_POSSIBLE_CR4_GUEST_BITS & X86_CR4_UMIP);
 
-	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP));
+	/*
+	 * Descriptor-table exits are also armed when a higher VTL registers
+	 * DT intercepts (reg_intercept_control); only an exit with neither
+	 * UMIP emulation nor an armed intercept indicates a stale
+	 * SECONDARY_EXEC_DESC control.
+	 */
+	WARN_ON_ONCE(!kvm_is_cr4_bit_set(vcpu, X86_CR4_UMIP) &&
+		     !kvm_hv_dt_intercepts_armed(vcpu));
 	return kvm_emulate_instruction(vcpu, 0);
 }
 
@@ -7916,6 +7967,14 @@ void vmx_vcpu_after_set_cpuid(struct kvm_vcpu *vcpu)
 
 	/* Refresh #PF interception to account for MAXPHYADDR changes. */
 	vmx_update_exception_bitmap(vcpu);
+
+	/*
+	 * Bring descriptor-table exiting in line with the VTL register
+	 * intercepts and UMIP emulation.  The secondary controls set above
+	 * leave SECONDARY_EXEC_DESC alone, so this is a consistency refresh
+	 * rather than a repair.
+	 */
+	vmx_update_hv_reg_intercepts(vcpu);
 }
 
 static __init u64 vmx_get_perf_capabilities(void)
diff --git a/arch/x86/kvm/vmx/x86_ops.h b/arch/x86/kvm/vmx/x86_ops.h
index 63e7b9256152..2e1dc101a5a6 100644
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
index 0933291298e0..0fda04f6114a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2368,6 +2368,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
+	case KVM_CAP_HYPERV_REG_INTERCEPT:
 #endif
 	case KVM_CAP_HCALL_FAULT_EXIT:
 	case KVM_CAP_PCI_SEGMENT:
@@ -3501,9 +3502,10 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 	/*
 	 * KVM_ENABLE_CAP is accepted on plane vCPU fds, but only the caps
 	 * below have been audited for plane_level > 0.  The nested paths
-	 * behind eVMCS and direct TLB flush have not; refuse those rather
-	 * than implicitly extending every current and future vCPU cap to
-	 * planes.
+	 * behind eVMCS and direct TLB flush have not, and the register
+	 * intercept only ever diverts plane 0 (hv_divert_dt_write() skips
+	 * higher planes); refuse those rather than implicitly extending
+	 * every current and future vCPU cap to planes.
 	 */
 	if (vcpu->plane_level) {
 		switch (cap->cap) {
@@ -3547,6 +3549,26 @@ static int kvm_vcpu_ioctl_enable_cap(struct kvm_vcpu *vcpu,
 			}
 			return r;
 		}
+	case KVM_CAP_HYPERV_REG_INTERCEPT: {
+		struct kvm_vcpu_hv *hv_vcpu;
+		int r;
+
+		r = kvm_hv_vcpu_init(vcpu);
+		if (r)
+			return r;
+		hv_vcpu = to_hv_vcpu(vcpu);
+		hv_vcpu->reg_intercept_control = cap->args[0];
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
+	}
 	case KVM_CAP_HYPERV_DIRECT_TLBFLUSH:
 		if (!kvm_x86_ops.enable_l2_tlb_flush)
 			return -ENOTTY;
@@ -5879,14 +5901,57 @@ static void emulator_get_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 	kvm_x86_call(get_idt)(emul_to_vcpu(ctxt), dt);
 }
 
+/*
+ * Divert a descriptor-table write into a register-intercept exit when the
+ * higher VTL armed one: the write is not applied, and userspace delivers
+ * the TLFS register-intercept message to the higher VTL.  The intercept
+ * contract covers only the L1 guest; a descriptor load emulated on behalf
+ * of a nested (L2) guest, however its exit arrived, is applied normally.
+ */
+static bool hv_divert_dt_write(struct x86_emulate_ctxt *ctxt, u32 hv_reg,
+			       const struct desc_ptr *dt, u64 ctl_bit)
+{
+#ifdef CONFIG_KVM_HYPERV
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	if (!hv_vcpu || vcpu->plane_level || is_guest_mode(vcpu) ||
+	    !(hv_vcpu->reg_intercept_control & ctl_bit))
+		return false;
+
+	hv_vcpu->reg_intercept.reg = hv_reg;
+	hv_vcpu->reg_intercept.base = dt->address;
+	hv_vcpu->reg_intercept.limit = dt->size;
+	hv_vcpu->reg_intercept.rip = ctxt->eip;
+	hv_vcpu->reg_intercept.insn_len = ctxt->_eip - ctxt->eip;
+	hv_vcpu->reg_intercept.pending = true;
+	return true;
+#else
+	return false;
+#endif
+}
+
+#define HV_CR_INTERCEPT_GDTR_WRITE	BIT_ULL(15)
+#define HV_CR_INTERCEPT_IDTR_WRITE	BIT_ULL(16)
+#define HV_X64_REGISTER_IDTR_ID		0x00070000
+#define HV_X64_REGISTER_GDTR_ID		0x00070001
+
 static void emulator_set_gdt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
+	if (hv_divert_dt_write(ctxt, HV_X64_REGISTER_GDTR_ID, dt,
+			       HV_CR_INTERCEPT_GDTR_WRITE))
+		return;
 	kvm_x86_call(set_gdt)(emul_to_vcpu(ctxt), dt);
 }
 
 static void emulator_set_idt(struct x86_emulate_ctxt *ctxt, struct desc_ptr *dt)
 {
-	kvm_x86_call(set_idt)(emul_to_vcpu(ctxt), dt);
+	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
+
+	if (hv_divert_dt_write(ctxt, HV_X64_REGISTER_IDTR_ID, dt,
+			       HV_CR_INTERCEPT_IDTR_WRITE))
+		return;
+	kvm_x86_call(set_idt)(vcpu, dt);
 }
 
 static unsigned long emulator_get_cached_segment_base(
@@ -6630,6 +6695,44 @@ int x86_decode_emulated_instruction(struct kvm_vcpu *vcpu, int emulation_type,
 }
 EXPORT_SYMBOL_FOR_KVM_INTERNAL(x86_decode_emulated_instruction);
 
+#ifdef CONFIG_KVM_HYPERV
+/*
+ * Complete a descriptor-table write that hv_divert_dt_write() diverted
+ * during the emulation that just finished: rewind RIP and build the
+ * KVM_EXIT_HYPERV_REG_INTERCEPT exit.  Consuming the record before
+ * x86_emulate_instruction() returns means it never outlives the emulation
+ * call: no stale rewind can fire on a later KVM_RUN, and disarming the cap
+ * or migrating the vCPU can never see a half-delivered intercept.
+ */
+static int complete_hv_reg_intercept(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	hv_vcpu->reg_intercept.pending = false;
+
+	/*
+	 * The intercepted instruction must not retire: the emulator advanced
+	 * RIP when it diverted the write, but the higher VTL owns
+	 * completion.  It either applies the write and advances RIP itself,
+	 * disarms the intercept so re-execution succeeds, or queues an
+	 * exception that must fault AT the instruction (the
+	 * kernel-patch-protection LIDT probe matches the faulting RIP
+	 * against the probe site).
+	 */
+	kvm_rip_write(vcpu, hv_vcpu->reg_intercept.rip);
+	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
+	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_REG_INTERCEPT;
+	vcpu->run->hyperv.plane = vcpu->plane_level;
+	vcpu->run->hyperv.u.reg_intercept.reg = hv_vcpu->reg_intercept.reg;
+	vcpu->run->hyperv.u.reg_intercept.insn_len =
+		hv_vcpu->reg_intercept.insn_len;
+	vcpu->run->hyperv.u.reg_intercept.base = hv_vcpu->reg_intercept.base;
+	vcpu->run->hyperv.u.reg_intercept.limit = hv_vcpu->reg_intercept.limit;
+	vcpu->run->hyperv.u.reg_intercept.rip = hv_vcpu->reg_intercept.rip;
+	return 0;
+}
+#endif
+
 int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 			    int emulation_type, void *insn, int insn_len)
 {
@@ -6861,6 +6964,15 @@ int x86_emulate_instruction(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa,
 	} else
 		vcpu->arch.emulate_regs_need_sync_to_vcpu = true;
 
+#ifdef CONFIG_KVM_HYPERV
+	{
+		struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+		if (hv_vcpu && hv_vcpu->reg_intercept.pending)
+			r = complete_hv_reg_intercept(vcpu);
+	}
+#endif
+
 	return r;
 }
 
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 694409459cb8..b260d4d8aa22 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -100,6 +100,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_HCALL          2
 #define KVM_EXIT_HYPERV_SYNDBG         3
 #define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+#define KVM_EXIT_HYPERV_REG_INTERCEPT  5
 	__u32 type;
 	__u32 plane;
 	union {
@@ -117,6 +118,15 @@ struct kvm_hyperv_exit {
 #define KVM_HYPERV_HCALL_UD		(1ULL << 0)
 			__u64 flags;
 		} hcall;
+		struct {
+			__u32 reg;
+			__u8 insn_len;
+			__u8 pad[3];
+			__u64 base;
+			__u32 limit;
+			__u32 pad2;
+			__u64 rip;
+		} reg_intercept;
 		struct {
 			__u32 msr;
 			__u32 pad2;
@@ -1032,6 +1042,7 @@ struct kvm_enable_cap {
 #define KVM_CAP_PLANES 254
 #define KVM_CAP_HYPERV_FORWARD_HCALL 255
 #define KVM_CAP_PLANES_SHARE 256
+#define KVM_CAP_HYPERV_REG_INTERCEPT 257
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
-- 
2.50.1

