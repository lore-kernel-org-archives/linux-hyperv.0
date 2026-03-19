Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB39D3FB06D
	for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 20:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773951951; cv=none; b=L4mEbugxkNN1AGIk54UTihyJz/QlDXkDQlhTmzxEv6ZrtqqwbCzMm9yNQtZnI/eHVcP7eFm+GoK7sEnWojwerZ8HNaIgJqEY9gbHIhc7J4imZTUiGyHbLwFC/vI2AHqqDO1A/QrIlrA4fqsvd7m0T44nsvsG7ekUGI/HNv+y8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773951951; c=relaxed/simple;
	bh=8pci5keNCSZIRItQgwBd9jTB/soEr+3j3n73ramG7Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YeuDw17BJ2BRbzlAlVavi7p/iq17Pb8snMv7yHw1FeYbqftwEDy1u/ajXfuMrxJ89v1BkerjvAA/NJZ8rSeZUKSc6EsarGt74xUp5dTNO38R/czoVoRLJrLFJinr9iQe7pFRsuUhchFyjAvSqLFibhpvSK5m3ziR+nXy6sR2/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f8D3H2q/; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f8D3H2q/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-439bc14dcf4so1709822f8f.1
        for <linux-hyperv@vger.kernel.org>; Thu, 19 Mar 2026 13:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773951947; x=1774556747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t30r0nJLZ+XoljLbUI5nWlW+9TZBNz/klLk5d0iuzjM=;
        b=f8D3H2q/DYz4fgI+MJgFdwQXlBRDylqxSM6zjV227Xbpj8CNRpWMredgnrrhMwKBEQ
         +R/Dmk/ZPhW6cXJQsu+LeJgy1bJu/eY2mOCz422dEG4OZITrByBlgFl5YjausggbiNjK
         rUVKXbTvWk1ckqH4H4Tzo2o8QXWADqKRRuMUXVZ8I5T4iSLCVzqwQ+P4u/jMqF6x+Ttc
         Wp6uHad1zUwAOmUcQtnHA3N3Us4f5xRrr1SrlFFQdDenx+UhmOazK34k9NuC9fLN+ksi
         GKQxHDZs200C3L6xg2w3ba4UFnaiTUIHsPzfz3FLD7J24PhTLE09guXWS1DpNmynPk1C
         bR2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773951947; x=1774556747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t30r0nJLZ+XoljLbUI5nWlW+9TZBNz/klLk5d0iuzjM=;
        b=omhnPsEx0Oyg76FpnDVIAlE/YeBu/3m4Tb00OTb5F0dHBJjGc8Ktp11ePYSymtEpCm
         VpSGRGx6JkccgqNQ7sAsuvAgzDxjJ8Stl8P2h/TccG3JPwqjeFgb98CAKydwSsg+YDfU
         Tbs5GqYMUUGuwJbfbuInqAN1iD7W9ynevpPl+LPNWaz2Es/2p8JH16nxqZqGeca7JOd9
         rZA3W+FWkYNpqVjy2XeZHI5rYiOJqUFi9DcvNVISEuSQUz18ko8x9mTNSpGu0OCrF7Zn
         18BVUggPZJuewLUlvkXcM2MGNYo5hHjmCzaRU0elDQoZT6qYSDAH4aQTeqA5ItJ638nA
         sodA==
X-Gm-Message-State: AOJu0Yx816Ges/zj2Qz3O+QAUhETtzpyJIcKouIZXp4Uj4zyU/FU9UBX
	+SHRnk3b4a7ipVAB5q1Z6PGct0YfIHm+t8+7ymmSs9yG+GW5/VMzu+gSMe9+nI5BfTM=
X-Gm-Gg: ATEYQzz/lINAxi0zgIgElH21za3ghlcQgd2hN8wnnqnlXE52PDb5xZzYAJPUQ2FoI8p
	qNmnUhtfdhOCWOWa5lRsYQgPUxKM5nwXBF/LkCIaS1ey2EtD3KV6EahnT3TwOVVmuhk8DWUFUbr
	ciFJgbv0Y1Wfc45Z1/aq97oDTJT+JfoCDYDTKRWar/JGZeDjNiNtSY/QMKtY7fWLfqLQ7Zv98OA
	TKESIM76sJHgGPslNW/ru7J/OVH0izytmJwQVrxq3nMEugsOniP+rBAoMgljCTTOZtGm8f3psfp
	Abj0Qs7pNpV3bPDdGN3KeLUCVs83tbD+Ssi5DRTjezOej4m+LWnVlMYjfKOt0q4lz8ukwj3GVCJ
	+A5ih7y3bzSqdNRHUXexylbBCRu2VcGE7tbaqL/Uxze8AJiFQGsXOppycBic8GKp84s5GQcLvE6
	yfPAaxmwVFIU5QWMJE/iFVb8WAi+mIfnNPf4pKK7pe4xeh27dy
X-Received: by 2002:a05:6000:4021:b0:43b:566e:fad2 with SMTP id ffacd0b85a97d-43b64242eb2mr1508120f8f.9.1773951946802;
        Thu, 19 Mar 2026 13:25:46 -0700 (PDT)
Received: from LQ5W56KC4T ([2001:8a0:672f:7800:e0e1:55cd:f0b:b1e5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b644ae16fsm1347544f8f.8.2026.03.19.13.25.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 19 Mar 2026 13:25:46 -0700 (PDT)
From: Eric Curtin <ericcurtin17@gmail.com>
X-Google-Original-From: Eric Curtin <eric.curtin@docker.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	iourit@linux.microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	haiyangz@microsoft.com
Subject: [PATCH 29/55] drivers: hv: dxgkrnl: Removed struct vmbus_gpadl, which was defined in the main linux branch
Date: Thu, 19 Mar 2026 20:24:43 +0000
Message-ID: <20260319202509.63802-30-eric.curtin@docker.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260319202509.63802-1-eric.curtin@docker.com>
References: <20260319202509.63802-1-eric.curtin@docker.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Iouri Tarassov <iourit@linux.microsoft.com>

Signed-off-by: Iouri Tarassov <iourit@linux.microsoft.com>
[kms: forward port to 6.6 from 6.1. No code changes made.]
Signed-off-by: Kelsey Steele <kelseysteele@microsoft.com>
---
 drivers/hv/dxgkrnl/dxgadapter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/dxgkrnl/dxgadapter.c b/drivers/hv/dxgkrnl/dxgadapter.c
index 6f763e326a65..236febbc6fca 100644
--- a/drivers/hv/dxgkrnl/dxgadapter.c
+++ b/drivers/hv/dxgkrnl/dxgadapter.c
@@ -932,7 +932,7 @@ void dxgallocation_destroy(struct dxgallocation *alloc)
 		vmbus_teardown_gpadl(dxgglobal_get_vmbus(), &alloc->gpadl);
 		alloc->gpadl.gpadl_handle = 0;
 	}
-else
+#else
 	if (alloc->gpadl) {
 		DXG_TRACE("Teardown gpadl %d", alloc->gpadl);
 		vmbus_teardown_gpadl(dxgglobal_get_vmbus(), alloc->gpadl);
