Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94BC3C5DA6
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718838; cv=none; b=dxO+ZcLEbuBO5VGMoUKQHOrTd3ejx2vhJlLf9Ut32QmDfXb7o13KkEljLpd1ZGPq32m41etjROghA8NjEJbko1jmjIVtljdfHKD981e2JYj8SXrI1bKLYd2Fi3BOs/E1GxHamevKTFQJHYTDXipRdhWkd32HNe336++DJqi1V+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718838; c=relaxed/simple;
	bh=frLTEoZS2wGW/Ath+1xF9AQS7YavZ223qWxxIXaQCHM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbjfTL4QNg7n9pRVOWN1GlkY8WSh/WzTYz+MXvDvtsExz7u2WDcy41fxVhT/ppIIcMijQLzxaunt7asPj+h4MWttydxg5P1npAzX/57ac0Tb+ZYUteV+Su2bGt54qOEB8IxPnLoDLFP+CrMLOIIRGekzoG+DrSi5GfMc5uUWfq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W/VZYUF/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W/VZYUF/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-8478fe07f0fso1478812b3a.0
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 14:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718835; x=1784323635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=SsZ1Rl/n/xZapvBLsULQnfYoRJnC5F850v9mJm5328I=;
        b=W/VZYUF/7h9WMWshohRHlXGNZolufAM16SPlqA7yzSN+qryXDBTHduVRfgW7xo8e11
         c0zi3VKDuH6vf9y7+YqUszJKLOvq4DTa5wJ4LNAxi0J+yqEb3MFK0I10Fwk3BTEYvSoW
         Iyzj7eAXEP4xHbjWawOTmXFDDDyYkF98W+d0h66+QLYr1f0j5wfc8es1nHxGa8nXIMlC
         k1YlXzuDHFYKhOwN9KUyCiulItSLbyErCNcYUn81aWbFsDaoXmZHVrWnDfx5adiZujQH
         2f7EZzIofWVLNS5rzmbWSMVGelsd4WYhX8BKw3vhS1UPMiQewcOuSgDO8M9a0hWuM9I7
         B+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718835; x=1784323635;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SsZ1Rl/n/xZapvBLsULQnfYoRJnC5F850v9mJm5328I=;
        b=NlyUOIiDIVThanNS+c5L2BIbX5uUzh7y3hKD4M+vj7spZkMDjiMaAfWFzt3heexttH
         ZLq04MU/4T5ZiuZ/jChJHSu4tAoh2R4ZnAHWM/iPAYOj/l2QDoU2N1DZxD7ErlBeLHhd
         dLrpq0pszDt1r+gaU8X6pTrx5bPkKLo54KqS8lMfe8JyrOqx4p9N16vOrAzlIfz0t5JE
         fBPVgiaNNaRw5WjmBSnLlfNw5OcomhPQ4Dxr5nz0uT7IU3Qtvqj5VTGbbr9muZsE7qoD
         u/3LCbU3jmwumGYKpIl62k9Ed3Q5yk0HIxPmwIIZaWrcPONeIrogqOj4Au9cXg5jtYlT
         SVWA==
X-Forwarded-Encrypted: i=1; AHgh+RoBl/yrpzRmvIkXoJXtT/LpQnBMlERqxcWUBqjX3zWRyaxAP21tlHIH96+ztOLWjHo5qeU1RZ5mUkYEBn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoFfwf77z3gcUwB364e5xx7e6ARGnutJojQbwErdpWowxpqFUt
	joSqaUKhaFUCUhdYxU4I7bn2nL7aIL8zbOvvTOp0c4W5Y2pDG9kOmG5V
X-Gm-Gg: AfdE7ckGDSnflhxO3myZfeRFLScbPEsmk+tyxdCfBVQ+27r5UW/9lTZogL1iandc7qA
	U5b0UGpzF94nWfRTpSl4VqHYYlSyNQcAdL6fqSUc8TSSIaule+2h1SRHrQe+1UAiIzy0gP/AQBn
	Ffjf6XjUhBG6eE5XlWL9y1n17gilOfjekDQKhwDmz0Oaej0qRUaofTKKv1p/pKG+JR6SMfqN9yr
	eQLvx+GfE0l8C2GjsPIPELbPWvDV9o+b913R1VJGaK9X+EkTfxp000QRQ0L7K76aWN7iMDUo1WP
	I7YlPK2vfz1lvjLN2UJTVQ5/zfyAYo3Ne5OOmeyk/y2bXGPrbRk5kncEoDiMcce1Py0WFg7fSCu
	RHU5A7uJ/T2ISEV9RqDz28us4mVuoSGIo7O4Q+a65dwlYQXBVvKZtgxadQL7cTBjsNlxvod4CU6
	iZCSA3KwTjmdyCRjadLfA9mF8NrcgJacFYeLV2ebnrwH81fRlwrrgKuV7ibIbPFgXy8haOIA==
X-Received: by 2002:a05:6a00:3397:b0:848:2f84:737 with SMTP id d2e1a72fcca58-8488990b261mr583131b3a.74.1783718835015;
        Fri, 10 Jul 2026 14:27:15 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84870d76ce7sm1801076b3a.55.2026.07.10.14.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:27:14 -0700 (PDT)
Subject: [PATCH v8 7/8] accel/amdxdna: Use hmm_range_fault_unlocked_timeout()
 for range population
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 10 Jul 2026 14:27:12 -0700
Message-ID: <178371883276.900500.12789147320642521200.stgit@skinsburskii>
In-Reply-To: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
References: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
It keeps a single HMM_RANGE_DEFAULT_TIMEOUT deadline for the populate pass
and retries -EBUSY until that deadline expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes mapp->range.notifier_seq for its internal
retries. Pass the remaining jiffies from the existing deadline to HMM,
while preserving the driver's existing outer loop for interval invalidation
retries and for selecting the next invalid mapping.

Keep returning -ETIME when the retry budget expires, matching the driver's
existing timeout error convention.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/accel/amdxdna/aie2_ctx.c |   17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 54486960cbf5..a16b8d7deaea 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1061,22 +1061,11 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
-	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
-	mmap_read_lock(mm);
-	ret = hmm_range_fault(&mapp->range);
-	mmap_read_unlock(mm);
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range,
+			max_t(long, timeout - jiffies, 1));
 	if (ret) {
-		if (time_after(jiffies, timeout)) {
+		if (ret == -EBUSY)
 			ret = -ETIME;
-			goto put_mm;
-		}
-
-		if (ret == -EBUSY) {
-			amdxdna_umap_put(mapp);
-			mmput(mm);
-			goto again;
-		}
-
 		goto put_mm;
 	}
 


