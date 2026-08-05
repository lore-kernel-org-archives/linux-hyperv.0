Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A04425887
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962287; cv=none; b=aIJEvH8porzyoA41h1+jHfNizvHnNqGkpeUuB6qfDZGdZOcKF9HtDPDdQ2RHM2dDitaZD6V2wR9q6df9+OG3ZlC7sAARLrXfXKjHkPjTEzntx1QPpn2xs6ZWoTU00jfufcNMn+pU3DE8PyIxm1vRgUgvcNG2gfLgSc9owsE6HhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962287; c=relaxed/simple;
	bh=VsaTIDWzIDz8HB9EYpNvkcsnMfbvQ95aRyp/yCJU5AE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mJidD4pDLhk+eVYfI39Zfk7Z6rL7lCNjdoOHGlnr8JZ6k/hkwIRaxurUGpCrfbPAxrUBKWI6M4Y56hRdsJ2qqoZVWaG97N5D58nAFefpK/0Q5XSOfxCMnArXzMdgw8wodCx4HyIuwrdABSVAxDS1wdnSW17LoJY4gqt04utddmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SPv/dpud; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPv/dpud"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2ccf2360620so15050605ad.3
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 13:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962286; x=1786567086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wufg7sO27f8/PuEZV6a7RVl6nQ0Yjk3GBfNCJb0RyYs=;
        b=SPv/dpudleDnRvMJQqE2w80+FzdU9Krd5DZ/5lz8dRFv9I6AQ2t83/gCsbAF5Y2lWn
         DiBNaE1CoRuC2K8PRwvflmFfJWU+ZfFxmVl2pX+CEy4zFcKbu1bYiN4gu/NmMVfU0COl
         VYdJJRbxJLkQL/OW10o0eKh7D1/DJ6yS9qYFkPnqS1KP1NtInKwljhTIRmBmQR9Nuqms
         4gy27emivzr+O9EKZ2g++XR7kkCtRnWtvptOh4958kXltO9U2vQ+s3xlVyvp+Uj34ulD
         OKmDIZ9Iw0dpWvGCXbPQ432YHgUX/IQXIGd0rJbYikkqvxnyzEEXoNcvJDKpGk6imDvT
         sUKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962286; x=1786567086;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wufg7sO27f8/PuEZV6a7RVl6nQ0Yjk3GBfNCJb0RyYs=;
        b=ehgGl9V6rs6uAG52z5S1j8mr9B+SUhIW9y+1M9Rdppu6w16dP79nJLRR/7J8RSWM5V
         kt/TzM+aLuZDEt/xG1uVNj+/BBfHnVd2g9FZc36u9o94kuGFgc++flPwHNfcAs1cAssQ
         agS/WxDgo1AWY/9WfLrxqCsGLuOFW1t03Vu2S8t01jSDrNpxaL1whEuk3WMhKhFm+Squ
         h2mU9SGMj4OjRI32ZFHiPt+ubSkD0WYW26GgK2bF8ddTmX5/YsuhBtPCHqVpzmnWlBDS
         o64KFamyiRw7FKw6Hd5S2CgWNw1bNOTY3XX7dxz+RPOvv8hNlxh2SbjH+3QAJzHBC5qM
         d8iA==
X-Forwarded-Encrypted: i=1; AHgh+Roh/Gh2vbyRPGGKzSUmfouTMG6CgfoHIRMcSWLprQpk2JeLpTmLTV27kVV89CHtyzKsaZIBW1EVJHbJriY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUUxYgajYojypIcmFpxA8XOibAW5F/pwdByx68K4NDyUaWGqW
	InY9MXmPgW0tQSojYC/1hX4WvxNbbugTScugzrNtEfXO+JcTW7Z4g6JY
X-Gm-Gg: AR+sD123xSL95DsX0bcI/Wy6OetF1hhCrq5HTs+Z/ZTf8IMocT4CL7vycUntjL45hh6
	BFfMDkQM3CCCURUNB7QOO//fZizwuwOPUaq1pXbtkZrXYhy2YJECBFZGIwhQy+Cjsq/70LugIW4
	0OF3SO2xnJmg01dx1Ik6OgfgSxvYTMJx2CADppoQNe5/X+ajS3l71fc/RseqXaqH1RebSCoYxUe
	IE0rHPffwjlRT7jFqVwPXAHWmvirxkZ1W+jGSDv+aPw/GNuRY51/FJqiBpjUWjZQi3p1X4Emx5t
	5auNymCYxFmsgVLMQA7V3EOM8mLp7yEVmfos7JYUecTAdW45mJbfdsNwlyj9OGZnwc9m/wMNpIH
	XlZ2ONVnPtSe2n8vc0D1ii6BciqPy0KPzfChYKRPwuEJFIXWmSH23dI4I2jBLfRGNzVHsl2VONB
	WcZHZPieObr9zqp7chd1obQNdgwFhyB7B+81Md4LtFD8btRm8GrjzzhFSHJQed23DHDNe5dQB3+
	jMCw9gaNtM4WcwMtcf8JuwoGIrWkK2IZN4AEw/K8sU=
X-Received: by 2002:a17:903:2bcc:b0:2b2:67ca:5ff9 with SMTP id d9443c01a7336-2d0ca159fd7mr117233285ad.0.1785962285806;
        Wed, 05 Aug 2026 13:38:05 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm21372745ad.64.2026.08.05.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:38:05 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
Date: Wed,  5 Aug 2026 13:37:48 -0700
Message-Id: <20260805203751.2678-4-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, the special case handling of
GPADL teardown is no longer necessary. Remove it.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
No changes in v2.

 drivers/net/hyperv/netvsc.c | 20 +++-----------------
 1 file changed, 3 insertions(+), 17 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 4d319c50955e..4295b96b4312 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -695,17 +695,8 @@ void netvsc_device_remove(struct hv_device *device)
 		= rtnl_dereference(net_device_ctx->nvdev);
 	int i;
 
-	/*
-	 * Revoke receive buffer. If host is pre-Win2016 then tear down
-	 * receive buffer GPADL. Do the same for send buffer.
-	 */
 	netvsc_revoke_recv_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-
 	netvsc_revoke_send_buf(device, net_device, ndev);
-	if (vmbus_proto_version < VERSION_WIN10)
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
 
@@ -733,14 +724,9 @@ void netvsc_device_remove(struct hv_device *device)
 	/* Now, we can close the channel safely */
 	vmbus_close(device->channel);
 
-	/*
-	 * If host is Win2016 or higher then we do the GPADL tear down
-	 * here after VMBus is closed.
-	*/
-	if (vmbus_proto_version >= VERSION_WIN10) {
-		netvsc_teardown_recv_gpadl(device, net_device, ndev);
-		netvsc_teardown_send_gpadl(device, net_device, ndev);
-	}
+	/* Must do the GPADL teardown after channel is closed */
+	netvsc_teardown_recv_gpadl(device, net_device, ndev);
+	netvsc_teardown_send_gpadl(device, net_device, ndev);
 
 	/* Release all resources */
 	free_netvsc_device_rcu(net_device);
-- 
2.25.1

