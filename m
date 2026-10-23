Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724736;
	b=BTTOS+TXhJkupQzTSsluQkUdGF2tepL0gh0dc3s870w6mybAN3PYjAQt8HYrGvjET48k
	 mlXPOT0uDAoWj7Q4f+ieNnEp4fdLnrzJksuLZjeg+frrTS1fDFyn512ZjVfe8imIqbNoq
	 EJU9BCFfpEoL/uXkgx5OJ7j87//fqFCZEjL93+o5gQKeP8tJV0NE6JhefY+mEP4pCI1Ex
	 NuhViVABxfMyj3Q+gilVPkgxF31vPxws6c6wEgIDocY4fQi1mfvko5WMQnJRVBqp/zcDK
	 Xijp9uOTa8y9tGhoCC4WK7I0dA9/7dlbW6WKSDn4k7MjvYBDcrWUZ4orPalT0B2GfNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724736;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Subject:Date:Message-Id:X-Mailer:
	 Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=pR6JdMczIcQeiJ74SnQg1wuYi/2QUh8zcrrU9uckavE=;
	b=hDjRZeML55lPzng3WO7LQnGdvPsSFt3c/B+cggdXWSnHXyZXYTZuOH31Ws99nB+4U9bp
	 R4/xWIxzrxuRiDI1h+FIxGbZad3o12LWxT5ZSzXP616rYVm//d/5/IQL8UbiabOmuk57K
	 weakUdvWQsnbTrhEfnbcGGiLRMpafdirXijPY2lmfZ9qGJf19dH4gYxSBm81ZkNTldhB9
	 oDCpkJOJjbzh3M9hkgusoNL3vM9g/GDYfSm4GD3JdMAVdHx5Z1AgqPto0q82fxoSVZCjp
	 PE1aQxmvR/XFMflzewQLFixL4+jozWIvvUHj2gDi+M+5+jAT0lve+MUoTNdfP/B4QfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DvXiqZD6;
	arc=none smtp.remote-ip=209.85.210.176
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBFB606A31D
	for <linux-hyperv@vger.kernel.org>; Fri, 23 Oct 2026 03:05:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EBFB606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DvXiqZD6
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-8a07025cce4so264876b3a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Oct 2026 20:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792724735; x=1793329535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pR6JdMczIcQeiJ74SnQg1wuYi/2QUh8zcrrU9uckavE=;
        b=DvXiqZD6rI5baXmmtvAKcFD9FRamTQZj8xR8gKdDi6TgjciM8fj9LDl0IX/zUNSvZQ
         cRHDaTD1WALckJLUoGSnNxbtAy5WoLNsmhuSH/HhqrY1wAkJkH8plpoc2rwidN8JSBym
         mBAaME+fDitKULSbG/Pk5/JGnaOX/kWtd6J0ZFE4jn6lmKjGJaF4JHOvUtJ8m1sfBHAy
         8sQqeQBtsimO0wliuMMlxFLfth1RpxcvgY9l4i7G9l/QqPQt+maGbe6+kmy4qcTRCkEl
         3MxYfvv6/5cpgzSp+yJjRLUIakuPN5HuKEVmFEapX4P+pc5gkEnguFiqc/4cR0+EQiSt
         WVmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792724735; x=1793329535;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pR6JdMczIcQeiJ74SnQg1wuYi/2QUh8zcrrU9uckavE=;
        b=jBEchSqXOLHb6ac0V1C5YpPIIlesG50AReR7UlFnyisMRVPjZqw9Rd2wAcolmAlpzR
         2A71PCykzoQAD0Mc1c/0m5V+Ix6ylRVrvxgFb4BpBnINLeq6ALgnh1LztVwNnMPESfpN
         BLA7HAmLXcAof6rwbvE9xA1FyFC4t82vKv7OJRMKJ/wnsESiVWd7PFRLc3RjMoWhcMH4
         PbgKFPSaFMQy7PH59+KsEySW8Lx7ugQa00gDTsGaHnuAmT9+1uDVIDyTgfmct2cwnu3J
         RqvoUNrhIBpH14fpc7Hup+8W715ZW4B8hWrO2Z8h1s/j4RRygg/VEhAtP7aLX5enmoaq
         nR4Q==
X-Forwarded-Encrypted: i=1; AKwUvBwrgPbym4ZxMLxgv/DMReozxZ6JaKZjhodLjvhieJfVdgVcHLA/H+XzVgLcIJAVrTg25vEDouZdh4F/14A=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhb9E4ovW371MZl8FLa1N4k5io21fCcFVQl8Fn3cVuDa3rwAKw
	WLdFLUBAU2sCYWYEG7uYdMQe6PPOH70+tSMtTxcSMww45FjMOUs4wqHw
X-Gm-Gg: AYBFou1mavufOXCMu8vs+2dh6jtqY+X7miRaRJVRZaBpBIungruH1oxDYX1JN2PWMUg
	5BaR6RKFHVCW7+VThywB5Cx+JEy9d3fboruRHHtXx1DeFYJFtl7rsuiePGzkT52fkUljZ62qccR
	Y6Ir+Qkidw7FfAf8nBxzIArj/42iFZDHJUgQA0mFN46Z1NQsWafy64XMLeNdHx0ouCgkoOW3gZh
	qOEg7tROVlUxW9HUAU4i4bunlYN+7wEW+cpIhUETt/qPBi5sVDCOGbAlwTivbRQIenG7SwuM7s+
	MkK45F0rcQ70OyQh7g7pfEwk/5EZVYdOCwCOV+umidjKho1VyRxxoubrVz47xcHasU89OsTTfIR
	6xVw1EILzXXGn2RxNwdSGJrAsWeXAN/f99iMq2ZVNjLls6VF/b4U/XAOPkFmTZqLLUlL8bWD3Ej
	ALKYETcI0boT38v6hlndTKifBcBIDtmOBRpo0GBk6ik+RZPOGAhg2eA5dgkyY124rfc0btwHULu
	+xv3ZK8EEdB+og0Z2ztA+WGFCIhuveW+cdajsiJf8+YV3zs+QRu3h+qlo8cnNJvMh0uymySJzyH
	q+XFriyXv98bbr6qUxzvxU50/ED7bO9N9i+4db8b9+cgeRtjN7nCFq7Z4TQ=
X-Received: by 2002:a05:6a00:440d:b0:881:b7d0:8dd5 with SMTP id d2e1a72fcca58-8a2c661aa67mr900925b3a.32.1792724735459;
        Thu, 22 Oct 2026 20:05:35 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a2c89d2e2esm215026b3a.13.2026.10.22.20.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 20:05:34 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: Remove leftover support for old Hyper-V versions
Date: Thu, 22 Oct 2026 20:05:27 -0700
Message-Id: <20261023030527.1611-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
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

When removing support for running Linux guests on Windows Server
2008/2008R2 and Windows 7, one area was missed due to the code
comment spelling "2012" incorrectly. Remove that functionality now.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/ring_buffer.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/hv/ring_buffer.c b/drivers/hv/ring_buffer.c
index 72f30ab23d1d..d8b085dfdb46 100644
--- a/drivers/hv/ring_buffer.c
+++ b/drivers/hv/ring_buffer.c
@@ -561,14 +561,6 @@ void hv_pkt_iter_close(struct vmbus_channel *channel)
 	start_read_index = READ_ONCE(rbi->ring_buffer->read_index);
 	WRITE_ONCE(rbi->ring_buffer->read_index, rbi->priv_read_index);
 
-	/*
-	 * Older versions of Hyper-V (before WS2102 and Win8) do not
-	 * implement pending_send_sz and simply poll if the host->guest
-	 * ring buffer is full.  No signaling is needed or expected.
-	 */
-	if (!rbi->ring_buffer->feature_bits.feat_pending_send_sz)
-		return;
-
 	/*
 	 * Issue a full memory barrier before making the signaling decision.
 	 * If reading pending_send_sz were to be reordered and happen
-- 
2.25.1

