Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCD43D300F
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 20:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785962288; cv=none; b=FBahJ6P6+8oTNOb1O4bXJdFc/4UsrrQzp24AEH2MDndM2KPhyGg10U0JItpcSgu6vN7Wr0mWPE7vvt87vawaVnLbnpvXJDd9r4BNDB/BrOj1q+6RolQhcyR4R1FPKcf+UZx6uxqtWo/+GmfoiUPpsKK9B5y0Ux7LmEcag+iAl3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785962288; c=relaxed/simple;
	bh=OopqtCN07oGoAKRVAQGlfvHRqLwfc1UdFt9BvhOiS3c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C8CrqZeEgaAjM9QZNuHDSgWpNm9TftyRHkYHBS5/Pijs6TWqCjOT0YdZDwgrbHzhTFAlmFE0Xlcu+/xxYE7AhVm9wRa2jHFG22I+AgJUgGHW+ElRA8NMQuhyjsmujR2SPrKHXh6KW70Fq+Mj8pygOreR+X0kqoap6ySV8WdbTnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmiRGE3n; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmiRGE3n"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc891373e0so18575045ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 05 Aug 2026 13:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785962287; x=1786567087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EdXY5/YY8vIPrZPChiWbr/RXKcHFj1ccguOM8+h3l00=;
        b=hmiRGE3nlfqYjKTtNGLiXlyTo7vpREGL5NvNYUMNxQjEE9ESa+nz3tlRrJAuoxqos+
         +itGkjqzegbkHWG+Ebans7mZ4mbqQJXX/+3jFH9wdJPwWSgSfUcCUJ+vQueTJQKmdf7r
         sUJcvQ7iQST7goziRmUQKc4baKj2fxamgqI2lnEM15FgiHGpSp5cuKuJvfGVqchnIC3X
         FgSIFQ4hLoLfhtd2guecPMoVM9KyFCQ2WwXlk1w8umPsGfoKWrtwS7jcnKJ+iLnxcMRs
         amfcAoI+kRfkxGNbd0b7BUIdjA2gLHtNtyr9NLz4hSsOZHmiw/X3yfsldBRqeWEX7Aj0
         0PVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785962287; x=1786567087;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EdXY5/YY8vIPrZPChiWbr/RXKcHFj1ccguOM8+h3l00=;
        b=L1kSkrJYi36Cbv164e0MHkGaRdfWD9mcyor5RtPHm7jxe2pTQBPooNv/4ilpYqy9NP
         DtSYZYZ+0c8f0xX4ecEIwpWrocdbd4vE5JeSvVdSVQqO8cUhFbXbBFGg1VVcVdzxrjps
         4lH5400P38CHKJuYaroyAyLedhdh55Bn5qrzneM4KKIaAMgNcY0Fh4KML/he6V0Spm22
         dhhwE6TWPq+RrYLS89972MjLHIpTjJ+0huR2Z8X11RTs0uYlmwFVcgLVdKlbKc4P7Gt1
         bDq19dSXm/9c8nr3m5v4FZzqJdYDB3VL7tvbTN/j6yjUoNUZn6VTR8G8qc4pMpUA+6ha
         izxQ==
X-Forwarded-Encrypted: i=1; AHgh+RrevL2jjQ8ioFDHOvEC7q+/JCFiXYIzOZqUuTYRoJmQ0cRvOSTnFil1EvPpJISjiX0GwNaqJXAlNAKq4lc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiCR9iHjgsxz5d+15etpjsNSOq8FEAOicscprMWphqU12+pae0
	DpB8LI0SGWaxWPjCKoZJOX24PWDkSl1/QYfjmRNaaHkcFE7oTSL7+fyn
X-Gm-Gg: AR+sD10ZvqDhH4W03Ldu8v5JiB0+8gec1fGa/dyLRszA0fahxw1KJ+0VoJR7YidVcVi
	ENGOpjZnWzYDzCVx/6sxZoMUan6QZLGJP2uctJCg3JV3F5uUajfEPxHrQGD3yiuuTq7o5YM+d2q
	OmM8tRl8cj37XywPZ5uoUvCQBU6nKM32mHoVJopO7cylPwzLoAb47fCgqZ7YyEBgQrx4/GZ2aPV
	hUodE4cVNafnpokTuM5R1mUg+58nevdjbbmlmR36B0EeJ3jkHisYV5bnjmHxazyRGtx+weX2EJ2
	RgOQrgXZQTwelVtMUmnSg7Hs6Spv8mpGCe+KibOSLNpgm7mqdmyxcukMrGgcoQ120w2OoYG1QtV
	3xxkCL6fwApq3aROoe208zZrM3s6M1WoRM5KyN2UKK63SXZ0WbamohWV5W3Z0V5CTC3AitiFZ4T
	3gLfPf5hI4+qxM9kkuEM+6WH5A6Art+s6jsU9JccqXWvPXRMT2yciHYMWaR6hA76/ZBvYSFiE8Z
	Zu57AdxPZ4klPB/9wHU46bUqF8cVf3Syg/n2AL3yg0DwELiXj61/0I=
X-Received: by 2002:a17:902:d2c9:b0:2cf:b330:e0e8 with SMTP id d9443c01a7336-2d0ca7599d6mr97124445ad.10.1785962286684;
        Wed, 05 Aug 2026 13:38:06 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d0aa4c0b1fsm21372745ad.64.2026.08.05.13.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 13:38:06 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/6] drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts
Date: Wed,  5 Aug 2026 13:37:49 -0700
Message-Id: <20260805203751.2678-5-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older synthetic video protocols. Remove the support.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
Changes in v2:
* Removed now unused function hv_drm_version_ge() and field
  synthvid_version. While it's posssible that these might be needed
  again if a new synthetic frame buffer protocol version is introduced,
  my sense is that this is not an area of active development on the
  Hyper-V side, so a new protocol version is less likely. The
  function/field can be added back when/if needed. [Sashiko]

 drivers/gpu/drm/hyperv/hyperv_drm.h       |  1 -
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 44 ++++++-----------------
 2 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm.h b/drivers/gpu/drm/hyperv/hyperv_drm.h
index 78136ec2c2f4..29e6f54af15f 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm.h
+++ b/drivers/gpu/drm/hyperv/hyperv_drm.h
@@ -29,7 +29,6 @@ struct hv_drm_device {
 	unsigned long fb_base;
 	unsigned long fb_size;
 	struct completion wait;
-	u32 synthvid_version;
 	u32 mmio_megabytes;
 	bool dirt_needed;
 
diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index f0ef627b4898..1d09bba1efdd 100644
--- a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
+++ b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
@@ -17,7 +17,7 @@
 #define SYNTHVID_VER_GET_MAJOR(ver) (ver & 0x0000ffff)
 #define SYNTHVID_VER_GET_MINOR(ver) ((ver & 0xffff0000) >> 16)
 
-/* Support for VERSION_WIN7 is removed. #define is retained for reference. */
+/* Support for WIN7 and WIN8 is removed. #define's retained for reference. */
 #define SYNTHVID_VERSION_WIN7 SYNTHVID_VERSION(3, 0)
 #define SYNTHVID_VERSION_WIN8 SYNTHVID_VERSION(3, 2)
 #define SYNTHVID_VERSION_WIN10 SYNTHVID_VERSION(3, 5)
@@ -181,16 +181,6 @@ struct synthvid_msg {
 	};
 } __packed;
 
-static inline bool hv_drm_version_ge(u32 ver1, u32 ver2)
-{
-	if (SYNTHVID_VER_GET_MAJOR(ver1) > SYNTHVID_VER_GET_MAJOR(ver2) ||
-	    (SYNTHVID_VER_GET_MAJOR(ver1) == SYNTHVID_VER_GET_MAJOR(ver2) &&
-	     SYNTHVID_VER_GET_MINOR(ver1) >= SYNTHVID_VER_GET_MINOR(ver2)))
-		return true;
-
-	return false;
-}
-
 static inline int hv_drm_sendpacket(struct hv_device *hdev, struct synthvid_msg *msg)
 {
 	static atomic64_t request_id = ATOMIC64_INIT(0);
@@ -236,7 +226,6 @@ static int hv_drm_negotiate_version(struct hv_device *hdev, u32 ver)
 		return -ENODEV;
 	}
 
-	hv->synthvid_version = ver;
 	drm_info(dev, "Synthvid Version major %d, minor %d\n",
 		 SYNTHVID_VER_GET_MAJOR(ver), SYNTHVID_VER_GET_MINOR(ver));
 
@@ -557,23 +546,12 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 		return ret;
 	}
 
-	/* Negotiate the protocol version with host */
-	switch (vmbus_proto_version) {
-	case VERSION_WIN10:
-	case VERSION_WIN10_V5:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		if (!ret)
-			break;
-		fallthrough;
-	case VERSION_WIN8:
-	case VERSION_WIN8_1:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN8);
-		break;
-	default:
-		ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
-		break;
-	}
-
+	/*
+	 * Negotiate the protocol version with host. Since support for hosts
+	 * older than WIN10 has been removed from Linux, only negotiate the
+	 * WIN10 version.
+	 */
+	ret = hv_drm_negotiate_version(hdev, SYNTHVID_VERSION_WIN10);
 	if (ret) {
 		drm_err(dev, "Synthetic video device version not accepted %d\n", ret);
 		goto error;
@@ -581,11 +559,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 
 	hv->screen_depth = SYNTHVID_DEPTH_WIN8;
 
-	if (hv_drm_version_ge(hv->synthvid_version, SYNTHVID_VERSION_WIN10)) {
-		ret = hv_drm_get_supported_resolution(hdev);
-		if (ret)
-			drm_err(dev, "Failed to get supported resolution from host, use default\n");
-	}
+	ret = hv_drm_get_supported_resolution(hdev);
+	if (ret)
+		drm_err(dev, "Failed to get supported resolution from host, use default\n");
 
 	if (!hv->screen_width_max) {
 		hv->screen_width_max = SYNTHVID_WIDTH_WIN8;
-- 
2.25.1

