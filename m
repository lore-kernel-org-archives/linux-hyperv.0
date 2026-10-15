Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311A04BD7AF;
	Thu, 15 Oct 2026 08:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052641; cv=none; b=E2BQinrokiPlEzgNS06dFvvRd1eZvjS8rCUQQvCqHjueff3b7b9kcPlSXl2RCBSazLv6TZiGinSpzAXJTfliLJECBfDa0smDDypfB3OnW1oM2ICHSYY4wl8i4mUq+HVAl+a0WtjbQmYbvCe3XnKTm1U4SnvTJ1NZEgUNzTCJzGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052641; c=relaxed/simple;
	bh=PCl3plfkN/X3eF9LBkYjDlF4scvLaIyebO1i+imIDZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XsR11LaSy6j+A+KTaBlxB1FIPj3od3N0RpQ0LMpV2ZPEZTPCaH5DpqgVkNPtx3zy6pP2L+fMkAxKlRmIv9UZLcYCq0mUx/bq+1329bxMOXG9CImjDDF0WV8hgfKyRsp9lwZDTzfsHOePqbN6z5Nsz1+KBM7/7x7V0YVQimEayuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PdBKANYk; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PdBKANYk"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id E5B3F20B7166;
	Thu, 15 Oct 2026 01:23:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E5B3F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792052635;
	bh=AcrsTHCeB/WFR2tGTjVe3hbIgVLifK/NBqZXLpeoa6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PdBKANYkTiQmN8sflRxfTkmU/Ry113KNSoJ9yFqdHikS5IbHtsDLh6c2f+6OxsejN
	 9rGHDe78a5xswyJGmUGTTlWEqpdhnJynrX2TDyatzxjvchi163aY0kh8rXBn5Qk6+N
	 9ACmf77R+flUJqto9HZVKVurOoGyFC9+dlWtC5mc=
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
Subject: [PATCH 1/2] iommu/hyperv: Add missing PCI dependency for the guest IOMMU driver
Date: Thu, 15 Oct 2026 16:23:50 +0800
Message-ID: <20261015082351.184252-2-zhangyu1@linux.microsoft.com>
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

Make HYPERV_PVIOMMU depend on PCI, to fix the possible link failure
of pci_request_acs(), if HYPERV_PVIOMMU is enabled yet with PCI disabled. 
Such configuration shall be prevented.

Fixes: 2690d4156b51 ("iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202610110511.Nk1sZ8SG-lkp@intel.com/
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
 drivers/iommu/hyperv/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/hyperv/Kconfig b/drivers/iommu/hyperv/Kconfig
index fe24ed65b6a7..f2f993f647c3 100644
--- a/drivers/iommu/hyperv/Kconfig
+++ b/drivers/iommu/hyperv/Kconfig
@@ -2,7 +2,7 @@
 # Hyper-V para-virtualized IOMMU driver for Linux guests
 config HYPERV_PVIOMMU
 	bool "Microsoft Hyper-V para-virtualized IOMMU driver for Linux guests"
-	depends on X86_64 && HYPERV
+	depends on X86_64 && HYPERV && PCI
 	select IOMMU_DMA
 	select GENERIC_PT
 	select IOMMU_PT
-- 
2.52.0

