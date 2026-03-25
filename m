Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 576D5182D0
	for <linux-hyperv@vger.kernel.org>; Wed, 25 Mar 2026 04:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774414224; cv=none; b=f0h7ZWIgR5c3l8+NQ2FpqFIloZ5tst05d9NwU2O5OEaUJYDbYQ/LDrhZ1gbBtvIR7oi/1QFofRxLAE1SHJkWvnZHmO9D4nPjiNY85ApFHL1CjRR3XhgIA3z9lQYqOKmzpE3u3BzmvOTlEjOJjL6U3ZXkrYpoHl3+tQAD/dQ7vaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774414224; c=relaxed/simple;
	bh=NOnb5W0LQimumxs5VACbGVyOcdX2vuC/C5pyx+AnOMU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XuBXfO5/f0UUhtBaDrN8OnOpUZiXwO+jh6PgKt4EQb3MT1jVLKHNX/fLku/P1OfVDTtunbGN8aqH2iPGisneNVCDPDDBwRJLLHb/qH5UV7LbuE1nBxwlEQIhyduCa7zQCfKxj3snE0lPgby0tQOBtNarRZNpW1IIJOxXCnevB/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aDrGqfSv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aDrGqfSv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774414222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pJnh0qeblB7QuhQfb4FwZ71GL5PXvoes3ViBRQuiUG0=;
	b=aDrGqfSvtoTmeGs6XSPD1uoEdWhXdG8TyKgQVJKUZPZECsZjtvBJY2b7Hfus0TR4CsyIq7
	j1AbdLPR54PAd8AIZYCSMrjk9C/o9DzG52ggpxdyor9t42YOC6gMMl0FxG3miPra8y3R3v
	nwlqz8YIrtDqvnv6STnNNcxjYhVwoeI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-597-xM6s-7JXM86MTFsko1JMMA-1; Wed,
 25 Mar 2026 00:50:18 -0400
X-MC-Unique: xM6s-7JXM86MTFsko1JMMA-1
X-Mimecast-MFC-AGG-ID: xM6s-7JXM86MTFsko1JMMA_1774414216
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8BA80195608B;
	Wed, 25 Mar 2026 04:50:16 +0000 (UTC)
Received: from localhost.redhat.com (unknown [10.72.112.30])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 51C301800361;
	Wed, 25 Mar 2026 04:50:09 +0000 (UTC)
From: Li Tian <litian@redhat.com>
To: netdev@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jason Wang <jasowang@redhat.com>,
	Li Tian <litian@redhat.com>
Subject: [PATCH net] netvsc: transfer lower device max tso size during VF transition
Date: Wed, 25 Mar 2026 12:50:06 +0800
Message-ID: <20260325045006.18607-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

When netvsc is accelerated by the lower device, we can advertise the
lower device max tso size in order to get better performance.
While a long-term migration to user-space bonding is planned, current
users on RHEL 10 / Azure are experiencing significant performance
regressions in 802.3ad environments. This patch provides a localized,
safe fix within netvsc without introducing new core networking helpers.

Signed-off-by: Li Tian <litian@redhat.com>
---
 drivers/net/hyperv/netvsc_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
index ee5ab5ceb2be..971607c7406f 100644
--- a/drivers/net/hyperv/netvsc_drv.c
+++ b/drivers/net/hyperv/netvsc_drv.c
@@ -2428,10 +2428,14 @@ static int netvsc_vf_changed(struct net_device *vf_netdev, unsigned long event)
 		 * This value is only increased for netvsc NIC when datapath is
 		 * switched over to the VF
 		 */
-		if (vf_is_up)
+		if (vf_is_up) {
 			netif_set_tso_max_size(ndev, vf_netdev->tso_max_size);
-		else
+			WRITE_ONCE(ndev->gso_max_size, READ_ONCE(vf_netdev->gso_max_size));
+			WRITE_ONCE(ndev->gso_ipv4_max_size,
+				   READ_ONCE(vf_netdev->gso_ipv4_max_size));
+		} else {
 			netif_set_tso_max_size(ndev, netvsc_dev->netvsc_gso_max_size);
+		}
 	}
 
 	return NOTIFY_OK;
-- 
2.53.0

