Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404A7490BF8;
	Sat, 17 Oct 2026 12:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=VauN8lE1YxxWbn3CuQh3mC8zTfvx0JSGyFG7OFyVTzcImaFBVPtB/k+Pz5ZVvMAohr4PBZwF0fsVopzhcQIkl0iwBBCgfQiyox/lEN4VgjsnbSvjQ3DgzSSL4P3yczU6M6sR9dVnRHKGYTFo8tnrsliNiOQYiKTQUNbIN7pbDts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=vr814dPQ7m+H8Psfpz2S57tibOiNxzsQ2rMb10VDSfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzloKt+q1Y62W2Du9DLN4jneJx0N06PZFAEGpZ2DAWXqTu34WtyoLSIcJkgT5+3fAP8BjO4Yd07VGhLmRARCyco/yFPrY+BUbi/db5mFIqSSIiTODBIH6dlPcJqlgDswT4LZNbipo1XELSV9m/66xyqrmdsSpaP685qBcv9UP9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rK7/yPkJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rK7/yPkJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description;
	bh=a4CHpkcKk/utciFY5YQmuIJ361lOG35Qn0BJvjWEjlo=; b=rK7/yPkJmhRU1BF/WKlhP2FUB6
	nKbcCjbDJMJMacaEwdDhkHkdY8hyXUfN/1GmyFO3F2xhB0FOz0pQqMiCPSiSlWkCQuDZS2cT9EkVi
	Bw3I7rdyr4Kevdbsz4rOk+JEE0Ip72YK/W5Uqlgyr31EfRSaR4SbuT+qjhpq+aYV1St1Mz+BIQbZe
	KjZLtZ/epZfJvE3h3m02vMC9gCZp0+L007TsqcKfYgoVKwPb917z6LnORLnwHJ7ls1xm0zCkUUeni
	RVDCQaPN8g+BPlsDuaHi2cmr4B4umCkulpCmgQcH8mEeh+8Z4cn1EVtsYR0fB1EpnJShHAb/b4s6a
	RuREs/Lg==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVEV-2GHk;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TE-00000002YoW-1ONF;
	Sat, 17 Oct 2026 13:25:04 +0100
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
	David Woodhouse <dwmw@amazon.co.uk>,
	nh-open-source@amazon.com
Subject: [RFC PATCH 52/55] KVM: selftests: Add Hyper-V reference TSC page memory attribute test
Date: Sat, 17 Oct 2026 13:24:58 +0100
Message-ID: <20261017122501.610248-53-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: David Woodhouse <dwmw@amazon.co.uk>

The reference TSC page is written by the host, not by the guest, so
the guest-side memory attribute tests never cover it.  Add a test
that a page at an unprotected gfn is maintained as usual, that
pointing HV_X64_MSR_REFERENCE_TSC at a gfn carrying
KVM_MEMORY_ATTRIBUTE_NW leaves the page contents untouched — on the
MSR write itself and on a subsequent KVM_SET_CLOCK-forced update —
and that re-pointing the MSR at a writable page recovers.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Assisted-by: LLM
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/hyperv_tsc_page_attrs.c | 129 ++++++++++++++++++
 2 files changed, 130 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 47c7a4c732eb..6edeb6693375 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -89,6 +89,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_forward_hcall
 TEST_GEN_PROGS_x86 += x86/hyperv_ipi
 TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
+TEST_GEN_PROGS_x86 += x86/hyperv_tsc_page_attrs
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
diff --git a/tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c b/tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c
new file mode 100644
index 000000000000..efa47ae69780
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Test that KVM honours plane memory attributes when it maintains the
+ * Hyper-V reference TSC page.  A page whose gfn carries
+ * KVM_MEMORY_ATTRIBUTE_NW in the owning plane's attributes must never
+ * be written by the host, on the HV_X64_MSR_REFERENCE_TSC write or on
+ * any later masterclock update; an unprotected page keeps working, and
+ * re-pointing the MSR at a writable page recovers.
+ */
+#include "test_util.h"
+#include "kvm_util.h"
+#include "processor.h"
+#include "hyperv.h"
+
+struct ms_hyperv_tsc_page {
+	volatile u32 tsc_sequence;
+	u32 reserved1;
+	volatile u64 tsc_scale;
+	volatile s64 tsc_offset;
+} __packed;
+
+#define SENTINEL_SEQ	0xdeadbeef
+#define SENTINEL_U64	0xcafef00dcafef00dULL
+
+static void guest_main(struct ms_hyperv_tsc_page *page_a, gpa_t page_a_gpa,
+		       struct ms_hyperv_tsc_page *page_b, gpa_t page_b_gpa)
+{
+	/* Set Guest OS id to enable Hyper-V emulation */
+	wrmsr(HV_X64_MSR_GUEST_OS_ID, HYPERV_LINUX_OS_ID);
+
+	/* An unprotected page is maintained by KVM as usual. */
+	wrmsr(HV_X64_MSR_REFERENCE_TSC, page_a_gpa | 0x1);
+	GUEST_ASSERT(page_a->tsc_sequence != 0);
+
+	/* Fill the page about to be protected, while it is still writable. */
+	page_b->tsc_sequence = SENTINEL_SEQ;
+	page_b->tsc_scale = SENTINEL_U64;
+	page_b->tsc_offset = SENTINEL_U64;
+
+	GUEST_SYNC(1);	/* host sets KVM_MEMORY_ATTRIBUTE_NW on page_b */
+
+	/*
+	 * Pointing the reference TSC MSR at the protected page must not
+	 * have KVM write to it: not on the MSR write itself, and not on
+	 * the masterclock update the write requests.
+	 */
+	wrmsr(HV_X64_MSR_REFERENCE_TSC, page_b_gpa | 0x1);
+	GUEST_ASSERT(page_b->tsc_sequence == SENTINEL_SEQ);
+	GUEST_ASSERT(page_b->tsc_scale == SENTINEL_U64);
+	GUEST_ASSERT(page_b->tsc_offset == SENTINEL_U64);
+
+	GUEST_SYNC(2);	/* host resets kvmclock, forcing a TSC page update */
+
+	GUEST_ASSERT(page_b->tsc_sequence == SENTINEL_SEQ);
+	GUEST_ASSERT(page_b->tsc_scale == SENTINEL_U64);
+	GUEST_ASSERT(page_b->tsc_offset == SENTINEL_U64);
+
+	/* Re-pointing the MSR at a writable page recovers. */
+	wrmsr(HV_X64_MSR_REFERENCE_TSC, page_a_gpa | 0x1);
+	GUEST_ASSERT(page_a->tsc_sequence != 0);
+
+	GUEST_DONE();
+}
+
+int main(void)
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	gva_t page_a_gva, page_b_gva;
+	gpa_t page_b_gpa;
+	int stage;
+
+	TEST_REQUIRE(kvm_has_cap(KVM_CAP_HYPERV_TIME));
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
+		     KVM_MEMORY_ATTRIBUTE_NW);
+	TEST_REQUIRE(sys_clocksource_is_based_on_tsc());
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_main);
+
+	vcpu_set_hv_cpuid(vcpu);
+
+	page_a_gva = vm_alloc_page(vm);
+	page_b_gva = vm_alloc_page(vm);
+	memset(addr_gva2hva(vm, page_a_gva), 0x0, getpagesize());
+	memset(addr_gva2hva(vm, page_b_gva), 0x0, getpagesize());
+	page_b_gpa = addr_gva2gpa(vm, page_b_gva);
+
+	vcpu_args_set(vcpu, 4, page_a_gva, addr_gva2gpa(vm, page_a_gva),
+		      page_b_gva, page_b_gpa);
+
+	for (stage = 1;; stage++) {
+		vcpu_run(vcpu);
+		TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_IO);
+
+		switch (get_ucall(vcpu, &uc)) {
+		case UCALL_ABORT:
+			REPORT_GUEST_ASSERT(uc);
+			/* NOT REACHED */
+		case UCALL_SYNC:
+			break;
+		case UCALL_DONE:
+			/* Keep in sync with guest_main() */
+			TEST_ASSERT(stage == 3, "Testing ended prematurely, stage %d",
+				    stage);
+			goto out;
+		default:
+			TEST_FAIL("Unknown ucall %lu", uc.cmd);
+		}
+
+		TEST_ASSERT(uc.args[1] == stage,
+			    "Stage %d: Unexpected sync, got %lx",
+			    stage, (ulong)uc.args[1]);
+
+		if (stage == 1)
+			vm_set_memory_attributes(vm, page_b_gpa, getpagesize(),
+						 KVM_MEMORY_ATTRIBUTE_NW);
+
+		/* Reset kvmclock triggering TSC page update */
+		if (stage == 2) {
+			struct kvm_clock_data clock = {0};
+
+			vm_ioctl(vm, KVM_SET_CLOCK, &clock);
+		}
+	}
+
+out:
+	kvm_vm_free(vm);
+}
-- 
2.50.1

