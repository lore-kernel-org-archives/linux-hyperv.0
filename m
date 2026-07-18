Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69CA1A6836;
	Sat, 18 Jul 2026 02:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342955; cv=none; b=umImNAc5uwaQId+dr48vwcUZH7wZEUTDTOvw+/g1HleQNj0RO0Vvuw3rVezcJVxVGw8B/MDkgyQW/RWnqYkP7o2iHrWFBhREOUlzvRYytwajju0BGpeWhzUn5Jluw4nkil7ShJFky5ktaBzFzKdAk4MGESe/Q6bg/iskZOBKO0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342955; c=relaxed/simple;
	bh=E7EHmtqBMSlHXf6HF5pZv+p38Ks3/6GL+TMs+N4l/G4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=iDLLBeXU9WgyNOWQsNlGoGI3kLWf5wKdKN2pfosN7eJ2PMG0Iq3K/NdO/JPZjHYD6aOjOTp+93HrsZQczJGeQ+ecXZcLVVAsR9RK0mcLkpmTe40hoiaa2T41kFuk/HosCLtvVNE6TWNEnHrgJCnksPHKP7nHruXj15l2+H4bzJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OwBKI3C4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OwBKI3C4"
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 45F6920B7169; Fri, 17 Jul 2026 19:49:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45F6920B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784342944;
	bh=SOnWjLNM5/oT91+v9QIK90ipsn1qlyZ8XKKBA2dE2UM=;
	h=From:To:Subject:Date:From;
	b=OwBKI3C4Agv2Gl9g8yuMf/ozecoYtvyYEAhrudWwy5voDqhOb/eiwvLtTPTNnYLg3
	 vdC3hH/whLV+hrxVxTQtLzMFXmPM1GCk3SUINH246TqtlpZf3p0ypntu/rIRcigdcJ
	 8MqXuldvCE9BJdPrfYhvVwVDtiS95aIstcygpIB4=
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
Subject: [PATCH net] net: mana: Return error code from mana_create_rxq()
Date: Fri, 17 Jul 2026 19:48:18 -0700
Message-ID: <20260718024818.560552-1-gargaditya@linux.microsoft.com>
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

Change mana_create_rxq() to return an int and pass the created rxq back
to the caller through an output parameter. The caller now propagates the
returned error code directly instead of substituting -ENOMEM.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 21 ++++++++++---------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 9d9bfd116dab..9162e356e0c1 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -2811,9 +2811,9 @@ static int mana_create_page_pool(struct mana_rxq *rxq, struct gdma_context *gc)
 	return 0;
 }
 
-static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
-					u32 rxq_idx, struct mana_eq *eq,
-					struct net_device *ndev)
+static int mana_create_rxq(struct mana_port_context *apc, u32 rxq_idx,
+			   struct mana_eq *eq, struct net_device *ndev,
+			   struct mana_rxq **rxq_out)
 {
 	struct gdma_dev *gd = apc->ac->gdma_dev;
 	struct mana_obj_spec wq_spec;
@@ -2829,7 +2829,7 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	rxq = kvzalloc_flex(*rxq, rx_oobs, apc->rx_queue_size);
 	if (!rxq)
-		return NULL;
+		return -ENOMEM;
 
 	rxq->ndev = ndev;
 	rxq->num_rx_buf = apc->rx_queue_size;
@@ -2923,14 +2923,16 @@ static struct mana_rxq *mana_create_rxq(struct mana_port_context *apc,
 
 	mana_gd_ring_cq(cq->gdma_cq, SET_ARM_BIT);
 out:
-	if (!err)
-		return rxq;
+	if (!err) {
+		*rxq_out = rxq;
+		return 0;
+	}
 
 	netdev_err(ndev, "Failed to create RXQ: err = %d\n", err);
 
 	mana_destroy_rxq(apc, rxq, false);
 
-	return NULL;
+	return err;
 }
 
 static void mana_create_rxq_debugfs(struct mana_port_context *apc, int idx)
@@ -2963,9 +2965,8 @@ static int mana_add_rx_queues(struct mana_port_context *apc,
 	int i;
 
 	for (i = 0; i < apc->num_queues; i++) {
-		rxq = mana_create_rxq(apc, i, &apc->eqs[i], ndev);
-		if (!rxq) {
-			err = -ENOMEM;
+		err = mana_create_rxq(apc, i, &apc->eqs[i], ndev, &rxq);
+		if (err) {
 			netdev_err(ndev, "Failed to create rxq %d : %d\n", i, err);
 			goto out;
 		}
-- 
2.43.0

