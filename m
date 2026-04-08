Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3556839DBD6;
	Wed,  8 Apr 2026 08:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775635950; cv=none; b=Jk6rFGoOIx6NFDuVoSSGv0/XlXFsdzzbWTveRh8fc6AErJe3neK6lA9COcALwitrji4FI176ndMs3vkZ6J/LqM5xhdmX3Y1TFE5yxLwVt+0Mkf75HUC0sR4MbYR6jvl0pHvhYFrS5nbkSu4tgF9H0jKVjfA6E37csYGt+7e/zh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775635950; c=relaxed/simple;
	bh=cAblTvQfwrotJoILLpnjbyoJmMO6glz2n0yN/cJtnZE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p24g0JofDtEuObeAz7K5UaHOsd3KWSkD9KWJirh28J2086Cn1yrT2lO1me/sI5RZ8fsQJHNmDFYIuACBnIOwwLZCrQytXD0MAcSBXekoYvGGifm+fs8V7hyRN221Gzo+oEVyHQOBx/B+D7/ClaH1yJFlZzP1ZYjABPvtQ3d9Ybg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S2KMUohG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S2KMUohG"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 157A620B6F0C; Wed,  8 Apr 2026 01:12:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 157A620B6F0C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775635949;
	bh=7xleirn6TKgFbh1dpbQPh3EcS+3Dv0bVGkF4Fei2rj8=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=S2KMUohGQUxFJtNmEAdkooSWBwa+qgNuIg2btyITta5FyfOsbRiS37Qo1kTNnHSi+
	 QxaP4U6ynsvnsfcDaICs+Ebg/d8hmVMiF0Ee3S7+jZpQjXu49JuzYi5iSpxX6gqU4G
	 UwNB+hgEkZE0SXdE/AI152/XJNF0yxsbCQP9UOLI=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
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
	ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com,
	gargaditya@linux.microsoft.com,
	shradhagupta@linux.microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	yury.norov@gmail.com,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 2/2] net: mana: Move current_speed debugfs file to mana_init_port()
Date: Wed,  8 Apr 2026 01:12:20 -0700
Message-ID: <20260408081224.302308-3-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260408081224.302308-1-ernis@linux.microsoft.com>
References: <20260408081224.302308-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the current_speed debugfs file creation from mana_probe_port() to
mana_init_port(). The file was previously created only during initial
probe, but mana_cleanup_port_context() removes the entire vPort debugfs
directory during detach/attach cycles. Since mana_init_port() recreates
the directory on re-attach, moving current_speed here ensures it survives
these cycles.

Fixes: 75cabb46935b ("net: mana: Add support for net_shaper_ops")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 07630322545f..6302432b9bf6 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3154,6 +3154,8 @@ static int mana_init_port(struct net_device *ndev)
 	eth_hw_addr_set(ndev, apc->mac_addr);
 	sprintf(vport, "vport%d", port_idx);
 	apc->mana_port_debugfs = debugfs_create_dir(vport, gc->mana_pci_debugfs);
+	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs,
+			   &apc->speed);
 	return 0;
 
 reset_apc:
@@ -3432,8 +3434,6 @@ static int mana_probe_port(struct mana_context *ac, int port_idx,
 
 	netif_carrier_on(ndev);
 
-	debugfs_create_u32("current_speed", 0400, apc->mana_port_debugfs, &apc->speed);
-
 	return 0;
 
 free_indir:
-- 
2.34.1

