Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793257;
	b=kXBoPujBtU6QqWNRFScfOJ0sUc21rnTVhIhi9EocnNNLyEg/DpFDkxWeYkEOZQQa8sgi
	 /K6IxFN4LQITE+NkbmJ/2XNOGatsGGT9MT4W/b+Sx9Aqke256C2+ODsFqIUisfLisVXwe
	 pDdiq8s/JvmcCSIUDl5AiDdMV3YTkGmWT0jHHm3nPqaKyK3mNDVAzTT0MxhMi5tNMjJdN
	 FZ5CG6o/6svn7rHfc0tGojSpj/VNSkQglwDXB07ASRGH/rBB0+xsixEGq95TZvjVGrgIt
	 5CG6OFz0KifnE/pK02H3dHbggWXijufN50aY0W8AiWeGOevfoRa8Cqdcjilx8f+x7dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793257;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=Me5ejnhbvE+lt/cdt2wcxwVEunlH/jA7EzGZDeDsqOU=;
	b=wo7q67mwEDHCqL+0u4ufG6xusJHkH6fb9NU67cFfN/PpvWA+f/v4YI0/P/N5C44sMuI5
	 2dMkn0GyTveYq/kJHw4Tgf2GzZZ88kOh43g0gdSCGTrIG7zwI9QUTSca2LNBOvbEyDtsB
	 ZQ0PL9Fj9nXR+FZH/XldgRlogC0ZjXur5b+Ano4a7EwfT9g8d2bzlAwvPnrER2ZP543El
	 k+LXZDFLLG3WJRALri13Yoi0EqsQwpI/m0YXIw8pTD+UwqlEOpmk6iS+nrgFviTktUWGB
	 ngnc0RnNZt9P6lDu21/nU3NDylkuh+VTmIt553yJgQdD+Tf9zyvjDqfGXzp7slPA5uQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=cqiXsnKK;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE30606A324;
	Fri, 27 Nov 2026 15:27:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EE30606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=cqiXsnKK
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=Me5ejnhbvE+lt/cdt2wcxwVEunlH/jA7EzGZDeDsqOU=; b=cqiXsnKKBRgqYB7+CLYmZEiFFq
	k/Q20b5SzVXJ7hV6TZzY/eozi1UgXTaVclA97epz0dTuAszR9xTnm0MYRwsvsDrVTdbjVKhIeMLGm
	9eCRr1syoIuQOFuEKA2G53/U8MR1y9HylJULWRC9iM47T+4jJgLbsbHN1Xjf+PQxG/c/2+IBgRNjJ
	FtW8UR5fQh3ElFkaOrJv5sov3iPuJeAQMG8NSB2M46zrEGr+IjN0ZgelLfJ1Da+IVodlu9nkAAYTp
	tfzb495aH68dkl5v+OJZS34Tm1Xbxhnq3w/+OdbBzv5ynsq3pcrfqXNhwiIk+OZccIZYstckjXaqD
	Zr2MG6cQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrG-0000000Gy1W-2RtC;
	Fri, 27 Nov 2026 15:27:30 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000Pq1-0cvY;
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
Subject: [PATCH v3 00/15] KVM: x86: Exit handling for Hyper-V hcalls, register intercept
Date: Fri, 27 Nov 2026 15:27:15 +0000
Message-ID: <20261127152730.99319-1-dwmw2@infradead.org>
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

Add KVM_CAP_HYPERV_FORWARD_HCALL. As with KVM_CAP_XEN_HVM and
KVM_CAP_EXIT_HYPERCALL, KVM_CHECK_EXTENSION returns a bitmask of
features and KVM_ENABLE_CAP takes the subset to enable. The first
feature, KVM_HYPERV_HCALL_FORWARD_UNKNOWN, surfaces unknown hypercalls
to userspace through the existing KVM_EXIT_HYPERV_HCALL exit.

A second feature, KVM_HYPERV_HCALL_RET, allows userspace to choose
whether/how the kernel should complete the hypercall, populating a
'ret' field with one of:

  KVM_INSN_COMPLETE   finish the instruction, as now
  KVM_INSN_GP         inject #GP(0) at it
  KVM_INSN_UD         inject #UD at it
  KVM_INSN_RESUME     do nothing; resume the guest as userspace left it

Hyper-V needs to do this in some cases, for example HvCallVtlCall and
HvCallVtlReturn are supposed to raise #UD when they are refused.

Further features will follow for HvCallVtlCall and HvCallVtlReturn on
VMs with planes, so that KVM can handle VTL transitions in the kernel.

Also add KVM_CAP_X86_REG_WRITE_FILTER for trapping control register
writes (CR0, CR4, XCR0, IDTR, LDTR, etc.).

Add KVM_CAP_X86_MSR_EXIT_INSN to allow MSR exits to gain the same
ability to COMPLETE/GP/UD/RESUME so that they can be handled by
another plane too. The existing 'error' field was already a u8 there,
so userspace can just opt in to using the new KVM_INSN_xxx values in
place of the existing 'non-zero means #GP' behaviour.

The VMware hypercall series¹ needs to fault its instruction too, and
with more than #GP. As posted, it has its exit carry a vector, an
error code and a fault address for KVM to inject. It can use the same
model, and the complex faults can be injected with KVM_SET_VCPU_EVENTS
followed by a ret of KVM_INSN_RESUME.

The completion result code deliberately does not cover:

 - PIO and MMIO. Those completions carry state which can't just be
   dropped, and VSM has no use for it: what a higher VTL intercepts
   there is the memory access, which faults before the instruction has
   done anything.

 - Guests with protected state. There is no instruction for KVM to
   leave alone, so MSR exits keep today's meaning (any non-zero value
   fails the access), a Hyper-V hypercall always completes, and a
   register write filter cannot be armed. Nor can one be armed for a
   plain SEV guest, whose instructions KVM cannot decode.

 - KVM_EXIT_HYPERCALL, KVM_EXIT_XEN and KVM_EXIT_TDX, which are
   untouched.

On an Intel Xeon 6 (itself a KVM guest, so VMX there is nested), on the
series as posted, the three new tests and hyperv_forward_hcall pass, as
do userspace_msr_exit_test, msrs_test, hyperv_features,
hyperv_extended_hypercalls, set_sregs_test, cr4_cpuid_sync_test,
xcr0_cpuid_test, smm_test and state_test: 13 of 13. The three with
emulator legs (msr_exit_insn_test, userspace_msr_exit_test and
reg_write_filter_test) pass again with kvm.force_emulation_prefix=1, as
do hyperv_forward_hcall and nested_reg_write_filter_test.

On a bare-metal AMD EPYC 9R14 (Zen 4), also on the series as posted,
the same 13 pass, and the same five again with
kvm.force_emulation_prefix=1. The three new tests also pass with
kvm_amd nrips=0, with and without forced emulation; there the
instruction lengths come from the emulator.

An earlier revision of these patches is at the base of the full VSM
tree², on which Windows Server 2025 boots with VBS and Credential
Guard, through the hypercall and register write exits.

One open question, on patch 7. It reports
HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE unconditionally, as it did in
v2, although only a VMM which handles forwarded hypercalls can honour
it.  I wonder if it should only be reported once the VMM has opted in,
perhaps just tied to KVM_HYPERV_HCALL_FORWARD_UNKNOWN. I've left it as
it is for now.

Based on v7.4-rc2. Also at:

  https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/exit-insn

Changes since v2³ of the hypercall forwarding series, which is patches
5-8 here. Everything else is new.

 - Drop KVM_VCPUEVENT_CANCEL_HCALL and the KVM_CAP_VCPU_EVENTS feature
   mask; the exit takes KVM_INSN_* in a 'ret' field instead (Sean⁴)
 - Drop vcpu_events_cancel_test; hyperv_forward_hcall covers 'ret'
 - Document that the feature mask only uses bits 0 to 30, and enforce
   it at build time
 - No allowlist of forwarded hypercalls. As discussed in the v2 thread⁵
   the capability is needed either way, and anything KVM learns to
   handle later has to be a new bit in its mask, so that a VMM which
   forwards that hypercall today keeps receiving it
 - The fix to the XMM helpers which Sashiko's review of the selftest
   led to⁶ is patch 1 here, now with a Fixes: tag

¹ https://lore.kernel.org/kvm/cover.1794374897.git.zack.rusin@broadcom.com/
² https://git.infradead.org/users/dwmw2/linux.git/shortlog/refs/heads/vsm3w/p4-startup
³ https://lore.kernel.org/kvm/20261113170535.79246-1-dwmw2@infradead.org/
⁴ https://lore.kernel.org/kvm/avuDUNAU_a933zvp@seanjc-mac.roam.internal/
⁵ https://lore.kernel.org/kvm/awCNTITOOiS1JEod@seanjc-mac.roam.internal/
⁶ https://lore.kernel.org/kvm/20261113181053.81779-1-dwmw2@infradead.org/

David Woodhouse (15):
  KVM: selftests: Make the x86 SSE register helpers volatile
  KVM: Define what completing an exit does with its instruction
  KVM: x86: Let userspace leave an MSR access alone
  KVM: selftests: Test MSR accesses which userspace leaves alone
  KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
  KVM: x86: hyper-v: Let userspace leave a hypercall uncompleted
  KVM: x86: hyper-v: Advertise XMM fast hypercall output
  KVM: selftests: Add Hyper-V hypercall forwarding test
  KVM: x86: Add a per-vCPU register write filter
  KVM: x86: Filter emulated CR0 and CR4 writes
  KVM: VMX: Support CR0 and CR4 write filters
  KVM: SVM: Support CR0 and CR4 write filters
  KVM: x86: Add descriptor-table registers to the write filter
  KVM: selftests: Add x86 register write filter test
  KVM: selftests: Test the register write filter with a nested guest

 Documentation/virt/kvm/api.rst                |  302 ++++-
 arch/x86/include/asm/kvm-x86-ops.h            |    1 +
 arch/x86/include/asm/kvm_host.h               |   23 +
 arch/x86/include/uapi/asm/kvm.h               |   17 +
 arch/x86/kvm/emulate.c                        |   54 +-
 arch/x86/kvm/hyperv.c                         |   28 +-
 arch/x86/kvm/hyperv.h                         |    9 +
 arch/x86/kvm/kvm_emulate.h                    |   28 +
 arch/x86/kvm/msrs.c                           |   75 +-
 arch/x86/kvm/regs.h                           |   43 +
 arch/x86/kvm/svm/nested.c                     |   16 +
 arch/x86/kvm/svm/sev.c                        |   22 +
 arch/x86/kvm/svm/svm.c                        |  138 ++-
 arch/x86/kvm/vmx/main.c                       |   13 +
 arch/x86/kvm/vmx/nested.c                     |   27 +-
 arch/x86/kvm/vmx/vmx.c                        |  167 ++-
 arch/x86/kvm/vmx/vmx.h                        |   14 +-
 arch/x86/kvm/vmx/x86_ops.h                    |    1 +
 arch/x86/kvm/x86.c                            |  343 +++++-
 arch/x86/kvm/x86.h                            |   34 +-
 include/uapi/linux/kvm.h                      |   35 +-
 tools/testing/selftests/kvm/Makefile.kvm      |    4 +
 .../selftests/kvm/include/x86/processor.h     |   33 +-
 tools/testing/selftests/kvm/lib/kvm_util.c    |    1 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  |  395 +++++++
 .../selftests/kvm/x86/msr_exit_insn_test.c    |  308 +++++
 .../kvm/x86/nested_reg_write_filter_test.c    |  362 ++++++
 .../selftests/kvm/x86/reg_write_filter_test.c | 1004 +++++++++++++++++
 28 files changed, 3437 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
 create mode 100644 tools/testing/selftests/kvm/x86/msr_exit_insn_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/nested_reg_write_filter_test.c
 create mode 100644 tools/testing/selftests/kvm/x86/reg_write_filter_test.c

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.50.1

