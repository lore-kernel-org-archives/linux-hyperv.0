Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ACF471252
	for <linux-hyperv@vger.kernel.org>; Wed, 26 Aug 2026 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787772357; cv=none; b=fNmockh36jbz+Umq49tewWT5qX7PCcN9SpaSaWVSdgthVDsXd/M1lktal2egDXL7n2zAqyGoqSQPO+ebgeCbOGO+p4s4FZXx3P5+8xjb8YYE/tfenLk9lCc6O0MTlZE7g73953jvN2epiwd965hWWq2Xcv/ITOeJoP+q+KNpxqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787772357; c=relaxed/simple;
	bh=VTDKVn+aa1FR7TOWMkSE/KFr/jyQmOGuAG+H/AxcJJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R2mgvqhZqP9fzK+60IpeKWnyB+EW+mCJDuBrMYGGaWTrDoxTuWHkUNrEtnha0UPSftVBEIO+HXZGyYVjLiHm7JkafxK6O+F3sVzc/Iw8wpYJGwp88rh5fzv0ovtFtti4qULpfbQMTFBiHJjrlS6df3J4PLcTRwbJOmN7/UlCIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jNqkTPLW; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jNqkTPLW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787772332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sHjqfZcCHdemnAFP2kuQbb8s6bb/4zThhyZF+luJUpg=;
	b=jNqkTPLWB2xyv+EGQEUExZiGpFKVKyIxKAhpR2aPDyUUWjjJx0OneQrUFQHMyP7dxjxkir
	aDPjS6LlxT7VKsb1momOCa/AOB5OEJ+0kdB7UVU50ACDnx2JX9y+k57kMw9+1/NpZWUik4
	gNt4rsMpYPML2lhly/NJrp3X+pfDvKg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-a2hGDbYEO8mOKPrQqX4sFQ-1; Wed,
 26 Aug 2026 15:25:28 -0400
X-MC-Unique: a2hGDbYEO8mOKPrQqX4sFQ-1
X-Mimecast-MFC-AGG-ID: a2hGDbYEO8mOKPrQqX4sFQ_1787772327
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 26C1B1955E97;
	Wed, 26 Aug 2026 19:25:27 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.rmtusnh.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D8F3434;
	Wed, 26 Aug 2026 19:25:25 +0000 (UTC)
From: Waiman Long <longman@redhat.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Waiman Long <longman@redhat.com>
Subject: [PATCH v2] Drivers: hv: Avoid infinite retry loop in init_vp_index()
Date: Wed, 26 Aug 2026 15:25:09 -0400
Message-ID: <20260826192509.529838-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

There is a retry loop in init_vp_index() where the CPUs from a certain
node are stripped out if they have already been in the allocated cpumask
or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
CPU left, the allocated cpumask is ignored and the process is retried
again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
out not to contain any CPU in that particular node, that will become an
infinite retry loop.  This particular problem was reported by sashiko
[1]. This should rarely happen, but we still need to guard against this.

Fix this infinite loop problem by skipping to the next numa node if
the allocated cpumask has already been cleared before. Set target_cpu
to the default VMBUS_CONNECT_CPU instead if the for loop is ending.

Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kernel.org [1]
Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/hv/channel_mgmt.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 89d214dda360..e80ac9fb5ed3 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -793,10 +793,20 @@ static void init_vp_index(struct vmbus_channel *channel)
 		if (cpumask_empty(available_mask)) {
 			/*
 			 * We have cycled through all the CPUs in the node;
-			 * reset the allocated map.
+			 * reset the allocated map. If the allocated map
+			 * has already been cleared, we will try the next numa
+			 * node. Set target_cpu to the default VMBUS_CONNECT_CPU
+			 * instead if the for loop is going to end.
 			 */
-			cpumask_clear(allocated_mask);
-			goto retry;
+			if (!cpumask_empty(allocated_mask)) {
+				cpumask_clear(allocated_mask);
+				goto retry;
+			}
+			if (i > ncpu) {
+				target_cpu = VMBUS_CONNECT_CPU;
+				break;
+			}
+			continue;	/* Try next numa node */
 		}
 
 		target_cpu = cpumask_first(available_mask);
-- 
2.55.0

