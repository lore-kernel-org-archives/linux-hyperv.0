Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3854485CDD
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828228; cv=none; b=Hn4TV2BSygPOAUigFr/TVxBY4YGabXMwM4eW4+WM4ZvnmfjsJWa8g0l8cxwyjhCLD4JAmG5RKUcJuYIKQGMrFGp2I0yx23xHBXy7N5ixHb+mtuA9jYLyaKeEWDuR7wlMjm0XUpz+/hILwTGpPHmheVgfAcRTbZh5fEMrC9qPRfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828228; c=relaxed/simple;
	bh=Js9Z5fScNTLs9yZDEPq5MMQDWBFdccrrYdkvKMfBR0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GhN7ssCQDVKS/hWrBFeicepliNXNvAN0GX6qmlKi6Cqvluvi8d559rOHNFXd0f1p/gK6ZYt5GTkoZ7RgjK8Cc/v42flimGlOAfCiZuiqMH+8NaK4ZYlh8krjcPa2uxUuYl2LEOchpM34cRqWH6A6Q1F8tgU1sRNZ86B8pmX8220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BKL6hJTS; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKL6hJTS"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so771236b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 10:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828216; x=1785433016; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3EHZQlaXq9sLmhVgtuP5ODA2wxc36yvs54yemcncOc=;
        b=BKL6hJTSZk19OoDFcA63/ZRoV0prsj8yCa4ogkU90ZAlAakTfXuIGGS/iowNK20Shm
         48LLdV1VLcRWB+urPSsdyN0SvDg3d5TRjBBZ91VHO9dGcLM7NP5U5NMulOAal5hJ07Q4
         J1ds7S3tCtGMQ0nJS4JKg2CXAmTMXTAXD90ceLfgLW81TiwyrV1T0V6qmP7F3+23sGKK
         ystiPsEBmqOhU53eERSPQWhWZYpis1kHPTqaTAM2/8tKMKtDgkNi4GGJGu6EhArOMTt9
         X2otbFigngyTor75rMG2t8eHnCm9TQHuyZEGyW2NqF+eQpSl9GlrB927etwZYxmjpij1
         XyUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828216; x=1785433016;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3EHZQlaXq9sLmhVgtuP5ODA2wxc36yvs54yemcncOc=;
        b=UlnyqX1gOoZ2sPqZlePnADgHnOMW7xhu2rzmWHIpgjgolY0zY4ix0AGuHqxD/01A/t
         M4pRytmhJ3b6pNhqdDEv9KElY4+XJmWQ7M/Q28BGYGMloSKkX+UrvaKZJjYHjJjWS7lk
         kHz4Gq7EM1vqRLDjFquptcWV+TMyfMCtUVFMU80Ue+3KDbhOs9hXMcHIWH+RHUwwr+kj
         lfBWqzCyTjF/7EckyfVvZLwpc7g2SnsnJ7Eh8UBxzJ2XuIbanLEiyfZwTqsq5+MdtG4V
         3ofNs2kGmI3W5LcNl/2ofnYGYXP1zRWn+1FbmyhXL4vZp6CqgJzZs/nmCpIM/tdbHf2X
         WGPQ==
X-Forwarded-Encrypted: i=1; AHgh+RqKcRaObMKvXwZ+250VweY7MFfc2Ng4iUSSsu/iH2ogqMf7snRgcd9hrijTpWCs83rm4aMlFfhxW6DTDTI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtLZFPELwMGxPDuVCrGa6wiBv0LS+0LF6PLb74Y8ThKU2K+hhg
	N2jcfI04/NR3/7SnQpC1F6518Bbf/N9vpXGT0jhc9ZWP6YBxczfbZwnN
X-Gm-Gg: AR+sD11vo9SDjYgctEYiJs9EPJgeDFVH5AD9tb/HWSguQbGTDVDDP+9OsxnVMucWHQY
	ZqfQMNdBLPkcuSczNddlZrWm7qIXeTv/bLa3cJJ+q0xig0PvU/PfOEkhoF8KJ2B9AtLMqdvYJ+S
	Zq+n6oZ1njBUBrXptwNsXYdwMp9DU0K+D70y0okTDGZMQCt+Xvn5jryjpejZNdsjwzjIBXLnOA1
	zRItZzykjuM/+fDTZ+9hO2XWIPk5c//pn16FNgB9CVKfK/A8LHxSQ00U6ek/OrHjqSzvb1CFtM/
	0UJfZtS2leIlXftxG3qhsq7j2z/JfM2bJasr46UCNOF4AmHPjug8Tyugo7Kpyt3faO0N6udYYB4
	u+LQ5NYLCZaDLOoKaXZQLFQpYWpqWhilKmHmv7q4G3AGrVERyMN5PSCongf4bceAqlXCfaArdMu
	BDxTUk0UGCP5fj/2MA/w0blJl+Iks6WLztHcM/obXmRJcHAwNx
X-Received: by 2002:a05:6a00:4482:b0:848:47d3:47ec with SMTP id d2e1a72fcca58-84e2b8ab6d2mr4797080b3a.31.1784828216068;
        Thu, 23 Jul 2026 10:36:56 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:36:55 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Thu, 23 Jul 2026 10:36:39 -0700
Subject: [PATCH v11 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-hmm-v10-v11-7-c55b003a4b61@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=2650;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=Js9Z5fScNTLs9yZDEPq5MMQDWBFdccrrYdkvKMfBR0c=;
 b=UoKX2QEi16TQG/XSPiXepu/KONklG+8l1kn86LgWhqxQQe32BnNrpIu04JJYOeap8yhmhRNnI
 Xgchah8NIfnDwgLdxf/plAUECr/N2GDtTgg00z0Czhp7vw9hyXoBoqQ
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

aie2_populate_range() takes mmap_read_lock() only around hmm_range_fault().
It also open-codes the mmu interval sequence setup before each HMM walk and
retries -EBUSY until HMM_RANGE_DEFAULT_TIMEOUT expires.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes mapp->range.notifier_seq for its internal
retries, so the driver only needs to call the helper and then validate the
sequence before marking the mapping populated.

Pass HMM_RANGE_DEFAULT_TIMEOUT as the helper retry budget for each HMM
population attempt. This scopes the timeout to repeated HMM notifier
retries while preserving the existing outer loop that moves between invalid
mappings and restarts when the interval is invalidated before the driver
updates its mapping state.

Keep returning -ETIME when the HMM retry budget expires, matching the
driver's existing timeout error convention.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/accel/amdxdna/aie2_ctx.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/accel/amdxdna/aie2_ctx.c b/drivers/accel/amdxdna/aie2_ctx.c
index 54486960cbf5..b5b4ca263002 100644
--- a/drivers/accel/amdxdna/aie2_ctx.c
+++ b/drivers/accel/amdxdna/aie2_ctx.c
@@ -1034,7 +1034,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 	bool found;
 	int ret;
 
-	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+	timeout = msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
 again:
 	found = false;
 	down_write(&xdna->notifier_lock);
@@ -1061,24 +1061,9 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 		return -EFAULT;
 	}
 
-	mapp->range.notifier_seq = mmu_interval_read_begin(&mapp->notifier);
-	mmap_read_lock(mm);
-	ret = hmm_range_fault(&mapp->range);
-	mmap_read_unlock(mm);
-	if (ret) {
-		if (time_after(jiffies, timeout)) {
-			ret = -ETIME;
-			goto put_mm;
-		}
-
-		if (ret == -EBUSY) {
-			amdxdna_umap_put(mapp);
-			mmput(mm);
-			goto again;
-		}
-
+	ret = hmm_range_fault_unlocked_timeout(&mapp->range, timeout);
+	if (ret)
 		goto put_mm;
-	}
 
 	down_write(&xdna->notifier_lock);
 	if (mmu_interval_read_retry(&mapp->notifier, mapp->range.notifier_seq)) {
@@ -1096,7 +1081,7 @@ static int aie2_populate_range(struct amdxdna_gem_obj *abo)
 put_mm:
 	amdxdna_umap_put(mapp);
 	mmput(mm);
-	return ret;
+	return ret == -EBUSY ? -ETIME : ret;
 }
 
 int aie2_cmd_submit(struct amdxdna_hwctx *hwctx, struct amdxdna_sched_job *job, u64 *seq)

-- 
2.43.0

