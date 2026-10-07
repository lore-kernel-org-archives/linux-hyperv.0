Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11624E36D4
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400157; cv=none; b=A5pWqsHn11k4ztdDrsZh5kbiTX9ulkjEqA91i25Qj6kDg8okHorgs1NOGG4KsAW0o8FktjTKrkyISx68sfTqgvX4FR2buNxQxALX5gv9ZHct9IEgpb1MzR0pDLy17NI9Ftq10329XQTDwV/Cwf8WTiEPdC0MTjvEeIQf1PaSII4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400157; c=relaxed/simple;
	bh=YvW9dw5fFHxAdlhk6wrXy+00S8Q5Vo/Aemaq0ZekxxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D/rE3NMdxWxe65ccXhOtvPjENzam+8+GG53LBRI7YLA9DUi3ysTTPF4Hk3vKZUHrobrVbOnWXeDqCQBY3teg4WuRREzEzCELJLHF8Uui5E49rVz1eKPPJ2CEf31s43Qrj0flpz0UduJ5CavlAZEKOWVVafIqMlCpEszPqBvgo5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G8do94Ma; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8do94Ma"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-7ca917f9f52so357592137.1
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400154; x=1792004954; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2ClTpzuXeB4RP4HWBkTbikHD8qrVDr9ORCmPMhJeh4g=;
        b=G8do94MaZdilUyUD51DlgGeCdM4G3fuuQsgvkQxUrxBGiDBRTgvcVX8QA2gBc4zNge
         wnrUQ0Td/qXUwijnKU4/1XqUkERmpVRoNnlIsN+NdyKnfF4iU7JPq0hWt/sVWbBTPC9u
         nCzBsmUPoT9wtZIWjueQ4cDZ+jO/yiMAaLwVsemuU4hH3UxEtAKSnWMdB0PBdliVIx+H
         7vOqOASg268GpV/NdA4bahGA+dPHlcMjM9NHxsBoLtn2HlV7bGemsN5tXpIXBCi72O+B
         F/07+y1/Iy21IhimNFGyig0dtsYPxFKFYIvZAadxWyumtvxl7N8SEggpwua7CPFDyjJW
         4vvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400154; x=1792004954;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2ClTpzuXeB4RP4HWBkTbikHD8qrVDr9ORCmPMhJeh4g=;
        b=Ti7zQse8X1SYrRAq7uCCIhlWzixfdc/q9pMKgOfiXxLCq5eJe5VW+njdi6HSFzCd1c
         Ng3G7QSYcUJoj04pYtJ2m9eLCjQRNadYQm1aQ5GOiodfPIKsldeWbu4zOKio37r1l63M
         2wBHLwTiMpXY1ReSXZqe23zXnrrAUwCo5nlmhorfKCVEx69Ml0UUmOyZ8osxAUfVJ6F4
         7iMDi8VOwmtqOwOXpJnf7YoEhL2cvmuRa2RtS3uEoeSboWeD9VEqN+Li0+qQre1QLf+L
         wELYoTCvT2PwnrnDq45FSdXcfT0uXRQZjcEswO23yaYrmQgcGpLSpArHKdci7IQ3Ly6L
         jTuw==
X-Forwarded-Encrypted: i=1; AKwUvBxSVJ7DL8oGTjK9ehunF9gJ0fn+W5oNewjeQJ0SH8Xcire2stNHCO0iarLN/OKmyeY8jevo0IkPYNqRuyk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLS8oPr4T0fQaNHyh8No8OoTmokwCScAMtczzKi9357xHyiL48J
	xbkPQ5XqXudVtsdzS3g5u2ZtgvEXWU8CYPLeNnV+Ir2rK4XKe+VbhA8x
X-Gm-Gg: AYBFou0FnnlJi7FmkFaEsGmGYLxwS8IR4Sro6ng4ggsFiGGdh8ZrCmw5ZVgzHhsec6k
	cc+hp+wiZski4idwRxkwPLc3OVNZXqrFQXDrTPb5Mkq+1um3wlMv3folU6PkniJ4RX1ld148b9T
	Er6mVHmS38+5vA6VzEHpJn6r2HU76DRe6gIdMOn7LXTKT21eo+p3RYjJu15rzKliN3qH0kEydIL
	k0RMMPg/hBAwFueWoT4ANDHeyrJKoSCkFMaV0zUEv3zgfsYopNCk1EfG0qQjIMefStYl4nt4dEG
	+2qlkhQIpV3CwndpNiAmTiAQp22HJd5VXUQ7dvlLWTuASQr1UkYis5bOtWNt3a+Lo/nI+EJ4qZf
	8KZIWwr50RtEetiqx0OYPj0AlZz7FL7FmWdIRxNp8QFlhYxPbEYaqevdnUwsy2HoCZPh7ey+7nv
	nr3Ybl7EcyrWJIjyDFvgz9TIqCc+r262swTudNIaiNhKkUoTgM7mijAO636msCZJ3Cs5uIU8hRH
	8LSI+w/IzZDNFI+JDg=
X-Received: by 2002:a05:6102:54ac:b0:7bc:696f:a5fb with SMTP id ada2fe7eead31-7ca38e1fda9mr1027964137.29.1791400153259;
        Wed, 07 Oct 2026 12:09:13 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.09.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:09:12 -0700 (PDT)
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
Subject: [PATCH v2 12/14] hv: netvsc: allocate RNDIS request descriptors with kvzalloc_obj()
Date: Wed,  7 Oct 2026 16:07:50 -0300
Message-ID: <20261007190752.336426-13-emersonbusson@gmail.com>
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

struct rndis_request embeds two RNDIS_EXT_LEN protocol tails.
RNDIS_EXT_LEN is HV_HYP_PAGE_SIZE, so the two tails alone are 8 KiB and
the struct is just over KMALLOC_MAX_CACHE_SIZE. kzalloc_obj() therefore
needs an order-2 compound page for every RNDIS control request, which can
fail under buddy fragmentation.

Use kvzalloc_obj() and kvfree() so allocation can fall back to vmalloc.
RNDIS control payloads are sent as GPA-direct page buffers, however, so a
vmalloc-backed descriptor cannot be described by one virt_to_phys() PFN.
Build one hv_page_buffer per Linux/Hyper-V page and resolve vmalloc backing
with vmalloc_to_page(). Linear allocations use virt_to_page(). This keeps
the GPA list valid and preserves the existing per-range DMA mapping for
isolated guests.

Keep both protocol tails unchanged. The response is copied after
request->response_msg into response_ext, within the existing
sizeof(struct rndis_message) + RNDIS_EXT_LEN bound.

Adds a fifth named RNDIS request KUnit case. It builds GPA descriptors from
a vmalloc buffer that crosses a page boundary and checks every PFN, offset,
and length against the backing pages. The existing cases retain the
allocation-size, response-layout, zeroing, request-id, and cleanup checks.

Rollback trigger: revert if the vmalloc page-buffer KUnit case fails or an
exact-source fragmented rebind shows malformed GPA descriptors from this
path.

Fixes: 5b54dac856cb ("hyperv: Add support for virtual Receive Side Scaling (vRSS)")
Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/net/hyperv/Kconfig              |  12 ++
 drivers/net/hyperv/Makefile             |   1 +
 drivers/net/hyperv/hyperv_net.h         |  43 ++++-
 drivers/net/hyperv/rndis_filter.c       | 117 ++++++++-----
 drivers/net/hyperv/rndis_request_test.c | 216 ++++++++++++++++++++++++
 5 files changed, 349 insertions(+), 40 deletions(-)
 create mode 100644 drivers/net/hyperv/rndis_request_test.c

diff --git a/drivers/net/hyperv/Kconfig b/drivers/net/hyperv/Kconfig
index 982964c1a9fb..226728fd77d7 100644
--- a/drivers/net/hyperv/Kconfig
+++ b/drivers/net/hyperv/Kconfig
@@ -6,3 +6,15 @@ config HYPERV_NET
 	select NLS
 	help
 	  Select this option to enable the Hyper-V virtual network driver.
+
+config HYPERV_NET_KUNIT_TEST
+	bool "Build Hyper-V netvsc KUnit tests"
+	depends on HYPERV_NET && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build the netvsc KUnit test suites into the hv_netvsc object.
+	  Built into the module rather than as a separate one so the
+	  cases can reach the internal helpers declared in hyperv_net.h
+	  without exporting them.
+
+	  If unsure, say N.
diff --git a/drivers/net/hyperv/Makefile b/drivers/net/hyperv/Makefile
index 0db7ccaec4a4..6f1abc756fde 100644
--- a/drivers/net/hyperv/Makefile
+++ b/drivers/net/hyperv/Makefile
@@ -2,3 +2,4 @@
 obj-$(CONFIG_HYPERV_NET) += hv_netvsc.o
 
 hv_netvsc-y := netvsc_drv.o netvsc.o rndis_filter.o netvsc_trace.o netvsc_bpf.o
+hv_netvsc-$(CONFIG_HYPERV_NET_KUNIT_TEST) += rndis_request_test.o
diff --git a/drivers/net/hyperv/hyperv_net.h b/drivers/net/hyperv/hyperv_net.h
index a15cb2460344..6492e7e93ded 100644
--- a/drivers/net/hyperv/hyperv_net.h
+++ b/drivers/net/hyperv/hyperv_net.h
@@ -210,14 +210,25 @@ struct rndis_device {
 	u8 rss_key[NETVSC_HASH_KEYLEN];
 };
 
+#define RNDIS_EXT_LEN HV_HYP_PAGE_SIZE
 
-/* Interface */
+/* Full definitions are below, after the RNDIS message format. */
+struct rndis_request;
 struct rndis_message;
+
+/* Interface */
 struct ndis_offload_params;
 struct netvsc_device;
 struct netvsc_channel;
 struct net_device_context;
 
+struct rndis_request *get_rndis_request(struct rndis_device *dev,
+					u32 msg_type, u32 msg_len);
+void put_rndis_request(struct rndis_device *dev, struct rndis_request *req);
+int rndis_build_page_buffers(const void *data, u32 len,
+			     struct hv_page_buffer *page_bufs,
+			     u32 *page_buf_cnt);
+
 extern u32 netvsc_ring_bytes;
 
 int netvsc_workqueue_init(void);
@@ -1779,6 +1790,36 @@ struct rndis_message {
 	union rndis_message_container msg;
 };
 
+/*
+ * RNDIS request descriptor. Declared here so the KUnit cases can reach
+ * the layout the response-copy bound in rndis_filter_receive_resp()
+ * relies on. The two RNDIS_EXT_LEN tails are what make the object
+ * larger than KMALLOC_MAX_CACHE_SIZE.
+ */
+struct rndis_request {
+	struct list_head list_ent;
+	struct completion  wait_event;
+
+	struct rndis_message response_msg;
+	/*
+	 * The buffer for extended info after the RNDIS response message. It's
+	 * referenced based on the data offset in the RNDIS message. Its size
+	 * is enough for current needs, and should be sufficient for the near
+	 * future.
+	 */
+	u8 response_ext[RNDIS_EXT_LEN];
+
+	/* Simplify allocation by having a netvsc packet inline */
+	struct hv_netvsc_packet	pkt;
+
+	struct rndis_message request_msg;
+	/*
+	 * The buffer for the extended info after the RNDIS request message.
+	 * It is referenced and sized in a similar way as response_ext.
+	 */
+	u8 request_ext[RNDIS_EXT_LEN];
+};
+
 
 /* Handy macros */
 
diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
index 9b6c44979b4e..1ce40baa2d23 100644
--- a/drivers/net/hyperv/rndis_filter.c
+++ b/drivers/net/hyperv/rndis_filter.c
@@ -16,6 +16,7 @@
 #include <linux/if_ether.h>
 #include <linux/netdevice.h>
 #include <linux/if_vlan.h>
+#include <linux/mm.h>
 #include <linux/nls.h>
 #include <linux/vmalloc.h>
 #include <linux/rtnetlink.h>
@@ -27,31 +28,6 @@
 
 static void rndis_set_multicast(struct work_struct *w);
 
-#define RNDIS_EXT_LEN HV_HYP_PAGE_SIZE
-struct rndis_request {
-	struct list_head list_ent;
-	struct completion  wait_event;
-
-	struct rndis_message response_msg;
-	/*
-	 * The buffer for extended info after the RNDIS response message. It's
-	 * referenced based on the data offset in the RNDIS message. Its size
-	 * is enough for current needs, and should be sufficient for the near
-	 * future.
-	 */
-	u8 response_ext[RNDIS_EXT_LEN];
-
-	/* Simplify allocation by having a netvsc packet inline */
-	struct hv_netvsc_packet	pkt;
-
-	struct rndis_message request_msg;
-	/*
-	 * The buffer for the extended info after the RNDIS request message.
-	 * It is referenced and sized in a similar way as response_ext.
-	 */
-	u8 request_ext[RNDIS_EXT_LEN];
-};
-
 static const u8 netvsc_hash_key[NETVSC_HASH_KEYLEN] = {
 	0x6d, 0x5a, 0x56, 0xda, 0x25, 0x5b, 0x0e, 0xc2,
 	0x41, 0x67, 0x25, 0x3d, 0x43, 0xa3, 0x8f, 0xb0,
@@ -78,16 +54,27 @@ static struct rndis_device *get_rndis_device(void)
 	return device;
 }
 
-static struct rndis_request *get_rndis_request(struct rndis_device *dev,
-					     u32 msg_type,
-					     u32 msg_len)
+struct rndis_request *get_rndis_request(struct rndis_device *dev,
+					u32 msg_type,
+					u32 msg_len)
 {
 	struct rndis_request *request;
 	struct rndis_message *rndis_msg;
 	struct rndis_set_request *set;
 	unsigned long flags;
 
-	request = kzalloc_obj(struct rndis_request);
+	/*
+	 * struct rndis_request embeds two RNDIS_EXT_LEN (4 KiB) protocol
+	 * tails and is larger than KMALLOC_MAX_CACHE_SIZE, so
+	 * kzalloc_obj() needs an order-2 compound page. That high-order
+	 * allocation can fail under buddy fragmentation. kvzalloc_obj()
+	 * keeps the zeroing semantics while allowing vmalloc backing when
+	 * a suitable kmalloc allocation is unavailable. The request payload
+	 * is sent as GPADL-direct page buffers, so rndis_filter_send_request()
+	 * must describe each backing page instead of assuming virt_to_phys()
+	 * yields one contiguous physical range.
+	 */
+	request = kvzalloc_obj(struct rndis_request);
 	if (!request)
 		return NULL;
 
@@ -115,8 +102,8 @@ static struct rndis_request *get_rndis_request(struct rndis_device *dev,
 	return request;
 }
 
-static void put_rndis_request(struct rndis_device *dev,
-			    struct rndis_request *req)
+void put_rndis_request(struct rndis_device *dev,
+		       struct rndis_request *req)
 {
 	unsigned long flags;
 
@@ -124,7 +111,8 @@ static void put_rndis_request(struct rndis_device *dev,
 	list_del(&req->list_ent);
 	spin_unlock_irqrestore(&dev->request_lock, flags);
 
-	kfree(req);
+	/* Paired with the kvzalloc_obj() in get_rndis_request(). */
+	kvfree(req);
 }
 
 static void dump_rndis_message(struct net_device *netdev,
@@ -221,27 +209,78 @@ static void dump_rndis_message(struct net_device *netdev,
 	}
 }
 
+int rndis_build_page_buffers(const void *data, u32 len,
+			     struct hv_page_buffer *page_bufs,
+			     u32 *page_buf_cnt)
+{
+	const u8 *addr = data;
+	u32 count = 0;
+
+	if (!data || !len || !page_bufs || !page_buf_cnt)
+		return -EINVAL;
+
+	*page_buf_cnt = 0;
+
+	while (len) {
+		struct page *page;
+		phys_addr_t phys;
+		u32 offset, chunk;
+		unsigned long page_offset = offset_in_page(addr);
+
+		if (count == MAX_PAGE_BUFFER_COUNT)
+			return -E2BIG;
+
+		if (is_vmalloc_addr(addr))
+			page = vmalloc_to_page(addr);
+		else if (virt_addr_valid(addr))
+			page = virt_to_page(addr);
+		else
+			return -EFAULT;
+
+		if (!page)
+			return -EFAULT;
+
+		phys = page_to_phys(page) + page_offset;
+		offset = offset_in_hvpage(phys);
+		chunk = min_t(u32, len, PAGE_SIZE - page_offset);
+		chunk = min_t(u32, chunk, HV_HYP_PAGE_SIZE - offset);
+
+		page_bufs[count].pfn = phys >> HV_HYP_PAGE_SHIFT;
+		page_bufs[count].offset = offset;
+		page_bufs[count].len = chunk;
+
+		addr += chunk;
+		len -= chunk;
+		count++;
+	}
+
+	*page_buf_cnt = count;
+	return 0;
+}
+
 static int rndis_filter_send_request(struct rndis_device *dev,
 				  struct rndis_request *req)
 {
 	struct hv_netvsc_packet *packet;
-	struct hv_page_buffer pb;
+	struct hv_page_buffer page_bufs[MAX_PAGE_BUFFER_COUNT];
+	u32 page_buf_cnt;
 	int ret;
 
 	/* Setup the packet to send it */
 	packet = &req->pkt;
 
 	packet->total_data_buflen = req->request_msg.msg_len;
-	packet->page_buf_cnt = 1;
-
-	pb.pfn = virt_to_phys(&req->request_msg) >> HV_HYP_PAGE_SHIFT;
-	pb.len = req->request_msg.msg_len;
-	pb.offset = offset_in_hvpage(&req->request_msg);
+	ret = rndis_build_page_buffers(&req->request_msg,
+				       req->request_msg.msg_len,
+				       page_bufs, &page_buf_cnt);
+	if (ret)
+		return ret;
+	packet->page_buf_cnt = page_buf_cnt;
 
 	trace_rndis_send(dev->ndev, 0, &req->request_msg);
 
 	rcu_read_lock_bh();
-	ret = netvsc_send(dev->ndev, packet, NULL, &pb, NULL, false);
+	ret = netvsc_send(dev->ndev, packet, NULL, page_bufs, NULL, false);
 	rcu_read_unlock_bh();
 
 	return ret;
diff --git a/drivers/net/hyperv/rndis_request_test.c b/drivers/net/hyperv/rndis_request_test.c
new file mode 100644
index 000000000000..6affa916e74e
--- /dev/null
+++ b/drivers/net/hyperv/rndis_request_test.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for RNDIS request descriptor allocation.
+ *
+ * Built into the hv_netvsc object rather than a separate module so the
+ * cases can reach the internal helpers declared in hyperv_net.h
+ * without exporting them.
+ */
+#include <kunit/test.h>
+#include <linux/hyperv.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/stddef.h>
+#include <linux/vmalloc.h>
+
+#include "hyperv_net.h"
+
+static int rndis_test_device_init(struct rndis_device *dev)
+{
+	memset(dev, 0, sizeof(*dev));
+	atomic_set(&dev->new_req_id, 0);
+	spin_lock_init(&dev->request_lock);
+	INIT_LIST_HEAD(&dev->req_list);
+	return 0;
+}
+
+/*
+ * The premise of the kvzalloc_obj() conversion: the descriptor embeds
+ * two RNDIS_EXT_LEN protocol tails and sits past
+ * KMALLOC_MAX_CACHE_SIZE, so kzalloc_obj() reached kmalloc_large() and
+ * took an order-2 compound page on the subchannel open path. If the
+ * struct ever drops back inside the cache, the conversion stops being
+ * about high-order allocation and this assertion is the reminder.
+ */
+static void rndis_request_size_premise_test(struct kunit *test)
+{
+	KUNIT_EXPECT_GT(test, sizeof(struct rndis_request),
+			(size_t)KMALLOC_MAX_CACHE_SIZE);
+	/*
+	 * The copy bound in rndis_filter_receive_resp() is
+	 * sizeof(struct rndis_message) + RNDIS_EXT_LEN. That is exactly
+	 * the response_msg + response_ext tail of the object. A reorder
+	 * or a resize of either member makes the bound lie.
+	 */
+	KUNIT_EXPECT_EQ(test,
+			offsetofend(struct rndis_request, response_ext),
+			offsetof(struct rndis_request, response_msg) +
+				sizeof(struct rndis_message) + RNDIS_EXT_LEN);
+	KUNIT_EXPECT_EQ(test,
+			offsetofend(struct rndis_request, request_ext),
+			offsetof(struct rndis_request, request_msg) +
+				sizeof(struct rndis_message) + RNDIS_EXT_LEN);
+}
+
+/*
+ * kvzalloc_obj() keeps the zeroing kzalloc_obj() provided. The two
+ * protocol tails are the fields a response is copied into; a stale
+ * tail is a stale response.
+ */
+static void rndis_request_alloc_zeroed_test(struct kunit *test)
+{
+	struct rndis_device dev;
+	struct rndis_request *req;
+
+	KUNIT_ASSERT_EQ(test, rndis_test_device_init(&dev), 0);
+	req = get_rndis_request(&dev, RNDIS_MSG_INIT, 0x20);
+	KUNIT_ASSERT_NOT_NULL(test, req);
+
+	KUNIT_EXPECT_EQ(test, req->response_ext[0], 0);
+	KUNIT_EXPECT_EQ(test, req->response_ext[RNDIS_EXT_LEN - 1], 0);
+	KUNIT_EXPECT_EQ(test, req->request_ext[0], 0);
+	KUNIT_EXPECT_EQ(test, req->request_ext[RNDIS_EXT_LEN - 1], 0);
+	KUNIT_EXPECT_EQ(test, req->response_msg.msg_len, 0U);
+
+	put_rndis_request(&dev, req);
+}
+
+/* Request ids come from a per-device counter and the list tracks the live set. */
+static void rndis_request_id_lifecycle_test(struct kunit *test)
+{
+	struct rndis_device dev;
+	struct rndis_request *req0, *req1;
+	struct rndis_request *cursor;
+	unsigned int n = 0;
+
+	KUNIT_ASSERT_EQ(test, rndis_test_device_init(&dev), 0);
+
+	req0 = get_rndis_request(&dev, RNDIS_MSG_INIT, 0x20);
+	KUNIT_ASSERT_NOT_NULL(test, req0);
+	req1 = get_rndis_request(&dev, RNDIS_MSG_QUERY, 0x20);
+	KUNIT_ASSERT_NOT_NULL(test, req1);
+
+	/*
+	 * get_rndis_request() stamps the id through the set_req template,
+	 * which shares the union slot with every other request body. Read
+	 * it back through the same member the producer used.
+	 */
+	KUNIT_EXPECT_EQ(test,
+			req0->request_msg.msg.set_req.req_id, 1U);
+	KUNIT_EXPECT_EQ(test,
+			req1->request_msg.msg.set_req.req_id, 2U);
+
+	list_for_each_entry(cursor, &dev.req_list, list_ent)
+		n++;
+	KUNIT_EXPECT_EQ(test, n, 2U);
+
+	/*
+	 * put_rndis_request() is the cleanup path every error and
+	 * timeout branch takes. It unlinks before it frees.
+	 */
+	put_rndis_request(&dev, req0);
+	n = 0;
+	list_for_each_entry(cursor, &dev.req_list, list_ent)
+		n++;
+	KUNIT_EXPECT_EQ(test, n, 1U);
+	KUNIT_EXPECT_TRUE(test,
+			  list_first_entry(&dev.req_list, struct rndis_request,
+					   list_ent) == req1);
+
+	put_rndis_request(&dev, req1);
+	KUNIT_EXPECT_TRUE(test, list_empty(&dev.req_list));
+}
+
+/*
+ * A request left on the list after a completed exchange is a leak of
+ * the descriptor and of its slot in the outstanding set. Repeated
+ * get/put cycles must return to the empty list every time.
+ */
+static void rndis_request_put_cleanup_test(struct kunit *test)
+{
+	struct rndis_device dev;
+	struct rndis_request *req;
+	int i;
+
+	KUNIT_ASSERT_EQ(test, rndis_test_device_init(&dev), 0);
+
+	for (i = 0; i < 4; i++) {
+		req = get_rndis_request(&dev, RNDIS_MSG_INIT, 0x20);
+		KUNIT_ASSERT_NOT_NULL(test, req);
+		KUNIT_EXPECT_FALSE(test, list_empty(&dev.req_list));
+		put_rndis_request(&dev, req);
+		KUNIT_EXPECT_TRUE(test, list_empty(&dev.req_list));
+	}
+}
+
+/*
+ * kvzalloc_obj() may return a vmalloc address under fragmentation. RNDIS
+ * requests are GPA-direct packets, so each backing page must be represented
+ * explicitly instead of deriving a single PFN with virt_to_phys().
+ */
+static void rndis_request_vmalloc_page_buffers_test(struct kunit *test)
+{
+	struct hv_page_buffer page_bufs[MAX_PAGE_BUFFER_COUNT];
+	const u32 data_len = 16;
+	u8 *allocation = vzalloc(2 * PAGE_SIZE);
+	const u8 *cursor;
+	phys_addr_t phys;
+	u32 count = 0, remaining = data_len, i;
+	int ret;
+
+	if (!allocation) {
+		KUNIT_FAIL(test, "could not allocate vmalloc test buffer");
+		return;
+	}
+
+	cursor = allocation + PAGE_SIZE - 8;
+	ret = rndis_build_page_buffers(cursor, data_len, page_bufs, &count);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	if (ret)
+		goto out;
+
+	KUNIT_EXPECT_EQ(test, count, 2U);
+	for (i = 0; i < count; i++) {
+		struct page *page = vmalloc_to_page(cursor);
+		unsigned long page_offset = offset_in_page(cursor);
+		u32 offset, chunk;
+
+		if (!page) {
+			KUNIT_FAIL(test, "vmalloc test buffer has no backing page");
+			goto out;
+		}
+
+		phys = page_to_phys(page) + page_offset;
+		offset = offset_in_hvpage(phys);
+		chunk = min_t(u32, remaining, PAGE_SIZE - page_offset);
+		chunk = min_t(u32, chunk, HV_HYP_PAGE_SIZE - offset);
+
+		KUNIT_EXPECT_EQ(test, page_bufs[i].pfn,
+				(u64)(phys >> HV_HYP_PAGE_SHIFT));
+		KUNIT_EXPECT_EQ(test, page_bufs[i].offset, offset);
+		KUNIT_EXPECT_EQ(test, page_bufs[i].len, chunk);
+
+		cursor += chunk;
+		remaining -= chunk;
+	}
+	KUNIT_EXPECT_EQ(test, remaining, 0U);
+
+out:
+	vfree(allocation);
+}
+
+static struct kunit_case rndis_request_test_cases[] = {
+	KUNIT_CASE(rndis_request_size_premise_test),
+	KUNIT_CASE(rndis_request_alloc_zeroed_test),
+	KUNIT_CASE(rndis_request_id_lifecycle_test),
+	KUNIT_CASE(rndis_request_put_cleanup_test),
+	KUNIT_CASE(rndis_request_vmalloc_page_buffers_test),
+	{}
+};
+
+static struct kunit_suite rndis_request_test_suite = {
+	.name = "hyperv-rndis-request",
+	.test_cases = rndis_request_test_cases,
+};
+
+kunit_test_suite(rndis_request_test_suite);
-- 
2.43.0

