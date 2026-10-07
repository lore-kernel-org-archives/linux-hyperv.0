Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDA04E141D
	for <linux-hyperv@vger.kernel.org>; Wed,  7 Oct 2026 19:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791400150; cv=none; b=gc6N+qK/Isw5YJrBJIsHAM072vxRVh3ZG8xGnwddH7ggGDH3v8h7mahYci8JjzAkDOzJXMWq77Wr9gOGWYzURH1eg5KCKM8t3xWj+0bCD41s3V7KouOrEfywOjkZxul27ldmnAQovtDtNLbzQazAVeyCY5ZO+NUuAiMyJjF3xMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791400150; c=relaxed/simple;
	bh=mQEHFRU1/q1X92pZCZTMI6+GIORG7OleZBFPde3RJ/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IVocRgXXvyhNHVzZPpIA8Y6AaRMtLZzbZGhKD0n/+Iq3RdRGGyhZFJSbdKtivSWF/E1c8ZecuP6bmRrT356oxQy4vjOyo7HDx8/zVCPBw5Utq/2sWV9UWpNM4tftCXRTYWE5CE3EE1Z1vfHagcXeQoZoPciziGVtEsZXUWywPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxpjcUP+; arc=none smtp.client-ip=209.85.217.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxpjcUP+"
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-78fb9d46f0aso1204068137.0
        for <linux-hyperv@vger.kernel.org>; Wed, 07 Oct 2026 12:09:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791400148; x=1792004948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iRVpQFxGHITFMIosTNxFLIsr19cq8kutjR3XgtUFGaY=;
        b=qxpjcUP+sRNrMEC9VtdEeHRT5KXo0BZlYbxCfC3YgTsCbyw/CkV+b6fjxTNHFXDxru
         Dlv/ziXQH2bFCGPm8U5NndkpAweEBNOARwULiAC/6t9b3rndKhn3Q6+MzrY2lnItIq0S
         /T/mxNVrePg0uFhuUqzNnspQsvKN1F/UFpxiKRvpehNLjGYw6TwB4ofKFP7lh/QHOBx5
         hpyxR7uITah2Md8wBZIHA8vBsOuFHxTBHoR3LGXqMJ5v+NQuYpRmWnPy2OvPI/S9b531
         NNw6oBF5tX0FtlIk4yOwCm1LZM1s3v5oT2Mb7d/9EDFziXp785i8yK+C3/VEB8IyMH/C
         PI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791400148; x=1792004948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=iRVpQFxGHITFMIosTNxFLIsr19cq8kutjR3XgtUFGaY=;
        b=oXyxmmVqnyQn+U/qxmgJ5/zQfkdt7fCIVN7jBpZXLakoCjyRPQseLiCg4y95NxfKXK
         zY5RADeOLTMH0sS9bfmBoijaFH+FnJB6/5q/fqPoNl34emriPvraEuRrypHR9Jn8GFKW
         XdQ+dIrmHoWMl5DWFE+dN9Ydxgazz05alQy5EvrpKCqWA8KyW1K2UT8cPY/A/gfmqzq1
         LEXJYQyE7ptC2il4ymu7ukuOkgUSpQz0YDpSKMjClsVpzx4Pd4oDFv3c5C+TjzAzW/SU
         Al/CjZq9EBQi1Ajz2e3yzarqDxBk0O+lLOJBYf2sGUyfzTVJISJEyhq2MMCu1OZ3kcK3
         drKw==
X-Forwarded-Encrypted: i=1; AKwUvBwVwxu/F5u1ePM2ywtfci/FHrT+qQMvVI3GvypgcW3+H3XIuGX+OMXkjmLCmgJOBJkYIl9iMpOijoi0GHE=@vger.kernel.org
X-Gm-Message-State: AFq9FYIAct5YpiX+kFa58ymmaJYYa1DOKhr0UaJmEfcuIQC703axo56C
	R7BpN0JFzSEY1c+WvkiyPgC7FAbheXtuWjpkUzYisqwr6/vOippeWcC2
X-Gm-Gg: AYBFou0yzCN100osWBjhFMOkzndibexPRjV8Oqh5VBgXTI2eiYw2wFPPA1xYgCTRel1
	lLOR6H3CsXIRmYuFQM5y2LXoe9oCWj6R0HUnc0CoEoeZ3Io8JdMT+jtFVSvdLtPExOUgSSySR0p
	pJ1++PpE+RA5kwiGRIg60avI2azB3UwO5MFB5hrvXB2BexwYoXkL8FUjyuTbu+nAgPGWeaIWL0/
	pWQNUf+Ak6g4fxIQS1MV2fcd2snulLkdhpfX048ZlsR89XFgzOW06f9/W04+7IDb4JbgAe+00VU
	7KXY27eawq+DpDEnYslwbP9ErMl5+/UpUENFQoOQFGz7+nCJTwE7p4lWDzUHlSBFWUmlN/K4sYQ
	euoHiliJB+9DekH1xvYJz9rDL9taUY4X7i+/0Z9T/axxOTXcH3VqKfLDqnVQWidzHktIcAQWPfb
	ZUHubQBA2dviy9DkX5Iy8wjNFBmvuiJVLWPSUwWDzfG09/Zd/UKPggbejiFM7lhTa6dfkefgy7V
	6KZn5P6TIX8ijfEwMiUE49VRLRQCA==
X-Received: by 2002:a05:6102:2924:b0:7ad:3ad3:997a with SMTP id ada2fe7eead31-7ca36e443a7mr1092386137.5.1791400147473;
        Wed, 07 Oct 2026 12:09:07 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([74.244.222.41])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7ca218138c6sm2456787137.12.2026.10.07.12.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 12:09:06 -0700 (PDT)
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
Subject: [PATCH v2 11/14] hv: vmbus: vmalloc requestor metadata
Date: Wed,  7 Oct 2026 16:07:49 -0300
Message-ID: <20261007190752.336426-12-emersonbusson@gmail.com>
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

Channel opens allocate request-ID arrays from the ring size. With the
128-page default ring, kvcalloc() can request an order-7 allocation. The
bitmap created by bitmap_zalloc() is another physically contiguous
allocation; at normal NetVSC sizes it can require order-1 pages. Either
allocation can fail under buddy fragmentation while order-0 pages remain
available.

Always allocate both guest-private structures with vzalloc(). Reject a
zero requestor count and check byte-size calculations before allocating,
then pair the allocations with vfree() on rollback and teardown. Neither
structure is exposed to the host, so neither needs to be decrypted for
Confidential Computing.

Extend KUnit coverage to require vmalloc backing for a typical 8 KiB
requestor array, a bitmap larger than one page, and an array above
KMALLOC_MAX_SIZE. Existing requestor cases continue to cover ID lifecycle
and cleanup.

Rollback trigger: revert if requestor metadata is exposed to the host, if
request-ID allocation or teardown regresses on a healthy channel open, or
if hyperv-vmbus-buffer KUnit fails.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/channel.c           |  39 ++++++--
 drivers/hv/hyperv_vmbus.h      |  11 +++
 drivers/hv/vmbus_buffer_test.c | 160 +++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 2793ca1b7f32..c7f3f5c6c0d2 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -1411,14 +1411,26 @@ EXPORT_SYMBOL_GPL(vmbus_alloc_buffer);
  * keeps track of the next available slot in the array. Initially, each
  * slot points to the next one (as in a Linked List). The last slot
  * does not point to anything, so its value is U64_MAX by default.
+ *
+ * Allocated with vzalloc() rather than kvcalloc(). kvcalloc() can use a
+ * higher-order kmalloc allocation for arrays up to KMALLOC_MAX_SIZE, so
+ * both small requestor arrays and the default 128-page ring array may need
+ * contiguous pages while opening a channel under buddy fragmentation. The
+ * array is guest-private request bookkeeping -- the host never sees the
+ * slot values -- so a vmalloc-backed mapping carries no Confidential
+ * Computing implication and needs no set_memory_decrypted().
  * @size: The size of the array
  */
-static u64 *request_arr_init(u32 size)
+u64 *request_arr_init(u32 size)
 {
-	int i;
+	size_t bytes;
+	u32 i;
 	u64 *req_arr;
 
-	req_arr = kcalloc(size, sizeof(u64), GFP_KERNEL);
+	if (!size || check_mul_overflow((size_t)size, sizeof(*req_arr), &bytes))
+		return NULL;
+
+	req_arr = vzalloc(bytes);
 	if (!req_arr)
 		return NULL;
 
@@ -1436,8 +1448,9 @@ static u64 *request_arr_init(u32 size)
  * Index 0 is the first free slot
  * @size: Size of the requestor array
  */
-static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
+int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
 {
+	size_t bitmap_longs, bitmap_bytes;
 	u64 *rqst_arr;
 	unsigned long *bitmap;
 
@@ -1445,9 +1458,17 @@ static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
 	if (!rqst_arr)
 		return -ENOMEM;
 
-	bitmap = bitmap_zalloc(size, GFP_KERNEL);
+	bitmap_longs = size / BITS_PER_LONG;
+	if (size % BITS_PER_LONG)
+		bitmap_longs++;
+	if (check_mul_overflow(bitmap_longs, sizeof(*bitmap), &bitmap_bytes)) {
+		vfree(rqst_arr);
+		return -ENOMEM;
+	}
+
+	bitmap = vzalloc(bitmap_bytes);
 	if (!bitmap) {
-		kfree(rqst_arr);
+		vfree(rqst_arr);
 		return -ENOMEM;
 	}
 
@@ -1464,10 +1485,10 @@ static int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size)
  * vmbus_free_requestor - Frees memory allocated for @rqstor
  * @rqstor: Pointer to the requestor struct
  */
-static void vmbus_free_requestor(struct vmbus_requestor *rqstor)
+void vmbus_free_requestor(struct vmbus_requestor *rqstor)
 {
-	kfree(rqstor->req_arr);
-	bitmap_free(rqstor->req_bitmap);
+	vfree(rqstor->req_arr);
+	vfree(rqstor->req_bitmap);
 }
 
 static int __vmbus_open(struct vmbus_channel *newchannel,
diff --git a/drivers/hv/hyperv_vmbus.h b/drivers/hv/hyperv_vmbus.h
index 2edeb7988bdc..9819a6b686ce 100644
--- a/drivers/hv/hyperv_vmbus.h
+++ b/drivers/hv/hyperv_vmbus.h
@@ -648,4 +648,15 @@ int vmbus_gpadl_teardown_request(struct vmbus_channel *channel,
 void vmbus_complete_gpadl_teardown(struct vmbus_connection *connection,
 				   struct vmbus_channel_gpadl_torndown *response);
 
+/*
+ * Requestor array lifetime helpers, shared with vmbus_buffer_test.c for
+ * the same reason as the sizing helpers. Defined in channel.c, unexported.
+ * request_arr_init() returns a vmalloc-backed array the caller must vfree();
+ * vmbus_alloc_requestor() owns both vmalloc-backed objects on success, and
+ * vmbus_free_requestor() releases them.
+ */
+u64 *request_arr_init(u32 size);
+int vmbus_alloc_requestor(struct vmbus_requestor *rqstor, u32 size);
+void vmbus_free_requestor(struct vmbus_requestor *rqstor);
+
 #endif /* _HYPERV_VMBUS_H */
diff --git a/drivers/hv/vmbus_buffer_test.c b/drivers/hv/vmbus_buffer_test.c
index 5c8e70d861ad..d0102dabef73 100644
--- a/drivers/hv/vmbus_buffer_test.c
+++ b/drivers/hv/vmbus_buffer_test.c
@@ -10,6 +10,7 @@
 #include <linux/completion.h>
 #include <linux/hyperv.h>
 #include <linux/mm.h>
+#include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 
@@ -776,6 +777,160 @@ static void vmbus_buffer_order_zero_allocation_test(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, context.attempts, (unsigned int)MAX_PAGE_ORDER + 1);
 }
 
+/*
+ * Requestor metadata must use vmalloc backing because both the array and its
+ * bitmap can require multiple pages. The requestor is guest-private
+ * bookkeeping: the host never sees the slot values, so this mapping has no
+ * Confidential Computing implication and needs no set_memory_decrypted().
+ * Cover a typical 8 KiB array, a requestor whose bitmap exceeds one page,
+ * and a size beyond KMALLOC_MAX_SIZE without memory pressure.
+ */
+static void vmbus_requestor_alloc_free_test(struct kunit *test)
+{
+	struct vmbus_requestor rqstor = {};
+
+	KUNIT_ASSERT_EQ(test, vmbus_alloc_requestor(&rqstor, 4), 0);
+	KUNIT_EXPECT_EQ(test, rqstor.size, 4U);
+	KUNIT_EXPECT_EQ(test, rqstor.next_request_id, 0U);
+	KUNIT_EXPECT_NOT_NULL(test, rqstor.req_arr);
+	KUNIT_EXPECT_NOT_NULL(test, rqstor.req_bitmap);
+
+	/* The free list links 0->1->2->3 and terminates in U64_MAX. */
+	KUNIT_EXPECT_EQ(test, rqstor.req_arr[0], 1U);
+	KUNIT_EXPECT_EQ(test, rqstor.req_arr[1], 2U);
+	KUNIT_EXPECT_EQ(test, rqstor.req_arr[2], 3U);
+	KUNIT_EXPECT_EQ(test, rqstor.req_arr[3], U64_MAX);
+
+	vmbus_free_requestor(&rqstor);
+}
+
+static void vmbus_requestor_vmalloc_backing_test(struct kunit *test)
+{
+	/*
+	 * Cover the small array, a requestor whose bitmap exceeds one page,
+	 * and a size beyond KMALLOC_MAX_SIZE. All requestor metadata must use
+	 * vmalloc backing regardless of size or allocator pressure.
+	 */
+	u32 small_size = 1024;
+	u32 bitmap_size = (PAGE_SIZE / sizeof(unsigned long)) * BITS_PER_LONG + 1;
+	u32 size = (KMALLOC_MAX_SIZE / sizeof(u64)) + 1;
+	struct vmbus_requestor rqstor = {};
+	u64 *req_arr;
+
+	KUNIT_EXPECT_PTR_EQ(test, request_arr_init(0), NULL);
+
+	req_arr = request_arr_init(small_size);
+	KUNIT_ASSERT_NOT_NULL(test, req_arr);
+	KUNIT_EXPECT_TRUE(test, is_vmalloc_addr(req_arr));
+	KUNIT_EXPECT_EQ(test, req_arr[0], 1U);
+	KUNIT_EXPECT_EQ(test, req_arr[small_size - 1], U64_MAX);
+	vfree(req_arr);
+
+	req_arr = request_arr_init(size);
+	KUNIT_ASSERT_NOT_NULL(test, req_arr);
+	KUNIT_EXPECT_TRUE(test, is_vmalloc_addr(req_arr));
+	KUNIT_EXPECT_EQ(test, req_arr[0], 1U);
+	KUNIT_EXPECT_EQ(test, req_arr[size - 1], U64_MAX);
+	vfree(req_arr);
+
+	KUNIT_ASSERT_EQ(test, vmbus_alloc_requestor(&rqstor, bitmap_size), 0);
+	KUNIT_EXPECT_TRUE(test, is_vmalloc_addr(rqstor.req_arr));
+	KUNIT_EXPECT_TRUE(test, is_vmalloc_addr(rqstor.req_bitmap));
+	vmbus_free_requestor(&rqstor);
+}
+
+static void vmbus_requestor_id_lifecycle_test(struct kunit *test)
+{
+	struct vmbus_channel channel = { .rqstor_size = 4 };
+	struct vmbus_requestor *rqstor = &channel.requestor;
+	u64 id0, id1, id2, id3, addr;
+
+	KUNIT_ASSERT_EQ(test, vmbus_alloc_requestor(rqstor, 4), 0);
+
+	/* IDs are 1-based; 0 is reserved for unsolicited host messages. */
+	id0 = vmbus_next_request_id(&channel, 0x1000);
+	KUNIT_EXPECT_EQ(test, id0, 1U);
+	id1 = vmbus_next_request_id(&channel, 0x2000);
+	KUNIT_EXPECT_EQ(test, id1, 2U);
+
+	/* Consumption returns the registered address and frees the slot. */
+	addr = vmbus_request_addr_match(&channel, id0, VMBUS_RQST_ADDR_ANY);
+	KUNIT_EXPECT_EQ(test, addr, 0x1000U);
+	addr = vmbus_request_addr_match(&channel, id1, 0x2000);
+	KUNIT_EXPECT_EQ(test, addr, 0x2000U);
+
+	/*
+	 * Consumed slots are reusable. The free list is LIFO -- each
+	 * consume pushes its slot onto the head -- so the slot freed last
+	 * is the one handed out first. Freeing id0 then id1 leaves slot 1
+	 * at the head, and the next ID is therefore id1 again, not id0.
+	 */
+	id2 = vmbus_next_request_id(&channel, 0x3000);
+	KUNIT_EXPECT_EQ(test, id2, id1);
+	id3 = vmbus_next_request_id(&channel, 0x4000);
+	KUNIT_EXPECT_EQ(test, id3, id0);
+
+	vmbus_free_requestor(rqstor);
+}
+
+static void vmbus_requestor_invalid_ids_test(struct kunit *test)
+{
+	struct vmbus_channel channel = { .rqstor_size = 4 };
+	struct vmbus_requestor *rqstor = &channel.requestor;
+	u64 id, addr;
+
+	KUNIT_ASSERT_EQ(test, vmbus_alloc_requestor(rqstor, 4), 0);
+
+	/* ID 0 is the unsolicited-message sentinel and is never in the set. */
+	KUNIT_EXPECT_EQ(test, vmbus_request_addr_match(&channel, 0, 0),
+			VMBUS_RQST_ERROR);
+
+	/* Out-of-range IDs are refused, not wrapped. */
+	KUNIT_EXPECT_EQ(test, vmbus_request_addr_match(&channel, 5, 0),
+			VMBUS_RQST_ERROR);
+	KUNIT_EXPECT_EQ(test, vmbus_request_addr_match(&channel, U64_MAX, 0),
+			VMBUS_RQST_ERROR);
+
+	id = vmbus_next_request_id(&channel, 0xABCD);
+	KUNIT_ASSERT_EQ(test, id, 1U);
+
+	/* A wrong expected address does not consume the slot. */
+	addr = vmbus_request_addr_match(&channel, id, 0x9999);
+	KUNIT_EXPECT_EQ(test, addr, 0xABCDU);
+
+	/* The slot is still live and a matching lookup consumes it once. */
+	addr = vmbus_request_addr_match(&channel, id, 0xABCD);
+	KUNIT_EXPECT_EQ(test, addr, 0xABCDU);
+
+	/* Replay: the slot is gone. */
+	addr = vmbus_request_addr_match(&channel, id, VMBUS_RQST_ADDR_ANY);
+	KUNIT_EXPECT_EQ(test, addr, VMBUS_RQST_ERROR);
+
+	vmbus_free_requestor(rqstor);
+}
+
+static void vmbus_requestor_exhaustion_test(struct kunit *test)
+{
+	struct vmbus_channel channel = { .rqstor_size = 2 };
+	struct vmbus_requestor *rqstor = &channel.requestor;
+
+	KUNIT_ASSERT_EQ(test, vmbus_alloc_requestor(rqstor, 2), 0);
+
+	KUNIT_EXPECT_EQ(test, vmbus_next_request_id(&channel, 0x1), 1U);
+	KUNIT_EXPECT_EQ(test, vmbus_next_request_id(&channel, 0x2), 2U);
+
+	/* Both slots taken: the free list is empty and the API says so. */
+	KUNIT_EXPECT_EQ(test, vmbus_next_request_id(&channel, 0x3),
+			VMBUS_RQST_ERROR);
+
+	/* An uninitialized requestor is not a full one. */
+	channel.rqstor_size = 0;
+	KUNIT_EXPECT_EQ(test, vmbus_next_request_id(&channel, 0x4),
+			VMBUS_NO_RQSTOR);
+
+	vmbus_free_requestor(rqstor);
+}
+
 static struct kunit_case vmbus_buffer_test_cases[] = {
 	KUNIT_CASE(vmbus_buffer_size_rounding_test),
 	KUNIT_CASE(vmbus_buffer_size_overflow_test),
@@ -805,6 +960,11 @@ static struct kunit_case vmbus_buffer_test_cases[] = {
 	KUNIT_CASE(vmbus_gpadl_post_success_test),
 	KUNIT_CASE(vmbus_gpadl_response_state_test),
 	KUNIT_CASE(vmbus_gpadl_teardown_post_failure_test),
+	KUNIT_CASE(vmbus_requestor_alloc_free_test),
+	KUNIT_CASE(vmbus_requestor_vmalloc_backing_test),
+	KUNIT_CASE(vmbus_requestor_id_lifecycle_test),
+	KUNIT_CASE(vmbus_requestor_invalid_ids_test),
+	KUNIT_CASE(vmbus_requestor_exhaustion_test),
 	{}
 };
 
-- 
2.43.0
