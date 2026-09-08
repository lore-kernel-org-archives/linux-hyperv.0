Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EF953A890;
	Tue,  8 Sep 2026 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869662; cv=none; b=kIimh887N8U9lmCTpYL3h3Gs3Idiyxd7rNqPZlRT/5f1o+qwokVX7wdbFgxLSDCpAqQwIcXEjrsI1J3dlLB6XSSyw29Nbh7sNRofDGHX+tWoM1txZMxRIOZf8v/nvG9Dn4a8yheM00I+U3TlFkY9Nqb+g8xB9wM13XC1x2I9ReA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869662; c=relaxed/simple;
	bh=S9CP+L/RgFRJCuk1PTUfzCx+J1bqlERwoM2PaRrn1D0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDInuOzNBLChQoRlqiDHJsSiSuSSvy0UM9XryCx/8rDK3uOjtphESeQ7pGvNGf7PuzMypfC2krPq1QP8DXBL9hYfztVM0JUEH2lQP7+WxHzeoEtNmWLEOQKD6Hmr/TYiw2j0Hbeei6RZnTOIZynW5LrZSH+zx3BTcUl58Usdm78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=i3/XAMNx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="i3/XAMNx"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0770420B712B;
	Tue,  8 Sep 2026 05:13:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0770420B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788869609;
	bh=TjgKX2J9Dixnu+lAwzjsVfBFkbjUXHFd/rnDdpxlKzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i3/XAMNxw46gU9+yapa4fNMwYgfikRb04YCIQPsLOeAFZ0lY8Ein3yJUD6Whdd6UT
	 DiD24esGps4XURk9rnnQGCYljztKdbywilypkQRPh+eL3uafBruEoMXo7iG0y2BgyH
	 sIdfUrOPjb/5jlr0RNpDsw6STkhp9j1sPC88Hvx4=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v5 2/9] mshv: clear SynIC mappings before freeing them
Date: Tue,  8 Sep 2026 12:13:35 +0000
Message-ID: <20260908121403.1160280-3-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908121403.1160280-1-weh@linux.microsoft.com>
References: <20260831112704.2851147-1-weh@linux.microsoft.com>
 <20260908121403.1160280-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
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
 drivers/hv/mshv_synic.c | 136 ++++++++++++++++++++--------------------
 1 file changed, 69 insertions(+), 67 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 7c168e5a740d..c77688b8d23c 100644
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
@@ -500,35 +492,37 @@ static int mshv_synic_cpu_init(unsigned int cpu)
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
+		event_ring_page = memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
+					   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
 
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
@@ -565,19 +559,22 @@ static int mshv_synic_cpu_init(unsigned int cpu)
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
@@ -586,15 +583,17 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
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
@@ -614,24 +613,18 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
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
@@ -640,18 +633,27 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
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

