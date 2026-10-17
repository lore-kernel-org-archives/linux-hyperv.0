Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76F848F84A;
	Sat, 17 Oct 2026 12:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792239911; cv=none; b=W505NRlFhCj8eJamJfTuQWcFoTC9ltmmEYtOdPz+32wyQco8saoRy0pF5bFlFRxPoHEvGpcM2vtPWODX4xP/ok5vCljtysafxK+vWfSJEFDTcp27ppxmCbSFA20O9Dnpo9PHovOyo38dnWhyfx8t2GzROhpiMl0zw4QIq+CqfbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792239911; c=relaxed/simple;
	bh=anYdUJUeV3wgHOsr/OXOvrQWV8As8i4sGRv/yElx0dI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lo6C+vFRjvcNzbZwY91KE3UskCTNaZd6BnjGjFkBLHOFyJjbOj2nVvqhLYEc7Vsb+8hB2E9X7FYoV2+ZMoDnsgGtbQXSHH0xY9/uba8ahY3k0wprKKt0MLX7bUPlLTLzqhQQzE7v8RHOvWVzbsEz2VtTPw9TR5Wt1v3NiDK3ClM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=casper.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AM4f85NJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=casper.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AM4f85NJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=9Rg6Pq/9dNRqE+YM5kpmFuNlesZd8z0cSvN8ctj0c14=; b=AM4f85NJiKZydZ/obeBiWpR2WC
	p/RhBGtavTyNfz7+xosKtD/CRL9o0pjMT+WFj4+CdWtN8y23DSEYf4nJuQyDegWipWWL79jYnGYWo
	XIMfhKIr+Y3toF3gEPO2X6Jea6O1nEuYt3wbCe9pFD+FiidusA1xg7705093CCY+rrkFL1bI2sKQZ
	bUCqa9/h/Y63c9KRx5emM1B6vl6keEKQXMBVFxQC0oI2lrHC8+HvuCCfFjsot/6+wLS0hJk0Qq0bR
	4ntRmTKn+OPbbFCmBCCN/qPVMeeDUo/t2ixBjugUA5ZIrHnFl+2vmqgUPoOZtR7Tn6E9YtY7bGvu6
	kuaNSRtA==;
Received: from [2001:8b0:10b:1::425] (helo=i7.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xI3TE-0000000CVDd-0dV3;
	Sat, 17 Oct 2026 12:25:04 +0000
Received: from dwoodhou by i7.infradead.org with local (Exim 4.99.5 #2 (Red Hat Linux))
	id 1xI3TD-00000002Ynq-3zCj;
	Sat, 17 Oct 2026 13:25:03 +0100
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
Subject: [RFC PATCH 44/55] KVM: selftests: Test hugepage sizing over mixed protection attributes
Date: Sat, 17 Oct 2026 13:24:50 +0100
Message-ID: <20261017122501.610248-45-dwmw2@infradead.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017122501.610248-1-dwmw2@infradead.org>
References: <20261017122501.610248-1-dwmw2@infradead.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: David Woodhouse <dwmw2@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html

From: Mushahid Hussain <hmushi@amazon.co.uk>

Back a 2 MiB-aligned region with a transparent hugepage and give it
alternating NX and NW protection attributes on its 4 KiB pages.  The
guest reads an NX page, which maps the region, then writes the NW page
next to it: the write must exit with KVM_EXIT_MEMORY_FAULT and leave
the page unchanged, instead of going through a 2 MiB leaf that
inherited the NX page's permissions.  Clearing the attribute lets the
write through.

This pins the hugepage side of the VSM memory protection boundary: a
single 4 KiB protection set by a higher VTL must not be widened away
by a neighbouring gfn's fault installing a hugepage whose access was
computed from the neighbour alone.  The host refuses that hugepage via
the KVM_LPAGE_MIXED_FLAG tracking which
kvm_arch_post_set_memory_attributes() maintains over the whole
attribute word, NR/NW/NX included.

[dwmw2: re-done by hand from Mushahid's original, adapted from the
 KVM_SET_PLANE_MEMORY_ATTRIBUTES uAPI to the per-plane memory
 attributes design: plane 0 attributes are set through
 KVM_SET_MEMORY_ATTRIBUTES with the NR/NW/NX protection bits, no
 plane runtime is needed, and the fault exit carries no plane field]

Assisted-by: LLM
Signed-off-by: Mushahid Hussain <hmushi@amazon.co.uk>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
---
 tools/testing/selftests/kvm/Makefile.kvm      |   1 +
 .../selftests/kvm/x86/memattr_hugepage_test.c | 132 ++++++++++++++++++
 2 files changed, 133 insertions(+)
 create mode 100644 tools/testing/selftests/kvm/x86/memattr_hugepage_test.c

diff --git a/tools/testing/selftests/kvm/Makefile.kvm b/tools/testing/selftests/kvm/Makefile.kvm
index 14e385750ed1..66b16987d6e2 100644
--- a/tools/testing/selftests/kvm/Makefile.kvm
+++ b/tools/testing/selftests/kvm/Makefile.kvm
@@ -92,6 +92,7 @@ TEST_GEN_PROGS_x86 += x86/hyperv_tlb_flush
 TEST_GEN_PROGS_x86 += x86/kvm_clock_test
 TEST_GEN_PROGS_x86 += x86/kvm_pv_test
 TEST_GEN_PROGS_x86 += x86/kvm_buslock_test
+TEST_GEN_PROGS_x86 += x86/memattr_hugepage_test
 TEST_GEN_PROGS_x86 += x86/monitor_mwait_test
 TEST_GEN_PROGS_x86 += x86/msrs_test
 TEST_GEN_PROGS_x86 += x86/nested_close_kvm_test
diff --git a/tools/testing/selftests/kvm/x86/memattr_hugepage_test.c b/tools/testing/selftests/kvm/x86/memattr_hugepage_test.c
new file mode 100644
index 000000000000..156036eda5db
--- /dev/null
+++ b/tools/testing/selftests/kvm/x86/memattr_hugepage_test.c
@@ -0,0 +1,132 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test hugepage sizing over mixed memory protection attributes on x86.
+ *
+ * Back a 2 MiB-aligned region with a transparent hugepage and give it
+ * alternating KVM_MEMORY_ATTRIBUTE_NX and _NW on its 4 KiB pages.  The
+ * guest reads an NX page, which maps the region, then writes the NW page
+ * next to it: the write must exit with KVM_EXIT_MEMORY_FAULT and leave
+ * the page unchanged, instead of going through a 2 MiB leaf that
+ * inherited the NX page's permissions.  Clearing the attribute lets the
+ * write through.
+ *
+ * This pins the VSM memory protection boundary: a VTL1 guest protecting
+ * one 4 KiB page of VTL0 memory must not have the protection widened
+ * away by a neighbouring fault's hugepage.
+ */
+#include "kvm_util.h"
+#include "processor.h"
+#include "test_util.h"
+#include "ucall_common.h"
+
+#define MIXED_GPA	0x40000000ul
+#define MIXED_SLOT	10
+#define MIXED_PAGES	1024	/* 4 MiB: a whole 2 MiB hugepage inside */
+
+/*
+ * MADV_HUGEPAGE is advisory and thp_configured() only checks that THP
+ * exists in the host kernel: if no 2 MiB THP actually backs the region
+ * (runtime policy "never", fragmentation), KVM maps 4 KiB leaves and
+ * the test "passes" without covering the hugepage path it exists for.
+ * Read the smaps entry covering @hva and report whether at least one
+ * anonymous hugepage backs it.
+ */
+static bool anon_hugepage_backed(void *hva)
+{
+	unsigned long start, end, kb, addr = (unsigned long)hva;
+	bool in_vma = false;
+	char line[256];
+	FILE *f;
+
+	f = fopen("/proc/self/smaps", "r");
+	TEST_ASSERT(f, "Failed to open /proc/self/smaps");
+
+	while (fgets(line, sizeof(line), f)) {
+		if (sscanf(line, "%lx-%lx ", &start, &end) == 2) {
+			in_vma = addr >= start && addr < end;
+			continue;
+		}
+		if (in_vma && sscanf(line, "AnonHugePages: %lu kB", &kb) == 1) {
+			fclose(f);
+			return kb >= 2048;
+		}
+	}
+
+	fclose(f);
+	TEST_FAIL("No smaps entry covers %p", hva);
+	return false;
+}
+
+static void guest_mixed_attrs(void)
+{
+	u64 *nx_page = (u64 *)MIXED_GPA;
+	u64 *nw_page = (u64 *)(MIXED_GPA + PAGE_SIZE);
+
+	/* The first touch maps the region: a read of a no-exec page. */
+	GUEST_SYNC(READ_ONCE(*nx_page));
+	/* A write to the no-write page next to it must be denied. */
+	WRITE_ONCE(*nw_page, 0xbad);
+	GUEST_SYNC(READ_ONCE(*nw_page));
+	GUEST_DONE();
+}
+
+int main(int argc, char *argv[])
+{
+	struct kvm_vcpu *vcpu;
+	struct kvm_run *run;
+	struct kvm_vm *vm;
+	struct ucall uc;
+	u64 *host;
+	int i, r;
+
+	TEST_REQUIRE(kvm_check_cap(KVM_CAP_MEMORY_ATTRIBUTES) &
+		     KVM_MEMORY_ATTRIBUTE_NW);
+	TEST_REQUIRE(thp_configured());
+
+	vm = vm_create_with_one_vcpu(&vcpu, guest_mixed_attrs);
+	run = vcpu->run;
+
+	vm_userspace_mem_region_add(vm, VM_MEM_SRC_ANONYMOUS_THP, MIXED_GPA,
+				    MIXED_SLOT, MIXED_PAGES, 0);
+	virt_map(vm, MIXED_GPA, MIXED_GPA, MIXED_PAGES);
+	host = addr_gpa2hva(vm, MIXED_GPA);
+	memset(host, 0, MIXED_PAGES * getpagesize());
+	host[0] = 0x11;
+	host[PAGE_SIZE / sizeof(u64)] = 0x22;
+
+	/* The memset faulted the region in; a THP must have materialised. */
+	TEST_REQUIRE(anon_hugepage_backed(host));
+
+	/* As VTL1 would: alternate NX and NW over the hugepage's 4 KiB pages. */
+	for (i = 0; i < 512; i++)
+		vm_set_memory_attributes(vm, MIXED_GPA + i * PAGE_SIZE,
+					 PAGE_SIZE,
+					 (i & 1) ? KVM_MEMORY_ATTRIBUTE_NW :
+						   KVM_MEMORY_ATTRIBUTE_NX);
+
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], 0x11);
+
+	r = _vcpu_run(vcpu);
+	TEST_ASSERT(r == -1 && errno == EFAULT,
+		    "write to the NW page: ret %d errno %d, exit %u",
+		    r, errno, run->exit_reason);
+	TEST_ASSERT_KVM_EXIT_REASON(vcpu, KVM_EXIT_MEMORY_FAULT);
+	TEST_ASSERT_EQ(run->memory_fault.gpa, MIXED_GPA + PAGE_SIZE);
+	TEST_ASSERT(run->memory_fault.flags & KVM_MEMORY_EXIT_FLAG_WRITE,
+		    "expected a write fault, flags 0x%llx",
+		    run->memory_fault.flags);
+	TEST_ASSERT_EQ(host[PAGE_SIZE / sizeof(u64)], 0x22);
+
+	/* Lift the protection: the write goes through at the right level. */
+	vm_set_memory_attributes(vm, MIXED_GPA + PAGE_SIZE, PAGE_SIZE, 0);
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_SYNC);
+	TEST_ASSERT_EQ(uc.args[1], 0xbad);
+	vcpu_run(vcpu);
+	TEST_ASSERT_EQ(get_ucall(vcpu, &uc), UCALL_DONE);
+
+	kvm_vm_free(vm);
+	return 0;
+}
-- 
2.50.1

