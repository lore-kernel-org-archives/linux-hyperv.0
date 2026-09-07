Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E92C33CEA7
	for <linux-hyperv@vger.kernel.org>; Mon,  7 Sep 2026 21:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788817772; cv=none; b=JB6uRUibwbhGT2yQ3rbLc8PAP8ppj3TWRX9asFLVytVF3m7PoUqyZkKqGl9w2bkugvRKcTbPn1/DlSFqGMImXlkfW13puKduM1iE1vj7Eq1ASOAZYy8UKrLulm/dwNRzJ+zmtSy/CBCdtaaghPC71sD4tm0mmfI0DB2YTRtZ4FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788817772; c=relaxed/simple;
	bh=NKh8Znxc/9XIRoZ70jnHk+tI5yLv2a+jvP9go5TtQ00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ab1vdb0IX+3SNAHdYKpmHcnje7utEI4wu4qw+s4mk5GG4PDthsmr/bfaNYagi2B0/aDQxBdrWYVmJcKl3Mby++P9iPl3KgKZNF9CnLeiQ/eGqY168yyUdkjQlyuJjlCxMIG+FT4ZEKWBvYJ3MdPWV6ql0cGJ0Z0eBzQ+xPtoAAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHbwvfjk; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHbwvfjk"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2d8f265cbe6so29557935ad.0
        for <linux-hyperv@vger.kernel.org>; Mon, 07 Sep 2026 14:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788817761; x=1789422561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n1yg1E3bmI7Wbg6fwKJNa02J7OZ0jX9eIVPZOa1Hk3I=;
        b=bHbwvfjk9low55dBKJ8K0RBi1WkYswA7GyHO9EcBOCDeJ953b+WiJwifjS4jElq/7t
         qnYM64gcLIaZYdS/LX9uY9/LnWKv+ACc4pgLYdStn6fBEgIuVeMQR8j6pvsHeMQEn+S5
         fn7zpGfCg5ykHu93SZb4UBRrQFvPzlP1LBd48BBtGrxcTdeN73vUwXkRRxMkkwY2LqBD
         DXro9okrJMenWsshjHjYq1jDuIu2UMnkhRyJmUby53O0zDgLmsH0pC84z2gbNtuyP9bZ
         EpVq8zdyG7T04fGf2fmPpVV99l51LwBMupjrcO7z9M566GVKLNMaG0BR+RBD4gX7THYR
         oVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788817761; x=1789422561;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n1yg1E3bmI7Wbg6fwKJNa02J7OZ0jX9eIVPZOa1Hk3I=;
        b=VmbBLxvDmE5UKSXi0K3Vx9IsDHqLy8Tne7uCMMItJSO7+v6YkKcTCKC8zR8EpcxIFH
         8kvDW94GJs2HpNcJnvBkODWtxXwCFT9ZXEYL5O/lr7bw+LXOphHaRF9KwOJnARQ+7lFX
         3Qkf1msIgg2PFvqlr03DS9WpZlQduHnNQeYQeg4n6lzSRP95Ti5nsnE4XtnuFemBoiaY
         fDiKMcE8xoXg/xDb4pvdAWax0u4cBws669aYp7/Ubp2Cuuk/6RHmmT9nUGPSEYoQUNnQ
         eScFkpZqDoTLCiZBbwbHGkvPqmTS4dIpbRX9HKT76pCbpvjTCIlvRiB25uHe7xYqhIVi
         3iJg==
X-Gm-Message-State: AFuF++mvfkefTVZe9X9YgxjebwSOSHv6sUd40UrvxRnCVf8T+6yIBQBJ
	eIbmDwQJZJKZf90Uj2bYae3DktB6keakWKv/mLGphZTeUfk8Wg4DF0Qq
X-Gm-Gg: AYBFou1Y1+W1q4ZPjDDVjSWf+YA+hTFsWEkZhwFQCMoXeX5kGV5sfZAbn8OMKMzeGnz
	d/dtF5pNzrfEBEaJcKJKJchqzxynUj+Ht99S1+tSvwIT6S5Hk5vlB+UYAV7bTIyJ2AWKUaTqgZ7
	qZpeM1Iyp1TPFgHg6YwZGCXRnujq6vYSFRgKPvBzym2OOWFOCEVGwD5490860mecR+hgcVVxV8f
	0dXbj9fMovg1wvnaD/+yvpzFMhHKeYZHixgHeZiFCjsGlUp9s7h4Jpm1JYMBe7nNL6MjhdpjUwp
	PhtF1f0rc1cvJGRdcm1BAgQbqDyM/7aPITJ4K4Ju9xAgwm8q3jKP0Yi3nzDuRLZvQNtWY1Nd3hc
	sfxqozpQpxwtlh5SLbpWacVjAmklKyaGQR+lGwJJGarnqrOwXr3gu0727XCPG9OyqDst45U2zxJ
	dVdspBN6sNdzE/bxjBEa8wpUzrgFIGrs53C+F5BE0FXpbHR0KYnCFavoBg4piRLkWowl2XuTL1h
	z7lVaGKnoWJQli1oxmYq1s3dN8XN9gI6BwWFmpgbOET
X-Received: by 2002:a17:903:4685:b0:2ca:660:b1d with SMTP id d9443c01a7336-2db126d8c1bmr365754295ad.11.1788817760726;
        Mon, 07 Sep 2026 14:49:20 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14841eaasm48794155ad.8.2026.09.07.14.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 14:49:19 -0700 (PDT)
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
Subject: [PATCH v2 3/3] hv_netvsc: Leak send/recv buffers if GPADL teardown fails
Date: Mon,  7 Sep 2026 14:49:02 -0700
Message-Id: <20260907214902.9046-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260907214902.9046-1-mhklinux@outlook.com>
References: <20260907214902.9046-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If GPADL teardown fails for the send or receive buffers, either
the Hyper-V host retains access to the buffers, or re-encryption of
the buffers failed. In either case, the intent is to be safe by
leaking the buffers instead of freeing them.

The intended behavior existed prior to commit 02400fcee254 ("hv_netvsc:
use RCU to fix concurrent rx and queue changes") because freeing
the buffers was done in the same function as the GPADL teardown.
The "return" statement in the error path effectively skipped freeing
the memory. But commit 02400fcee254 moved the freeing to a separate
function that is called later. It has no knowledge of the GPADL teardown
error, and so frees the memory regardless.

Fix this by calling vmbus_leak_buffer() if the respective GPADL
teardown fails. The later call to vmbus_free_buffer() then skips
freeing of the actual buffer, including any re-encryption required
in a CoCo VM.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260731201210.3653C1F00AC4@smtp.kernel.org/
Fixes: 02400fcee254 ("hv_netvsc: use RCU to fix concurrent rx and queue changes")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/net/hyperv/netvsc.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
index 5cd084e5696c..e9292c3fac92 100644
--- a/drivers/net/hyperv/netvsc.c
+++ b/drivers/net/hyperv/netvsc.c
@@ -316,9 +316,11 @@ static void netvsc_teardown_recv_gpadl(struct hv_device *device,
 		 * rather than continue and a bugchk
 		 */
 		if (ret != 0) {
+			vmbus_leak_buffer(&net_device->recv_buf,
+					  &net_device->recv_buf_chunks,
+					  &net_device->recv_buf_chunk_cnt);
 			netdev_err(ndev,
 				   "unable to teardown receive buffer's gpadl\n");
-			return;
 		}
 	}
 }
@@ -337,9 +339,11 @@ static void netvsc_teardown_send_gpadl(struct hv_device *device,
 		 * rather than continue and a bugchk
 		 */
 		if (ret != 0) {
+			vmbus_leak_buffer(&net_device->send_buf,
+					  &net_device->send_buf_chunks,
+					  &net_device->send_buf_chunk_cnt);
 			netdev_err(ndev,
 				   "unable to teardown send buffer's gpadl\n");
-			return;
 		}
 	}
 }
-- 
2.25.1

