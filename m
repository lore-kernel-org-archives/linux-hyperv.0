Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795793260;
	b=bIpesF6gii9SSTU8xRzsvVmauIArEmuSHymBmRvM0PpSdnCvRdaQ3CBESNx9yenfOIi+
	 WK3vZ23W/w1TMNh8eBKkQqGsGcANePhhzUorjbS5R1iRENPkwJZBFCNOnvG+dlUijVVbw
	 OI656hnpiUqunxgjnzSKc41Opi5FzW0fGcGpeoitMKSKwZbMYKViscwCnR5rxgekT3tPK
	 5yWSXPMXgNHNrU2838Q6FX+YgVT2oKuX9mqNa8WRRn8lB/J7MRsjLZEUWto4XeKSgnUG2
	 VtZ2Q8ewuOI2qms7ZtivlC5YhBbsCMCrZZp9TqILpIR8Fwk844ahFkBacyq7cvuZa1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795793260;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=qypCK3tA9UUfqj8ZPbY29il9tVVCylL/MCgm/h0RxEg=;
	b=uLVYQLkl6k1oqAqhKpDVY8ZIoeSYmlz+73O4JeiKJnpbseD1beDQkAYJ9/OS3olPk/cA
	 O1kA8F2aBZbD3kE+YqyYRDHPAZ7bBVw0SjUdbCtQ+BqWWvUwegaAfhLMysSUZXn9KtVbt
	 Y6ePQPSr7wi7TQZ3TvMaYtY8UqP+vZtraUzS5/hDXV7gpYX1JJ6vmMatwsNM5vHB0qace
	 JJRePvS/FB5OrFfMtY51ALTGMjsq6pcwc0VxKRj++E8tLjFwdgeMst5od5AX8IiH6iCw3
	 ROyOu7fN8iQB7+SBqc7CA4+SygyDpuqGVDdSlQhw4+uvDybEXAoKNEvZOWjx9QQhZzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UzvUS10y;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE6D60A261D;
	Fri, 27 Nov 2026 15:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DDE6D60A261D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=UzvUS10y
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=qypCK3tA9UUfqj8ZPbY29il9tVVCylL/MCgm/h0RxEg=; b=UzvUS10yP5FSOhp+XxMv4NNFIp
	y0mDqzHRLgoc2PcPjgMUM+U+2rMjRBUjXXljKkBGV+1Y0upnX0fwf6Ngga0qdWLl56SYBI0yqShhE
	s/yuh/K4Q0W3MSvUYmJyYYD5QgEP0mResYYU0hpl3c7ckGg/BWczOmgfgC2d9p1664gKJqBH0iAmb
	j69Y+OKO+5q+HR42SepAEuRFlGZZTYJsNMJyFrx9RhMKqPNPmb6eo8lLsZw8MiHYDdXG/bJl7oOqt
	11VPsVkf8OC/kLH9sc1/jJbec3Byksdvlv/Bns0hXRmDdti9OOSK+uNHI+CxfynHqPuUHtZ81x+H5
	vJ5khZVA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xWxrJ-00000007tkm-2FLY;
	Fri, 27 Nov 2026 15:27:33 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xWxrG-00000000PqD-1c5D;
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
Subject: [PATCH v3 04/15] KVM: selftests: Test MSR accesses which userspace leaves alone
Date: Fri, 27 Nov 2026 15:27:19 +0000
Message-ID: <20261127152730.99319-5-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261127152730.99319-1-dwmw2@infradead.org>
References: <20261127152730.99319-1-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

Cover intercepted and force-emulated RDMSR and WRMSR: without
KVM_CAP_X86_MSR_EXIT_INSN any error is a #GP; with it, each KVM_INSN_*
value, undefined ones, and KVM_INSN_RESUME with nothing changed, with a
queued #NM, with RIP moved, and across a single-step.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/msr_exit_insn_test.c    | 308 ++++++++++++++++++
 2 files changed, 309 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/msr_exit_insn_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 17a4256e9081..f0cb8cf748dd 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -96,6 +96,7 @@ TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
 TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
+TEST_GEN_PROGS_x86 += x86/msr_exit_insn_test
 TEST_GEN_PROGS_x86 += x86/msrs_test
 TEST_GEN_PROGS_x86 += x86/nested_close_kvm_test
 TEST_GEN_PROGS_x86 += x86/nested_dirty_log_test
diff --git a/tools/testing/selftests/kvm/x86/msr_exit_insn_test.c b/tools/testing/selftests/kvm/x86/msr_exit_insn_test.c
new file mode 100644
index 000000000000..9ff6c88de38a
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/msr_exit_insn_test.c
@@ -0,0 +1,308 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test KVM_CAP_X86_MSR_EXIT_INSN: without it, any non-zero 'error' of
+ * KVM_EXIT_X86_RDMSR and KVM_EXIT_X86_WRMSR is a #GP.  With it, 'error'
+ * takes KVM_INSN_*: the #GP is KVM_INSN_GP, KVM_INSN_UD injects #UD,
+ * undefined values fail KVM_RUN, and KVM_INSN_RESUME leaves the
+ * instruction unretired: RIP and the registers stay as they were and no
+ * #GP is injected, so the guest runs the instruction again, or takes the
+ * exception userspace queued, or resumes where userspace moved RIP.  Both
+ * intercepted and, with kvm.force_emulation_prefix, emulated accesses are
+ * covered.  KVM steps over the prefix before it emulates, so an emulated
+ * access which is left alone is intercepted when the guest executes it
+ * again.
+ *
+ * Copyright © 2026 Amazon.com, Inc. or its affiliates.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+
+#define TEST_MSR	0x474f4f00	/* Not implemented by KVM. */
+
+#define MSR_INSN_LEN	2
+
+#define WRITE_VAL	0x1122334455667788ULL
+#define DATA_IGNORED	0xa1a2a3a4a5a6a7a8ULL
+#define DATA_RET0	0xb1b2b3b4b5b6b7b8ULL
+#define DATA_RETRY	0xc1c2c3c4c5c6c7c8ULL
+#define DATA_MOVED	0xd1d2d3d4d5d6d7d8ULL
+#define DATA_STEP	0xe1e2e3e4e5e6e7e8ULL
+#define DATA_BAD	0xbad0bad1bad2bad3ULL
+
+static u8 guest_rdmsr(bool fep, u64 *val)
+{
+	*val = 0;
+	return fep ? rdmsr_safe_fep(TEST_MSR, val) : rdmsr_safe(TEST_MSR, val);
+}
+
+static u8 guest_wrmsr(bool fep)
+{
+	if (fep)
+		return kvm_asm_safe_fep("wrmsr", "a"(WRITE_VAL & -1u),
+					"d"(WRITE_VAL >> 32), "c"(TEST_MSR));
+
+	return wrmsr_safe(TEST_MSR, WRITE_VAL);
+}
+
+/* One read, then one write, which must end as userspace decided. */
+static void guest_access(bool fep, u8 vector, u64 data)
+{
+	u64 val;
+
+	GUEST_ASSERT_EQ(guest_rdmsr(fep, &val), vector);
+	if (!vector)
+		GUEST_ASSERT_EQ(val, data);
+	GUEST_ASSERT_EQ(guest_wrmsr(fep), vector);
+}
+
+static void guest_accesses(bool fep)
+{
+	/* Not enabled: zero completes, and anything else is a #GP. */
+	guest_access(fep, 0, DATA_IGNORED);
+	guest_access(fep, GP_VECTOR, 0);
+	guest_access(fep, GP_VECTOR, 0);
+	guest_access(fep, GP_VECTOR, 0);
+	GUEST_SYNC(fep);
+
+	/* Enabled: completed, then failed with #GP, then with #UD. */
+	guest_access(fep, 0, DATA_RET0);
+	guest_access(fep, GP_VECTOR, 0);
+	guest_access(fep, UD_VECTOR, 0);
+
+	/* Left alone, or refused by KVM_RUN: the instruction runs again. */
+	guest_access(fep, 0, DATA_RETRY);
+
+	/* Left alone with #NM queued by userspace. */
+	guest_access(fep, NM_VECTOR, 0);
+
+	/* Left alone and retired by userspace. */
+	guest_access(fep, 0, DATA_MOVED);
+
+	/* Left alone and then completed while single-stepping. */
+	guest_access(fep, 0, DATA_STEP);
+	GUEST_SYNC(fep);
+}
+
+static void guest_code(void)
+{
+	guest_accesses(false);
+	if (is_forced_emulation_enabled)
+		guest_accesses(true);
+	GUEST_DONE();
+}
+
+static void expect_msr_exit(struct kvm_vcpu *vcpu, bool write)
+{
+	struct kvm_run *run = vcpu->run;
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	if (run->exit_reason == KVM_EXIT_IO && get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, write ? KVM_EXIT_X86_WRMSR :
+						  KVM_EXIT_X86_RDMSR);
+	TEST_ASSERT_EQ(run->msr.index, TEST_MSR);
+	TEST_ASSERT_EQ(run->msr.reason, KVM_MSR_EXIT_REASON_UNKNOWN);
+	TEST_ASSERT_EQ(run->msr.error, KVM_INSN_COMPLETE);
+	if (write)
+		TEST_ASSERT_EQ(run->msr.data, WRITE_VAL);
+}
+
+static void expect_sync(struct kvm_vcpu *vcpu, bool fep)
+{
+	struct ucall uc;
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	switch (get_ucall(vcpu, &uc)) {
+	case UCALL_SYNC:
+		TEST_ASSERT_EQ(uc.args[1], fep);
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+}
+
+/*
+ * Leave the access alone, with 'data' set to what must not reach the guest,
+ * or give KVM_RUN a value it refuses, and check that the access comes back
+ * exactly as it was.
+ */
+static void leave_and_retake(struct kvm_vcpu *vcpu, bool write, u8 error)
+{
+	struct kvm_run *run = vcpu->run;
+	struct kvm_regs before, after;
+
+	/* The #UD exit of a forced emulation sets RF; an intercept does not. */
+	vcpu_regs_get(vcpu, &before);
+	before.rflags &= ~X86_EFLAGS_RF;
+	run->msr.error = error;
+	if (!write)
+		run->msr.data = DATA_BAD;
+
+	if (error > KVM_INSN_RESUME) {
+		TEST_ASSERT(__vcpu_run(vcpu) == -1 && errno == EINVAL,
+			    "KVM_RUN accepted 'error' %u", error);
+		vcpu_regs_get(vcpu, &after);
+		after.rflags &= ~X86_EFLAGS_RF;
+		TEST_ASSERT(!memcmp(&before, &after, sizeof(before)),
+			    "Registers changed by a failed KVM_RUN");
+	}
+
+	expect_msr_exit(vcpu, write);
+	vcpu_regs_get(vcpu, &after);
+	after.rflags &= ~X86_EFLAGS_RF;
+	TEST_ASSERT(!memcmp(&before, &after, sizeof(before)),
+		    "Registers changed over a %s left alone: RIP 0x%llx -> 0x%llx, RAX 0x%llx -> 0x%llx, RDX 0x%llx -> 0x%llx, RFLAGS 0x%llx -> 0x%llx",
+		    write ? "WRMSR" : "RDMSR", before.rip, after.rip,
+		    before.rax, after.rax, before.rdx, after.rdx,
+		    before.rflags, after.rflags);
+}
+
+static void complete(struct kvm_vcpu *vcpu, bool write, u8 error, u64 data)
+{
+	vcpu->run->msr.error = error;
+	if (!write)
+		vcpu->run->msr.data = data;
+}
+
+static void run_accesses(struct kvm_vcpu *vcpu, bool fep)
+{
+	struct kvm_guest_debug debug = {};
+	struct kvm_run *run = vcpu->run;
+	struct kvm_vcpu_events events;
+	struct kvm_regs regs;
+	int write;
+
+	/* Not enabled: any non-zero 'error' is a #GP. */
+	vm_enable_cap(vcpu->vm, KVM_CAP_X86_MSR_EXIT_INSN, 0);
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, 0, DATA_IGNORED);
+	}
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, KVM_INSN_RESUME, DATA_BAD);
+	}
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, KVM_INSN_UD, DATA_BAD);
+	}
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, 0x80, DATA_BAD);
+	}
+	expect_sync(vcpu, fep);
+	vm_enable_cap(vcpu->vm, KVM_CAP_X86_MSR_EXIT_INSN, 1);
+
+	/* Complete and #GP: as before.  And #UD. */
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, KVM_INSN_COMPLETE, DATA_RET0);
+	}
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, KVM_INSN_GP, DATA_BAD);
+	}
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, KVM_INSN_UD, DATA_BAD);
+	}
+
+	/*
+	 * Resume: no #GP, nothing written, the same exit again.  A reserved
+	 * value fails KVM_RUN and leaves the guest the same way.
+	 */
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		leave_and_retake(vcpu, write, KVM_INSN_RESUME);
+		leave_and_retake(vcpu, write, KVM_INSN_RESUME + 1);
+		leave_and_retake(vcpu, write, KVM_INSN_RESUME);
+		leave_and_retake(vcpu, write, 0xff);
+		complete(vcpu, write, KVM_INSN_COMPLETE, DATA_RETRY);
+	}
+
+	/* Resume with an exception queued: taken at the instruction. */
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		run->msr.error = KVM_INSN_RESUME;
+		vcpu_events_get(vcpu, &events);
+		TEST_ASSERT(!events.exception.pending && !events.exception.injected,
+			    "Exception queued at an MSR exit");
+		events.exception.injected = 1;
+		events.exception.nr = NM_VECTOR;
+		events.exception.has_error_code = 0;
+		vcpu_events_set(vcpu, &events);
+	}
+
+	/* Resume with RIP moved: userspace performed the access. */
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		complete(vcpu, write, KVM_INSN_RESUME, DATA_BAD);
+		vcpu_regs_get(vcpu, &regs);
+		regs.rip += MSR_INSN_LEN;
+		if (!write) {
+			regs.rax = DATA_MOVED & -1u;
+			regs.rdx = DATA_MOVED >> 32;
+		}
+		vcpu_regs_set(vcpu, &regs);
+	}
+
+	/*
+	 * Single-step: an access which is left alone has not retired, so
+	 * there is no debug exit until it is completed.
+	 */
+	for (write = 0; write <= 1; write++) {
+		expect_msr_exit(vcpu, write);
+		vcpu_regs_get(vcpu, &regs);
+		debug.control = KVM_GUESTDBG_ENABLE | KVM_GUESTDBG_SINGLESTEP;
+		vcpu_guest_debug_set(vcpu, &debug);
+		leave_and_retake(vcpu, write, KVM_INSN_RESUME);
+		complete(vcpu, write, KVM_INSN_COMPLETE, DATA_STEP);
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_DEBUG);
+		TEST_ASSERT_EQ(run->debug.arch.pc, regs.rip + MSR_INSN_LEN);
+		debug.control = 0;
+		vcpu_guest_debug_set(vcpu, &debug);
+	}
+	expect_sync(vcpu, fep);
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_USER_SPACE_MSR));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_X86_MSR_EXIT_INSN));
+	/* With kvm.ignore_msrs the access to TEST_MSR never exits. */
+	TEST_REQUIRE(!kvm_is_ignore_msrs());
+	TEST_ASSERT_EQ(kvm_check_cap(KVM_CAP_X86_MSR_EXIT_INSN), 1);
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
+
+	TEST_ASSERT(__vm_enable_cap(vm, KVM_CAP_X86_MSR_EXIT_INSN, 2) == -1 &&
+		    errno == EINVAL,
+		    "KVM_CAP_X86_MSR_EXIT_INSN accepted an unknown argument");
+	vm_enable_cap(vm, KVM_CAP_X86_USER_SPACE_MSR, KVM_MSR_EXIT_REASON_UNKNOWN);
+
+	run_accesses(vcpu, false);
+	if (is_forced_emulation_enabled)
+		run_accesses(vcpu, true);
+	else
+		pr_info("Set kvm.force_emulation_prefix=1 to test emulated MSR accesses\n");
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+	if (get_ucall(vcpu, &uc) == UCALL_ABORT)
+		REPORT_GUEST_ASSERT(uc);
+	TEST_ASSERT_EQ(uc.cmd, UCALL_DONE);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

