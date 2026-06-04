Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0F537105A;
	Thu,  4 Jun 2026 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560120; cv=none; b=kEOx6fp4p0c8vdBU1DK8uM7ORN9pq/Uy0dqhSua+/EYhbEDegVJ76IZpc/EVXkSKcHPR/gvHzUs+zQj9DkIPGTMFYeWOhifN0ZufVTbwbDP/RC/f4FYQCuzu8ywoV4jSaONaM9MDxj4W8YDPZzjnrx9b5YBtiSB2xXx33EEWf3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560120; c=relaxed/simple;
	bh=3dP7tSKE777SpeJjpcqFKvadQN1HE9zy/yv1fQvLeRA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t4kZm/p9KokhQKCGzfNS196xt2x6D8Pa+UxuEVd6mTz04Rp70oebffnNEnC9cZ9k2RDE6Ez4bwx3vWmECGl6BIn7EbWBaDZaIfmtf6jNAiqUvS29hmzX7TiXy+epaME4g3UFuLtTysRu70dQrl6FN61ie7n1eZ03euezP82Avt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WCdFTXs+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WCdFTXs+"
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 405EF20B716D; Thu,  4 Jun 2026 01:01:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 405EF20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780560103;
	bh=XPoYNCGvDJaTicqaJgBWKLcSrkwnst8h0cS85WM1Ij0=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WCdFTXs+lyRejL+5qYa1V89vD2RW8wbzfBoWMXa9BY1QBTiKbCukS+ZmwUto+9bAy
	 PXalcoeGi7lmTksMy5khgdXF0QLj1iEoLA9TresXJydw6DDMJUdHkuLZ5OZOv2Un2j
	 RjXAN+K269VUicXaQc4iHsGJMH5R97V/M8dHTp7o=
From: Aditya Garg <gargaditya@linux.microsoft.com>
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
	shradhagupta@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	ernis@linux.microsoft.com,
	kees@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
Date: Thu,  4 Jun 2026 01:01:26 -0700
Message-ID: <20260604080137.1995269-3-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_create_txq() has several error paths (after mana_alloc_queues() or
mana_create_wq_obj() failure) where tx_qp[i]->tx_object stays as the
INVALID_MANA_HANDLE sentinel set at allocation. mana_destroy_txq() then
unconditionally calls mana_destroy_wq_obj() with (u64)-1, which firmware
rejects and logs an error.

Mirror the RX-side pattern in mana_destroy_rxq() and skip the destroy
when the handle is still INVALID_MANA_HANDLE.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index db14357d3732..4a2cd800111e 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2351,7 +2351,8 @@ static void mana_destroy_txq(struct mana_port_context *apc)
 			netif_napi_del_locked(napi);
 			apc->tx_qp[i]->txq.napi_initialized = false;
 		}
-		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
+		if (apc->tx_qp[i]->tx_object != INVALID_MANA_HANDLE)
+			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i]->tx_object);
 
 		mana_deinit_cq(apc, &apc->tx_qp[i]->tx_cq);
 
-- 
2.43.0

