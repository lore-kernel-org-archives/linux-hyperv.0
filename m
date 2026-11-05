Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844080;
	b=nyDWHpP88ITORsVbHlYf+68cz8qAswZWVSGh+PYQabkMloH7+QWZSVkhJrQeOVQVw9aj
	 E2mhNrmocnD0xVt+nTKptxV2JTjAJDmyR+XDnAF8dqN6N/BzafRrsDJfSiec9p/5YNr9M
	 GifviVo1uTqgcf4gliXtqJU0N+3JWKTveoTtT/T9eZltelYvI2WgnxkvwRBHbqQ/TLjeI
	 smOIrJSuzXF2WMmSeBgeZ71XhHChGB+ALt/Sez6EwuxKEVHJY6vKAUj9+WnZLgmyRDp5h
	 vihbv8X4lV/UISWHmJ955jI1THI5E4BsDnEfwlbzR0udABYei49QzWguJTYHpBusv9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844080;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=kKEqqjcrmstgVTN3I27vdrZLBL+vIo5DTjjeZQ8FHDQ=;
	b=g8EyqSpUcQE5xLCz3z/iKYTeutV2SNaNnJKUH3LONvnfKLUrXoPjRS/U7Qn2GTtN8ht7
	 YvQtXpQ+fPzvEaWc+L4BsUh0n8ShS61ceL22Fv8nS8NtrHfohBnXKevXzmuQya+ZLKVyb
	 Ns1Z9JXA1lsBPyENdVZgCMsH4z2hFG1d2Rt8shbtNVZUOQODpDAG8n0osqt6tahMjPFB4
	 oGWP5cCTbBuXCrzInhCPYFO3CYLQnQ4983ggVpmyVnwjPYWPNHSoMY0q/4xfv1ojV3Y+X
	 3wKH9uRImZXIet5VUShHaOhCEBfyw4ADzvjIpGha2QC09l3R9Jn1w53gugcICTosRzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DrI0nK8G;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6327B6082BD9;
	Thu,  5 Nov 2026 02:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6327B6082BD9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=DrI0nK8G
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id A915420B7166;
	Wed,  4 Nov 2026 18:01:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A915420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793844064;
	bh=kKEqqjcrmstgVTN3I27vdrZLBL+vIo5DTjjeZQ8FHDQ=;
	h=From:To:Cc:Subject:Date:From;
	b=DrI0nK8GYcLzIyoUEfzhS6FHnR+unKmXaQEMrhpcIC9DVTC2FilIBobecVq7kEbyR
	 UFRELZuu0YZvihkhFNWDqHGY/ReyLuyHtWvtOpGBunPmHiYVuKd9ZEoXm5MSF6Mkum
	 asdTyHDfY9VfDJPB04CXyZNvV0TUNO/7sn+y9fKk=
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
Subject: [PATCH V4 0/5] Hyper-V: root VM iommu kernel only driver
Date: Wed,  4 Nov 2026 18:01:01 -0800
Message-ID: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
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

V4:
 - Use gfp flag in add tree function instead of GFP_KERNEL.
 - Check for HV_STATUS_DEVICE_ALREADY_IN_DOMAIN in attach device.
 - Don't call delete tree if unmap hypercall failed.
 - Don't print error if map device pages hypercall failed with enomem.
 - Minor comments fixups.

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
 drivers/iommu/hyperv/hv-iommu-root.c  | 613 ++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h        |  17 +-
 include/hyperv/hvgdk_mini.h           |   4 +
 include/hyperv/hvhdk_mini.h           |  15 +
 include/linux/hyperv.h                |   6 +
 13 files changed, 694 insertions(+), 19 deletions(-)
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

