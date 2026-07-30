Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715CE374A02
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 20:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442317; cv=none; b=GlJeiTCujt3epF4cYU7V6WqCGaRJ5z37jFpcmLoKrJYNLHtlUCoF5TCQ8+cRc41OaecwrscD3pFyOnguKgtw+oho7l0Myx2o+QSZIwpCu33mQlLIigif9xC0VZLVbgThs0gz35M+MZuWjY86R1W3m2I7u6tC7CmghmlIll+tyKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442317; c=relaxed/simple;
	bh=bgehGYxVvOhqrzJ9g+V/DTye3Nic7PErqY7Gl161rk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oqicIRpt3KeOGtUMPTevl15AfJpGkLFdNY8UJcqv9TlLOTir2P3o55x/PQX+9TTs4QlyVY/dZlVTH2TCox7miHpUNSUk++ZB28/DSmR895c+e9gzANpYP1Ibcs07w2XCSz8kMS5ckC5wMUhx2LECS4A6eDZGt+zHkaJJNPy17p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVVO0A9A; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVVO0A9A"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-84e27035206so363875b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 13:11:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442304; x=1786047104; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
        b=SVVO0A9AitLveUl+OUT7/8qpSi1jp0u6t2irF12YEd3TKItCnvbsGEuvV0TW7Wr4YF
         l1plK9a2rxxOU2kuLG1iWWczXAmqnGtUTSTvPgKOPXg+8Kqupdke7+5C/JRgXRvynKXu
         JtRLvCmVg1oV03+DU42qTZKFYW/CNYigEOL8p6WAZavale2umWQ2QZA2/EYwdOIghPrK
         emR/ZoVt+IvBMMTxBpUFpzApaRBYJwaGr34x4nkWv5zsVmOoA22Gxz7etij0yZsMV2hP
         DCEZw4gbZQ43q7v3vAjMHTtCW9ix5nnnkKVl7o0KB9bPm3SBRXui9yQ/3NvPL1+VgHk8
         dMUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442304; x=1786047104;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QRL/mQO23aZLDOYAwAiZdksOJj7+W5EBU224dpv2hko=;
        b=AU7z9Ta3X6KgjsSnDxMd8zN5bEnzGbZezqsLk+K635+D6aaOkxwVq2W9/ypCnEPLWf
         tWDrA96er/kw/+0okwUN88JByugtzrh0EsQXuNyYAbT+P731HsUtGsI1P8gN8VBiqCJO
         H2kXGemcFPFjRUccr8O3g8bTOMXcAAEPyYrykImw164lt6nVMetcFWWzKTdyAMC9xPH2
         dSDMmlQO27bZOlEb7pc9ME7ayRo04Hdxjy+lo76a6326Zh9WGDi1DB8mXmsV48hghvZz
         YvoXXnOsRYP/jmfurP15sqtANIgZ95mzJZmLvxxtg1c0Jf5HxWQD7ct72UdotWFMQtMC
         lYYQ==
X-Forwarded-Encrypted: i=1; AHgh+RpVmNs3a/XOgFTUJmRlgjT7dBFhDKC/49oMbQ4rpYURMuaHAI/gtU1qqNtEDemuNpS8NuqdH8NY7N329Ds=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy1UjHYXzqR4dIbN9u7oBq9w+ahNkg5N2Owofa50ZU47T58ifv
	U/6gNHVYmqBChvaRiQpEIqvJ8HIT/xvKESZRiprhoyUisXMccrgvZf6r
X-Gm-Gg: AR+sD128UetLcWXW2Z+vU5ftFXdeTmo/dywVMHmeXslZ9gPRLe237xSXOSD4eHzPJgE
	ZIdwiRJimNmazUxPKXr9qmoIwQ4X6TnFDbDUwEa/k+4fYpUbLM4eIt5kTSBjAU0OuL3/q6uMx50
	Jl90jkLZ1LUZWBUeqQXOBOFplybcSbyPzEyLiyKnpiSB5NnpT8JwbYNlygd1qDEfDsQCB+GAmDf
	Pm7Y0VKD88xcbkqJtjWvh/54rljqmClt2DkVIABcmg0QAKwXTEQVhGHn/nwZqypUQe9rqJgwSJU
	hgZPY6VqyRfh3RDckYF8V0QyJ3CTZp+ZQNht1ImNYG05htMy5ucBPdWCz1TXDrpm95yt3Po5cuR
	wQJL/6l8eQt8RJoHenuZuPzDrcTvuyOlMVhhgf8N9xBn9+/Bs+yQ1I+tM+q5mbYOMnOpL/cXOre
	Goj73WveX14XnqsJwzbK3163NY35JGdhxkeWYh7SeO1h0XqUTQLQxkXtYYsKRx4RDZP+Yz882Ji
	EDOF3+KlrlxeC+am2feAD/C1/xJzbRO9rZRyqim8zU=
X-Received: by 2002:a05:6a00:c82:b0:845:3fea:96c with SMTP id d2e1a72fcca58-84ebc22e874mr3531492b3a.21.1785442303585;
        Thu, 30 Jul 2026 13:11:43 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:42 -0700 (PDT)
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
Subject: [RESEND PATCH 4/6] drm_hyperv: Remove support for synth video protocol of old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:21 -0700
Message-Id: <20260730201123.1767-5-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, it's no longer necessary
to support older synthetic video protocols. Remove the support.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 33 +++++++----------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_proto.c b/drivers/gpu/drm/hyperv/hyperv_drm_proto.c
index f0ef627b4898..cea1ea2595cd 100644
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
@@ -557,23 +557,12 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
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
@@ -581,11 +570,9 @@ int hv_drm_connect_vsp(struct hv_device *hdev)
 
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

