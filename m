Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A2374C10F5;
	Thu, 15 Oct 2026 08:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052644; cv=none; b=M+IFYTaKOKZiK5cI7/N1xbUizi28CJ+P3SjKp2gPo/qFhj8jJGbSdMsejjMYxYPLwr38ngYFzqYToJI7+FoKgJ0KYjqWACgZEPHwGTpRmvRkUEy/4bLtDhIFxK2HtOpQ+r8PT8cp3lMuvRB2BwYATsPUp/thR74uHA6UFIs61TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052644; c=relaxed/simple;
	bh=XcLkKEd3NqVTgzSdtdjBcyUHKP4q/E1XsiAeMQO3tEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jzopnkJXLKPaSTOCfhHf40GlhJpAWhTM1gogAzDnDIE4JYMfiHeSww/boqpFs/pyTmRQWgBhGTmY44UfCgCTO5K0UnfvQVwhjVoqnKbpfOfmXgOLvOk6N9c5AYydN0YBIWerxUiKdYm1+cSCq/XTEX2rM31upFgnBxEqCvnjjbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WlRtZokq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WlRtZokq"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id 353C120B7167;
	Thu, 15 Oct 2026 01:23:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 353C120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792052638;
	bh=eg2DwiPr5Y+nznzLP+qxrupdMG+RIQzVHXgoOtYMalw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WlRtZokq1SmWs85f5lKUW8xPqV8SOG0FiVJLOYLto+9QiFH70yFUEnRbR0pwTva1G
	 +bMEBE/yT7RHWBpdd/A1Wtuz2nug1b0MN2GPDAYIE90FCgUtoRe0i5+rBdPhYxCocF
	 CSvjHY9pvzp5Dd2NOKZCoAh2iGQNt5wEkB3SqHWI=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: joro@8bytes.org
Cc: iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lkp@intel.com,
	oe-kbuild-all@lists.linux.dev,
	joerg.roedel@amd.com,
	jgg@nvidia.com,
	will@kernel.org,
	robin.murphy@arm.com,
	mhklinux@outlook.com,
	wei.liu@kernel.org,
	jacob.pan@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com
Subject: [PATCH 2/2] iommu/hyperv: Make hv_iommu_device static
Date: Thu, 15 Oct 2026 16:23:51 +0800
Message-ID: <20261015082351.184252-3-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
References: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make hv_iommu_device static to give it internal linkage. This
pointer is only used within hv-iommu-guest.c, but previously
has external linkage without a prior declaration. This causes
sparse to warn that the symbol was not declared.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610092126.TuSXnTYR-lkp@intel.com/
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/iommu/hyperv/hv-iommu-guest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/hv-iommu-guest.c b/drivers/iommu/hyperv/hv-iommu-guest.c
index fe06bd970621..876a22f21f1e 100644
--- a/drivers/iommu/hyperv/hv-iommu-guest.c
+++ b/drivers/iommu/hyperv/hv-iommu-guest.c
@@ -22,7 +22,7 @@
 #include "iommu.h"
 #include "../iommu-pages.h"
 
-struct hv_iommu_dev *hv_iommu_device;
+static struct hv_iommu_dev *hv_iommu_device;
 
 /*
  * Identity and blocking domains are static singletons: identity is a 1:1
-- 
2.52.0

