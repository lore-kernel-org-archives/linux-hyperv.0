Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024119;
	b=OHUP/cOQs10AKbYRRaRzeD9wlDDMF9yMSXN4Rz4dg5b6WJGDHSGhjnlNcVqtSCQndL+V
	 9bCpPZz5cP0AI8BzwKH3HKqn7pjg/2Tnrfn6JObde0dtKlyyiESUS1PvklZlbMrWfpwL6
	 ehSsKEJ+OA262L7aAQ/lFIJH+gthNGqnqfKFXOUq3qs48zMZO/Dr8ujVllbNXGSObM3/J
	 F4UqnO4iwel0Y0h3BhUpCUu2wfL2rLP4M9tPS02Sjr6qfNp6Nt4ZEFpmsB2f79I49xYl5
	 zkIUolKgMaDfGWakfhVcCc0xXS8rZ2q+aYMJnjk4laem/WQld+xPG9mGDOuLOS56YXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024119;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=T8RWDlF0ZLHkwitlFe89Mvi++dGYI23jnLumllnM/JI=;
	b=zwYvkOzi4I0hSSJpef/h3U07qlyVHTdTiX7kbwr431CxkVQo7nLXg2vvTGWVfHYgVjyr
	 YY2oJq1OGRmuwlyu2VhJV9tYxVurgaJjgm+XJkiV7uYR7L9DHkc5BfjHfq+/8OhFQdzbp
	 bdgTipGUVmOC1mql8odF+PIavJLqGACS3kZJy9/9xTa0108UQCK+APdkRM6jEUKRW6nqA
	 IMOWhVRqpJ2UngTKFv8zCBM2NmRGlGgdkoW2OY9umD4YQM06aHy++Sm9mcnvmTHVN/wEI
	 704trCUeX2ablzoQRqpmH0iU31lwOAEiZwDWZr5FW0JnTP4jNe/Jjdsz89zcw/GmuBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lBxs5qhd;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F92F606A33A;
	Mon, 26 Oct 2026 14:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F92F606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=lBxs5qhd
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id BB80520B7166;
	Mon, 26 Oct 2026 07:15:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BB80520B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793024108;
	bh=T8RWDlF0ZLHkwitlFe89Mvi++dGYI23jnLumllnM/JI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lBxs5qhd1bwTrjjw7uML6ftK38sSt+QMPbEYPGnRNetPGqgmMo+8/RE6381cyrBhr
	 YPm2cJNGL8krHSYWXtLQqztNNyC1nDQudwIttgGkmrFmBhYQfM+mXOxc5gclqqzXd0
	 hHOm7MFR4z0wPgGkcOi2YqU/llLKn2v92O1OlXmI=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	weh@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v8 2/9] mshv: clear SynIC mappings before freeing them
Date: Mon, 26 Oct 2026 14:14:49 +0000
Message-ID: <20261026141512.2987985-3-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026141512.2987985-1-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
 <20261026141512.2987985-1-weh@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wei Hu <weh@microsoft.com>

Publish and withdraw per-CPU SynIC mapping pointers explicitly so
interrupt readers cannot retain stale addresses across CPU hotplug
teardown or initialization failure. Address the CPUHP callback CPU
directly and guard all cleanup paths against missing pages.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/hv/mshv_synic.c | 137 ++++++++++++++++++++--------------------
 1 file changed, 70 insertions(+), 67 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 7c168e5a740d..92fd9fb2071a 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -28,33 +28,31 @@ static int mshv_sint_irq = -1; /* Linux IRQ for mshv_sint_vector */
 
 static u32 synic_event_ring_get_queued_port(u32 sint_index)
 {
-	struct hv_synic_event_ring_page **event_ring_page;
+	struct hv_synic_event_ring_page *event_ring_page;
 	volatile struct hv_synic_event_ring *ring;
 	struct hv_synic_pages *spages;
-	u8 **synic_eventring_tail;
+	u8 *eventring_tail;
 	u32 message;
 	u8 tail;
 
 	spages = this_cpu_ptr(synic_pages);
-	event_ring_page = &spages->synic_event_ring_page;
-	synic_eventring_tail = (u8 **)this_cpu_ptr(hv_synic_eventring_tail);
+	event_ring_page = READ_ONCE(spages->synic_event_ring_page);
+	eventring_tail = READ_ONCE(*this_cpu_ptr(hv_synic_eventring_tail));
 
-	if (unlikely(!*synic_eventring_tail)) {
+	if (unlikely(!eventring_tail)) {
 		pr_debug("Missing synic event ring tail!\n");
 		return 0;
 	}
-	tail = (*synic_eventring_tail)[sint_index];
+	tail = eventring_tail[sint_index];
 
-	if (unlikely(!*event_ring_page)) {
+	if (unlikely(!event_ring_page)) {
 		pr_debug("Missing synic event ring page!\n");
 		return 0;
 	}
 
-	ring = &(*event_ring_page)->sint_event_ring[sint_index];
+	ring = &event_ring_page->sint_event_ring[sint_index];
 
-	/*
-	 * Get the message.
-	 */
+	/* Get the message. */
 	message = ring->data[tail];
 
 	if (!message) {
@@ -78,9 +76,6 @@ static u32 synic_event_ring_get_queued_port(u32 sint_index)
 			mb();
 			message = ring->data[tail];
 
-			/*
-			 * Ok, lets bail out.
-			 */
 			if (!message)
 				return 0;
 		}
@@ -88,15 +83,13 @@ static u32 synic_event_ring_get_queued_port(u32 sint_index)
 		ring->signal_masked = 1;
 	}
 
-	/*
-	 * Clear the message in the ring buffer.
-	 */
+	/* Clear the message in the ring buffer. */
 	ring->data[tail] = 0;
 
 	if (++tail == HV_SYNIC_EVENT_RING_MESSAGE_COUNT)
 		tail = 0;
 
-	(*synic_eventring_tail)[sint_index] = tail;
+	eventring_tail[sint_index] = tail;
 
 	return message;
 }
@@ -408,16 +401,17 @@ mshv_intercept_isr(struct hv_message *msg)
 void mshv_isr(void)
 {
 	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
-	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
+	struct hv_message_page *msg_page;
 	struct hv_message *msg;
 	bool handled;
 
-	if (unlikely(!(*msg_page))) {
+	msg_page = READ_ONCE(spages->hyp_synic_message_page);
+	if (unlikely(!msg_page)) {
 		pr_debug("Missing synic page!\n");
 		return;
 	}
 
-	msg = &((*msg_page)->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX]);
+	msg = &msg_page->sint_message[HV_SYNIC_INTERCEPTION_SINT_INDEX];
 
 	/*
 	 * If the type isn't set, there isn't really a message;
@@ -462,12 +456,10 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	union hv_synic_siefp siefp;
 	union hv_synic_sirbp sirbp;
 	union hv_synic_sint sint;
-	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
-	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
-	struct hv_synic_event_flags_page **event_flags_page =
-			&spages->synic_event_flags_page;
-	struct hv_synic_event_ring_page **event_ring_page =
-			&spages->synic_event_ring_page;
+	struct hv_synic_pages *spages = per_cpu_ptr(synic_pages, cpu);
+	struct hv_message_page *msg_page;
+	struct hv_synic_event_flags_page *event_flags_page;
+	struct hv_synic_event_ring_page *event_ring_page;
 	/*
 	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
 	 * See hv_hyp_synic_enable_regs() for that initialization.
@@ -484,11 +476,11 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 		simp.simp_enabled = true;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
 	}
-	*msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
-			     HV_HYP_PAGE_SIZE,
-			     MEMREMAP_WB);
+	msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
+			    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	WRITE_ONCE(spages->hyp_synic_message_page, msg_page);
 
-	if (!(*msg_page))
+	if (!msg_page)
 		goto cleanup_simp;
 
 	/*
@@ -500,35 +492,38 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 		siefp.siefp_enabled = true;
 		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
 	}
-	*event_flags_page = memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
-				     HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	event_flags_page = memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
+				    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	WRITE_ONCE(spages->synic_event_flags_page, event_flags_page);
 
-	if (!(*event_flags_page))
+	if (!event_flags_page)
 		goto cleanup_siefp;
 
 	/* Setup the Synic's event ring page */
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 
 	if (hv_root_partition()) {
-		*event_ring_page = memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
-					    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+		event_ring_page =
+			memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
+				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
 
-		if (!(*event_ring_page))
+		if (!event_ring_page)
 			goto cleanup_siefp;
 	} else {
 		/*
 		 * On L1VH the hypervisor does not provide a SIRBP page.
 		 * Allocate one and program its GPA into the MSR.
 		 */
-		*event_ring_page = (struct hv_synic_event_ring_page *)
+		event_ring_page = (struct hv_synic_event_ring_page *)
 			get_zeroed_page(GFP_KERNEL);
 
-		if (!(*event_ring_page))
+		if (!event_ring_page)
 			goto cleanup_siefp;
 
-		sirbp.base_sirbp_gpa = virt_to_phys(*event_ring_page)
+		sirbp.base_sirbp_gpa = virt_to_phys(event_ring_page)
 				>> HV_HYP_PAGE_SHIFT;
 	}
+	WRITE_ONCE(spages->synic_event_ring_page, event_ring_page);
 
 	sirbp.sirbp_enabled = true;
 	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
@@ -565,19 +560,22 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	return 0;
 
 cleanup_siefp:
-	if (*event_flags_page)
-		memunmap(*event_flags_page);
 	if (!vmbus_active) {
 		siefp.siefp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
 	}
+	WRITE_ONCE(spages->synic_event_ring_page, NULL);
+	WRITE_ONCE(spages->synic_event_flags_page, NULL);
+	if (event_flags_page)
+		memunmap(event_flags_page);
 cleanup_simp:
-	if (*msg_page)
-		memunmap(*msg_page);
 	if (!vmbus_active) {
 		simp.simp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
 	}
+	WRITE_ONCE(spages->hyp_synic_message_page, NULL);
+	if (msg_page)
+		memunmap(msg_page);
 
 	return -EFAULT;
 }
@@ -586,15 +584,17 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 {
 	union hv_synic_sint sint;
 	union hv_synic_sirbp sirbp;
-	struct hv_synic_pages *spages = this_cpu_ptr(synic_pages);
-	struct hv_message_page **msg_page = &spages->hyp_synic_message_page;
-	struct hv_synic_event_flags_page **event_flags_page =
-		&spages->synic_event_flags_page;
-	struct hv_synic_event_ring_page **event_ring_page =
-		&spages->synic_event_ring_page;
+	struct hv_synic_pages *spages = per_cpu_ptr(synic_pages, cpu);
+	struct hv_message_page *msg_page;
+	struct hv_synic_event_flags_page *event_flags_page;
+	struct hv_synic_event_ring_page *event_ring_page;
 	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
 	bool vmbus_active = hv_vmbus_exists();
 
+	msg_page = READ_ONCE(spages->hyp_synic_message_page);
+	event_flags_page = READ_ONCE(spages->synic_event_flags_page);
+	event_ring_page = READ_ONCE(spages->synic_event_ring_page);
+
 	/* Disable the interrupt */
 	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
 	sint.masked = true;
@@ -614,24 +614,18 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 	sirbp.sirbp_enabled = false;
 
-	if (hv_root_partition()) {
-		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
-		memunmap(*event_ring_page);
-	} else {
+	if (!hv_root_partition())
 		sirbp.base_sirbp_gpa = 0;
-		hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
-		free_page((unsigned long)*event_ring_page);
-	}
+	hv_set_non_nested_msr(HV_MSR_SIRBP, sirbp.as_uint64);
 
 	/*
-	 * Release our mappings of the message and event flags pages.
-	 * When VMBus is not active, we enabled SIMP/SIEFP — disable
-	 * them. Otherwise VMBus owns the MSRs — leave them.
+	 * When VMBus is not active, disable registers before withdrawing the
+	 * pointers visible to interrupt readers.
 	 */
-	memunmap(*event_flags_page);
 	if (!vmbus_active) {
 		union hv_synic_simp simp;
 		union hv_synic_siefp siefp;
+		union hv_synic_scontrol sctrl;
 
 		siefp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIEFP);
 		siefp.siefp_enabled = false;
@@ -640,18 +634,27 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 		simp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIMP);
 		simp.simp_enabled = false;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
-	}
-	memunmap(*msg_page);
-
-	/* When VMBus is active it owns SCONTROL — leave it. */
-	if (!vmbus_active) {
-		union hv_synic_scontrol sctrl;
 
 		sctrl.as_uint64 = hv_get_non_nested_msr(HV_MSR_SCONTROL);
 		sctrl.enable = 0;
 		hv_set_non_nested_msr(HV_MSR_SCONTROL, sctrl.as_uint64);
 	}
 
+	WRITE_ONCE(spages->synic_event_ring_page, NULL);
+	WRITE_ONCE(spages->synic_event_flags_page, NULL);
+	WRITE_ONCE(spages->hyp_synic_message_page, NULL);
+
+	if (event_ring_page) {
+		if (hv_root_partition())
+			memunmap(event_ring_page);
+		else
+			free_page((unsigned long)event_ring_page);
+	}
+	if (event_flags_page)
+		memunmap(event_flags_page);
+	if (msg_page)
+		memunmap(msg_page);
+
 	return 0;
 }
 
-- 
2.43.0

