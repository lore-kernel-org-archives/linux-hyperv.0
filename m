Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F6B3B994F
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 20:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442315; cv=none; b=hJVcHUIjdwhrNFySOTAeRoVHgX428xx/KOsmNomOmYbDNmn2y2jSLU/yAkamijvNXOuXiIPqeFmoYOcUSNh5VHyvUqaO/jw3GFEClxhRfEPqIgxabQPPAPr2OWuXS1uGhSXX7sZ1Y9vq8jywl+VMSmi5ep6htUrsaLd3PuS5KuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442315; c=relaxed/simple;
	bh=ywoJVudyQly2BSU4Suu/ELob67veyV2IT2JljVMnXPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AqLhtcueoc8xaFNMiznc/cz6NVJdMX89kjz5N7PysT9OJAVR22FGF+vJ/bC4oqS62Ka0FMP2x6e4gYLBml4BO1BOefUweiQRK9JJLQ2jO/sIFFObUnzCZvfTZND0i27bPgdxxO+cZFlJH8HiURVDZwGBMU+ICbU2nC2ybyRylMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZE+rgqp; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZE+rgqp"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84e3007a2b7so275404b3a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 13:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442301; x=1786047101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
        b=ZZE+rgqpWGO8ojZDXUbip2ounkYY1eNg1d/0oFePsUOEIaLoBEWK68sJkW7Do71l+c
         mv2c21/bWO0tG92lgpzz8W59tzWOgzs5Dyb+TSZ63ocakvnEwITXuv2zLJHhH5YoFoUf
         h32nb2ymWScCbUNtfx1Wh9iEYigiS3fehlP6otLLhF/HFqkH3dC9bLl/rlouFDNV1lNp
         57RGYHcbxYHG6TKhdjIMrOTJSX6ljivYWRSYXrsjc9RyVX3bqWyG84P2MnMo2XJKI8jQ
         DgjQ+LjftpwVskuSqBOBR/leyinBmGfR93VbzVs5jHN5dy6CqqY8jpajaPK5QyvgGU9L
         qCGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442301; x=1786047101;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SiwSGXnRH3TAjHZf8TYJ+bLPyzkydxq8UaVMUOfakl0=;
        b=ml68GfYJNzJpPl5oQhPIzX7uN/wQbAIvAHFkWfs3noRkVUASP0A7qDJR/0U/iV0tKb
         X5fzhoDExuMdunvlQczlpcWur7CY9fUOk8RSDrfVRrJ1TnAehJY7Zgs+4J89rPt5tOXc
         p5Gg1TyBUf7+v1Fct97zZZAo8XQpsrkjVghHCoEIakbIGJhRQijWdT1uP5agl7v8oe75
         YZ2iKYJknUg8G/a5C8woB4EVwFe2APxyc0OA3zGFOHmPvINhwJb8cCu5fnBXvK+YeSAZ
         vgAONePpGljhqgL7hUCG/isNz+DJj79pETB/muE71VluLWGuckgjCDV24stxA4Dc4mN4
         Ur2w==
X-Forwarded-Encrypted: i=1; AHgh+RoodbhqKwXRf6QLLILjC7jrE8PzOpdQISryVAZ2Df5fTlTPOw8kBhfbM06by6hQf8jlhFa1p9NsisD/KuQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yythbwdt6+Xbl0yRTBgK5lA+2ZPx7CocQ8nhpecQreVbGtnNkkG
	Y/5U0A3T4qC+qSLsrrGLHL71im7bT1hlpiTsuHie825BFtxQ9efs7IId
X-Gm-Gg: AR+sD103X3FfyTSW/q2KyJQ97KnVRhVqL//4r8/KdYvo4X8UMFO/EpBgtNhd5pdX3Eb
	7Y3q60GV5xUM8HbHGZTVe9dibDRQzS3yfHZMoLPm8v1odLxlbGzRK9WrqYnYu+P8/Qjd5ed71s5
	VZCesugMBlwNYORqRZ8RPDkUeMcM8jSaJul/3hmInabn1xWCTDTwXh++whH8aiR6uR4aukk2lxE
	Hpckw3HyUiJ/+TJPzT4MRvRjFGI1kZcO4Zq6EtDd+THnnH6fCYQGLa3rjYZ+mrsKrMYe/yVZho9
	IcTFhMX0suNyxRTi9hCT6u1cLe0t4/wk498u+aXRboUukqkOZgtNW7nfrxc8rrJEvXIjo4flv4C
	ROCTefzq6KRpYTm9/pz259OXf89K4faIj825JmVykyuEKDd8ypI3q9M5vikWyoag8UZtQ4Lp/vu
	Q3V5hYyjijf805mNG3I0ICxk0PPRv80N1UXb2TzOp1lZuAF4aIf4cEL450QHVGhFJDfpLmyNxA3
	KrLqmuXSIQAvyAihqsdPvoY6uhZhaspMJvVkmLs3at3LgtiYDIhUA==
X-Received: by 2002:a05:6a00:1391:b0:848:56ff:6ced with SMTP id d2e1a72fcca58-84ebc1f5844mr3898044b3a.8.1785442301426;
        Thu, 30 Jul 2026 13:11:41 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:40 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	daniel.lezcano@kernel.org,
	ssengar@linux.microsoft.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	James.Bottomley@HansenPartnership.com,
	martin.petersen@oracle.com,
	sgarzare@redhat.com,
	horms@kernel.org
Cc: x86@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [RESEND PATCH net-next 3/6] hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:20 -0700
Message-Id: <20260730201123.1767-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260730201123.1767-1-mhklinux@outlook.com>
References: <20260730201123.1767-1-mhklinux@outlook.com>
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

