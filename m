Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00CCF47D46A
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828222; cv=none; b=B+E3OzAVIDl8W/7Znw2x3oe8Jj3IR0PkQwzKgP+DR+Ig87E1JBhVa12/Dq1J7PpH3OKdgLTsOeoQL5UNmjjKzgOyvZh49+a+97tr8j1rGDva8a4cyc7WEpraMxeCNPMX7Va2bTr9F8M95YOlJ1K2bB8gNJclssNdX9EDO+qCdG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828222; c=relaxed/simple;
	bh=ZyAhBAfWZePcXjSsL7QqvsrSYU5bhX/lu/bgMYHTJjg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u+2Ac9IJm1cDQ/rgnIqsmF7mC90ooPMlTrXKkHa0ZbuquX2Pft2jDaHe/SweqMl1LRk5dKnsvAh5CpuYBtDg4G7Wq6uT/WW7F2SCtEue5/74Pcizm8xim0ys+xCbBOiKz5LDeaFzuEVUKWsocr0bg9HVWzRmqmF8uhu+f9/1b4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxDQV4ad; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxDQV4ad"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84e27035206so1023100b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 10:36:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828211; x=1785433011; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3slUHnl834IP76VoxdiRinKrcbFYlUZTVsrXFJZ4JdY=;
        b=TxDQV4adhqRRAekWKez2o8M9b2r1N8AqJJwAYODXxBXkLYFJQkJEdchOdxcj8bhvrM
         VAUQBDtVhqqz1QYGH9SkvlUvzw+PSD3qHq/CtSUz95oRVoBgIZpRGtNy6YzFO9ze8Ahc
         D4l4Fj9JpYgfSAKb8NbAQvV/P1dINo9cElUfZDImdi5bzBGJ7Fvl6qInx+o8cYy8zH4P
         YC8f3mFup4oQ0/yGL2PUs92s0+La/W9BKGjKEKhVG4LS1cmmM4WVeeWQmY1pWGdtRoWA
         5WtKrrraSVTNyA8JVVUb05BWJAXZ+Pe8F61u/GCnMpmHA+/hpoSvoIuCXn+I4zdGUo46
         XGIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828211; x=1785433011;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=3slUHnl834IP76VoxdiRinKrcbFYlUZTVsrXFJZ4JdY=;
        b=hV2XUMkDC2kjEn03+sOPVDonPtRAJGPsC5/P1LyrmdgWQAHDqhfNVnIw6fb2IFjLoT
         x185cedSZDqbKfaa5FUk31VM+RFps9gD1ac4GhYYy5tdZCqxtLqft0LJ2pUa/fddAlaR
         k2CW4gY+BmvQ5/Peh0b5TFrkN0ERQQPUHlrHnFM+Las5emrVNmjC0ZrnCztLVOTE416q
         AdYwELmAYIuUrdFRU9oKm1zt5+KNS/05h7Z9xc/uUZV9/Yw+HBWCjoARXd5kwYrFHd1q
         VaI6IMQmpTUYUCh3b9T3Z7d4pq07ysYiIc27kZYxrHKBSIofRsuw55D/so/BpHWPt5Fl
         Fq0w==
X-Forwarded-Encrypted: i=1; AHgh+Roi56N96V3yi8X637ybeTkCTsKXBdsMzKDoZV1gR/ywDpJsblWcAjaQ/6/zNy9shj+G9oUBsBLBi3rO2Xs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4VvtagZnqSCH6r5pchqd197CjZjxkwelkbc8Q5njTPpd2Z2yB
	Jp1Sy2tj4msdRDUJ1xKlaSmiCimEv3dm3Ge3N+jTrnX9dVrVw8M0C7g5
X-Gm-Gg: AR+sD10iKY4/t0L2oRR/ju/24kHlzJQ0dwm2FivWlva3h3cR0eRilRDgprE9OWMUDdh
	rAr9eFhgQq3/l1UrmAuQ5y7j+y0XNsL/ob1gbY8cGLu5H9VqhyhqfPFEir5fAZzEfHdhyN0oPEw
	V6zqkNsTCr7FgeGX00AIzE/xsINfmholli3QPojc1Vaqj9lUUcYht/38+rLMte2zvx71nyYJ82i
	1kqN1XMrTTOG7N5eCLUZRd9A94XIFxc8G7reFY2GvTbD5esy5JwU6q0dRmA+hoGNKy/Po3vtMsP
	cV2n7tA8ilgspTDtz4WohFT0L/Z9T5PP+ve8O0q0IbU1H3IUBUOR46eTfn2dD5ESLVKIqsEosfl
	SV2fwLYxdz36IcUgv49lAJ+8fRkyIDb+zNj2mI5Ovn0/C7b2/zGvQFNW7bMB7ZuSsrNJ+/Ro49O
	f0nJPbzeKjl8yDPV10HFqVGqVrnScMcPRDQkfjEnGX+4Ao423bjYSh1FF5dRk=
X-Received: by 2002:a05:6a00:27aa:b0:848:2d1d:836f with SMTP id d2e1a72fcca58-84e2bd6923fmr4526185b3a.28.1784828211456;
        Thu, 23 Jul 2026 10:36:51 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:36:51 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:36 -0700
Subject: [PATCH v11 4/8] mshv: Use hmm_range_fault_unlocked_timeout() for
 region faults
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-4-c55b003a4b61@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=3646;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=ZyAhBAfWZePcXjSsL7QqvsrSYU5bhX/lu/bgMYHTJjg=;
 b=U8sSsRw+6XM+qGDxpQuoe99V7LeZ+M1zXxyPfZetIcbxZBFVX+M/0/c0psrN63mtn0Gyjy1RN
 9IByi6+fiCLCWN+9DASYqtkcc69AC9zezCPbmBdSfWzMLLq1QDXujHn
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

MSHV currently faults movable memory regions by taking mmap_read_lock()
around hmm_range_fault(). That prevents the fault path from handling VMAs
whose fault handlers need to drop mmap_lock, such as userfaultfd-backed
mappings.

Use hmm_range_fault_unlocked_timeout() instead. Passing a timeout of 0
preserves MSHV's existing unbounded retry behavior while letting the HMM
helper own mmap_lock acquisition and refresh range->notifier_seq internally
before walking the range. After the fault succeeds, MSHV still takes
mreg_mutex and checks mmu_interval_read_retry() before installing the pages
into the region, so the existing invalidation synchronization is preserved.

Fold the small fault-and-lock helper into mshv_region_range_fault(), since
the remaining retry path is just the standard "fault, take the driver lock,
check the interval notifier sequence" pattern.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/hv/mshv_regions.c | 54 +++++++++--------------------------------------
 1 file changed, 10 insertions(+), 44 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 6d65e5b42152..dddaade31b5d 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -381,46 +381,6 @@ int mshv_region_get(struct mshv_mem_region *region)
 	return kref_get_unless_zero(&region->mreg_refcount);
 }
 
-/**
- * mshv_region_hmm_fault_and_lock - Handle HMM faults and lock the memory region
- * @region: Pointer to the memory region structure
- * @range: Pointer to the HMM range structure
- *
- * This function performs the following steps:
- * 1. Reads the notifier sequence for the HMM range.
- * 2. Acquires a read lock on the memory map.
- * 3. Handles HMM faults for the specified range.
- * 4. Releases the read lock on the memory map.
- * 5. If successful, locks the memory region mutex.
- * 6. Verifies if the notifier sequence has changed during the operation.
- *    If it has, releases the mutex and returns -EBUSY to match with
- *    hmm_range_fault() return code for repeating.
- *
- * Return: 0 on success, a negative error code otherwise.
- */
-static int mshv_region_hmm_fault_and_lock(struct mshv_mem_region *region,
-					  struct hmm_range *range)
-{
-	int ret;
-
-	range->notifier_seq = mmu_interval_read_begin(range->notifier);
-	mmap_read_lock(region->mreg_mni.mm);
-	ret = hmm_range_fault(range);
-	mmap_read_unlock(region->mreg_mni.mm);
-	if (ret)
-		return ret;
-
-	mutex_lock(&region->mreg_mutex);
-
-	if (mmu_interval_read_retry(range->notifier, range->notifier_seq)) {
-		mutex_unlock(&region->mreg_mutex);
-		cond_resched();
-		return -EBUSY;
-	}
-
-	return 0;
-}
-
 /**
  * mshv_region_range_fault - Handle memory range faults for a given region.
  * @region: Pointer to the memory region structure.
@@ -452,13 +412,19 @@ static int mshv_region_range_fault(struct mshv_mem_region *region,
 	range.start = region->start_uaddr + page_offset * HV_HYP_PAGE_SIZE;
 	range.end = range.start + page_count * HV_HYP_PAGE_SIZE;
 
-	do {
-		ret = mshv_region_hmm_fault_and_lock(region, &range);
-	} while (ret == -EBUSY);
-
+again:
+	ret = hmm_range_fault_unlocked_timeout(&range, 0);
 	if (ret)
 		goto out;
 
+	mutex_lock(&region->mreg_mutex);
+
+	if (mmu_interval_read_retry(range.notifier, range.notifier_seq)) {
+		mutex_unlock(&region->mreg_mutex);
+		cond_resched();
+		goto again;
+	}
+
 	for (i = 0; i < page_count; i++)
 		region->mreg_pages[page_offset + i] = hmm_pfn_to_page(pfns[i]);
 

-- 
2.43.0

