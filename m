Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52518FDDE;
	Tue,  1 Sep 2026 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788265131; cv=none; b=p60QGrO460Nyia4AneojocxtBwZ1dni3OEEVVTOLmFGC2FtxTp0O/S+FeBFRmkLyOYIofgvt+dsqk5hhenpX4hSuFVHf95gueNCKoB0nx/xqwi8Cg9pwsYqaK3+OlD7AErGNdRx9s+e4wLTBYqXjcyqy/hJpsdA5DRw4a8xQ5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788265131; c=relaxed/simple;
	bh=f91MJKWGtDcgImwhw5xnCqWepe3MFrUOX8o7V25aOck=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=AEm2QGUXOo1hlgaPAayBIDPmQztabblt7/xM29VAmCWe1lWCKVZh6Vy7BwZjOHDheyjjRBUOf7V/BOG2hvMDgfkk82U6tHLWyWcZ8qCXJteIEIoh1ngKbs5OhtUKA4g9weInIAB32woFiRIm4foOlCBep39BDHzIbO2yn+UaObs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZZz7diOa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZZz7diOa"
Received: from kali.mshome.net (unknown [4.213.232.20])
	by linux.microsoft.com (Postfix) with ESMTPSA id 04E4920B7166;
	Tue,  1 Sep 2026 05:18:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 04E4920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788265093;
	bh=wpQ4qtHHQBV6bm/lnDJ+MhXIw96xxzkcYVHtndKnkPE=;
	h=From:To:Subject:Date:From;
	b=ZZz7diOaOppL27ukTWIO4OH+8kfShyjAnD17iRY1D+i1Z5Z0w0qfRsMxGEVDK9pBV
	 e6TB/3PvYthT1oaxT8UnHHEMXiDTGHvMRZI2jBmVzq1hClVROvq8bDWB5GQbWKrDm3
	 Acm4sCDw3XIT7ZxZ0fq9FEiqDGf936HRLAc60qvE=
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ernis@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: mana: Reserve extra CQ slot for the fence completion CQE
Date: Tue,  1 Sep 2026 07:17:58 -0500
Message-ID: <20260901121837.3503240-1-sahilchandna@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RX completion queue is sized to hold exactly one CQE per posted RX WQE.
MANA_FENCE_RQ makes hardware post an additional CQE_RX_OBJECT_FENCE after
the packet CQEs. The current sizing reserves no extra slot for it and in
rare cases, CQ has no guaranteed slot for the fence CQE when it is full of
packet CQEs. This can lead to dropping the fence completion while the
driver waits holding RTNL lock throughout the timeout duration.
Reserve one extra CQE slot for CQE_RX_OBJECT_FENCE. mana_gd_alloc_memory()
requires queue_size to be a power-of-two and at least MANA_PAGE_SIZE;
the reservation pushes cq_size past a power-of-two, so round up the CQ size
in mana_create_rxq().

Fixes: 6cc74443a773 ("net: mana: Add RX fencing")
Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 7dfb453ae75a..e677842059e2 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3020,6 +3020,10 @@ static int mana_alloc_rx_wqe(struct mana_port_context *apc,
 		*cq_size += COMP_ENTRY_SIZE;
 	}

+	/* Reserve an extra slot for Fence completion
+	 * event (CQE_RX_OBJECT_FENCE) in case RX CQ is full.
+	 */
+	*cq_size += COMP_ENTRY_SIZE;
 	return 0;
 }

@@ -3114,7 +3118,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 		goto out;

 	rq_size = MANA_PAGE_ALIGN(rq_size);
-	cq_size = MANA_PAGE_ALIGN(cq_size);
+	cq_size = MANA_PAGE_ALIGN(roundup_pow_of_two(cq_size));

 	/* Create RQ */
 	memset(&spec, 0, sizeof(spec));
--
2.53.0

