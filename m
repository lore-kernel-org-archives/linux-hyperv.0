Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D25C428833;
	Thu,  7 May 2026 15:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168597; cv=none; b=Vzzuo7lT0COBzb/VmAKKUoLDpHn4/xsliHP8ZBrkCYS+tZGCisXok6azgTkBpWqA5ZX3NY110UBCGHntcMbYrItj2KGWfNQ83qQVP3+sMiLq4yqNBSib4voTULn8ic5vYyojM1keGKmKSKlsCtWG+bJWbwoI8o2xtzfoOMTp6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168597; c=relaxed/simple;
	bh=GCszAkUZ6N6PEeO5JRUc3/8x0N+lseW9YMRCRB1R8t4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VC5HC9sGs+jOTh1RkNpTFdoFwWaH0ckciyBXHKKyeJSLajyJR3wTs6s4pqdWJrgpY0LmT4TBFCnBM7zhdtlcI+0NPZ2J3vr3gSpFV/cg4jcnjmlQE828s9dHeF9Dr7Uv3yGHeG5iMTY2nuC5iaRuZRqHrsuH8PNp23AhqT+ZtmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VBEyLeEB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VBEyLeEB"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9731B20B7167;
	Thu,  7 May 2026 08:43:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9731B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168592;
	bh=lHdBDtdX+i2Bvo0Y7puGK3HjcBr6MONWxySGf+EzWrk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=VBEyLeEBwu4EJSXMqp/4L/B7ZX0m1Bu3YvUVj3A3xgcGOaMUVkXWLdsGqscQ9mzX6
	 /hhMWxbsm8tBo4/e4wbLtT2XG+xgEyWz6xbSaujz+NfYbkStrfQ6RjsS6GV0OqYEfN
	 G8eLDpvttRICupiQ1A2fNQ5qhVp3ewjGjPlnanpw=
Subject: [PATCH v4 03/18] mshv: Fix race in mshv_irqfd_deassign
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:43:15 +0000
Message-ID: 
 <177816859556.21765.6200058614819106223.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
Content-Transfer-Encoding: 7bit

mshv_irqfd_deactivate() and the hlist traversal of pt_irqfds_list
require pt->pt_irqfds_lock to be held, but mshv_irqfd_deassign()
omits it. This races with the EPOLLHUP path in mshv_irqfd_wakeup(),
which does take the lock before calling mshv_irqfd_deactivate().

Additionally, mshv_irqfd_deactivate() uses hlist_del() which poisons
the node pointers rather than resetting them. Since
mshv_irqfd_is_active() relies on hlist_unhashed() (checks pprev ==
NULL), a poisoned node still appears active. If a concurrent path calls
mshv_irqfd_deactivate() again on the same irqfd, the guard fails to
prevent a double hlist_del() on poisoned pointers.

Fix both issues:
- Add the missing spin_lock_irq/spin_unlock_irq around the list
  traversal in mshv_irqfd_deassign(), matching mshv_irqfd_release().
- Use hlist_del_init() instead of hlist_del() so the node is properly
  marked as unhashed after removal, making the is_active guard reliable.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_eventfd.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
index 90959f639dc32..5995a62aff8d8 100644
--- a/drivers/hv/mshv_eventfd.c
+++ b/drivers/hv/mshv_eventfd.c
@@ -284,7 +284,7 @@ static void mshv_irqfd_deactivate(struct mshv_irqfd *irqfd)
 	if (!mshv_irqfd_is_active(irqfd))
 		return;
 
-	hlist_del(&irqfd->irqfd_hnode);
+	hlist_del_init(&irqfd->irqfd_hnode);
 
 	queue_work(irqfd_cleanup_wq, &irqfd->irqfd_shutdown);
 }
@@ -541,13 +541,14 @@ static int mshv_irqfd_deassign(struct mshv_partition *pt,
 	if (IS_ERR(eventfd))
 		return PTR_ERR(eventfd);
 
+	spin_lock_irq(&pt->pt_irqfds_lock);
 	hlist_for_each_entry_safe(irqfd, n, &pt->pt_irqfds_list,
 				  irqfd_hnode) {
 		if (irqfd->irqfd_eventfd_ctx == eventfd &&
 		    irqfd->irqfd_irqnum == args->gsi)
-
 			mshv_irqfd_deactivate(irqfd);
 	}
+	spin_unlock_irq(&pt->pt_irqfds_lock);
 
 	eventfd_ctx_put(eventfd);
 


