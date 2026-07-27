Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E692AE78;
	Mon, 27 Jul 2026 11:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152299; cv=none; b=J9m0G5gKC3eDFC7LdwCzV7NpPeCXDaMI0/3NATEv+WishOla1VGwOeZqzgVi6c9mCOK8dy8bMeRiWDI6vVKP/QfVmHoLn9/btFYveRwxePu5sT2SuiPbNSdjbEEXViKEadc6fi2+XHU2AlRCKB5U+0vkluhHpEA+XKuIeQZFWqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152299; c=relaxed/simple;
	bh=5xtxNIrKzcSGukgAp9eyDFCt4DjtswkPM5vkzSI6YXM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=peCyBLFwQF7iWDodf6VG7TO6t0AIxGQOGywxC5aP1u8THvaW0BnjpRjXwxglwh4tpTjvOyhRa/FITmRdsSvk6cX+WkXp/Fbls8OnEXrKmuAXoLKzG9OMxsa6B57J/Dy7xjMByyF7FbPQ2C8xk0WcGPfEan+rBiYRtnv4L8QFeSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T/OBGPF/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T/OBGPF/"
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id C823820B7166; Mon, 27 Jul 2026 04:38:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C823820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785152282;
	bh=PjRrfK4a6EKRQonD/jTqwJazNKDKPgT6jjz0ItyaIKo=;
	h=From:To:Subject:Date:From;
	b=T/OBGPF/3HV3dVvWtq+xuXz5fcnXSaljYselICGRwdkfItorwRtPV/DpWwCcMCHD4
	 fXF4Y03vvfMhufX7MKaI/nySOTkM4CHQNEP4Wnr3U+Xn26WF1Hc4FJkfc3KWr3+O5T
	 KuLrejWHs00vmnqWWIg3T6p0sxr/9M9cNefXNypg=
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
	ernis@linux.microsoft.com,
	horms@kernel.org,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ssengar@linux.microsoft.com,
	gargaditya@microsoft.com
Subject: [PATCH net v2] net: mana: Return error code from mana_create_rxq()
Date: Mon, 27 Jul 2026 04:37:59 -0700
Message-ID: <20260727113759.2881500-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_create_rxq() returns a struct mana_rxq pointer and returns NULL on
any failure. The caller, mana_add_rx_queues(), cannot tell what went
wrong and hardcodes the error as -ENOMEM. As a result the actual failure
reported by the lower layers (for example -EPROTO from a failed HW
request) is masked and every RX queue creation failure looks like an
out-of-memory error.

Return an ERR_PTR() encoded error code from mana_create_rxq() on failure
instead of NULL. The caller now propagates the returned error code
directly instead of substituting -ENOMEM.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
---
Changes in v2:
 - Use ERR_PTR() to return the error from mana_create_rxq() instead of
   adding an output parameter, keeping the pointer return type.

v1: https://lore.kernel.org/all/20260718024818.560552-1-gargaditya@linux.microsoft.com/

 drivers/net/ethernet/microsoft/mana/mana_en.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9d9bfd116dab..92bb55935c1c 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2829,7 +2829,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	rxq = kvzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
 	if (!rxq)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	rxq->ndev = ndev;
 	rxq->num_rx_buf = apc->rx_queue_size;
@@ -2930,7 +2930,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	mana_destroy_rxq(apc, rxq, false);
 
-	return NULL;
+	return ERR_PTR(err);
 }
 
 static void mana_create_rxq_debugfs(struct mana_port_context *apc, int idx)
@@ -2964,8 +2964,8 @@ static int mana_add_rx_queues(struct mana_port_context *apc,
 
 	for (i = 0; i < apc->num_queues; i++) {
 		rxq = mana_create_rxq(apc, i, &apc->eqs[i], ndev);
-		if (!rxq) {
-			err = -ENOMEM;
+		if (IS_ERR(rxq)) {
+			err = PTR_ERR(rxq);
 			netdev_err(ndev, "Failed to create rxq %d : %d\n", i, err);
 			goto out;
 		}
-- 
2.43.0

