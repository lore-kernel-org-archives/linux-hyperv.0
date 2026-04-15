Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EE593CC9FD;
	Wed, 15 Apr 2026 08:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776240590; cv=none; b=LLKphzvh5OE2sh+wh6QDSQ98+N21ScFv936JADlnV4LeQ/zyplKbB36EfBT9j2d4No32t8XsE1Lo0cQOiskdSdIMMJo0WigWSphd7nWliymszfO57VAt44+0WXt/QTTamq1Igpp3N0Pku31nHZSsdDkEGwo1wc6g2lnpjDN+KAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776240590; c=relaxed/simple;
	bh=MCDfnbc2rfwekHxL8zm0sBnGyWdgeI7+CMo8UNBwB4w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MqtD5PbO6n19V9uA8cSShtam/EGUqoQzhMXejtHOIHQbI8V4NKtZTz2VcuceRlyaR8hcbwwJrF7SUdTDnxWrOWwkKtMJl2Fvihl/lUDWvuGSp7pp2K0PoWaAh9pqGpUNk/GaSp7WaFJLncf3haokNfPTdDZoT1bF22NLyTqRDjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bdYK6bOb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bdYK6bOb"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 853F820B7128; Wed, 15 Apr 2026 01:09:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 853F820B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776240587;
	bh=Gi9uAMZ3o8x3SKpfNIETP0JZnX/4FC7fDfxBAeXJbYg=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=bdYK6bObnsgQyqMxbEotSK1+qh6NctGGekCoFbhgij92CczSdQKGrEay8Vj05RWT/
	 OSOm/TeOWXUhJ5ZFSfBa1UGg/AJ/KSTutSHWE8DUo4Mprf+ILDuNFXFjV/XvyjPDso
	 AOjMjlB39qkuUMR8e0Ylo3z80BcmN/89CptPYIGA=
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
	shirazsaleem@microsoft.com,
	kees@kernel.org,
	kotaranov@microsoft.com,
	leon@kernel.org,
	shacharr@microsoft.com,
	stephen@networkplumber.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 3/5] net: mana: Guard mana_remove against double invocation
Date: Wed, 15 Apr 2026 01:09:39 -0700
Message-ID: <20260415080944.732901-4-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260415080944.732901-1-ernis@linux.microsoft.com>
References: <20260415080944.732901-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If PM resume fails (e.g., mana_attach() returns an error), mana_probe()
calls mana_remove(), which tears down the device and sets
gd->gdma_context = NULL and gd->driver_data = NULL.

However, a failed resume callback does not automatically unbind the
driver. When the device is eventually unbound, mana_remove() is invoked
a second time. Without a NULL check, it dereferences gc->dev with
gc == NULL, causing a kernel panic.

Add an early return if gdma_context or driver_data is NULL so the second
invocation is harmless. Move the dev = gc->dev assignment after the
guard so it cannot dereference NULL.

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network Adapter (MANA)")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v3:
* Add this patch to the patchset
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 468ed60a8a00..ce1b7ec46a27 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3731,11 +3731,16 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
 	struct gdma_context *gc = gd->gdma_context;
 	struct mana_context *ac = gd->driver_data;
 	struct mana_port_context *apc;
-	struct device *dev = gc->dev;
+	struct device *dev;
 	struct net_device *ndev;
 	int err;
 	int i;
 
+	if (!gc || !ac)
+		return;
+
+	dev = gc->dev;
+
 	disable_work_sync(&ac->link_change_work);
 	cancel_delayed_work_sync(&ac->gf_stats_work);
 
-- 
2.34.1

