Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594892;
	b=HgCRgue0JI4l2nzXRSNAIpDS+EJkaiRVz6USnTEqq/qmllmPW5hA/NMi7YlSTFdKl6FZ
	 9EhibOM/jT7z8nZLsM4CFk1x+w6Gnt8iLEXpulTZEhe22UMplBX8kBQGW1NTU43EqVbvl
	 bv2/HD2ugZmL2AECj+MubUFafDGJYYMZp+WePB8PpKeRs6AkD5TbskiVyIwTtJj1sNadv
	 9ladDI5xecMU3OCJ18rrCtP2WSTDXUfjfel3aj0hSSYy5GDyK7GW1rwZPzGWPAR7LZzmi
	 wnbE58Pf1htO98wyu5rn56PmOXVWnTPK1AjyRV3eqs4IXPFLhAeOJyP+cfQFspqDLgw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594892;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=VeAdZMo7xKei4b/LovaFZ4bIRHRhU7+BzLiziNXX27s=;
	b=hSzQ+u7s54VRYu6pi6Y1Ag01JY45f7woPyEizr1MZ7nG9npGdnBktWaIfz60n4+TOZVX
	 6v94uRnQJJUIjX2WIhIYtLiRJGbTYAfjyI2+63+A9trV4vq99HsAT7+mnao/D7WC3TRoW
	 b3cfee5UZj73DAP8UqsoWCuUvLPdQF6P2cqrquK9dAz3IGNdM9WTLdAv42MZ6+GeosQsR
	 /35kVm4DG96HOf/tJGoS/U4dYgbDTnJLLyQG+XqPEoDGZbty8b8x1Tjp9yYkPR5iEsZVr
	 7AA2ZiAyKQaWzYL0W2vBRQMTMyrY0+PjduQYkX8XyY937tP2H8kxPXNJScsVYI9s/aw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OXsoNUQa;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC12606A887;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2BC12606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=OXsoNUQa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=VeAdZMo7xKei4b/LovaFZ4bIRHRhU7+BzLiziNXX27s=; b=OXsoNUQaEtNaj1AD6vpQI/dV6g
	XsHHeKxjw3pH/RoSeqGPhGfRghtX/iisH4a29bbs/sckVZiffyiUlxAPqaTJNVW2ST7qfV815sN2e
	SWflnUaV3bD+Haao+XaBA2O1JqOy1ADZiISxXHMLW8ZA8ajnE0O5qYjN5a1tQjRnLolz+WVQK36hW
	r0jr9YlmkyhXaWNhZ9nGlc33n2cUtI79KKgSQheIm/kLLwKVJyvVbfn/7j7H0f+he8cpO5vtJ96ek
	hZPi50nPrciDgY8NEbYuY54juWL/sp5l5cQPcj8CXycIqbPp+qYqvYSJClaAZU8+o2nHkN418/Cpz
	++Od+FLA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gQx-2EoI;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Lu5-1FFP;
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
Subject: [RFC PATCH v2 23/31] KVM: selftests: Check that a masked higher-plane timer is no event
Date: Fri, 13 Nov 2026 18:34:39 +0000
Message-ID: <20261113183448.84094-24-dwmw2@infradead.org>
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

A LAPIC timer that expires under a masked LVTT latches the expiry but
is never injected. A higher plane that arms its timer and then masks
LVTT must therefore not count as having a pending event, or every run
of the lower plane ends in a KVM_EXIT_HYPERV_VTL_INTERRUPT exit (or a
forced entry) with nothing for the higher plane to take.

The plane-1 twin arms a 50ms one-shot timer, masks LVTT and is
suspended like a userspace VTL switch. Once KVM_GET_LAPIC shows the
timer expired, plane 0 must run its guest code to GUEST_DONE.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/planes_vtl_timer_mask_test.c      | 177 ++++++++++++++++++
 2 files changed, 178 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_timer_mask_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 250b324d0881..c6ad866a0b0d 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -115,6 +115,7 @@ TEST_GEN_PROGS_x86 += x86/platform_info_test
 TEST_GEN_PROGS_x86 += x86/plane_x86_test
 TEST_GEN_PROGS_x86 += x86/planes_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_entry_test
+TEST_GEN_PROGS_x86 += x86/planes_vtl_timer_mask_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/x86/planes_vtl_timer_mask_test.c b/tools/testing/selftests/kvm/x86/planes_vtl_timer_mask_test.c
new file mode 100644
index 000000000000..e6b2b9eaa9c6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_vtl_timer_mask_test.c
@@ -0,0 +1,177 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that a higher plane's masked LAPIC timer does not hold the lower
+ * plane hostage.
+ *
+ * A LAPIC timer that expires while LVTT is masked still latches its
+ * expiry, but the interrupt is never injected.  If the latched expiry
+ * counted as a pending higher-plane event, the lower plane would exit
+ * with KVM_EXIT_HYPERV_VTL_INTERRUPT on every run, and a VMM that enters
+ * the higher plane in response would find nothing to deliver.
+ *
+ * The plane-1 twin arms a one-shot timer, masks LVTT before it can fire,
+ * and is then suspended exactly like a userspace VTL switch.  Once the
+ * timer has expired, plane 0 must run its guest code.
+ */
+#include <errno.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/mman.h>
+#include <unistd.h>
+
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "apic.h"
+
+#ifndef KVM_EXIT_HYPERV_VTL_INTERRUPT
+#define KVM_EXIT_HYPERV_VTL_INTERRUPT  4
+#endif
+
+#define TEST_VECTOR		0xe0
+#define TWIN_SYNC_PORT		0x7e
+#define TWIN_STACK_PAGES	4
+#define TDCR_DIVIDE_BY_1	0xb
+/* 50ms at KVM's default 1GHz APIC bus: long enough to mask LVTT first. */
+#define TIMER_COUNT		50000000u
+
+static void twin_sync(uint8_t stage)
+{
+	asm volatile("outb %0, %1" :: "a"(stage), "Nd"((uint16_t)TWIN_SYNC_PORT));
+}
+
+/* Runs with IF clear; the masked timer must never interrupt it anyway. */
+static void twin_guest_code(void)
+{
+	x2apic_enable();
+	x2apic_write_reg(APIC_TDCR, TDCR_DIVIDE_BY_1);
+	x2apic_write_reg(APIC_LVTT, APIC_LVT_TIMER_ONESHOT | TEST_VECTOR);
+	x2apic_write_reg(APIC_TMICT, TIMER_COUNT);
+	x2apic_write_reg(APIC_LVTT, APIC_LVT_MASKED | APIC_LVT_TIMER_ONESHOT |
+				    TEST_VECTOR);
+	for (;;)
+		twin_sync(1);
+}
+
+static void plane0_guest_code(void)
+{
+	GUEST_SYNC(0);
+	GUEST_SYNC(1);
+	GUEST_DONE();
+}
+
+static void set_plane_run_state(int vcpu_fd, u64 state)
+{
+	int r = ioctl(vcpu_fd, KVM_SET_PLANE_RUN_STATE, &state);
+
+	TEST_ASSERT(!r, "KVM_SET_PLANE_RUN_STATE(0x%lx) failed: errno %d",
+		    state, errno);
+}
+
+static u32 twin_tmcct(int twin_fd)
+{
+	struct kvm_lapic_state lapic;
+	int r = ioctl(twin_fd, KVM_GET_LAPIC, &lapic);
+
+	TEST_ASSERT(!r, "KVM_GET_LAPIC on twin failed: errno %d", errno);
+	return *(u32 *)&lapic.regs[APIC_TMCCT];
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	struct kvm_run *twin_run;
+	struct kvm_vcpu *vcpu0;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	int plane_fd, twin_fd, mmap_sz, r, i;
+
+	kvm_force_split_irqchip = true;
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	kvm_force_split_irqchip = false;
+
+	TEST_REQUIRE(vm_check_cap(vm, KVM_CAP_PLANES) >= 1);
+	TEST_REQUIRE(__vm_enable_cap(vm, KVM_CAP_PLANES, 2) == 0);
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL) &
+		     KVM_HYPERV_HCALL_VTL_CALLS);
+	/* VTL interrupt exits belong to the userspace-switch VTL contract. */
+	vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+		      KVM_HYPERV_HCALL_VTL_CALLS);
+
+	vcpu0 = vm_vcpu_add(vm, 0, plane0_guest_code);
+
+	plane_fd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL);
+	TEST_ASSERT(plane_fd >= 0, "KVM_CREATE_PLANE failed: errno %d", errno);
+	twin_fd = __kvm_ioctl(plane_fd, KVM_CREATE_VCPU, NULL);
+	TEST_ASSERT(twin_fd >= 0, "KVM_CREATE_VCPU on plane 1 failed: errno %d",
+		    errno);
+
+	mmap_sz = ioctl(vm->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	TEST_ASSERT(mmap_sz >= (int)sizeof(*twin_run),
+		    "KVM_GET_VCPU_MMAP_SIZE failed");
+	twin_run = mmap(NULL, mmap_sz, PROT_READ | PROT_WRITE, MAP_SHARED,
+			twin_fd, 0);
+	TEST_ASSERT(twin_run != MAP_FAILED, "mmap of twin kvm_run failed");
+
+	/* Same mode and page tables as plane 0, own code and stack, IF clear. */
+	vcpu_sregs_get(vcpu0, &sregs);
+	r = ioctl(twin_fd, KVM_SET_SREGS, &sregs);
+	TEST_ASSERT(!r, "KVM_SET_SREGS on twin failed: errno %d", errno);
+
+	r = ioctl(twin_fd, KVM_GET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_GET_REGS on twin failed: errno %d", errno);
+	regs.rip = (unsigned long)twin_guest_code;
+	regs.rsp = vm_alloc_stack(vm, TWIN_STACK_PAGES);
+	regs.rflags = 0x2;
+	r = ioctl(twin_fd, KVM_SET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_SET_REGS on twin failed: errno %d", errno);
+
+	/* Run the twin until it has armed and masked its timer. */
+	set_plane_run_state(twin_fd, 0);
+	set_plane_run_state(vcpu0->fd, KVM_PLANE_RUN_STATE_USER_HOLD);
+	r = ioctl(vcpu0->fd, KVM_RUN, NULL);
+	TEST_ASSERT(!r, "KVM_RUN (twin runnable) failed: errno %d", errno);
+	TEST_ASSERT_EQ(twin_run->exit_reason, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(twin_run->io.port, TWIN_SYNC_PORT);
+
+	/* Suspend the twin and let its masked timer expire. */
+	set_plane_run_state(twin_fd, KVM_PLANE_RUN_STATE_USER_HOLD);
+	set_plane_run_state(vcpu0->fd, 0);
+	for (i = 0; i < 100 && twin_tmcct(twin_fd); i++)
+		usleep(10000);
+	TEST_ASSERT(!twin_tmcct(twin_fd), "The twin's timer did not expire");
+
+	/*
+	 * Plane 0 must make progress: the latched expiry of a masked timer
+	 * is not an event of the twin's.
+	 */
+	for (i = 0; i < 3; i++) {
+		vcpu_run(vcpu0);
+		/* A masked higher-plane timer must not count as an event. */
+		TEST_ASSERT(vcpu0->run->exit_reason == KVM_EXIT_IO,
+			    "Plane 0 did not run: exit %u (%s), hyperv type %u",
+			    vcpu0->run->exit_reason,
+			    exit_reason_str(vcpu0->run->exit_reason),
+			    vcpu0->run->exit_reason == KVM_EXIT_HYPERV ?
+			    vcpu0->run->hyperv.type : 0);
+		switch (get_ucall(vcpu0, &uc)) {
+		case UCALL_SYNC:
+			TEST_ASSERT_EQ(uc.args[1], i);
+			break;
+		case UCALL_DONE:
+			TEST_ASSERT_EQ(i, 2);
+			break;
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+		default:
+			TEST_FAIL("Unexpected ucall %lu", uc.cmd);
+		}
+	}
+
+	kvm_munmap(twin_run, mmap_sz);
+	close(twin_fd);
+	close(plane_fd);
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

