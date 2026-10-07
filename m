Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFB4E1415
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400096; cv=none; b=SQwAY2SAYWH3XkwsK5mH3Cua6ZxqIwH20YRJFUm2xHOBieCAWwN5hljVEK2M1OG43J9tost2KXSZdmpT+y4uQK6aehRLP4QUAm2MnjAi4T32mrvh+6tkTg3fPsh0OnW4dlU311mY38LCIxh2vxAHgElCVM33IMrYTSQZZnFZgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400096; c=relaxed/simple;
	bh=f6hAYaWquotH6XzgQ1x/frvwgLxkKCCZuUjx5By3X4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hEjWykgkBLI04g00y8E8AUxuGqT5VC4RQZl4AuIrvs6+M/HqKqekHsbBVkBkBWnCS3CWRO+1uXfuQN9RY4ARPuZC1mQyl6+2i3iy8fR6ZgtkG+qNp0yMGq85SmInus0+ZKYDnUR+lXx+wgoCLPBhzgp6bu9Pw6/GtqUCfQF0+tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NfK4X1+6; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NfK4X1+6"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-7bf5f3736d2so2728033137.0
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400094; x=1792004894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+Vn0spk3ajwyij1jMAAvmsyWo8ulUmzZZ0Zz44T5uS8=;
        b=NfK4X1+6dgRqwMFTLK1yUy/qXKiULZgORTpdG8+ZoD6uV8+gdKZtc3X0myEAETFU38
         xwTN/mbyetAkLxwOlg/n4q9moFkZFUzHX0Xf35gGDzp7KFGLomng/+rmyB/O2Z2lWrl0
         niHi0WxG+28CgxvITFproajrgWCtXdQ8MBn87fcw2GQk1ucKhnU1lUJDu8PyjIIE0CEa
         PPFydPZjNVI1WXU+UQMHZAhlvFbqAgdJGlrcVf7sASO364PtgugIXbZUaT6eWKSFQa9U
         IeAEDSLAfZwHQrI1R2jLDPffKiHaUnIwP3nAgSnWhBJoivzgMnXlpwit7Bz7kqtUN3el
         W3ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400094; x=1792004894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+Vn0spk3ajwyij1jMAAvmsyWo8ulUmzZZ0Zz44T5uS8=;
        b=LS8ga9vP8ZNc7YutPVvQY0ysoA+i1R5LWZYnlPIeR/TFhwpIWSkYlaReuxBnoCaWXu
         wKfess7zz5SAIlsMfEmuFqq+yzlXZADDQTiwTnBAAn//AF4yR5H8Rb4lxSlYu3p+aZjW
         Ff/Q8fCFfGPcm0nK74NFiRpMFpck5HzX1MwEmiCcU1CuxPHG4Rn/BPi5Pkmn4MtItip3
         2R6P56rNeWeVmkGcepUQbNvxPaqT6dRJe+1Oi/SHJOq+yZIM2JrAY3xmWYMLFEXhVBEN
         A8baBX7UxnHiXVKcwFaLvyn7rutX3ehtW9j/MEH5oeVkbbRZB9S7gfSMhvXCcCmHlC/P
         jsTQ==
X-Forwarded-Encrypted: i=1; AKwUvBySrJn/U2CSeRVtmHyPvKENH0Ss2fO5jcjiDBenox/GDlx6AZ8JfGOtvTxfXNjRkSFx4d9mNP4UmUbeK0Y=@vger.kernel.org
X-Gm-Message-State: AFq9FYKCX+A/oaZcXiTpMyqyLAlEuzENU0+cGW1k2eeW6y7lopbI2U3b
	DkfjCE3XjdenqtkXCQruBS7T3De41OyGvPLJvl5B2rxTHhuG1dF/s434
X-Gm-Gg: AYBFou3qriWftgy9o0o27T4br0tIfP4x6QkvPAbqtBJ36hDZnMJaV7rYOIWwsRdDvDo
	z3+3SVbx9ATZW83GPwEZFeUkbDGXSMjtPqiwgpOhBr4ze0wOxKto8BajgTnm7ns/HIoqkUR4FiI
	+NmZMfWUdKxI2R77micNG6H3Ox7Ru+XiwGK68ovSQ44VdVizIKtIQrFgXD8FH1LPToMQDY7IAgu
	TrNAV8b5bXaYJQUG9jhFwqkPLo1vCN8cqN3Ivtjc5e6E8ZKmveSK67HVR3/CbDE1v8Z371RlNMR
	TpIeIgtaelS0iukeBTlTLclEU+g5y55v1It65GcpcdZJPrauaQ94Fjc0ApS4ZHWliPnpmemS+rC
	XcJu6N4X99xgyJhOvxEw6g35xjPZgmBXAViS/KcHKmIAPPtjgHMeTqkc92HIpjzM1MUz2LwG9iM
	6So4SXZmZHHTJfQb8+wO5KcdrUkJR0QuZEFG/ePTYmpjoaZe/xCd1wkThXDVA4RwSTDnuEYe7aT
	jqfdxKv8jw/nptQGI8=
X-Received: by 2002:a05:6102:4490:b0:7c3:8ae6:d7ab with SMTP id ada2fe7eead31-7ca36e47759mr1089805137.5.1791400093596;
        Wed, 07 Oct 2026 12:08:13 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:08:13 -0700 (PDT)
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
Subject: [PATCH v2 02/14] hv: vmbus: validate chunk buffer allocation and cleanup
Date: Wed,  7 Oct 2026 16:07:40 -0300
Message-ID: <20261007190752.336426-3-emersonbusson@gmail.com>
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

Validate rounded sizes before storing them and preserve allocated
chunks when cleanup or GPADL teardown has an uncertain outcome. Add
focused KUnit coverage for buffer sizing, ownership decisions, and the
ring fallback order descent.

vmbus_alloc_buffer() rounds the requested size up to PAGE_SIZE before it
computes nr_pages. A zero size, and a size within PAGE_SIZE of U32_MAX,
both produce a rounded value that is wrong: zero allocates nothing, and
the near-U32_MAX cases wrap to a small nr_pages, so a small chunk array
is built for a buffer the host is told is large. Reject both before the
rounded size is stored or used.

vmbus_buffer_should_free() gathers the leak decision in one place. A
cleanup whose GPADL create or teardown message may have reached the host
cannot prove the host has released the pages. Handing those pages back
to the allocator, or re-encrypting them, while the host may still map
them is a use-after-free from the host's side and a Confidential
Computing hazard. Such a buffer is marked leaked and its chunks are
retained instead of freed.

The new cases live in drivers/hv/vmbus_buffer_test.c, which is built
into the hv_vmbus object rather than a separate module. That keeps the
cases off the production sources while still letting them call the
internal sizing, order-descent and free-decision helpers. Those helpers
are therefore not static; nothing outside hv_vmbus links against them,
and no symbol is exported for test purposes.

The cases pin both rules, the partial-allocation rollback, and the
order-descent fallback.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/Kconfig             |  11 ++++
 drivers/hv/Makefile            |   1 +
 drivers/hv/channel.c           |  67 ++++++++++++++++++----
 drivers/hv/hyperv_vmbus.h      |  12 ++++
 drivers/hv/vmbus_buffer_test.c | 102 +++++++++++++++++++++++++++++++++
 5 files changed, 181 insertions(+), 12 deletions(-)
 create mode 100644 drivers/hv/vmbus_buffer_test.c

diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
index aa11bcefddf2..d44dd60fbc23 100644
--- a/drivers/hv/Kconfig
+++ b/drivers/hv/Kconfig
@@ -65,6 +65,17 @@ config HYPERV_VMBUS
 	help
 	  Select this option to enable Hyper-V Vmbus driver.
 
+config HYPERV_VMBUS_KUNIT_TEST
+	bool "Build Hyper-V VMBus buffer KUnit tests"
+	depends on HYPERV_VMBUS && KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  Build the vmbus buffer sizing, GPADL lifetime and reclaim KUnit
+	  cases into the hv_vmbus object. The cases reach internal helpers
+	  that are not exported, so they cannot live in a separate module.
+
+	  If unsure, say N.
+
 config MSHV_ROOT
 	tristate "Microsoft Hyper-V root partition support"
 	depends on HYPERV && (X86_64 || ARM64)
diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
index 888a748cc7cb..80d33e9c0e57 100644
--- a/drivers/hv/Makefile
+++ b/drivers/hv/Makefile
@@ -12,6 +12,7 @@ hv_vmbus-y := vmbus_drv.o \
 		 hv.o connection.o channel.o \
 		 channel_mgmt.o ring_buffer.o hv_trace.o
 hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
+hv_vmbus-$(CONFIG_HYPERV_VMBUS_KUNIT_TEST) += vmbus_buffer_test.o
 hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
 mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o mshv_irq.o \
 	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index f8feb2a0ec0a..7d5b99281872 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -28,6 +28,44 @@
 
 #include "hyperv_vmbus.h"
 
+/*
+ * vmbus_buffer_round_size() and the order-descent helpers are also called
+ * from vmbus_buffer_test.c, which is built into this same object. They are
+ * therefore not static; nothing outside hv_vmbus links against them.
+ */
+int vmbus_buffer_round_size(u32 size, u32 *rounded_size)
+{
+	if (!size)
+		return -EINVAL;
+
+	if (size > U32_MAX - (u32)PAGE_SIZE + 1)
+		return -EOVERFLOW;
+
+	*rounded_size = round_up(size, (u32)PAGE_SIZE);
+	return 0;
+}
+
+unsigned int vmbus_buffer_order(unsigned long remaining,
+				unsigned int max_order)
+{
+	return min_t(unsigned int, max_order, ilog2(remaining));
+}
+
+bool vmbus_buffer_lower_order(unsigned int *order)
+{
+	if (!*order)
+		return false;
+
+	(*order)--;
+	return true;
+}
+
+bool vmbus_buffer_should_free(const struct vmbus_buffer *buffer)
+{
+	return !buffer->leak && !buffer->gpadl.leak &&
+	       !buffer->gpadl.gpadl_handle;
+}
+
 static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 				  u32 size,
 				  bool confidential,
@@ -661,7 +699,8 @@ void vmbus_free_buffer(void *addr, struct page **chunks, u32 chunk_cnt)
 		return;
 	}
 
-	vunmap(addr);
+	if (addr)
+		vunmap(addr);
 
 	for (i = 0; i < chunk_cnt; i++) {
 		unsigned long vaddr =
@@ -683,8 +722,7 @@ void vmbus_release_buffer(struct vmbus_buffer *buffer)
 		return;
 
 	kvfree(buffer->pages);
-	if (!buffer->leak && !buffer->gpadl.leak &&
-	    !buffer->gpadl.gpadl_handle)
+	if (vmbus_buffer_should_free(buffer))
 		vmbus_free_buffer(buffer->addr, buffer->chunks,
 				  buffer->chunk_cnt);
 	memset(buffer, 0, sizeof(*buffer));
@@ -717,12 +755,13 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 				  struct page ***chunks_out,
 				  u32 *chunk_cnt_out)
 {
-	unsigned long nr_pages = PFN_UP(size);
-	unsigned long remaining = nr_pages;
+	u32 rounded_size;
+	unsigned long nr_pages;
+	unsigned long remaining;
 	unsigned long page_idx = 0;
 	struct page **chunks = NULL;
 	struct page **pages = NULL;
-	int order = MAX_PAGE_ORDER;
+	unsigned int order = MAX_PAGE_ORDER;
 	u32 chunk_cnt = 0;
 	void *addr;
 	u32 i;
@@ -731,13 +770,15 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	*chunks_out = NULL;
 	*chunk_cnt_out = 0;
 
-	if (!nr_pages)
+	if (vmbus_buffer_round_size(size, &rounded_size))
 		return NULL;
+	nr_pages = rounded_size >> PAGE_SHIFT;
+	remaining = nr_pages;
 
 	/* If the buffer does not need to be decrypted, just use vzalloc() */
 	if ((!hv_is_isolation_supported() &&
 	     !cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) || confidential)
-		return vzalloc(nr_pages << PAGE_SHIFT);
+		return vzalloc(rounded_size);
 
 	/* Worst case: every chunk is a single page. */
 	chunks = kvmalloc_objs(*chunks, nr_pages, GFP_KERNEL | __GFP_ZERO);
@@ -752,7 +793,7 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 		struct page *page;
 		gfp_t gfp;
 
-		order = min(order, ilog2(remaining));
+		order = vmbus_buffer_order(remaining, order);
 
 		/*
 		 * Use __GFP_NORETRY | __GFP_NOWARN to avoid OOM-killing,
@@ -767,7 +808,7 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 		page = alloc_pages_node(cpu_to_node(channel->target_cpu),
 					gfp, order);
 		if (!page) {
-			if (!order--)
+			if (!vmbus_buffer_lower_order(&order))
 				goto err;
 			continue;
 		}
@@ -794,7 +835,7 @@ static void *__vmbus_alloc_buffer(struct vmbus_channel *channel,
 	if (!addr)
 		goto err;
 
-	memset(addr, 0, nr_pages << PAGE_SHIFT);
+	memset(addr, 0, rounded_size);
 
 	kvfree(pages);
 	*chunks_out = chunks;
@@ -1067,8 +1108,10 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, struct vmbus_gpadl *gpad
 
 	info = kzalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
-	if (!info)
+	if (!info) {
+		gpadl->leak = true;
 		return -ENOMEM;
+	}
 
 	init_completion(&info->waitevent);
 	info->waiting_channel = channel;
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 20d023c9735e..93df3b35cfd4 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -551,4 +551,16 @@ int hv_create_ring_sysfs(struct vmbus_channel *channel,
 							    struct vm_area_desc *desc));
 int hv_remove_ring_sysfs(struct vmbus_channel *channel);
 
+/*
+ * vmbus buffer sizing, order-descent and free-decision helpers.
+ *
+ * These are shared with vmbus_buffer_test.c, which is built into the
+ * hv_vmbus object alongside channel.c. They stay unexported.
+ */
+int vmbus_buffer_round_size(u32 size, u32 *rounded_size);
+unsigned int vmbus_buffer_order(unsigned long remaining,
+				unsigned int max_order);
+bool vmbus_buffer_lower_order(unsigned int *order);
+bool vmbus_buffer_should_free(const struct vmbus_buffer *buffer);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_test.c
new file mode 100644
index 000000000000..d0a927a46caf
--- /dev/null
+++ b/drivers/hv/vmbus_buffer_test.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * KUnit tests for Hyper-V VMBus buffer allocation and GPADL lifetime.
+ *
+ * Built into the hv_vmbus object rather than a separate module so the
+ * cases can reach the internal helpers declared in hyperv_vmbus.h
+ * without exporting them.
+ */
+#include <kunit/test.h>
+#include <linux/hyperv.h>
+#include <linux/mm.h>
+#include <linux/slab.h>
+#include <linux/vmalloc.h>
+
+#include "hyperv_vmbus.h"
+
+static void vmbus_buffer_size_rounding_test(struct kunit *test)
+{
+	u32 rounded_size;
+
+	KUNIT_EXPECT_EQ(test, vmbus_buffer_round_size(1, &rounded_size), 0);
+	KUNIT_EXPECT_EQ(test, rounded_size, (u32)PAGE_SIZE);
+	KUNIT_EXPECT_EQ(test, vmbus_buffer_round_size(PAGE_SIZE, &rounded_size), 0);
+	KUNIT_EXPECT_EQ(test, rounded_size, (u32)PAGE_SIZE);
+}
+
+static void vmbus_buffer_size_overflow_test(struct kunit *test)
+{
+	u32 rounded_size = 0;
+	int ret;
+
+	KUNIT_EXPECT_EQ(test, vmbus_buffer_round_size(0, &rounded_size), -EINVAL);
+	ret = vmbus_buffer_round_size(U32_MAX, &rounded_size);
+	KUNIT_EXPECT_EQ(test, ret, -EOVERFLOW);
+	ret = vmbus_buffer_round_size(U32_MAX - PAGE_SIZE + 1, &rounded_size);
+	KUNIT_EXPECT_EQ(test, ret, 0);
+	KUNIT_EXPECT_EQ(test, rounded_size,
+			(u32)(U32_MAX - PAGE_SIZE + 1));
+}
+
+static void vmbus_ring_fallback_order_zero_test(struct kunit *test)
+{
+	unsigned int order;
+
+	order = vmbus_buffer_order(1UL << MAX_PAGE_ORDER, MAX_PAGE_ORDER);
+	KUNIT_EXPECT_EQ(test, order, (unsigned int)MAX_PAGE_ORDER);
+	while (order)
+		KUNIT_ASSERT_TRUE(test, vmbus_buffer_lower_order(&order));
+	KUNIT_EXPECT_FALSE(test, vmbus_buffer_lower_order(&order));
+	KUNIT_EXPECT_EQ(test, order, 0U);
+	KUNIT_EXPECT_EQ(test, vmbus_buffer_order(3, MAX_PAGE_ORDER), 1U);
+}
+
+static void vmbus_buffer_failed_teardown_leaks_test(struct kunit *test)
+{
+	struct vmbus_buffer buffer = {
+		.addr = (void *)1,
+		.gpadl.gpadl_handle = 1,
+	};
+
+	KUNIT_EXPECT_FALSE(test, vmbus_buffer_should_free(&buffer));
+	buffer.gpadl.gpadl_handle = 0;
+	buffer.gpadl.leak = true;
+	KUNIT_EXPECT_FALSE(test, vmbus_buffer_should_free(&buffer));
+	buffer.gpadl.leak = false;
+	buffer.leak = true;
+	KUNIT_EXPECT_FALSE(test, vmbus_buffer_should_free(&buffer));
+	buffer.leak = false;
+	KUNIT_EXPECT_TRUE(test, vmbus_buffer_should_free(&buffer));
+}
+
+static void vmbus_buffer_partial_allocation_cleanup_test(struct kunit *test)
+{
+	struct page **chunks;
+	struct vmbus_buffer buffer = {};
+
+	chunks = kmalloc_obj(*chunks, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, chunks);
+	vmbus_free_buffer(NULL, chunks, 0);
+
+	buffer.addr = vzalloc(PAGE_SIZE);
+	KUNIT_ASSERT_NOT_NULL(test, buffer.addr);
+	vmbus_release_buffer(&buffer);
+	KUNIT_EXPECT_PTR_EQ(test, buffer.addr, NULL);
+	vmbus_release_buffer(&buffer);
+}
+
+static struct kunit_case vmbus_buffer_test_cases[] = {
+	KUNIT_CASE(vmbus_buffer_size_rounding_test),
+	KUNIT_CASE(vmbus_buffer_size_overflow_test),
+	KUNIT_CASE(vmbus_ring_fallback_order_zero_test),
+	KUNIT_CASE(vmbus_buffer_failed_teardown_leaks_test),
+	KUNIT_CASE(vmbus_buffer_partial_allocation_cleanup_test),
+	{}
+};
+
+static struct kunit_suite vmbus_buffer_test_suite = {
+	.name = "hyperv-vmbus-buffer",
+	.test_cases = vmbus_buffer_test_cases,
+};
+
+kunit_test_suite(vmbus_buffer_test_suite);
-- 
2.43.0

