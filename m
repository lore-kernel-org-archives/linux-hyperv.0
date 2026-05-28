Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59990197A7D;
	Thu, 28 May 2026 00:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928957; cv=none; b=Jqc4SUSmgIkGQdYLa7yV1sYby3tFKdK6HDwVHRjwsioMMdPcKc/BkoDtVebaKPOwkayCve79Fn+sSrY1FMoGdVNsDvLpfGM5oU8Y/IVRH07MoxsZq0OZeg+g3MzMlIOrS4yAnUnmZog9Sn2fyTL2d/qPKtZrW0frBSFrlIzVQp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928957; c=relaxed/simple;
	bh=+pQS3rXVX+zJu7Hr2ptnvRm0Jx8L6WPar9VNsKT+l08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDmIx/l9pynZe7BIvspljPyNEeagLFPbk9ztAfzl+/xcfEyg1tyPpDPTyGGab0HdrgIuRhiqyxaO6O9/NzFgtDaf42q4JRILvGr++hqIwkuYnWLtJCiEOzBxvFDxSl6U9p1hgxxDhZptIaSSTR6nyVtfYpOjuFKGfB9aDFvuzh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aVvvYYwH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aVvvYYwH"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id BFE2E20B7178; Wed, 27 May 2026 17:42:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BFE2E20B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928937;
	bh=NBsrZvFZCaB+Y/+qvoDfxB0s8ldAO6L08kiidL6oEeI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aVvvYYwHjeNot3eIR3oUp6o7Upqmt3WV5LdKAduXaKrJZexICOXvtNvgktsWgX+ZJ
	 utUu36E7dKfzILCi+VELYR8r9Y7mkHMJnwV6BpykT51jf7MOoVXaWiKQy5lyD6ieUx
	 VPZSQEMPfAb90pLP1EyYWFvDqYR2cqaK/TPWiS+I=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 09/20] memblock: introduce MEMBLOCK_KHO_SCRATCH_EXT
Date: Wed, 27 May 2026 17:41:51 -0700
Message-ID: <20260528004204.1484584-10-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

In the upcoming commits, the KHO will learn how to discover free blocks
of memory by walking the KHO radix tree. It will then mark those regions
as scratch to allow memory allocation in case scratch runs low.

To differentiate the extended scratch areas from the main scratch areas,
introduce MEMBLOCK_KHO_SCRATCH_EXT. Use it when choosing memblock flags
for allocations during scratch-only. Teach should_skip_region() to check
for both flags before deciding if the region should be skipped.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/memblock.h | 10 ++++++++++
 mm/memblock.c            | 41 ++++++++++++++++++++++++++++++++++------
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 5afcd99aa8c1..4f535ca4947a 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -51,6 +51,9 @@ extern unsigned long long max_possible_pfn;
  * memory reservations yet, so we get scratch memory from the previous
  * kernel that we know is good to use. It is the only memory that
  * allocations may happen from in this phase.
+ * @MEMBLOCK_KHO_SCRATCH_EXT: same as MEMBLOCK_KHO_SCRATCH but was discovered at
+ * boot time by finding gaps in preserved memory instead of being passed from
+ * previous kernel. Does not get passed to the next kernel.
  */
 enum memblock_flags {
 	MEMBLOCK_NONE		= 0x0,	/* No special request */
@@ -61,6 +64,7 @@ enum memblock_flags {
 	MEMBLOCK_RSRV_NOINIT	= 0x10,	/* don't initialize struct pages */
 	MEMBLOCK_RSRV_KERN	= 0x20,	/* memory reserved for kernel use */
 	MEMBLOCK_KHO_SCRATCH	= 0x40,	/* scratch memory for kexec handover */
+	MEMBLOCK_KHO_SCRATCH_EXT= 0x80, /* extended scratch memory for KHO */
 };
 
 /**
@@ -157,6 +161,7 @@ int memblock_clear_nomap(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_noinit(phys_addr_t base, phys_addr_t size);
 int memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t size);
 int memblock_mark_kho_scratch(phys_addr_t base, phys_addr_t size);
+int memblock_mark_kho_scratch_ext(phys_addr_t base, phys_addr_t size);
 int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size);
 
 void memblock_free(void *ptr, size_t size);
@@ -304,6 +309,11 @@ static inline bool memblock_is_kho_scratch(struct memblock_region *m)
 	return m->flags & MEMBLOCK_KHO_SCRATCH;
 }
 
+static inline bool memblock_is_kho_scratch_ext(struct memblock_region *m)
+{
+	return m->flags & MEMBLOCK_KHO_SCRATCH_EXT;
+}
+
 int memblock_search_pfn_nid(unsigned long pfn, unsigned long *start_pfn,
 			    unsigned long  *end_pfn);
 void __next_mem_pfn_range(int *idx, int nid, unsigned long *out_start_pfn,
diff --git a/mm/memblock.c b/mm/memblock.c
index 6349c48154f4..6f76a6bb96d6 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -182,7 +182,7 @@ static enum memblock_flags __init_memblock choose_memblock_flags(void)
 {
 	/* skip non-scratch memory for kho early boot allocations */
 	if (kho_scratch_only)
-		return MEMBLOCK_KHO_SCRATCH;
+		return MEMBLOCK_KHO_SCRATCH | MEMBLOCK_KHO_SCRATCH_EXT;
 
 	return system_has_some_mirror ? MEMBLOCK_MIRROR : MEMBLOCK_NONE;
 }
@@ -1180,8 +1180,9 @@ int __init_memblock memblock_reserved_mark_kern(phys_addr_t base, phys_addr_t si
  * @base: the base phys addr of the region
  * @size: the size of the region
  *
- * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH will be considered
- * for allocations during early boot with kexec handover.
+ * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH or
+ * %MEMBLOCK_KHO_SCRATCH_EXT will be considered for allocations during early
+ * boot with kexec handover.
  *
  * Return: 0 on success, -errno on failure.
  */
@@ -1205,6 +1206,23 @@ __init int memblock_clear_kho_scratch(phys_addr_t base, phys_addr_t size)
 				    MEMBLOCK_KHO_SCRATCH);
 }
 
+/**
+ * memblock_mark_kho_scratch_ext - Mark a memory region as MEMBLOCK_KHO_SCRATCH_EXT.
+ * @base: the base phys addr of the region
+ * @size: the size of the region
+ *
+ * Only memory regions marked with %MEMBLOCK_KHO_SCRATCH or
+ * %MEMBLOCK_KHO_SCRATCH_EXT will be considered for allocations during early
+ * boot with kexec handover.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+__init int memblock_mark_kho_scratch_ext(phys_addr_t base, phys_addr_t size)
+{
+	return memblock_setclr_flag(&memblock.memory, base, size, 1,
+				    MEMBLOCK_KHO_SCRATCH_EXT);
+}
+
 static bool should_skip_region(struct memblock_type *type,
 			       struct memblock_region *m,
 			       int nid, int flags)
@@ -1238,10 +1256,20 @@ static bool should_skip_region(struct memblock_type *type,
 
 	/*
 	 * In early alloc during kexec handover, we can only consider
-	 * MEMBLOCK_KHO_SCRATCH regions for the allocations
+	 * MEMBLOCK_KHO_SCRATCH or MEMBLOCK_KHO_SCRATCH_EXT regions for the
+	 * allocations.
 	 */
-	if ((flags & MEMBLOCK_KHO_SCRATCH) && !memblock_is_kho_scratch(m))
-		return true;
+	if (flags & (MEMBLOCK_KHO_SCRATCH | MEMBLOCK_KHO_SCRATCH_EXT)) {
+		bool skip = true;
+
+		if ((flags & MEMBLOCK_KHO_SCRATCH) && memblock_is_kho_scratch(m))
+			skip = false;
+
+		if ((flags & MEMBLOCK_KHO_SCRATCH_EXT) && memblock_is_kho_scratch_ext(m))
+			skip = false;
+
+		return skip;
+	}
 
 	return false;
 }
@@ -2801,6 +2829,7 @@ static const char * const flagname[] = {
 	[ilog2(MEMBLOCK_RSRV_NOINIT)] = "RSV_NIT",
 	[ilog2(MEMBLOCK_RSRV_KERN)] = "RSV_KERN",
 	[ilog2(MEMBLOCK_KHO_SCRATCH)] = "KHO_SCRATCH",
+	[ilog2(MEMBLOCK_KHO_SCRATCH_EXT)] = "KHO_SCRATCH_EXT",
 };
 
 static int memblock_debug_show(struct seq_file *m, void *private)
-- 
2.43.0

