Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824A343F8CF
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756701; cv=none; b=HoBQFtY8dXeYIulx7JkVRbVYnae8QRWPqxGHiOz3MyoLMjefAOJtqJh00/+YrwKndH2OpuoaItarAekkyTEUTVdU9WTGRr6uSk7hIEr89aKWSDH4KCOmaSvETyFZ2qYj/cZm0FoA5yoICB1I6W8H8L4Rz7oDAUDxH5azSzVFHL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756701; c=relaxed/simple;
	bh=Js9Z5fScNTLs9yZDEPq5MMQDWBFdccrrYdkvKMfBR0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NuSOQ5xybv1xnRikui37vyjeh2m1yyKKE511EQp1U7E1wMZYUHSkRjnrANFAOoiq1YddbdTBI9zt8/U5hOoj+WATWSDwwKRPuy3/0lx7c0VoUSkeWF4DQeLixTp4Ds0gKlUb4yz8ATQ2YMoqEU6M3zYczP27MF6m3YIg2gfPwkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bqfwTEge; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bqfwTEge"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-848761b5897so7298496b3a.3
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784756699; x=1785361499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/3EHZQlaXq9sLmhVgtuP5ODA2wxc36yvs54yemcncOc=;
        b=bqfwTEgeLLBzB5btm+3q41Gfm+tsHhfYbXFwI58ASYtVh9ExV7vdkWmUMY3W9XDpcQ
         /7a3wuLg87gEATfBwM7u6oitGBFUa39ChxwuVNJBxRF5Ak1PoUFo+L11pE45bP6ya/bg
         po9Y/JtM8iRcws9GV/n53TuQp0N9DDeyysQITt8sLvx82dVDk3AHl6ES5s560p1EIxIh
         SKAkCGq/X6mzwji+sQSViy1DJMv462IYVEYVhRbDr5vZuA5ErWeQIivIDyGOl4Wuq19S
         AfHVZTJ4snaeY8S9TL+mwHfhE0yJr033IVhHgsDXAp574jP8wgYVYClSB7JWyYBenWW4
         01ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756699; x=1785361499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/3EHZQlaXq9sLmhVgtuP5ODA2wxc36yvs54yemcncOc=;
        b=QahvCNTwsuasdaCD8D3kBJjZX2MB1pv7QnvGm8auKqpjE9F+nKS3bziEnTVXbRfF8w
         rKvNgm4NQ0Zi+ot6S0UzhehppQOb/MK3JFPJksKhQc6H54cTChL+ZQS0GgAXE872RqMD
         YhOml8CWZNu3XzyrEckJCTDxndyLImpdSkTvhXVQeA7fx+KUhogxOECrLOEcwYipWP0J
         0BGup5typtZzES/6lhHQ0vwveTG08HVi35R/SldlxEov59lA0xBjHPjZs/Deor7zyoZX
         8mHvVGmEuZbOrLlkeOvKVeA0vYWFYcS5y8gE/7uBXjn22XMZI/8K0BTX/gLjJONid7z3
         sgxQ==
X-Forwarded-Encrypted: i=1; AHgh+RowfUVskEUqUbU/aNZD08lr2Q+PS2WP9s/qiMryugTtXtrPsBatnf1NI6OzweVnVPwmj0vgmjzdEkyz1IA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRkrOYq9KWArCrB/7q9UYATH7wsthb6TAbQrpr3npkLoYd6hkX
	x3Y0tCqq79nfZtsEZkuQCz04cD6hRBaotdSInfMv/bb1WsYjP9ksAWeN
X-Gm-Gg: AR+sD11c54AiHYBWns+fpG+7FzF/WcsDY9UZTsEKbejQqj/6lIZWviEK31lEYsFeIyT
	4IsjRMwAsKJWEDnga09NcQMksz6q6nPpErAYGNTVFzLwXHiNgb3CRxRKhYC0/nPXaWprxoTs2Aq
	5Z5Uq2idsOyh2Bukkms5jJcLChh2fL7ZWPcw2AmpHPGDin4ZV7q9TVHLBsOL05kqBJ+xZ8wDCQk
	P/gQzLQ0kMe5z4MW4i74+GwIWVXfJjje+lnH+rKR3gOXzhanbqkoWIxMP//M6x48eFYRTHX2S5K
	NVSRaO1A3636E2JMG7i7RU6/hNvvHgvKuRyIkciPWEP52QZfJVEIh6bDG5I948HNug77de3dPv1
	qAPA8uifmeMDKuCZXnR8T5Wx2bKM94s43ZcwB8Rcd9TrV10XooXU4NMn/AVgwfrsKpVi4De6KPp
	8bZjmHoTyABqTWFkLnCbqkNT7HsIUCFuFRrc6Hq/ngIbsZbm6L
X-Received: by 2002:a05:6a00:2e21:b0:848:5ca1:bae0 with SMTP id d2e1a72fcca58-84e2bb3728fmr677188b3a.42.1784756698735;
        Wed, 22 Jul 2026 14:44:58 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm1946297b3a.9.2026.07.22.14.44.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:44:58 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Date: Wed, 22 Jul 2026 14:44:29 -0700
Subject: [PATCH v10 7/8] accel/amdxdna: Use
 hmm_range_fault_unlocked_timeout() for range population
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260722-hmm-v10-v1-7-606464dd601a@gmail.com>
References: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
In-Reply-To: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784756683; l=2650;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=Js9Z5fScNTLs9yZDEPq5MMQDWBFdccrrYdkvKMfBR0c=;
 b=OvUAdAx0y7f+AZFnN5LSfteCYnBEUqdMQ1drzLwHbqAw6OKXvHLZibJ29BghZSxMaAsL2Igct
 7dhM0ZwBa4kCtizE7Rk+AH/sCkM9/0Xx1LPVtAK4e1kYz6EQ4qhx7vD
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

