Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=90.155.50.34
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794594893;
	b=hNsM/+/DJEJltNfRjyrUbw6xpWWoA82ekF11hRhrBZ1eTGCSUVuqKhJHXOxo3N00dADk
	 vbsXFKSk5ty9Aomh7iM5mOokV84Y3UX+h6gllxclEbdUYGvqZhayp72sie4IIEOZhBrrA
	 BYsJS6OKUb9eu5KvCZIjgenqAQsU7HkogvZuxHLquah2JvXU6vb1ftnwCfMwfH5Uq+is8
	 /WIIHH09C0gSr+Mx8XV39XoFE7a8f4DioTxLm3A8t+4JGZUnNVaMxfHHwddcLQtxFAzLW
	 B92MuvurTTwJFWSfUa+qtuE5m5S9Gbt9zIyTwJu5+smlnZmPAizE+HiVkMY8keyWOyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794594893;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Sender:X-SRS-Rewrite;
	bh=8UBIrCp1doq9/Q9DjRxsAJhTIftKS7tyh/VYFp/ZxXU=;
	b=ZIDtPs9uYxE70szayh2cKIuiqQjVT1nyH7wiEczXMm+eVsIL1eZwQHiRkA/ZFLgwP9jn
	 pLXFb6uGZTAAIs/2N4hgmVMfvp3YHY5e3Krejenfe1iEo3nPN8sJKeZ3Gur8TwjQOhlvF
	 ENk9NbPW7oF/RyEw8xq+W0VG6/oPeVH8CByVJT3TB+QeO05ylcDBPNAIS7at9NNj45v2P
	 OtcekUvZhkhWP7AjpEsMPjMmxBoucWJnhjI8hG/1pqPaihJ/hRNu+EgKB7I1okFsV9cXk
	 1yH1s7WX4AKD52Jx+7KHbZghrKiCxFMr3NMAkk8fwJgfTvwfkZ/3wPKYtR5jM1FGYmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=infradead.org;
	spf=none smtp.mailfrom=casper.srs.infradead.org;
	dkim=pass header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZjrICK7x;
	arc=none smtp.remote-ip=90.155.50.34
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E93606A898;
	Fri, 13 Nov 2026 18:34:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 78E93606A898
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=ZjrICK7x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=8UBIrCp1doq9/Q9DjRxsAJhTIftKS7tyh/VYFp/ZxXU=; b=ZjrICK7x2DQjHM1FpykNzIq6x4
	NUJmQ439YvNTlMYpC4vMG8hvY8x6PqBrVUw3Kjrh1/8O9bYP/rfuwo7rEcJ6HNJ/k9e8Jd0vQNShl
	G6Nu52j4rbWcA7Ht3CkSc8D6RWNEMx2gCn65bCvAqx4vTA9juNfdJ0nDx6h/RRLIgOTRRtsAIjjge
	plwen2x9xyPxtZ2vm95kJY2fXbhE6g5S9HZlmX60nBXn6rC4AVHVDNGSck7X8jmWsJEfCbdcccagY
	0L7ryB4a+Zg3hvptWP2w2ksb325aOaaXoOyBz5EELa8GiJHBhf9XZCF22/VPAU5cXXw6yWEp63qb5
	4BOhOl2A==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xRw6s-00000004gRD-3E6Y;
	Fri, 13 Nov 2026 18:34:50 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xRw6s-00000000LuU-2EA1;
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
Subject: [RFC PATCH v2 29/31] KVM: selftests: Add Hyper-V reference TSC page memory attribute test
Date: Fri, 13 Nov 2026 18:34:45 +0000
Message-ID: <20261113183448.84094-30-dwmw2@infradead.org>
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

The reference TSC page is written by the host, not by the guest, so
the guest-side memory attribute tests never cover it.  Add a test
that a page at an unprotected gfn is maintained as usual, that
pointing HV_X64_MSR_REFERENCE_TSC at a gfn carrying
KVM_MEMORY_ATTRIBUTE_NW leaves the page contents untouched, both on
the MSR write itself and on a subsequent KVM_SET_CLOCK-forced update,
and that re-pointing the MSR at a writable page recovers.  The guest
overwrites that page before the recovery, so only a fresh publish
passes.

It stays a test of its own rather than a case in memory_attributes.c:
it follows the Hyper-V MSR flow and needs Hyper-V CPUID.  struct
ms_hyperv_tsc_page moves from hyperv_clock.c into include/x86/hyperv.h
for both tests to use.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/include/x86/hyperv.h        |   8 ++
 .../testing/selftests/kvm/x86/hyperv_clock.c  |   7 -
 .../selftests/kvm/x86/hyperv_tsc_page_attrs.c | 131 ++++++++++++++++++
 4 files changed, 140 insertions(+), 7 deletions(-)
 create mode 100644 tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 2b8a238c32e8..5f58fff2d543 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -95,6 +95,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_forward_hcall
 TEST_GEN_PROGS_x86 += x86/hyperv_ipi
 TEST_GEN_PROGS_x86 += x86/hyperv_svm_test
 TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
+TEST_GEN_PROGS_x86 += x86/hyperv_tsc_page_attrs
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
diff --git a/tools/testing/selftests/kvm/include/x86/hyperv.h b/tools/testing/selftests/kvm/include/x86/hyperv.h
index 78003f5a22f3..c1d13a35fc0e 100644
--- a/tools/testing/selftests/kvm/include/x86/hyperv.h
+++ b/tools/testing/selftests/kvm/include/x86/hyperv.h
@@ -358,4 +358,12 @@ void vcpu_set_hv_cpuid(struct kvm_vcpu *vcpu);
 
 bool kvm_hv_cpu_has(struct kvm_x86_cpu_feature feature);
 
+/* HV_REFERENCE_TSC_PAGE */
+struct ms_hyperv_tsc_page {
+	volatile u32 tsc_sequence;
+	u32 reserved1;
+	volatile u64 tsc_scale;
+	volatile s64 tsc_offset;
+} __packed;
+
 #endif /* !SELFTEST_KVM_HYPERV_H */
diff --git a/tools/testing/selftests/kvm/x86/hyperv_clock.c b/tools/testing/selftests/kvm/x86/hyperv_clock.c
index 7a1b3b5d1e62..0db068af0863 100644
--- a/tools/testing/selftests/kvm/x86/hyperv_clock.c
+++ b/tools/testing/selftests/kvm/x86/hyperv_clock.c
@@ -9,13 +9,6 @@
 #include "processor.h"
 #include "hyperv.h"
 
-struct ms_hyperv_tsc_page {
-	volatile u32 tsc_sequence;
-	u32 reserved1;
-	volatile u64 tsc_scale;
-	volatile s64 tsc_offset;
-} __packed;
-
 /* Simplified mul_u64_u64_shr() */
 static inline u64 mul_u64_u64_shr64(u64 a, u64 b)
 {
diff --git a/tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c b/tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c
new file mode 100644
index 000000000000..7e618ffec6a6
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/hyperv_tsc_page_attrs.c
@@ -0,0 +1,131 @@
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
+	/*
+	 * Re-pointing the MSR at a writable page recovers.  Overwrite the
+	 * page first, so that only a fresh publish can pass the checks.
+	 */
+	page_a->tsc_sequence = SENTINEL_SEQ;
+	page_a->tsc_scale = SENTINEL_U64;
+	page_a->tsc_offset = SENTINEL_U64;
+	wrmsr(HV_X64_MSR_REFERENCE_TSC, page_a_gpa | 0x1);
+	GUEST_ASSERT(page_a->tsc_sequence != 0);
+	GUEST_ASSERT(page_a->tsc_sequence != SENTINEL_SEQ);
+	GUEST_ASSERT(page_a->tsc_scale != SENTINEL_U64);
+	GUEST_ASSERT(page_a->tsc_offset != SENTINEL_U64);
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

