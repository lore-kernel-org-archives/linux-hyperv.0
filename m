Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793588282;
	b=4n3zcgMq8JZEMVBznTHVHY7g77e4lnbDYDGDgx8bl9LTVguOaY+BqvHQEGmEit2fdJUR
	 wI0klLzhrKdCcYcOVCDqayriBk0AlheGA1MtIpmqxEG1KP66uc1U7jZUoXZQC0h3thuR2
	 VRjQin/tRVP0Vz50/hBTQP0BVnfCWiL0vfpNzroiipWMI9h+hIgfJ7x/u+1n/0B2Q9BAn
	 +qIGTttdHSjFqJW3P1PEMxJ4PTyzqBhNXM6UWJCV7K224TUJOdUFtAwWenVdb6dvMeiCE
	 RxKpCoGEPBnCdbjtvhEq0ZLiOZS47YUac4zXOjGqGas+CryUBm6GnD77+pJqyo9jOAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793588282;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=i6tZUO8XBhTDjKD1jpOy09iINxG2kNUDkhNJoZ9/I2c=;
	b=3Ii4HItTFEaY/fw5OBmTeUqCzYkqC20voeHPIr8t7uRmah7ko9a69oZ1+l8LI//ga+mM
	 8dx7TNP0kmLfhzR00Cl4D2BuXz0MwmYseLzrXNojd7MBUqOMOBgGanTqUabzFE+nbeMKL
	 A2fFB/NhlGKBh4woZr4R8UKZ0Kgzim4PLSZloUQGiMyzNjlmJSUD4PU2yVQdotcUj/QO8
	 qTCss58Y6ahqSv0Yhw1JxSL7d4Fi0Sm9b0o6KUEhq004jTSzoT/Hd29JroPDD/fPhEpUP
	 fc+P5g1QJLjU+3JjEh+nSDKksBr/+RSngoJi5SajW4GlqXMEQTiJnet7xOQUkRSeRsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=obRqk5EW;
	arc=none smtp.remote-ip=209.85.219.53
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912F2606A324
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Nov 2026 02:58:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 912F2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=obRqk5EW
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91c19fc50abso33848046d6.1
        for <linux-hyperv@vger.kernel.org>; Sun, 01 Nov 2026 18:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793588280; x=1794193080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=i6tZUO8XBhTDjKD1jpOy09iINxG2kNUDkhNJoZ9/I2c=;
        b=obRqk5EW6Wtir5YMHsX/clzkm0ln5rDOJ+L5AfkfafhprKqOqK091VJRtrJHJlhVVq
         mocUZDz4cI4cQ4xyC0vlfk7XwbypEeD6urqi6o9SygIhqvZeeY39lVUr9WGoWuY44DfH
         jWBU+qN4NfeZImUJOCYCr1Hq8KQTNOvP+9nKXeYKjm6jJ9jVyDFACcXD0316tsQ7tPrd
         hnOHh2d6nEHzhFPvwTTJZzkSSUXtSNrQaznb86CaXgDJ2PsjdxAzLITv6vxgYLDd2D/h
         2UaGZ0Psp/jlZlRanm8+M2sGO2k8OZBTMD2Qj7OKrws6gGohs6eFwRRPbhM5WPc3XSSu
         VhPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793588280; x=1794193080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i6tZUO8XBhTDjKD1jpOy09iINxG2kNUDkhNJoZ9/I2c=;
        b=xGt+UC07uSLQI7mWgadDgFz9yBdRmnm9aiaOGr9e6t/T8hejxTPM4WoJe6YOPXMZZG
         HpY4kknE77kd8Bb2FpMPfOL1Auxu0TOUSkM/PuOXt28r3uoiJ6l78ndG5RHlcn3YVpoD
         coshtD62H1rzOeiFkqkt43oOvsd3cEhzKL4f4QJPeHCi2lv1abbctPiefrsnPYL+J5Dg
         fCbk9g2w2JLwYblQdlo8YUrXWxmdcbB+QsE+Nb/aPftfCLMFIwBVuRKKbyzH1AcuuPOA
         f3LQBselNCZ5+jQis1jeiwyOmOQfu5gSgGtpbOz0lBnKBng+kR1fdSJQI0VmO1zmyA4m
         pJ9Q==
X-Forwarded-Encrypted: i=1; AKwUvBz6nr5GO0q4HDlIvMt6B69HDhihHCpAXsAxRDBQ51ibkSuy0mXaIai4LpaKfisn6Vk44iElYDowQdDsDNE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z2RYuqAj1sfcC8Fz4cAvgm6VAe8aiTC3kESnHwDyZUEA5/sf6
	NSYiLyrXm30eMxcCIde14XzL201R0y02zlBKX6GrPHp479uACyFNd4Jc
X-Gm-Gg: AYBFou0FR+kiHYVQloKfo0Te/JFu7NMTz0ebZGTX9XNje6oKS6s9S9roN3G/Ua2gqJD
	GopfccIKsRmRSrtCYsNRboIfK9F+7j+KQbm3deAgDWSTJCcIm/o0FMpcgpaM2nTmW5my2a24Q91
	HLqAfUAs2RvsvVtfpPzihJrx8N4xAiHp1eXdC41Y2yVC4CskfS5cVxiE3Ve4ieOh6EuJfzp6fr6
	DNc3ZeQ1Rnz2McCpryW2uQ9azBC/IPUg8J2d9lmm9GvOwi2x1pnXBqG42VtBBlPiZZksHYmPHt+
	W57wP2vB5aT6wg/li7EjxdTFchu9gJPpW585SY1XqBwc2yvcUtFOfnZbfJT3Y/mGa+hA3w8BdHJ
	82gtBuNv4z2rPM+/mb+FpaMn0pE5THdUw+Mym1meZbVCQj/a6EtVNn5mITo98z6pDDA+tr3JPOB
	obqLb95tuJ5ZP/4BQxbugYl39z5m5hWe14bJhGe6T1fcPBg41hmAy3k1fhwJCBUg3cBdpuxUMo7
	72WUbAFicMBa+ZZNMqD6NfN4lfZJsk4Sp/26i9vIpjdXqYoXbOYLtl72NLkco+oNrAgmNo4HYZW
	phfR7Sgg0+QSQt25ZYP7PfL2R0p6g64FD4NLEhnshlByrir4CQTp
X-Received: by 2002:a05:6214:40f:b0:91c:5f4b:d2d7 with SMTP id 6a1803df08f44-91ca4b6d8eamr145818826d6.47.1793588280310;
        Sun, 01 Nov 2026 18:58:00 -0800 (PST)
Received: from i4-gl-tmk5904.ad.psu.edu ([130.203.156.186])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca7e23b0bsm79658866d6.2.2026.11.01.18.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 18:57:59 -0800 (PST)
From: Yuho Choi <oss.patchbox@gmail.com>
To: Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	Tianyu Lan <tiala@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yuho Choi <oss.patchbox@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] mshv: Don't free overlay pages after a failed unmap
Date: Sun,  1 Nov 2026 21:57:42 -0500
Message-ID: <20261102025754.257856-2-oss.patchbox@gmail.com>
X-Mailer: git-send-email 2.43.0
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

On L1VH partitions where the VMM can provide overlay GPFNs, the kernel
allocates the VP state and stats pages and supplies them to the
hypervisor as overlay locations through hv_map_vp_state_page() and
hv_map_stats_page(). The hypervisor may write intercept messages,
register state, and statistics to these pages. Only a successful
HVCALL_UNMAP_VP_STATE_PAGE or HVCALL_UNMAP_STATS_PAGE confirms that the
corresponding overlay has been revoked.

hv_unmap_vp_state_page() and hv_unmap_stats_page() free the overlay
page regardless of the hypercall result. If the unmap fails, revocation
is unconfirmed, but dropping the driver's page reference may still
allow the page to be returned to the allocator and reused. A subsequent
hypervisor write through a retained overlay could then corrupt an
unrelated kernel or user allocation.

Free an overlay page only after the unmap hypercall succeeds. On failure,
leak the page rather than return memory that the hypervisor may still be
able to access. This matches how the rest of drivers/hv handles pages
whose state is unknown after a failed hypervisor operation; for example,
hv_free_page() leaks a page that could not be re-encrypted. Log the
leaked page in both helpers, as some of their callers discard the
return value.

Fixes: 19c515c27cee ("mshv: Allocate vp state page for HVCALL_MAP_VP_STATE_PAGE on L1VH")
Fixes: d62313bdf596 ("mshv: Introduce new hypercall to map stats page for L1VH partitions")
Cc: stable@vger.kernel.org
Signed-off-by: Yuho Choi <oss.patchbox@gmail.com>
---
v2:
- Also log a failed stats page unmap before leaking the page (Wei Liu).
- Rebased on v7.4-rc1.

Compile-tested with x86_64 defconfig, CONFIG_HYPERV=y,
CONFIG_MSHV_ROOT=m, and W=1. Not tested on an L1VH system.

 drivers/hv/mshv_root_hv_call.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index b8d199f95299..e761addda50e 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -643,8 +643,18 @@ int hv_unmap_vp_state_page(u64 partition_id, u32 vp_index, u32 type,
 {
 	int ret = hv_call_unmap_vp_state_page(partition_id, vp_index, type, input_vtl);
 
-	if (mshv_use_overlay_gpfn() && state_page)
-		__free_page(state_page);
+	if (mshv_use_overlay_gpfn() && state_page) {
+		/*
+		 * If the unmap failed, the hypervisor may still be using the
+		 * page as an overlay. Leak it rather than handing it back to
+		 * the page allocator.
+		 */
+		if (ret)
+			pr_err("%s: failed to unmap partition %llu vp %u state page type %u, leaking page: %d\n",
+			       __func__, partition_id, vp_index, type, ret);
+		else
+			__free_page(state_page);
+	}
 
 	return ret;
 }
@@ -995,8 +1005,18 @@ int hv_unmap_stats_page(enum hv_stats_object_type type,
 
 	ret = hv_call_unmap_stats_page(type, identity);
 
-	if (mshv_use_overlay_gpfn() && page_addr)
-		__free_page(virt_to_page(page_addr));
+	if (mshv_use_overlay_gpfn() && page_addr) {
+		/*
+		 * If the unmap failed, the hypervisor may still be updating the
+		 * overlay page. Leak it rather than handing it back to the page
+		 * allocator.
+		 */
+		if (ret)
+			pr_err("%s: failed to unmap stats page type %u, leaking page: %d\n",
+			       __func__, type, ret);
+		else
+			__free_page(virt_to_page(page_addr));
+	}
 
 	return ret;
 }
-- 
2.43.0

