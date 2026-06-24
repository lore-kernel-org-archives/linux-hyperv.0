Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38241EB19B
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2026 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323868; cv=none; b=TsMB8VLnmdAVKzhlTHD+fTsqUeB0pzqvtxx/aDD6hufgpHidro/QLprOK6HFHSHebOiazcw1h6z1GLoP7cU0qPeZ9o6m//N4hKbc8UrrYanyDEqnoNui4nb2CZ0Kxom3E59/JQo0R+U5NvhrmNZBEO6L1U3GopvS0zGFdQS40Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323868; c=relaxed/simple;
	bh=zbn6ZgKuNmDAjBOeogtu2BX0nB1p38Bq3d2/uZLEr7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SjbPFgVUOblvSTYIOnnB1194AOLqvIItD7KRlBayJwdNaCg5oMPes/Jm3t4gHLY7wasl+YvHXG9LnVzETv6GWHc9BCJ3jRCgiyJTXVx8Q7I+Zmf8W4WFtlU7gYvpZjtzb5Ffg96aoaFyb3+IzozM3PSyWvGZsnjMbJsVQ9XHEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mhn4eMXA; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mhn4eMXA"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8000e21f014so18695837b3.2
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2026 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782323867; x=1782928667; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JA2at9PRcWvPdd4c7nsTj4r03VsrW8ItBnRL2frJ9jg=;
        b=mhn4eMXAkKt/daHBKMzzYSAYe8I1jS5NLF8SMXT6Xb0madIv/5F5IE8NjX940qAR4Z
         9raclPX7nbgMTiQ7e8PCllBLfyWwN9oCUUgYEZ49mKAx1ZvkRqBHUlygomdQIPQvwhcU
         eSNNNp7Pxn+wkQCuTMd2Zr8kSHYFK4VRVcl7G7QWCDx+1ueWR0ZJByiQx/k4cTsQZ/3p
         9e6CYRx70K88hWYW19jZWv4P7/SWrEqqeIOLZEI0vhUaPm4SZMVg0d/xpn9RjdaklW7T
         H0bDH73ICAo1wf5GO+r63360iFjYXICGxJCoYoJdrXzxb4tmk+W76KH5JaspiK0dclEz
         Psiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782323867; x=1782928667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JA2at9PRcWvPdd4c7nsTj4r03VsrW8ItBnRL2frJ9jg=;
        b=MJOSzG2vIJrxkJ1E6rO/LDAzDKxoIdhTXaomdok7kaUTn9o69IykI4R6J60BVgS2iA
         oR1GxFJSGVD74hJUeq4DeutM6ua5ZoiB5ISSraSX769EEPmB6/+ZZj1W+0DlXSp0Wbu7
         AhDFsaEk1RnUUdhHSU3h4pqkNJKU0HdegjT2CMqHRRsfZnHMvN2+l7/BOcwRFB7mEASm
         VbPpGoebiHG5DPuG3vPxNPsoMlI4zutvIJVNiiUJ8QfYEza5CVmHX2sqtucSjl+7Iykk
         LhzN3mmKPQC+/oALt9ODkkpQDabJPFHz4Yivw81LV7+hUikMVtmq2tinlVQ3a1OqHbAf
         jljA==
X-Gm-Message-State: AOJu0YxCvZ5rTMmwmQewTSpOK0GRCrhiuBGqR8o5xhWjtpO0WXWQDJES
	fclTi3xag7CXpJoIJ77tGkIGo4x5+hL48o0sUP4l6I0xqoaFeCuNKL8X
X-Gm-Gg: AfdE7ck2V9/8XYcmEnwE2vaRsa754pYxVI2HC1Dbt/TSasUFlwkYVCzX7gLdw17eAeb
	sDbwkAuEtE20nFXfwvDq97ncZiArMl3YPWVyKs5oESHKDQSuD1kAo9fR9ZzdsUyE75OtzwSwzZD
	02ViPMMGYSFPR+dY+7j7rrtyqXHUl+frSE/WaHBup43f3iAB2rnjuUviXAxIJY/764zfuKJ3KSu
	WwLlc4p5py45tgUixl26RnABkN27fGsxTbbsyoi25O5lwCsrZyGifsoJCLTsV7xP2Hec1Y4geRi
	8CubEXwzifAxNKTsE0NHwSVb/TtkbiXWUVZOTpVsD9Wx0tCcVe/AzvTdZTJMILJr7FCv65+S/Xq
	ADiUIYqJBmRoLQ9Ut2VWZmgmKK/XAA6zIkmARczyx5RapKEOONF17dz+pAvP6dfFe2igjIdjNlt
	dmfjFHAjbGfwrapTQqJnLjXQpxQQ==
X-Received: by 2002:a05:690c:e3c1:b0:7bb:712:a754 with SMTP id 00721157ae682-807eceda983mr45883937b3.5.1782323866861;
        Wed, 24 Jun 2026 10:57:46 -0700 (PDT)
Received: from Dev-Null-MSI ([2a0d:3344:52ac:a808:98a4:4381:be45:536f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-806f10837bfsm23129037b3.45.2026.06.24.10.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 10:57:45 -0700 (PDT)
From: Yousef Alhouseen <alhouseenyousef@gmail.com>
To: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yousef Alhouseen <alhouseenyousef@gmail.com>
Subject: [PATCH] hyperv: mshv: zero VTL hypercall input page
Date: Wed, 24 Jun 2026 19:57:03 +0200
Message-ID: <20260624175703.9285-1-alhouseenyousef@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mshv_vtl_hvcall_call() copies only the user-provided input size.

It then passes the page to hv_do_hypercall().

For short inputs, stale bytes can remain in the bounce page.

Those bytes can be consumed by the hypervisor.

Allocate the input page zeroed, matching the output page.

Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
---
 drivers/hv/mshv_vtl_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 0365d207c..f2633148c 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -1146,7 +1146,7 @@ static int mshv_vtl_hvcall_call(struct mshv_vtl_hvcall_fd *fd,
 	 *
 	 * TODO: Take care of this when CVM support is added.
 	 */
-	in = (void *)__get_free_page(GFP_KERNEL);
+	in = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	out = (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	if (!in || !out) {
 		ret = -ENOMEM;
-- 
2.54.0

