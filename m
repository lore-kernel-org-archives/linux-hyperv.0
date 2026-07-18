Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227FA1A9FBD;
	Sat, 18 Jul 2026 02:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341206; cv=none; b=gphbyNQxZPBxonxz4hZyKXYDUzW+m9ElTQ05JpZdxt20h12UYL/BPahawuP2tnwFS183g2g8uM91fSA6Wb0uR2ZGawlBYUkYpNqy3EcYI1Dd5I5lfLOMRdPQ08EAevlJpoBaJC/fXNihcrlGU/mCBJZDQFqKB8jIisI+IXYT/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341206; c=relaxed/simple;
	bh=Mmx0CBcgIJaT5eFEHHi/ufL2NxYrTmdRYBBb36i7vv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SbWsmqpnilNlqhdW93Tzosr+7VS3G9xie0PmYZOirwDvhy6o0wwY5E4xn5zN61NJjkwdivvMY5Wc6OFmj5X8pnHs2bFqT6SNyy+I5fvgDYBEWszu8/1MwcO57mDCDK/0CcP0+Tl/P5YpO+cuK6jep7wV5SLylPA23ewcmLJWT1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Bo1iPmoz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Bo1iPmoz"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2663420B7169;
	Fri, 17 Jul 2026 19:19:53 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2663420B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784341194;
	bh=POVLPRyxFM5PtT/8dZGCKuA6gfIpp8GPB2GIOmG2iTQ=;
	h=From:To:Cc:Subject:Date:From;
	b=Bo1iPmozPGKoiXdo+IWL1xwa3Ksd2jTaN1tHEMjkKZwyNe7eMokMjpijJ5e/F6WWb
	 f+NmdUQd/GgxuABUZreBdFyrNlARbT8XyeDNeUCwLOrsG4sktXFw7VceF8mjaP01zl
	 PosWrR1UYrrboU5d6Xuqd35qYqMaKOskzXNaP5V0=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH V4 0/9] PCI passthru on Hyper-V 
Date: Fri, 17 Jul 2026 19:19:40 -0700
Message-ID: <20260718021949.926306-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement passthru of PCI devices to unprivileged virtual machines
(VMs) when Linux is running as a privileged VM on Microsoft Hyper-V
hypervisor. This support is made to fit within the workings of VFIO
framework. This supports both full device passthru and SR-IOV based VFs.

At a high level, the hypervisor supports traditional paging iommu domains
that use explicit map and unmap hypercalls for mapping and unmapping
guest RAM into the iommu subsystem. Hyper-V also has a concept of direct
attach devices (DDA) whereby the iommu subsystem simply uses the guest
HW page table (ept/npt/..). This series adds support for the former.

This series rebased to: a4ffc59238be (origin/hyperv-next)

Testing:
 o Most testing done on hyperv-next:a4ffc59238be using Cloud Hypervisor (51).
 o All tests involved passthru of devices using MSIx.
 o Tested on Baremetal dom0/root: 
       test 1: Mellanox ConnectX-6 Lx passthru
       test 2: NVIDIA Tesla Tesla T4 GPU.
       test 3: Both of above simultaneous passthru
 o VF: Mellanox ConnectX-6 Lx passthru 

This series strives to establish a base line. Some pending work items:
 o arm64 : some delta to make this work on arm64 (in progress).
 o Qemu and OpenVMM support (in progress).
 o device sleep/wakeup.
 o More stress testing with high end GPUs

Changes in V4:
 o Completely remove direct device attach (DDA) support 
 o Remove first two patches that were submitted separately and are
   already merged.
 o Change hv_iommu_unmap_pages() to unmap in batches of HV_REP_COUNT_MAX,
   otherwise if a physical range happens to be larger than that, there would 
   be errors from the hypercall.
 o Use large page (2M) flag for mmio mappings as internal testing found
   that to speed things up greatly.
 o rename hv_no_movbl_pgs to hv_memreg in last patch.

Changes in V3:
 o patch #8: fix compiler issues incase of !CONFIG_HYPERV. Also, do forward
   declaration of struct pci_dev instead of including pci.h.
 o patch #9: minor changes to comments. Pass hv_domain instead of 
   iommu_domain to hv_iommu_detach_dev() since that's what it needs. Set
   device private to null if attach fails. Clam down number of PFNs passed
   to hv_iommu_map_pgs().

Changes in V2:
 o rebase to 5170a82e8921
 o minor fixes for arm64 build
 o drop patch 03: "x86/hyperv: add insufficient memory support in irqdomain.c" 
     as it that path is no longer used
 o drop patch 08: "PCI: hv: rename hv_compose_msi_msg .. " and do it separately
   outside this series.
 o minor updates to commit messages

Changes in V1:
 o patch 1: Don't tie hyperv-irq.c to CONFIG_HYPERV_IOMMU.
 o patch 4: Redesigned to address security vulnerability found by copilot 
            with passing tgid as a parameter.  Also, do tgid setting right 
            after setting pt_id.
 o patch 5: Remove unused type parameter from mshv_device_ops.device_create
 o patch 7: mshv_partition_ioctl_create_device cleanup on copy_to_user.
 o patch 10: Add export of hv_build_devid_type_pci here to get rid of 
             patch 11.
 o patch 12: Move functions to build device ids from patch 11 here for
             the benefit of arm64. Rename file to: hyperv-iommu-root.c.
 o patch 13: removed to be made part of interrupt part II of this support.
 o patch 14: get rid of fast path to reduce review noise.
 o New (last) patch to pin ram regions if device passthru to a VM.

Thanks,
-Mukesh

Mukesh R (9):
  mshv: Provide a way to get partition ID if running in a VMM process
  mshv: Add declarations and definitions for VFIO-MSHV bridge device
  mshv: Introduce basic mshv bridge device for VFIO to build upon
  mshv: Add ioctl support for MSHV-VFIO bridge device
  mshv: Import data structs around device passthru from hyperv headers
  PCI: hv: Export hv_build_devid_type_pci() and change return type
  x86/hyperv: Implement Hyper-V virtual IOMMU
  mshv: Populate mmio mappings for PCI passthru
  mshv: Disable movable regions upfront if device passthru

 arch/x86/hyperv/irqdomain.c          |   9 +-
 arch/x86/include/asm/mshyperv.h      |   6 +
 arch/x86/kernel/pci-dma.c            |   2 +
 drivers/hv/Makefile                  |   3 +-
 drivers/hv/mshv_root.h               |  24 +-
 drivers/hv/mshv_root_hv_call.c       | 101 +++-
 drivers/hv/mshv_root_main.c          | 259 +++++++++-
 drivers/hv/mshv_vfio.c               | 211 ++++++++
 drivers/iommu/Kconfig                |   1 +
 drivers/iommu/hyperv/Kconfig         |  15 +
 drivers/iommu/hyperv/Makefile        |   1 +
 drivers/iommu/hyperv/hv-iommu-root.c | 704 +++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h       |   8 +
 include/hyperv/hvgdk_mini.h          |   8 +
 include/hyperv/hvhdk_mini.h          |  67 +++
 include/linux/hyperv.h               |   6 +
 include/uapi/linux/mshv.h            |  31 ++
 17 files changed, 1408 insertions(+), 48 deletions(-)
 create mode 100644 drivers/hv/mshv_vfio.c
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/hv-iommu-root.c

-- 
2.51.2.vfs.0.1

