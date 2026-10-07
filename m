Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040E23F412C
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400113; cv=none; b=NYfLZRqGwuZ/c71P+AugPRONCLAN4j4iaze4dG2N4+sROjd3QrYRTxzVPQGHRBYtBGj0Dhme0EY/+oMQWrKvGXtbHROhii5D7wW0ItiaialjZVhzJNssTLWvO7LnahRuzwmf6Wyz76bdJ1oxYey1mIxk+34nXhMkVQujyva0+Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400113; c=relaxed/simple;
	bh=TRpxXbgK5feIIYYPp3hVJ6rrLvZGyM6h7dKswG/XLYs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EhQsraftDPd9ml/gAxRAZdMk67mNE2WU0BfgmFdu8UFG8qs+hk0IZ/vRxbtDz6wqCpJSca3mJmtqfcePGgR9v5gclPqrsRh+MHi51M8Kyqxo5BflydQI0nGA+qPkddviJxnV80NPgnmncBpp1Am73KdCYX3L2D0gaaYS4hzbETE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NmH9OvQ9; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NmH9OvQ9"
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7c19c6721a3so1245068137.2
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400111; x=1792004911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qq3ASsoCUV2DexwqH8oicxx6PUf60jRNmxlUA0Nsl+A=;
        b=NmH9OvQ9ys9kfhuL7X4g8z5SBo+5vCZOvmK0SL5USdK8vxC5PXgLmLFlMIavvgjntk
         xatoJAfDxCDnMpyme4H6oGolQ/ezOYcBDJi6dsQuzDLv+vUfvgGIJK9L7a1OxJ8w9geT
         NR9pGWZcFCFnkfDMU5HP4D1O4EL1awjhbAWN1aKv9JTvPzrQx2uA09zoRsbsCGipdJ+R
         wtzhtwyaJwGOpOPVjR/7FEFOcNLrbLHwyiLm+iFM1+HieAz97c0xXps7+SsMpkL3oAFh
         YoCDe7I9l9F6QKBX7mqfDqgnxcC3bztBjB0V5E/wKNi2lWtsQS662UTnmemBt7ccB8mO
         UNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400111; x=1792004911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qq3ASsoCUV2DexwqH8oicxx6PUf60jRNmxlUA0Nsl+A=;
        b=BL7jXWL5omO/vxTVldyY1LpBvRwzmJKDuxCLtRXtZJZFFO/OWUrSZOJpZd2ukWs7Dz
         8s+gdGhCcwySamzIdLKahS5/0+WolrGl+XctyQXLFLaR1dnMg+qE5QiZUnscL3WrSvx6
         d3fKzakTigCKxeGHaLcUrpF89+vAMuI2nxFhcU19dAYLYmSxNseLdlHsz1uyXRS74tkK
         tE5a79frjZbWKfmxLortPRy2r9L6WE5M0MJp2WBTc0saIeF2Yi3Z4wXR3z/DKtvAb3MD
         W7BHnbCzA52de0IlKgkzMhuArKqdqxH93LrQblA7JjbnRdRzGxiixZTAHsd+r0kUMgGs
         k8lg==
X-Forwarded-Encrypted: i=1; AKwUvByyEEAuMLl9D2QAI0hUv+fj44c/VviSg06zckAcENm6mKOgmnniCCZsOGtKiQ5XDVgRR5Ju3/bxYRvxHNs=@vger.kernel.org
X-Gm-Message-State: AFq9FYK02b0qLx4qKaKLRKttlVKEZj1etXH6h8wRbiHizf4VzI6ELzIl
	ao3iZLkduoDo4312JhGl8YfZ/i04Dz6FazTmArRKvs/iXqcAG6ki0tV/
X-Gm-Gg: AYBFou3we1zYXGeIrz+d05wZqOnUByCJN68oe6wrO5hA3VZIcncjxrBTYdXW682t4Pv
	Jcz35WAA2Kkp2lyTseQoykexAxZs0iECi3M91lxNvRn4XqZqb8m/GiFw3PLGIB5Tql9jszP7OsJ
	swdqYMtL8xkUgd3tIeO1qKa+sHtjgX6FsFgEutu88HocLhzwVo0Akd2Pw4XN7EVA/1XiXCPctLj
	lr0+dMOKxT3Oaad1fgLYYJ3mLg1YHGbG3GTE2O8s3pdmD7yS7v/+1dMIWF5iQ58Jx7f/rlAUBve
	5UBbsf9wT3SOlZnZXqWxb3ecYGRLa68JVBSFV550Nd9xskVrDDkJie3J58TnWlwx5GqXJVbR3Wv
	pNAua9yo1VzQFW40rlqtLN0+mNdl8pL/WZwExjECwYXmyAidAmZG6oN/AP0Q0wVM9lMMIcIV+l4
	4FL1i5FZj/ML2AJCGROkBMLJZLjL5k9izSNujky5bl44QjqILxs1hqYnw4u0nsx2PYiHcAJBEj/
	KAC7VVTFyQGcQxJYAA=
X-Received: by 2002:a05:6102:688f:b0:7bc:1de3:39b0 with SMTP id ada2fe7eead31-7ca38f28c27mr1015513137.32.1791400110798;
        Wed, 07 Oct 2026 12:08:30 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:30 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH v2 05/14] hv: vmbus: add KUnit test for order-zero allocation fallback
Date: Wed,  7 Oct 2026 16:07:43 -0300
Message-ID: <20261007190752.336426-6-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Factor the order-descent allocation loop so KUnit can inject failures
for orders above zero while retaining a real order-zero allocation in
the test path. Also verify clean exhaustion when the order-zero attempt
fails.

The factoring keeps the per-order GFP policy of the loop it replaces.
Speculative attempts above order 0 still carry __GFP_COMP together with
__GFP_NORETRY | __GFP_NOWARN so they cannot OOM-kill, and the order-0
attempt is still the plain GFP_KERNEL | __GFP_ZERO final fallback that
is allowed to try harder. Reusing one gfp across the whole descent
would leave __GFP_NORETRY set on the order-0 attempt and silently
weaken that last resort.

The case joins the others in drivers/hv/vmbus_buffer_test.c, built
into the hv_vmbus object. vmbus_alloc_pages_with_fallback() and its
callback type are therefore declared in hyperv_vmbus.h instead of
staying static in channel.c. Nothing outside hv_vmbus links against
them, and no symbol is exported.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c           | 56 ++++++++++++++++++++++----------
 drivers/hv/hyperv_vmbus.h      | 13 ++++++++
 drivers/hv/vmbus_buffer_test.c | 58 ++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 16 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 6a1bc9b17869..0c025a12808a 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -60,6 +60,31 @@ bool vmbus_buffer_lower_order(unsigned int *order)
 	return true;
 }
 
+struct page *vmbus_alloc_pages_with_fallback(int nid, gfp_t gfp,
+					     unsigned int *order,
+					     vmbus_alloc_pages_fn alloc,
+					     void *context)
+{
+	struct page *page;
+
+	do {
+		gfp_t try_gfp = gfp;
+
+		/*
+		 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing,
+		 * but try harder at order 0 since that is the final
+		 * fallback.
+		 * __GFP_COMP stores order information in the page folio.
+		 */
+		if (*order)
+			try_gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
+
+		page = alloc(context, nid, try_gfp, *order);
+		if (page || !vmbus_buffer_lower_order(order))
+			return page;
+	} while (true);
+}
+
 bool vmbus_buffer_should_free(const struct vmbus_buffer *buffer)
 {
 	return !buffer->leak && !buffer->gpadl.leak &&
@@ -774,6 +799,14 @@ void vmbus_release_buffer(struct vmbus_buffer *buffer)
 }
 EXPORT_SYMBOL_GPL(vmbus_release_buffer);
 
+static struct page *vmbus_alloc_pages_node(void *context, int nid,
+					   gfp_t gfp,
+					   unsigned int order)
+{
+	(void)context;
+	return alloc_pages_node(nid, gfp, order);
+}
+
 /**
  * __vmbus_alloc_buffer - allocate host-visible, virtually-contiguous backing.
  *
@@ -837,26 +870,17 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	while (remaining) {
 		struct page *page;
 		gfp_t gfp;
+		int nid;
 
 		order = vmbus_buffer_order(remaining, order);
 
-		/*
-		 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing,
-		 * but try harder at order 0 since that is the final
-		 * fallback.
-		 * __GFP_COMP stores order information in the page folio.
-		 */
 		gfp = GFP_KERNEL | __GFP_ZERO;
-		if (order)
-			gfp |= __GFP_COMP | __GFP_NORETRY | __GFP_NOWARN;
-
-		page = alloc_pages_node(cpu_to_node(channel->target_cpu),
-					gfp, order);
-		if (!page) {
-			if (!vmbus_buffer_lower_order(&order))
-				goto err;
-			continue;
-		}
+
+		nid = cpu_to_node(channel->target_cpu);
+		page = vmbus_alloc_pages_with_fallback(nid, gfp, &order,
+						       vmbus_alloc_pages_node, NULL);
+		if (!page)
+			goto err;
 
 		ret = set_memory_decrypted((unsigned long)page_address(page),
 					   1U << order);
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index bb585ac2ceac..e08c472041d5 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -563,6 +563,19 @@ unsigned int vmbus_buffer_order(unsigned long remaining,
 bool vmbus_buffer_lower_order(unsigned int *order);
 bool vmbus_buffer_should_free(const struct vmbus_buffer *buffer);
 
+/*
+ * Order-descent allocation, shared with vmbus_buffer_test.c so the
+ * cases can inject per-order failures. Defined in channel.c, built
+ * into the hv_vmbus object, never exported.
+ */
+typedef struct page *(*vmbus_alloc_pages_fn)(void *context, int nid,
+					     gfp_t gfp,
+					     unsigned int order);
+struct page *vmbus_alloc_pages_with_fallback(int nid, gfp_t gfp,
+					     unsigned int *order,
+					     vmbus_alloc_pages_fn alloc,
+					     void *context);
+
 /*
  * GPADL post and response helpers, also shared with vmbus_buffer_test.c.
  * Same deal as the sizing helpers above: defined in channel.c, built into
diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_test.c
index fbf7c4351d64..60fc526af1af 100644
--- a/drivers/hv/vmbus_buffer_test.c
+++ b/drivers/hv/vmbus_buffer_test.c
@@ -257,12 +257,70 @@ static void vmbus_gpadl_teardown_post_failure_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, context.call_count, 1U);
 }
 
+struct vmbus_buffer_page_alloc_test_context {
+	struct kunit *test;
+	unsigned int attempts;
+	unsigned int expected_order;
+	bool fail_order_zero;
+};
+
+static struct page *vmbus_buffer_test_alloc_page(void *context, int nid,
+						 gfp_t gfp,
+						 unsigned int order)
+{
+	struct vmbus_buffer_page_alloc_test_context *test_context = context;
+
+	(void)nid;
+	KUNIT_EXPECT_EQ(test_context->test, order,
+			test_context->expected_order);
+	test_context->attempts++;
+	if (test_context->expected_order)
+		test_context->expected_order--;
+
+	if (order)
+		return NULL;
+	if (test_context->fail_order_zero)
+		return NULL;
+
+	return alloc_pages(gfp, 0);
+}
+
+static void vmbus_buffer_order_zero_allocation_test(struct kunit *test)
+{
+	struct vmbus_buffer_page_alloc_test_context context = {
+		.test = test,
+		.expected_order = MAX_PAGE_ORDER,
+	};
+	struct page *page;
+	unsigned int order = MAX_PAGE_ORDER;
+
+	page = vmbus_alloc_pages_with_fallback(0, GFP_KERNEL, &order,
+					       vmbus_buffer_test_alloc_page, &context);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	KUNIT_EXPECT_EQ(test, order, 0U);
+	KUNIT_EXPECT_EQ(test, context.expected_order, 0U);
+	KUNIT_EXPECT_EQ(test, context.attempts, (unsigned int)MAX_PAGE_ORDER + 1);
+	__free_pages(page, 0);
+
+	context.attempts = 0;
+	context.expected_order = MAX_PAGE_ORDER;
+	context.fail_order_zero = true;
+	order = MAX_PAGE_ORDER;
+	page = vmbus_alloc_pages_with_fallback(0, GFP_KERNEL, &order,
+					       vmbus_buffer_test_alloc_page, &context);
+	KUNIT_EXPECT_PTR_EQ(test, page, NULL);
+	KUNIT_EXPECT_EQ(test, order, 0U);
+	KUNIT_EXPECT_EQ(test, context.expected_order, 0U);
+	KUNIT_EXPECT_EQ(test, context.attempts, (unsigned int)MAX_PAGE_ORDER + 1);
+}
+
 static struct kunit_case vmbus_buffer_test_cases[] = {
 	KUNIT_CASE(vmbus_buffer_size_rounding_test),
 	KUNIT_CASE(vmbus_buffer_size_overflow_test),
 	KUNIT_CASE(vmbus_ring_fallback_order_zero_test),
 	KUNIT_CASE(vmbus_buffer_failed_teardown_leaks_test),
 	KUNIT_CASE(vmbus_buffer_partial_allocation_cleanup_test),
+	KUNIT_CASE(vmbus_buffer_order_zero_allocation_test),
 	KUNIT_CASE(vmbus_gpadl_post_failure_test),
 	KUNIT_CASE(vmbus_gpadl_post_success_test),
 	KUNIT_CASE(vmbus_gpadl_response_state_test),
-- 
2.43.0

