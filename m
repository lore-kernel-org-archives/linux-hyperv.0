Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46D0C3C0625;
	Tue, 29 Sep 2026 22:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721397; cv=none; b=p0arIUKEPMAehBAArVpCtlsPbLjtH3lDRxl4+bMLoJYM/4TAyvb/GSQrnTjD8cm9AuEGhrXlqDpj8do0zQvgETu5xRkWEKnwXviF7QsdkNzxSOTB5ZQoiiPLafIoT7HiqW57qHTUtFsFbAmlajPz6qpxdRTOx+EUwCB8snM2VZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721397; c=relaxed/simple;
	bh=UVS1dhIiugzdHIfZyOqPjpdsOL1nw+37sSQf0bFl/xI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hluzj23aDQjHq5wSeqCDbOsJOausqkQwcEw381HhZ3Wdokrlq4y4zycUzZof8BG68wGHnZ6okTJmhl5TMnqbxRAHFA1Vq4FA6JbQV3qWTNhfyNTtsDINXj00TC2b4KuoemDaY42HV2Q0iI3NhJBmcqBd87BC3JrDwQsw1g92PZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fMwIHTuV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fMwIHTuV"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id DC18F20B7166;
	Tue, 29 Sep 2026 15:35:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC18F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790721340;
	bh=JY/+V85NIX2IkP25YQOyeM+/zuoWIOPcVjOSPlujFWQ=;
	h=From:To:Cc:Subject:Date:From;
	b=fMwIHTuVRg/+VI0s2ihT3wiaO3iKUQSnLtjlnl8EYW5+zHH+VpJ5hVkYtSMFMZgfj
	 jUVZKwN8OioiVYeTCbpkcAjDwJQa4YC70wsfbjxHNJh0lUV9w+B7umFnzGBDSbrLRw
	 Z6mNtAU/Wnd8JP/8dANQ+eHWlHhDZFsUlbOO9aww=
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
Subject: [PATCH V2 0/4] Hyper-V: root VM iommu kernel only driver
Date: Tue, 29 Sep 2026 15:36:18 -0700
Message-ID: <20260929223622.778617-1-mrathor@linux.microsoft.com>
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

V2:
 - Add patch (0001) to allow gfp_flags to be passed to deposit pages
   function.
 - In last main patch:
     o remove hv_iommu_setup_skip to skip devices being managed
     o remove hv_special_domain()
     o Add comments around pgsize_bitmap and IOMMU capabilities.
     o Add to lookup tree before mapping iova in the map callback
     o Unmap iova before removing from the tree in the unmap callback

Mukesh R (4):
  mshv: Add gfp_flags parameter to hv_call_deposit_pages()
  PCI: hv: Export hv_build_devid_type_pci() and change return type
  mshv: Import data structs around device domains from hyperv headers
  x86/hyperv: Implement Hyper-V virtual IOMMU

 arch/x86/hyperv/irqdomain.c          |   9 +-
 arch/x86/include/asm/mshyperv.h      |   6 +
 arch/x86/kernel/pci-dma.c            |   2 +
 drivers/hv/hv_proc.c                 |  14 +-
 drivers/hv/mshv_root_hv_call.c       |   6 +-
 drivers/iommu/Kconfig                |   1 +
 drivers/iommu/hyperv/Kconfig         |  15 +
 drivers/iommu/hyperv/Makefile        |   1 +
 drivers/iommu/hyperv/hv-iommu-root.c | 611 +++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h       |   9 +-
 include/hyperv/hvgdk_mini.h          |   9 +
 include/hyperv/hvhdk_mini.h          |  90 ++++
 include/linux/hyperv.h               |   6 +
 13 files changed, 764 insertions(+), 15 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

