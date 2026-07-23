Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB048425E
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828232; cv=none; b=LJAny/tHNuM3cY8AQzymTtnafhfJebq3ChwXzfzz4SATN1CF/peVvGKQPJhpyyYo0gVcLwCLkvxpYv1mAnThj4/PjqQuQEXm+idcBSLdzwuZulmNe4pigLIqZVOcxKnoGUCcoZLzFBalw3m5jhda1r7tY5PNDFsLk8iiYuSE3gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828232; c=relaxed/simple;
	bh=OHRNaT5JjbQYbg0HfVsh/goi/Wp2JeVv837tKjXheiU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qR1zx/z/dsA6xTjsEoAczLMuqvAAgyyt1scganGvcQsYsXWZui8OsrcwnmLxLdxs+RXns+PuxD+3M6hGVoZpO31mz3JVoNM98W7iec63xhpqZP5A2f/fqVN6XD2qJ1RPraLpcosu5lGAQDjznwi91DgFvnvmIIVSm/sBCzMjZ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSXNC98m; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSXNC98m"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so771272b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828218; x=1785433018; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i8Qd33SMLkRtmqANiDW8AEhl0t9s2Dut7/75bk+4IdQ=;
        b=WSXNC98mn9E0uZv6c2hSBxaJ5THbotrgF8Z9RkvDYuq4Q4evsHpW4g3mqJYQWggIpf
         zt0Gp0677ef4lE+UEuWL6cq09YFhfDkld1spJvjM/x2tEbA5n+/fYqZSj6/fh9IXcCTu
         ixmXyltpDNi/NOEf9arwP00oJMN8zMDDDnQRimdOkX2p4kTQDi8PjYqwaCtc9DgMkCxx
         c64FSyVvbcVHAJtVXLCEExjtElC0ViZjOER1MjCb/lF7xwMYJ8wnYTOeuoqaDZ/Lyq/E
         BIdjNu3rl7Vd3ly213tz3cfTC31gvKlDq9z/0YF6dMEzjdJYXBn35fUWfRiuLEwR4v92
         Xr2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828218; x=1785433018;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i8Qd33SMLkRtmqANiDW8AEhl0t9s2Dut7/75bk+4IdQ=;
        b=YItLPXnth8wOGO7yiwVwb0OmNu3j6Ri9M5rwB7+jaFKmOqiKv0xVG4TuUCMr7Y86gq
         4hTKOuGVZEg28UvJx5f8DXoMfFW6pGc6HAwk0e32otfrDnDDp4jMoevptlzFEe0EUUw5
         1A/kJL3dqs3q+1OOOR5vSUO14Y/majOXN1ZDRD3KHg40TG11Txaq++564oIwL7POpZA7
         O3UpfWzUPvU4nzprcEzf530OGcQaJ4TP7GtqipEPF3l48SrVW9mwA4DF/XeaQfWgSeqw
         dLIMcAQVSOand8bsGVNrtAI0rA3I74VQKodkLtQycMWe+ElA3iUYT4C3hVzto6ckOcpm
         vRVA==
X-Forwarded-Encrypted: i=1; AHgh+RpdIK60fnEc1NpzMQ09vzRmr7DJM/Ot/rfy3eGyDmsmutnkgUPV9grVYCWW4a/sGouX2/2nMhWIpexeD+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw81dFBQlc1eDWelwFbbU6wSXhzaCXXOVnWjC/dZbRa5fpRkuW1
	DrTu8Ql71o6ls6I7L2njU0Wr/L1kDGYrgX1P6hHVOiF0zxri91RUStAc
X-Gm-Gg: AR+sD11P7TivNvUvkbrnpDeU30TqHburiOfu4Acg4Y6Tf5vRjVeCW4lu0VLLVeN0Bn5
	84G6vYJBD/40keMTNiFWHzao9MkgFqeK9jssazojOqcMutzBE8nTn9Axaaw7G700r/P0ptR5PGs
	f0UYHv2MP5NRWU4qKbTxLg/wCgCdrpSacEQwhpANi71lKcbJJqZagcad+mB+EN0MjtIdMU5TxhP
	NE7kOArPSH5tCW6orwCMyoL+y1k0ODiXOtrBzRU3iL89A/uxV0ZYMWFNprJMsMPdA1Y+88H0edX
	I23Ea/mWBOZ9hxxa0tr6orIWFLVduAJpo3LRUHcrsHtcCmLtiStJpMV9rWRqxmSSNZWV+k29aTW
	+YuyZ/GmQxDe0QYtKhSba+cehfJmDFjTfDZgt2KiFcgQx01ZU0sZ8y5K99VMk7JddbWTJZulhTC
	9CL/IlcHTHKvgJV6Mvvj2UhjFsQE6tdP3zvPgPjFjz876kgNHD
X-Received: by 2002:a05:6a00:cd3:b0:848:88e6:95d3 with SMTP id d2e1a72fcca58-84e2bc4d259mr4728321b3a.72.1784828217972;
        Thu, 23 Jul 2026 10:36:57 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:36:57 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:40 -0700
Subject: [PATCH v11 8/8] drm/gpusvm: Use hmm_range_fault_unlocked_timeout()
 for range faults
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-8-c55b003a4b61@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=4921;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=OHRNaT5JjbQYbg0HfVsh/goi/Wp2JeVv837tKjXheiU=;
 b=3mS7hpEm1cC4EjlfjSHzs08itt/haPD5UmH5YZzhkX5wXqdTOzSMnls0rW++T0vSS8hxNEDOH
 H/0vN9YPqS8C3NJp8Qfk40j/53Cv5CNaQqrwQS1NX9qK2UYGBofyGE6
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

Several GPU SVM paths take mmap_read_lock() only to call hmm_range_fault()
and open-code mmu interval sequence setup before each HMM walk. They also
retry -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires.

Use hmm_range_fault_unlocked_timeout() for those faults. The HMM helper now
owns mmap_lock acquisition and refreshes range->notifier_seq for its
internal retries, while GPU SVM keeps its existing driver-lock validation
with mmu_interval_read_retry() after a successful fault.

drm_gpusvm_scan_mm() and drm_gpusvm_range_evict() pass
HMM_RANGE_DEFAULT_TIMEOUT as the helper retry budget for each HMM fault
attempt. drm_gpusvm_get_pages() keeps its existing absolute outer deadline
because it can be reached from GPU page-fault workers, where fatal signals
from the faulting process cannot stop an endless invalidation retry loop.
It passes the remaining time from that deadline to HMM for each fault
attempt.

Leave drm_gpusvm_check_pages() on hmm_range_fault() because that path is
called with the mmap lock already held by its caller.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/drm_gpusvm.c | 60 ++++++++------------------------------------
 1 file changed, 10 insertions(+), 50 deletions(-)

diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
index 958cb605aedd..e912e994beb2 100644
--- a/drivers/gpu/drm/drm_gpusvm.c
+++ b/drivers/gpu/drm/drm_gpusvm.c
@@ -773,8 +773,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 		.end = end,
 		.dev_private_owner = dev_private_owner,
 	};
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	enum drm_gpusvm_scan_result state = DRM_GPUSVM_SCAN_UNPOPULATED, new_state;
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(start, end);
@@ -788,22 +787,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,
 	hmm_range.hmm_pfns = pfns;
 
 retry:
-	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-	mmap_read_lock(range->gpusvm->mm);
-
-	while (true) {
-		err = hmm_range_fault(&hmm_range);
-		if (err == -EBUSY) {
-			if (time_after(jiffies, timeout))
-				break;
-
-			hmm_range.notifier_seq =
-				mmu_interval_read_begin(notifier);
-			continue;
-		}
-		break;
-	}
-	mmap_read_unlock(range->gpusvm->mm);
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 	if (err)
 		goto err_free;
 
@@ -1408,6 +1392,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	void *zdd;
 	unsigned long timeout =
 		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long remaining;
 	unsigned long i, j;
 	unsigned long npages = npages_in_range(pages_start, pages_end);
 	unsigned long num_dma_mapped;
@@ -1422,7 +1407,9 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	struct dma_iova_state *state = &svm_pages->state;
 
 retry:
-	if (time_after(jiffies, timeout))
+	remaining = timeout - jiffies;
+
+	if (time_after_eq(jiffies, timeout))
 		return -EBUSY;
 
 	hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
@@ -1439,21 +1426,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
 	}
 
 	hmm_range.hmm_pfns = pfns;
-	while (true) {
-		mmap_read_lock(mm);
-		err = hmm_range_fault(&hmm_range);
-		mmap_read_unlock(mm);
-
-		if (err == -EBUSY) {
-			if (time_after(jiffies, timeout))
-				break;
-
-			hmm_range.notifier_seq =
-				mmu_interval_read_begin(notifier);
-			continue;
-		}
-		break;
-	}
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, remaining);
 	mmput(mm);
 	if (err)
 		goto err_free;
@@ -1720,8 +1693,7 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		.end = drm_gpusvm_range_end(range),
 		.dev_private_owner = NULL,
 	};
-	unsigned long timeout =
-		jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	unsigned long timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 	unsigned long *pfns;
 	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
 					       drm_gpusvm_range_end(range));
@@ -1736,24 +1708,12 @@ int drm_gpusvm_range_evict(struct drm_gpusvm *gpusvm,
 		return -ENOMEM;
 
 	hmm_range.hmm_pfns = pfns;
-	while (!time_after(jiffies, timeout)) {
-		hmm_range.notifier_seq = mmu_interval_read_begin(notifier);
-		if (time_after(jiffies, timeout)) {
-			err = -ETIME;
-			break;
-		}
-
-		mmap_read_lock(mm);
-		err = hmm_range_fault(&hmm_range);
-		mmap_read_unlock(mm);
-		if (err != -EBUSY)
-			break;
-	}
+	err = hmm_range_fault_unlocked_timeout(&hmm_range, timeout);
 
 	kvfree(pfns);
 	mmput(mm);
 
-	return err;
+	return err == -EBUSY ? -ETIME : err;
 }
 EXPORT_SYMBOL_GPL(drm_gpusvm_range_evict);
 

-- 
2.43.0

