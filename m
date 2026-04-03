Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774A618BBAE;
	Fri,  3 Apr 2026 07:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775200207; cv=none; b=GS5AFLzgOqzHWHovvVSdkYCW313RcO9kxHxmOYqAhMh2ejvSy9alsDFDxAinbqUFzZsL0XOXfIZIcu/Xq6jem4w2G7rNQjw9piD6wCax0n2HDCxoW2VGpc6X5rZJoD6Z8GEu2+k3MefGDu0A5QSHCY68y/EjzrxqJL3b68MhLJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775200207; c=relaxed/simple;
	bh=/pU5A3xBq86VS1vAri5aQXl3uYXYcF2a0cSpoh8LkGU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hXTWrEFeYAy2T+VGBkOU1Z3szI1jQEfJVkYuVItkk8b1SXWyf0Tkj2Gn8ZKOO1cHOu4ldTGHD28aQZvQQ6Y+1qe9kjTqcfffSRF+R6V/2h0+eUezlw2kd4i/QhlFJKNP8a56vrzztdWlIro0JC1D1rOMiHWh5kVS+HikRmmLJEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n3Qwr+uA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n3Qwr+uA"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id 385A620B710C; Fri,  3 Apr 2026 00:10:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 385A620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775200206;
	bh=2p3sm93ntdgO9xv/cGtBdCj2MVo7aGQL6Rx5fp5dy44=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=n3Qwr+uAdD4s5WB3wCZka8tnPN8NmqVXAIN4Kv+lSmN8rrSCxco22URj57QmBhAPQ
	 KLV4vnSLFEzmCPpCSl5pPQS0T99yxlgjBvyQ5BH8NM3qTj2868W053UCPTMOLV4b6+
	 5SlyrCWowQlDujRxZv90yHvxd8lWjLLgsEkRVk5A=
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
Subject: [PATCH net-next 2/4] net: mana: Init gf_stats_work before potential error paths in probe
Date: Fri,  3 Apr 2026 00:09:41 -0700
Message-ID: <20260403070948.9225-3-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260403070948.9225-1-ernis@linux.microsoft.com>
References: <20260403070948.9225-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move INIT_DELAYED_WORK(gf_stats_work) to before mana_create_eq(),
while keeping schedule_delayed_work() at its original location.

Previously, if any function between mana_create_eq() and the
INIT_DELAYED_WORK call failed, mana_probe() would call mana_remove()
which unconditionally calls cancel_delayed_work_sync(gf_stats_work)
in __flush_work() or debug object warnings with
CONFIG_DEBUG_OBJECTS_WORK enabled.

Fixes: be4f1d67ec56 ("net: mana: Add standard counter rx_missed_errors")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
 drivers/net/ethernet/microsoft/mana/mana_en.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/ethernet/microsoft/mana/mana_en.c
index 57f146ea6f66..f6ad46736418 100644
--- a/drivers/net/ethernet/microsoft/mana/mana_en.c
+++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
@@ -3635,6 +3635,8 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 		INIT_WORK(&ac->link_change_work, mana_link_state_handle);
 	}
 
+	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
+
 	err = mana_create_eq(ac);
 	if (err) {
 		dev_err(dev, "Failed to create EQs: %d\n", err);
@@ -3709,7 +3711,6 @@ int mana_probe(struct gdma_dev *gd, bool resuming)
 
 	err = add_adev(gd, "eth");
 
-	INIT_DELAYED_WORK(&ac->gf_stats_work, mana_gf_stats_work_handler);
 	schedule_delayed_work(&ac->gf_stats_work, MANA_GF_STATS_PERIOD);
 
 out:
-- 
2.34.1

