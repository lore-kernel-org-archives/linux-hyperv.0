Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A34A200110
	for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 20:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785442315; cv=none; b=kJpFx4+c3UYRD7arsrB1MGRZtvF8Fb1qw13SafIayxAbaRJib45kQj/NmVTOvJc7f1cLm1Cagd1V/OR2qwB/0d12xZN3UOyoSlrMPWHFq3uhTG7AOLWUSWvvv56P3VPuLkgQVjlI7XWdujIGYXg9j5smQHMwTVkDD1Pt5Rp5xN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785442315; c=relaxed/simple;
	bh=82dBttW5BbKeJKJs/OF80tfwpM2MddI/t/zJLyO/za8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P4tw35IkKTB19P3oF4QAuRgiogaLO8dPE6FY51SjqTtHRHyf82aX0NBrVqWOQAjFljVtIyuH2Hxa5P6jzFTlwH6irmGwyBM+CieQa/bMH2C7S4qFXj0gyk2IZeRcdxilP1OuUMdaCPBEGo/bg7o4kIdCUeSzfSn5btYw64GFhPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkLoGcDB; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkLoGcDB"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84830c774a0so352429b3a.1
        for <linux-hyperv@vger.kernel.org>; Thu, 30 Jul 2026 13:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785442299; x=1786047099; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
        b=HkLoGcDB3WBibfwJOqTSPhktaOR12tYrn1Z2YDjlIijtIW0jt/y84TTd58TwPijLB+
         su9HlquHfO6asdTGrNx6RH1XttqGkuWS4CVnYGMh3bnUB05Td0l/0sdQnJXCkaWl1yCc
         SDd9D08//3ifMA2WRmm/p3MOQb+kLLDCQcQe5hwpDor0zCtwL2yd4I84GYPLMpem4kuF
         HKOwvVo2Ig21oxAwDDGOaWOW6f8sFMco0vOERzbo/HhcwK+6RIW/EXwkrGXj4/v7+SON
         ZNb9Iq+WCDHIVknVzZNrQdnTdfmT4y2eSU5YdBjiJjeN+KNtKNmhIK3jmQfF8mYxEXo1
         5sjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785442299; x=1786047099;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1cRzxCLmJh01GBR+ktuxuJ/o0iMR1lZqgXW5wBf6dg0=;
        b=hJDGjq11LRV8bixrhdb07SCq9ec8Ce+sZZkMxv0LrFymU3xNQwCK64euYhUvbwPD7K
         FLOkr/osPHbPx7Ci0sW9rW+oeOoAGyfjb9Y3NH+C/fezPxPFGxCvhiAddiBFIcJJ+xJz
         nsweP8hr/e/wxDvSZYstDqXiwSrFUevIIeXAVDdH9jXW1z2ZO82HkY9EtMmHqKd3Hm+Z
         ycSpOWj9cmE0qqgW1HuXVhEygaPRJnTpWidjOpptJf10Lb+nimPHOdWo8KfxHoUMJjON
         eRn7z0HzWrAGMPuFq41RVcEHc5Znx0lrSzK6p/Pb9/LuI7fK/TeWilN5m0lEmSdNMcQF
         FSXA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6/UyxjYdVQgz6L2eUc4wwIa/s0YEv5COmeJt9AmcldjvZoPF2lIWhZGNE8hRFjAp2yxsb2vBfTXBG974=@vger.kernel.org
X-Gm-Message-State: AOJu0YwibhLH4dbw1HE/cfyxjcameDLPNGxiOgGBtKaaRGouNf9cIn08
	OLgviy+hMBy6MwU24vqo31nZyYObby3Krvy847znYpPaJpfRSelVXxAf
X-Gm-Gg: AR+sD11MQZtrIrZb1GVo41ROO69IK/O6Q5PWLxDUoBE14Cv62v9SkovsPhndCiXNHSP
	Wv++P1qYwC8IhHSBIBTEXfs9szqxN8wGpaIzObvUfOq8UhvUhp/oiFepEVARg/i6aByYFSzpxWK
	3tkYDen9tUB3Z1U+nGnGhMWdV2UPtKKaH+R2Du87qQloNed/raQCIMHE5ywJkkuzPFn619wS0du
	udcQJ8U6xUeL44C/es+f3t2vTCtNF9MWfW3lfbAR9BdIm3XV8Q5+fmV2ieIUbgo7+PNUIiJadV7
	4+cDEK6ez+D1B2hnfL7wQBBSffWconoNrEIxB/XYphrMT+I5PZCkoLP7XLldRTlV5IzeMNiSPig
	DPb0wR1TfdmTOmzqqU0JOaa5Jdwqf38y425fx8sRfpIGsmoJwOUhhvYY0zfaKith8KF1hS+GmmX
	EDR7kc5SxejPFpiE7a25ieNOVY/4qEpd4BtuqYyD/KbQP8gB2OONV59COM6AY9NETehc/1AQ3QK
	ny8jhYAQYrcXQjrh0oM1zmvWnlY62Ct0uRF8UDrkLg=
X-Received: by 2002:aa7:88c7:0:b0:848:760e:eb76 with SMTP id d2e1a72fcca58-84ebc432c34mr3475574b3a.61.1785442298760;
        Thu, 30 Jul 2026 13:11:38 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0055325sm3689108b3a.15.2026.07.30.13.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 13:11:37 -0700 (PDT)
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
Subject: [RESEND PATCH net-next 2/6] hv_sock: Remove check for old Hyper-V hosts
Date: Thu, 30 Jul 2026 13:11:19 -0700
Message-Id: <20260730201123.1767-3-mhklinux@outlook.com>
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
hosts earlier than WS2016 and Windows 10, the check for such versions
during hv_sock initialization is no longer necessary. Remove the
check.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 net/vmw_vsock/hyperv_transport.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 5405c2680dec..855b15971c35 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -961,9 +961,6 @@ static int __init hvs_init(void)
 {
 	int ret;
 
-	if (vmbus_proto_version < VERSION_WIN10)
-		return -ENODEV;
-
 	ret = vmbus_driver_register(&hvs_drv);
 	if (ret != 0)
 		return ret;
-- 
2.25.1

