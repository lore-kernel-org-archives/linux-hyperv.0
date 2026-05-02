Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA0821ADA4;
	Sat,  2 May 2026 04:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777696089; cv=none; b=VHQReUUq+gSqlJ7762BpEJsTjyBlUobftoqOC5LtIecGspz/JVK0kxW6Yb9LC1uhruD49Ot2tjMM2KPHiCISTDQj3f+FVBy/E4sP0Eog+8OYlQQp5OSRvxEM1xqIbwCgohGGGrqX4KbM232X/ofr93jNfExpgufV8znBPudTjG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777696089; c=relaxed/simple;
	bh=TObf4XIWmwhXR8Re/YMconnsoKjJ2V56JauBQc5rgfw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gFCAfndR5IQF4mT7lEn5jnPSCfULer/ZltgDLI1L93vBjsttm9j3DXuuaHP0KABu3+tP2odsYqsGEeFAzMHcVywmen/fhWLtYn8/lqJR2B2KEOgRBOeN0e5aBE8hUtbQFsYR6XQz1Sc7hHXaNoqLn0SmkWhOBJSkKapexIPAaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=O8VQlZVn; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="O8VQlZVn"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B686020B7168;
	Fri,  1 May 2026 21:28:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B686020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777696086;
	bh=mA6d133xBJJrXoX9Q6neAsNewcRZ8IoTG1ivHX8NLqk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=O8VQlZVn363KJb6t4m5+7ARP3MU5whKUt+lTXuRl+C2MdKYv7UKG8O6C5aSc1kpDz
	 5vCxt6qq3LvwdR8oivWwfPRZ6CK6ld67/mZ0gT1FpONHSxpW+gMwm2pMxBOkbbsDdu
	 JJbkzHJsrPWxmBEDOqch/HZX5x5d/HPutm27t/Fw=
Subject: [PATCH v2 10/18] mshv: Fix level-triggered check on uninitialized
 data
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 02 May 2026 04:28:06 +0000
Message-ID: 
 <177769608677.222166.8530189029476535062.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177769588777.222166.3414280094142944420.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

In mshv_irqfd_assign(), the level-triggered validation for resample
irqfds checks irqfd_lapic_irq.lapic_control.level_triggered before
mshv_irqfd_update() has populated the field. Since the irqfd struct is
zero-allocated, level_triggered is always 0 at that point, causing the
check to always reject resample irqfds with -EINVAL. This makes
level-triggered interrupt resampling — used to avoid interrupt storms
with assigned devices — completely non-functional.

Move the check after the mshv_irqfd_update() call, which resolves the
IRQ routing entry and populates irqfd_lapic_irq with the actual trigger
mode.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |   25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index b92e7f05aa9cd..3165f787994fc 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -483,6 +483,19 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 	init_poll_funcptr(&irqfd->irqfd_polltbl, mshv_irqfd_queue_proc);
 
 	spin_lock_irq(&pt->pt_irqfds_lock);
+	ret = 0;
+	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
+		if (irqfd->irqfd_eventfd_ctx != tmp->irqfd_eventfd_ctx)
+			continue;
+		/* This fd is used for another irq already. */
+		ret = -EBUSY;
+		spin_unlock_irq(&pt->pt_irqfds_lock);
+		goto fail;
+	}
+
+	idx = srcu_read_lock(&pt->pt_irq_srcu);
+	mshv_irqfd_update(pt, irqfd);
+
 #if IS_ENABLED(CONFIG_X86)
 	if (args->flags & BIT(MSHV_IRQFD_BIT_RESAMPLE) &&
 	    !irqfd->irqfd_lapic_irq.lapic_control.level_triggered) {
@@ -491,22 +504,12 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
 		 * Otherwise return with failure
 		 */
 		spin_unlock_irq(&pt->pt_irqfds_lock);
+		srcu_read_unlock(&pt->pt_irq_srcu, idx);
 		ret = -EINVAL;
 		goto fail;
 	}
 #endif
-	ret = 0;
-	hlist_for_each_entry(tmp, &pt->pt_irqfds_list, irqfd_hnode) {
-		if (irqfd->irqfd_eventfd_ctx != tmp->irqfd_eventfd_ctx)
-			continue;
-		/* This fd is used for another irq already. */
-		ret = -EBUSY;
-		spin_unlock_irq(&pt->pt_irqfds_lock);
-		goto fail;
-	}
 
-	idx = srcu_read_lock(&pt->pt_irq_srcu);
-	mshv_irqfd_update(pt, irqfd);
 	hlist_add_head(&irqfd->irqfd_hnode, &pt->pt_irqfds_list);
 	spin_unlock_irq(&pt->pt_irqfds_lock);
 


