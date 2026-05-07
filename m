Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1087B44CAF7;
	Thu,  7 May 2026 15:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778168663; cv=none; b=E4PjKs5plwqU8KDGt7eU9PFhoIBPN8wtKZCGzA+7zs9SHUty96y7PLHbdL5K1TQuu1ypmbP26FR+RbAwD51JqOgVMNovHwXSySeH5PLXThJhH+RVW6YGiMZbaJ/WeKYU7hx2pB60BK35QtDBmxIdXIzk2PNOUaDEv2oMJUwVC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778168663; c=relaxed/simple;
	bh=cc9fOzfM6FkSnbFE7ATn3kH3yP3bi5JA5X+BcOV42+U=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tVN+3MRvrW/Ni+JcPSiqXmPddqvMMLqomPX3V0DZjZTdtEFTX5hMkLILu0s3SIBpE9LimzZ3/r7EwRvgSqaSNS9+CmF0u7jmWtvdrzKDqGLUn5rfMuMNG9pacLljEL11oF5HTie6DI3qd779V3zqjPR/mNO2jXA3PBJsxdiKVC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QuuQ2a1S; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QuuQ2a1S"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8AE3420B7165;
	Thu,  7 May 2026 08:44:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8AE3420B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778168658;
	bh=L2ymyV4ovIf/eCaF2+6/x1CckAl2okWrPirCBf8MqKg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QuuQ2a1SmytSWnKdaHvclZiZyPSGTE3yGW/bAjuGmebdVERtk+tiQloMcW3MPOSmL
	 pKyXpIPgn9ZGy4DIt1PPyNA7IsWMCJe7aYJGqfubfN1v3I0+eI92oOIrRzEb0zqjYr
	 qGtnfM98VPYsc0Q7EtOC0yyMgjzsZY3GCGUhXSbw=
Subject: [PATCH v4 15/18] mshv: Defer mshv_vp free to an RCU grace period
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 07 May 2026 15:44:21 +0000
Message-ID: 
 <177816866152.21765.16203922564983237274.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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

destroy_partition() frees mshv_vp with plain kfree() while ISR readers
walk pt_vp_array[] under rcu_read_lock().  On non-root schedulers,
where drain_all_vps() does not run, an in-flight intercept ISR can
observe a non-NULL pt_vp_array slot and dereference freed memory in
kick_vp().  On the root scheduler the same race exists in a narrower
form: drain_vp_signals() synchronises on kick_vp()'s kicked_by_hv flag
but not on its wake_up() tail, so the wait-queue lock embedded in vp
can still be held when destroy_partition() reaches kfree(vp).

Add struct rcu_head vp_rcu to struct mshv_vp, clear the pt_vp_array
slot before the free, and use kfree_rcu() so the actual kfree happens
after a grace period.  drain_all_vps() is retained because it serves a
separate purpose (telling the hypervisor to stop signalling and
reconciling signal counts) that kfree_rcu() does not address.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root.h      |    1 +
 drivers/hv/mshv_root_main.c |    5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index b6961a6d9a98b..e19a84ea07905 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -35,6 +35,7 @@ static_assert(HV_HYP_PAGE_SIZE == MSHV_HV_PAGE_SIZE);
 #define MSHV_PIN_PAGES_BATCH_SIZE	(0x10000000ULL / HV_HYP_PAGE_SIZE)
 
 struct mshv_vp {
+	struct rcu_head vp_rcu;
 	u32 vp_index;
 	struct mshv_partition *vp_partition;
 	struct mutex vp_mutex;
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 381aa86c5b90e..e32f6e0f9f637 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -30,6 +30,7 @@
 #include <linux/panic_notifier.h>
 #include <linux/vmalloc.h>
 #include <linux/rseq.h>
+#include <linux/rcupdate.h>
 
 #include "mshv_eventfd.h"
 #include "mshv.h"
@@ -1915,9 +1916,9 @@ static void destroy_partition(struct mshv_partition *partition)
 				vp->vp_ghcb_page = NULL;
 			}
 
-			kfree(vp);
-
 			partition->pt_vp_array[i] = NULL;
+
+			kfree_rcu(vp, vp_rcu);
 		}
 
 		mshv_debugfs_partition_remove(partition);


