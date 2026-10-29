Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793256163;
	b=OGTAIi5FTqmb8CrQI/5crZ/J5aK+qm83H7VirpgqH023k7zvrwskUCcef1+TnwrNSfTM
	 mcTRL+PA1lu8Src8uQFwN5h0UAHzcDImmY7N7ArYQZ6GCp3T9eBu5eqEWGQTu/AuClTdV
	 g7DAw0A1YJomX6+KofLQH4/e8qm2+ngWT2RTjiPcsR6YJz1JshVH/vmrHzh/imeB+tCPR
	 K4A+tKspyYnN688TVFzklEIqLrwnbMqugVEZons4Xa4JesC5P1u7dxgZQuraMace1RJ7L
	 WXoGS3ym8w4POLt5i608SHrqtbO+tloBUNetT/M11QcdxKyxWfQ1+6jGTpIOZkj9QMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793256163;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=TwPeZ3+dVYa0x/Onb18lEJ0bQ1+V91oucPH+79L0Cjs=;
	b=250uyr/6WyAbCaSqtoJJLRlZcNLkT1dPZarpo//PFybSOSYNTwOMWhuGcw4JFNsMTQV2
	 lWqJ2JsO02oFP1QT+9Ubzh6LKHsr5jw6nlb7m25TEHeZDJSX2nILt/HkMmYCXlf8fn1Xo
	 x+aSpHbFbU7IaTNQXBuJF3wQJu76NyRhlWhYE9rtXCS3k2M/iBFLbBMTQU3aZNqDK64o5
	 r8Pu+4tj2tea1aCNDqQSBYlZ8roqPlusEklWBTdRXkOiEOGSQXGp2tG7PU+aPwyClS1v1
	 I6eDWvTNJoFNRdUqQd27+F2wu5wa9FELGZubdtL8yN+xIAe8wZ8Y8j6zClKObQBys/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="o/nxMkJd";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493FC606A31D;
	Thu, 29 Oct 2026 06:42:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 493FC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=o/nxMkJd
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id 104C720B7167;
	Wed, 28 Oct 2026 23:42:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 104C720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793256150;
	bh=TwPeZ3+dVYa0x/Onb18lEJ0bQ1+V91oucPH+79L0Cjs=;
	h=From:To:Cc:Subject:Date:From;
	b=o/nxMkJdZ4WGFtpXcylsak83ZpeAYJPHPaEghJJnNB48zOld4dstbLI/nGvoX+7jE
	 EvOfMuExGoDnA2diNcvL8vZuzTXuWTlpbCyplt9F/IJ8SH3/jr0ak3R2oLvr6Vwmcd
	 7SrNhc+Yh56Mj9IoySRuq60fGZJ/8tMtdKQA9T8A=
From: Naman Jain <namjain@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org
Cc: hpa@zytor.com,
	riel@surriel.com,
	mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/hyperv: Account for lazy mm_cpumask maintenance
Date: Thu, 29 Oct 2026 06:42:33 +0000
Message-ID: <20261029064234.362385-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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

CPUs no longer running an mm may remain in mm_cpumask(). Hyper-V treats
these CPUs as flush targets and bypasses the native callbacks that trim
the mask. A single-threaded process can therefore keep issuing
all-processor flushes after visiting all CPUs and returning to one CPU.

Share the native target predicate and filter the mask before building
either hypercall format or selecting HV_FLUSH_ALL_PROCESSORS. Preserve
lazy-TLB exclusion and unfiltered page-table-freeing flushes, and use
native callbacks for periodic trimming and ASID transitions.

When no remote targets remain, request immediate trimming through native
callbacks so stale memberships do not unnecessarily prevent later
invalidations from using the local fast path. Leave lazy CPU-mask
maintenance during context switches unchanged.

Fixes: 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily")
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
On a 32-vCPU Hyper-V guest, after a single-threaded process visited all
CPUs and returned to one CPU, the reproducer's median time per iteration
(two mprotect() calls and a write) dropped from 17.235 us to 1.622 us,
a 90.6% reduction. This could be more on higher vCPU VMs.

 arch/x86/hyperv/mmu.c           | 62 +++++++++++++++++++++------------
 arch/x86/include/asm/tlbflush.h |  6 ++++
 arch/x86/mm/tlb.c               |  8 +++--
 3 files changed, 52 insertions(+), 24 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index cfcb60468b01c..128ad3ce8c24c 100644
--- a/arch/x86/hyperv/mmu.c
+++ b/arch/x86/hyperv/mmu.c
@@ -1,6 +1,7 @@
 #define pr_fmt(fmt)  "Hyper-V: " fmt
 
 #include <linux/log2.h>
+#include <linux/percpu.h>
 #include <linux/slab.h>
 #include <linux/types.h>
 
@@ -16,6 +17,8 @@
 /* Each gva in gva_list encodes up to 4096 pages to flush */
 #define HV_TLB_FLUSH_UNIT (4096 * PAGE_SIZE)
 
+static DEFINE_PER_CPU(struct cpumask, hyperv_tlb_flush_mask);
+
 static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 				      const struct flush_tlb_info *info);
 
@@ -51,23 +54,23 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
 	return gva_n - offset;
 }
 
-static bool cpu_is_lazy(int cpu)
-{
-	return per_cpu(cpu_tlbstate_shared.is_lazy, cpu);
-}
-
 static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 				   const struct flush_tlb_info *info)
 {
 	int cpu, vcpu, gva_n, max_gvas;
 	struct hv_tlb_flush *flush;
+	struct cpumask *flush_cpus;
 	u64 status;
 	unsigned long flags;
-	bool do_lazy = !info->freed_tables;
 
 	trace_hyperv_mmu_flush_tlb_multi(cpus, info);
 
-	if (!hv_hypercall_pg)
+	/*
+	 * Hypercalls bypass the callbacks that trim mm_cpumask() and complete
+	 * ASID transitions.
+	 */
+	if (!hv_hypercall_pg || info->trim_cpumask ||
+	    mm_in_asid_transition(info->mm))
 		goto do_native;
 
 	local_irq_save(flags);
@@ -79,6 +82,30 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 		goto do_native;
 	}
 
+	flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
+	if (info->freed_tables) {
+		cpumask_copy(flush_cpus, cpus);
+	} else {
+		cpumask_clear(flush_cpus);
+		for_each_cpu(cpu, cpus) {
+			if (cpu_needs_tlb_flush(cpu, info))
+				__cpumask_set_cpu(cpu, flush_cpus);
+		}
+	}
+
+	/*
+	 * An effectively local mm should not keep taking the remote path until
+	 * the next periodic trim. Let the native callbacks prune stale bits.
+	 */
+	if (cpumask_any_but(flush_cpus, smp_processor_id()) >= nr_cpu_ids) {
+		struct flush_tlb_info local_info = *info;
+
+		local_info.trim_cpumask = 1;
+		local_irq_restore(flags);
+		native_flush_tlb_multi(cpus, &local_info);
+		return;
+	}
+
 	if (info->mm) {
 		/*
 		 * AddressSpace argument must match the CR3 with PCID bits
@@ -93,7 +120,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	}
 
 	flush->processor_mask = 0;
-	if (cpumask_equal(cpus, cpu_present_mask)) {
+	if (cpumask_equal(flush_cpus, cpu_present_mask)) {
 		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
 	} else {
 		/*
@@ -107,14 +134,12 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 		 * must. We will also check all VP numbers when walking the
 		 * supplied CPU set to remain correct in all cases.
 		 */
-		cpu = cpumask_last(cpus);
+		cpu = cpumask_last(flush_cpus);
 
 		if (cpu < nr_cpumask_bits && hv_cpu_number_to_vp_number(cpu) >= 64)
 			goto do_ex_hypercall;
 
-		for_each_cpu(cpu, cpus) {
-			if (do_lazy && cpu_is_lazy(cpu))
-				continue;
+		for_each_cpu(cpu, flush_cpus) {
 			vcpu = hv_cpu_number_to_vp_number(cpu);
 			if (vcpu == VP_INVAL) {
 				local_irq_restore(flags);
@@ -127,12 +152,6 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 			__set_bit(vcpu, (unsigned long *)
 				  &flush->processor_mask);
 		}
-
-		/* nothing to flush if 'processor_mask' ends up being empty */
-		if (!flush->processor_mask) {
-			local_irq_restore(flags);
-			return;
-		}
 	}
 
 	/*
@@ -158,7 +177,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	goto check_status;
 
 do_ex_hypercall:
-	status = hyperv_flush_tlb_others_ex(cpus, info);
+	status = hyperv_flush_tlb_others_ex(flush_cpus, info);
 
 check_status:
 	local_irq_restore(flags);
@@ -197,9 +216,8 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
-			info->freed_tables ? NULL : cpu_is_lazy);
-	if (nr_bank < 0)
+	nr_bank = cpumask_to_vpset(&flush->hv_vp_set, cpus);
+	if (nr_bank <= 0)
 		return HV_STATUS_INVALID_PARAMETER;
 
 	/*
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 70098d448e999..e1e05cc867d5a 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -264,6 +264,12 @@ void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
 
+/*
+ * Do not use for filtering when freeing page tables or during global ASID
+ * transitions.
+ */
+bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info);
+
 static inline bool is_dyn_asid(u16 asid)
 {
 	return asid < TLB_NR_DYN_ASIDS;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 0c4da320831cb..f2f40928d56a4 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1273,10 +1273,9 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
 
-static bool should_flush_tlb(int cpu, void *data)
+bool cpu_needs_tlb_flush(int cpu, const struct flush_tlb_info *info)
 {
 	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
-	struct flush_tlb_info *info = data;
 
 	/*
 	 * Order the 'loaded_mm' and 'is_lazy' against their
@@ -1311,6 +1310,11 @@ static bool should_flush_tlb(int cpu, void *data)
 	return false;
 }
 
+static bool should_flush_tlb(int cpu, void *data)
+{
+	return cpu_needs_tlb_flush(cpu, data);
+}
+
 static bool should_trim_cpumask(struct mm_struct *mm)
 {
 	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
-- 
2.43.0
