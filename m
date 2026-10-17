Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C52A49EC51;
	Sat, 17 Oct 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239921; cv=none; b=mirk/20gr0aaZu0B1LBmuIz0EDKxJbeuGvhfBj75Zy64hLXA4zv/VirzHPRsdybxLBEmho+/WweST/bBY2Re8/Qey6NoHFDQFDYgdwGOSUuNE5wRktND02di3dJV4JX2SKGIUXp6wPa8AylnY4Vp5BoCRFeqEfBP/TLsVDwVepU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239921; c=relaxed/simple;
	bh=G7Q3eE63lXZh6+d33FQ1eN7wUtlBrle9Zgt+4IKuP7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZqS++ioDvngris9DG0kI0J4D8ozd2o8y+SHlNfHpDxqy3OslLsE0Vmf5X1tnO7Di6pH8ZgjZGZWiW4M6cPCMcmvz+90hXE84b/fU3BCxVPBFGZoTeRgySKBSwAJX28tyBia4wQCBrHmyq8xw8LG3qwrwtwuQZvR6tNTaTspR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=H2WpFIYN; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="H2WpFIYN"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=eCNwxzRJ84CL8VIVOhPn+GEg7m3LfXwOr+TqbcvUxiw=; b=H2WpFIYNc9xDDNszc3oaqKd5HY
	0qptZPm89UW0vg51ykH1cpZdW+XryoR6Y2cFD38a82b+G2wWhwXhZgkQZL3lCUBnipmZ2khlxmETD
	QTdXaN55Fb3etl08hQdvG/h0ESOuG96lN4RldhSQjEqYW9kAj9bU9AcMmebQqfXXxV52zbXzUTUKk
	Uig5LB7SVWNRCSx2mHSdJ0n8nYPb/cIS24VlgDN/gDJO7OM1JcveKVN0fDhTlwrDBrDPUDFmUIQKu
	22d5sgm4VLVtMmiGzxsQvlKWLrSJfAmCK95RYMlOkkwQCqzfb88glY43ffbXADafHy5qmTRWDiung
	7YrE4r/g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfM-1aPo;
	Sat, 17 Oct 2026 12:25:15 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TC-00000002YmG-3U1m;
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
Subject: [RFC PATCH 21/55] KVM: x86: hyper-v: handle VTL call/return in the kernel
Date: Sat, 17 Oct 2026 13:24:27 +0100
Message-ID: <20261017122501.610248-22-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Every VTL transition exits to userspace, which performs the switch
with a dozen cross-thread vCPU ioctls. A Windows guest boots VSM with
hundreds of thousands of transitions, so boot takes *minutes* of
wall-clock time in switch overhead alone.

Handle HvCallVtlCall and HvCallVtlReturn in kvm_hv_hypercall() when
userspace opts in with KVM_CAP_HYPERV_VTL_SWITCH. The switch copies
the VTL-shared state directly between the plane vCPUs (GPRs except
RSP, CR2), maintains the entered VTL's assist-page control area (entry
reason, caller's RAX/RCX), and restores RAX/RCX on a non-fast VTL
return. The suspended plane keeps its deferred hypercall completion
pending, RIP still at the vmcall, exactly as userspace-driven
switching leaves it.

The shared guest FPU is carried across in the plane run loop, once the
outgoing plane's FPU has been saved, by copying the legacy FXSAVE area
between the twins. The source's FP and SSE XSTATE_BV bits are
propagated set-or-clear: when those components are in init state,
XSAVES skipped them and the vzalloc'ed legacy area is zeroes, and
blindly marking them valid would load MXCSR=0 (every SIMD exception
unmasked) and FCW=0 into the other VTL as architectural state.

Transitions the kernel cannot handle (no twin plane vCPU) still go to
userspace, with the vmcall retired and the completion dropped before
the exit. A completion left armed across the suspension fires on
whatever entry next resumes the plane — after a forced higher-VTL
entry that is an arbitrary interrupted instruction, which must not
have RAX overwritten and RIP skipped. The reference hypervisor
likewise retires the instruction before switching, which also makes
the suspended RIP a higher VTL observes through GetVpRegisters point
past the vmcall. An hv_vtl_switch_limit module parameter caps how many
transitions the kernel handles, with the rest forwarded; that is the
bisection knob for behavioural divergence between the two switch
paths.

Also report the originating plane of every forwarded hypercall in a
previously-padding field of struct kvm_hyperv_exit, so userspace can
tell which VTL issued a hypercall without tracking every switch
itself.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 Documentation/virt/kvm/api.rst  |  59 +++++++++-
 arch/x86/include/asm/kvm_host.h |  14 +++
 arch/x86/kvm/hyperv.c           | 193 ++++++++++++++++++++++++++++++++
 arch/x86/kvm/x86.c              |  69 ++++++++++++
 include/hyperv/hvgdk_mini.h     |   2 +
 include/linux/kvm_host.h        |  21 ++++
 include/uapi/linux/kvm.h        |   3 +-
 virt/kvm/kvm_main.c             |   1 +
 8 files changed, 360 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 8232356b1bb0..c9283994014a 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -7126,8 +7126,10 @@ EOI was received.
   #define KVM_EXIT_HYPERV_SYNIC          1
   #define KVM_EXIT_HYPERV_HCALL          2
   #define KVM_EXIT_HYPERV_SYNDBG         3
+  #define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+  #define KVM_EXIT_HYPERV_REG_INTERCEPT  5
 			__u32 type;
-			__u32 pad1;
+			__u32 plane;
 			union {
 				struct {
 					__u32 msr;
@@ -7141,6 +7143,15 @@ EOI was received.
 					__u64 result;
 					__u64 params[2];
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
@@ -7158,6 +7169,11 @@ EOI was received.
 Indicates that the VCPU exits into userspace to process some tasks
 related to Hyper-V emulation.
 
+'plane' identifies the plane the exit concerns: the plane of the vCPU
+that triggered the exit, or for KVM_EXIT_HYPERV_VTL_INTERRUPT the
+higher plane to be entered.  On kernels without plane support the
+field was padding and reads as zero.
+
 Valid values for 'type' are:
 
 	- KVM_EXIT_HYPERV_SYNIC -- synchronously notify user-space about
@@ -7172,6 +7188,25 @@ Hyper-V Synthetic debugger state change. Notification is used to either update
 the pending_page location or to send a control command (send the buffer located
 in send_page or recv a buffer to recv_page).
 
+	- KVM_EXIT_HYPERV_VTL_INTERRUPT -- the plane named by 'plane' has a
+
+pending event that preempts the current, lower plane (TLFS: higher VTL
+interrupts preempt lower VTLs).  The VMM is expected to perform a VTL
+entry into that plane.  Delivered only while in-kernel VTL switching
+(KVM_CAP_HYPERV_VTL_SWITCH, see section 7.50) is disabled, and
+single-shot: if the VMM declines the entry, the event waits in the
+target plane for a cooperative entry rather than re-triggering the
+exit.
+
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
@@ -9064,6 +9099,28 @@ For Hyper-V, unknown hypercalls are passed to userspace without checking their
 parameter pages.  The fault GPA is in the physical address space of the
 VM managed by userspace, after nested GPA translation.
 
+7.50 KVM_CAP_HYPERV_VTL_SWITCH
+------------------------------
+
+:Architectures: x86
+:Target: VM
+:Parameters: args[0] is 1 to enable in-kernel VTL switches, 0 to disable them
+
+When enabled, KVM handles the non-fast forms of the HvCallVtlCall and
+HvCallVtlReturn hypercalls itself where it can: the calling plane's
+vCPU is suspended mid-hypercall and its twin in the target plane
+resumed, with the VTL-shared register state (GPRs except RSP, CR2, FPU)
+carried across and the entered VTL's assist page updated as the TLFS
+specifies.  A transition KVM cannot handle (a fast-form call, no twin
+vCPU in the target plane, a target that cannot be entered) falls back
+to the KVM_CAP_HYPERV_FORWARD_HCALL path, so a VMM enabling this
+capability must still implement the userspace switch and should enable
+forwarding too.
+
+While this capability is disabled, a pending event for a higher plane
+instead surfaces as a KVM_EXIT_HYPERV_VTL_INTERRUPT exit (see section
+5) telling the VMM to enter that plane.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6ee85022cdfc..537ea6cded7a 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -731,6 +731,14 @@ struct kvm_vcpu_hv {
 		u64 vm_id;
 		u32 vp_id;
 	} nested;
+
+	/*
+	 * RAX/RCX of the lower VTL captured at VTL entry, restored on a
+	 * non-fast VTL return when this plane has no VP assist page to
+	 * carry them in its VTL control area.
+	 */
+	u64 vtl_entry_rax;
+	u64 vtl_entry_rcx;
 };
 
 struct kvm_hypervisor_cpuid {
@@ -1202,6 +1210,12 @@ enum hv_tsc_page_status {
 /* Hyper-V emulation context */
 struct kvm_hv {
 	struct mutex hv_lock;
+	bool hv_inkernel_vtl_switch;
+	/*
+	 * In-kernel VTL switches performed by this VM, counted against the
+	 * hv_vtl_switch_limit debug knob; saturates instead of wrapping.
+	 */
+	atomic_t vtl_switch_count;
 	/*
 	 * GUEST_OS_ID and the hypercall page are per-VTL instances in the
 	 * TLFS; bank them per plane so a higher VTL enabling its own
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index ea80536caa48..2f57f89cd8ea 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2725,6 +2725,7 @@ static int kvm_hv_hypercall_userspace_exit(struct kvm_vcpu *vcpu,
 
 	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
 	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
+	vcpu->run->hyperv.plane = vcpu->plane_level;
 	vcpu->run->hyperv.u.hcall.input = hc->param;
 	vcpu->run->hyperv.u.hcall.params[0] = hc->ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc->outgpa;
@@ -2732,6 +2733,150 @@ static int kvm_hv_hypercall_userspace_exit(struct kvm_vcpu *vcpu,
 	return 0;
 }
 
+
+/* VTL control area in the VP assist page (TLFS struct hv_vp_vtl_control). */
+#define HV_VTL_CONTROL_OFFSET		8
+#define HV_VTL_ENTRY_REASON_VTL_CALL	1
+#define HV_VTL_RETURN_FAST_BIT		BIT_ULL(0)
+
+struct hv_vtl_control {
+	u32 vtl_entry_reason;
+	u8 vina_asserted;
+	u8 reserved[3];
+	u64 vtl_ret_x64rax;
+	u64 vtl_ret_x64rcx;
+} __packed;
+
+static u64 hv_vtl_assist_page_gpa(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
+
+	if (!hv_vcpu ||
+	    !(hv_vcpu->hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ENABLE))
+		return 0;
+	return hv_vcpu->hv_vapic & HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK;
+}
+
+/*
+ * In-kernel VTL call/return: switch between the plane vCPUs directly
+ * instead of bouncing every transition through userspace.  Keeps the
+ * userspace contract: VTL-shared register state (GPRs except RSP, CR2,
+ * FPU) follows the switch, the entered VTL's assist page gets the entry
+ * reason and the caller's RAX/RCX, and a non-fast VTL return restores
+ * the lower VTL's RAX/RCX from the returning VTL's control area.  The
+ * suspending plane stays suspended mid-hypercall, with
+ * hcall_resume_pending set: its pending completion delivers the
+ * instruction skip and the resume RAX when a later switch re-enters
+ * the plane.
+ *
+ * Returns -ENOENT when the transition cannot be handled here (no twin
+ * plane); the caller forwards the hypercall to userspace unchanged.
+ */
+static int hv_vtl_switch_limit = -1;
+module_param(hv_vtl_switch_limit, int, 0644);
+
+static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
+{
+	static const int shared_gprs[] = {
+		VCPU_REGS_RAX, VCPU_REGS_RBX, VCPU_REGS_RCX, VCPU_REGS_RDX,
+		VCPU_REGS_RSI, VCPU_REGS_RDI, VCPU_REGS_RBP,
+		VCPU_REGS_R8, VCPU_REGS_R9, VCPU_REGS_R10, VCPU_REGS_R11,
+		VCPU_REGS_R12, VCPU_REGS_R13, VCPU_REGS_R14, VCPU_REGS_R15,
+	};
+	int cur = vcpu->plane_level;
+	int to = is_return ? cur - 1 : cur + 1;
+	u64 rax = kvm_rax_read(vcpu), rcx = kvm_rcx_read(vcpu);
+	bool fast = is_return && (rax & HV_VTL_RETURN_FAST_BIT);
+	int limit = READ_ONCE(hv_vtl_switch_limit);
+	struct hv_vtl_control ctl;
+	struct kvm_vcpu *target;
+	u64 assist, resume;
+	int i;
+
+	if (to < 0 || to >= KVM_MAX_PLANES || !vcpu->common->vcpus[to])
+		return -ENOENT;
+	target = vcpu->common->vcpus[to];
+
+	/*
+	 * Debug budget on in-kernel switches, counted per VM and only for
+	 * switches that pass the eligibility checks above (a forwarded
+	 * switch consumes none).  The counter saturates so a guest cannot
+	 * wrap it back under an operator-set limit.
+	 */
+	if (limit >= 0 &&
+	    atomic_fetch_add_unless(&to_kvm_hv(vcpu->kvm)->vtl_switch_count,
+				    1, INT_MAX) >= limit)
+		return -ENOENT;
+
+	if (is_return && !fast) {
+		assist = hv_vtl_assist_page_gpa(vcpu);
+		if (assist) {
+			if (kvm_vcpu_read_guest(vcpu,
+						assist + HV_VTL_CONTROL_OFFSET,
+						&ctl, sizeof(ctl)))
+				return -ENOENT;
+		} else {
+			ctl.vtl_ret_x64rax = to_hv_vcpu(vcpu)->vtl_entry_rax;
+			ctl.vtl_ret_x64rcx = to_hv_vcpu(vcpu)->vtl_entry_rcx;
+		}
+	}
+
+	/* VTL-shared state: GPRs except RSP (RIP/RFLAGS stay private). */
+	for (i = 0; i < ARRAY_SIZE(shared_gprs); i++)
+		kvm_register_write_raw(target, shared_gprs[i],
+				       kvm_register_read_raw(vcpu,
+							     shared_gprs[i]));
+	target->arch.cr2 = vcpu->arch.cr2;
+	vcpu->common->vtl_fpu_from = cur;
+
+	if (!is_return) {
+		assist = hv_vtl_assist_page_gpa(target);
+		if (assist) {
+			ctl = (struct hv_vtl_control) {
+				.vtl_entry_reason = HV_VTL_ENTRY_REASON_VTL_CALL,
+				.vtl_ret_x64rax = rax,
+				.vtl_ret_x64rcx = rcx,
+			};
+			kvm_vcpu_write_guest(vcpu,
+					     assist + HV_VTL_CONTROL_OFFSET,
+					     &ctl, sizeof(ctl));
+		}
+		if (to_hv_vcpu(target)) {
+			to_hv_vcpu(target)->vtl_entry_rax = rax;
+			to_hv_vcpu(target)->vtl_entry_rcx = rcx;
+		}
+		resume = rax;
+	} else {
+		if (!fast)
+			kvm_rcx_write(target, ctl.vtl_ret_x64rcx);
+		resume = fast ? rax : ctl.vtl_ret_x64rax;
+	}
+
+	/*
+	 * The target resumes in a hypercall of its own (any time after its
+	 * very first entry).  Its pending completion delivers the deferred
+	 * instruction skip and the resume RAX from the shared run struct,
+	 * exactly as when userspace drives the switch; until then its
+	 * suspended RIP stays at the vmcall, which the higher VTL can
+	 * observe (and rewrite) through HvCallGetVpRegisters.
+	 */
+	if (target->arch.complete_userspace_io)
+		vcpu->run->hyperv.u.hcall.result = resume;
+
+	/*
+	 * Suspend the current plane in its uncompleted hypercall; the
+	 * switch back will provide its resume value the same way.
+	 */
+	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
+
+	vcpu->plane_user_stopped = true;
+	kvm_vcpu_set_plane_stopped(vcpu);
+	target->plane_user_stopped = false;
+	kvm_vcpu_set_plane_runnable(target);
+	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+	return 0;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -2898,6 +3043,54 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
+	case HVCALL_VTL_CALL:
+	case HVCALL_VTL_RETURN:
+		/* Neither call takes a variable header or rep count. */
+		if (unlikely(hc.rep || hc.var_cnt)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		if (to_kvm_hv(vcpu->kvm)->hv_inkernel_vtl_switch &&
+		    !hc.fast &&
+		    !kvm_hv_vtl_switch(vcpu, hc.code == HVCALL_VTL_RETURN)) {
+			/*
+			 * Suspended mid-hypercall; the pending completion
+			 * delivers the result when the plane resumes.
+			 */
+			return 1;
+		}
+		if (to_kvm_hv(vcpu->kvm)->hv_forward_hcalls) {
+			/*
+			 * Retire the vmcall before the plane switch, like the
+			 * reference hypervisor: the VMM fully owns the resumed
+			 * context (GPR copy, control-area RAX/RCX restore).  A
+			 * completion deferred across the suspension fires on
+			 * whatever entry resumes this plane next - after a
+			 * forced higher-VTL entry that can be an arbitrary
+			 * interrupted instruction, which then has RAX and RIP
+			 * rewritten with stale hypercall results.
+			 */
+			ret = kvm_hv_hypercall_userspace_exit(vcpu, &hc);
+			if (!ret) {
+				/*
+				 * With guest TF and KVM_GUESTDBG_SINGLESTEP
+				 * the skip prepares KVM_EXIT_DEBUG in the
+				 * same run union, overwriting the exit just
+				 * prepared; the retired vmcall would then be
+				 * silently dropped and the VMM never perform
+				 * the switch.  Re-prepare the hypercall exit
+				 * in that case: the VMM must see it, at the
+				 * price of one missed step event.
+				 */
+				if (!kvm_skip_emulated_instruction(vcpu))
+					kvm_hv_hypercall_userspace_exit(vcpu,
+									&hc);
+				vcpu->arch.complete_userspace_io = NULL;
+				return 0;
+			}
+			break;
+		}
+		fallthrough;
 	default:
 		if (to_kvm_hv(vcpu->kvm)->hv_forward_hcalls)
 			return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a9a241264ca..aa8e14a45568 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4884,6 +4884,7 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_FORWARD_HCALL:
+	case KVM_CAP_HYPERV_VTL_SWITCH:
 #endif
 	case KVM_CAP_HCALL_FAULT_EXIT:
 	case KVM_CAP_PCI_SEGMENT:
@@ -5912,6 +5913,12 @@ static int kvm_vcpu_ioctl_x86_set_xsave(struct kvm_vcpu *vcpu,
 	 */
 	xstate->xsave.header.xfeatures &= ~vcpu->arch.guest_fpu.fpstate->xfd;
 
+	/*
+	 * Cancel a pending VTL FPU carry: it would overwrite the state
+	 * installed here on the next KVM_RUN.
+	 */
+	kvm_vcpu_cancel_vtl_fpu_carry(vcpu->common);
+
 	return fpu_copy_uabi_to_guest_fpstate(&vcpu->arch.guest_fpu,
 					      guest_xsave->region,
 					      kvm_caps.supported_xcr0,
@@ -6920,6 +6927,13 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		to_kvm_hv(kvm)->hv_forward_hcalls = !!cap->args[0];
 		r = 0;
 		break;
+	case KVM_CAP_HYPERV_VTL_SWITCH:
+		r = -EINVAL;
+		if (cap->args[0] & ~1ULL)
+			break;
+		to_kvm_hv(kvm)->hv_inkernel_vtl_switch = !!cap->args[0];
+		r = 0;
+		break;
 #endif
 	case KVM_CAP_X2APIC_API:
 		r = -EINVAL;
@@ -12366,6 +12380,55 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu_plane0)
 		if (vcpu == NULL)
 			return -EINVAL;
 
+#ifdef CONFIG_KVM_HYPERV
+		/*
+		 * An in-kernel VTL switch carries the shared guest FPU
+		 * state to the newly selected plane.  The source plane's
+		 * FPU was saved to its fpstate when its inner run loop
+		 * exited, so the buffers are current.
+		 */
+		if (common->vtl_fpu_from >= 0) {
+			struct kvm_vcpu *prev;
+
+			prev = common->vtl_fpu_from < KVM_MAX_PLANES ?
+			       common->vcpus[common->vtl_fpu_from] : NULL;
+			common->vtl_fpu_from = -1;
+			if (prev && prev != vcpu &&
+			    prev->arch.guest_fpu.fpstate &&
+			    vcpu->arch.guest_fpu.fpstate) {
+				struct fpstate *dst = vcpu->arch.guest_fpu.fpstate;
+				struct fpstate *src = prev->arch.guest_fpu.fpstate;
+
+				memcpy(&dst->regs.fxsave, &src->regs.fxsave,
+				       sizeof(struct fxregs_state));
+				/*
+				 * Only the legacy FXSAVE area (x87, XMM,
+				 * MXCSR) is VTL-shared; the XSAVE header and
+				 * extended components (PKRU in particular)
+				 * stay per-VTL.  Carry the source's FP/SSE
+				 * xfeatures bits along with the area: when
+				 * the source's components are in init state
+				 * the saved legacy area holds no valid
+				 * register image (XSAVES skipped it), and
+				 * marking it present would make XRSTOR load
+				 * zeroes as architectural state, MXCSR=0
+				 * included.  Without XSAVE the fpstate is
+				 * only the 512-byte legacy area and there is
+				 * no header to maintain.
+				 */
+				if (boot_cpu_has(X86_FEATURE_XSAVE)) {
+					u64 carry = src->regs.xsave.header.xfeatures &
+						    (XFEATURE_MASK_FP | XFEATURE_MASK_SSE);
+
+					dst->regs.xsave.header.xfeatures =
+						(dst->regs.xsave.header.xfeatures &
+						 ~(XFEATURE_MASK_FP | XFEATURE_MASK_SSE)) |
+						carry;
+				}
+			}
+		}
+#endif
+
 		common->plane_switch = false;
 
 		ret = __kvm_arch_vcpu_ioctl_run(vcpu);
@@ -12986,6 +13049,12 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->rdp = fpu->last_dp;
 	memcpy(fxsave->xmm_space, fpu->xmm, sizeof(fxsave->xmm_space));
 
+	/*
+	 * Cancel a pending VTL FPU carry: it would overwrite the state
+	 * installed here on the next KVM_RUN.
+	 */
+	kvm_vcpu_cancel_vtl_fpu_carry(vcpu->common);
+
 	vcpu_put(vcpu);
 	return 0;
 }
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 6a4e8b9d570f..e1b6ee863777 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -482,6 +482,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_ASSERT_VIRTUAL_INTERRUPT			0x0094
 #define HVCALL_CREATE_PORT				0x0095
 #define HVCALL_CONNECT_PORT				0x0096
+#define HVCALL_VTL_CALL				0x0011
+#define HVCALL_VTL_RETURN			0x0012
 #define HVCALL_START_VP					0x0099
 #define HVCALL_GET_VP_INDEX_FROM_APIC_ID		0x009a
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE	0x00af
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 7071ff74d4ea..79b3ec2b95b8 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -338,6 +338,16 @@ struct kvm_vcpu_common {
 	/* Currently active VCPU */
 	struct kvm_vcpu *current_vcpu;
 
+#ifdef CONFIG_KVM_HYPERV
+	/*
+	 * An in-kernel VTL switch moved execution away from this plane
+	 * (-1: none pending); the run loop copies the (VTL-shared) guest
+	 * FPU state from it when it selects the new plane, after the old
+	 * one's FPU has been saved.
+	 */
+	int vtl_fpu_from;
+#endif
+
 	struct kvm_vcpu *vcpus[KVM_MAX_PLANES];
 
 	/* Locks */
@@ -458,6 +468,17 @@ struct kvm_vcpu {
 	unsigned plane_level;
 };
 
+/*
+ * Cancel (or initialise away) a pending in-kernel VTL switch FPU carry.
+ * A no-op on configurations without the Hyper-V VTL switch.
+ */
+static inline void kvm_vcpu_cancel_vtl_fpu_carry(struct kvm_vcpu_common *common)
+{
+#ifdef CONFIG_KVM_HYPERV
+	common->vtl_fpu_from = -1;
+#endif
+}
+
 void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu);
 void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu);
 struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index b55e28be5181..b50f92135acd 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -100,7 +100,7 @@ struct kvm_hyperv_exit {
 #define KVM_EXIT_HYPERV_HCALL          2
 #define KVM_EXIT_HYPERV_SYNDBG         3
 	__u32 type;
-	__u32 pad1;
+	__u32 plane;
 	union {
 		struct {
 			__u32 msr;
@@ -1025,6 +1025,7 @@ struct kvm_enable_cap {
  */
 #define KVM_HV_HCALL_RESULT_RAISE_UD	(1ULL << 63)
 #define KVM_CAP_HCALL_FAULT_EXIT 252
+#define KVM_CAP_HYPERV_VTL_SWITCH 253
 
 struct kvm_irq_routing_irqchip {
 	__u32 irqchip;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index ef23ee3ce04a..ef6e59a15846 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -474,6 +474,7 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 		goto out_drop_counter;
 	}
 	common->run = page_address(page);
+	kvm_vcpu_cancel_vtl_fpu_carry(common);
 
 	mutex_init(&common->mutex);
 
-- 
2.50.1

