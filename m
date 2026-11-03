Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674326;
	b=GGf7t2Gh0Lr+JPlk0JZpDp43vxTUDQaqXb+/zeUOUlocxng/2H9ndH4FNqb6QUXak56E
	 bi0zoAXsEQwDLmDsAJJKqOqsitJAdiJz32tA1vQwh47s/sVEKKLeVckDRnf7Hqq40tM6B
	 HGFgldsJhJSJGMp+ulNhDCH4j3AOzLEwEmodAMeqYBuV+BWKSaZaK8lqKLrLyV2Q1yGtq
	 4KDaYSDbqg0ggYC84kHAqhlYmHCy4Jiaix/+rdIPjR6VUDAKxjVw0xmQzzZ5SS+ugZrtQ
	 Bck6EU/s8/xiMpz3OawGCafpLNyw37Zy4MYUl9dNoKhidaGaaCQi4lcXwjYXYv39Z2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674326;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=LB7T7mSGj7gb2NVvd8ZxKJtsbTjQrh+GSEJ00NJnkNE=;
	b=vugMXe2zhVfYSMpdER8mnjHOfup0LmB5emWKq+47AXOKJ8rsMpUQ8r1ps1JM/OvQfBlf
	 cxebCbZIr5Pk/yfkf6fpRgoWfbIfIBa61e/tFnt+mqMWDFYYgAu06S3XbLWSMaK5rpdqZ
	 rQaCWjskg0Vh9clcEOKAkIOK6TixGtukDEXYtVM46P35hRrIduX12LPI/5WnciDgUQmH/
	 BwDxmmN6ON/GFHYbzaZ7zforKkhzemt/5NL5p0lYWuNuubVPUs/qI19cuew4wxOjdDcCP
	 6/nBSCX5Qeq4XKlqCzxEukah2ZYQylSBxjiMn1y8QtrIJqgzo/ySJ3ADXq/utcWXo+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="MKO4cDK/";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FED9606A326;
	Tue,  3 Nov 2026 02:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2FED9606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=MKO4cDK/
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 408FD20B7166;
	Mon,  2 Nov 2026 18:51:49 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 408FD20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793674309;
	bh=LB7T7mSGj7gb2NVvd8ZxKJtsbTjQrh+GSEJ00NJnkNE=;
	h=From:To:Cc:Subject:Date:From;
	b=MKO4cDK/yIH2vLLKmfvTwAGoD4Xfny4JkVP+YYiLrV0OxxxpYIzwrgDFi9ETrWFiA
	 AISttQrJCgVFazCcxLjzTFYRFbR4fNWDRCN3+W4/vmZghaDELE8lGy3JiafI6M6wUN
	 nAgGLdslM9vuCB8hT+GYZ6woJomni6vIQSeI1hbw=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-arch@vger.kernel.org
Cc: jgg@nvidia.com,
	jacob.pan@linux.microsoft.com,
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
Subject: [PATCH V3 0/5] Hyper-V: root VM iommu kernel only driver
Date: Mon,  2 Nov 2026 18:51:45 -0800
Message-ID: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series introduces hyperv root VM iommu kernel only driver. This
driver acts as liason between the hypervisor and iommu layer. Details are
both in the actual commits and in the comments in the file implementing it.

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

V2:
 - Add patch (0001) to allow gfp_flags to be passed to deposit pages
   function.
 - In last main patch:
     o remove hv_iommu_setup_skip to skip devices being managed
     o remove hv_special_domain()
     o Add comments around pgsize_bitmap and IOMMU capabilities.
     o Add to lookup tree before mapping iova in the map callback
     o Unmap iova before removing from the tree in the unmap callback

V3:
 - Rebase to rc1 tag 6628e7d4c6b2 which contains both pviommu and the
   deposit memory redesign patches.
 - Add a tiny patch to rename hv_iommu_init() to hv_pviommu_init(), and
   only call it for non-root.

Mukesh R (5):
  mshv: Add gfp flags to deposit memory logic
  PCI: hv: Export hv_build_devid_type_pci() and change return type
  mshv: Import data structs around device domains from hyperv headers
  iommu/hyperv: Only call pviommu init on non-root VMs
  x86/hyperv: Implement root partition IOMMU kernel only driver

 arch/x86/hyperv/hv_init.c             |   3 +-
 arch/x86/hyperv/irqdomain.c           |   9 +-
 arch/x86/include/asm/mshyperv.h       |   8 +-
 arch/x86/kernel/pci-dma.c             |   2 +
 drivers/hv/hv_proc.c                  |  20 +-
 drivers/iommu/hyperv/Kconfig          |  13 +
 drivers/iommu/hyperv/Makefile         |   1 +
 drivers/iommu/hyperv/hv-iommu-guest.c |   2 +-
 drivers/iommu/hyperv/hv-iommu-root.c  | 602 ++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h        |  17 +-
 include/hyperv/hvgdk_mini.h           |   4 +
 include/hyperv/hvhdk_mini.h           |  15 +
 include/linux/hyperv.h                |   6 +
 13 files changed, 683 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

