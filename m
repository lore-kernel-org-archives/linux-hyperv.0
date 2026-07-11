Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC672D595B
	for <linux-hyperv@vger.kernel.org>; Sat, 11 Jul 2026 15:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782394; cv=none; b=oywPkVfx0rWXW1L2z5SOogKdj2ku8z43qXtFTN45H9xktvZ0CIzJwz3oW1iyKuMYCVvEe5xHc9GEi7fWE4ypC3sK/ZUNU/EBXrxpRZnAL+BTid+ixLBPuBEkjr74oGQi9lf97mkzC32OdKkNQLae/iU93cEDqR0ZBNMAZZ57lSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782394; c=relaxed/simple;
	bh=xfd1Qij55WSKgMYmH/iULiROavfzelZy0Gq6Ktbvt4s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X7LD5972j379NNLn/iLrzepqMi+nl73pKT2IxfsfiZKZ79CeT8fshS5vKuM8uZ+shiBPsRG+njdhZPiQATTvIwpjQ8DlkjcfnP9HmaAUulzrQY/7EF8wcxS0AJkFd1psjEAgR+Ogw24uNA2riQ6AdBwnyPTzg4N7Z6IQbOKtuuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RdER+N6g; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RdER+N6g"
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-51bfe810293so9835311cf.1
        for <linux-hyperv@vger.kernel.org>; Sat, 11 Jul 2026 08:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782392; x=1784387192; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XSPQ4s327xjju3OZzaMxfnUi+7xam88AtuluAZAKUPI=;
        b=RdER+N6ghm5RpSKKvj+gqtJxRBfPmMkBL8fMv4K6APpV1kKcCcxbKfb5/4cKDFpTtg
         FwCU4a/ts9PUK1uxOiASMqHWAPZBj7oCY5/VG2TDLeMgcFI0F3pmM6OehTWfJxlWvWmA
         ah3CqWm3AK/jmu2R6lJVPtlaj0PmN8hka8eK+DXUa/pVcf1fygS69HwuV4pENMFmziC/
         xROgyWzftvniM5Q86qCuKbjsmDvx6lx9HgEXP8eicWeLYRGBw3muIhXTNrn1ja2P5Q29
         q7vDzGqm5U8rmfAtaCRZJOwQdyAKP+Mx1n2TTczKw2aLxJHKKOem+CC31ZLhAyYd/enM
         slUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782392; x=1784387192;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XSPQ4s327xjju3OZzaMxfnUi+7xam88AtuluAZAKUPI=;
        b=tMMGk7S75FedquKJ/18Jb0fcTMIaXgfO0xsqs3HP5ahvR4XknizVY8Qx8RiOxEZek9
         WKz8g0pCfzg2FRM7PbPk9xGO1w+FiBsfl4qCqpdFeuvsdu5s8V/pKBemCmJOdUaFRhS3
         S5L6djDbSES8PkVPLnX/5eogDEilAkn9EEb8CXP3v1V3qo+gyJ92nm1THVueTUnrowBa
         6DBQtT3o8nl0EnOLYLyut9MwiBSXcoQGLehc/I+5yDbKg2EYLfNNmr6Kfi6Hes0VjxMo
         22+OynBnXc0JHouva5lZ6p+AlmyyLaj1rk7vjsukdlFIdSVbrb2XyPJuG435TbklssX1
         K3RQ==
X-Forwarded-Encrypted: i=1; AHgh+Rqh7TYSRPTyXdFTtbe4D9oTi2KhxEdV6QP2l26MI/AIValXKmowhXIktmvPZzBWM8yS0IW/f34R2J2XwBc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza2b4AH8FGLvR197c/F+1/U4HUKTVL1rWr7JF5l+X42GFlaPpw
	lM6gAjmpo3JYxqlN1HVaJwbm/gQYDYFeg0f80bUbI2GeVM4T8sg1h1C1
X-Gm-Gg: AfdE7cnBLHqpGpTlB1pQQEVmNmaOhPhAAb4oHalt2HFIsRL+dymZmkf/Hqvdr2Y5TjJ
	3ha/lGfdoWLxhX9R1pb2KlFLYTHnf+JajHZGSsEk2fJ9emNVQQFsSE7TEYhdaTC/JmtIWanjA/o
	7dNMfH/w8nLjAIw/hR6cw9Udq0U4q2jQ+12n0BzVkr+x6xbbQnQlHHAQpPVwfLYx+RGgQa2GDC1
	7qKJDL8qT6FtQ1dbWuZKwC9VEFKYU4riP49/qJlg1AxNrFandva7jMIMUDJ2t8SsqoC45JTGSHQ
	xaxe2xEYS0iga4hymj6fz2eEa+p2/mUMfZiVCOCTVP6PngTuLuuIEiPZpOgrUXWjjRlKnl0meO9
	nC89t4hzyh+YoYSRMCm7Iok9v/zb23NDheF+MlLoHkGky1KAJ19UUP7rB2thgIsH/Liu62+HbWL
	LJB1nANGRHi4nrx5CEDx2oUhVWZgwvbm55zUlL3Sus1Z5+cDYgjcyI1iJvdJ6Ow94bGp+IWU9fG
	C6n4BGPhw==
X-Received: by 2002:a05:620a:28c9:b0:92e:8e36:32a7 with SMTP id af79cd13be357-92ef2c7289amr321690985a.68.1783782392025;
        Sat, 11 Jul 2026 08:06:32 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b88a38sm465793285a.12.2026.07.11.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:31 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] net: mana: cap HWC init max message size to HW_CHANNEL_MAX_REQUEST_SIZE
Date: Sat, 11 Jul 2026 11:06:28 -0400
Message-ID: <20260711150628.2914205-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

mana_hwc_init_event_handler() in hw_channel.c stores device-advertised
HWC_INIT_DATA_MAX_REQUEST and HWC_INIT_DATA_MAX_RESPONSE values
without bounds checking. mana_hwc_alloc_dma_buf() later computes the
DMA buffer size as MANA_PAGE_ALIGN(q_depth * max_msg_size) in 32-bit
arithmetic. A malicious device returning a large max_msg_size causes
the product to wrap, allocating a small buffer while laying out
q_depth request slots at the unwrapped stride, placing slots outside
the allocation.

Impact: a compromised hypervisor device model or malicious MANA PCI
device can cause out-of-bounds DMA buffer writes during HWC channel
initialization. A reproducer is available on request.

Clamp both values to HW_CHANNEL_MAX_REQUEST_SIZE (4096), consistent
with the cap already applied at the channel-create callsite.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 drivers/net/ethernet/microsoft/mana/hw_channel.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/hw_channel.c b/drivers/net/ethernet/microsoft/mana/hw_channel.c
index 48a9acea4ab6c..a0916b50cffce 100644
--- a/drivers/net/ethernet/microsoft/mana/hw_channel.c
+++ b/drivers/net/ethernet/microsoft/mana/hw_channel.c
@@ -152,10 +152,14 @@ static void mana_hwc_init_event_handler(void *ctx, struct gdma_queue *q_self,
 			break;
 
 		case HWC_INIT_DATA_MAX_REQUEST:
+			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
+				val = HW_CHANNEL_MAX_REQUEST_SIZE;
 			hwc->hwc_init_max_req_msg_size = val;
 			break;
 
 		case HWC_INIT_DATA_MAX_RESPONSE:
+			if (val == 0 || val > HW_CHANNEL_MAX_REQUEST_SIZE)
+				val = HW_CHANNEL_MAX_REQUEST_SIZE;
 			hwc->hwc_init_max_resp_msg_size = val;
 			break;
 
-- 
2.53.0

