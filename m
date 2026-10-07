Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB873FF886
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400108; cv=none; b=DJ2A0H9Cg0RrtL/z4p9Tk5ccw/oi4qGxwq/Qy4RvnHE+uTFuYAAB4zOdG5UqnlgLZYS2/oEZ0flnhY+NEwZpY2DRl5PMbFk1jkHqtbWR/eAL11Ss4C5jwWzRUFrZ4+J05xTEDYriHIUhfFUsy3AvaChm6ZL4tldWY8mFXiNaZIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400108; c=relaxed/simple;
	bh=Qwq+kY2o+T6ABRe+YklIrsklzg5y+LARPem0/vSKTos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AP4TZyuwXzxeNE33QwUrLZHvuS28isvo9KfSS8ZRIpnMcNMBczUhgearnG+w1r2e/7ktXx6/rwCHX1e2r5/3dVPDKU76174oHxaBvpSdPC3S24jyy88r4wEjQGLPxHWXKXXLbqPDQiDoDxpPQJU1M9SLL2CZFmGDrdBvSJqGx2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kwvg3eD0; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kwvg3eD0"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-98c78660542so1113568241.1
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400105; x=1792004905; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Q7IO14t1uj+VV+wwgMKYEW/4gtW1MTypzaYfTUg1s0=;
        b=kwvg3eD0WugQu9WpE0a3AFtEGCSM8zSed/mXmSqGpuuhUi7QVmTTDYycgPAPDDudX0
         EsV1PU57OMMwD5A5qf2XHhJIYyOA/eKB70IJxORXxIL1NuASr3whCKvdxIloyu0ZkJyY
         70ZzDl69IkRswYOWVugVad6oWXmpIIkf4LLmUpeXRei0Ouak8xmrb7Ga268KvmI60qDS
         VJUiKm9D1N0JEEA8ZJX0Hc2nMoNciZhs71h1NP0xDPjuRsIRdRJZKL6nsm7WjH7dYwjE
         Xg0NDsz2/j/5yc1QDlT+kZ+vu5Vq+lHLQKlPNmAyv6LvAVhHobqopRew04MrVSSbiXn2
         1eOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400105; x=1792004905;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Q7IO14t1uj+VV+wwgMKYEW/4gtW1MTypzaYfTUg1s0=;
        b=lWUT5bGiLNoSnJbO7ElfHnDMuJ2yAAtbdbLl1jpAldaAvNNcXyWwHPWCMQkUgZnKD2
         0m0joUDLwSosPev9wLYhonMb5nHEWeqWilSxxiFdPvKkalMGluun7Lr18ShJl3giPsC5
         7UO0znGu9JgawC6EXGHO3AvIl41TkoyCm0h5zm6jVWl03pdfNUGLG9c0dk18YAUmTc5W
         T5dSi7s34uLJjI4JY8o4oA7YLtaS/swB3z/KE3vcQBmqs1LTBpGgQes5+BJeZcjQSp/N
         QB9q8Sf3mmXEyPzGYSzDvXqcfl8cm+PQiYX3NEdoxiCzE9KJrb/r+kxscTlKDLDPgJyX
         k/fA==
X-Forwarded-Encrypted: i=1; AKwUvBy3oFC7/r+vimgeyVqzw3Dj66OjBmCbXrTfLgwyJNHeWXYnJKg3nGpp5u+ga49YU3DRjNviJlnzs4WwNPg=@vger.kernel.org
X-Gm-Message-State: AFq9FYJWV0UnpKM3LzAT2Op3VBz904JHA8yJgUyJnxlc1vgZmiMd+jiC
	gwoPxGLfKD+BFZcGcg0fLOZCeQhEMIGZfIOxjKrMBv/Utvnk27CLtBJb
X-Gm-Gg: AYBFou3IUgX3+9OXc1KT/RkLgUXYU3awyN9MvRp6LdYFOnhTfz3EWfThXeGgeCZQsrI
	zpF14DlVjN9w3wwBglgdLhE6dXeavuRwhFbY4u7ggBzD1Jms3Rd6h/mKHW9B4BEHvvWSPxaXoQS
	kE6wdgYQV9c8WTmmeqeiYYClrJ/Ow03rsGIcMMH1vw2Hza6hN/kfE+lKKNu88fHFax3/ejcspy9
	WX6iTVnmPXv8opVfU1PZyBeXbtUj9RCmr91H+j6O44j1x7eF+il7OZK0RzAy2BXToLHB7r9FxmC
	EeFNR3uqsIJdQdmEoKVkMUD2pkON/wLb7YpLV12cra6HPSitFyMC/C6iN34vF8eUoCUjtC3rvpq
	ocFgXpbAUSs+XMMLYMbcvbG2WNdlrhjaAaFqAows36cm37iwx6+v0IqikykogReAH+jGYXna3fV
	3NfGJLGX+e5e3ig6358Pb4AYB9LrRMBbxTt60FG6aSCI8ZCYpxzx3ffARMhZCNC9fpoOvpKJ5ro
	6wxRQdaw939sXFuGQU=
X-Received: by 2002:a05:6102:5124:b0:7c4:5129:8e17 with SMTP id ada2fe7eead31-7ca38f24bb3mr1127791137.31.1791400105188;
        Wed, 07 Oct 2026 12:08:25 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:24 -0700 (PDT)
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
Subject: [PATCH v2 04/14] hv: vmbus: add KUnit tests for GPADL post failure injection
Date: Wed,  7 Oct 2026 16:07:42 -0300
Message-ID: <20261007190752.336426-5-emersonbusson@gmail.com>
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

Route GPADL message posting through a private callback so KUnit can
inject header, each body, and teardown post failures without a live
host. Exercise uncertain host ownership after failed posts, host
rejection, and channel rescind response handling through the same
helpers used by production.

The cases join the existing ones in drivers/hv/vmbus_buffer_test.c,
which is built into the hv_vmbus object. That keeps tests out of the
production sources while still letting them drive
vmbus_post_gpadl_messages(), vmbus_gpadl_response_status() and
vmbus_post_gpadl_teardown(). Those three are therefore not static,
and their callback type is declared in hyperv_vmbus.h alongside the
sizing helpers. Nothing outside hv_vmbus links against them, and no
symbol is exported.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c           | 142 ++++++++++++++++----------
 drivers/hv/hyperv_vmbus.h      |  19 ++++
 drivers/hv/vmbus_buffer_test.c | 176 +++++++++++++++++++++++++++++++++
 3 files changed, 286 insertions(+), 51 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 7d5b99281872..6a1bc9b17869 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -488,6 +488,84 @@ static void vmbus_free_channel_msginfo(struct vmbus_channel_msginfo *msginfo)
  *              should be 0 for BUFFER type gpadl
  * @gpadl_handle: some funky thing
  */
+static int vmbus_gpadl_post_real(void *context, void *buffer,
+				 size_t buflen, bool can_sleep)
+{
+	(void)context;
+	return vmbus_post_msg(buffer, buflen, can_sleep);
+}
+
+int vmbus_post_gpadl_messages(struct vmbus_channel_msginfo *msginfo,
+			      u32 gpadl, bool *posted,
+			      vmbus_gpadl_post_fn post_msg,
+			      void *context)
+{
+	struct vmbus_channel_gpadl_header *gpadl_header;
+	struct vmbus_channel_msginfo *submsginfo;
+	struct list_head *curr;
+	int ret;
+
+	gpadl_header = (struct vmbus_channel_gpadl_header *)msginfo->msg;
+	gpadl_header->header.msgtype = CHANNELMSG_GPADL_HEADER;
+	gpadl_header->gpadl = gpadl;
+
+	/* A failed post may still have reached the host. */
+	*posted = true;
+	ret = post_msg(context, gpadl_header,
+		       msginfo->msgsize - sizeof(*msginfo), true);
+	trace_vmbus_establish_gpadl_header(gpadl_header, ret);
+	if (ret)
+		return ret;
+
+	list_for_each(curr, &msginfo->submsglist) {
+		struct vmbus_channel_gpadl_body *gpadl_body;
+
+		submsginfo = list_entry(curr, struct vmbus_channel_msginfo,
+					msglistentry);
+		gpadl_body = (struct vmbus_channel_gpadl_body *)submsginfo->msg;
+		gpadl_body->header.msgtype = CHANNELMSG_GPADL_BODY;
+		gpadl_body->gpadl = gpadl;
+
+		ret = post_msg(context, gpadl_body,
+			       submsginfo->msgsize - sizeof(*submsginfo), true);
+		trace_vmbus_establish_gpadl_body(gpadl_body, ret);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+int vmbus_gpadl_response_status(u32 creation_status, bool rescind,
+				bool *posted)
+{
+	*posted = false;
+	if (creation_status)
+		return -EDQUOT;
+	if (rescind)
+		return -ENODEV;
+
+	return 0;
+}
+
+int vmbus_post_gpadl_teardown(u32 child_relid,
+			      struct vmbus_channel_gpadl_teardown *msg,
+			      u32 gpadl,
+			      vmbus_gpadl_post_fn post_msg,
+			      void *context)
+{
+	int ret;
+
+	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
+	msg->child_relid = child_relid;
+	msg->gpadl = gpadl;
+
+	ret = post_msg(context, msg, sizeof(*msg), true);
+	trace_vmbus_teardown_gpadl(msg, ret);
+
+	return ret;
+}
+
 static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 				   enum hv_gpadl_type type, void *kbuffer,
 				   u32 size, u32 send_offset, bool memory_prepared,
@@ -495,11 +573,9 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 				   struct vmbus_gpadl *gpadl)
 {
 	struct vmbus_channel_gpadl_header *gpadlmsg;
-	struct vmbus_channel_gpadl_body *gpadl_body;
 	struct vmbus_channel_msginfo *msginfo = NULL;
-	struct vmbus_channel_msginfo *submsginfo;
-	struct list_head *curr;
 	u32 next_gpadl_handle;
+	u32 creation_status;
 	unsigned long flags;
 	bool posted = false;
 	int ret = 0;
@@ -558,49 +634,20 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 		goto cleanup;
 	}
 
-	/* A failed post may still have reached the host. */
-	posted = true;
-	ret = vmbus_post_msg(gpadlmsg, msginfo->msgsize -
-			     sizeof(*msginfo), true);
-
-	trace_vmbus_establish_gpadl_header(gpadlmsg, ret);
-
-	if (ret != 0)
+	ret = vmbus_post_gpadl_messages(msginfo, next_gpadl_handle, &posted,
+					vmbus_gpadl_post_real, NULL);
+	if (ret)
 		goto cleanup;
 
-	list_for_each(curr, &msginfo->submsglist) {
-		submsginfo = (struct vmbus_channel_msginfo *)curr;
-		gpadl_body =
-			(struct vmbus_channel_gpadl_body *)submsginfo->msg;
-
-		gpadl_body->header.msgtype =
-			CHANNELMSG_GPADL_BODY;
-		gpadl_body->gpadl = next_gpadl_handle;
-
-		ret = vmbus_post_msg(gpadl_body,
-				     submsginfo->msgsize - sizeof(*submsginfo),
-				     true);
-
-		trace_vmbus_establish_gpadl_body(gpadl_body, ret);
-
-		if (ret != 0)
-			goto cleanup;
-
-	}
 	wait_for_completion(&msginfo->waitevent);
 
-	if (msginfo->response.gpadl_created.creation_status != 0) {
-		posted = false;
-		pr_err("Failed to establish GPADL: err = 0x%x\n",
-		       msginfo->response.gpadl_created.creation_status);
-
-		ret = -EDQUOT;
-		goto cleanup;
-	}
-
-	if (channel->rescind) {
-		posted = false;
-		ret = -ENODEV;
+	creation_status = msginfo->response.gpadl_created.creation_status;
+	ret = vmbus_gpadl_response_status(creation_status, channel->rescind,
+					  &posted);
+	if (ret) {
+		if (creation_status)
+			pr_err("Failed to establish GPADL: err = 0x%x\n",
+			       creation_status);
 		goto cleanup;
 	}
 
@@ -608,8 +655,6 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	gpadl->gpadl_handle = gpadlmsg->gpadl;
 	gpadl->buffer = kbuffer;
 	gpadl->size = size;
-	posted = false;
-
 
 cleanup:
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
@@ -1118,9 +1163,6 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	msg = (struct vmbus_channel_gpadl_teardown *)info->msg;
 
-	msg->header.msgtype = CHANNELMSG_GPADL_TEARDOWN;
-	msg->child_relid = channel->offermsg.child_relid;
-	msg->gpadl = gpadl->gpadl_handle;
 
 	spin_lock_irqsave(&vmbus_connection.channelmsg_lock, flags);
 	list_add_tail(&info->msglistentry,
@@ -1130,10 +1172,8 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 	if (channel->rescind)
 		goto post_msg_err;
 
-	ret = vmbus_post_msg(msg, sizeof(struct vmbus_channel_gpadl_teardown),
-			     true);
-
-	trace_vmbus_teardown_gpadl(msg, ret);
+	ret = vmbus_post_gpadl_teardown(channel->offermsg.child_relid, msg, gpadl->gpadl_handle,
+					vmbus_gpadl_post_real, NULL);
 
 	if (ret)
 		goto post_msg_err;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 93df3b35cfd4..bb585ac2ceac 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -563,4 +563,23 @@ unsigned int vmbus_buffer_order(unsigned long remaining,
 bool vmbus_buffer_lower_order(unsigned int *order);
 bool vmbus_buffer_should_free(const struct vmbus_buffer *buffer);
 
+/*
+ * GPADL post and response helpers, also shared with vmbus_buffer_test.c.
+ * Same deal as the sizing helpers above: defined in channel.c, built into
+ * the hv_vmbus object, never exported.
+ */
+typedef int (*vmbus_gpadl_post_fn)(void *context, void *buffer,
+				   size_t buflen, bool can_sleep);
+int vmbus_post_gpadl_messages(struct vmbus_channel_msginfo *msginfo,
+			      u32 gpadl, bool *posted,
+			      vmbus_gpadl_post_fn post_msg,
+			      void *context);
+int vmbus_gpadl_response_status(u32 creation_status, bool rescind,
+				bool *posted);
+int vmbus_post_gpadl_teardown(u32 child_relid,
+			      struct vmbus_channel_gpadl_teardown *msg,
+			      u32 gpadl,
+			      vmbus_gpadl_post_fn post_msg,
+			      void *context);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_test.c
index d0a927a46caf..fbf7c4351d64 100644
--- a/drivers/hv/vmbus_buffer_test.c
+++ b/drivers/hv/vmbus_buffer_test.c
@@ -85,12 +85,188 @@ static void vmbus_buffer_partial_allocation_cleanup_test(struct kunit *test)
 	vmbus_release_buffer(&buffer);
 }
 
+struct vmbus_gpadl_post_test_context {
+	struct kunit *test;
+	unsigned int call_count;
+	unsigned int fail_call;
+	u32 first_msgtype;
+	u32 expected_gpadl;
+};
+
+static int vmbus_gpadl_test_post(void *context, void *buffer,
+				 size_t buflen, bool can_sleep)
+{
+	struct vmbus_gpadl_post_test_context *test_context = context;
+	struct vmbus_channel_message_header *header = buffer;
+
+	KUNIT_EXPECT_TRUE(test_context->test, can_sleep);
+	KUNIT_EXPECT_GT(test_context->test, buflen,
+			(size_t)sizeof(*header));
+	test_context->call_count++;
+	KUNIT_EXPECT_EQ(test_context->test, header->msgtype,
+			test_context->call_count == 1 ?
+			test_context->first_msgtype : CHANNELMSG_GPADL_BODY);
+	switch (header->msgtype) {
+	case CHANNELMSG_GPADL_HEADER: {
+		struct vmbus_channel_gpadl_header *gpadl_header = buffer;
+
+		KUNIT_EXPECT_EQ(test_context->test, gpadl_header->gpadl,
+				test_context->expected_gpadl);
+		break;
+	}
+	case CHANNELMSG_GPADL_BODY: {
+		struct vmbus_channel_gpadl_body *gpadl_body = buffer;
+
+		KUNIT_EXPECT_EQ(test_context->test, gpadl_body->gpadl,
+				test_context->expected_gpadl);
+		break;
+	}
+	case CHANNELMSG_GPADL_TEARDOWN: {
+		struct vmbus_channel_gpadl_teardown *teardown = buffer;
+
+		KUNIT_EXPECT_EQ(test_context->test, teardown->gpadl,
+				test_context->expected_gpadl);
+		KUNIT_EXPECT_EQ(test_context->test, teardown->child_relid,
+				7U);
+		break;
+	}
+	default:
+		KUNIT_FAIL(test_context->test,
+			   "unexpected GPADL message type: %d",
+			   header->msgtype);
+	}
+	if (test_context->call_count == test_context->fail_call)
+		return -EIO;
+
+	return 0;
+}
+
+static struct vmbus_channel_msginfo *
+vmbus_gpadl_test_msginfo(struct kunit *test, unsigned int body_count)
+{
+	struct vmbus_channel_msginfo *msginfo;
+	struct vmbus_channel_msginfo *body_info;
+	unsigned int i;
+
+	msginfo = kunit_kzalloc(test, sizeof(*msginfo) +
+			       sizeof(struct vmbus_channel_gpadl_header),
+			       GFP_KERNEL);
+	if (!msginfo)
+		return NULL;
+
+	msginfo->msgsize = sizeof(*msginfo) +
+			   sizeof(struct vmbus_channel_gpadl_header);
+	INIT_LIST_HEAD(&msginfo->submsglist);
+
+	for (i = 0; i < body_count; i++) {
+		body_info = kunit_kzalloc(test,
+					  sizeof(*body_info) +
+					  sizeof(struct vmbus_channel_gpadl_body),
+					  GFP_KERNEL);
+		if (!body_info)
+			return NULL;
+
+		body_info->msgsize = sizeof(*body_info) +
+				     sizeof(struct vmbus_channel_gpadl_body);
+		INIT_LIST_HEAD(&body_info->msglistentry);
+		list_add_tail(&body_info->msglistentry, &msginfo->submsglist);
+	}
+
+	return msginfo;
+}
+
+static void vmbus_gpadl_post_failure_test(struct kunit *test)
+{
+	unsigned int fail_call;
+
+	for (fail_call = 1; fail_call <= 3; fail_call++) {
+		struct vmbus_gpadl_post_test_context context = {
+			.test = test,
+			.fail_call = fail_call,
+			.first_msgtype = CHANNELMSG_GPADL_HEADER,
+			.expected_gpadl = 17,
+		};
+		struct vmbus_channel_msginfo *msginfo;
+		bool posted = false;
+		int ret;
+
+		msginfo = vmbus_gpadl_test_msginfo(test, 2);
+		KUNIT_ASSERT_NOT_NULL(test, msginfo);
+
+		ret = vmbus_post_gpadl_messages(msginfo, 17, &posted,
+						vmbus_gpadl_test_post, &context);
+		KUNIT_EXPECT_EQ(test, ret, -EIO);
+		KUNIT_EXPECT_EQ(test, context.call_count, fail_call);
+		KUNIT_EXPECT_TRUE(test, posted);
+	}
+}
+
+static void vmbus_gpadl_post_success_test(struct kunit *test)
+{
+	struct vmbus_gpadl_post_test_context context = {
+		.test = test,
+		.first_msgtype = CHANNELMSG_GPADL_HEADER,
+		.expected_gpadl = 17,
+	};
+	struct vmbus_channel_msginfo *msginfo;
+	bool posted = false;
+	int ret;
+
+	msginfo = vmbus_gpadl_test_msginfo(test, 2);
+	KUNIT_ASSERT_NOT_NULL(test, msginfo);
+
+	ret = vmbus_post_gpadl_messages(msginfo, 17, &posted,
+					vmbus_gpadl_test_post, &context);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, context.call_count, 3U);
+	KUNIT_EXPECT_TRUE(test, posted);
+}
+
+static void vmbus_gpadl_response_state_test(struct kunit *test)
+{
+	bool posted = true;
+
+	KUNIT_EXPECT_EQ(test, vmbus_gpadl_response_status(0, false, &posted), 0);
+	KUNIT_EXPECT_FALSE(test, posted);
+
+	posted = true;
+	KUNIT_EXPECT_EQ(test,
+			vmbus_gpadl_response_status(1, false, &posted), -EDQUOT);
+	KUNIT_EXPECT_FALSE(test, posted);
+
+	posted = true;
+	KUNIT_EXPECT_EQ(test,
+			vmbus_gpadl_response_status(0, true, &posted), -ENODEV);
+	KUNIT_EXPECT_FALSE(test, posted);
+}
+
+static void vmbus_gpadl_teardown_post_failure_test(struct kunit *test)
+{
+	struct vmbus_gpadl_post_test_context context = {
+		.test = test,
+		.fail_call = 1,
+		.first_msgtype = CHANNELMSG_GPADL_TEARDOWN,
+		.expected_gpadl = 17,
+	};
+	struct vmbus_channel_gpadl_teardown msg = {};
+	int ret;
+
+	ret = vmbus_post_gpadl_teardown(7, &msg, 17,
+					vmbus_gpadl_test_post, &context);
+	KUNIT_EXPECT_EQ(test, ret, -EIO);
+	KUNIT_EXPECT_EQ(test, context.call_count, 1U);
+}
+
 static struct kunit_case vmbus_buffer_test_cases[] = {
 	KUNIT_CASE(vmbus_buffer_size_rounding_test),
 	KUNIT_CASE(vmbus_buffer_size_overflow_test),
 	KUNIT_CASE(vmbus_ring_fallback_order_zero_test),
 	KUNIT_CASE(vmbus_buffer_failed_teardown_leaks_test),
 	KUNIT_CASE(vmbus_buffer_partial_allocation_cleanup_test),
+	KUNIT_CASE(vmbus_gpadl_post_failure_test),
+	KUNIT_CASE(vmbus_gpadl_post_success_test),
+	KUNIT_CASE(vmbus_gpadl_response_state_test),
+	KUNIT_CASE(vmbus_gpadl_teardown_post_failure_test),
 	{}
 };
 
-- 
2.43.0

