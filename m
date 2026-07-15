Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372CF4248CF
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Jul 2026 18:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139404; cv=none; b=Sqj06pt5j+AwNOHHnMZD/oL6E2Ab772OAoDNjz3xTH+16PUM7KE3A6nBgEiDnecwhfMEBIiNCRYOSJZ9SGU4vkUJ7yp9J1F7p0vjoYKu07nA3SX1/KzmsHgK5HhPgQl1clY2xl089QgulMkB//5MnWwmBiABPBldEW8MOatUhxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139404; c=relaxed/simple;
	bh=QDkn/RQPvTt4rCrtIK7bOiEWlSwSa2c8a6ijlJ6xk/E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZv8BgKmwuSmqh+RAmbj1QC6E4VD1jXwQM1nefoJKWvAMLpltAsmbdAw16PRerjd/oyVuHp69xNYyR7ytWdggU573EHjOSANoPz/vfq81BbhZHjJxrLwTjRbb7TyggkujlYujBQAwUn2KtLEjp9wc6RmATQNYY8EHQ/t2AJQBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HWXDJQHB; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HWXDJQHB"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cabc0a1ab6so68401845ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Jul 2026 11:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139400; x=1784744200; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xews/oLHPsdqsmPpn1oXU4/lUwRmc6mOTrGvCA27l7U=;
        b=HWXDJQHBm4rFxdLm2+gv56gw+psJw2vVt5OZf1Y01gGSkeE4EW9Iw1ITC8mJfcU9Mc
         nFmYSlzE7OrNHy8QGK/stl3aQHjzk3uld6y7z/UymSuWaCx41XhpjaWVuqqQ9SghtLWI
         n+UzeG8MpoFpas+nJieykgj/qH1+p6tZfI7GAgeF78ymdjVvyiilieEiTbAOvbZQpeQV
         LFFoN4VDcskkFCsL6Eqpo2bQ1uRHo0Yrt6n0J0nSx72d39oyNsDMFjXeiV/4YtjN7YFi
         xCLO3M30GnghdfKEHgrM5/7c5EZPFD85fZuNth2j3B1hwals7RQhwaUFXVc0cTTXsxdr
         I2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139400; x=1784744200;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xews/oLHPsdqsmPpn1oXU4/lUwRmc6mOTrGvCA27l7U=;
        b=cubgSnXx+X2V2lev+mhh6Zl7ukxifmI9iFFQfegcqDh/bcyaxuitk4doNvF/HhZ/zq
         1fXruIfkFBf2vZZd42aDNTLADERs4spY2H8OInbrcp0dQc3KDI394x55F7RSCSJQiQS/
         p+R2j+UzuR0yc5NJM7zm/7p1s8mTvnX69vW98cs8Jzakl2YnvP0+NPw/Dtdx2U4nYFGY
         rQsHRiY7eJhTbIoahCdaRZDqsAmEF2EukYFN/R8u9+NGhP4WjIcz5KBPrhCfFuxMYB6H
         v0nAKt3iSyXyIxtwQ2MKmLAVAO35mHtCUTylEymUXG5jlTy7OXTjV80k8MriKF8CrV0k
         fETg==
X-Forwarded-Encrypted: i=1; AHgh+Ro8Nlj4AfDuOJTEyCzmnQt7De4fyJkhVJIhOt5r+a0/XW2LB936Vd1/ASqx7nIJK4jNehxWJjlfZnTSTVc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMG1B8Uzkkd4dXNDXtz+PNe4hBQTBOAUDgy2SdO2rshkP6Ogby
	XbJZgHs7OCRPGEOmWeYqHkWO6IzyYPpdbBEaIjkt1/OYmzfVkRx79zP+
X-Gm-Gg: AfdE7cnA31eS+7qPBS1Zud3ECyL4V9xf2NBAm4mmvlsz2VzwUs+Ny+WMIssnQaXe/Od
	VHunJBCdHWwG2cHFDam8AN24R4HH7wW4ry9CIN9BMhPR1VdH6RJaPIBNFg2csMHTDnHxBH8tiDh
	ukopxFlnqtPnrP02jR+9h1ZJU0zuOS255QIuwbgxly/NoEGjRcjqaYLXKMO3YcKdoH5e9Ex1qcM
	c7qyO+DoAjVPRWPEvAHKM7sO4cmgmsqH1WMDXIZlJGfFToHjPVY0QBZ0m5gy42yP8X42XzcD6Di
	cUsO5zTw7f1mSky4LamDXQDAYJ2zj1mZXB7wgqobXu8bE0/GvkM1MOUOwEkFSebz2lHWAplVF4W
	+pFXBInHoTLUDoXWe1UnsF/7nFjIcMsD1RRp4lvMlWVGUmuG1qva4pdISTUxR3O7nS3feoVoJkl
	bo2LOv0s8upRUxxX3m/UwJjUhlb3wt56QVQ0BTMF6W384Wbjs/PQLOoKNoZxg=
X-Received: by 2002:a17:902:ccd2:b0:2c8:4c29:afeb with SMTP id d9443c01a7336-2cee9a64cf7mr89372715ad.8.1784139399557;
        Wed, 15 Jul 2026 11:16:39 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf10592040sm6621985ad.55.2026.07.15.11.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:16:38 -0700 (PDT)
Subject: [PATCH v9 6/8] RDMA/umem: Use hmm_range_fault_unlocked_timeout() for
 ODP faults
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
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Wed, 15 Jul 2026 11:16:37 -0700
Message-ID: <178413939750.1155966.3639451690646685854.stgit@skinsburskii>
In-Reply-To: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
References: <178413903133.1155966.3904063656020521607.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

ib_umem_odp_map_dma_and_lock() takes mmap_read_lock() only around
hmm_range_fault(), then retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT
expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
ODP keeps using HMM_RANGE_DEFAULT_TIMEOUT for each HMM fault attempt,
while interval invalidation retries continue to be handled by the existing
outer loop.

ODP still validates the interval notifier sequence while holding umem_mutex
before DMA mapping pages.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/infiniband/core/umem_odp.c |   18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 404fa1cc3254..9cc21cd762d9 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -329,7 +329,7 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
 	int pfn_index, dma_index, ret = 0, start_idx;
 	unsigned int page_shift, hmm_order, pfn_start_idx;
-	unsigned long num_pfns, current_seq;
+	unsigned long num_pfns;
 	struct hmm_range range = {};
 	unsigned long timeout;
 
@@ -363,26 +363,18 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	}
 
 	range.hmm_pfns = &(umem_odp->map.pfn_list[pfn_start_idx]);
-	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 
 retry:
-	current_seq = range.notifier_seq =
-		mmu_interval_read_begin(&umem_odp->notifier);
-
-	mmap_read_lock(owning_mm);
-	ret = hmm_range_fault(&range);
-	mmap_read_unlock(owning_mm);
-	if (unlikely(ret)) {
-		if (ret == -EBUSY && !time_after(jiffies, timeout))
-			goto retry;
+	ret = hmm_range_fault_unlocked_timeout(&range, timeout);
+	if (unlikely(ret))
 		goto out_put_mm;
-	}
 
 	start_idx = (range.start - ib_umem_start(umem_odp)) >> page_shift;
 	dma_index = start_idx;
 
 	mutex_lock(&umem_odp->umem_mutex);
-	if (mmu_interval_read_retry(&umem_odp->notifier, current_seq)) {
+	if (mmu_interval_read_retry(&umem_odp->notifier, range.notifier_seq)) {
 		mutex_unlock(&umem_odp->umem_mutex);
 		goto retry;
 	}


