Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC7049158D;
	Sat, 17 Oct 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239920; cv=none; b=fdbQADDeMlKoFoG01VlwgZTUhnFeA8h79IilcSctxZrq8yI8b/k73RPvN77wq1bdVEzqvAFfn7gwTpOBVdOCRVphm1b8t1ZyZsa2ikSMBbSJNLlxnVu4HGpswnlYPvHJfUvALOB48RbIB8ZpcaZudfkMIYk2Cxgs8mhFBzAFaGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239920; c=relaxed/simple;
	bh=VmonMQNQEvT+KIRX0/Xw55/yWpG4wzyoRpO6of1g4IU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AKjKMpWj1XBo7ChshLd7M4MCeFRcGksRTJ3u9DkgpPrbxB0xoISlwy3IXvD8Ld3MvgZ736fkDLfIvKLLQsV4xqSyCtMVwZYGR/KA4LvdZXMabVzLqvOwVHKS0F69uRiOuFLXJ1cv1iEhjNdwoF1VIj8ZsE+YztbPsfDkNIrN9+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WCgXz196; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WCgXz196"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=4/j4hLYo4ZKdASbTs1SD/1QRFdf80rHDt9FHcVo24Jo=; b=WCgXz196SH7LweylMCamKShkHV
	areI3OOvaTLnwOX4nWtJX6zKuCzex6JGzdrvuJ/zZsJIL+UZuO6x0mjflEu1UCUPVhGm+lvbvuNFM
	410CmL2rXYJ7hn8ioKn06tIavnBdxOv8w9EsLlqXiDpdkP6ieWWPHqRV7XBaxUNdAqhHrbXDyk7jH
	WIBvV5i11xKA2diUt7qpp3tnVIW9iJdTYqI1obq6kZWSkTl+z0u0iunQKq+H2TTm8iEOU3ePjvzJ9
	JLTcpfSytV/8ygaGNfxcltTPFQTRs3g0LKxIDgyrhB1Qp0RrIKYhRzyvaDuQQhVDvmCdZXmVpDMkm
	bTVe7zQA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002LfB-1abf;
	Sat, 17 Oct 2026 12:25:14 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TB-00000002Yko-3Hf6;
	Sat, 17 Oct 2026 13:25:01 +0100
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
Subject: [RFC PATCH 00/55] KVM: x86: Hyper-V VSM (Virtual Trust Levels) on VM planes
Date: Sat, 17 Oct 2026 13:24:06 +0100
Message-ID: <20261017122501.610248-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
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

Windows uses Virtualization Based Security for Credential Guard and
friends, and enables it by default in current releases. A guest with
VBS enabled runs its secure kernel in VTL1, a higher privilege level
which the hypervisor has to keep isolated from the normal kernel in
VTL0. KVM has no concept of that today, so Windows guests either lose
VBS or emulate it with nested virtualization, which is slower and
loses features.

There have been completely in-kernel implementations of VBS, which
did unnatural things all within a single kvm_vcpu (four APICs, etc.)

This is an attempt to build it more cleanly, more in userspace, based
on KVM planes (https://lwn.net/Articles/1087590/).

The behavioural reference was the in-kernel VSM implementation in the
Nitro Hypervisor, complete with its latest compatibility fixes since
it was last posted — largely turned into a bunch of kvm unit
tests. The result boots Windows Server 2016 through 2025 with
Credential Guard active, on both Intel and AMD hosts, with VTL1
protecting its memory from VTL0. With hibernate/resume tested, since
that part has always been extra fun.

For now I've structured the userspace part as a separable library
which can be pulled into QEMU or other VMMs. Partly because QEMU
doesn't want it when AI did the typing (but *might* tolerate it as an
external library), and partly because I think it might make sense to
have a more permissively licensed standard implementation for how
KVM-based VMMs implement VSM, and have some input from the Microsoft
side and some improved expectation that it'll *keep* working with
Windows and not keep breaking for every new release. But that's a
future conversation. For now I'm just preempting the question, "why
does it look like that?".

 • https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/vsm
 • https://git.infradead.org/?p=users/dwmw2/qemu.git;a=shortlog;h=refs/heads/vsm
 • https://git.infradead.org/?p=users/dwmw2/kvm-unit-tests.git;a=shortlog;h=refs/heads/vsm

Pulled into my base tree on v7.1-rc7 (not reposted here):

 • KVM planes itself (Jörg's latest from June)
   https://lore.kernel.org/kvm/20260608144252.351443-1-joro@8bytes.org/
   https://github.com/joergroedel/linux/tree/kvm-planes-v7.1
 • Paolo's memory protection attributes v3
   https://lore.kernel.org/kvm/20260918135030.171564-1-pbonzini@redhat.com/
 • Melody Wang's SEV-SNP #HV doorbell / Restricted Injection series
   https://lore.kernel.org/all/cover.1777048608.git.huibo.wang@amd.com/
 • A few fixes to the above ride just above them in the git tree,
   each citing the report it addresses; not part of this posting

Generic fixes and features in KVM before we get to VSM itself:

 • Userspace opt-in (KVM_CAP_PLANES) and plane run-state ioctls;
   MP state, guest-debug, KVM_TRANSLATE, SETUP_MCE and a filtered
   KVM_ENABLE_CAP on plane vCPU fds; unwind of a failed
   KVM_CREATE_PLANE
 • Plane mechanics: per-plane request fan-out, kicking the twin
   that is actually running, XCR0 and TSC matching shared across
   twins, runtime CPUID per plane, APICv inhibited while planes
   are enabled (for now).
 • Per-plane memory attributes and overlays, and instruction state
   on the memory-fault exit, for the VMM to build intercept
   messages from
 • Fixes found along the way: KVM_TRANSLATE reporting a real
   write-access walk, SVM keeping TPR[3:0] across exits without a
   guest CR8 write

Finally we get to the actual Hyper-V VSM bits:

 • Hypercall forwarding to userspace (KVM_CAP_HYPERV_FORWARD_HCALL),
   with completion or injected #UD, for the VSM hypercalls KVM
   doesn't handle itself
 • HvCallVtlCall/HvCallVtlReturn switching between planes in the
   kernel; forced VTL entry gated on interrupt deliverability and
   re-armed when a plane suspends with IRR set
 • Per-plane Hyper-V state: GUEST_OS_ID/HYPERCALL MSRs, the
   reference TSC page, SynIC and event routing, TLB flushes
 • VTL register intercepts, including the descriptor-table load
   traps Credential Guard requires
 • The suspended-VP state (from Nikolas Wipper's series), refusal of
   SendIpi to a higher VTL, XMM fast hypercall output
 • Selftests for both halves; a hyperv_vsm suite for kvm-unit-tests
   covering VTL call/return, protections, intercepts and eventing
   follows separately

The four WIP-marked patches need finishing and splitting; they are
included because the series does not function without them. This is
very much an RFC.

Held back in the git tree for a follow-up posting:

 • KVM_TRANSLATE2 and the page-walker flags/status work (also
   Nikolas's), and the HvCallTranslateVirtualAddress handling built
   on it
 • TLB flush inhibit (TlbLocked)

Not done at all yet: VINA, and migration of mid-VTL-switch state
(the forced-entry and captured-register state has no GET/SET
exposure). The interaction with SEV-SNP VMPLs, the other consumer of
planes, is untested from this side.

Mushahid also has a version which boots Windows 11 on arm64, which
we'll reconcile when some of the dust settles.

I think this will take a while to reconcile and merge, even after
the base dependencies (planes, memattrs, etc.) are in. I'd like to
start settling the basic functionality so we can start preparing
to merge it in little pieces, if we can reach a general consensus.


David Woodhouse (44):
  KVM: x86/mmu: Move ACC_* masks from spte.h to mmu.h
  KVM: x86: Let userspace opt in to multiple planes with KVM_CAP_PLANES
  KVM: selftests: Add x86 planes lifecycle test
  KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
  KVM: selftests: Add Hyper-V hypercall forwarding test
  KVM: Add KVM_GET/SET_PLANE_RUN_STATE vCPU ioctls
  KVM: selftests: Cover plane run-state ioctls in planes_test
  KVM: x86: hyper-v: Let userspace fault a forwarded hypercall
  KVM: x86: Allow MP state ioctls on plane vCPU fds
  KVM: x86: Filter KVM_ENABLE_CAP on plane vCPU fds
  KVM: x86: initialise Hyper-V state on every plane vCPU
  KVM: implement per-plane memory attributes
  KVM: x86: hyper-v: bank GUEST_OS_ID and HYPERCALL MSRs per plane
  KVM: x86: hyper-v: bank the reference TSC page per plane
  KVM: x86: allow KVM_SET_GUEST_DEBUG on plane vCPU fds
  KVM: x86: hyper-v: flush the calling plane's TLB on flush hypercalls
  KVM: x86/mmu: free obsolete roots of all planes
  KVM: x86: hyperv: don't arm PV EOI for a higher plane's VP assist page
  KVM: x86: allow KVM_TRANSLATE on plane vCPU fds
  KVM: x86: hyper-v: handle VTL call/return in the kernel
  KVM: x86: load each plane twin while updating it after KVM_SET_CPUID
  WIP: userspace VTL interrupt entry and register intercepts
  WIP: KVM: x86: deliver events to suspended higher planes
  WIP: KVM: per-plane memory overlays, richer protection-fault exits
  WIP: KVM: x86: VSM event-delivery parity fixes from Windows boot
    triage
  KVM: planes: fan out per-plane requests to twin vCPUs
  KVM: x86: inhibit APICv when VM planes are enabled
  KVM: x86: hyperv: divert LLDT and LTR into register intercepts
  KVM: planes: Unwind published state on KVM_CREATE_PLANE failure
  KVM: planes: Kick the running twin's pCPU, not the request target's
  KVM: planes: Keep current_vcpu in sync in vcpu_load()
  KVM: x86: Report a real write-access walk from KVM_TRANSLATE
  KVM: planes: Share XCR0 across plane twins
  KVM: x86: hyperv: Refuse a synthetic IPI to a higher VTL
  KVM: x86: Gate forced VTL entry on interrupt deliverability
  KVM: selftests: Test a plane suspending with an undelivered interrupt
  KVM: x86: hyperv: Advertise XMM fast hypercall output
  KVM: SVM: Carry instruction state on reflected plane-protection faults
  KVM: SVM: Trap descriptor-table loads for VTL register intercepts
  KVM: SVM: Keep TPR[3:0] across exits without a guest CR8 write
  KVM: selftests: Add Hyper-V reference TSC page memory attribute test
  KVM: SVM: Hedge the v_tpr_entry comment
  KVM: Check every plane's protections before caching a gfn->hva
  KVM: planes: Annotate the lockless twin-publication protocol

Mushahid Hussain (9):
  KVM: x86: Leave TSC matching to the plane 0 vCPUs
  KVM: x86: hyperv: Track the reference TSC page per plane
  KVM: x86: hyperv: Update the reference TSC page past protections
  KVM: x86: hyperv: Publish an added reference TSC page at once
  KVM: x86: hyperv: Harden the per-plane reference TSC page updates
  KVM: x86: Derive runtime CPUID bits from the executing plane
  KVM: selftests: Test hugepage sizing over mixed protection attributes
  KVM: x86: hyperv: Do not skip a moved vCPU when completing a hypercall
  KVM: x86: Allow KVM_X86_SETUP_MCE on plane vCPUs

Nikolas Wipper (1):
  KVM: x86: Implement Hyper-V's vCPU suspended state

Paolo Bonzini (1):
  KVM: selftests: Add VM plane infrastructure and tests

 Documentation/virt/kvm/api.rst                | 241 ++++-
 arch/x86/hyperv/hv_apic.c                     |   3 +-
 arch/x86/include/asm/kvm-x86-ops.h            |   1 +
 arch/x86/include/asm/kvm_host.h               | 140 ++-
 arch/x86/kvm/cpuid.c                          | 139 ++-
 arch/x86/kvm/cpuid.h                          |   6 +-
 arch/x86/kvm/emulate.c                        |  21 +
 arch/x86/kvm/hyperv.c                         | 995 ++++++++++++++++--
 arch/x86/kvm/hyperv.h                         |  37 +-
 arch/x86/kvm/kvm_emulate.h                    |  10 +
 arch/x86/kvm/lapic.c                          |  85 +-
 arch/x86/kvm/mmu.h                            |  14 +
 arch/x86/kvm/mmu/mmu.c                        | 131 ++-
 arch/x86/kvm/mmu/paging_tmpl.h                |   7 +-
 arch/x86/kvm/mmu/spte.h                       |  14 -
 arch/x86/kvm/mmu/tdp_mmu.c                    |  23 +-
 arch/x86/kvm/svm/nested.c                     |  16 +
 arch/x86/kvm/svm/svm.c                        | 143 ++-
 arch/x86/kvm/svm/svm.h                        |  16 +-
 arch/x86/kvm/vmx/main.c                       |  13 +-
 arch/x86/kvm/vmx/nested.c                     |   1 +
 arch/x86/kvm/vmx/vmx.c                        | 118 ++-
 arch/x86/kvm/vmx/x86_ops.h                    |   1 +
 arch/x86/kvm/x86.c                            | 668 +++++++++++-
 include/hyperv/hvgdk_mini.h                   |   5 +-
 include/hyperv/hvhdk_mini.h                   |   3 +-
 include/linux/kvm_host.h                      | 149 ++-
 include/uapi/linux/kvm.h                      |  63 +-
 tools/include/uapi/linux/kvm.h                |  54 +-
 tools/testing/selftests/kvm/Makefile.kvm      |   7 +
 .../testing/selftests/kvm/include/kvm_util.h  |  74 ++
 .../selftests/kvm/include/x86/processor.h     |   1 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |  85 +-
 .../testing/selftests/kvm/lib/x86/processor.c |  15 +
 .../testing/selftests/kvm/memory_attributes.c |   6 +-
 tools/testing/selftests/kvm/plane_test.c      | 137 +++
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 144 +++
 .../selftests/kvm/x86/hyperv_tsc_page_attrs.c | 129 +++
 .../selftests/kvm/x86/memattr_hugepage_test.c | 132 +++
 .../selftests/kvm/x86/plane_x86_test.c        | 325 ++++++
 tools/testing/selftests/kvm/x86/planes_test.c | 142 +++
 .../selftests/kvm/x86/planes_vtl_entry_test.c | 188 ++++
 virt/kvm/kvm_main.c                           | 699 +++++++++++-
 virt/kvm/pfncache.c                           |   3 +-
 44 files changed, 4956 insertions(+), 248 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/plane_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c
 create mode 100644 tools/testing/selftests/kvm/x86/memattr_hugepage_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/plane_x86_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c

-- 
2.50.1

