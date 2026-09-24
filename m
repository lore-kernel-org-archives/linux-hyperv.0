Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946C039EF27;
	Thu, 24 Sep 2026 02:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215379; cv=none; b=on30EgOZN5ci2TSoXA+jF949GeuCtVf/XAya3ZUxt93IusIqYQbeh063eeqPav5H6Rt34XkwUs5F/hYPQQzyYw1iqGFttN3paGm/2xligmsC4tFmglS3RPomGVJ4S1Q7GxxgJT3iTtb2XojP5dYmUbqtPZJ8fOk5lQFVrBIb6Y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215379; c=relaxed/simple;
	bh=G26jFl3qf1F6lFuNE3v/08zg4zvjxBOGCLTqu4wZQAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=csFojg3XbOChoIkZfwQqlpWP/xE5+/Sx0Hkv1eB/w8qUIyj+GCSp6fAd//jNCADElAlkfO4klYz9NdPJoV55Hza/PFo+hqYUV1xdHtC0qDCcEnhyWy0T/3Vn2I3N05IbX0+KW3uThhcau//S9UPOMBKEVNwPTYU3U0KWG7WF/7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Hb63onH3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Hb63onH3"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6ECEB20B7167;
	Wed, 23 Sep 2026 19:02:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6ECEB20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790215329;
	bh=jpg6hnv1I1BQZIEQIbPxFGR8d5ZrjHb40/ATbELpoLw=;
	h=From:To:Cc:Subject:Date:From;
	b=Hb63onH3ellvYMCw1VS94xJTzYnFCU5BnhiaRvETnMJcXfxp5CJsvpiJ3U9YwxJsv
	 9ORjtb47tilsfPB8afCRqbWqoNQ6R0711NsZ7vt4jJ/zcUIdsLW/oORceBLCOSfy9d
	 z2LFvEjGpwLyRh1Vn7v1HO5bBt/aSuc6tNv4Cg7I=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	arnd@arndb.de,
	mrathor@linux.microsoft.com
Subject: [PATCH V1 0/3] Hyper-V: root VM iommu kernel only driver
Date: Wed, 23 Sep 2026 19:02:18 -0700
Message-ID: <20260924020221.128762-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series introduces hyperv root VM iommu kernel only driver. This
driver acts as liason between the hypervisor and iommu layer. Details are
both in the actual commit and in the comments in the file implementing it.

Thanks,
-Mukesh

V0: based on upstream hyperv-next commit be0cfab740e5

V1:
 - change order of lookup tree deletions to appease all AI agents,
   carving out hv_iommu_hyp_unmap_pages() from hv_iommu_unmap_pages().
 - change unique_id to ida subsystem management so we never ever run
   out of domain ids.
 - change hv_max_iova_width to hv_iommu_max_iova and generate proper
   mask.
 - some other minor changes.

Mukesh R (3):
  PCI: hv: Export hv_build_devid_type_pci() and change return type
  mshv: Import data structs around device domains from hyperv headers
  x86/hyperv: Implement root VM IOMMU kernel only driver

 arch/x86/hyperv/irqdomain.c          |   9 +-
 arch/x86/include/asm/mshyperv.h      |   6 +
 arch/x86/kernel/pci-dma.c            |   2 +
 drivers/iommu/Kconfig                |   1 +
 drivers/iommu/hyperv/Kconfig         |  15 +
 drivers/iommu/hyperv/Makefile        |   1 +
 drivers/iommu/hyperv/hv-iommu-root.c | 656 +++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h       |   3 +
 include/hyperv/hvgdk_mini.h          |   9 +
 include/hyperv/hvhdk_mini.h          |  87 ++++
 include/linux/hyperv.h               |   6 +
 11 files changed, 791 insertions(+), 4 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

