Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2623E44E651
	for <linux-hyperv@vger.kernel.org>; Wed, 26 Aug 2026 17:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787765864; cv=none; b=XYzTXh+yT07x6AgeFT3g/KLzdUj/b0ehK1MHA8/HTFRmeuKg5roE6CeRGGw2tLHHnr5z+fivfvT+r1hSO97vl+jdH7YcCuUYGHWK/psUyYkRjMMHB+m0/JV22SJPy5NlVZqYNmTQZnwY+vzs7I3YmE8EH72u1HkW1sc6fm1H8G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787765864; c=relaxed/simple;
	bh=J56Od10YjLBfXjaRtkbFgU50yw7N6bEFMogt4hSy9o4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lkvAd2yLS+FHiIRXaEUSKgPE/iiJIkvGIm/NMlvFHVGiD88fzeifn5guAe1///plQAcIxYwlX0e3N5xV0s9ZDRQS6y/MUbDjZjlphqmm1KG9E39lPy0yVJ5WSjA5b3EDJiDXJQUVRN3lKtpHg6HcUSJbLhGOBbQY4PK9zv5OzzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AnUnB1Pz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AnUnB1Pz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787765852;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=f7NGWrMVOmUns/2V3+RO3qremiV9F2t/yCezPuNANs4=;
	b=AnUnB1PziyLYNxIyC3p7uDXoFsiM2DWkod0AiwR4tamSBfLUQppCre8qIKhzBl4qbw/Jl7
	CMHSUKV8bz5QMtyTaDv6AkOljqeuBHQII9CtcHboIgYs7OrHq/wu/4QD4nf3+XmI61iI30
	XLxUask/MoSu9/0WzFmZFgK9GnGEGcY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-522-wV5FI6iTPKWlzZKe162mDw-1; Wed,
 26 Aug 2026 13:37:28 -0400
X-MC-Unique: wV5FI6iTPKWlzZKe162mDw-1
X-Mimecast-MFC-AGG-ID: wV5FI6iTPKWlzZKe162mDw_1787765846
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 296B91862D5C;
	Wed, 26 Aug 2026 17:37:26 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.rmtusnh.csb (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1CB5E1800598;
	Wed, 26 Aug 2026 17:37:23 +0000 (UTC)
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
Subject: [PATCH] Drivers: hv: Avoid infinite retry loop in init_vp_index()
Date: Wed, 26 Aug 2026 13:37:10 -0400
Message-ID: <20260826173710.511604-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

There is a retry loop in init_vp_index() where the CPUs from a certain
node are stripped out if they have already been in the allocated cpumask
or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
CPU left, the allocated cpumask is ignored and the process is retried
again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
out not to contain any CPU in that particular node, that will become an
infinite retry loop.  This particular problem was reported by sashiko
[1]. This should rarely happen, but we still need to guard against this.

Fix this infinite loop problem by ignoring the HK_TYPE_MANAGED_IRQ
housekeeping cpumask if the allocated cpumask has already been
cleared before. Since the HK_TYPE_MANAGED_IRQ housekeeping cpumask
is supposed to be used on a best effort basis, it is OK to ignore it
in this particular case. Also add a check_hkcpu boolean flag in struct
vmbus_channel to control the HK_TYPE_MANAGED_IRQ housekeeping CPU check
in target_cpu_store() and init_vp_index().

Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kernel.org [1]
Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/hv/channel_mgmt.c | 14 +++++++++++---
 drivers/hv/vmbus_drv.c    |  3 ++-
 include/linux/hyperv.h    |  7 +++++++
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 89d214dda360..30d91668e1c5 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -774,6 +774,7 @@ static void init_vp_index(struct vmbus_channel *channel)
 	}
 
 	for (i = 1; i <= ncpu + 1; i++) {
+		channel->check_hkcpu = true;
 		while (true) {
 			numa_node = next_numa_node_id++;
 			if (numa_node == nr_node_ids) {
@@ -788,14 +789,21 @@ static void init_vp_index(struct vmbus_channel *channel)
 
 retry:
 		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
-		cpumask_and(available_mask, available_mask, hk_mask);
+		if (channel->check_hkcpu)
+			cpumask_and(available_mask, available_mask, hk_mask);
 
 		if (cpumask_empty(available_mask)) {
 			/*
 			 * We have cycled through all the CPUs in the node;
-			 * reset the allocated map.
+			 * reset the allocated map. If the allocated map has
+			 * already been cleared, we will have to ignore the
+			 * HK_TYPE_MANAGED_IRQ housekeeping cpumask as its use
+			 * is on a best effort basis, not a must.
 			 */
-			cpumask_clear(allocated_mask);
+			if (!cpumask_empty(allocated_mask))
+				cpumask_clear(allocated_mask);
+			else
+				channel->check_hkcpu = false;
 			goto retry;
 		}
 
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6824bd7cb3c4..bea578cd0aa7 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1751,7 +1751,8 @@ int vmbus_channel_set_cpu(struct vmbus_channel *channel, u32 target_cpu)
 	if (target_cpu >= nr_cpumask_bits)
 		return -EINVAL;
 
-	if (!cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
+	if (channel->check_hkcpu &&
+	    !cpumask_test_cpu(target_cpu, housekeeping_cpumask(HK_TYPE_MANAGED_IRQ)))
 		return -EINVAL;
 
 	if (!cpu_online(target_cpu))
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index a2b484679eb4..0d8df79c26ca 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -831,6 +831,13 @@ struct vmbus_channel {
 	 */
 	bool out_full_flag;
 
+	/*
+	 * Check target_cpu in target_cpu_store() to make sure that it is in the
+	 * HK_TYPE_MANAGED_IRQ housekeeping cpumask and reject it if not when
+	 * the flag is set.
+	 */
+	bool check_hkcpu;
+
 	/* Channel callback's invoked in softirq context */
 	struct tasklet_struct callback_event;
 	void (*onchannel_callback)(void *context);
-- 
2.55.0

