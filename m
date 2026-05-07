Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55AEF44A725;
	Thu,  7 May 2026 15:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168625; cv=none; b=bQYGkqpiWhoI40jEHlCRbkhBtmo0ykqUrysDLlHb8fesLw3LoHk7/K3Btph3p0+w5r3mcyTn9woT4UpjFyQUs1RdXzatepsMdEDoAPbZ8wAos+oUQx5BWBDq/GnK6wBYQwuJZRCoK9FMmuBK4AK5S0uxCw7ELjkWWRdqa6hzu/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168625; c=relaxed/simple;
	bh=+1qavQbYqAq8IbSG94bf/IYFx2OboRHWRF9djwzFPek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BzzdtVmSEkZXXGtkBICYAr52VjxrLWA23QDQgDbefhyry7ZNjkMCpcZdP6TSRqJm3zMNYNiyw1gjrE0t5LpkhRQN0br/xN+QZmUXacr7y93SQ7f162KRajUkTRyJP0ulQ/n1QTrJNziQrIDWXt30gltOepcAL+vpFyD6iOkkWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EsE1bN3t; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EsE1bN3t"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B64A320B7169;
	Thu,  7 May 2026 08:43:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B64A320B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168620;
	bh=J5WjrPsnwyiN6tNx2/51Z3Pk6whEXbKxQfLna/EqC/A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=EsE1bN3t6KfmMj6n1cIxKJYyo94UFcvfBFFFHRWjdA2VinaZZ6tFz9QmJewxNXHFI
	 rF+MD7L6aYEA9lKGBLzbCP46tgLyxQOyAqlIzbp3X8nvrM7jRsDvx4MqfPrF40vQXs
	 1Ya1nD/XEDKUVlRoeexeA7PWyfDLOutbEKFHel8c=
Subject: [PATCH v4 08/18] mshv: Fix level-triggered check on uninitialized
 data
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:43 +0000
Message-ID: 
 <177816862362.21765.11809618639989414561.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
index c24069dff9702..11a6006f80194 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -491,6 +491,19 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
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
@@ -499,22 +512,12 @@ static int mshv_irqfd_assign(struct mshv_partition *pt,
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
 


