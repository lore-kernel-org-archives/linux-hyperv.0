Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2558A3A8FEE
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Aug 2026 21:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787864666; cv=none; b=cIAHycBjMJe7r1xR420hygVcVfMoC6Hi0JfWWh7d/FCWkaKo529qdvhkJHAL5qA7BwLhYN/fh5C8U+eizst1PIHXy6kdR9ZxWeuHFva6fQPP1ByzCPMcoGfABRPrhkQSZs6Vg+UfkDzF7CMymzULSb5mBONte1YxhzC5u0JYXeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787864666; c=relaxed/simple;
	bh=Mmzu5piDzOR5VLGdR8g1iQaVB12Pi3zQ2wPUvmLua/8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mJYwPJ4lNC/TxAOY9GelZvfy+RK0FY7Na8S+800YvWpwRDeZ39kX5lrQ3jsINRqKP8NUGmmiBkzA8wBFL42i3te4DWmWAtAAu0NvrW+Jd5Upgma7dmJpfCfXaVf1qx8SJtO/7M6RFxztLHotOOUfN3+NWizqq960/9IuPJmeWBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HessqCvS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HessqCvS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787864662;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ow8pCpus5Oqslb30nDP6hej/UoGp7POUQCVM9ygYWLY=;
	b=HessqCvSsU5jbkBlUjV2sLMu6xihNGG2bo0M512+wj8tdMcORykBui0wbMgJMko8JMKEvm
	noJIZSEJJljKd9YI+4oJvpFQDF4KqCPWNSJFHQ+5y2wPNN60PHmLdAmO1PQU22rnO1OHYY
	qppGu56ll5RWMJWsJm96CSPxBRJHFOg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-541-a5NFsN_XOTGcR-41eqdJyQ-1; Thu,
 27 Aug 2026 17:03:53 -0400
X-MC-Unique: a5NFsN_XOTGcR-41eqdJyQ-1
X-Mimecast-MFC-AGG-ID: a5NFsN_XOTGcR-41eqdJyQ_1787864601
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E1A031800657;
	Thu, 27 Aug 2026 21:03:20 +0000 (UTC)
Received: from llong-thinkpadp16vgen1.rmtusnh.csb (headnet03.pony-001.prod.iad2.dc.redhat.com [10.2.32.114])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2FDF27DF;
	Thu, 27 Aug 2026 21:03:19 +0000 (UTC)
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
Subject: [PATCH v4] Drivers: hv: Avoid infinite retry loop in init_vp_index()
Date: Thu, 27 Aug 2026 17:03:13 -0400
Message-ID: <20260827210313.670241-1-longman@redhat.com>
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

Fix this infinite loop problem by also skipping NUMA node that has no
housekeeping CPU in the inner while loop of init_vp_index(). Also update
the early abort check to check for the absence of online housekeeping
CPUs instead of just the emptiness of the cpumask. As the outer for
loop will only be reached if the housekeeping cpumask has at least one
online CPU, a NUMA node with housekeeping CPUs will eventually be found.

Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kernel.org [1]
Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs")
Signed-off-by: Waiman Long <longman@redhat.com>
---
 drivers/hv/channel_mgmt.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index 89d214dda360..9b5ac09fbcf0 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -752,13 +752,14 @@ static void init_vp_index(struct vmbus_channel *channel)
 	u32 i, ncpu = num_online_cpus();
 	cpumask_var_t available_mask;
 	struct cpumask *allocated_mask;
+	const struct cpumask *node_mask;
 	const struct cpumask *hk_mask = housekeeping_cpumask(HK_TYPE_MANAGED_IRQ);
 	u32 target_cpu;
 	int numa_node;
 
 	if (!perf_chn ||
 	    !alloc_cpumask_var(&available_mask, GFP_KERNEL) ||
-	    cpumask_empty(hk_mask)) {
+	    !cpumask_intersects(hk_mask, cpu_online_mask)) {
 		/*
 		 * If the channel is not a performance critical
 		 * channel, bind it to VMBUS_CONNECT_CPU.
@@ -780,14 +781,16 @@ static void init_vp_index(struct vmbus_channel *channel)
 				next_numa_node_id = 0;
 				continue;
 			}
-			if (cpumask_empty(cpumask_of_node(numa_node)))
+			node_mask = cpumask_of_node(numa_node);
+			if (cpumask_empty(node_mask) ||
+			    !cpumask_intersects(node_mask, hk_mask))
 				continue;
 			break;
 		}
 		allocated_mask = &hv_context.hv_numa_map[numa_node];
 
 retry:
-		cpumask_xor(available_mask, allocated_mask, cpumask_of_node(numa_node));
+		cpumask_xor(available_mask, allocated_mask, node_mask);
 		cpumask_and(available_mask, available_mask, hk_mask);
 
 		if (cpumask_empty(available_mask)) {
-- 
2.55.0

