Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EB1D4A64CA
	for <linux-hyperv@vger.kernel.org>; Thu,  3 Sep 2026 16:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788451639; cv=none; b=RsRInk1aInmo0kgM7hc3wOIFT9xzHiCl2TOUzADqYazdLH3iwvfEwXaaxmnT8c5B6vlJ/Wgdk4qnyXTOGl6n5nokRbMbzmizllEkpkV945x+MnZsN/QTBXdgaUXVGZ7Uvtb0lCPtoj1GSMlsMlaUJvDPGOKUkXTcYW4Z5DsTAB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788451639; c=relaxed/simple;
	bh=4nfVwGbxhCKSpPCmUf2T+tRIUDg90eQLoFxKdHwqJyY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fNZxIdYtiqUVcgJL01EunjXbu/DhKlscZStH+7+jXggyOmNp45n+Ac1WFY9ybNRpbl73RX92ieySw26rE57QY4l7+/BU7oDn+7NhivKRRkGG3jW6RZkWpbzVCxuw2yLJpjnA2LnpoFyET7ijgUKT1UvJSx51f+eQ1r+45sb58go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KyqA4QAY; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KyqA4QAY"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-382ef647e20so3098288a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 03 Sep 2026 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788451636; x=1789056436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G6hrH/lA3aA7eJREheWu7J/A2b4LUsrs+Hdunm8t3Ac=;
        b=KyqA4QAY2rKUszlkyZi4ovuEXZjYUFB/yr3ZWJTstgICFJb2MhlsxkORXh877+MXHk
         m5wrdHoAB5eXp65Q/JUQ3owvBRc1oWx5Dh5SCmJgW8BzLp1inhX5e/5FRh+G3xDCYb8S
         wkSldCSKMQGMPYNbAhTNYsymnYRfC8nUF9rMFZCEknjdNU0BfjCb6TOlcVaMmGZmXkn9
         792k4RfIphUM/figciL6bjxV+fAthZrq5mFVWLV3Oa9+1eJnkejjZ0vaOqvlDfzwXQFe
         ozllDBU5svGEOHLyFDc4KRPDLwkzUedyY1q8SXV68rqt/07b/IjiGo3sjkszWmXWVI5e
         dKWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788451636; x=1789056436;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G6hrH/lA3aA7eJREheWu7J/A2b4LUsrs+Hdunm8t3Ac=;
        b=p/17rHumR5JrYddjQ906GRhfar6DvVgq43An/Qdyumv8TB3cwtuSUzuSSWJclbj/bu
         A8peWBefC8G4tb2G4HWEfU9Ylyvtpry+0lrYzlSPobGrTWsg3fppP0zbdo6uSRI+OZP5
         G1bLCAVwzd+BhOzbUdC4alNig26J9IGOgtPsh50siDfBKdBxd4YqTb48Kyeb1VyTKygR
         Q5DTMaQbZ7kB18CpUj9pes8C98vNPBewZZBRsLGuHP/1sw2cIBA+9SvjgDaRidKJinLe
         zuel39azCTTYM2CrZu4zg7r4GdnVdio/WUJkjACI3yhW78fVNI6rEkjwwH1ikn8Lnbdz
         56LA==
X-Gm-Message-State: AFuF++mEMOdwpYHp2LZILmNNJtKQAZ2o8KALeGqB1z1YEVUxLTV8qIKf
	2QQu85fCTfxhX+CnmkWFMxUqf6YopxOIdpidEozq7jwLoX4CqQP/LVhi
X-Gm-Gg: AYBFou2Cd1slIOIhD/BKNGRB7dXkAaLwCsuZqTT6ooY/oQcyXJLZQQFo+1hHwEbOwAp
	BIwGZLPFI+x2P9Hnj4VV0u7MzWyu15F9862Qmtxu+P1UM0OcaBazAT4GhP/YqYzpNkbK32u5siF
	g2UWgEj6tQJU+A262t1DDkmxX4sMifanjcaPKdY4Z92PD5yRa8RxyFcut6HXZm+I35B3lEnc5xW
	OSRE0JjUQIdSo60HZxZYCRHoNrQ5SWwizznMfX1Ueq303EDb02VmcwM3l8NZ97yEep8jJwgj2YL
	eiQSMagEYC423knEO8L56gp6j/NSYZqhrId3o1sOmfn1jjhSwDmYnkOkTkZIWD6L2rmN74N623I
	P7Cqs/gWzaGvID75TVOLMDZZ9M4Il48FsZzAFyM7iGtGW8VjPOGX9tBWV52RXIElQYEzNEfow5w
	pEKbvuWKLcnldMC/HRltAgLFPyxJf4j4+Yxe0kHx/iYh7t3zosXM8fimc2WF8AOvkRww==
X-Received: by 2002:a17:90b:4fc6:b0:398:c315:fa6f with SMTP id 98e67ed59e1d1-39aee04acdamr22881454a91.14.1788451636126;
        Thu, 03 Sep 2026 09:07:16 -0700 (PDT)
Received: from mhkubun.mshome.net ([50.34.2.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae8ccc72fsm3702020a91.2.2026.09.03.09.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 09:07:15 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH 0/2] hv_netvsc: Fix leaking of send/receive buffers after GPADL teardown error
Date: Thu,  3 Sep 2026 09:06:49 -0700
Message-Id: <20260903160651.1637-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a Hyper-V netvsc device is shutdown, the GPADLs for the device's
large send and receive buffers are torn down. If the teardown fails,
Hyper-V retain access to the buffers and may continue to read or write
them. Consequently the buffers should be leaked after such an error.

Leaking the buffers used to work correctly, but was broken by a
commit applied in the 4.16 kernel. This patch series restores the
correct leaking behavior.

Because the large buffers are allocated with wrapper functions
that allow allocations larger than MAX_ORDER_NR_PAGES, leaking the
memory is not as simple as setting the memory pointer to NULL so
vfree() or kfree() does nothing. Patch 1 introduces a new
vmbus_leak_buffer() function that causes vmbus_free_buffer() to
properly leak the buffers. Then Patch 2 uses this function in
the netvsc driver.

Michael Kelley (2):
  Drivers: hv: Add vmbus_leak_buffer()
  hv_netvsc: Leak send/recv buffers if GPADL teardown fails

 drivers/hv/channel.c        | 26 ++++++++++++++++++++++++++
 drivers/net/hyperv/netvsc.c |  6 ++++++
 include/linux/hyperv.h      |  4 ++++
 3 files changed, 36 insertions(+)

-- 
2.25.1

