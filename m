Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793824258;
	b=EILUoJMiRf8cQWHgDbfQQT+AUPuXIOX4QA/FZxQE/uOivjqXicJuxRvmm35ab9lsQxE+
	 OM1GZMjAtU43dL9iK+VFKkcVQ4DNNlVfzczuFZQrQdZ2PTY1RCWKhkf8lLxhFLSWCE1Ud
	 LSwpZWWSaLCpTBymGsDM7n20h1wjOxHFvmNLxSca8xtNPIwPWpCCNUz2LwGAF4tjVDeFc
	 fIZdQR2LE2dL+ZeFD8vjaSECaol4TnZ0Ja7Voq9oAJXeNKjJIgtKQ0ss1oTT4j4SrE3kC
	 LP5yAeaxWEXPYc7FtGJ+rh0xm+iZ0htoTCEL0ntRBrkPkCtywPxu/tvS7vX/vhZ5AWA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793824258;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=huPVslj+kM9c+WtCioU3Ljzu+t0gbVdPL3W1oxXh1oM=;
	b=uS+eFHQRaNAdOoDbHlUUi9j2s2fgQVoVZcXr1LFyMcXA9ew0rwKE6HbpNEOCkLbLJfTF
	 1F5Y1J39gaWTn34Lt+GVAhRtta8hPp0VF0MPw5kOx2o3+QOo6qvQOfTudn3KGXFTDqMNO
	 txwSP+1VbJ55hYmWAvwukp841QAv0AA0lPF3kdqe/t/1qG+/gVoCN4nEBu5vYnXR3bM1j
	 M9oSuJIJQNNzvTI36+t23ET5excqb9Pn7ZNsQlgARL0wiGksPVM8OjWbah1fZ9ZEtDi99
	 /E8ZxolO0XAo3ZC3GDeBk59XoO4GB8cRixJMKbfyg5AM4BvZBzWNV9TTCLs8SUGbNEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LXvS2106;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E17606AE10
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Nov 2026 20:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98E17606AE10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=LXvS2106
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490a0e72588so457288f8f.3
        for <linux-hyperv@vger.kernel.org>; Wed, 04 Nov 2026 12:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1793824256; x=1794429056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=huPVslj+kM9c+WtCioU3Ljzu+t0gbVdPL3W1oxXh1oM=;
        b=LXvS2106f7G3x7PVtW2Uc/j2I076hzP3YOxsuP76p3ihKo81neXfgxoLSaWA0vp3h+
         gWSdTzowhKTy6g5f0gIpElccxgYx8aRj2B7hEl6SVWOIyxPO6u5Ad1bTjKJlSelVHU3x
         1uO7bI2o6Nsw4ANPDdQX3Utt9eLr9hwcEl5g0+AKoOGU69CtkbHqDU5D+jJBkGGTtpAx
         jJz6OKIqx8DHqGm+vI1zjxRND6y1mwn9cbbb1xshHUv9acUPbjeh3EfMqM+CoXQS45ie
         H1fqZgQhvXZRz6rU7Y0Ib9iPzdGBJJ+Q+Oz4BD1ENFyvEXZi26Ji2irgcfO8yioZbvnt
         FtVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793824256; x=1794429056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=huPVslj+kM9c+WtCioU3Ljzu+t0gbVdPL3W1oxXh1oM=;
        b=qZfgJfNNBzReDIIZ+qmIFzQ2Gl6VQi5G7OELOj3yfCJCm/kfNRLsMfg+bpQe6iVnqI
         MzGAcZAIhjvBGCAWBniZ0J4dQLsvsulN0Ka/6fC+/eTHqlbEsPW1n5Hfsw1y56ep4h0Y
         yj3ia6yPVS5TtRgpr6SxAimek0loS+DKfkPwkFnlpp6yCSZPmH51bDgjCXP5Uj5iorDc
         1Rtx7+/4kHE63fobbDGGbD//J3oCXaabcosC7wrHuZP+CapVwrnT1SaL0CWv1zpcAQt7
         VQ07+6XyO+3HVvvLdQsHlB4ubVK5JexJatmbfKUKCB0i39OjG+URHwjewtd2FTRIwMKp
         p+Dg==
X-Forwarded-Encrypted: i=1; AKwUvBwiu1fYFygtQ3Mosr855ZWjKI8hZF+/qta9+mto8D62ifF+ZBiGINzj6CILSCxTp30Gl77umxIPTRGGf4I=@vger.kernel.org
X-Gm-Message-State: APuU4Z/LVtwtdqE8khp/GEp/2PX5lTz5m1gfUpm4yOQLjwsiUk9cRTqq
	B94MOjKVW7/hIPmncTrGDWOeLssMFEFq+rzOQaIJZw+E2mZehkm0DrHJGf8PD3L+LY4=
X-Gm-Gg: AYBFou37YZEET1F6SWfAnihjKYzFkzlXOHwxXMt8qQWFaWGIUyszsGKAUxvdCb88fyf
	r7EEKnvhr1YeGHZVwxIgeD7tHy1chQ87T61+9JuewKuyZefWmalniC+gfp0vilBsoD7hAIYHW/K
	ep7lL6knWtQkylGgSQureuwWN2jGYRcFoSiFbLvyzvznIk2BNdCoVV/Pe/cJ9ZIsE8stYdRx+DQ
	diK41K10qJ1rfJqTmC4pRCiFi7H/qay3v90sbqZWBca2PpjIKexGpx8me5xtHT6sdRS5ddvO0tH
	zsWNIzTMcd1gpbqpCBkujrk2lrqjr8bWTkPlfSW8xS4jnu2J76oKXKHUezSoWKK130jHLpjUrOn
	AxJUAwx0TvZSGzjIWH1bqT2PoOfDxujUyhtD7UnOqNgVdM2aE1pZMoy7NWNdHhDSlBU3V9Y5Iq5
	WGdc8AEOuelJ32HF++fjiu3zI+H+eifbti28YLWzbM0wBggiNdWal5++GEiuEEWiz8MN5++o3dU
	X0bKK8hGWzwvvUcn15I7zedmXYRNWgoYDgM3TlCFVE+o/A2CEk1osezbgyyQYj2Yyqjj8HXkGLR
	NoogaeLAO/3jxaFUp0QjtIsr
X-Received: by 2002:a05:6000:40ca:b0:48c:5304:5e50 with SMTP id ffacd0b85a97d-48e6e2620d8mr39868997f8f.0.1793824256006;
        Wed, 04 Nov 2026 12:30:56 -0800 (PST)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48feda207d8sm5431164f8f.52.2026.11.04.12.30.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:30:54 -0800 (PST)
From: Andrey Misiurov <amisiurov@cloudlinux.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Drivers: hv: util: Fix transport teardown on util_probe() failure
Date: Wed,  4 Nov 2026 21:30:49 +0100
Message-ID: <20261104203049.1031148-1-amisiurov@cloudlinux.com>
X-Mailer: git-send-email 2.43.7
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

Commit 07a756a49f4b ("Drivers: hv: util: Avoid accessing a ringbuffer
not initialized yet") moved the creation of the KVP and VSS transports
after vmbus_open(). util_probe() still calls srv->util_deinit() when
vmbus_open() or util_init_transport() fails, and hv_kvp_deinit() and
hv_vss_deinit() destroy hvt unconditionally.

On the first probe, or when hvutil_transport_init() has failed, hvt is
NULL and hvutil_transport_destroy() dereferences it.  After an unbind,
hvt still points to the transport freed by util_remove(), so a failed
re-probe frees it a second time.

Skip the destroy when there is no transport and clear hvt after it.

Found while reviewing a backport of commit 07a756a49f4b.
Not reproduced at runtime.

Fixes: 07a756a49f4b ("Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <amisiurov@cloudlinux.com>
---
 drivers/hv/hv_kvp.c      | 5 ++++-
 drivers/hv/hv_snapshot.c | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 336b278..813bec5 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -825,5 +825,8 @@ void hv_kvp_deinit(void)
 
 	hv_kvp_cancel_work();
 
-	hvutil_transport_destroy(hvt);
+	if (hvt) {
+		hvutil_transport_destroy(hvt);
+		hvt = NULL;
+	}
 }
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 847dc69..a827cef 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -456,5 +456,8 @@ void hv_vss_deinit(void)
 
 	hv_vss_cancel_work();
 
-	hvutil_transport_destroy(hvt);
+	if (hvt) {
+		hvutil_transport_destroy(hvt);
+		hvt = NULL;
+	}
 }
-- 
2.43.7

