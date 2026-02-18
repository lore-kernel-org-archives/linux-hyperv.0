Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71EA2330670
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 14:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426084; cv=none; b=sZLXOSU92QlIdde5QM5UhymaNcbAhdcsLLvuZCmjUDgfSSCsk9TL7wK81ttdKT3acj5cXmcz2mvGI7nIFraH40goG5YD6tzxpxOFUrHqhW6ry6v2bWRwTrUJa3GIv6DIqYiZZibncKLIs6dLnpJ2Q4a56mk6VQU1l0nEdq9IEAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426084; c=relaxed/simple;
	bh=mZtB2FrTAh16xTy5vj3HWm5ON2AtyBQPYq0pTyGDMFE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VAy+dwtnc6pFDk/oMPBQl++M32OLanFgA0h703NunzaqAJ+t3ZjqHk6LdkM/oDBE4gsEJqLOocJe+zDuWuWn1DJTt+DxHoFCnIJFg3X1ZpsQyOBNZYf9Yq/3HEy3KA3kbIxG9bb/2NnMLItl4mGF5hLhLOEy1dESZ5iza7rEl9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jr6kSd82; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jr6kSd82"
Received: from anbelski-virt-work-5.irsgb21fvobu5fvmalxug44hib.xx.internal.cloudapp.net (unknown [172.171.99.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id E97F120B6F00;
	Wed, 18 Feb 2026 06:48:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E97F120B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771426083;
	bh=m6qQ4akgrOGD9wXWi3kr/xiHK1y1l+7d7NeibrsBi/U=;
	h=From:To:Cc:Subject:Date:From;
	b=Jr6kSd82plAKtfAekCqjsFauNucHLjUNj3QZUvjPSGUy7+kLHiYewqBRwV3R0uIfJ
	 dKM3wKuFx9U3cTk3quzWfD3VoS3ij1wi6Te4C8rvr1JS43P5lzbeNUDYJfdpDzgyLb
	 C9CfJsQo01RXDp8wBc1jRTEnZ980T2j9VDoO/xRY=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org,
	muislam@microsoft.com
Subject: [PATCH 1/4] mshv: Add nested virtualization creation flag
Date: Wed, 18 Feb 2026 14:47:59 +0000
Message-Id: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Muminul Islam <muislam@microsoft.com>

Introduce HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE to
indicate support for nested virtualization during partition creation.

This enables clearer configuration and capability checks for nested
virtualization scenarios.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Signed-off-by: Muminul Islam <muislam@microsoft.com>
---
 include/hyperv/hvhdk.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 08965970c17d..03afb7d0412b 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -328,6 +328,7 @@ union hv_partition_isolation_properties {
 #define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
 
 /* Note: Exo partition is enabled by default */
+#define HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE	BIT(1)
 #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED		BIT(4)
 #define HV_PARTITION_CREATION_FLAG_EXO_PARTITION			BIT(8)
 #define HV_PARTITION_CREATION_FLAG_LAPIC_ENABLED			BIT(13)
-- 
2.34.1

