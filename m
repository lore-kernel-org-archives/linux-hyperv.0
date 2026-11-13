Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589547;
	b=0RgATvpKhv/QUsk89Wqgula75JNi+qox7VG+4+f158tYVnk5ulxFULYSAi9QDskJkIsL
	 ymLF6GZsrYtuX7OuadfLJAhfJpqbXGwnAEI7JQFFaIAvXmj5QvzABLNRcbfm29EDGpe29
	 pkLkl+PjZ7YguDtLpQzQHeH+tpsFE2fsGdicuHcGacxkQgOeX7pzol+7rx0mozNG525HW
	 +gPHADtmYJwrN5h0+YB9wha3fOrSuJ3pbr/vZR/yKXTD1o93hkyhW5WiAoLlq4nQiPc10
	 BoJ5x8yZbqi02lDsaBPsPSKsLdV04761MdmN3hvCf5TepWsA5CpiQcUO7JKLqHnPM5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589547;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Sender:X-SRS-Rewrite;
	bh=ESsgt/TRagJZAJHymZDUQcxn7gpvuI5G4jdddBBCKdU=;
	b=REsKHxTbFQq2tR1AZTUmUUuwGRBEkn3PQtLUN+tIiqNg1LzWX33/yUEmr1iLfMe0l5na
	 GxM6gVpkIQ21a9uylw97bNwuzYLt36IQgdK2f5vJJ65KVFhO3e6oCtUxPmT4HacDdKJJu
	 8lu1C98MxjAAtXWB6z4JnHUmjGgMWKDBzuUuB/p1w/hV8owxbEYcOg6+Se9RTpKLjGekN
	 SW3V+5EMvwphjyryaY3LZ8+MYphqRhPkFZzrpKZzCh5HVZL6gG4DTWiAknCQnhXD0MaqE
	 R41SMduN8rdjJXxhbYMAos35kcmO12birF24bs2yxK25t14r5aHNr/btZgDASm2BJ1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nnRGQxL7;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF71B606A335;
	Fri, 13 Nov 2026 17:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF71B606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=nnRGQxL7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=ESsgt/TRagJZAJHymZDUQcxn7gpvuI5G4jdddBBCKdU=; b=nnRGQxL706oJDJc4leNwyszS7C
	3F7+EAyJOvvo0NLCWCwiNOo4jvShMeGhJF1UAfwUGBhd0v8EGgV8P5ZhmVxWO5vdDeMJioq2KdqEH
	115DeZjJIJ6GR5dbCLSbkE/vXGx4KPY3ScdMjeOvigvtcutMaxPnW2FCgZL53iLX+oX3bBBpvgxl3
	C6Vqm2PfHuZdo2lUtPooCtCIkKdvEXuLL3BJvI6RAuuO1Rv0n/B8jBWrQyPqYhuxJYRZyjoNwU8m2
	KLZLNizNSSSuagkCHjiPYWHJCMH53j9QRkd6oUaQpDSemI2U1XRUSwaYEi+UiAR9N6hSIskCowDd7
	x+ZAfOMQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuiV-00000003oWA-4BTT;
	Fri, 13 Nov 2026 17:05:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRuiV-00000000KcG-36IQ;
	Fri, 13 Nov 2026 17:05:35 +0000
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <shuah@kernel.org>,
	Paul Durrant <paul@xen.org>,
	Xin Li <xin@zytor.com>,
	Francesco Lavra <flavra@baylibre.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	Liran Alon <liran.alon@oracle.com>,
	Arbel Moshe <arbel.moshe@oracle.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH v2 0/4] KVM: x86: hyper-v: Forward unimplemented hypercalls to userspace
Date: Fri, 13 Nov 2026 10:05:31 -0700
Message-ID: <20261113170535.79246-1-dwmw2@infradead.org>
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
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

KVM implements a fixed set of Hyper-V hypercalls and fails every other
code with HV_STATUS_INVALID_HYPERCALL_CODE. A VMM that wants to
implement more of the TLFS, such as the VSM hypercalls Windows uses for
Virtualization Based Security, never sees them.

This series adds KVM_CAP_HYPERV_FORWARD_HCALL. As with KVM_CAP_XEN_HVM
and KVM_CAP_EXIT_HYPERCALL, KVM_CHECK_EXTENSION returns a bitmask of
features and KVM_ENABLE_CAP takes the subset to enable, rejecting any
bit the kernel does not report. The first feature,
KVM_HYPERV_HCALL_FORWARD_UNKNOWN, sends the hypercalls KVM does not
implement, and extended hypercalls in fast form, out through the
existing KVM_EXIT_HYPERV_HCALL exit, whose format does not change at
all. Further mask bits will follow for HvCallVtlCall and HvCallVtlReturn
on VMs with planes, so that KVM can handle VTL transitions in the
kernel.

Patch 2 lets userspace cancel the pending completion of a hypercall
that exited to userspace, with a new KVM_VCPUEVENT_CANCEL_HCALL flag on
KVM_SET_VCPU_EVENTS. The guest then re-executes the hypercall, unless
the same ioctl queued an exception to be delivered at it. That is how a
VMM makes a hypercall raise #UD (or #PF with CR2, or anything else the
events machinery can queue), which the TLFS specifies for some invalid
uses, instead of returning a status. It is independent of the rest of
the series: in v1 this was a #UD request flag in the hcall exit itself,
but the KVM_EXIT_VMWARE series [1] wants the same for other exits and
other vectors, and KVM_SET_VCPU_EVENTS already knows how to queue every
exception shape, so v2 adds only the cancel primitive and lets the
existing machinery do the rest. KVM_SET_VCPU_EVENTS has no flag
discovery, so KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) becomes a
feature mask (bit 0 keeps truth-value checks working, bit 1 advertises
the cancel). The KVM_VCPUEVENT_ namespace so far only holds VALID_*
field gates; if the action flag wants a different name, I am not
attached to this one.

Patch 3 reports HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE, since a VMM
handling a forwarded fast hypercall can write the XMM output itself.
Patch 4 adds the Hyper-V forwarding selftest; the generic cancel error
paths come with patch 2's own selftest.

v1->v2:
 - Drop KVM_HYPERV_HCALL_RAISE_UD, KVM_HYPERV_HCALL_UD and the hcall
   exit's flags field; cancel the completion through
   KVM_SET_VCPU_EVENTS instead (patch 2).
 - Selftests: a generic vcpu_events_cancel_test, and forwarding-test
   legs for cancel+#UD (RIP and RAX untouched), cancel alone (the
   hypercall exits a second time), and EBUSY with nothing cancellable
   pending.

The series is based on v7.4-rc2. Tested on a bare-metal AMD EPYC
(Zen 4) system: vcpu_events_cancel_test and hyperv_forward_hcall pass,
as do hyperv_clock, hyperv_cpuid, hyperv_extended_hypercalls,
hyperv_features, hyperv_ipi, hyperv_tlb_flush and hyperv_svm_test, plus
triple_fault_event_test and nested_exceptions_test for the
KVM_SET_VCPU_EVENTS change. Not yet retested on Intel.

[1] https://lore.kernel.org/all/90467782be23b83fd3e9a6afe2f1d2149eaf9db9.1794374897.git.zack.rusin@broadcom.com/

David Woodhouse (4):
  KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
  KVM: x86: Let userspace cancel a pending hypercall completion
  KVM: x86: hyper-v: Advertise XMM fast hypercall output
  KVM: selftests: Add Hyper-V hypercall forwarding test

 Documentation/virt/kvm/api.rst                |  73 ++++
 arch/x86/include/asm/kvm_host.h               |   4 +
 arch/x86/include/uapi/asm/kvm.h               |   7 +
 arch/x86/kvm/hyperv.c                         |  14 +-
 arch/x86/kvm/hyperv.h                         |   8 +
 arch/x86/kvm/x86.c                            |  51 ++-
 include/uapi/linux/kvm.h                      |   4 +
 tools/testing/selftests/kvm/Makefile.kvm      |   2 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 337 ++++++++++++++++++
 .../kvm/x86/vcpu_events_cancel_test.c         | 119 +++++++
 10 files changed, 616 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
 create mode 100644 tools/testing/selftests/kvm/x86/vcpu_events_cancel_test.c

-- 
2.50.1

