Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34C0849427F;
	Sat, 17 Oct 2026 12:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239914; cv=none; b=V8NaSPdCz33/U7OXI6yfX3SXgs4NhxrOq0d4K3iWAIpH0mzbVSTRQTXWtdbB01yo5LkG2i65KC5MZKG1wZ7COL6tDrAjjQ7OD86I8Gf3VUVPSh0avS27uFn1KolgL30A2ZSG+yDEUP0V2MJb1LZylaMt+BFAwk5RdrgdWYWjWuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239914; c=relaxed/simple;
	bh=DA6gk81+wCV1G05Q+kU4c0Muh3+eDPCCG9oU1VwD57k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YSrroyxeizw6/p7BIqUuvgRmLaFyUPUpE6bgYukHZviFWrzdKS8WCbMGr2hYxmkwiCqYWF56v7tiQN93ltHf0LW1SXa2v6RcyfyL/pplNCadAlzoUX6eMlXuz1DYCfNN7skTBdbZYHXeX6+QFkX0OyfadKa11lT0n7sjZsOACig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=IqAvW1+l; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="IqAvW1+l"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=KCTMPfLGPbExC6rYO6Osf5ZRh9jRRpcPoU7REB3cQ+E=; b=IqAvW1+l2AtQGs4Pwl7gFZCx67
	CjjHjzBAovRmMtLpvEYGDgU1w1vOAGY+n+dxEL0f9TUmhFvWAerfR6W8O0skQ8mm4k/vdgElPCyAB
	1b/yM+XRkCrM5+sKQe011utzmac9G+R1WggT7ckJ/0YdhnfsmTG+/YS2f4vzqmG5JwmZwbvYTCjr3
	9O42DHr3YICkglCdoKi8TZHtz3OCIWFZm6DBUDL81ssf6Vb+ri7ozg4JM+Z0YdwZXJM5EiW2UOIKv
	/n35+v7ZVhNnWBc54fDmms7KI5u3XcNHW5EKgOIj+LMon0FkL9YZfAMX9ur5a1zxwMi1483vfiTVo
	Qt3Cyklg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TF-00000002Lfc-1ynt;
	Sat, 17 Oct 2026 12:25:06 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002Ynz-0Etu;
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
Subject: [RFC PATCH 46/55] KVM: x86: hyperv: Do not skip a moved vCPU when completing a hypercall
Date: Sat, 17 Oct 2026 13:24:52 +0100
Message-ID: <20261017122501.610248-47-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: Mushahid Hussain <hmushi@amazon.co.uk>

A Hyper-V hypercall that exits to userspace is completed on the next
KVM_RUN of the vCPU, and the completion skips the VMCALL. With planes,
the lower plane is not run again until the secure kernel returns, and
userspace applies the registers the secure kernel sets for it in
between. On a resume from hibernation the secure kernel sets VTL0's
RIP to the hibernate continuation. The deferred completion then skips
an instruction on top of that RIP.

The two vendors fail differently. SVM writes the stale next_rip of the
old VMCALL exit, so the VP resumes at the hypercall page's RET with
the new RSP, pops a zero and faults at RIP 0: Windows Server 2025
with Credential Guard bugchecks 0xD1 (0, 0xff, 0, 0) on every resume
on AMD. VMX adds the VMCALL length to the new RIP and lands three
bytes into PopSaveHiberContextWrapper+0x35, where the bytes happen to
decode as a harmless instruction before resynchronising, so Intel
passes by luck.

Record the RIP of the hypercall when exiting to userspace and complete
without skipping when the vCPU is no longer there. Applies to both
the VTL switch completion and the generic userspace completion. The
generic KVM_EXIT_HYPERCALL and Xen completions have the same shape
but userspace does not move the vCPU there; on arm64 the HVC is
skipped at exit time, so the planes series is unaffected there.

Measured on an m6a.metal (AMD) planes bench, WS2025 CG hibernate:
SK SETs VTL0 RIP = wrapper+0x35, RSP = cont; first plane-0 exits after
the return are at hypercall page+3, then RIP 0; KiBugCheckData 0xD1.

Assisted-by: LLM
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>

[dwmw2: this stack retires a forwarded VtlCall/VtlReturn eagerly at
 exit time with no pending completion, so that path is unexposed; the
 exposures are the FORWARD_HCALL completion and the plane an in-kernel
 VTL switch suspends at its vmcall, whose RIP the higher VTL rewrites
 via HvCallSetVpRegisters. Both resume through
 kvm_hv_hypercall_complete_userspace(), so one moved-check there
 covers both; the RIP is recorded in kvm_hv_hypercall_userspace_exit()
 and kvm_hv_vtl_switch(). The check yields to the TLB-flush
 suspension retry (a suspended vCPU re-executes the instruction, so
 there is no skip to suppress).]
(re-done by hand)
[dwmw2: folded in the RAISE_UD completion-contract tightening: the
 KVM_CAP_HYPERV_FORWARD_HCALL extension check returns 2 to advertise
 that the kernel honours KVM_HV_HCALL_RESULT_RAISE_UD, the bit is
 honoured only while forwarding is enabled (the legacy syndbg and
 slow-form completions treat bit 63 as part of the result) and only
 after the suspended and moved guards, and an in-kernel-armed
 completion is tagged with hcall_resume_pending so it re-executes the
 hypercall instead of consuming stale run-union bytes left by an
 unrelated exit.]
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst  |  6 +++
 arch/x86/include/asm/kvm_host.h | 17 ++++++++
 arch/x86/kvm/hyperv.c           | 77 ++++++++++++++++++++++++++++++---
 arch/x86/kvm/x86.c              | 11 ++++-
 include/uapi/linux/kvm.h        |  4 +-
 5 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index d75987c1d325..494600236360 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -9146,6 +9146,12 @@ with ``hyperv.u.hcall.result`` set.  Hypercalls KVM implements itself,
 and the ordering of CPUID-enforcement checks against hypercall
 dispatch, are unaffected.
 
+When KVM_CHECK_EXTENSION reports a value of 2 or more, a result with
+KVM_HV_HCALL_RESULT_RAISE_UD set makes KVM raise #UD at the hypercall
+instruction instead of completing it (honoured only while forwarding
+is enabled).  A VMM must not set that bit on kernels reporting 1,
+where it lands in the guest's RAX as part of the result.
+
 7.49 KVM_CAP_HCALL_FAULT_EXIT
 ------------------------------------
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index 6d3bae46ecab..e03ae6493641 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -762,6 +762,23 @@ struct kvm_vcpu_hv {
 	u64 vtl_entry_rcx;
 	bool vtl_entry_regs_valid;
 
+	/*
+	 * Linear RIP of the hypercall instruction whose deferred
+	 * completion (userspace exit or in-kernel VTL switch suspension)
+	 * is pending; linear so that a CS.base change while the vCPU is
+	 * parked cannot alias the recorded offset.
+	 */
+	u64 hcall_exit_rip;
+
+	/*
+	 * Set when an in-kernel VTL switch armed the deferred completion:
+	 * the resume value only lands in run->hyperv.u.hcall.result when
+	 * the opposite-direction switch provides it.  While set, the run
+	 * union holds unrelated bytes and the completion must retry the
+	 * hypercall instead of consuming them.
+	 */
+	bool hcall_resume_pending;
+
 	bool suspended;
 	int waiting_on;
 };
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e3ac840c8e5e..02866b9b7e9b 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2838,16 +2838,67 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	return ret;
 }
 
+/*
+ * A hypercall whose completion was deferred (a userspace exit, or an
+ * in-kernel VTL switch suspending this plane) completes on the vCPU's next
+ * run.  The vCPU may have been moved in between: the higher VTL can rewrite
+ * the suspended plane's RIP through HvCallSetVpRegisters (on a hibernate
+ * resume the secure kernel points VTL0 at the continuation), and userspace
+ * applies that through KVM_SET_REGS.  Skipping an instruction there would
+ * land past the new RIP, so only skip when the vCPU still sits at the RIP
+ * recorded when the completion was armed.
+ */
+static bool kvm_hv_hypercall_moved(struct kvm_vcpu *vcpu)
+{
+	return !kvm_is_linear_rip(vcpu, to_hv_vcpu(vcpu)->hcall_exit_rip);
+}
+
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 result = vcpu->run->hyperv.u.hcall.result;
 
+	/* Still suspended: nothing completes yet, the vmcall is retried. */
+	if (kvm_hv_vcpu_suspended(vcpu))
+		return 1;
+
+	/*
+	 * An in-kernel VTL switch armed this completion, and only the
+	 * opposite-direction switch writes the resume value.  Resumed any
+	 * other way (a run-state ioctl, a switch forwarded to userspace),
+	 * the run union holds leftover bytes from an unrelated exit:
+	 * don't consume them, re-execute the hypercall instead.
+	 */
+	if (hv_vcpu->hcall_resume_pending) {
+		hv_vcpu->hcall_resume_pending = false;
+		return 1;
+	}
+
+	if (kvm_hv_hypercall_moved(vcpu)) {
+		/*
+		 * The parked plane was repointed (HvCallSetVpRegisters via
+		 * the higher VTL): deliver the result without the deferred
+		 * skip.  Strip the VMM-only control bit; an exception aimed
+		 * at the hypercall instruction has no target once RIP
+		 * moved, and bit 63 must not leak into guest RAX.
+		 */
+		result &= ~KVM_HV_HCALL_RESULT_RAISE_UD;
+		trace_kvm_hv_hypercall_done(result);
+		kvm_hv_hypercall_set_result(vcpu, result);
+		++vcpu->stat.hypercalls;
+		return 1;
+	}
+
 	/*
 	 * A hypercall the VMM judged malformed beyond returning a status
 	 * (such as a VTL call that is invalid in the current state) faults
-	 * at the instruction instead of completing.
+	 * at the instruction instead of completing.  Only completions the
+	 * VMM owns under KVM_CAP_HYPERV_FORWARD_HCALL honour the control
+	 * bit; legacy exits (syndbg, slow-form hypercalls) predate it and
+	 * keep bit 63 as part of the result.
 	 */
-	if (result & KVM_HV_HCALL_RESULT_RAISE_UD) {
+	if (to_kvm_hv(vcpu->kvm)->hv_forward_hcalls &&
+	    (result & KVM_HV_HCALL_RESULT_RAISE_UD)) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
@@ -2993,6 +3044,9 @@ static int kvm_hv_hypercall_userspace_exit(struct kvm_vcpu *vcpu,
 	vcpu->run->hyperv.u.hcall.input = hc->param;
 	vcpu->run->hyperv.u.hcall.params[0] = hc->ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc->outgpa;
+	to_hv_vcpu(vcpu)->hcall_exit_rip = kvm_get_linear_rip(vcpu);
+	/* Userspace owns this exit and writes hcall.result before KVM_RUN. */
+	to_hv_vcpu(vcpu)->hcall_resume_pending = false;
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
 	return 0;
 }
@@ -3136,9 +3190,11 @@ bool kvm_hv_vtl_interrupt_entry(struct kvm_vcpu *vcpu,
 	 * value is guest-derived; strip the VMM-only RAISE_UD control bit
 	 * so the completion cannot be made to inject #UD by the guest.
 	 */
-	if (target->arch.complete_userspace_io)
+	if (target->arch.complete_userspace_io) {
 		vcpu->run->hyperv.u.hcall.result = kvm_rax_read(target) &
 						   ~KVM_HV_HCALL_RESULT_RAISE_UD;
+		to_hv_vcpu(target)->hcall_resume_pending = false;
+	}
 
 	vcpu->plane_kernel_stopped = true;
 	kvm_vcpu_set_plane_stopped(vcpu);
@@ -3282,7 +3338,9 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 	 * instruction skip and the resume RAX from the shared run struct,
 	 * exactly as when userspace drives the switch; until then its
 	 * suspended RIP stays at the vmcall, which the higher VTL can
-	 * observe (and rewrite) through HvCallGetVpRegisters.
+	 * observe (and rewrite) through HvCallGetVpRegisters.  A rewritten
+	 * RIP suppresses the deferred skip (kvm_hv_hypercall_moved()): the
+	 * plane resumes exactly where the higher VTL pointed it.
 	 *
 	 * The resume value is guest-derived in all three cases (the
 	 * caller's RAX on a call or a fast return, the control area on a
@@ -3291,9 +3349,10 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 	 * plane.
 	 */
 	resume &= ~KVM_HV_HCALL_RESULT_RAISE_UD;
-	if (target->arch.complete_userspace_io)
+	if (target->arch.complete_userspace_io) {
 		vcpu->run->hyperv.u.hcall.result = resume;
-	else
+		to_hv_vcpu(target)->hcall_resume_pending = false;
+	} else
 		/*
 		 * No completion is armed when the target's suspension
 		 * already retired its vmcall (forwarded switch) or was a
@@ -3307,8 +3366,12 @@ static int kvm_hv_vtl_switch(struct kvm_vcpu *vcpu, bool is_return)
 
 	/*
 	 * Suspend the current plane in its uncompleted hypercall; the
-	 * switch back will provide its resume value the same way.
+	 * switch back will provide its resume value the same way.  Until
+	 * it does, hcall_resume_pending marks the run union as not holding
+	 * this plane's result.
 	 */
+	to_hv_vcpu(vcpu)->hcall_exit_rip = kvm_get_linear_rip(vcpu);
+	to_hv_vcpu(vcpu)->hcall_resume_pending = true;
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
 
 	vcpu->plane_kernel_stopped = true;
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 89203909db36..dc6196107c23 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4937,7 +4937,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_HYPERV_CPUID:
 	case KVM_CAP_HYPERV_ENFORCE_CPUID:
 	case KVM_CAP_SYS_HYPERV_CPUID:
-	case KVM_CAP_HYPERV_FORWARD_HCALL:
 	case KVM_CAP_HYPERV_VTL_SWITCH:
 	case KVM_CAP_HYPERV_REG_INTERCEPT:
 #endif
@@ -4985,6 +4984,16 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_ONE_REG:
 		r = 1;
 		break;
+#ifdef CONFIG_KVM_HYPERV
+	case KVM_CAP_HYPERV_FORWARD_HCALL:
+		/*
+		 * 2: KVM_HV_HCALL_RESULT_RAISE_UD is honoured on hypercall
+		 * completion.  A VMM must not set the bit on kernels
+		 * reporting 1, where it lands in guest RAX instead.
+		 */
+		r = 2;
+		break;
+#endif
 	case KVM_CAP_PRE_FAULT_MEMORY:
 		r = tdp_enabled;
 		break;
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 843cef8f4cbf..8224ef335ba1 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -1038,7 +1038,9 @@ struct kvm_enable_cap {
  * Userspace completion of a forwarded Hyper-V hypercall (KVM_EXIT_HYPERV_HCALL
  * under KVM_CAP_HYPERV_FORWARD_HCALL): setting this bit in the result makes
  * KVM raise #UD at the faulting instruction instead of completing the
- * hypercall; all other result bits are then ignored.
+ * hypercall; all other result bits are then ignored.  Only honoured while
+ * forwarding is enabled, and only on kernels where
+ * KVM_CHECK_EXTENSION(KVM_CAP_HYPERV_FORWARD_HCALL) returns >= 2.
  */
 #define KVM_HV_HCALL_RESULT_RAISE_UD	(1ULL << 63)
 #define KVM_CAP_HCALL_FAULT_EXIT 252
-- 
2.50.1

