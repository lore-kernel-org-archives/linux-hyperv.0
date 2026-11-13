Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.92.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594895;
	b=NuFiCZLaB/Xz9NRV/dr9vEuzd1DL/O4tDXzS2xVxUiETXlNzPImUYEBVsii7V2ZQ1aFr
	 Yd0POQnELp0D1W7Yce6jMKNIyJUZOaMVGI8qktqCct9imq7xFcIxmHZaz1uKwK9syqP4k
	 EuQKT3RZioCT8TxHPf23RgSTL/+BnNaF+a0ypzsws0SEKgaNDJ5TQMIPp1Mjv9HW/hTQq
	 iRwqNgq//iH0CjO994UNqB4CGZjwltbEKIKZEUZLeERlM9lOESocwjpTz6aiHkdTimup0
	 vkbHBf9Z2ArW5kBWSupDwB23CbcHZvArmsWB101nV2pZLxrMgpC4CPaavg5ooXn/R6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594895;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=+aLCPDLIUPibFI5ustQLgv0SbezMrfQuPxUL6p09Xls=;
	b=GN66aqF7MAwdWkSDi3OXxzoFA7nN/gfiZEm/+9fzTmXmsMGdr1atVd0hY+jLK77B5ZGz
	 4V7kgdOEpvxGI9nQaj/QTgqlG/eetSaSfePOuCCCA6G+dcLUhn5bOR0BIU22JLA1RH70f
	 n6zcbgxnEFJRFtCBSrLqmFzE4oGeVutruzG7PL6lVKlH5YnaUc4Cypy0MKAEF4Hp8EUgX
	 bzH0tBLik8FcyygdhkYtQGzli6toYJTxnjMINl/YJ6Cg7IgEpdQyRCpniqla0miI1sgWp
	 Ihilk/Hj+ciO8vETr9GaPUZV/cChNygfBSy6XgQxwyY3iDNEHjo2gGUX3W9cWLUPyuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=desiato.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b="geNsEB/B";
	arc=none smtp.remote-ip=90.155.92.199
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1999606A33F;
	Fri, 13 Nov 2026 18:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1999606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=geNsEB/B
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+aLCPDLIUPibFI5ustQLgv0SbezMrfQuPxUL6p09Xls=; b=geNsEB/BJbnX0LYlRmL0QiLgnt
	o75I/wAxObk2BCGvDdL6dqXADMbDo0W5RjfB78NDiwjrwYBQbTATAuWgcgEjEZnfCnhyyu+wENlqW
	ePEqLy/DRcti7XSSvyYjvL3KRGxWK2V7XR0tWyIjLF/S94TryFPQVB3g7vIVq+GAYPPk7YUdl8A6u
	/FlZ1/wdV6Nsl6zBT3fTLBgX9e4bdPEykzAkpoj24eX40WDtveXeZjzzXXn4PycoVixilmkLIsoV5
	Db+hZzr7RM59VGswmcNa/MBEy8n03Hlosp2UxaRwBp/jeDVS0l+j4z2MLqfSuNAjb/XGdcDwmEk43
	O9Ps6kWA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by desiato.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6t-0000000Bezz-3A5d;
	Fri, 13 Nov 2026 18:34:51 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6r-00000000Lsv-26Wl;
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
Subject: [RFC PATCH v2 07/31] KVM: selftests: Cover single-step over a forwarded VTL call
Date: Fri, 13 Nov 2026 18:34:23 +0000
Message-ID: <20261113183448.84094-8-dwmw2@infradead.org>
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

A forwarded HvCallVtlCall retires the vmcall before the exit is
delivered, and under KVM_GUESTDBG_SINGLESTEP the deferred skip used to
overwrite the KVM_EXIT_HYPERV exit with KVM_EXIT_DEBUG, silently
dropping the switch.

Single-step across a VTL call in the forwarding test, with
KVM_HYPERV_HCALL_VTL_CALLS enabled alongside forwarding: the hypercall
exit must still arrive, hcall.result must be ignored, and the guest
must resume past the vmcall with the RAX value userspace wrote
directly with KVM_SET_REGS, as a failed switch does.

The stage runs only where KVM reports KVM_HYPERV_HCALL_VTL_CALLS;
elsewhere the test skips it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 .../selftests/kvm/x86/hyperv_forward_hcall.c  | 78 ++++++++++++++++++-
 1 file changed, 75 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
index 3c23479e60ce..0e5ac99d2985 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_forward_hcall.c
@@ -5,6 +5,11 @@
  * userspace in memory-based and fast form, with userspace supplying the
  * result and the XMM output, and a userspace completion raising #UD
  * through the exit's flags.
+ *
+ * A forwarded VTL call is retired eagerly: the exit must survive the
+ * KVM_EXIT_DEBUG that single-stepping prepares for the retired vmcall,
+ * and the result the VMM writes must be ignored in favour of the RAX
+ * value userspace sets directly.
  */
 #include "test_util.h"
 #include "kvm_util.h"
@@ -14,12 +19,16 @@
 /* A hypercall code KVM does not implement (HvCallGetVpRegisters). */
 #define HVCALL_TEST_CODE	0x50
 
+/* HvCallVtlCall: forwarded with the vmcall already retired. */
+#define HVCALL_VTL_CALL		0x11
+
 #define FAST_PARAM0		0x1122334455667788ULL
 #define FAST_PARAM1		0x99aabbccddeeff00ULL
 #define XMM_IN_MARKER		0x5157ca11c0ffee00ULL
 #define XMM_OUT_MARKER		0x0de1ba5eba5eba11ULL
 #define USERSPACE_STATUS	0x55AA
 #define FULL_RESULT		(BIT_ULL(63) | USERSPACE_STATUS)
+#define VTL_RESULT_MARKER	0x1234567890abcdefULL
 
 enum {
 	STAGE_DISABLED = 1,
@@ -29,9 +38,10 @@ enum {
 	STAGE_RAISE_UD,
 	STAGE_FLAGS_CLEARED,
 	STAGE_REDISABLED,
+	STAGE_VTL_CALL,
 };
 
-static void guest_code(gpa_t pgs_gpa)
+static void guest_code(gpa_t pgs_gpa, bool vtl_calls)
 {
 	__sse128_u in, out;
 	u64 status;
@@ -100,6 +110,19 @@ static void guest_code(gpa_t pgs_gpa)
 	GUEST_ASSERT_EQ(status & 0xffff, HV_STATUS_INVALID_HYPERCALL_CODE);
 	GUEST_SYNC(STAGE_REDISABLED);
 
+	if (!vtl_calls)
+		GUEST_DONE();
+
+	/*
+	 * Single-step over a forwarded VTL call.  The vmcall is retired
+	 * before the exit, so hcall.result is ignored and the resume RAX
+	 * is whatever userspace wrote with KVM_SET_REGS.
+	 */
+	vector = __hyperv_hypercall(HVCALL_VTL_CALL, 0, 0, &status);
+	GUEST_ASSERT(!vector);
+	GUEST_ASSERT_EQ(status, VTL_RESULT_MARKER);
+	GUEST_SYNC(STAGE_VTL_CALL);
+
 	GUEST_DONE();
 }
 
@@ -181,16 +204,47 @@ static void test_feature_mask(struct kvm_vm *vm)
 	vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, 0);
 }
 
+static void handle_vtl_call(struct kvm_vcpu *vcpu, int debug_exits)
+{
+	struct kvm_guest_debug debug = {};
+	struct kvm_regs regs;
+
+	/*
+	 * The forwarded VTL call must arrive even though retiring the
+	 * vmcall prepared a KVM_EXIT_DEBUG in the same run union.
+	 */
+	check_hcall_exit(vcpu, HVCALL_VTL_CALL, 0, 0);
+	TEST_ASSERT(debug_exits > 0, "Single-step was not active");
+
+	/*
+	 * The instruction is retired; the result must be ignored.  A failed
+	 * switch writes the status straight into the guest's RAX.
+	 */
+	vcpu->run->hyperv.u.hcall.result = 0;
+	vcpu_regs_get(vcpu, &regs);
+	regs.rax = VTL_RESULT_MARKER;
+	vcpu_regs_set(vcpu, &regs);
+
+	vcpu_guest_debug_set(vcpu, &debug);
+}
+
 int main(int argc, char *argv[])
 {
+	struct kvm_guest_debug debug = {};
 	struct kvm_vcpu *vcpu;
 	struct kvm_vm *vm;
 	gva_t hcall_page;
 	gpa_t hcall_gpa;
 	struct ucall uc;
 	int stage = STAGE_DISABLED;
+	int debug_exits = 0;
+	bool vtl_calls;
 
 	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_FORWARD_HCALL));
+	vtl_calls = kvm_check_cap(KVM_CAP_HYPERV_FORWARD_HCALL) &
+		    KVM_HYPERV_HCALL_VTL_CALLS;
+	if (!vtl_calls)
+		pr_info("KVM_HYPERV_HCALL_VTL_CALLS not supported, skipping the VTL call stage\n");
 
 	vm = vm_create_with_one_vcpu(&vcpu, guest_code);
 	vcpu_set_hv_cpuid(vcpu);
@@ -202,11 +256,16 @@ int main(int argc, char *argv[])
 	memset(addr_gva2hva(vm, hcall_page), 0x0, 3 * getpagesize());
 	hcall_gpa = addr_gva2gpa(vm, hcall_page);
 
-	vcpu_args_set(vcpu, 1, hcall_gpa);
+	vcpu_args_set(vcpu, 2, hcall_gpa, vtl_calls);
 
 	for (;;) {
 		vcpu_run(vcpu);
 
+		if (vcpu->run->exit_reason == KVM_EXIT_DEBUG) {
+			debug_exits++;
+			continue;
+		}
+
 		if (vcpu->run->exit_reason == KVM_EXIT_HYPERV) {
 			switch (stage) {
 			case STAGE_MEMORY:
@@ -239,6 +298,9 @@ int main(int argc, char *argv[])
 						 hcall_gpa + 2 * getpagesize());
 				vcpu->run->hyperv.u.hcall.result = USERSPACE_STATUS;
 				break;
+			case STAGE_VTL_CALL:
+				handle_vtl_call(vcpu, debug_exits);
+				break;
 			default:
 				TEST_FAIL("Unexpected hypercall exit in stage %d", stage);
 			}
@@ -263,6 +325,16 @@ int main(int argc, char *argv[])
 			case STAGE_FLAGS_CLEARED:
 				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL, 0);
 				break;
+			case STAGE_REDISABLED:
+				if (!vtl_calls)
+					break;
+				vm_enable_cap(vm, KVM_CAP_HYPERV_FORWARD_HCALL,
+					      KVM_HYPERV_HCALL_FORWARD_UNKNOWN |
+					      KVM_HYPERV_HCALL_VTL_CALLS);
+				debug.control = KVM_GUESTDBG_ENABLE |
+						KVM_GUESTDBG_SINGLESTEP;
+				vcpu_guest_debug_set(vcpu, &debug);
+				break;
 			}
 			stage++;
 			break;
@@ -276,7 +348,7 @@ int main(int argc, char *argv[])
 	}
 
 done:
-	TEST_ASSERT_EQ(stage, STAGE_REDISABLED + 1);
+	TEST_ASSERT_EQ(stage, (vtl_calls ? STAGE_VTL_CALL : STAGE_REDISABLED) + 1);
 	kvm_vm_free(vm);
 	return 0;
 }
-- 
2.50.1

