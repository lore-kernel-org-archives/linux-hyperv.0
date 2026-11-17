Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906931;
	b=v/mSqtpYT3rSsCV2i3yC9/BLApQfsDZUcuFFKijtjX7EXagcd/th2kOnTQLaoS4QK2KJ
	 KQqDMxbYtK7W8pDh49O0wD+n1HjrN9ysicTKG1MaYoF0vskvo+HP1I5tgpGx7DaeN4HtS
	 rCvjM/mBXClqR0/QEEQ3Vf9kiSojVPeX4qXE8bm/QVp/MkU95zvY8wVeOUWRACB6ZTsS9
	 jHpizKKlncFYSpEDre31udOY2QhR19P1ATu+jSt/T+ZNCr/MqKY01eXHZwlFXYteaf0NC
	 XFl2OujJKHwIgsp01vX0O5jP7k70tc6LDOE/WPhsm41xDSrSuNEdBCZUi2T/i5hlqTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906931;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=hndtqpjgUXjh43NxDS+qO5pFgoW3H3rBsOwawt70AGI=;
	b=LgZiuVKGNuKiGIIRtcOWA5oaSx/L9K3PVJex95Xe5w0Y+GyLpIz4OVFk4UAuyDiQomOb
	 Z4HveIdu47JSkp9bc8xw4Xwa/B3qAMiajBrGlEFGH7qiilF729PxokIk7PIPglOF4B2xn
	 SKV149A0+N5ZR/h98DzpipJbt9xt839GAVeNsPYHqWrCIL6BAIK4X6NrbguMWG7hXQF1M
	 w0K4oX+X1J3AZPqlcKr20f6t/svGTgeNoxBmcbVGlQH69u6kXscD19m1vBWu5E0mH1+qw
	 sfKX8IHE47oCMssEfmDJqtchAS/4hYV/cu4GNFsKQZYNfYo3rzLFu+PSbuQ2g06hh9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=tGJLLyH2;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97180606A334;
	Tue, 17 Nov 2026 09:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97180606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=tGJLLyH2
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 407E520B716E;
	Tue, 17 Nov 2026 01:15:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 407E520B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794906930;
	bh=hndtqpjgUXjh43NxDS+qO5pFgoW3H3rBsOwawt70AGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tGJLLyH2/m8Rth9q97vW00PuLyhbCjrg/xHTGYDjUmd00RdcgobWyZzcfv8m20wRF
	 U3dN73RKN7ZYmXTiMO9IgEb/++1U4Ny5Y0FPSK5iDYPElar/81+rJLM8nzFqAR7WqV
	 sMUMGw3RzJ3GrlW7pS3PBbpgW84pUAOk5K5M0fCI=
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
Subject: [PATCH v2 2/5] x86/tlb: Make the conditional flush predicate reusable
Date: Tue, 17 Nov 2026 09:15:04 +0000
Message-ID: <20261117091507.2088642-3-namjain@linux.microsoft.com>
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

Make should_flush_tlb() available to the Hyper-V backend and give it a
const struct flush_tlb_info pointer instead of void *. Keep a
should_flush_tlb_wrapper() adapter for the SMP callback interface.

No functional changes.

Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 18 ++++++++++++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 70098d448e999..1d1852ecaf084 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -263,6 +263,7 @@ void flush_tlb_one_user(unsigned long addr);
 void flush_tlb_one_kernel(unsigned long addr);
 void flush_tlb_multi(const struct cpumask *cpumask,
 		      const struct flush_tlb_info *info);
+bool should_flush_tlb(int cpu, const struct flush_tlb_info *info);
 
 static inline bool is_dyn_asid(u16 asid)
 {
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 53dcab39566f2..9b1aea2b3a1d5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1279,10 +1279,14 @@ static void flush_tlb_func(void *info)
 			nr_invalidate);
 }
 
-static bool should_flush_tlb(int cpu, void *data)
+/*
+ * Select ordinary flush targets using state ordered against context switches.
+ * Callers must bypass this filtering for page-table freeing and global ASID
+ * transitions, as native_flush_tlb_multi() does.
+ */
+bool should_flush_tlb(int cpu, const struct flush_tlb_info *info)
 {
 	struct mm_struct *loaded_mm = per_cpu(cpu_tlbstate.loaded_mm, cpu);
-	struct flush_tlb_info *info = data;
 
 	/*
 	 * Order the 'loaded_mm' and 'is_lazy' against their
@@ -1317,6 +1321,12 @@ static bool should_flush_tlb(int cpu, void *data)
 	return false;
 }
 
+/* Adapt the typed predicate to the SMP conditional-call interface. */
+static bool should_flush_tlb_wrapper(int cpu, void *data)
+{
+	return should_flush_tlb(cpu, data);
+}
+
 static bool should_trim_cpumask(struct mm_struct *mm)
 {
 	if (time_after(jiffies, READ_ONCE(mm->context.next_trim_cpumask))) {
@@ -1357,8 +1367,8 @@ STATIC_NOPV void native_flush_tlb_multi(const struct cpumask *cpumask,
 	if (info->freed_tables || mm_in_asid_transition(info->mm))
 		on_each_cpu_mask(cpumask, flush_tlb_func, (void *)info, true);
 	else
-		on_each_cpu_cond_mask(should_flush_tlb, flush_tlb_func,
-				(void *)info, 1, cpumask);
+		on_each_cpu_cond_mask(should_flush_tlb_wrapper, flush_tlb_func,
+				      (void *)info, 1, cpumask);
 }
 
 void flush_tlb_multi(const struct cpumask *cpumask,
-- 
2.43.0

