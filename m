Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594895;
	b=mqYWNwMfX5IBavrKCIgSieBnuvwUDGbzEkkxaIAezWmyM/AGtgV/mzpGmKw9b42+WzPs
	 9rtm8PY/GUa95GqI63FqeP+dzq2prUkflRDBtcrDT+i54exUQK/ThF5WwhYRzwB5PCBdp
	 kEGKTl/uNwXXTFU6erS/lsL8TfULZqj24I1F6gE3zoIexIr7oNg9B0CxI9oWeLs5HNo+j
	 a7mKPw3/RDxNY6HHSGTStqAxv5x7sZU4ma6YNvw83evdRTnJ31EkqmgI6mKGIZddf9xWE
	 OL3CgteCJLNDlozzK55kPiVGHejYGAe+L82DrYOZGcDEoLxWPp6ctuzDPs0Mqbxg5oA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=e0QjDoSDOqtjXi/aRoGP666o2KHiNjjVlepe5JNaymU=;
	b=A/CcGzLclqIB4DOZYEUzVj5tcIpZPLvSvqXd/hT5U/PMKpqaGmjhHfF4vZvjCQoPvrmP
	 oWbpxcVhQY8pPgxp6X63jM73Ucp3dDF6tQ9sCpGmaSRz1Hq8DwPv4P4O/1mw4pO4aGLtG
	 pYb/cvGNfVGe6U+6h7bggieEUsYs2uXqyONBcbv/Cyl8CJwWRhPJff0cXBSLllyAi6H8R
	 QiBA9ALaY0cGJrk99qWREGEGEUKAPf8yemM2LnEKM1LmlT+JssmJIu46PKam+6AzPFqup
	 y/oawkICfrrXjIaMOtp5hkiOnbEEt7BZr63XbLgDdNozo7NpBkGn22xUrx4ra3JHOUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=R4c9Wc5k;
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEEC60A383F;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AEEEC60A383F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=R4c9Wc5k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=e0QjDoSDOqtjXi/aRoGP666o2KHiNjjVlepe5JNaymU=; b=R4c9Wc5kaf4dtb12GOu7/i2wR3
	Vzf1j82Ld0ZPYVKP65TcpO/83QyHkCaX8aN1FLXsiO/XtyUaSfCqH+RIVUJfgGFC06E0gtIYrn1Hv
	D3CQKbvuxGIm5pw2gl81Oo34BnsYRVcUiGKCheBmpkSfqXZkUC7SazHHB5U8paEmTqjPtnaqJEo6Y
	LXYSBB3Tjjbtq5vp4FCwmTwNf6mfJlPaalDmBKqphosYcRi/cCUh/Njz031IUF77EMuPxZzP7dhlF
	W0fhycYJcJYVuf3g+VQZuPr4yMll5uIqZD+Zk00sD4CRzsCDjmNz2V10o6yVIQITTUA5Ige2omnpt
	VuUp8kbg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6v-0000000Bf05-0Ueo;
	Fri, 13 Nov 2026 18:34:53 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000Lu9-1P8S;
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
Subject: [RFC PATCH v2 24/31] KVM: selftests: Check that a restored higher-plane interrupt forces an exit
Date: Fri, 13 Nov 2026 18:34:40 +0000
Message-ID: <20261113183448.84094-25-dwmw2@infradead.org>
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

A migration destination restores a higher plane's IRR with
KVM_SET_LAPIC, which does not go through __apic_accept_irq() and so
sets no forced-entry marker, and its plane vCPUs have never entered the
guest on that host. KVM must re-derive the marker from the restored
IRR, or an interrupt posted to a suspended VTL1 just before the save is
never delivered.

Model the destination: give a plane-1 twin that has never run an IRR
bit through KVM_SET_LAPIC, leave it held, and require plane 0 to
exit with KVM_EXIT_HYPERV_VTL_INTERRUPT for plane 1. Run it with the
LAPIC restored before and after KVM_SET_PLANE_RUN_STATE.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../kvm/x86/planes_vtl_restore_test.c         | 121 ++++++++++++++++++
 2 files changed, 122 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/planes_vtl_restore_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index c6ad866a0b0d..446a526750e0 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -116,6 +116,7 @@ TEST_GEN_PROGS_x86 += x86/plane_x86_test
 TEST_GEN_PROGS_x86 += x86/planes_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_entry_test
 TEST_GEN_PROGS_x86 += x86/planes_vtl_timer_mask_test
+TEST_GEN_PROGS_x86 += x86/planes_vtl_restore_test
 TEST_GEN_PROGS_x86 += x86/pmu_counters_test
 TEST_GEN_PROGS_x86 += x86/pmu_event_filter_test
 TEST_GEN_PROGS_x86 += x86/private_mem_conversions_test
diff --git a/tools/testing/selftests/kvm/x86/planes_vtl_restore_test.c b/tools/testing/selftests/kvm/x86/planes_vtl_restore_test.c
new file mode 100644
index 000000000000..186a9338627d
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/planes_vtl_restore_test.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that a restored higher plane with a latched interrupt still forces
+ * a VTL interrupt exit.
+ *
+ * Forced entry is triggered by the posting of an interrupt to a higher
+ * plane, through a marker __apic_accept_irq() sets.  A migration
+ * destination restores the IRR with KVM_SET_LAPIC instead, which posts
+ * nothing, and its plane vCPUs have never entered the guest on that host.
+ * KVM must re-derive the marker from the restored IRR, whichever of
+ * KVM_SET_LAPIC and KVM_SET_PLANE_RUN_STATE the VMM issues last, or a
+ * one-shot cross-VTL interrupt sent just before the save is lost.
+ *
+ * Each run models a destination: a plane-1 twin that has never run gets
+ * an IRR bit through KVM_SET_LAPIC and is left held, and running plane
+ * 0 must report a KVM_EXIT_HYPERV_VTL_INTERRUPT exit for plane 1.
+ */
+#include <errno.h>
+#include <string.h>
+#include <sys/ioctl.h>
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
+#define TEST_VECTOR	0xe0
+
+static void plane0_guest_code(void)
+{
+	GUEST_SYNC(0);
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
+/* Enable the twin's APIC in software and latch TEST_VECTOR in its IRR. */
+static void restore_twin_lapic(int twin_fd)
+{
+	struct kvm_lapic_state lapic;
+	u32 *reg;
+	int r;
+
+	r = ioctl(twin_fd, KVM_GET_LAPIC, &lapic);
+	TEST_ASSERT(!r, "KVM_GET_LAPIC on twin failed: errno %d", errno);
+
+	reg = (u32 *)&lapic.regs[APIC_SPIV];
+	*reg |= APIC_SPIV_APIC_ENABLED;
+	reg = (u32 *)&lapic.regs[APIC_IRR + (TEST_VECTOR / 32) * 0x10];
+	*reg |= 1u << (TEST_VECTOR % 32);
+
+	r = ioctl(twin_fd, KVM_SET_LAPIC, &lapic);
+	TEST_ASSERT(!r, "KVM_SET_LAPIC on twin failed: errno %d", errno);
+}
+
+static void run_test(bool lapic_first)
+{
+	struct kvm_vcpu *vcpu0;
+	struct kvm_vm *vm;
+	int plane_fd, twin_fd, r;
+
+	kvm_force_split_irqchip = true;
+	vm = __vm_create(VM_SHAPE_DEFAULT, 1, 0);
+	kvm_force_split_irqchip = false;
+
+	TEST_REQUIRE(__vm_enable_cap(vm, KVM_CAP_PLANES, 2) == 0);
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
+	if (lapic_first)
+		restore_twin_lapic(twin_fd);
+	set_plane_run_state(twin_fd, KVM_PLANE_RUN_STATE_USER_HOLD);
+	set_plane_run_state(vcpu0->fd, 0);
+	if (!lapic_first)
+		restore_twin_lapic(twin_fd);
+
+	r = ioctl(vcpu0->fd, KVM_RUN, NULL);
+	TEST_ASSERT(!r, "KVM_RUN (plane 0) failed: errno %d", errno);
+	TEST_ASSERT(vcpu0->run->exit_reason == KVM_EXIT_HYPERV,
+		    "Expected KVM_EXIT_HYPERV, got %u (%s), LAPIC restored %s",
+		    vcpu0->run->exit_reason,
+		    exit_reason_str(vcpu0->run->exit_reason),
+		    lapic_first ? "first" : "last");
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.type, KVM_EXIT_HYPERV_VTL_INTERRUPT);
+	TEST_ASSERT_EQ(vcpu0->run->hyperv.plane, 1);
+
+	close(twin_fd);
+	close(plane_fd);
+	kvm_vm_free(vm);
+}
+
+int main(int argc, char *argv[])
+{
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_PLANES));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL) &
+		     KVM_HYPERV_HCALL_VTL_CALLS);
+
+	run_test(true);
+	run_test(false);
+	return 0;
+}
-- 
2.50.1

