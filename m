Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794430720;
	b=gTVnLcDcyyXlp8bNTG1gZBBDSQTPfWGxvEz6OLeyNJRC5l+sPyKBMwO52cjuS1br1uBX
	 4aH/xRkcAdofyH4bntR9IgF0zfq7Ya2z/43aND05JKpZeTQY+PJ7mpqtYSogP+RAKNJAK
	 lroJCELsEeqxVWyMQ3LlYv0eboKo5Qa2dhYllBqNrmOHhKX++dHHzbEs+YE2STkeNneAS
	 hfzk48BjFPL+vuXKQioAK6OvvSKk7RwAP1NryiRWfH2+LFEM4YsKrnOb/AZHVvNpfU6sB
	 COhOQ9xxRdlHcUO4R92dCR9nin/r7w01bvPfPuiQCHd389J2MKSFg1AuMQNRAkbU+sQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794430720;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 Sender:X-SRS-Rewrite;
	bh=YUFQ0BzuROj7vKv1gEx2DSIYXCVTpEtb08fn/aq/i9g=;
	b=GeuFDTAl0cT3P7khb19Uz+hKkDPwMXJYx2I3bGHIiuQUo2UMBM3fgvliYtsg8x+JXsac
	 dFr0k+mZzZoXdS1kQIZVHlL2AhfAQjiTdhA0Aki/8b3KxSNp6mRvDkKl7IWFQGL8YNl2Z
	 YJy5B+Pp/opguZ2QW7rHY9ErJ75q29FMvSjFOj3v9dlz2Tty+v8JL7axJNMGie2NYC4IX
	 QT3vjZWCzoTJjD0FazqXJ+gbMMSJpqsrJC9BLOoV60tn/JEE9HqrqTeMIj93W+jZfu+SR
	 45QSMIeKzhtB1b207othSHe6cyBqIFeLtenlfW1szYLI/Rj8UgwxkZHW32coufxqQnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=BYRXdC+e;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F6F606A31C;
	Wed, 11 Nov 2026 20:58:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F6F606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=BYRXdC+e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=YUFQ0BzuROj7vKv1gEx2DSIYXCVTpEtb08fn/aq/i9g=; b=BYRXdC+eNh2MLKCFHYtHOlfJ7x
	z0WWYh4ivfCNrvP1yonwgAV9TfOEeQGWAunQ4KkAWk5oawGTBATJXrNIIsUjbki8DTlnbbCMnNBZ1
	xQmY4VFdEtau8ifckcdm3GOhnw6LtTT8mK5znOGEaJRFyfWBO4vxDlIk1/zjfNeB3ybwSwZGf6kfC
	GVAmpEsPglkv1Bi3filNDXrol1TLz4CcE7zaZ6GB1ABadukinFf2NYrMXGKJ/95aw8xI7lDS2x7mF
	MSnxXPE/5ZFivEjWfpXuZm6DmKvHYDKpWe7msuJoKyE0Fzvhqy/p5hnBTIoY8QDt1HdbcqbEAUw0L
	yS3nQQMA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRFOu-0000000Ea66-3PGx;
	Wed, 11 Nov 2026 20:58:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRFOu-0000000HZ7e-2DQI;
	Wed, 11 Nov 2026 20:58:36 +0000
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
	Sriram Nambakam <snambakam@linux.microsoft.com>,
	David Woodhouse <dwmw@amazon.co.uk>
Subject: [PATCH 0/4] KVM: x86: hyper-v: Forward unimplemented hypercalls to userspace
Date: Wed, 11 Nov 2026 12:58:32 -0800
Message-ID: <20261111205836.4186584-1-dwmw2@infradead.org>
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
bit the kernel does not report:

 - KVM_HYPERV_HCALL_FORWARD_UNKNOWN (bit 0) sends the hypercalls KVM
   does not implement, and extended hypercalls in fast form, out
   through the existing KVM_EXIT_HYPERV_HCALL exit.

 - KVM_HYPERV_HCALL_RAISE_UD (bit 1) lets userspace complete such an
   exit by raising #UD at the hypercall instruction, which the TLFS
   specifies for some invalid uses, instead of returning a status.
   Userspace asks for that with KVM_HYPERV_HCALL_UD in a new 'flags'
   field after the hypercall parameters; KVM zeroes it on every exit,
   and refuses bits it does not know. The field fits in the existing
   union, so struct kvm_run does not grow.

Further mask bits will follow for HvCallVtlCall and HvCallVtlReturn on
VMs with planes, so that KVM can handle VTL transitions in the kernel.

Patch 3 reports HV_X64_HYPERCALL_XMM_OUTPUT_AVAILABLE, since a VMM
handling a forwarded fast hypercall can write the XMM output itself.
Patch 4 adds a selftest.

This is orthogonal to KVM_CAP_HCALL_FAULT_EXIT in the memory attributes
series, which Vitaly asked about on v3 [2]. That one is about a memory
fault *during* the processing of a hypercall KVM does implement, which
it turns into KVM_EXIT_MEMORY_FAULT. This one is about the hypercalls
KVM does not implement at all. A forwarded hypercall goes out to
userspace before KVM touches any guest memory on its behalf, so the two
never meet, and a VMM can use either without the other.

This is the first part of the VSM work posted as an RFC [1] that does
not depend on planes or memory attributes.

The series is based on v7.4-rc2 and also applies cleanly to
kvm-x86/next (cbe54fc3462b). It has been compile-tested on x86_64 with
and without CONFIG_KVM_HYPERV.

Tested on v7.4-rc2 with this series and the KVM_TRANSLATE fix posted
alongside it, on an Intel Xeon 6 system (itself a KVM guest, so VMX
there is nested) and on a bare-metal AMD EPYC (Zen 4) system. The new
hyperv_forward_hcall selftest passes on both, as do hyperv_clock,
hyperv_cpuid, hyperv_extended_hypercalls, hyperv_features, hyperv_ipi
and hyperv_tlb_flush. hyperv_evmcs passes on Intel and hyperv_svm_test
on AMD, each skipping on the other vendor.

[1] https://lore.kernel.org/kvm/20261017122501.610248-1-dwmw2@infradead.org/
[2] https://lore.kernel.org/kvm/kupv77y5yrc.fsf@vkuznets-thinkpadx1carbongen12.rmtcz.csb/

David Woodhouse (4):
  KVM: x86: hyper-v: Add KVM_CAP_HYPERV_FORWARD_HCALL
  KVM: x86: hyper-v: Let userspace fault a forwarded hypercall
  KVM: x86: hyper-v: Advertise XMM fast hypercall output
  KVM: selftests: Add Hyper-V hypercall forwarding test

 Documentation/virt/kvm/api.rst                |  65 +++++
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/kvm/hyperv.c                         |  38 ++-
 arch/x86/kvm/hyperv.h                         |   9 +
 arch/x86/kvm/x86.c                            |  14 +
 include/uapi/linux/kvm.h                      |   7 +
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 268 ++++++++++++++++++
 8 files changed, 402 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c


base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.50.1

