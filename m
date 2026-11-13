Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594896;
	b=NYwP+2sv7aWVOvAtG6FRNjgBsgrWVtxLTiOa9Qr/Gjw51bK5P4MNuqxmYMPQDaOKqgRB
	 ntKkFpFd+5DE95QXUYBMocButaCfDKMN1g1t1YgycoRTozGrDnutnJiSFHmFGn7/2iTcS
	 joBJYKINqEGjm02JDs9yiiG6ir2c3tEzPXhDsViiRmHZHskGzafzaRWuK1qxLuo+BlhDs
	 jNV3ZwG9PGHM1u7IevpXdmb625zD/Cjh1Q+nSNFwX9jGTs5MSkHnZdooplsBAs42aEdec
	 12pDtfhQDZ1dlfi7noZiRJF0yGzOrzFuj+UF7R7Xy1t/35Q7wuR8YKZ60d4MhtqEiaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ledlpXaPPBAB+YgMZ7BCmqDVcGSkc57ZCoS4a2YN+Kg=;
	b=tyDWho6V2WInXQ56UQ0uogmN+kVtLFA+WdZF2xdZjpW0J1P9cESEnKfG84viao4rEa3z
	 onomvqp0nXF6RE11y/PKs7CRLMHChxIejiUPpjP6UbkQ0JVfnyzOfU9P/RKUoFE81IZdv
	 DwVfXjlEddxwbeAywOgNVw2gvMMRPj6roKc7lhItR8B8+uy4CXwFkmJaHg20o24qO/clA
	 AscWgfz6gb+EJvjCTlk7pdBzOuEQQ06a0VDKgyvHh+nXCJM5Yb8HLBR8t6orLtPp0e3Ir
	 ohCL7HY3OkzTxf/b2TkTYWSV4j0wUXULUg9Ccy2MOVk2DlSJ+r1L2+hb+a7AeghFr7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VltA8U66;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F7560A5BC6;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3F7560A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=VltA8U66
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ledlpXaPPBAB+YgMZ7BCmqDVcGSkc57ZCoS4a2YN+Kg=; b=VltA8U66d0poZy+TxFpQ7mdIBT
	yWNlLvskf71Mor3zbY+EEYOzpjy4PC/TFBFAT2i8tevhmQj9fws3+zdtjwojp4tHtgc+EAd9cXefw
	Uw7l3Eb1sQGtG/4DuDom0SUUJOEZyCBo3qIwa4Xt5ihZoWxTxPavzAzPMcLbC6+8oncoPVBi4BZdm
	/d9bZXnwvq5iG7t12ShypEGiL8yq7vBQyM2NdWjfgSUFE3bLwTqSpkHp81Guc6mYKhEe3HgiG6825
	DnTizQhwj7399/swxaDhIjTVkpxNT9UEAgc+xijMZPni1LtXyuxVKPm95Lg036tSu6M6YE0P9axyw
	mBTgLQOQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bezy-38fC;
	Fri, 13 Nov 2026 18:34:52 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lsr-1kFq;
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
Subject: [RFC PATCH v2 06/31] KVM: x86: hyper-v: Handle VTL call/return in the kernel
Date: Fri, 13 Nov 2026 18:34:22 +0000
Message-ID: <20261113183448.84094-7-dwmw2@infradead.org>
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

Every VTL transition exits to userspace, which performs the switch
with a dozen cross-thread vCPU ioctls. A Windows guest makes hundreds
of thousands of transitions while booting VSM, so boot spends
*minutes* of wall-clock time in switch overhead alone.

Add two KVM_CAP_HYPERV_FORWARD_HCALL bits for HvCallVtlCall and
HvCallVtlReturn:

 - KVM_HYPERV_HCALL_VTL_CALLS (bit 2) gives the two calls their TLFS
   semantics, for a VMM that switches planes itself. Without it they
   stay ordinary hypercalls that KVM does not implement.
 - KVM_HYPERV_HCALL_VTL_SWITCH (bit 3), which requires VTL_CALLS,
   handles them in kvm_hv_hypercall().

hyperv_forward_hcall checks that VTL_SWITCH is refused without
VTL_CALLS.

The in-kernel switch copies the VTL-shared state (GPRs except RSP,
CR2) directly between the plane vCPUs, maintains the entered VTL's
assist-page control area (entry reason, caller's RAX/RCX), and
restores RAX/RCX on a non-fast VTL return. The suspended plane keeps
its hypercall completion pending with RIP still at the vmcall, exactly
as userspace-driven switching leaves it. The switch that re-enters a
plane writes the resume value (a full 64-bit register; on a non-fast
return, the lower VTL's own RAX) straight into its RAX, since no
userspace exit is involved, and marks the pending completion to only
retire the vmcall. A target whose vmcall was already retired (left by
a forwarded switch) has no completion armed and simply resumes.

The kernel only switches when it can do so exactly; anything else is
forwarded to userspace, which owns the switch:

 - a target that userspace holds (KVM_PLANE_RUN_STATE_USER_HOLD);
 - a target parked on a completion other than the hypercall one (MMIO,
   PIO), which owns the shared run union;
 - a target plane that has never run, whose HvCallEnableVpVtl state
   only userspace knows. A plane counts as having run once it entered
   the guest on this host or while an in-kernel switch keeps it
   SUSPENDED: last_vmentry_cpu is per-host, and restoring the run
   state is what tells a migration destination that the plane holds
   a context (api.rst says so for KVM_PLANE_RUN_STATE_SUSPENDED);
 - a target whose fpstate layout differs from the caller's;
 - a non-fast return from a plane without a VP assist page whose entry
   registers were not captured by an in-kernel call (userspace entered
   it, or the capture was lost across migration);
 - a VTL call whose control-area write fails. The write goes through
   the entered plane's vCPU, so it passes that plane's memory
   attributes and memslot view, and it happens before any state moves.
   It covers only the fields KVM maintains, the entry reason and
   RAX/RCX: KVM does not emulate VINA, so vina_asserted is the VMM's.

A plane the kernel suspends this way is not a userspace hold. Mark it
KVM_PLANE_RUN_STATE_SUSPENDED at the switch, and clear the flag when
the opposite switch resumes it: the flag gates plane-0 events like the
hold does, and a saved and restored run state puts the suspension back
as it was. The hold stays userspace's alone; in-kernel transitions read
it but never change it.

The SEV-SNP VMPL switch refuses to enter a held plane, failing KVM_RUN
as it does for a missing target, since there is no exit to forward a
VMGEXIT through. It sets neither flag on the VMPL it leaves.

The FPU is shared between VTLs in the TLFS, so the run loop carries it
from the plane that switched away to the plane it entered: the
source's complete fpstate image (XSAVE header included) and
vcpu->arch.pkru are copied to the target. The copy happens as soon as
the source plane's inner run loop has returned, its FPU saved, and
before KVM_RUN can return to userspace. The carry therefore never
outlives the KVM_RUN that performed the switch: after a -EINTR (or any
other) return, KVM_GET_XSAVE and KVM_GET_FPU on the entered plane show
the switched state, and KVM_SET_XSAVE or KVM_SET_FPU need not cancel
anything. Twins share XCR0, and KVM_SET_CPUID enlarges every twin's
fpstate for dynamic xfeatures, as does the creation of a twin after
it, so their XSAVES-compacted layouts match and the copy is exact.
Should they still differ, the switch is forwarded (above) rather than
carried in part; a guest cannot make the host WARN.

A transition the kernel does not handle goes to userspace with the
vmcall already retired and the completion dropped. A completion left
armed across the suspension would fire on whatever entry next resumes
the plane, and after a forced higher-VTL entry that is an arbitrary
interrupted instruction, which must not have RAX overwritten and RIP
skipped. Retiring first also makes the suspended RIP that a higher VTL
reads through GetVpRegisters point past the vmcall.

Retiring at exit time has one wrinkle. With guest EFLAGS.TF and
KVM_GUESTDBG_SINGLESTEP, the skip prepares a KVM_EXIT_DEBUG in the
same run union, on top of the KVM_EXIT_HYPERV just prepared; the
forwarded switch is silently dropped and a debugger-attached Windows
guest wedges. Prepare the hypercall exit again in that case: the VMM
*must* see the switch, at the price of one missed step event. A skip
that failed (SVM without NRIPS emulates it, and a failure prepares
KVM_EXIT_INTERNAL_ERROR) keeps its own exit.

The kvm.hv_vtl_switch_limit module parameter caps how many transitions
the kernel handles, forwarding the rest. It is the bisection knob for
divergence between the two switch paths; only performed switches
count against it.

A suspended plane's completion runs on its next KVM_RUN, after the
higher VTL may have moved it. On a resume from hibernation the secure
kernel sets VTL0's RIP to the hibernate continuation through
HvCallSetVpRegisters, and the deferred completion then skipped an
instruction on top of that RIP. SVM wrote the stale next_rip of the
old VMCALL exit, so the VP resumed at the hypercall page's RET with
the new RSP, popped a zero and faulted at RIP 0: Windows Server 2025
with Credential Guard bugchecked 0xD1 (0, 0xff, 0, 0) on every resume
on AMD (m6a.metal). VMX added the VMCALL length to the new RIP and
landed three bytes into PopSaveHiberContextWrapper+0x35, where the
bytes happen to decode as a harmless instruction, so Intel passed by
luck. The same holds for a FORWARD_HCALL exit completed after
userspace applied such a SetVpRegisters. Record the linear RIP of the
hypercall in cui_linear_rip, as the fast PIO completions do, whenever
a completion is armed, and complete without the skip when the vCPU is
no longer there. A moved vCPU gets the result even when userspace set
KVM_HYPERV_HCALL_UD, rather than a #UD aimed at an instruction it has
left.

The completion armed by an in-kernel switch is marked
hcall_resume_pending until the opposite switch provides the resume
value. A plane resumed any other way (a run-state ioctl, a switch
forwarded to userspace) re-executes the hypercall instead of reading
the run union, which then holds leftover bytes from an unrelated
exit. api.rst describes both guards.

Also report the originating plane of every forwarded hypercall, SynIC
and SynDbg exit, in a field of struct kvm_hyperv_exit that used to be
padding, so userspace can tell which VTL an exit concerns without
tracking every switch.

Co-developed-by: Mushahid Hussain <hmushi@amazon.co.uk>
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../admin-guide/kernel-parameters.txt         |   9 +
 Documentation/virt/kvm/api.rst                |  56 ++-
 arch/x86/include/asm/kvm_host.h               |   5 +
 arch/x86/kvm/hyperv.c                         | 370 +++++++++++++++++-
 arch/x86/kvm/hyperv.h                         |  42 +-
 arch/x86/kvm/svm/sev.c                        |  10 +
 arch/x86/kvm/x86.c                            |  61 +++
 include/hyperv/hvgdk_mini.h                   |   2 +
 include/linux/kvm_host.h                      |  23 ++
 include/uapi/linux/kvm.h                      |   4 +-
 .../selftests/kvm/x86/hyperv_forward_hcall.c  |  14 +
 virt/kvm/kvm_main.c                           |   1 +
 12 files changed, 583 insertions(+), 14 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0b3c140babd9..5bd7ebda0fed 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3173,6 +3173,15 @@ Kernel parameters
 
 			Default is N (off).
 
+	kvm.hv_vtl_switch_limit=
+			[KVM,X86] Debugging aid for Hyper-V VSM guests: the number
+			of VTL switches (HvCallVtlCall, HvCallVtlReturn) each VM
+			may perform in the kernel with KVM_HYPERV_HCALL_VTL_SWITCH
+			enabled.  Later switches are forwarded to userspace, as
+			with KVM_HYPERV_HCALL_VTL_CALLS alone.  Writable at
+			runtime through /sys/module/kvm/parameters/.
+			Default is -1 (no limit).
+
 	kvm.nx_huge_pages=
 			[KVM] Controls the software workaround for the
 			X86_BUG_ITLB_MULTIHIT bug.
diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 1a7884776ed5..61cfda97fa29 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -6907,8 +6907,9 @@ Reads or sets the run state flags of a plane's vCPU:
 - KVM_PLANE_RUN_STATE_USER_HOLD (bit 0): userspace has stopped the plane.
   Only KVM_SET_PLANE_RUN_STATE sets or clears it.
 - KVM_PLANE_RUN_STATE_SUSPENDED (bit 1): the plane is suspended by a
-  guest privilege transition, and resumes when that transition unwinds.
-  KVM does not set it yet; userspace can set it to restore a saved state.
+  guest privilege transition, such as the lower plane of an in-kernel
+  Hyper-V VTL switch, and becomes runnable again on the matching
+  in-kernel transition without userspace involvement.
 - KVM_PLANE_RUN_STATE_INACTIVE (bit 2): the plane has not been started.
   KVM sets it on every vCPU of a non-zero plane at creation and clears it
   when the plane is made runnable.  It is not accepted on plane 0.
@@ -6918,8 +6919,11 @@ Reads or sets the run state flags of a plane's vCPU:
 A plane with no flag set is runnable.  Setting any other bit fails
 with -EINVAL.  Writing back the flags previously read restores the same
 state, so a VMM can save and restore the run state of every plane, for
-example across live migration.  Which runnable plane executes at a given
-moment is not part of this state.
+example across live migration, without turning a guest suspension into
+userspace policy.  Restoring KVM_PLANE_RUN_STATE_SUSPENDED also tells KVM
+that the plane holds a guest context, so that in-kernel transitions may
+enter it on a migration destination where it has not yet run.  Which
+runnable plane executes at a given moment is not part of this state.
 
 When a vCPU thread calls KVM_RUN, KVM executes the lowest-numbered
 runnable plane, falling back to plane 0.  Whenever KVM itself makes a
@@ -6931,7 +6935,9 @@ KVM_PLANE_RUN_STATE_USER_HOLD on the current one before re-entering
 KVM_RUN.  Pending events for plane 0 make it runnable again on their own
 unless it is held or suspended; a held plane 0 keeps its events pending
 until the VMM clears the hold, so a software privilege model can keep a
-higher plane running undisturbed.  The ioctl is accepted on any plane's
+higher plane running undisturbed.  In-kernel plane transitions never
+override a hold: a guest-initiated VTL switch targeting a held plane is
+forwarded to userspace instead.  The ioctl is accepted on any plane's
 vCPU fd, on VMs that enabled more than one plane with
 KVM_ENABLE_CAP(KVM_CAP_PLANES); it fails with -EINVAL on other VMs.
 Planes whose count the architecture defines, such as SEV-SNP VMPLs, are
@@ -7442,7 +7448,7 @@ EOI was received.
   #define KVM_EXIT_HYPERV_HCALL          2
   #define KVM_EXIT_HYPERV_SYNDBG         3
 			__u32 type;
-			__u32 pad1;
+			__u32 plane;
 			union {
 				struct {
 					__u32 msr;
@@ -7475,6 +7481,10 @@ EOI was received.
 Indicates that the VCPU exits into userspace to process some tasks
 related to Hyper-V emulation.
 
+'plane' identifies the plane the exit concerns: the plane of the vCPU
+that triggered the exit.  On kernels without plane support the field
+was padding and reads as zero.
+
 Valid values for 'type' are:
 
 	- KVM_EXIT_HYPERV_SYNIC -- synchronously notify user-space about
@@ -7500,6 +7510,11 @@ KVM_HYPERV_HCALL_UD there to raise #UD at the hypercall instruction
 instead of completing the hypercall.  KVM_RUN fails with EINVAL, leaving
 the exit pending, if 'flags' holds any other bit.
 
+If the vCPU no longer sits at the hypercall instruction when it is
+resumed (userspace moved RIP, as a VMM does to apply a higher VTL's
+HvCallSetVpRegisters to a parked lower VTL), KVM writes 'result' without
+advancing RIP, and ignores KVM_HYPERV_HCALL_UD.
+
 	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
 
 Hyper-V Synthetic debugger state change. Notification is used to either update
@@ -9461,6 +9476,8 @@ The defined bits are::
 
   #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
   #define KVM_HYPERV_HCALL_RAISE_UD		(1ULL << 1)
+  #define KVM_HYPERV_HCALL_VTL_CALLS		(1ULL << 2)
+  #define KVM_HYPERV_HCALL_VTL_SWITCH		(1ULL << 3)
 
 KVM_HYPERV_HCALL_FORWARD_UNKNOWN: a hypercall that KVM would otherwise
 fail with HV_STATUS_INVALID_HYPERCALL_CODE exits to userspace with
@@ -9488,6 +9505,33 @@ the hypercall instruction instead of completing the hypercall, ignoring
 rather than fail with a status.  When enabled, it applies to every
 KVM_EXIT_HYPERV_HCALL completion, forwarded or not.
 
+KVM_HYPERV_HCALL_VTL_CALLS: KVM applies the TLFS semantics of
+HvCallVtlCall and HvCallVtlReturn for a VMM that switches between planes
+itself.  Both calls exit to userspace with KVM_EXIT_HYPERV_HCALL whether
+or not KVM_HYPERV_HCALL_FORWARD_UNKNOWN is enabled, but the hypercall
+instruction is already retired when the exit is delivered and
+``hyperv.u.hcall.result`` is ignored.  The calls follow the TLFS
+captured-register contract instead: on a successful switch the calling
+VTL's RAX and RCX are restored to their captured values when it next
+runs; on failure userspace writes the error status into the guest's RAX
+itself (KVM_SET_REGS) before resuming the vCPU.  While this bit is
+clear the two calls are ordinary hypercalls that KVM does not implement.
+
+KVM_HYPERV_HCALL_VTL_SWITCH: requires KVM_HYPERV_HCALL_VTL_CALLS, and
+KVM_ENABLE_CAP fails with -EINVAL if it is set alone.  KVM handles the
+non-fast forms of HvCallVtlCall and HvCallVtlReturn itself where it can:
+the calling plane's vCPU is suspended mid-hypercall and its twin in the
+target plane resumed, with the VTL-shared register state (GPRs except
+RSP, CR2, FPU) carried across and the entered VTL's assist page updated
+as the TLFS specifies.  A transition KVM cannot handle (a
+fast-form call, no twin vCPU in the target plane, a target that cannot
+be entered) exits to userspace as described for
+KVM_HYPERV_HCALL_VTL_CALLS, so the VMM must still implement the
+userspace switch.  A plane suspended by an in-kernel switch completes
+its hypercall when the opposite switch resumes it.  Resumed any other
+way (KVM_SET_PLANE_RUN_STATE, or a switch forwarded to userspace), it
+re-executes the hypercall and 'result' is not read.
+
 8. Other capabilities.
 ======================
 
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index f46a3494aacc..75861e54a041 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1090,6 +1090,11 @@ struct kvm_hv {
 	struct mutex hv_lock;
 	/* KVM_HYPERV_HCALL_* features enabled by KVM_CAP_HYPERV_FORWARD_HCALL */
 	u64 hcall_features;
+	/*
+	 * In-kernel VTL switches performed by this VM, counted against the
+	 * hv_vtl_switch_limit debug knob while it is set; never exceeds it.
+	 */
+	atomic_t vtl_switch_count;
 	/*
 	 * GUEST_OS_ID and the hypercall page are per-VTL instances in the
 	 * TLFS; bank them per plane so a higher VTL enabling its own
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index 8969e964cc0c..3d55ca709c29 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -254,6 +254,7 @@ static void synic_exit(struct kvm_vcpu_hv_synic *synic, u32 msr)
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNIC;
+	hv_vcpu->exit.plane = vcpu->plane_level;
 	hv_vcpu->exit.u.synic.msr = msr;
 	hv_vcpu->exit.u.synic.control = synic->control;
 	hv_vcpu->exit.u.synic.evt_page = synic->evt_page;
@@ -355,6 +356,7 @@ static void syndbg_exit(struct kvm_vcpu *vcpu, u32 msr)
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 
 	hv_vcpu->exit.type = KVM_EXIT_HYPERV_SYNDBG;
+	hv_vcpu->exit.plane = vcpu->plane_level;
 	hv_vcpu->exit.u.syndbg.msr = msr;
 	hv_vcpu->exit.u.syndbg.control = syndbg->control.control;
 	hv_vcpu->exit.u.syndbg.send_page = syndbg->control.send_page;
@@ -2817,10 +2819,11 @@ static void kvm_hv_hypercall_set_result(struct kvm_vcpu *vcpu, u64 result)
 	}
 }
 
-static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
+static int __kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result,
+				       bool skip)
 {
 	u32 tlb_lock_count = 0;
-	int ret;
+	int ret = 1;
 
 	if (hv_result_success(result) && is_guest_mode(vcpu) &&
 	    kvm_hv_is_tlb_flush_hcall(vcpu) &&
@@ -2832,7 +2835,8 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	kvm_hv_hypercall_set_result(vcpu, result);
 	++vcpu->stat.hypercalls;
 
-	ret = kvm_skip_emulated_instruction(vcpu);
+	if (skip)
+		ret = kvm_skip_emulated_instruction(vcpu);
 
 	if (tlb_lock_count)
 		kvm_nested_call(hv_inject_synthetic_vmexit_post_tlb_flush)(vcpu);
@@ -2840,11 +2844,51 @@ static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
 	return ret;
 }
 
+static int kvm_hv_hypercall_complete(struct kvm_vcpu *vcpu, u64 result)
+{
+	return __kvm_hv_hypercall_complete(vcpu, result, true);
+}
+
 static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 {
+	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
 	u64 result = vcpu->run->hyperv.u.hcall.result;
 	u64 flags = vcpu->run->hyperv.u.hcall.flags;
 	u64 valid = 0;
+	/*
+	 * A deferred completion (a userspace exit, or an in-kernel VTL
+	 * switch suspending this plane) runs on the vCPU's next KVM_RUN,
+	 * and the vCPU may have been moved in between: the higher VTL can
+	 * rewrite a suspended plane's RIP through HvCallSetVpRegisters (on
+	 * a hibernate resume the secure kernel points VTL0 at the
+	 * continuation), which userspace applies with KVM_SET_REGS.  Only
+	 * skip the hypercall instruction if the vCPU still sits on it.
+	 */
+	bool moved = !kvm_is_linear_rip(vcpu, vcpu->arch.cui_linear_rip);
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
+	/*
+	 * Resumed by an in-kernel VTL transition, which wrote RAX itself:
+	 * the run union has no say.  Retire the vmcall, unless the plane
+	 * was moved: then it resumes where it was pointed.
+	 */
+	if (hv_vcpu->hcall_kernel_result) {
+		hv_vcpu->hcall_kernel_result = false;
+		trace_kvm_hv_hypercall_done(kvm_rax_read(vcpu));
+		++vcpu->stat.hypercalls;
+		return moved ? 1 : kvm_skip_emulated_instruction(vcpu);
+	}
 
 	if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_RAISE_UD))
 		valid |= KVM_HYPERV_HCALL_UD;
@@ -2862,14 +2906,15 @@ static int kvm_hv_hypercall_complete_userspace(struct kvm_vcpu *vcpu)
 	/*
 	 * The VMM judged the hypercall to fault rather than return a
 	 * status: leave RIP at the hypercall instruction and raise #UD
-	 * there.
+	 * there.  A moved vCPU is no longer at the instruction the #UD
+	 * would target, so it gets the result instead.
 	 */
-	if (flags & KVM_HYPERV_HCALL_UD) {
+	if ((flags & KVM_HYPERV_HCALL_UD) && !moved) {
 		kvm_queue_exception(vcpu, UD_VECTOR);
 		return 1;
 	}
 
-	return kvm_hv_hypercall_complete(vcpu, result);
+	return __kvm_hv_hypercall_complete(vcpu, result, !moved);
 }
 
 static int kvm_hvcall_signal_event(struct kvm_vcpu *vcpu, struct kvm_hv_hcall *hc)
@@ -3006,14 +3051,274 @@ static int kvm_hv_hypercall_userspace_exit(struct kvm_vcpu *vcpu,
 
 	vcpu->run->exit_reason = KVM_EXIT_HYPERV;
 	vcpu->run->hyperv.type = KVM_EXIT_HYPERV_HCALL;
+	vcpu->run->hyperv.plane = vcpu->plane_level;
 	vcpu->run->hyperv.u.hcall.input = hc->param;
 	vcpu->run->hyperv.u.hcall.params[0] = hc->ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc->outgpa;
 	vcpu->run->hyperv.u.hcall.flags = 0;
+	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
+	/* Userspace owns this exit and writes hcall.result before KVM_RUN. */
+	to_hv_vcpu(vcpu)->hcall_resume_pending = false;
+	to_hv_vcpu(vcpu)->hcall_kernel_result = false;
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
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
+ * Debug knob: the number of in-kernel VTL switches a VM may perform
+ * before the rest are forwarded to userspace (-1: unlimited).
+ */
+static int hv_vtl_switch_limit = -1;
+module_param(hv_vtl_switch_limit, int, 0644);
+
+/*
+ * Plane twins carry the whole guest FPU image across a VTL switch, which
+ * is only exact when their fpstates have the same layout.
+ */
+static bool hv_vtl_fpstates_match(struct kvm_vcpu *a, struct kvm_vcpu *b)
+{
+	struct fpstate *fa = a->arch.guest_fpu.fpstate;
+	struct fpstate *fb = b->arch.guest_fpu.fpstate;
+
+	return fa && fb && fa->size == fb->size &&
+	       fa->xfeatures == fb->xfeatures;
+}
+
+/*
+ * In-kernel VTL call/return: switch between the plane vCPUs directly
+ * instead of bouncing every transition through userspace.  Keeps the
+ * userspace contract: VTL-shared register state (GPRs except RSP, CR2,
+ * FPU) follows the switch, the entered VTL's assist page gets the entry
+ * reason and the caller's RAX/RCX, and a non-fast VTL return restores
+ * the lower VTL's RAX/RCX from the returning VTL's control area.  The
+ * suspending plane stays suspended mid-hypercall: the switch that
+ * re-enters it writes its resume RAX, and its pending completion then
+ * only retires the vmcall.
+ *
+ * Returns -ENOENT when the transition cannot be handled here (no twin
+ * plane); the caller forwards the hypercall to userspace unchanged.
+ */
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
+	 * A plane userspace holds stays stopped until the VMM releases it.
+	 * Forward the switch so userspace can apply its own policy.
+	 */
+	if (target->plane_user_hold)
+		return -ENOENT;
+
+	/*
+	 * The resume protocol below delivers the result through the
+	 * target's armed hypercall completion.  A target parked on any
+	 * other completion (MMIO, PIO) owns the shared run union; writing
+	 * hcall.result over it would feed the pending completion garbage
+	 * and lose the resume value.  Forward such a switch to userspace.
+	 */
+	if (target->arch.complete_userspace_io &&
+	    target->arch.complete_userspace_io != kvm_hv_hypercall_complete_userspace)
+		return -ENOENT;
+
+	/*
+	 * Userspace owns HvCallEnableVpVtl state; the kernel only knows a
+	 * plane vCPU exists, and VMMs create those at setup time.  Refuse
+	 * to call into a plane that has never run: it still holds reset
+	 * state, and only userspace knows whether its VTL was enabled.
+	 * Forwarding lets userspace apply its enablement tracking (and run
+	 * the plane's first entry itself).
+	 */
+	if (!is_return && !kvm_hv_plane_has_run(target))
+		return -ENOENT;
+
+	/*
+	 * The FPU follows the switch as one image (see kvm_vtl_fpu_carry()).
+	 * KVM_SET_CPUID keeps the twins' layouts in step; should they still
+	 * differ, let userspace carry the state rather than lose part of it.
+	 */
+	if (!hv_vtl_fpstates_match(vcpu, target))
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
+			/*
+			 * No captured entry registers to restore: this plane
+			 * was last entered by userspace (or the capture was
+			 * lost across migration).  Forward the return so
+			 * userspace restores the lower VTL's RAX/RCX itself.
+			 */
+			if (!to_hv_vcpu(vcpu)->vtl_entry_regs_valid)
+				return -ENOENT;
+
+			ctl.vtl_ret_x64rax = to_hv_vcpu(vcpu)->vtl_entry_rax;
+			ctl.vtl_ret_x64rcx = to_hv_vcpu(vcpu)->vtl_entry_rcx;
+		}
+	}
+
+	/*
+	 * Debug budget on in-kernel switches, counted per VM.  Only a
+	 * switch that is actually performed consumes budget: the check
+	 * comes after every other reason to forward but the control-area
+	 * write, which gives the budget back when it fails, and the count
+	 * stops at the limit instead of growing past it.
+	 */
+	if (limit >= 0) {
+		atomic_t *count = &to_kvm_hv(vcpu->kvm)->vtl_switch_count;
+		int old = atomic_read(count);
+
+		do {
+			if (old >= limit)
+				return -ENOENT;
+		} while (!atomic_try_cmpxchg(count, &old, old + 1));
+	}
+
+	if (!is_return) {
+		/*
+		 * Write the entered VTL's control area through the entered
+		 * plane's vCPU: the write must pass that plane's memory
+		 * attributes and memslot view, and the higher VTL normally
+		 * protects its assist page against the caller's plane.
+		 * Fail before any state moves (mirroring the read above);
+		 * userspace then owns the switch.
+		 */
+		assist = hv_vtl_assist_page_gpa(target);
+		if (assist) {
+			/*
+			 * Write only the fields KVM maintains: KVM does not
+			 * emulate VINA, so vina_asserted belongs to the VMM.
+			 */
+			ctl.vtl_entry_reason = HV_VTL_ENTRY_REASON_VTL_CALL;
+			ctl.vtl_ret_x64rax = rax;
+			ctl.vtl_ret_x64rcx = rcx;
+			if (kvm_vcpu_write_guest(target,
+						 assist + HV_VTL_CONTROL_OFFSET,
+						 &ctl.vtl_entry_reason,
+						 sizeof(ctl.vtl_entry_reason)) ||
+			    kvm_vcpu_write_guest(target,
+						 assist + HV_VTL_CONTROL_OFFSET +
+						 offsetof(struct hv_vtl_control,
+							  vtl_ret_x64rax),
+						 &ctl.vtl_ret_x64rax,
+						 sizeof(ctl.vtl_ret_x64rax) +
+						 sizeof(ctl.vtl_ret_x64rcx))) {
+				if (limit >= 0)
+					atomic_dec(&to_kvm_hv(vcpu->kvm)->vtl_switch_count);
+				return -ENOENT;
+			}
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
+	vcpu->common->vtl_fpu_to = to;
+
+	if (!is_return) {
+		if (to_hv_vcpu(target)) {
+			to_hv_vcpu(target)->vtl_entry_rax = rax;
+			to_hv_vcpu(target)->vtl_entry_rcx = rcx;
+			to_hv_vcpu(target)->vtl_entry_regs_valid = true;
+		}
+		resume = rax;
+	} else {
+		if (!fast)
+			kvm_rcx_write_raw(target, ctl.vtl_ret_x64rcx);
+		resume = fast ? rax : ctl.vtl_ret_x64rax;
+		to_hv_vcpu(vcpu)->vtl_entry_regs_valid = false;
+	}
+
+	/*
+	 * The resume value is a full 64-bit register value (the caller's
+	 * RAX on a call or a fast return, the lower VTL's RAX from the
+	 * control area on a non-fast return).  No userspace exit is
+	 * involved, so it goes straight into the target's RAX rather than
+	 * through the run union.  A target suspended in a hypercall of
+	 * its own (any time after its very first entry) still has its
+	 * completion armed: it now only retires the vmcall, and until then
+	 * the suspended RIP stays at the vmcall, which the higher VTL can
+	 * observe (and rewrite) through HvCallGetVpRegisters.  A rewritten
+	 * RIP suppresses the deferred skip: the plane resumes exactly where
+	 * the higher VTL pointed it.  A target whose suspension already
+	 * retired its vmcall (forwarded switch) has no completion armed and
+	 * resumes where RIP points.
+	 */
+	kvm_rax_write_raw(target, resume);
+	if (target->arch.complete_userspace_io) {
+		to_hv_vcpu(target)->hcall_kernel_result = true;
+		to_hv_vcpu(target)->hcall_resume_pending = false;
+	}
+
+	/*
+	 * Suspend the current plane in its uncompleted hypercall; the
+	 * switch back will provide its resume value the same way.  Until
+	 * it does, hcall_resume_pending marks the run union as not holding
+	 * this plane's result.
+	 */
+	vcpu->arch.cui_linear_rip = kvm_get_linear_rip(vcpu);
+	to_hv_vcpu(vcpu)->hcall_resume_pending = true;
+	to_hv_vcpu(vcpu)->hcall_kernel_result = false;
+	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
+
+	vcpu->plane_suspended = true;
+	kvm_vcpu_set_plane_stopped(vcpu);
+	target->plane_suspended = false;
+	kvm_vcpu_set_plane_runnable(target);
+	kvm_make_request(KVM_REQ_PLANE_RESCHED, vcpu);
+	return 0;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu_hv *hv_vcpu = to_hv_vcpu(vcpu);
@@ -3178,7 +3483,60 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 			break;
 		}
 		return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
+	case HVCALL_VTL_CALL:
+	case HVCALL_VTL_RETURN:
+		/*
+		 * Without KVM_HYPERV_HCALL_VTL_CALLS these are hypercalls
+		 * KVM does not implement, like any other.
+		 */
+		if (!kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_CALLS))
+			goto unimplemented;
+		/* Neither call takes a variable header or rep count. */
+		if (unlikely(hc.rep || hc.var_cnt)) {
+			ret = HV_STATUS_INVALID_HYPERCALL_INPUT;
+			break;
+		}
+		if (kvm_hv_hcall_feature(vcpu->kvm, KVM_HYPERV_HCALL_VTL_SWITCH) &&
+		    !hc.fast &&
+		    !kvm_hv_vtl_switch(vcpu, hc.code == HVCALL_VTL_RETURN)) {
+			/*
+			 * Suspended mid-hypercall; the pending completion
+			 * delivers the result when the plane resumes.
+			 */
+			return 1;
+		}
+		/*
+		 * Retire the vmcall before the plane switch: the VMM fully
+		 * owns the resumed context (GPR copy, control-area RAX/RCX
+		 * restore).  A completion deferred across the suspension
+		 * fires on whatever entry resumes this plane next - after a
+		 * forced higher-VTL entry that can be an arbitrary
+		 * interrupted instruction, which then has RAX and RIP
+		 * rewritten with stale hypercall results.
+		 */
+		ret = kvm_hv_hypercall_userspace_exit(vcpu, &hc);
+		if (!ret) {
+			/*
+			 * With guest TF and KVM_GUESTDBG_SINGLESTEP the skip
+			 * prepares KVM_EXIT_DEBUG in the same run union,
+			 * overwriting the exit just prepared; the retired
+			 * vmcall would then be silently dropped and the VMM
+			 * never perform the switch.  Re-prepare the hypercall
+			 * exit in that case: the VMM must see it, at the price
+			 * of one missed step event.  A 0 return can also mean
+			 * the skip itself failed (SVM without NRIPS emulates it,
+			 * and an emulation failure prepares
+			 * KVM_EXIT_INTERNAL_ERROR); leave that exit alone.
+			 */
+			if (!kvm_skip_emulated_instruction(vcpu) &&
+			    vcpu->run->exit_reason == KVM_EXIT_DEBUG)
+				kvm_hv_hypercall_userspace_exit(vcpu, &hc);
+			vcpu->arch.complete_userspace_io = NULL;
+			return 0;
+		}
+		break;
 	default:
+unimplemented:
 		if (kvm_hv_hcall_feature(vcpu->kvm,
 					 KVM_HYPERV_HCALL_FORWARD_UNKNOWN))
 			return kvm_hv_hypercall_userspace_exit(vcpu, &hc);
diff --git a/arch/x86/kvm/hyperv.h b/arch/x86/kvm/hyperv.h
index 2617ee1e57b2..fc64fd0fd54f 100644
--- a/arch/x86/kvm/hyperv.h
+++ b/arch/x86/kvm/hyperv.h
@@ -115,6 +115,32 @@ struct kvm_vcpu_hv {
 		u64 vm_id;
 		u32 vp_id;
 	} nested;
+
+	/*
+	 * RAX/RCX of the lower VTL captured at VTL entry, restored on a
+	 * non-fast VTL return when this plane has no VP assist page to
+	 * carry them in its VTL control area.  Only valid between an
+	 * in-kernel VTL entry and the matching return: a plane entered by
+	 * userspace, or restored from migration, has no captured values
+	 * and its assist-less return is forwarded to userspace.
+	 */
+	u64 vtl_entry_rax;
+	u64 vtl_entry_rcx;
+	bool vtl_entry_regs_valid;
+	/*
+	 * An in-kernel VTL transition into this plane has already written
+	 * the full 64-bit resume value to RAX: the pending hypercall
+	 * completion only retires the vmcall, and must not take a result
+	 * from the run union.
+	 */
+	bool hcall_kernel_result;
+	/*
+	 * Set when an in-kernel VTL switch armed the deferred completion:
+	 * the resume value only arrives with the opposite-direction switch.
+	 * While set, the run union holds unrelated bytes and the completion
+	 * must retry the hypercall instead of consuming them.
+	 */
+	bool hcall_resume_pending;
 };
 
 /* "Hv#1" signature */
@@ -208,13 +234,27 @@ static inline bool kvm_hv_hypercall_enabled(struct kvm_vcpu *vcpu)
 
 /* Features reported and accepted by KVM_CAP_HYPERV_FORWARD_HCALL. */
 #define KVM_HYPERV_HCALL_SUPPORTED	(KVM_HYPERV_HCALL_FORWARD_UNKNOWN | \
-					 KVM_HYPERV_HCALL_RAISE_UD)
+					 KVM_HYPERV_HCALL_RAISE_UD | \
+					 KVM_HYPERV_HCALL_VTL_CALLS | \
+					 KVM_HYPERV_HCALL_VTL_SWITCH)
 
 static inline bool kvm_hv_hcall_feature(struct kvm *kvm, u64 feature)
 {
 	return READ_ONCE(to_kvm_hv(kvm)->hcall_features) & feature;
 }
 
+/*
+ * Whether a plane has a guest context to enter: it has entered the guest
+ * on this host, or an in-kernel VTL switch suspended it.  A migration
+ * destination reproduces the latter by restoring
+ * KVM_PLANE_RUN_STATE_SUSPENDED, while last_vmentry_cpu stays -1 until
+ * the plane next runs there.
+ */
+static inline bool kvm_hv_plane_has_run(struct kvm_vcpu *vcpu)
+{
+	return vcpu->arch.last_vmentry_cpu != -1 || vcpu->plane_suspended;
+}
+
 int kvm_hv_hypercall(struct kvm_vcpu *vcpu);
 
 void kvm_hv_irq_routing_update(struct kvm *kvm);
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index eefa8641100b..a63822defc3b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -4644,6 +4644,16 @@ static int __sev_snp_run_vmpl(struct vcpu_svm *svm, unsigned int vmpl)
 	if (!target)
 		return -EINVAL;
 
+	/*
+	 * In-kernel plane transitions never override a userspace hold
+	 * (KVM_PLANE_RUN_STATE_USER_HOLD).  There is no VMGEXIT exit to
+	 * forward the switch through, so fail KVM_RUN as for a missing
+	 * target, the same way kvm_vcpu_select_plane() refuses to resume a
+	 * held plane 0: the VMM owns releasing the plane.
+	 */
+	if (target->plane_user_hold)
+		return -EINVAL;
+
 	/* Mark current plane as stopped so it is not selected */
 	kvm_set_mp_state(target, KVM_MP_STATE_RUNNABLE);
 	/* In case KVM_REQ_UPDATE_PROTECTED_GUEST_STATE is set - mark the new VMSA as runnable */
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7246450533c7..2046dd0d27c1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -4361,6 +4361,10 @@ int kvm_vm_ioctl_enable_cap(struct kvm *kvm,
 		r = -EINVAL;
 		if (cap->args[0] & ~KVM_HYPERV_HCALL_SUPPORTED)
 			break;
+		/* The in-kernel switch falls back to the VTL_CALLS exit. */
+		if ((cap->args[0] & KVM_HYPERV_HCALL_VTL_SWITCH) &&
+		    !(cap->args[0] & KVM_HYPERV_HCALL_VTL_CALLS))
+			break;
 		WRITE_ONCE(to_kvm_hv(kvm)->hcall_features, cap->args[0]);
 		r = 0;
 		break;
@@ -9459,6 +9463,62 @@ void kvm_plane_share_dr6(struct kvm_vcpu *vcpu)
 		twin->arch.dr6 = vcpu->arch.dr6;
 }
 
+#ifdef CONFIG_KVM_HYPERV
+/*
+ * An in-kernel VTL switch carries the VTL-shared guest FPU state from the
+ * plane that switched away to the plane it entered.  Called once the
+ * source plane's inner run loop has returned, when kvm_put_guest_fpu()
+ * has saved its registers to its fpstate, and before KVM_RUN can return
+ * to userspace: the carry never outlives the KVM_RUN that performed the
+ * switch, so KVM_GET_XSAVE and KVM_GET_FPU on the entered plane always
+ * see the switched state, and KVM_SET_XSAVE or KVM_SET_FPU have no
+ * pending copy to race with.
+ */
+static void kvm_vtl_fpu_carry(struct kvm_vcpu_common *common)
+{
+	int from = common->vtl_fpu_from, to = common->vtl_fpu_to;
+	struct kvm_vcpu *src, *dst;
+	struct fpstate *sfps, *dfps;
+
+	if (from < 0)
+		return;
+
+	common->vtl_fpu_from = -1;
+	common->vtl_fpu_to = -1;
+	if (from >= KVM_MAX_PLANES || to < 0 || to >= KVM_MAX_PLANES)
+		return;
+
+	src = common->vcpus[from];
+	dst = common->vcpus[to];
+	if (!src || !dst || src == dst)
+		return;
+
+	sfps = src->arch.guest_fpu.fpstate;
+	dfps = dst->arch.guest_fpu.fpstate;
+
+	/*
+	 * The guest FPU is VTL-shared, as in the Nitro VSM implementation,
+	 * which banks no FPU state across a VTL switch: the entered VTL sees
+	 * exactly the registers the source VTL last held.  Copy the complete
+	 * register image, XSAVE header included, plus vcpu->arch.pkru, which
+	 * shadows the PKRU component outside the image.  Plane twins share
+	 * XCR0, and the switch is only performed in the kernel when their
+	 * fpstates match in size and features, so their XSAVES-compacted
+	 * layouts match and the whole-buffer copy is exact.  Supervisor
+	 * components follow the buffer (CET is not exposed to guests on this
+	 * stack).
+	 */
+	if (!sfps || !dfps || sfps->size != dfps->size ||
+	    sfps->xfeatures != dfps->xfeatures)
+		return;
+
+	memcpy(&dfps->regs, &sfps->regs, sfps->size);
+	dst->arch.pkru = src->arch.pkru;
+}
+#else
+static inline void kvm_vtl_fpu_carry(struct kvm_vcpu_common *common) {}
+#endif
+
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu_plane0)
 {
 	struct kvm_vcpu_common *common = vcpu_plane0->common;
@@ -9472,6 +9532,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu_plane0)
 
 		ret = __kvm_arch_vcpu_ioctl_run(vcpu, held);
 		kvm_plane_share_dr6(vcpu);
+		kvm_vtl_fpu_carry(common);
 		if (ret)
 		       break;
 	} while (vcpu_plane0->common->plane_switch);
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 966945f0504f..8346b2212c8c 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -440,6 +440,8 @@ union hv_vp_assist_msr_contents {	 /* HV_REGISTER_VP_ASSIST_PAGE */
 #define HVCALL_NOTIFY_LONG_SPIN_WAIT			0x0008
 #define HVCALL_SEND_IPI					0x000b
 #define HVCALL_ENABLE_VP_VTL				0x000f
+#define HVCALL_VTL_CALL					0x0011
+#define HVCALL_VTL_RETURN				0x0012
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX		0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX		0x0014
 #define HVCALL_SEND_IPI_EX				0x0015
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index d9e2767ed45d..09ed84886550 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -343,6 +343,17 @@ struct kvm_vcpu_common {
 	/* Currently active VCPU */
 	struct kvm_vcpu *current_vcpu;
 
+#ifdef CONFIG_KVM_HYPERV
+	/*
+	 * An in-kernel VTL switch moved execution from plane vtl_fpu_from
+	 * to plane vtl_fpu_to (-1: none pending); the run loop copies the
+	 * (VTL-shared) guest FPU state across once the source plane's FPU
+	 * has been saved, before KVM_RUN returns.
+	 */
+	int vtl_fpu_from;
+	int vtl_fpu_to;
+#endif
+
 	struct kvm_vcpu *vcpus[KVM_MAX_PLANES];
 
 	/* Locks */
@@ -479,6 +490,18 @@ struct kvm_vcpu {
 	unsigned plane_level;
 };
 
+/*
+ * Start with no in-kernel VTL switch FPU carry pending.  A no-op on
+ * configurations without the Hyper-V VTL switch.
+ */
+static inline void kvm_vcpu_init_vtl_fpu_carry(struct kvm_vcpu_common *common)
+{
+#ifdef CONFIG_KVM_HYPERV
+	common->vtl_fpu_from = -1;
+	common->vtl_fpu_to = -1;
+#endif
+}
+
 void kvm_vcpu_set_plane_runnable(struct kvm_vcpu *vcpu);
 void kvm_vcpu_set_plane_stopped(struct kvm_vcpu *vcpu);
 struct kvm_vcpu *kvm_vcpu_select_plane(struct kvm_vcpu *vcpu, bool *held);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index 89d76a917f6f..d63076e53b8e 100644
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
@@ -131,6 +131,8 @@ struct kvm_hyperv_exit {
 /* KVM_CAP_HYPERV_FORWARD_HCALL feature bits */
 #define KVM_HYPERV_HCALL_FORWARD_UNKNOWN	(1ULL << 0)
 #define KVM_HYPERV_HCALL_RAISE_UD		(1ULL << 1)
+#define KVM_HYPERV_HCALL_VTL_CALLS		(1ULL << 2)
+#define KVM_HYPERV_HCALL_VTL_SWITCH		(1ULL << 3)
 
 struct kvm_xen_exit {
 #define KVM_EXIT_XEN_HCALL          1
diff --git a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
index 5afc99ed533c..3c23479e60ce 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
@@ -159,6 +159,20 @@ static void test_feature_mask(struct kvm_vm *vm)
 	TEST_ASSERT(supported & KVM_HYPERV_HCALL_RAISE_UD,
 		    "KVM_HYPERV_HCALL_RAISE_UD not reported");
 
+	/* A bit KVM does not report must be rejected. */
+	if (!(supported & KVM_HYPERV_HCALL_VTL_CALLS)) {
+		r = __vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+				    KVM_HYPERV_HCALL_VTL_CALLS);
+		TEST_ASSERT(r && errno == EINVAL,
+			    "Enabling an unreported feature should fail with EINVAL");
+	}
+
+	/* In-kernel VTL switching is never valid without VTL_CALLS. */
+	r = __vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+			    KVM_HYPERV_HCALL_VTL_SWITCH);
+	TEST_ASSERT(r && errno == EINVAL,
+		    "VTL_SWITCH without VTL_CALLS should fail with EINVAL");
+
 	r = __vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, BIT_ULL(63));
 	TEST_ASSERT(r && errno == EINVAL,
 		    "Enabling an undefined feature should fail with EINVAL");
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 49d67a337c14..0a3cfdc624d7 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -517,6 +517,7 @@ static int kvm_vcpu_init_common(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned
 		goto out_drop_counter;
 	}
 	common->run = page_address(page);
+	kvm_vcpu_init_vtl_fpu_carry(common);
 
 	mutex_init(&common->mutex);
 
-- 
2.50.1

