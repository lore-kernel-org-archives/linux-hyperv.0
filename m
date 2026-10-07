Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D619E4E3ED4
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400167; cv=none; b=fxFKsUZjuoGWZj4uzDZ1BrGgzqqDz8XxiN9H5sZcMxaFWpGFA3vuT3TPmrYUZNXzNwoOlvRpvO0OcO3woPIQQU+37rUL7X1AvkhreyXfvTH7VtbSy/jrUgxLOqKje0nd7Z3zG6x+PPAltRmI4n6fDEzmJIzVVu4m26ECwRKYzd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400167; c=relaxed/simple;
	bh=vVSqOGp2wx/0qJVjAsSbH5oTy4Gpsm8b9+BCotcy5AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPfod6H9JlXtBKBHHj/jc5QrLurXBGDKNSJ/mz8LItiGRLkKhF8R+e3WcOblcyTXkncaWQrKHAq0x2mZk5kAfC0sSPSAXBCN7pBdS41nvaBbulnQmpYnC5+fJZKyJWxarWB3Bf0/gLMn+IF4Gsu2k93rd8fXA5tReeRNZtFtq1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UyKU9oV/; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UyKU9oV/"
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-98febe968deso217371241.0
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400165; x=1792004965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3XGvHahoLRouhu1JIBcDAOTwzFgHXehCkZsR1IWSJgU=;
        b=UyKU9oV/Skj6omKIj79jVBpXFg+ATjDAhM9sqCUH9n7N5aK52iQU92wyj/ba8d5V4A
         S0zg7dUjAV6GAyUZWdQJaly3O91FpSYaNiL+BIO05/eGEEU1aA0iY18E5QjhonwDRVqC
         2RNfUEvuSB58m5AxmJlT2oIdzZXLYabSU8gb4OAgmFCwJ3cOcQjEnW9xeW5yhGJ6qk0+
         NOkBOn7Yx6d87Vuen2T8VFNR1vRfvw0/OvpuXf8DIiOUgG0cn6v+5sW1logY/xmMAN7V
         10Mza0jE1vixG8/LbiHHKSr3bqIH9aS6Ct27KVNk9TvCcFVJe3Houcp6+C9RQI+BqFKP
         JEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400165; x=1792004965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=3XGvHahoLRouhu1JIBcDAOTwzFgHXehCkZsR1IWSJgU=;
        b=V2sjgGuCNZhFcYgX5XQ2O+qTQEOw8a4lqUC+puQffsbq8BT8SDTntymr6AV806RHC1
         0JPQRp35uJLCSiwZu5Ql8Gr7Xt21KiSCYLl7bnQ87S5tFXVRxzd0EYgABpeIstwOUo7P
         u6uzDP/QF9qjkl9PVubsPfAATqXN8xstoIETB0Sed5e4yIBYewi1eP2PNydl8ofdHasl
         0YCsXOf/6Wtqdzf3n1Qkl5tcPeotVgDhNw0D/B23RaLsKG+rhbwgqP+20nSBAKrbsZRR
         /VW+/LWw9dz+SusxzVZWQuTTqsRNG16sF/yHnnl8aMpaPEBk+xamNm5RkM+TaJqtfxRe
         XemQ==
X-Forwarded-Encrypted: i=1; AKwUvBzDqINOIuuDIG8IKKc4aNIcxvkBGyc98ZVwQKC9wo1M5Qs/jjwwXNlGrCLEww9c9kJrMsRU01FMicfOS2E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLPmdoY2of25XB/3vZOr8lOLIi5yIxIue9f7m8eVOG/RWolQVC3
	5ztwP6N+FPq2vtpjRzdkEIpROCeulJC/RM9PybQOxdtf+o4etrP4OKpl
X-Gm-Gg: AYBFou2V8sRUZJQLnzpPD31xs/6vlZFGr9GdfNV8BgXp1ikL5xNQJCqENpOmuG70ajv
	sj6F6IvQCQA7Uh12IQeoXzxrsJPF+oU1jiWKwOC6rERFadxpiPPgiLwr9VpUDrWid5AU7PVkwRR
	7NU2pRrelM3qcKWprecT2M98OVQLZ/KpY8iyFUYlGC7btXlGRqvSEKr2S7ZLj+3Txckh7P4RfGX
	id4fLtPxsEtRluWlRdbCU2CuDJueTZHydwUYrDb+SFHCcabpqgz8ysFFZ0KlCrCP3zoF1gPYLfg
	ohb+5edFVltKNJQb5b3RpT/R+1uOg/2CnGM5GvSn7JZsSbvkofXw/wma4BzPvRxwDms1DKirmG1
	fP5GpLqYtc2c4hJd/NUwvEGE47g7uHW++Oo3AsWT+qx28zyodGXtZr5/StZquAg9fKof/Z07U+i
	BoR1hSc/9oYb4ZiHBdXE3i3rBUlMrnijkFslUlmyyL3z2+K51/HLm6sAoM2Kd5IbRFYoz7HblwD
	0wtsYkKUNzRHH+1/tI=
X-Received: by 2002:a05:6102:688f:b0:7bc:1de3:39b0 with SMTP id ada2fe7eead31-7ca38f28c27mr1016377137.32.1791400164748;
        Wed, 07 Oct 2026 12:09:24 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:09:24 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 14/14] hv: netvsc: use kvzalloc for device state
Date: Wed,  7 Oct 2026 16:07:52 -0300
Message-ID: <20261007190752.336426-15-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

alloc_net_device() allocates the fixed-channel netvsc_device with
kzalloc_obj(). The runtime fragmentation drill reaches this allocation
from netvsc_device_add(): windows-2025 reports an order-7 allocation
failure with about 99 MiB free, while windows-latest stalls at channel
open until the guest timeout.

This object is guest-private control-plane metadata, not DMA backing.
Use kvzalloc_obj() so the allocation can fall back to vmalloc when a
high-order kmalloc cannot be satisfied. Zero initialization is preserved.
The RCU workqueue cleanup uses kvfree() to release either backing.

Rollback trigger: revert if channel setup fails with vmalloc capacity
available or teardown leaves netvsc_device allocations outstanding.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/net/hyperv/netvsc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 0d017f836b9e..8ea7c993baac 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -144,7 +144,7 @@ static void __free_netvsc_device(struct netvsc_device *nvdev)
 		vfree(nvdev->chan_table[i].mrc.slots);
 	}
 
-	kfree(nvdev);
+	kvfree(nvdev);
 }
 
 static void free_netvsc_device(struct work_struct *w)
@@ -171,7 +171,7 @@ static struct netvsc_device *alloc_net_device(void)
 {
 	struct netvsc_device *net_device;
 
-	net_device = kzalloc_obj(struct netvsc_device);
+	net_device = kvzalloc_obj(struct netvsc_device);
 	if (!net_device)
 		return NULL;
 
-- 
2.43.0

