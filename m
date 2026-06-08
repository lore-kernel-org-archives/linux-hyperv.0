Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C708C1CAA68;
	Mon,  8 Jun 2026 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780913645; cv=none; b=oRXBUi4f7EJolXtJsnhXFyjAvUp/+offht0e16d0ZuzRf9jTKABPhteu0Cv+1J8LFPgcovVVFLvXyqrhtNNXphMAMcFKlen2zP60VRgXCaf/AvQ8x7Bjgla96XE6sbooGXTzbsavT29DQSVJJ5EbVCHqlXuRvMSO/ZJhglWr3mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780913645; c=relaxed/simple;
	bh=7sqsPSlC62BXb8yb/9Brgirj38bkv4Q15+uoFfoYe/w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S4I1qFPR3zfcda/DxAT/QpzSBIHsShQ97khT8UELDliuKfNJy1/CGMtGJKeIaQi7aBXge8JGv9Q0EErnTLC66SbKlqjH/pp43r7taZxAbsiF8WZHRPK94V+flATwVhCNLHsfHQ5n5VEIhM107TBFlDjY2LRYBWSZuB7eYcOSz+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lWIvpzpu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lWIvpzpu"
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id D39DC20B7167; Mon,  8 Jun 2026 03:13:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D39DC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780913627;
	bh=o8krHEL94k3Devk000JfdtoizGMtQGBbfvLaItOxdKg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=lWIvpzpuVOT1ewGCrw4W5sc3d9aL3MNkyD24aS8k/MG9FlA3/EbwQumpd+i7Ezt5F
	 kWpNwB/kQu98SPUSlBalvBtYrMghx3qPevHS8+zmjU8zN3vkc6SKCymkfW6A69hEO5
	 g7wONGSWYhHzd/bxjBmumwmuufARKtgP3MvLm7iI=
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
Subject: [PATCH net v2 1/2] net: mana: initialize gdma queue id to INVALID_QUEUE_ID
Date: Mon,  8 Jun 2026 03:13:40 -0700
Message-ID: <20260608101345.2267320-2-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
References: <20260608101345.2267320-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_gd_create_mana_wq_cq() leaves queue->id as 0 (from kzalloc_obj())
until mana_create_wq_obj() assigns the firmware-returned id. If creation
fails before that, cleanup calls mana_gd_destroy_cq() with id 0, NULLing
gc->cq_table[0] and silently breaking whichever real CQ owns that slot.

Initialize queue->id to INVALID_QUEUE_ID right after allocation, matching
mana_gd_create_eq(). The existing (id >= max_num_cqs) guard then
short-circuits cleanly.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Dipayaan Roy <dipayanroy@linux.microsoft.com>
Reviewed-by: Haiyang Zhang <haiyangz@microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/gdma_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index d8e816882f02..ac71ca8450bf 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -1192,6 +1192,8 @@ int mana_gd_create_mana_wq_cq(struct gdma_dev *gd,
 	if (!queue)
 		return -ENOMEM;
 
+	queue->id = INVALID_QUEUE_ID;
+
 	gmi = &queue->mem_info;
 	err = mana_gd_alloc_memory(gc, spec->queue_size, gmi);
 	if (err) {
-- 
2.43.0

