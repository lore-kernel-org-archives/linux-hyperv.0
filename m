Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7EB35C682
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828216; cv=none; b=k0Nr2ayzf6uC29uVobtRgr9TV1PdqQrpSIUEbhDBoqbk9h/Ipe8KjNxbGY5kXgf3wplFIedJVVkm50jpeytzB205QmJx858KMGdzF8Z0HvP4D/1ZVt3Jum8b4LzXf1/SNK8uJ3atiVDInMrCZiYdU6a3bYtASyfLNldIL8rtros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828216; c=relaxed/simple;
	bh=e05SOoAaH6rdxtJDrz7A9LUM75TsCH+ORPFdPnvT+/o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UiUhV1L3ntE097wtrQkozrYtPiGQktmcxHAeTqd90aW6HVauhgQJyHxrGg/SHU9HC8pf0PKy5GrPAz0LDjNn4L7cAaE9zpWAK00V+MWIktaq4DkoW7hePaHb+BCC4r0djh3Xfr5uV9xKGLWQMUEET9sSzEj58SU7BSZ0sBMi62s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWCH55cr; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWCH55cr"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-84830c774a0so1178497b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 10:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828206; x=1785433006; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JmjPr4ajWT+pNjYdNv6NRB3T+nqQJNeM5CFnnbec2W4=;
        b=JWCH55crn8LHQSD8Tn4CAevzsLUpwWnSdnZeyG870/I9I5y9gva8B8QK3cPltZ9PbK
         V0gz1+md4VLJ397Byzz35/w0SIWrCGZp1Hyh8F9E2prAohCeBD1/LYBgRDgqIFAwmGIY
         uzdEw7egtqC3BkEJk1k0A/haWNBgtxeCleOVkZkFHqAM5xMlboL6f6jXr3mQuWO7oGB2
         3amYn7QUvpw8j8djFCksHHPvTI5INbW7UFY5aM+a0Yb304dAu6+svDVRJY7v8CDRt/E3
         z9VV3Tp0A6GV84NXNdJ3nkgK7G4d0MesKW/2my9wwjV4g2czqyk6vAIZp0NKUODh10MZ
         SEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828206; x=1785433006;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JmjPr4ajWT+pNjYdNv6NRB3T+nqQJNeM5CFnnbec2W4=;
        b=Bzo0SWeIXgCGx/O0lutpsVrgTS9HW1emiKQGnENW0DEZcp4Kt+s6pgopc3upvUIDYD
         U3T5CzqZ2RqWDOR4xkEJEaxJqxZV2FUTf6RBklpLrcWx8QnsQzcVotc0jivA2bZbAbrq
         bH33hWOI7NscODeoBCFay4sl+hPNgsQZ3bLAlMK4zkPd4GYUUC61lGbPCOwlqUM9M1ed
         gyO6UExTMrOUsqnnthlQ8DtgGvdtPundKElRkuaWEPhJ5KDHKxg+GLJ2zHiI8NAy1WxX
         tK/R15JvHMiIt+wgdeU+vEtVM+UATA0mfupEUpI9LzobkoeIDZ5wXcaQNYed55UfTUSX
         ezZA==
X-Forwarded-Encrypted: i=1; AHgh+RreaDmTM7Z3oXZvnFxLimyYtzqj5T9uqiGVMw+n/5movT4UgcSruCoLs3/tu2t0sY+DtRFKHrldaTHhKAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOSEw6RuEQ45fB+Nb0O16lrjpkPhxLXm234ydYemXDiY5qkaEh
	SHk32bGTqDa7oHnujEudc2Wcox1Dd0fbQTRWdCsqjpR+ldyWtXN9xGD1
X-Gm-Gg: AR+sD12cCtvzXsPpljQ8qemQJv4JX+a1nY+8StmLMKyR5U6FcFsS/UWuXgCKlGG61x6
	gGJsmja40wrFfm7DHFDbpYBMQzzlrDADfMzq2DFE0OrXa9wZKLBvqD4Bgy9ZZ7znP3dCFeGAaRR
	oD4sRI6E82KF5sdqxMdia0QlgoQQh5wMyV8kJFSZvdOICrGfvBz0Sm1cedUJZyHaJp5b3mq4zF4
	yLzYXnztjfQfJ4Oq90T4Mc0lDagEnK5smc/MsG7ocQRH4GP+DJDpkRnneBlYSEITDAZCc0vv2vH
	7lLsqxdwlIGlwBpnrgAaHm3SmZ3FCLHfpQgOuun2BVoGtB4cmy4xp/yXyqF1Ri19ZBptxixyU1W
	3xbtnJWPmGNemPKnB84oRb7VOPF0IKmXzuaOVbdCuKk1nKzF73TMZqSEu6JulV/KldGLlHKTy9q
	nYOtzZQ4gOMP8c/5d891Xdqq0BKm52/4GT/s5Tv1eP4Ey0fvsN
X-Received: by 2002:a05:6a00:3cc4:b0:845:e7ee:eae7 with SMTP id d2e1a72fcca58-84e2b7fc1f8mr4822860b3a.5.1784828206217;
        Thu, 23 Jul 2026 10:36:46 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:36:45 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:33 -0700
Subject: [PATCH v11 1/8] mm/hmm: move page fault handling out of walk
 callbacks
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-1-c55b003a4b61@gmail.com>
References: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
In-Reply-To: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Oded Gabbay <ogabbay@kernel.org>, skinsburskii@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=9376;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=e05SOoAaH6rdxtJDrz7A9LUM75TsCH+ORPFdPnvT+/o=;
 b=gwyU/77AJ6dKu0lZRnFlWCTHfMteTC7dUTtNdZcgpayFHK/4UuYZFQAVucZpomng7uyaHw8h7
 T8/k5JdDqvADw77M1tYI9WkF5Vk2uNwAOeuvh4Jkjbevj0cWSnQtBpg
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

hmm_range_fault() currently triggers page faults from inside the page-table
walk callbacks: hmm_vma_walk_pmd(), hmm_vma_walk_pud(),
hmm_vma_walk_hugetlb_entry() and the pte-level helper all call
hmm_vma_fault(), which in turn calls handle_mm_fault() while the walker
still holds nested locks.  The pte spinlock is dropped explicitly by each
caller, and the hugetlb path manually drops and retakes
hugetlb_vma_lock_read around the fault to dodge a deadlock against the walk
framework's unconditional unlock.

This layering does not extend cleanly to fault handlers that may release
mmap_lock (VM_FAULT_RETRY, VM_FAULT_COMPLETED). If the lock is dropped
while walk_page_range() is mid-traversal, the VMA can be freed before the
walk framework's matching hugetlb_vma_unlock_read(), turning that unlock
into a use-after-free.

Split the responsibilities the way get_user_pages() does. Walk callbacks
become inspect-only: when they detect a range that needs to be faulted in,
they record it in struct hmm_vma_walk and return a private sentinel
(HMM_FAULT_PENDING). The outer loop in hmm_range_fault() then drops out of
walk_page_range(), invokes a new helper hmm_do_fault() that calls
handle_mm_fault() with only mmap_lock held, and restarts the walk so the
now-present entries are collected into hmm_pfns.

No functional change for existing callers. As a side effect the hugetlb
callback no longer needs the hugetlb_vma_{un}lock_read dance, and every
fault-path exit from the callbacks now releases the pte spinlock on a
single, common path. This refactor is also a precursor for adding an
unlockable variant of hmm_range_fault() in a follow-up patch.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 mm/hmm.c | 118 ++++++++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 75 insertions(+), 43 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index e5c1f4deed24..bc9361a715fa 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -33,8 +33,17 @@
 struct hmm_vma_walk {
 	struct hmm_range	*range;
 	unsigned long		last;
+	unsigned long		end;
+	unsigned int		required_fault;
 };
 
+/*
+ * Internal sentinel returned by walk callbacks when they need a page fault.
+ * The callback stores end/required_fault in hmm_vma_walk; the outer loop
+ * consumes the sentinel and never propagates it to the caller.
+ */
+#define HMM_FAULT_PENDING	-EAGAIN
+
 enum {
 	HMM_NEED_FAULT = 1 << 0,
 	HMM_NEED_WRITE_FAULT = 1 << 1,
@@ -60,37 +69,25 @@ static int hmm_pfns_fill(unsigned long addr, unsigned long end,
 }
 
 /*
- * hmm_vma_fault() - fault in a range lacking valid pmd or pte(s)
- * @addr: range virtual start address (inclusive)
- * @end: range virtual end address (exclusive)
- * @required_fault: HMM_NEED_* flags
- * @walk: mm_walk structure
- * Return: -EBUSY after page fault, or page fault error
+ * hmm_record_fault() - record a range that needs to be faulted in
  *
- * This function will be called whenever pmd_none() or pte_none() returns true,
- * or whenever there is no page directory covering the virtual address range.
+ * Called by the walk callbacks when they discover that part of the range
+ * needs a page fault.  The callback records what to fault and returns
+ * HMM_FAULT_PENDING; the outer loop in hmm_range_fault() drops back out of
+ * walk_page_range() and invokes handle_mm_fault() from a context where no
+ * page-table or hugetlb_vma_lock is held.
  */
-static int hmm_vma_fault(unsigned long addr, unsigned long end,
-			 unsigned int required_fault, struct mm_walk *walk)
+static int hmm_record_fault(unsigned long addr, unsigned long end,
+			    unsigned int required_fault,
+			    struct mm_walk *walk)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
-	struct vm_area_struct *vma = walk->vma;
-	unsigned int fault_flags = FAULT_FLAG_REMOTE;
 
 	WARN_ON_ONCE(!required_fault);
 	hmm_vma_walk->last = addr;
-
-	if (required_fault & HMM_NEED_WRITE_FAULT) {
-		if (!(vma->vm_flags & VM_WRITE))
-			return -EPERM;
-		fault_flags |= FAULT_FLAG_WRITE;
-	}
-
-	for (; addr < end; addr += PAGE_SIZE)
-		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
-		    VM_FAULT_ERROR)
-			return -EFAULT;
-	return -EBUSY;
+	hmm_vma_walk->end = end;
+	hmm_vma_walk->required_fault = required_fault;
+	return HMM_FAULT_PENDING;
 }
 
 static unsigned int hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
@@ -174,7 +171,7 @@ static int hmm_vma_walk_hole(unsigned long addr, unsigned long end,
 		return hmm_pfns_fill(addr, end, range, HMM_PFN_ERROR);
 	}
 	if (required_fault)
-		return hmm_vma_fault(addr, end, required_fault, walk);
+		return hmm_record_fault(addr, end, required_fault, walk);
 	return hmm_pfns_fill(addr, end, range, 0);
 }
 
@@ -209,7 +206,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
 	required_fault =
 		hmm_range_need_fault(hmm_vma_walk, hmm_pfns, npages, cpu_flags);
 	if (required_fault)
-		return hmm_vma_fault(addr, end, required_fault, walk);
+		return hmm_record_fault(addr, end, required_fault, walk);
 
 	pfn = pmd_pfn(pmd) + ((addr & ~PMD_MASK) >> PAGE_SHIFT);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
@@ -328,7 +325,7 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 fault:
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
-	return hmm_vma_fault(addr, end, required_fault, walk);
+	return hmm_record_fault(addr, end, required_fault, walk);
 }
 
 #ifdef CONFIG_ARCH_HAS_PMD_SOFTLEAVES
@@ -371,7 +368,7 @@ static int hmm_vma_handle_absent_pmd(struct mm_walk *walk, unsigned long start,
 					      npages, 0);
 	if (required_fault) {
 		if (softleaf_is_device_private(entry))
-			return hmm_vma_fault(addr, end, required_fault, walk);
+			return hmm_record_fault(addr, end, required_fault, walk);
 		else
 			return -EFAULT;
 	}
@@ -517,7 +514,7 @@ static int hmm_vma_walk_pud(pud_t *pudp, unsigned long start, unsigned long end,
 						      npages, cpu_flags);
 		if (required_fault) {
 			spin_unlock(ptl);
-			return hmm_vma_fault(addr, end, required_fault, walk);
+			return hmm_record_fault(addr, end, required_fault, walk);
 		}
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
@@ -564,21 +561,8 @@ static int hmm_vma_walk_hugetlb_entry(pte_t *pte, unsigned long hmask,
 	required_fault =
 		hmm_pte_need_fault(hmm_vma_walk, pfn_req_flags, cpu_flags);
 	if (required_fault) {
-		int ret;
-
 		spin_unlock(ptl);
-		hugetlb_vma_unlock_read(vma);
-		/*
-		 * Avoid deadlock: drop the vma lock before calling
-		 * hmm_vma_fault(), which will itself potentially take and
-		 * drop the vma lock. This is also correct from a
-		 * protection point of view, because there is no further
-		 * use here of either pte or ptl after dropping the vma
-		 * lock.
-		 */
-		ret = hmm_vma_fault(addr, end, required_fault, walk);
-		hugetlb_vma_lock_read(vma);
-		return ret;
+		return hmm_record_fault(addr, end, required_fault, walk);
 	}
 
 	pfn = pte_pfn(entry) + ((start & ~hmask) >> PAGE_SHIFT);
@@ -637,6 +621,44 @@ static const struct mm_walk_ops hmm_walk_ops = {
 	.walk_lock	= PGWALK_RDLOCK,
 };
 
+/*
+ * hmm_do_fault - fault in a range recorded by a walk callback
+ *
+ * Called from the outer loop in hmm_range_fault() after a callback
+ * returned HMM_FAULT_PENDING.  At this point we hold only mmap_lock;
+ * the page-table spinlock and any hugetlb_vma_lock acquired by the walk
+ * framework have already been released by the unwind.
+ *
+ * Returns -EBUSY on success (all pages faulted, caller should re-walk).
+ * Returns a negative errno on failure.
+ */
+static int hmm_do_fault(struct mm_struct *mm,
+			struct hmm_vma_walk *hmm_vma_walk)
+{
+	unsigned long addr = hmm_vma_walk->last;
+	unsigned long end = hmm_vma_walk->end;
+	unsigned int required_fault = hmm_vma_walk->required_fault;
+	unsigned int fault_flags = FAULT_FLAG_REMOTE;
+	struct vm_area_struct *vma;
+
+	vma = vma_lookup(mm, addr);
+	if (!vma)
+		return -EFAULT;
+
+	if (required_fault & HMM_NEED_WRITE_FAULT) {
+		if (!(vma->vm_flags & VM_WRITE))
+			return -EPERM;
+		fault_flags |= FAULT_FLAG_WRITE;
+	}
+
+	for (; addr < end; addr += PAGE_SIZE)
+		if (handle_mm_fault(vma, addr, fault_flags, NULL) &
+		    VM_FAULT_ERROR)
+			return -EFAULT;
+
+	return -EBUSY;
+}
+
 /**
  * hmm_range_fault - try to fault some address in a virtual address range
  * @range:	argument structure
@@ -674,6 +696,16 @@ int hmm_range_fault(struct hmm_range *range)
 			return -EBUSY;
 		ret = walk_page_range(mm, hmm_vma_walk.last, range->end,
 				      &hmm_walk_ops, &hmm_vma_walk);
+		/*
+		 * When HMM_FAULT_PENDING is returned a walk callback
+		 * recorded a range that needs handle_mm_fault();
+		 * hmm_do_fault() runs the fault outside walk_page_range()
+		 * (so no page-table or hugetlb_vma_lock is held) and
+		 * returns -EBUSY so the loop re-walks and picks up the
+		 * now-present entries.
+		 */
+		if (ret == HMM_FAULT_PENDING)
+			ret = hmm_do_fault(mm, &hmm_vma_walk);
 		/*
 		 * When -EBUSY is returned the loop restarts with
 		 * hmm_vma_walk.last set to an address that has not been stored

-- 
2.43.0

