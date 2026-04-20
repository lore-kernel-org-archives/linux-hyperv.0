Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC339FCC5;
	Mon, 20 Apr 2026 12:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776689266; cv=none; b=r7TBPplaG4usvtrdljn3iWEXTfsWWhVC+mRVvpPLGHQN7KeYFxMBCKUGALH1YWi7zbMxSon17l+FSImo0R8SwB0Oml3y0H1xXvISIVStuFqVSs7RqoXpnrqyJKUcM9AWSAdpwnD3Z9PwjM/LKYOsVULpA3DoRp7S0I5IZglr9R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776689266; c=relaxed/simple;
	bh=P2kt/CKC5yu9pr1ZKCk7iyd6LOBo0Pl3p47ol6qO+8Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JILj1BV0NL1zi603m7jVDuSiCInX6ZVHgfrDiOI9rl/J1renL15XePDBnr0h0nlG6ZrkWHmLZp226s1I8jFXkzX57EMM5dUf6plqOjEnicur2S4DGfANJeBGz8uLzl6JawV/99RlzD6i1i1ZPTqK5U8sEIFFJ6cTRoI3fbtk9mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O0ywJ7ki; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O0ywJ7ki"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id B0CCE20B7007; Mon, 20 Apr 2026 05:47:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B0CCE20B7007
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776689265;
	bh=0fhaBQOr7Jyp7EGbiMAXQbIjNs9S2T+A2SatmDBiXM4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=O0ywJ7kiaWWSceUWcpgi0YcNXs2/+f6MPJrwMURQCW3oDpCZCn35GJ8QzjDvxQhrq
	 2tF64+5G7M19glKp1OvBZU8p2seF/a95ctE9vvSPmaU2XkTVapch2nwEl45Aw081Jr
	 dR5eygVyWL5MXf9BF/96P90H4iKa04pUbf25IZuY=
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
Subject: [PATCH net v4 3/5] net: mana: Guard mana_remove against double invocation
Date: Mon, 20 Apr 2026 05:47:37 -0700
Message-ID: <20260420124741.1056179-4-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260420124741.1056179-1-ernis@linux.microsoft.com>
References: <20260420124741.1056179-1-ernis@linux.microsoft.com>
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

Fixes: 635096a86edb ("net: mana: Support hibernation and kexec")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v4:
* Update Fixes tag to 635096a86edb
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

