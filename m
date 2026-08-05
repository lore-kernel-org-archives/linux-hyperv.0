Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B07441F5DB
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962286; cv=none; b=AqnsACFWNSOgU2ghhJgw8i9CLU4PhvFu/F1LcjeYHNCPOrNAB0+ZCpOaWSGvAKRR/danLEqyWlFTxxLbMGNcJDpsmkdE4eF1Tp8Mh6O73VHd5k6w4OcTbKf/IhmQYEvD944TidHOmHQQr+f+RxoWB7fc9HOaoBC06Jd3hKR3ipE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962286; c=relaxed/simple;
	bh=UsrGlfHfBZ24s2mz89h36c6p74WT/yBuKhlLpP3iX+Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JxT3Y1o8aDGnauRHqpRmu53jlADdZ294ymhwIMjmKJaFL31dKCuhWlKgP1qJmHdeE8n/L8s5oMssyn3k2sSJkWHgZdHeGy5Ws2EmaRJ3B5KAyF3hQOt3TYDPWiK7RT9jEbtuFeL0hPVAc+ncupzTNy5TygOzaFcSHOx0yXw3KEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P2YcmqHF; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P2YcmqHF"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d0407aedd6so17334925ad.0
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 13:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962285; x=1786567085; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=khZbcPeOcWMayZoJtmII1zy3N0Hefa7E1I1impxoRQ8=;
        b=P2YcmqHFuHEbTn9z3bsvbPIemFouU/5/I33WtR403jfvLCfdli43RO2H+JfLNSo+4r
         XIhncv5WtaF1gUuwDGondLpez+EV8d0l1+5K+kqKTmSGKVoup/gZTSjXASs2VyQrpxHB
         QZOcaQGpU2d6R3PZZir/bbIoiQKGWTdIQMgceTBAyzpOBL585x+pjcg3yu72/erBxfG6
         ZKn2G1+dH4/l0mGSRWBVv5wGIInK8kugfyodBL51McCXfpRPCbe7sgOstSoaQxbD07Sh
         elqTB1rx4zUaMMS6n0wgbPaSuhnBLQeK1JJlwkYe8s+saypC7bW94n77v2VOfrQ0RCA8
         VDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962285; x=1786567085;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=khZbcPeOcWMayZoJtmII1zy3N0Hefa7E1I1impxoRQ8=;
        b=TP0Nxt3Q7WjZBENgYvoEX3jAyhm/b2rVxFQUR1+fLSEfCtGNroe3aoLAq877JLUzaM
         /VafHclx69pXYdMTIrPq0z7PbuDUDU411PCuemKDdX6b/3XDpIOjO0p5O5AHw0A52Ggl
         hc4LIDhS347Qbmhu2CnHLq3iRikOMsfpIrYSPfghYSFE+n8Qi/t+u3FSiOEb0NbBiJGm
         wsLplPuOKxlEBcNhUWimAqBJ7UeSmJEF8v0xqPHJrEahzZ1vl7QBFkB4npsI4f2UEqd9
         V7WUlrVCg4PxzOgBUus0WHFt0ilG7rlJVH/9FY/K1Ow2qjc/QpPJpt06m2exa+VntMa3
         Hx8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrlR2YgR/NNJMrC7ZLsXEBfwVHzZsHhbWcgOI5VYslOo1jFyRlQ5YZlLhIN4ihDdqVmcBYTAhl3ePQkamw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7LpLsFW55eRGlGAO80Fa3RGwp0y4bpTlskUNSXRwntNm4uIpm
	x8m2II4AcyXgKcjV3UWLFtlqkLwnpyd99qB3CCa4cQyMQFxTY58yVH1Z
X-Gm-Gg: AR+sD11uXynw852X+AI5j0QQAFbv7Xqm/nDqDXQR+kyodXdayitwb8GpZImJC4h3gEI
	TKz0OMiUjkFQm5tCTNFRSsd2C+6cQvrkBltYLJGZtH6oviA2Y7//ChaZXZH3PW02Qf4vcKFUXh3
	c14Ly4EO3ZNS3+ugxWIC49gQQ+TZ1q96qFcWEpXBTLBlthG27sASK4n5g9kE690L9nGPSwl9xuo
	413BWGiiGT1+6w0b+/vB6qIwBanXSQWeTRovb/Avdepvo+DbgbQTC6W76MKQFCzbNZ6QeA0Xl09
	w4CCOQYWXWfgRJObLMBslP8T6fZiZVzgvsjHKiJAG1JJXa89WOsLLhScx617QTdQNurCXuo7WuK
	86tv/89fATQ0oFNvvtdMi5B5LYdJQAabgPufjwChYZqfun8PPslKSL78BDmbcOeB3BcdsYT5amd
	Eeq3gYfpIEYYielvQwrl1qoC641RHydaxzloBQ8Ho3gNERCJQFUXWVG02s/4hWtbqVHMOOFsJ2d
	Huaj78k5av5lBw2uzuQEJkWwW6u9vLoaTWxxuoIPmU=
X-Received: by 2002:a17:902:ea01:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2d0ca70d2e9mr103696525ad.4.1785962284848;
        Wed, 05 Aug 2026 13:38:04 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm21372745ad.64.2026.08.05.13.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:38:04 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/6] hv_sock: Remove check for old Hyper-V hosts
Date: Wed,  5 Aug 2026 13:37:47 -0700
Message-Id: <20260805203751.2678-3-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260805203751.2678-1-mhklinux@outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the overall removal of Linux support for running on Hyper-V
hosts earlier than WS2016 and Windows 10, the check for such versions
during hv_sock initialization is no longer necessary. Remove the
check.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
No changes in v2.

 net/vmw_vsock/hyperv_transport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 5405c2680dec..855b15971c35 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -961,9 +961,6 @@ static int __init hvs_init(void)
 {
 	int ret;
 
-	if (vmbus_proto_version < VERSION_WIN10)
-		return -ENODEV;
-
 	ret = vmbus_driver_register(&hvs_drv);
 	if (ret != 0)
 		return ret;
-- 
2.25.1

