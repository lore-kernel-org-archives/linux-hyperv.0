Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FD63B47EF
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486796; cv=none; b=kuDykyjVYqq05mEa41qexg7XvkMqXkyESX+iRzm7IJ7SD6Rq5CJBGL3emVDriXsfdBjNqwa3kGtxOqTwYbHMw46VhIaKonfpjbKC6zZ2c3+GUyTsSb7Xdi0CA9AmDDSYcFzFdkpV349jznSrFU/Gyd0QD1smxSN0dFA7CgNTmWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486796; c=relaxed/simple;
	bh=BJhZEjV13NfMfJ70FGMT/OSqJQFIXDnnD864pIvSPv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3GPRUuSURwscyKGYG+fasKynAQHjQ8ysKMV/NweARbZ29jeP8idiXpBGwH1SSeS+wLLWnuh6OI2ddk7y0GxxpzskIONG9MlH3wGvQjNt5FGTMZYOo9/oYYMlxO/6Z87Lq+EGUW4kGmdMkmaKA618/Yko1cRI4Ua6R2kLWZUjIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=GX9DUnyK; arc=none smtp.client-ip=74.125.82.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="GX9DUnyK"
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-33fb4680717so2079325eec.1
        for <linux-hyperv@vger.kernel.org>; Thu, 08 Oct 2026 12:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1791486794; x=1792091594; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mdYp5F0mgTxGu/EPWqlstTXyTWY/Kq4qdM3AvQLOhGc=;
        b=GX9DUnyK19tZHgmWnrk2ph/WMOxV7jIYuWcdWMFXeczyJgSuEnflyhQNVVxzLDkJ+k
         nBlNVwEIaHlaeNoEoc6Kd73w5FFbstzr1w7fEKO/auEL76pbVbRkVv3J0n17Sx8028Cf
         GotFzFXBaX9ZO6aKA1SoIfQplQstIJAOetwQRDBVCybAOnKoMsGx70pDkYFLWMYnRfzt
         Pu6lQYYaWqcx46ZyIZMg/sGyYgxHoURTaoipBEwJBTbWO5zzSdux5lkC3LAEc486qMbf
         sSRq3t0qlPmpJa5cAoWZmGrLt7jafiYjhq6UiUdCfrXcsOv7gQ3RHrxfmPqrHyGclRKQ
         cI/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791486794; x=1792091594;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mdYp5F0mgTxGu/EPWqlstTXyTWY/Kq4qdM3AvQLOhGc=;
        b=ZoP5HnMF1taKra2wyT72YoHtf63V1Q+nVoY3EAuReNO3FzovOSvbwraWK6Fk4v4X0R
         ZWYwAHD1rrtU1ZirLJJtUHBw4NIx7R2+Q+0547xuFpI74s7gdYiwI3Tx21SSMuUT1l4v
         9zS5tINGE6694tXptWF4ZXbEFKN7pbR2KArYqvwlBRstHVr9XQfLyrDtwM7yj4voZTJG
         Ws8XRgNJyXpJBNTUDzcDUKbt5LLzVFSM8JKozUhem1fsXgQkFRZNY4R+iWWVjdPdA3Ry
         Uq3UL6BzoRtMN/RdOyNE98+dUe3iAayIt/m9m+E+d54BDHdpGn7o4O5rFa6UIhOy/Qvc
         nUkg==
X-Forwarded-Encrypted: i=1; AKwUvBxLK2k5bBO/g1g4BPKq7Eu9OHWLJK62dFwYuZIUkPpp2eBQXNs82glWnnXj102quaanIVmZYvqSCqFOD8A=@vger.kernel.org
X-Gm-Message-State: AFq9FYKLRbnAhyCCuirOpXmXXTwKEk5B2cWEPj6LBB4GhWIRE9Tisl+Q
	dtcIimYTIikli1d8k4XToMlT8V2XJvp5w/JvoUAkJdfqjG2v4Vag/+/wElmNKM/zMz8=
X-Gm-Gg: AYBFou0GabH50yUJ5rmfum+7GrqlGnVjr+iHuGidu2oxMGR7FVVRzJJe8MIw+6uTXgb
	DtWsU7MdymMp+NOuqXKeSWd5+jkYWxk25kjGjAX1sjCkS6+Lex2OkcZkfVU2DDJyfV4budcqglL
	70yOazo+LrTGr02PVPsYZhPCfupuNkPTajA77SeL5lo07Ghf57rW2ye4PiNzRTisSME7GaEVlC4
	LFcLuifsdIbjaMvsi5FWm2t4CglztX72tI7mfYOrTODr2BcK0w+a4k1Kgv5GJ8WdtWY8AkyBqsB
	CHhyJGkpznT6xZ080JzOJ2BK5I0HbAFnHBSy+oxfmmRJkk/ejI2+GIKTHFfQHvhVCZ8wF8JOBJu
	JpAZwJULUDM9MvbJSXyYozrbu3bye81kcKHu9t3EQtAWndRwTns2vfb+puzciD1medUtfGY46os
	jS2BTZUaf85/XZEnnhcdVGEcCfK9oF+MC0Iyp18ed9XlvbYHfdt2Ovv6RLlt+5j9aaMuvobc2Eb
	MZy+A/c/FSrbIOCJUUoGU7e5Gu2Jm54KYqzi5ryKwy8bNpwkbGmLpMx5lN21bcKk7Znws8=
X-Received: by 2002:a05:693c:414b:20b0:351:1cc6:995e with SMTP id 5a478bee46e88-3515dbea38fmr8630903eec.5.1791486794211;
        Thu, 08 Oct 2026 12:13:14 -0700 (PDT)
Received: from localhost.localdomain ([2603:8001:5f01:8bab:bc88:5ec1:4f8a:5b23])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537c841579sm94214eec.4.2026.10.08.12.13.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 12:13:13 -0700 (PDT)
From: Artem Dinaburg <artem@trailofbits.com>
To: stable@vger.kernel.org
Cc: Artem Dinaburg <artem@trailofbits.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Helge Deller <deller@gmx.de>,
	linux-hyperv@vger.kernel.org,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.6.y 1/2] fbdev: hyperv_fb: Simplify hvfb_putmem
Date: Thu,  8 Oct 2026 15:13:04 -0400
Message-ID: <20261008191309.98263-2-artem@trailofbits.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008191309.98263-1-artem@trailofbits.com>
References: <20261008191309.98263-1-artem@trailofbits.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saurabh Sengar <ssengar@linux.microsoft.com>

[ Upstream commit f5e728a50bb17336a20803dde488515b833ecd1d ]

The device object required in 'hvfb_release_phymem' function
for 'dma_free_coherent' can also be obtained from the 'info'
pointer, making 'hdev' parameter in 'hvfb_putmem' redundant.
Remove the unnecessary 'hdev' argument from 'hvfb_putmem'.

[ Backport to 6.6.y: Pass info->device through the target's
  hvfb_release_phymem() helper and remove the now-redundant hdev
  argument from each hvfb_putmem() call. ]

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Link: https://lore.kernel.org/r/1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <1740845791-19977-2-git-send-email-ssengar@linux.microsoft.com>
Assisted-by: LLM
Signed-off-by: Artem Dinaburg <artem@trailofbits.com>
---
This is patch 1 of 2 in the ordered 6.6.y backport series.
This is the prerequisite needed for the CVE-2025-21976 backport. Makes
hvfb_putmem() derive the device from fb_info, which permits the following
fix to move framebuffer-memory release into fb_destroy() and honor
outstanding open references.

The fix is already present in 6.12.y, 6.18.y, and 7.2.y, but not in 6.6.y.
This fix also affects 6.1.y, which will need a separate backport; this
submission contains only the 6.6.y patch.

 drivers/video/fbdev/hyperv_fb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 80e8ec36b7db..80e6d9682179 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -973,7 +973,7 @@ static phys_addr_t hvfb_get_phymem(struct hv_device *hdev,
 }
 
 /* Release contiguous physical memory */
-static void hvfb_release_phymem(struct hv_device *hdev,
+static void hvfb_release_phymem(struct device *device,
 				phys_addr_t paddr, unsigned int size)
 {
 	unsigned int order = get_order(size);
@@ -981,7 +981,7 @@ static void hvfb_release_phymem(struct hv_device *hdev,
 	if (order <= MAX_ORDER)
 		__free_pages(pfn_to_page(paddr >> PAGE_SHIFT), order);
 	else
-		dma_free_coherent(&hdev->device,
+		dma_free_coherent(device,
 				  round_up(size, PAGE_SIZE),
 				  phys_to_virt(paddr),
 				  paddr);
@@ -1100,7 +1100,7 @@ static int hvfb_getmem(struct hv_device *hdev, struct fb_info *info)
 }
 
 /* Release the framebuffer */
-static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
+static void hvfb_putmem(struct fb_info *info)
 {
 	struct hvfb_par *par = info->par;
 
@@ -1109,7 +1109,7 @@ static void hvfb_putmem(struct hv_device *hdev, struct fb_info *info)
 		iounmap(par->mmio_vp);
 		vmbus_free_mmio(par->mem->start, screen_fb_size);
 	} else {
-		hvfb_release_phymem(hdev, info->fix.smem_start,
+		hvfb_release_phymem(info->device, info->fix.smem_start,
 				    screen_fb_size);
 	}
 
@@ -1223,7 +1223,7 @@ static int hvfb_probe(struct hv_device *hdev,
 
 error:
 	fb_deferred_io_cleanup(info);
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 error2:
 	vmbus_close(hdev->channel);
 error1:
@@ -1252,7 +1252,7 @@ static void hvfb_remove(struct hv_device *hdev)
 	vmbus_close(hdev->channel);
 	hv_set_drvdata(hdev, NULL);
 
-	hvfb_putmem(hdev, info);
+	hvfb_putmem(info);
 	framebuffer_release(info);
 }
 
-- 
2.39.5
