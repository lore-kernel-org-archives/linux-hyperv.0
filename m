Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10E8D4BB26D;
	Thu, 15 Oct 2026 08:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792052638; cv=none; b=WGTKxODYm2lSBd8w/ck01WGMMPf6RtG+TMNJvKkMVdsXI/c+8eJOSIKTGExMiMdnzly+wddlMm9V6EcFrq+K0ZBhL2cNtIE8MoH4g8ifQvy1QyjKjsqqquqekYkLPV6liOzgyh1ndXZR7Xo4DvU02LCrZwqkltXVAUAKgWf7SL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792052638; c=relaxed/simple;
	bh=7P/XDM0Pc3hLL66AC0Zh/8OHDk/x5QbE3znFGAvBqAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lPUcc3yJ/FJz4tuXqfwIQs0+f5EBxw79dHOma+jUt4tGzvKhI/YrzK1alWDxaCwd1E9SJsoR4kP55CzCCjaUFKnvS4m6eZ/CcciCysbz7FEXDKf11NsUNxZSQt/rbGga3EFtXK8w+Vng9jOndAkeAtsSPdZYoyyuPuGcIX/hATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Cdy9YaQs; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Cdy9YaQs"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id AB50D20B7168;
	Thu, 15 Oct 2026 01:23:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB50D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792052632;
	bh=LD/yH6+zsnLB+bR1bqGlx1FhwoUpdK4wYX+T7U4uJNg=;
	h=From:To:Cc:Subject:Date:From;
	b=Cdy9YaQsQiK9Z+lHjgBU9vdkhFMuARAtcbegJOzunKPSbmPjDLkGq7gU+wZ21+oE4
	 rmvNTVnCC2CDVtashJqaFMaP5D6fhYk/kAS3eB6KFMWYfhbNHB/c5a+mSeNEYhwuV8
	 eR+VuQi1HJyBiuPZ//eu3UnYf30lZUo3WfqPH23Q=
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
Subject: [PATCH 0/2] iommu/hyperv: Fix guest IOMMU build issues
Date: Thu, 15 Oct 2026 16:23:49 +0800
Message-ID: <20261015082351.184252-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series address two issues reported by kernel test robot in the
recently applied Hyper-V guest IOMMU driver.
                                                                                                                                                        
The first one adds the missing PCI dependency to prevent a link failure
when CONFIG_PCI is disabled. And the second makes hv_iommu_device static
to address a sparse warning.

The patches are based on the hyper-v branch of the IOMMU tree.

Yu Zhang (2):
  iommu/hyperv: Add missing PCI dependency for the guest IOMMU driver
  iommu/hyperv: Make hv_iommu_device static

 drivers/iommu/hyperv/Kconfig          | 2 +-
 drivers/iommu/hyperv/hv-iommu-guest.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

-- 
2.52.0

