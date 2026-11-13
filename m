Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589548;
	b=g4FD/RNopqmlBpfwSVEWMGN19y0hNpRCCcG6nHRaFAuZYOEpj6Ie0DLj307TbGmS7m+E
	 kdjIin/5P+hyKM23h5Bi0qU6xlneOBobm10RjI3PwfLtdY+PqmDAsFj8pvIrxPIto0Ytv
	 mhvNHSOO4ZEpuRdKbdG+gqhyjiK+O01FEvySlj82y5AuHEee6SwB0OkgrZkaUON1bDER5
	 wkyDiZ/tRak0lRssr36Y8izP33uAnwdETLnkEHRB/wwtlXVPmfqROOzWgaGDBoQ7UXjsE
	 6Of30IK3LQtaJpK1HrhySwVqlz2CSR/MatODR2dg7zHvFB6p6RXemrqweIbovE6OONg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589548;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=kCGxpBXBaBiGwMJsw72VsYlYa0+q6WTQu2Tug3H6f7Q=;
	b=Pd39Kp04xXDgX+6jW0p4XCrSrICJRtK8swz0L2JPC6aBsx30oVnDXkqe/Ij4d1cnlLaF
	 djf+W2gqKJX358gKa4/6/yXPA9Maw43I1amA8RSqzb2nacCyQqgcGvdcIX3iHyYbOxBGC
	 SpWvx0iDVqSeyLAD4V416Lit/Rw5BqUPW6zaFk1ZU1rB65oz7DRQqT235qbDDfj9i/2Se
	 uh1cPBVSTL/PKpMo/X2XyTmWyah0rIRCh1GUdm8BHtcFi5ROiSOBkUjO59tOl9GFRLB+q
	 brKQ9x4DQdBnYycmB5d/MA7OYzDPZQRqfi1tvt8r5Fj/xE34lMdkb2O89gH2uERc8vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZciuCMf+;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF569606A323;
	Fri, 13 Nov 2026 17:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF569606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZciuCMf+
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=kCGxpBXBaBiGwMJsw72VsYlYa0+q6WTQu2Tug3H6f7Q=; b=ZciuCMf+M5eyOudWbTFzUxXseO
	d736S9WO9qpplbnJ69ZC0ve9bAxozf7HMnjy5Md3huKV1yThrkco6Mvq1XqlH9ols5OLAel4kyXZl
	MI0iUNQiUQ0+JfIh4h3Cmg0S3hCVkeqVXjb20Z1hBb3ClJ5LoE3CRs5jTk0xzW9trOcD7ElkMvO0E
	kBCFqQ24vbdOESU5In6oV/ixmSamYTFzkFVeT4iwMVwXS48HIQFFS3XHjhFX7Jj4/NRBMKZuL0Ciu
	BycjxC1e/m7sajXYq5OKagFKPW1JvU9TMwCxGjYtDpb8oAoicr63i7NG9QQgqRd8mD5xqQHphbPpr
	KcTWtn1g==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRuiW-00000003oWG-0RUW;
	Fri, 13 Nov 2026 17:05:36 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRuiV-00000000KcN-3hGD;
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
Subject: [PATCH v2 2/4] KVM: x86: Let userspace cancel a pending hypercall completion
Date: Fri, 13 Nov 2026 10:05:33 -0700
Message-ID: <20261113170535.79246-3-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261113170535.79246-1-dwmw2@infradead.org>
References: <20261113170535.79246-1-dwmw2@infradead.org>
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

A VMM implementing Hyper-V hypercalls behind KVM_EXIT_HYPERV_HCALL can
only complete them: write a status, advance RIP.  The TLFS specifies
some hypercalls to raise an exception at the hypercall instruction
instead, and the exit has no way to say that.  The KVM_EXIT_VMWARE
series has the same problem for its backdoor exits, so solve it without
touching the exit format at all: cancel the pending completion, and
queue the exception through the machinery KVM_SET_VCPU_EVENTS already
has.

KVM_VCPUEVENT_CANCEL_HCALL on KVM_SET_VCPU_EVENTS drops the pending
completion: no result write, no RIP advance, so the guest re-executes
the hypercall on its next entry unless the same call queued an
exception to be delivered there.  Hyper-V hypercalls are restartable by
design, so both outcomes are architecturally sound.  If nothing
cancellable is pending - nothing at all, or a completion KVM armed for
its own purposes, like the MMIO and PIO emulation continuations - the
ioctl fails with EBUSY and changes nothing.  Only the Hyper-V hypercall
userspace exits are cancellable.

Only the ioctl takes the flag.  KVM_GET_VCPU_EVENTS never reports it, so
no saved or synced copy of the events carries it, and cancelling from the
events KVM_RUN syncs from kvm_run (KVM_SYNC_X86_EVENTS) would have no
use: userspace is already re-entering the vCPU.  sync_regs() rejects the
flag outright with EINVAL, so EBUSY keeps one meaning and only the ioctl
returns it.

KVM_SET_VCPU_EVENTS offers no way to probe for a new flag, so
KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) grows from 1 into a feature
mask: KVM_VCPU_EVENTS_BASE keeps existing truth-value checks working,
and KVM_VCPU_EVENTS_CANCEL_HCALL advertises the new flag.

The new selftest covers the paths that need no Hyper-V support: the
capability mask, EBUSY with nothing pending and with a PIO emulation
continuation pending (which must then still retire the instruction),
EINVAL for an undefined flags bit, and EINVAL from KVM_RUN for the flag
in the synced events.  The positive paths need a
hypercall exit and come with the Hyper-V forwarding test.

Link: https://lore.kernel.org/all/876c4f4fc442116c9bff8abd8c34f99fcfa65531.camel@infradead.org/
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 Documentation/virt/kvm/api.rst                |  24 ++++
 arch/x86/include/asm/kvm_host.h               |   2 +
 arch/x86/include/uapi/asm/kvm.h               |   7 ++
 arch/x86/kvm/hyperv.c                         |   6 +
 arch/x86/kvm/x86.c                            |  37 +++++-
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/vcpu_events_cancel_test.c         | 119 ++++++++++++++++++
 7 files changed, 194 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/vcpu_events_cancel_test.c

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 092f6f9ad8a0..cb45bdf5f1ee 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -1302,6 +1302,27 @@ If KVM_CAP_X86_TRIPLE_FAULT_EVENT is enabled, KVM_VCPUEVENT_VALID_TRIPLE_FAULT
 can be set in flags field to signal that the triple_fault field contains
 a valid state and shall be written into the VCPU.
 
+On x86, KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) returns a feature mask:
+KVM_VCPU_EVENTS_BASE for the two ioctls themselves, and
+KVM_VCPU_EVENTS_CANCEL_HCALL when KVM_SET_VCPU_EVENTS accepts
+KVM_VCPUEVENT_CANCEL_HCALL in the flags field.
+
+KVM_VCPUEVENT_CANCEL_HCALL cancels a pending, cancellable hypercall
+completion, i.e. a KVM_EXIT_HYPERV_HCALL exit that userspace is holding.
+KVM forgets the completion: the hypercall's result is never written and
+its instruction is never retired, so the vCPU re-executes the hypercall
+instruction on its next entry unless the same call queued an exception
+to be delivered there instead.  Hyper-V hypercalls are restartable by
+design, so either is architecturally sound; this is how a VMM makes a
+hypercall fault (e.g. #UD, or #PF with the address in
+exception_payload) rather than return a status.  If no completion is
+pending, or the pending completion is not cancellable (for example an
+MMIO or PIO emulation continuation), the ioctl fails with EBUSY and
+changes nothing.  Only the KVM_SET_VCPU_EVENTS ioctl takes the flag:
+KVM_GET_VCPU_EVENTS never reports it, and in the events that
+KVM_SYNC_X86_EVENTS syncs through kvm_run it makes KVM_RUN fail with
+EINVAL.
+
 ARM64:
 ^^^^^^
 
@@ -7323,6 +7344,9 @@ and memory-based extended hypercalls exit this way;
 KVM_CAP_HYPERV_FORWARD_HCALL (see section 7.48) adds the hypercalls KVM
 does not implement.
 
+Instead of completing the hypercall, userspace may cancel it with
+KVM_VCPUEVENT_CANCEL_HCALL on KVM_SET_VCPU_EVENTS (see section 4.32).
+
 	- KVM_EXIT_HYPERV_SYNDBG -- synchronously notify user-space about
 
 Hyper-V Synthetic debugger state change. Notification is used to either update
diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
index fce46ae26137..7e37cbadc6d4 100644
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -856,6 +856,8 @@ struct kvm_vcpu_arch {
 	struct x86_emulate_ctxt *emulate_ctxt;
 	bool emulate_regs_need_sync_to_vcpu;
 	bool emulate_regs_need_sync_from_vcpu;
+	/* KVM_SET_VCPU_EVENTS may cancel the pending completion. */
+	bool cui_cancellable;
 	int (*complete_userspace_io)(struct kvm_vcpu *vcpu);
 	unsigned long cui_linear_rip;
 	int cui_rdmsr_imm_reg;
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 00ce265391e1..a886830f663c 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -330,6 +330,13 @@ struct kvm_reinject_control {
 #define KVM_VCPUEVENT_VALID_PAYLOAD	0x00000010
 #define KVM_VCPUEVENT_VALID_TRIPLE_FAULT	0x00000020
 
+/* Cancels a pending, cancellable hypercall completion on KVM_SET_VCPU_EVENTS */
+#define KVM_VCPUEVENT_CANCEL_HCALL	0x00000040
+
+/* KVM_CHECK_EXTENSION(KVM_CAP_VCPU_EVENTS) feature bits */
+#define KVM_VCPU_EVENTS_BASE		0x00000001
+#define KVM_VCPU_EVENTS_CANCEL_HCALL	0x00000002
+
 /* Interrupt shadow states */
 #define KVM_X86_SHADOW_INT_MOV_SS	0x01
 #define KVM_X86_SHADOW_INT_STI		0x02
diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index e72539f9acc9..858ee0f374e5 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -2717,6 +2717,12 @@ int kvm_hv_hypercall(struct kvm_vcpu *vcpu)
 	vcpu->run->hyperv.u.hcall.params[0] = hc.ingpa;
 	vcpu->run->hyperv.u.hcall.params[1] = hc.outgpa;
 	vcpu->arch.complete_userspace_io = kvm_hv_hypercall_complete_userspace;
+	/*
+	 * Userspace may revoke this completion through KVM_SET_VCPU_EVENTS
+	 * instead of completing it; the guest then re-executes the hypercall
+	 * instruction.
+	 */
+	vcpu->arch.cui_cancellable = true;
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index d8de7742a0da..2824fe8e1417 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -2237,7 +2237,6 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_IOEVENTFD_NO_LENGTH:
 
 	case KVM_CAP_SET_IDENTITY_MAP_ADDR:
-	case KVM_CAP_VCPU_EVENTS:
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV:
 	case KVM_CAP_HYPERV_VAPIC:
@@ -2305,6 +2304,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_EXIT_HYPERCALL:
 		r = KVM_EXIT_HYPERCALL_VALID_MASK;
 		break;
+	case KVM_CAP_VCPU_EVENTS:
+		r = KVM_VCPU_EVENTS_BASE | KVM_VCPU_EVENTS_CANCEL_HCALL;
+		break;
 #ifdef CONFIG_KVM_HYPERV
 	case KVM_CAP_HYPERV_FORWARD_HCALL:
 		r = KVM_HYPERV_HCALL_SUPPORTED;
@@ -3052,9 +3054,21 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			      | KVM_VCPUEVENT_VALID_SHADOW
 			      | KVM_VCPUEVENT_VALID_SMM
 			      | KVM_VCPUEVENT_VALID_PAYLOAD
-			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT))
+			      | KVM_VCPUEVENT_VALID_TRIPLE_FAULT
+			      | KVM_VCPUEVENT_CANCEL_HCALL))
 		return -EINVAL;
 
+	/*
+	 * Refuse the cancel unless a cancellable completion is pending: the
+	 * flag is only valid on the vCPU whose KVM_EXIT_HYPERV_HCALL exit
+	 * userspace is holding, and a completion KVM armed for its own
+	 * purposes (MMIO and PIO emulation continuations) is not userspace's
+	 * to revoke.
+	 */
+	if ((events->flags & KVM_VCPUEVENT_CANCEL_HCALL) &&
+	    (!vcpu->arch.complete_userspace_io || !vcpu->arch.cui_cancellable))
+		return -EBUSY;
+
 	if (events->flags & KVM_VCPUEVENT_VALID_PAYLOAD) {
 		if (!vcpu->kvm->arch.exception_payload_enabled)
 			return -EINVAL;
@@ -3152,6 +3166,16 @@ static int kvm_vcpu_ioctl_x86_set_vcpu_events(struct kvm_vcpu *vcpu,
 			kvm_clear_request(KVM_REQ_TRIPLE_FAULT, vcpu);
 	}
 
+	/*
+	 * Drop the pending completion: nothing retires the hypercall
+	 * instruction, so the vCPU re-executes it on its next entry unless
+	 * this call queued an exception to be delivered there instead.
+	 */
+	if (events->flags & KVM_VCPUEVENT_CANCEL_HCALL) {
+		vcpu->arch.complete_userspace_io = NULL;
+		vcpu->arch.cui_cancellable = false;
+	}
+
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
 	return 0;
@@ -9060,6 +9084,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
 	if (unlikely(vcpu->arch.complete_userspace_io)) {
 		int (*cui)(struct kvm_vcpu *) = vcpu->arch.complete_userspace_io;
 		vcpu->arch.complete_userspace_io = NULL;
+		vcpu->arch.cui_cancellable = false;
 		r = cui(vcpu);
 		if (r <= 0)
 			goto out;
@@ -9393,6 +9418,14 @@ static int sync_regs(struct kvm_vcpu *vcpu)
 	if (vcpu->run->kvm_dirty_regs & KVM_SYNC_X86_EVENTS) {
 		struct kvm_vcpu_events events = vcpu->run->s.regs.events;
 
+		/*
+		 * Cancelling a hypercall completion takes an explicit
+		 * KVM_SET_VCPU_EVENTS; KVM_GET_VCPU_EVENTS never reports the
+		 * flag, so no synced copy of the events legitimately has it.
+		 */
+		if (events.flags & KVM_VCPUEVENT_CANCEL_HCALL)
+			return -EINVAL;
+
 		if (kvm_vcpu_ioctl_x86_set_vcpu_events(vcpu, &events))
 			return -EINVAL;
 
diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..7a51ff975cfa 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -134,6 +134,7 @@ TEST_GEN_PROGS_x86 += x86/sync_regs_test
 TEST_GEN_PROGS_x86 += x86/ucna_injection_test
 TEST_GEN_PROGS_x86 += x86/userspace_io_test
 TEST_GEN_PROGS_x86 += x86/userspace_msr_exit_test
+TEST_GEN_PROGS_x86 += x86/vcpu_events_cancel_test
 TEST_GEN_PROGS_x86 += x86/vmx_apic_access_test
 TEST_GEN_PROGS_x86 += x86/vmx_apicv_updates_test
 TEST_GEN_PROGS_x86 += x86/vmx_exception_with_invalid_guest_state
diff --git a/tools/testing/selftests/kvm/x86/vcpu_events_cancel_test.c b/tools/testing/selftests/kvm/x86/vcpu_events_cancel_test.c
new file mode 100644
index 000000000000..d78f7f881031
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/vcpu_events_cancel_test.c
@@ -0,0 +1,119 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_VCPUEVENT_CANCEL_HCALL without a cancellable completion: the
+ * cancel must fail with EBUSY and disturb nothing, whether nothing at
+ * all is pending or the pending completion belongs to KVM (a PIO
+ * emulation continuation), and an undefined flags bit must still fail
+ * with EINVAL, as must the flag in the events KVM_RUN syncs from
+ * kvm_run.  The positive paths need a hypercall exit and live in the
+ * Hyper-V forwarding test (hyperv_forward_hcall) later in this series.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define TEST_PORT	0xd00d
+
+static void guest_code(void)
+{
+	asm volatile("outb %%al, %%dx" :: "a"(0xaa), "d"(TEST_PORT));
+	GUEST_DONE();
+}
+
+/*
+ * The cancel must fail with EBUSY and leave the vCPU's event state as
+ * KVM_GET_VCPU_EVENTS reported it.
+ */
+static void check_cancel_refused(struct kvm_vcpu *vcpu)
+{
+	struct kvm_vcpu_events events, after;
+	int r;
+
+	vcpu_events_get(vcpu, &events);
+	events.flags |= KVM_VCPUEVENT_CANCEL_HCALL;
+	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(r == -1 && errno == EBUSY,
+		    "Cancel with nothing to cancel: r = %d, errno = %d",
+		    r, errno);
+
+	events.flags &= ~KVM_VCPUEVENT_CANCEL_HCALL;
+	vcpu_events_get(vcpu, &after);
+	TEST_ASSERT(!memcmp(&events, &after, sizeof(events)),
+		    "Failed cancel changed the vCPU's events");
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu_events events;
+	struct kvm_vcpu *vcpu;
+	struct kvm_regs regs, after;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	long cap;
+	int r;
+
+	cap = kvm_check_cap(KVM_CAP_VCPU_EVENTS);
+	TEST_REQUIRE(cap & KVM_VCPU_EVENTS_CANCEL_HCALL);
+	TEST_ASSERT(cap & KVM_VCPU_EVENTS_BASE,
+		    "KVM_CAP_VCPU_EVENTS lost its base bit: %#lx", cap);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	/* Nothing pending at all. */
+	check_cancel_refused(vcpu);
+
+	/*
+	 * An undefined flags bit is still unknown.  Flags are allocated from
+	 * the bottom, so probe the top bit rather than the next free one.
+	 */
+	vcpu_events_get(vcpu, &events);
+	events.flags |= 1U << 31;
+	r = __vcpu_ioctl(vcpu, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(r == -1 && errno == EINVAL,
+		    "Undefined events flag: r = %d, errno = %d", r, errno);
+
+	/* Only the ioctl cancels: in the synced events the flag is invalid. */
+	if (kvm_check_cap(KVM_CAP_SYNC_REGS) & KVM_SYNC_X86_EVENTS) {
+		vcpu_events_get(vcpu, &vcpu->run->s.regs.events);
+		vcpu->run->s.regs.events.flags |= KVM_VCPUEVENT_CANCEL_HCALL;
+		vcpu->run->kvm_dirty_regs = KVM_SYNC_X86_EVENTS;
+		r = __vcpu_run(vcpu);
+		TEST_ASSERT(r == -1 && errno == EINVAL,
+			    "Cancel through sync_regs: r = %d, errno = %d",
+			    r, errno);
+		vcpu->run->kvm_dirty_regs = 0;
+	} else {
+		print_skip("KVM_CAP_SYNC_REGS lacks KVM_SYNC_X86_EVENTS, sync_regs cancel case");
+	}
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT(vcpu->run->io.port == TEST_PORT &&
+		    vcpu->run->io.direction == KVM_EXIT_IO_OUT,
+		    "Expected OUT to port %#x, got %s port %#x", TEST_PORT,
+		    vcpu->run->io.direction == KVM_EXIT_IO_OUT ? "OUT" : "IN",
+		    vcpu->run->io.port);
+
+	/*
+	 * The OUT's completion is KVM's, not userspace's to revoke, and
+	 * the refusal must not move the vCPU.
+	 */
+	vcpu_regs_get(vcpu, &regs);
+	check_cancel_refused(vcpu);
+	vcpu_regs_get(vcpu, &after);
+	TEST_ASSERT_EQ(regs.rip, after.rip);
+	TEST_ASSERT_EQ(regs.rax, after.rax);
+
+	/*
+	 * The pending completion must still retire the OUT: the next exit
+	 * is the GUEST_DONE ucall, not the OUT re-executing.
+	 */
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	TEST_ASSERT(vcpu->run->io.port != TEST_PORT,
+		    "The OUT re-executed: its completion was lost");
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

