Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594897;
	b=V7oTI3wH6Fgu0Szvak7MkjlQ4ZFgDIm9KTXwvVysLzfr5opQRjwpY7haWw6mVdmiFWHk
	 HX8kfMDf9y57nqtPhlA27NkFtPHoJNaStg18UjdPTEoVVelKbRS7hQsf+Sn7ZgzrTCXob
	 xu5fm+PSXrnZAs9s04+8QO4TFe2hnVydZhKuzrgl75RdVhPwmavcHPrErWDGUS2bidLpF
	 TXyK3Ugbd1oHu8sK+s+TGt/dqYlPECtUNhpM4WaonfyUldC6kmTdWeOLs8yDDy9BZy5hO
	 wOc1GzoxfH0FAfsLnMCMaFjT3OzxOeN3lRpZvpI/6nyCyJi7TWSquRI6zakFSgCumsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594897;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=EQE8G03VCtSeDfWZTAqFkZaKC9YvDiDU3mhyqd7ATUQ=;
	b=MKN8kZaOs802BqQMcLLR5pHROetrzxAM5INjbi+ti7XLsFJUTDWqH6C9I8LdB2QBh/6u
	 PRE3Gkwcz1gvqgRGSRaHoa/9qJxQDut/5kQX2xuV7ZhSMLdAKvorXJANKO08R1JkEJdKc
	 pXeO0Fp3ftOsLSY5kofxc0PizmkUaDTgB9y73aXqpKnJLtacZo1cUm7h2P9bseNPocDPf
	 g+fhra4j8FganeYEZ2s25F/Qnu3Giyk0XwgoLrMg6kWnfvvP0xq03TDIiHuFYRpR5MCr0
	 b9uHU9KQDEv3SNY3b8bTuIJp8erHHLcy5APHpXsqZyIEQU17m39yRAGdY/NrQjjiakg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LjMxsHop;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32EF60A5BC5;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B32EF60A5BC5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=LjMxsHop
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=EQE8G03VCtSeDfWZTAqFkZaKC9YvDiDU3mhyqd7ATUQ=; b=LjMxsHop2/HZmRr80xtGQ3hobR
	iElLNO0RCQlblov3YY2ho+Xq83TRxFCqeXvq5dPUMjC8yexx1Zhv7eLt1Cgzag9PggDn7RH7gwLqe
	HbUohlHgnrslUZJ/B3b/r3ucpn2PS+9EoIOlUJ0p7SsfVp8q0OLmGcw7eMhPADSK1Zsa/7H8g00VJ
	Fll43B4wO9HLxM8h9a9ydnwwBWCMrauX30YDDqYMuOfsPTtafT/z7w2L8e435u65atugtIei/JD/e
	hO8Hfrsh9OcTKfTwcd7G7fdChmXgLdT6TuPU07t6DHKc+TrKIVfEP8KY4KVdXC/zoVMmvDTtNmWQ/
	wEbutDRQ==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6v-0000000Bf07-0UZA;
	Fri, 13 Nov 2026 18:34:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000LuI-1jkS;
	Fri, 13 Nov 2026 18:34:50 +0000
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
Subject: [RFC PATCH v2 26/31] KVM: selftests: Check that a VTL switch keeps bit 63 of RAX
Date: Fri, 13 Nov 2026 18:34:42 +0000
Message-ID: <20261113183448.84094-27-dwmw2@infradead.org>
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

An in-kernel VTL call or VTL return hands the entered plane a full
64-bit RAX: the caller's RAX on a call, and on a non-fast return the
lower VTL's RAX from the returning plane's control area. Bit 63 of
that value is the guest's, and must arrive intact whatever the VMM has
enabled.

Make plane 1 set up its VP assist page and return to plane 0, then
have plane 0 make a VTL call with bit 63 of RAX set, and plane 1
answer with a non-fast return whose control area carries a RAX and an
RCX with bit 63 set. Check that each plane sees exactly the value it
was given, with and without KVM_HYPERV_HCALL_RAISE_UD.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/planes_vtl_return_test.c          | 204 ++++++++++++++++++
 2 files changed, 205 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_return_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 42b0bf7e8128..2b8a238c32e8 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -118,6 +118,7 @@ TEST_GEN_PROGS_x86 += x86/planes_vtl_entry_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_timer_mask_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_restore_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_nmi_halt_test
+TEST_GEN_PROGS_x86 += x86/planes_vtl_return_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/x86/planes_vtl_return_test.c b/tools/testing/selftests/kvm/x86/planes_vtl_return_test.c
new file mode 100644
index 000000000000..ed3e1cd0a085
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_vtl_return_test.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that an in-kernel VTL call and VTL return hand the entered plane
+ * its full 64-bit RAX.
+ *
+ * Plane 1 enables its VP assist page and returns to plane 0, as a secure
+ * kernel does once it has booted.  Plane 0 then makes a VTL call with bit
+ * 63 of RAX set, and plane 1 answers with a non-fast VTL return whose
+ * control area restores a RAX and RCX that also have bit 63 set.  Both
+ * resume values are guest registers and must arrive intact, whether or
+ * not KVM_HYPERV_HCALL_RAISE_UD is enabled.
+ */
+#include <errno.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+
+#define HVCALL_VTL_CALL		0x0011
+#define HVCALL_VTL_RETURN	0x0012
+
+/* struct hv_vp_vtl_control sits at offset 8 of the VP assist page. */
+#define VTL_CONTROL_OFFSET	8
+#define VTL_ENTRY_REASON_CALL	1
+
+#define CALL_RAX		0x8000000000005a5aULL
+#define RETURN_RAX		0xffff8000deadbeefULL
+#define RETURN_RCX		0x8000000012345678ULL
+
+#define TWIN_STACK_PAGES	4
+
+struct vtl_control {
+	u32 vtl_entry_reason;
+	u8 vina_asserted;
+	u8 reserved[3];
+	u64 vtl_ret_x64rax;
+	u64 vtl_ret_x64rcx;
+} __packed;
+
+/* What plane 1 saw when plane 0's VTL call entered it. */
+static u64 twin_entry_rax;
+static u32 twin_entry_reason;
+
+/*
+ * Every GPR but RSP is shared with the other plane across the switch.
+ * RSP is private, so keep the callee-saved registers on this plane's
+ * stack (below the red zone) and declare the rest clobbered.
+ */
+static inline void vtl_hypercall(u64 code, u64 *rax, u64 *rcx)
+{
+	u64 a = *rax, c = code;
+
+	asm volatile("sub $128, %%rsp\n\t"
+		     "push %%rbx\n\t"
+		     "push %%rbp\n\t"
+		     "push %%r12\n\t"
+		     "push %%r13\n\t"
+		     "push %%r14\n\t"
+		     "push %%r15\n\t"
+		     "vmcall\n\t"
+		     "pop %%r15\n\t"
+		     "pop %%r14\n\t"
+		     "pop %%r13\n\t"
+		     "pop %%r12\n\t"
+		     "pop %%rbp\n\t"
+		     "pop %%rbx\n\t"
+		     "add $128, %%rsp\n\t"
+		     : "+a"(a), "+c"(c)
+		     :
+		     : "rdx", "rsi", "rdi", "r8", "r9", "r10", "r11",
+		       "cc", "memory");
+	*rax = a;
+	*rcx = c;
+}
+
+static void twin_guest_code(gva_t assist_gva, gpa_t assist_gpa)
+{
+	struct vtl_control *ctl =
+		(void *)(assist_gva + VTL_CONTROL_OFFSET);
+	u64 rax = 0, rcx;
+
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	wrmsr(HV_X64_MSR_VP_ASSIST_PAGE,
+	      assist_gpa | HV_X64_MSR_VP_ASSIST_PAGE_ENABLE);
+
+	/* Set up: hand control to plane 0, which has not run yet. */
+	vtl_hypercall(HVCALL_VTL_RETURN, &rax, &rcx);
+
+	/* Entered by plane 0's VTL call. */
+	twin_entry_rax = rax;
+	twin_entry_reason = ctl->vtl_entry_reason;
+
+	ctl->vtl_ret_x64rax = RETURN_RAX;
+	ctl->vtl_ret_x64rcx = RETURN_RCX;
+	rax = 0;
+	vtl_hypercall(HVCALL_VTL_RETURN, &rax, &rcx);
+
+	for (;;)
+		asm volatile("hlt");
+}
+
+static void plane0_guest_code(void)
+{
+	u64 rax = CALL_RAX, rcx;
+
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+	vtl_hypercall(HVCALL_VTL_CALL, &rax, &rcx);
+
+	GUEST_ASSERT_EQ(rax, RETURN_RAX);
+	GUEST_ASSERT_EQ(rcx, RETURN_RCX);
+	GUEST_DONE();
+}
+
+static void run_test(u64 features)
+{
+	struct kvm_vcpu *vcpu0;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_vm *vm;
+	gva_t assist;
+	int plane_fd, twin_fd, r;
+	struct ucall uc;
+	u64 state;
+
+	kvm_force_split_irqchip = true;
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	kvm_force_split_irqchip = false;
+
+	TEST_REQUIRE(__vm_enable_cap(vm, KVM_CAP_PLANES, 2) == 0);
+	vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, features);
+
+	vcpu0 = vm_vcpu_add(vm, 0, plane0_guest_code);
+	vcpu_set_hv_cpuid(vcpu0);
+
+	plane_fd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL);
+	TEST_ASSERT(plane_fd >= 0, "KVM_CREATE_PLANE failed: errno %d", errno);
+	twin_fd = __kvm_ioctl(plane_fd, KVM_CREATE_VCPU, NULL);
+	TEST_ASSERT(twin_fd >= 0, "KVM_CREATE_VCPU on plane 1 failed: errno %d",
+		    errno);
+
+	assist = vm_alloc_page(vm);
+	memset(addr_gva2hva(vm, assist), 0, getpagesize());
+
+	/* Same mode and page tables as plane 0, own code and stack. */
+	vcpu_sregs_get(vcpu0, &sregs);
+	r = ioctl(twin_fd, KVM_SET_SREGS, &sregs);
+	TEST_ASSERT(!r, "KVM_SET_SREGS on twin failed: errno %d", errno);
+	r = ioctl(twin_fd, KVM_GET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_GET_REGS on twin failed: errno %d", errno);
+	regs.rip = (unsigned long)twin_guest_code;
+	regs.rsp = vm_alloc_stack(vm, TWIN_STACK_PAGES);
+	regs.rdi = assist;
+	regs.rsi = addr_gva2gpa(vm, assist);
+	regs.rflags = 0x2;
+	r = ioctl(twin_fd, KVM_SET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_SET_REGS on twin failed: errno %d", errno);
+
+	/* Plane 1 runs first; plane 0 is left stopped without a VMM hold. */
+	state = 0;
+	r = ioctl(twin_fd, KVM_SET_PLANE_RUN_STATE, &state);
+	TEST_ASSERT(!r, "KVM_SET_PLANE_RUN_STATE on twin failed: errno %d",
+		    errno);
+
+	vcpu_run(vcpu0);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu0, KVM_EXIT_IO);
+	switch (get_ucall(vcpu0, &uc)) {
+	case UCALL_DONE:
+		break;
+	case UCALL_ABORT:
+		REPORT_GUEST_ASSERT(uc);
+	default:
+		TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+	}
+
+	sync_global_from_guest(vm, twin_entry_rax);
+	sync_global_from_guest(vm, twin_entry_reason);
+	TEST_ASSERT_EQ(twin_entry_reason, VTL_ENTRY_REASON_CALL);
+	TEST_ASSERT_EQ(twin_entry_rax, CALL_RAX);
+
+	close(twin_fd);
+	close(plane_fd);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	u64 supported, vtl = KVM_HYPERV_HCALL_VTL_CALLS |
+			     KVM_HYPERV_HCALL_VTL_SWITCH;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PLANES));
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_FORWARD_HCALL));
+	supported = kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL);
+	TEST_REQUIRE((supported & vtl) == vtl);
+
+	run_test(vtl);
+	if (supported & KVM_HYPERV_HCALL_RAISE_UD)
+		run_test(vtl | KVM_HYPERV_HCALL_RAISE_UD);
+
+	return 0;
+}
-- 
2.50.1

