Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594896;
	b=26EeDlbjaYmOXRr4bdY8bx9tehyk/Wz9JdUG9Jrg0cL8VT45KlnmUNKNFqmR8zYOpMKY
	 gIHbNPu1sCWxNBSmXfMkOCzm9WtDaZrHxtJuCDA/cFgN0pI7T1q5vQIhNCtLL6uwhSq0x
	 AnZifuLCDxoKR59cPOAKZj3KxDaWlhunszpTl5vvWgiJs1uTvDOO4pnQuuq+Tyjx7YNxy
	 RNrgaewTULIujb2MJ6jR5CT5HvuiPPV/rubIpXWkv2SXIXiStAUZGWQk1tV6JInE0Wtyy
	 tkZoDmxZEkEft6hte3pqLwM1eg1NCCcPZ41vEd7V+c9Lmioqdit4ldd7oBTYlt4svtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594896;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=ja8Oms7VXegy0qxvI7xlhg+tglwGtDJqaCHCJWbAubE=;
	b=L67aTJYpz7Kdr88LQObUz0CB5HGwXuxS0yVTUMlhLW23LXH7voYqVxyvmB4lB60EFHud
	 3cG568YoD3GKxpiDUmpg4hZGZ891/uUNWN312Zdyu0/beyl5fuDT/l3Q+JjhdfBeLhxvg
	 dss5q9IelUaYGt02T+KiD8mK280CC57FNWIZh3x7LQJtIQG3YmapQM5dsND/ZWNG3oskG
	 6pJcTxai6lRWGKqnkKMAMOzNOQXY531afhPOxTums/WsHOFwll55ljJO8KtVmhjFXuRFG
	 CL1roUNs/q842kYm+5/1rl47KeMAbtSxXhRUx9zXzucvUiWP44uppr+v3ECkR14wsPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ATFlPP0e;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B221D60A5BC3;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B221D60A5BC3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=ATFlPP0e
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=ja8Oms7VXegy0qxvI7xlhg+tglwGtDJqaCHCJWbAubE=; b=ATFlPP0euhKN52ISEZLsdcfPmQ
	m/wM1k3paLK1RuN3M27IBzkXwfDQDrNMUAjTt03zn4OMItM8EKMw11b/udecjB5VsFi1WjJjdym5A
	BbIGEk04APTTrfY8dbn8kM7GEd58xi5AnWk4fT2ShyuxLSrrrhlt5koSjxoIHv7Be+ccaBPx+XrN7
	VOl/x+svkJsjNVgEWdlkeJDKocp1+awtg/umvxwOwOvgEmFDM/GjOUdJvA5dq0R/HHSqPN1w47o+O
	5qkT5OpUVNRklnPc52zzAJe1wi/55Ea9EpQjzI6w7LKl0OyT8lWfgKp0eUjj6agu61AN/mRV5ioLC
	owxKIrkw==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6v-0000000Bf06-0UFb;
	Fri, 13 Nov 2026 18:34:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000LuD-1ZS2;
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
Subject: [RFC PATCH v2 25/31] KVM: selftests: Check that a higher plane's NMI survives HLT and suspension
Date: Fri, 13 Nov 2026 18:34:41 +0000
Message-ID: <20261113183448.84094-26-dwmw2@infradead.org>
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

An NMI sent through the APIC to a non-zero plane is folded back to
plane 0 and leaves only a marker on the targeted plane. When that plane
is the selected one and halted, nothing but the marker can wake it, and
an NMI must break HLT.

Run the plane-1 twin as the selected plane with plane 0 held, halt
it with IF clear, and send an NMI MSI through the plane-1 fd from a
second thread. The twin must leave HLT and reach its next sync point;
if it does not, the thread interrupts KVM_RUN with a signal so the test
fails instead of hanging.

Software-enable the twin's APIC with KVM_SET_LAPIC first. Its plane's
APIC map is built from APIC state writes, and the creation-time reset
runs before the twin joins the plane, so without one the MSI reaches no
vCPU. Assert that KVM_SIGNAL_MSI reports exactly one delivery, so a
lost MSI fails at the send instead of looking like a missed wakeup.

A second case covers an NMI posted to the plane itself. The twin runs
with NMIs blocked (nmi.masked set through KVM_SET_VCPU_EVENTS, as in an
NMI handler before IRET), gets a pending NMI through the same ioctl
(KVM_NMI is not accepted on a plane fd), runs on so the marker is
consumed with the NMI still pending, and is held as a userspace VTL
switch would. Running plane 0 must then report a
KVM_EXIT_HYPERV_VTL_INTERRUPT exit for plane 1. That case needs
KVM_HYPERV_HCALL_VTL_CALLS and is skipped without it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/planes_vtl_nmi_halt_test.c        | 305 ++++++++++++++++++
 2 files changed, 306 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_nmi_halt_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 446a526750e0..42b0bf7e8128 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -117,6 +117,7 @@ TEST_GEN_PROGS_x86 += x86/planes_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_entry_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_timer_mask_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_restore_test
+TEST_GEN_PROGS_x86 += x86/planes_vtl_nmi_halt_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/x86/planes_vtl_nmi_halt_test.c b/tools/testing/selftests/kvm/x86/planes_vtl_nmi_halt_test.c
new file mode 100644
index 000000000000..69646dc2563b
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_vtl_nmi_halt_test.c
@@ -0,0 +1,305 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that an NMI aimed at a higher plane is not lost while that plane
+ * cannot take it.
+ *
+ * Folded NMI, halted plane: an NMI delivered through the APIC to a
+ * non-zero plane is folded back to plane 0 and leaves only a marker on
+ * the targeted plane.  When that plane is the selected one and sits in
+ * HLT, the marker is all there is to wake it: the plane's own event checks
+ * see no NMI, and plane 0's events are only examined when the plane enters
+ * the guest.  The plane-1 twin runs with plane 0 held and halts with IF
+ * clear.  A helper thread then sends an NMI MSI through the plane-1 fd,
+ * which must reach exactly one vCPU, and the twin must leave HLT and reach
+ * its next sync point.  If the twin stays halted, the helper interrupts
+ * KVM_RUN with a signal so the test fails instead of hanging.
+ *
+ * Blocked NMI, suspended plane: an NMI posted to the plane itself
+ * (KVM_SET_VCPU_EVENTS on its fd) earns one forced VTL entry through the
+ * same kind of single-shot marker.  A run with NMIs blocked, as inside an
+ * NMI handler before IRET, consumes the marker without taking the NMI.
+ * When the plane then suspends, KVM must re-arm the marker, or the lower
+ * VTL never hears of the NMI.  The twin runs with NMIs blocked
+ * (nmi.masked), gets a pending NMI, runs on, and is held like a
+ * userspace VTL switch; running plane 0 must then report a
+ * KVM_EXIT_HYPERV_VTL_INTERRUPT exit for plane 1.
+ */
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
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
+#define TWIN_SYNC_PORT		0x7e
+#define TWIN_STACK_PAGES	4
+#define MSI_ADDR_BASE		0xfee00000u
+#define MSI_DATA_DM_NMI		0x400u
+
+static int plane_fd;
+static pthread_t vcpu_thread;
+
+struct twin {
+	int fd;
+	struct kvm_run *run;
+	int mmap_sz;
+};
+
+static void twin_sync(uint8_t stage)
+{
+	asm volatile("outb %0, %1" :: "a"(stage), "Nd"((uint16_t)TWIN_SYNC_PORT));
+}
+
+static void twin_halt_code(void)
+{
+	twin_sync(1);
+	asm volatile("cli; hlt");
+	for (;;)
+		twin_sync(2);
+}
+
+static void twin_spin_code(void)
+{
+	twin_sync(1);
+	for (;;)
+		twin_sync(2);
+}
+
+static void plane0_guest_code(void)
+{
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
+static void sigusr1_handler(int sig)
+{
+}
+
+static void *nmi_sender(void *arg)
+{
+	struct kvm_msi msi = {
+		.address_lo = MSI_ADDR_BASE,	/* physical APIC ID 0 */
+		.data = MSI_DATA_DM_NMI,
+	};
+	int r;
+
+	/* Give the twin time to halt. */
+	usleep(200000);
+	r = ioctl(plane_fd, KVM_SIGNAL_MSI, &msi);
+	TEST_ASSERT(r == 1, "KVM_SIGNAL_MSI on plane 1 reached %d vCPUs, errno %d",
+		    r, errno);
+
+	/* Break KVM_RUN if the NMI did not. */
+	sleep(2);
+	pthread_kill(vcpu_thread, SIGUSR1);
+	return NULL;
+}
+
+static struct kvm_vm *create_vm(struct kvm_vcpu **vcpu0, bool vtl_calls)
+{
+	struct kvm_vm *vm;
+
+	kvm_force_split_irqchip = true;
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	kvm_force_split_irqchip = false;
+
+	TEST_REQUIRE(vm_check_cap(vm, KVM_CAP_PLANES) >= 1);
+	TEST_REQUIRE(__vm_enable_cap(vm, KVM_CAP_PLANES, 2) == 0);
+	/* VTL interrupt exits belong to the userspace-switch VTL contract. */
+	if (vtl_calls)
+		vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+			      KVM_HYPERV_HCALL_VTL_CALLS);
+
+	*vcpu0 = vm_vcpu_add(vm, 0, plane0_guest_code);
+	return vm;
+}
+
+/* Plane-1 twin with the same mode and page tables as plane 0. */
+static void create_twin(struct kvm_vm *vm, struct kvm_vcpu *vcpu0,
+			void *code, struct twin *twin)
+{
+	struct kvm_lapic_state lapic;
+	struct kvm_sregs sregs;
+	struct kvm_regs regs;
+	int r;
+
+	plane_fd = __vm_ioctl(vm, KVM_CREATE_PLANE, (void *)1UL);
+	TEST_ASSERT(plane_fd >= 0, "KVM_CREATE_PLANE failed: errno %d", errno);
+	twin->fd = __kvm_ioctl(plane_fd, KVM_CREATE_VCPU, NULL);
+	TEST_ASSERT(twin->fd >= 0, "KVM_CREATE_VCPU on plane 1 failed: errno %d",
+		    errno);
+
+	twin->mmap_sz = ioctl(vm->kvm_fd, KVM_GET_VCPU_MMAP_SIZE, NULL);
+	TEST_ASSERT(twin->mmap_sz >= (int)sizeof(*twin->run),
+		    "KVM_GET_VCPU_MMAP_SIZE failed");
+	twin->run = mmap(NULL, twin->mmap_sz, PROT_READ | PROT_WRITE,
+			 MAP_SHARED, twin->fd, 0);
+	TEST_ASSERT(twin->run != MAP_FAILED, "mmap of twin kvm_run failed");
+
+	vcpu_sregs_get(vcpu0, &sregs);
+	r = ioctl(twin->fd, KVM_SET_SREGS, &sregs);
+	TEST_ASSERT(!r, "KVM_SET_SREGS on twin failed: errno %d", errno);
+
+	r = ioctl(twin->fd, KVM_GET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_GET_REGS on twin failed: errno %d", errno);
+	regs.rip = (unsigned long)code;
+	regs.rsp = vm_alloc_stack(vm, TWIN_STACK_PAGES);
+	regs.rflags = 0x2;
+	r = ioctl(twin->fd, KVM_SET_REGS, &regs);
+	TEST_ASSERT(!r, "KVM_SET_REGS on twin failed: errno %d", errno);
+
+	/*
+	 * Software-enable the twin's APIC.  As on plane 0, the plane's APIC
+	 * map is built from APIC state writes; the vCPU-creation reset runs
+	 * before the twin joins its plane, so until a KVM_SET_LAPIC an NMI
+	 * MSI would find no destination.
+	 */
+	r = ioctl(twin->fd, KVM_GET_LAPIC, &lapic);
+	TEST_ASSERT(!r, "KVM_GET_LAPIC on twin failed: errno %d", errno);
+	*(u32 *)&lapic.regs[APIC_SPIV] |= APIC_SPIV_APIC_ENABLED;
+	r = ioctl(twin->fd, KVM_SET_LAPIC, &lapic);
+	TEST_ASSERT(!r, "KVM_SET_LAPIC on twin failed: errno %d", errno);
+}
+
+static void destroy(struct kvm_vm *vm, struct twin *twin)
+{
+	kvm_munmap(twin->run, twin->mmap_sz);
+	close(twin->fd);
+	close(plane_fd);
+	kvm_vm_free(vm);
+}
+
+static void expect_twin_sync(struct twin *twin, uint8_t stage)
+{
+	TEST_ASSERT_EQ(twin->run->exit_reason, KVM_EXIT_IO);
+	TEST_ASSERT_EQ(twin->run->io.port, TWIN_SYNC_PORT);
+	TEST_ASSERT_EQ(*((uint8_t *)twin->run + twin->run->io.data_offset),
+		       stage);
+}
+
+static void test_folded_nmi_halt(void)
+{
+	struct kvm_vcpu *vcpu0;
+	struct twin twin;
+	struct kvm_vm *vm;
+	pthread_t sender;
+	int r;
+
+	vm = create_vm(&vcpu0, false);
+	create_twin(vm, vcpu0, twin_halt_code, &twin);
+
+	/* Run the twin as the selected plane, with plane 0 held. */
+	set_plane_run_state(twin.fd, 0);
+	set_plane_run_state(vcpu0->fd, KVM_PLANE_RUN_STATE_USER_HOLD);
+	r = ioctl(vcpu0->fd, KVM_RUN, NULL);
+	TEST_ASSERT(!r, "KVM_RUN (twin runnable) failed: errno %d", errno);
+	expect_twin_sync(&twin, 1);
+
+	signal(SIGUSR1, sigusr1_handler);
+	vcpu_thread = pthread_self();
+	r = pthread_create(&sender, NULL, nmi_sender, NULL);
+	TEST_ASSERT(!r, "pthread_create failed: %d", r);
+
+	/*
+	 * The twin halts; only the folded NMI can wake it.  Raw KVM_RUN on
+	 * purpose: the helper's SIGUSR1 must end this run with EINTR.
+	 */
+	r = ioctl(vcpu0->fd, KVM_RUN, NULL);
+	/* On failure, the folded NMI did not break the twin's HLT. */
+	TEST_ASSERT(!r, "KVM_RUN returned %d, errno %d", r, errno);
+	expect_twin_sync(&twin, 2);
+
+	pthread_cancel(sender);
+	pthread_join(sender, NULL);
+	destroy(vm, &twin);
+}
+
+static void test_blocked_nmi_suspend(void)
+{
+	struct kvm_vcpu_events events;
+	struct kvm_vcpu *vcpu0;
+	struct twin twin;
+	struct kvm_vm *vm;
+	int r;
+
+	if (!(kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL) &
+	      KVM_HYPERV_HCALL_VTL_CALLS)) {
+		print_skip("KVM_HYPERV_HCALL_VTL_CALLS not supported");
+		return;
+	}
+
+	vm = create_vm(&vcpu0, true);
+	create_twin(vm, vcpu0, twin_spin_code, &twin);
+
+	/* NMIs blocked, as in an NMI handler that has not reached IRET. */
+	r = ioctl(twin.fd, KVM_GET_VCPU_EVENTS, &events);
+	TEST_ASSERT(!r, "KVM_GET_VCPU_EVENTS on twin failed: errno %d", errno);
+	events.nmi.masked = 1;
+	r = ioctl(twin.fd, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(!r, "KVM_SET_VCPU_EVENTS on twin failed: errno %d", errno);
+
+	set_plane_run_state(twin.fd, 0);
+	set_plane_run_state(vcpu0->fd, KVM_PLANE_RUN_STATE_USER_HOLD);
+	vcpu_run(vcpu0);
+	expect_twin_sync(&twin, 1);
+
+	/*
+	 * Post an NMI to the twin, NMIs still blocked; the next run
+	 * consumes its marker.  KVM_NMI is not accepted on a plane fd.
+	 */
+	r = ioctl(twin.fd, KVM_GET_VCPU_EVENTS, &events);
+	TEST_ASSERT(!r, "KVM_GET_VCPU_EVENTS on twin failed: errno %d", errno);
+	events.flags = KVM_VCPUEVENT_VALID_NMI_PENDING;
+	events.nmi.pending = 1;
+	events.nmi.masked = 1;
+	r = ioctl(twin.fd, KVM_SET_VCPU_EVENTS, &events);
+	TEST_ASSERT(!r, "KVM_SET_VCPU_EVENTS (NMI) on twin failed: errno %d",
+		    errno);
+	vcpu_run(vcpu0);
+	expect_twin_sync(&twin, 2);
+
+	r = ioctl(twin.fd, KVM_GET_VCPU_EVENTS, &events);
+	TEST_ASSERT(!r, "KVM_GET_VCPU_EVENTS on twin failed: errno %d", errno);
+	TEST_ASSERT(events.nmi.pending && events.nmi.masked,
+		    "Expected a blocked NMI to stay pending (pending %u, masked %u)",
+		    events.nmi.pending, events.nmi.masked);
+
+	/* Suspend the twin as a VtlReturn would, NMI still latched. */
+	set_plane_run_state(twin.fd, KVM_PLANE_RUN_STATE_USER_HOLD);
+	set_plane_run_state(vcpu0->fd, 0);
+
+	/* On failure the NMI was forgotten and plane 0 runs its guest. */
+	vcpu_run(vcpu0);
+	TEST_ASSERT(vcpu0->run->exit_reason == KVM_EXIT_HYPERV,
+		    "Expected KVM_EXIT_HYPERV, got %u (%s): the twin's blocked NMI was lost when it suspended",
+		    vcpu0->run->exit_reason,
+		    exit_reason_str(vcpu0->run->exit_reason));
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.type, KVM_EXIT_HYPERV_VTL_INTERRUPT);
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.plane, 1);
+
+	destroy(vm, &twin);
+}
+
+int main(int argc, char *argv[])
+{
+	test_folded_nmi_halt();
+	test_blocked_nmi_suspend();
+	return 0;
+}
-- 
2.50.1

