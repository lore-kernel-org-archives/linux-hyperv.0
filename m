Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E5D4BC001
	for <linux-hyperv@vger.kernel.org>; Wed, 15 Jul 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784139399; cv=none; b=U5ujpUut/6zXgN4xW6u1RXSNtbjxOGoCJOamffI8Jdg02tMjFg6q/Z7ZU8ywY4IG68rVwT+4cV24xuSj8uZXrAjHq167cAs2xcT0btN/M+UapP2KCsshKIoe+5qXLSbSDKbgAuYBOQ/FiFBhijy954yvytTacGKmrPEsCOvOYH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784139399; c=relaxed/simple;
	bh=WjbR1yYJvUnP6Ki/Ch1cSCwnR1/UzkvRzcRqts53AcQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NuCQFtCnyiQMUlEGwylDuAkk4B5RVVUPxky5CmX0/uMuzGvJL5PUxEEWxXE96M5B45twFOkKoiHsy8uno81eqB83c59tjOfrJxiFw8YpDy0tN/WBZv/z5MMF5d36mJ9JciYM32sE190IqgcQNaH1TgcGuUAsGnZjPUh2ukgxmqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m6TbMt8n; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m6TbMt8n"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2c7c61b5292so34908915ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 15 Jul 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784139392; x=1784744192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4IcjMhwypTXX14WXh1GVYxiUX1ayGU/csb6g5Y2UiV8=;
        b=m6TbMt8nz8qqpVH9SrEubmKEspUu6JhWcAApw1JPE61+7AWvolXapr4mB2nrMlYsni
         2tig5XKQc7+3FW/8Su2jrLSVrhUMM2bjhdAEHABjuHd6/+5iR0lzw7jqGpuyGbtCmP0j
         fbKiAYXs74bIoxYYeheAjWKRcjWNMcY0nxrr+6663ZWL4XSpB6s1VMvgYCPEUK0UwGyn
         ELvQyTwhhmHJrY7hBt9tPnbf426fiDdmz+7nKgOjjt/DRaH9Q1hBXmrq9Y8NkOGQ5/Lj
         HN4YpvvjcMqUQa8pwhNusanW0pp/pKhGNGSNHpZqpL4rHVklUxLNFQ0qbh7nU1jVQHkQ
         weIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784139392; x=1784744192;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4IcjMhwypTXX14WXh1GVYxiUX1ayGU/csb6g5Y2UiV8=;
        b=WZUAzQZSIIzKb6BCol0APCznmK7rZnmEU1BjrLcpQmnmVKNoRcXVomUL8jqnDWYzkZ
         ShMA0Im1wKttzMgZYziTBJ34BO5YCcIudDYYae0GmxMthUE7mLO7Ue9ik7Rv6/Rq+iPX
         UL938cHAREGb63gYtQ5GZnCFPZA64JD69k4T6etn19fsyuj3of+jLil0IYW44khkcFyU
         F8in5yyQ9H+rQaTLjwz3sag+sMyWTLryJZxyDUXWVD87X+Tnhy/yCqU2g2gMQ7oT1aQj
         2Ddul93zrn9SzE5rVlHOsqe21GhmAQQwSwV/POprWtJnUJM8X2VB+2NYmIa1eCID5g+g
         Grew==
X-Forwarded-Encrypted: i=1; AHgh+Ro/YMr6DQed1UOhZnowXmYFaYJpY2MO9rIo+x42ATDgfTJeLto37oHQrExwJXBZ7DIgmJizLqrdIcD0esc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg53usp/o0WCbn9ZrMZvuDVmJ4D4Ik722LCm0z088VdymmQD8o
	VPI98KaKs0uXvqvw1b5QjLxqzwoQp6+tBdq6sB0YKYih0U0klbn+wH5p
X-Gm-Gg: AfdE7clJ2ABQJfHmVlXjIT0xbf22MsfWvJw1ZV0bcabwL5YATYibZC+QKBHW+Nf/zpF
	QJuty4a6LZvKs4Zndnic8PO2b92+RnBca8aa1B4ZQHzg8jPPSWx6pnQ3KiNyFj8i57fBw16+/dU
	lJk5IxNwgB2HqMZLuW5195nhJutnrjhwAAiNju/9oW8jm7awO82RvuVIuIynWdLw0UEmon5LdAP
	e0Ou2jOn8Wxpzw9qPFUNoQaSHTUq2vqq0ngAOZzbRUQCPgoHd9L7OezxIn3lCOI3UslHW5kDg1P
	KNdYkAASxclBxjjfigqtPzDNFvboNeAlc8l2+FgpecC88+swnCK7kmrK7kBfI8H/Gg7uI/OgHvc
	jvlROmYi6a77i6tC7bj6ICB4/0wGweXSYBd7b2KmGzhBt7fBB2WRyvylt1P6P8uusozi8yfGb9o
	ogcZBmI1h0/s6q6oqIoOitrUfEienL4kg4YvlKwyDCj1qH/wgu+wNLZuK/1Oo=
X-Received: by 2002:a17:902:f645:b0:2c9:fc14:588f with SMTP id d9443c01a7336-2ce9ec0f95fmr181359435ad.29.1784139392357;
        Wed, 15 Jul 2026 11:16:32 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf100e3946sm6817295ad.4.2026.07.15.11.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 11:16:31 -0700 (PDT)
Subject: [PATCH v9 5/8] drm/nouveau: Use hmm_range_fault_unlocked_timeout()
 for SVM faults
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
Date: Wed, 15 Jul 2026 11:16:30 -0700
Message-ID: <178413939024.1155966.6246787744253724390.stgit@skinsburskii>
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

nouveau_range_fault() takes mmap_read_lock() only to call
hmm_range_fault(). It also keeps a single HMM_RANGE_DEFAULT_TIMEOUT
deadline across both HMM -EBUSY retries and post-fault
mmu_interval_read_retry() retries.

Use hmm_range_fault_unlocked_timeout() instead. The HMM helper now owns
the mmap lock and refreshes range->notifier_seq for its internal retries.
Nouveau keeps its existing absolute deadline in the outer loop and passes
the remaining jiffies to the helper for each fault attempt, so retries
caused by mmu_interval_read_retry() do not reset the overall retry budget.

Nouveau still validates the interval notifier sequence while holding
svmm->mutex before programming the GPU mapping.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
---
 drivers/gpu/drm/nouveau/nouveau_svm.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index dcc92131488e..58735446d783 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -678,20 +678,22 @@ static int nouveau_range_fault(struct nouveau_svmm *svmm,
 	range.end = notifier->notifier.interval_tree.last + 1;
 
 	while (true) {
-		if (time_after(jiffies, timeout)) {
+		long remaining = timeout - jiffies;
+
+		/*
+		 * The HMM timeout only bounds retries while HMM is walking and
+		 * faulting the range. This fault is handled by a kernel worker,
+		 * so fatal signals from the faulting process cannot stop an
+		 * endless stream of invalidations here.
+		 */
+		if (time_after_eq(jiffies, timeout)) {
 			ret = -EBUSY;
 			goto out;
 		}
 
-		range.notifier_seq = mmu_interval_read_begin(range.notifier);
-		mmap_read_lock(mm);
-		ret = hmm_range_fault(&range);
-		mmap_read_unlock(mm);
-		if (ret) {
-			if (ret == -EBUSY)
-				continue;
+		ret = hmm_range_fault_unlocked_timeout(&range, remaining);
+		if (ret)
 			goto out;
-		}
 
 		mutex_lock(&svmm->mutex);
 		if (mmu_interval_read_retry(range.notifier,


