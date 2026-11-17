Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906944;
	b=joqTvGykb01wDowr5GiwvSQXol/wYvF2LGFNb//RPdbV2QIxmtJBpgF7k8/O/QcJw5W7
	 uvPL7Gn3b6q4ej8fyktKNhV8Q3PFJTMVjgTgImxrpvUvsn3POyifSRuFS08GOhvqIDXrd
	 pcJmqyXUyuCLG2iDDBOTCzlz1kS40hzUWR/l5GbWKPR8s5lTIZknwTRwzQiyAoiiepO9n
	 wJrRrqmRLrrAv24/f/6tvHrLHy9P6/WwjCRsClXfYznX2Y/v5yObiWaJ68G2qxI536iQv
	 k4goZE0PwnJMxh3OZ2pFyoWE3lnZeTeiwYK0WeaFSPBT8TVgR4yGRSKPxX18XUYsAjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906944;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=Lo8L12hZuWZeYqLF8fJQgjn+CP/n0abVvWh4m3hMZ1w=;
	b=k3apsX8cJG6fSiCDe2GWCK2hOJbsVzMBQLXrGscL3gcy1ynZrP9wVbE4b4wWfcX9S26t
	 GHp3XckAGsjJ4nEGzvhJ0uTmlP5XE+ZegFwcND7KDaW1xgOd2r3FkPJ8uR29nRMgZ1pSK
	 6g+Ym0XvMWcdwfVugx4B5mpKykEnUhtizEZ2AB0UY7XssASCHVLwoZYZul+13CP+di8+i
	 8JA42MHPTcbb3On0H++1SuwyO1zLsxGaIw68/DBi09YGzbCQnh4FDyLlWsGEkDfrrSaeV
	 IF4xsThVcA7a437HznACLW1APbjVx+DdKmcN7v6TZ7mOKbUdo190R0B6/h70q7hpadQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cOWU0AL5;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EFA606A31C;
	Tue, 17 Nov 2026 09:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 79EFA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=cOWU0AL5
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0FF0B20B7169;
	Tue, 17 Nov 2026 01:15:37 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0FF0B20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794906943;
	bh=Lo8L12hZuWZeYqLF8fJQgjn+CP/n0abVvWh4m3hMZ1w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOWU0AL503TFVw3wIfg/gDfjkP0LH/u/AmfcFI5OxJIzHdDJZ45a6yzqVsHXVa1Wy
	 01m4lMUYjyZWvN7xQyXUB3W426q29RCQ8c5+ZK0m5tNhpo/tOX2Abc7Avzmm3s3ayT
	 i33/sOATdXGVdCWjwm6Kx4Ztnb3SHLj/5gPx2uPs=
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
	bigeasy@linutronix.de,
	zhouchuyi@bytedance.com,
	houwenlong.hwl@antgroup.com,
	qq570070308@gmail.com,
	bastien.curutchet@bootlin.com,
	namjain@linux.microsoft.com,
	dianders@chromium.org,
	jgross@suse.com,
	hawk@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] x86/hyperv: Filter TLB targets before building hypercalls
Date: Tue, 17 Nov 2026 09:15:06 +0000
Message-ID: <20261117091507.2088642-5-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261117091507.2088642-1-namjain@linux.microsoft.com>
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
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

SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs regressed
between Linux 6.8 and 7.0. Recreating DataLoader workers each epoch caused
host-to-GPU copy stalls and timeouts. The reported bisection identified
commit 209954cbc7d0 ("x86/mm/tlb: Update mm_cpumask lazily").

That change leaves a CPU's bit set after it switches to another mm.
Native flush callbacks remove these stale bits, but successful Hyper-V
hypercalls do not run those callbacks. A CPU actively running another
mm need not be in lazy TLB mode, so the existing lazy-TLB check does not
exclude it. If the mask includes all present CPUs, the backend selects
the all-processors shortcut before checking individual CPUs.

Use the native predicate to build a per-CPU target mask before selecting
the all-processors shortcut or either hypercall format. Keep the full
candidate mask when freeing page tables. Retain the empty basic-mask
check because filtering can leave no targets.

This patch does not change when trimming is requested.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/hyperv/mmu.c | 40 ++++++++++++++++++++++++++--------------
 1 file changed, 26 insertions(+), 14 deletions(-)

diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
index 375f23b157ab3..833eaea1d3fa8 100644
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
 
@@ -51,19 +54,14 @@ static inline int fill_gva_list(u64 gva_list[], int offset,
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
 
@@ -87,6 +85,23 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 		goto do_native;
 	}
 
+	flush_cpus = this_cpu_ptr(&hyperv_tlb_flush_mask);
+	/*
+	 * mm_cpumask() may retain CPUs that have switched to another mm.
+	 * Use the native predicate for its context-switch ordering and lazy
+	 * TLB exclusion. Page-table freeing must include lazy CPUs, so keep
+	 * the full candidate mask in that case.
+	 */
+	if (info->freed_tables) {
+		cpumask_copy(flush_cpus, cpus);
+	} else {
+		cpumask_clear(flush_cpus);
+		for_each_cpu(cpu, cpus) {
+			if (should_flush_tlb(cpu, info))
+				__cpumask_set_cpu(cpu, flush_cpus);
+		}
+	}
+
 	if (info->mm) {
 		/*
 		 * AddressSpace argument must match the CR3 with PCID bits
@@ -101,7 +116,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	}
 
 	flush->processor_mask = 0;
-	if (cpumask_equal(cpus, cpu_present_mask)) {
+	if (cpumask_equal(flush_cpus, cpu_present_mask)) {
 		flush->flags |= HV_FLUSH_ALL_PROCESSORS;
 	} else {
 		/*
@@ -115,14 +130,12 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
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
@@ -166,7 +179,7 @@ static void hyperv_flush_tlb_multi(const struct cpumask *cpus,
 	goto check_status;
 
 do_ex_hypercall:
-	status = hyperv_flush_tlb_others_ex(cpus, info);
+	status = hyperv_flush_tlb_others_ex(flush_cpus, info);
 
 check_status:
 	local_irq_restore(flags);
@@ -205,8 +218,7 @@ static u64 hyperv_flush_tlb_others_ex(const struct cpumask *cpus,
 	flush->hv_vp_set.valid_bank_mask = 0;
 
 	flush->hv_vp_set.format = HV_GENERIC_SET_SPARSE_4K;
-	nr_bank = cpumask_to_vpset_skip(&flush->hv_vp_set, cpus,
-			info->freed_tables ? NULL : cpu_is_lazy);
+	nr_bank = cpumask_to_vpset(&flush->hv_vp_set, cpus);
 	if (nr_bank <= 0)
 		return HV_STATUS_INVALID_PARAMETER;
 
-- 
2.43.0

