Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=ffW0ve4RUwrwx36ZVDcuv0W2PbE2c+gXKmlZ2fWCdEI5Vsb0WAEkTt1g3VAC+FhBd6EM
	 mQTHaKewvQ3r0i8sXzsHuCFl049ORVm3Y8Wwaa+zn7dhZ+GMuWh6wal2/PAjQ1icMD3Mm
	 UbvlCyKNUX1vEGNcV7VRLYDdGsjBye1yNBdt8nqG0ibLCqXzeWcjus1j7ODtJZxo4/8qC
	 roMgiK9gIkdCiHHds1jFOCqAxehvItg+WTMswcK7vJNbHjhq3PoCj/X9ys8BtSsbG+6+i
	 VOEUQ81G2/FR4xEsWdi3eEFP6wr+mBQq9a94UyLukXEfdbnp/E6gVh0tNQqx9oInV0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=O1GtGqWtkfznp8Kf7GuLYgyA/j5cNUJBtJT7c2DPIHk=;
	b=p1AmhtiX4ljKSm0j8WOXYML+LgT2zv6wll/VR59QKgJGnQYNsFEOVpk3sOrZdVgVlfuj
	 QR+AdUuApJmXPzKCeIOv+clD/tSN6Oy7EA6TC1R1JiCldye2d3vRJ2FEh4BeYDmqzY4mi
	 JC8NQToAmRiSpXBIBckOH6X/U8+VSsanue7XeWZzc+Lra4SKromXStpW2NEP82B71uSJ3
	 BFIe2fm+b7G+Ds2BKRbyVlwWqBCECiCrvUwk4omJGdBzdXqhUMtRVX5beYpigEWoSPozA
	 I9XS2UJLX/K+sJHsOPgrv7k2SSEfDmBDOwHndQMYVdnU+5mZHKU9X/gowSyQHFZvIWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LNY1PcF4;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED1606A32D;
	Fri, 13 Nov 2026 18:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5AED1606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=LNY1PcF4
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=O1GtGqWtkfznp8Kf7GuLYgyA/j5cNUJBtJT7c2DPIHk=; b=LNY1PcF4mFw3+GLaFORDnJT4H1
	yIp1vaYpxXms78GrzapeRtJ+PkDH87MjZ08gy+yeMc7Ydvqki0gcUJw92+Zm6kKF59gOoO9ACYW92
	ZNezc7WIv+r02Mk7Y1nzdEWOCRPRUz9tvXR367hA9OjW4A1kL2PSEZmfCbfqCpQX1h6/yL7bJKKSc
	buC3AtPkXoQJSbnq48mrVx0t2atSxMCg4FhBSmXGRmtSeM7XZ7GPAcu+kaOGVrKfUnayK4/4GqdUJ
	lKRR0xVNoJUz9C7y0AL/ORr3E/u/16lA3t0vY8j9ImoyrdMOew5d6zd+GM3hmx4q56QD+aG5p5NI6
	+8mZPAzQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6r-00000004gPQ-0yWA;
	Fri, 13 Nov 2026 18:34:49 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000LsU-01Mg;
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
Subject: [RFC PATCH v2 00/31] KVM: x86: Hyper-V VSM (Virtual Trust Levels) on VM planes
Date: Fri, 13 Nov 2026 18:34:16 +0000
Message-ID: <20261113183448.84094-1-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

This is v2 of the Hyper-V VSM support¹: Windows Virtualization Based
Security running natively on KVM planes, with the secure kernel in
VTL1 isolated from the normal kernel in VTL0, instead of using nested
virtualization.

This is still largely AI-written with minimal oversight so far; it's
presented to show the direction and for testing, not for detailed
review.

As before, it boots Windows Server 2016 through 2025 with Credential
Guard active, on both Intel and AMD hosts, with VTL1 protecting its
memory from VTL0, and survives hibernate/resume. It also runs VBS
enclaves: the full CreateEnclave / LoadEnclaveImage / InitializeEnclave
/ CallEnclave cycle behaves as it does on real Hyper-V. The userspace
side is still a separable, permissively-licensed library, pulled into
QEMU for testing.

Since v1:

 • Rebased to v7.4-rc2. Paolo's memory protection attributes are now
   merged in from kvm.git² rather than carried as patches.
 • Three parts grew up and left home: the fixes to Jörg's series³,
   the forwarding of unimplemented Hyper-V hypercalls to userspace⁴
   and the generic plane userspace API⁷ are posted separately, and
   this series is based on them.
 • This is now the *minimum* VSM: what it takes to boot Windows with
   Credential Guard and keep VTL1's memory protected. The parts it
   can live without — KVM_TRANSLATE on plane fds, VTL-switch
   statistics, the Hyper-V vCPU suspended state and the TLB flush
   inhibit (KVM_HYPERV_SET_TLB_FLUSH_INHIBIT) — sit above it in git⁵
   and will follow once this part makes sense to people.
 • KVM_TRANSLATE2 is gone. The userspace library walks the guest
   page tables itself for HvTranslateVirtualAddress, which it turned
   out to need to do anyway.
 • The hypercall exit gained a flags field (KVM_HYPERV_HCALL_UD) for
   fault injection instead of stealing bit 63 of the result, so a
   forwarded hypercall can return a full 64-bit result.
 • A pile of fixes from review, each noted in its commit.

The base is Jörg's KVM Planes + SEV-SNP series⁶ with the fixes³ and
the plane userspace API⁷ applied; kvm-memprot-v4² and the hypercall
forwarding⁴ are merged on top. None of that is reposted here. The
whole assembly, and the userspace to drive it:

 • https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/vsm2/vsm-min (tag vsm2-min1)
 • https://git.infradead.org/?p=users/dwmw2/qemu.git;a=shortlog;h=refs/heads/vsm-v2
 • https://git.infradead.org/?p=users/dwmw2/kvm-unit-tests.git;a=shortlog;h=refs/heads/vsm-v2

The 31 patches here are VSM itself: per-plane memory
attributes and overlays, the per-plane Hyper-V state (GUEST_OS_ID,
hypercall page, reference TSC page, SynIC, STIMER), VTL call/return
and the VTL-protection fault path, interrupt preemption and forced
VTL entry, and the register intercepts Windows actually uses.

Patch 28 (KVM: SVM: Keep TPR[3:0] across exits without a guest CR8
write) is a fix in its own right: the bug exists without planes, so
it should probably be applied standalone. I can send it separately
if wanted.

¹ https://lore.kernel.org/kvm/20261017122501.610248-1-dwmw2@infradead.org/
² git://git.kernel.org/pub/scm/virt/kvm/kvm.git kvm-memprot-v4
³ https://lore.kernel.org/kvm/20261111222911.477-1-dwmw2@infradead.org/
⁴ https://lore.kernel.org/kvm/20261111205836.4186584-1-dwmw2@infradead.org/
⁵ https://git.infradead.org/?p=users/dwmw2/linux.git;a=shortlog;h=refs/heads/vsm2/vsm-extras
⁶ https://lore.kernel.org/kvm/20260608144252.351443-1-joro@8bytes.org/
⁷ https://lore.kernel.org/kvm/20261113182607.82813-1-dwmw2@infradead.org/

David Woodhouse (30):
  KVM: Implement per-plane memory attributes
  KVM: x86: hyper-v: Bank GUEST_OS_ID and HYPERCALL MSRs per plane
  KVM: x86: hyperv: Maintain a reference TSC page for each plane
  KVM: x86: hyperv: Flush every plane twin on TLB flush hypercalls
  KVM: x86: hyperv: Don't arm PV EOI for a higher plane's VP assist page
  KVM: x86: hyper-v: Handle VTL call/return in the kernel
  KVM: selftests: Cover single-step over a forwarded VTL call
  KVM: x86: hyperv: Let higher-VTL interrupts preempt a lower VTL
  KVM: x86: hyperv: Divert intercepted descriptor-table loads
  KVM: x86: Keep APICv off on higher-plane vCPUs
  KVM: x86: hyperv: Make KVM_REQ_HV_STIMER a per-plane request
  KVM: x86: Kick lower twins when an event lands on a suspended plane
  KVM: x86: hyperv: Suppress SynIC exits from higher planes
  KVM: VMX: Report GVA and instruction bytes on plane-protection faults
  KVM: x86: hyperv: Divert LLDT and LTR into register intercepts
  KVM: Add per-plane memory overlays
  KVM: x86: hyperv: Deliver higher-plane SynIC messages through overlays
  KVM: x86: hyperv: Truncate higher-VTL vAPIC MSR writes
  KVM: x86: Fold an NMI for a higher plane back to plane 0
  KVM: x86: hyperv: Honour in_vtl in synthetic cluster IPIs
  KVM: x86: Gate and re-arm forced VTL entry on interrupt deliverability
  KVM: selftests: Test a plane suspending with an undelivered interrupt
  KVM: selftests: Check that a masked higher-plane timer is no event
  KVM: selftests: Check that a restored higher-plane interrupt forces an
    exit
  KVM: selftests: Check that a higher plane's NMI survives HLT and
    suspension
  KVM: selftests: Check that a VTL switch keeps bit 63 of RAX
  KVM: SVM: Carry instruction state on reflected plane-protection faults
  KVM: SVM: Keep TPR[3:0] across exits without a guest CR8 write
  KVM: selftests: Add Hyper-V reference TSC page memory attribute test
  KVM: Document the two scopes of KVM_REQUEST_PER_PLANE

Sriram Nambakam (1):
  KVM: x86: hyperv: Do not divert descriptor-table writes in SMM

 .../admin-guide/kernel-parameters.txt         |    9 +
 Documentation/virt/kvm/api.rst                |  193 ++-
 arch/x86/hyperv/hv_apic.c                     |    3 +-
 arch/x86/include/asm/kvm-x86-ops.h            |    1 +
 arch/x86/include/asm/kvm_host.h               |   95 +-
 arch/x86/kvm/emulate.c                        |   21 +
 arch/x86/kvm/hyperv.c                         | 1150 +++++++++++++++--
 arch/x86/kvm/hyperv.h                         |   92 +-
 arch/x86/kvm/kvm_emulate.h                    |   10 +
 arch/x86/kvm/lapic.c                          |   80 +-
 arch/x86/kvm/lapic.h                          |    3 +
 arch/x86/kvm/mmu/mmu.c                        |  108 +-
 arch/x86/kvm/mmu/paging_tmpl.h                |    5 +-
 arch/x86/kvm/mmu/tdp_mmu.c                    |   23 +-
 arch/x86/kvm/msrs.c                           |   20 +-
 arch/x86/kvm/svm/nested.c                     |   16 +
 arch/x86/kvm/svm/sev.c                        |   34 +
 arch/x86/kvm/svm/svm.c                        |  200 ++-
 arch/x86/kvm/svm/svm.h                        |   13 +
 arch/x86/kvm/vmx/main.c                       |   13 +
 arch/x86/kvm/vmx/nested.c                     |    1 +
 arch/x86/kvm/vmx/vmx.c                        |  131 +-
 arch/x86/kvm/vmx/x86_ops.h                    |    1 +
 arch/x86/kvm/x86.c                            |  546 +++++++-
 arch/x86/kvm/x86.h                            |    3 +
 include/hyperv/hvgdk_mini.h                   |    5 +-
 include/hyperv/hvhdk_mini.h                   |    3 +-
 include/linux/kvm_host.h                      |  144 +++
 include/uapi/linux/kvm.h                      |   48 +-
 tools/testing/selftests/kvm/Makefile.kvm      |    6 +
 .../testing/selftests/kvm/include/kvm_util.h  |    1 +
 .../selftests/kvm/include/x86/hyperv.h        |    8 +
 tools/testing/selftests/kvm/lib/kvm_util.c    |   11 +
 .../testing/selftests/kvm/memory_attributes.c |    6 +-
 .../testing/selftests/kvm/x86/hyperv_clock.c  |    7 -
 .../selftests/kvm/x86/hyperv_forward_hcall.c  |   92 +-
 .../selftests/kvm/x86/hyperv_tsc_page_attrs.c |  131 ++
 .../selftests/kvm/x86/planes_vtl_entry_test.c |  186 +++
 .../kvm/x86/planes_vtl_nmi_halt_test.c        |  305 +++++
 .../kvm/x86/planes_vtl_restore_test.c         |  121 ++
 .../kvm/x86/planes_vtl_return_test.c          |  204 +++
 .../kvm/x86/planes_vtl_timer_mask_test.c      |  177 +++
 virt/kvm/kvm_main.c                           |  535 +++++++-
 virt/kvm/pfncache.c                           |    3 +-
 44 files changed, 4530 insertions(+), 234 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_entry_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_nmi_halt_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_restore_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_return_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_timer_mask_test.c

-- 
2.50.1

