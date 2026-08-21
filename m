Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C0346EC66;
	Fri, 21 Aug 2026 13:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787318824; cv=none; b=JA8EBwDsZPZ5rfiwCcLqZosm1uQfQ9vahEUZAGEu7u7NUEF/tqfmC2V0M54rRSmtTt9T+6llcqG7Sjoykqca3fIz0rY7l4bYaRnrmKb+/REGhLNp/CTL5WQ0voWCvHkICCT6YQJF9MjILy/MihrAJ0dS5goPPUUyqW1grjHUYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787318824; c=relaxed/simple;
	bh=A6etM3S8LMw1uxwtzm2zR8I6yuUntWFrFMSvHs/fSos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JaRykc01WAtUG2zlr8IkF5Z5UcttAx/fE3fEzt75f+TcbxsRJyBhJwRnj/UO5WbBxD8mFzz2NhWnobNt3Tb1cqOzfj8FrxNSqKyhNHb03xklThqAFimQsGE6+4ybLaet0UDWhWnNTvYiKyYUvmW8s6ciFKCtmMA7BBvoZgK+4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HlJwCYjL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HlJwCYjL"
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id B4CD520B7128;
	Fri, 21 Aug 2026 06:26:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B4CD520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787318791;
	bh=CUDvFhs2gDAVJNdnuKeFcoGCW6ywUjdV3ujU9CDexI8=;
	h=From:To:Cc:Subject:Date:From;
	b=HlJwCYjLn8dworFwiOSmqJRMT12/+0Rvodb3nUud9EczPXFqRZ8A9QTPetsRegdIx
	 DOGSL+cYEzr2/EC/mmj6SyUi4UqNqPZjZoyB1ITndiktliVVy9s/oMM7BJGvXMHP//
	 L2/KCaumUrzFb9jIRMsL7d7ohhVJOZC7y5migfYU=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	x86@kernel.org
Cc: wei.liu@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	joro@8bytes.org,
	will@kernel.org,
	robin.murphy@arm.com,
	bhelgaas@google.com,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	arnd@arndb.de,
	jgg@ziepe.ca,
	mhklinux@outlook.com,
	jacob.pan@linux.microsoft.com,
	tgopinath@linux.microsoft.com,
	easwar.hariharan@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	baolu.lu@linux.intel.com,
	suravee.suthikulpanit@amd.com,
	vasant.hegde@amd.com
Subject: [PATCH v4 0/5] Hyper-V: Add para-virtualized IOMMU support for Linux guests
Date: Fri, 21 Aug 2026 21:26:49 +0800
Message-ID: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series introduces a para-virtualized IOMMU driver for
Linux guests running on Microsoft Hyper-V. The driver enables two
primary use cases:
  1) In-kernel DMA protection for devices assigned to the guest.
  2) Device assignment to guest user space (e.g., via VFIO).

The driver implements the following core functionality:
*   Hypercall-based Enumeration
    Unlike traditional ACPI-based discovery (e.g., DMAR/IVRS),
    this driver enumerates the Hyper-V IOMMU capabilities directly
    via hypercalls. This approach allows the guest to discover
    IOMMU presence and features without requiring specific virtual
    firmware extensions or modifications.

*   Domain Management
    The driver manages IOMMU domains through a new set of Hyper-V
    hypercall interfaces, handling domain allocation and attachment
    for endpoint devices.

*   Nested Translation Support
    This implementation leverages guest-managed stage-1 I/O page
    tables nested with host stage-2 translations. It is built
    upon the consolidated IOMMU page table framework (IOMMU_PT).
    This design eliminates the need for emulating map operations.
    Both Intel VT-d and AMD IOMMU platforms are supported.

*   IOTLB Invalidation
    IOTLB invalidation requests are marshaled and issued to the
    hypervisor through the same hypercall mechanism. Both domain-
    selective and page-selective flushes are supported.

Implementation Notes:
*   Platform Support
    The current implementation targets x86 platforms with Intel
    VT-d and AMD IOMMU hardware.

*   MSI Region Handling
    The standard x86 MSI interrupt range
    (0xfee00000 - 0xfeefffff) is reserved from normal IOVA mappings.
    Future updates may allow this configuration to be queried via
    hypercalls if new hardware platforms are to be supported.

*   Reserved Regions (RMRR)
    There is currently no requirement to support assigned devices with
    ACPI RMRR limitations. Consequently, this patch series does not
    specify or query reserved memory regions.

*   Guest Hibernation
    Guest hibernation and resume are not supported by this initial
    implementation. The current pvIOMMU interface does not define how
    Hyper-V device-domain objects and device attachments are restored.

Testing:
Validated with the following configurations:
- NVMe devices assigned to the guest on AMD platforms, tested
  with fio.
- Intel DSA devices assigned to the guest, tested with dmatest.
- dma_map_benchmark for DMA mapping performance evaluation.

Changelog:

v3[1] -> v4:
- Added Jacob Pan's Reviewed-by tag for patch 1/4/5.

- hyperv: hypercall interfaces:
  - Added the authoritative Hyper-V type names to imported definitions.
  - Added HV_STATUS_DEVICE_ALREADY_IN_DOMAIN and mapped it to -EEXIST.

- hv: logical device ID registry:
  - Made the registry independent of CONFIG_HYPERV_PVIOMMU.
  - Renamed the APIs to hv_pci_xxx_dev_id(),
  - Reworked initialization and error cleanup to propagate failures.
  - Return -EEXIST with a warning for duplicate registration.

- iommu/x86: architectural MSI reserved region:
  - Replaced the exported range constants with
    iommu_alloc_resv_x86_msi_region().

- iommu/hyperv: para-virtualized IOMMU:
  - Accepted HV_STATUS_DEVICE_ALREADY_IN_DOMAIN as a successful attach,
    and removed the blocking-domain-specific duplicate check.
  - Removed the redundant ATS disable from release_device(); ATS is
    disabled when attaching the release domain.

- iommu/hyperv: page-selective IOTLB flush:
  - Removed the redundant include of linux/hyperv.h.
  - Documented that the list flush also invalidates non-leaf page-walk
    caches before detached page-table pages are freed.

v2[2] -> v3:
- Added a separate patch defining the common x86 architectural MSI
  reserved range and converted the Intel, AMD, and Hyper-V IOMMU
  drivers to use it.

- hyperv: hypercall interfaces:
  - Used BIT_ULL() for 64-bit capability flags.
  - Matched the create-device-domain input layout to the 32-byte
    Hyper-V ABI.
  - Corrected the page-selective flush range layout to 6/6/52 bits.

- hv: logical device ID registry:
  - Replaced the linear list with an rhashtable for the sparse PCI
    domain number mapping.
  - Used RCU-protected lookup and deferred freeing on removal.
  - Simplified the registration and cleanup paths.

- iommu/hyperv: para-virtualized IOMMU:
  - Renamed the guest driver source to hv-iommu-guest.c.
  - Enabled ATS only after a device-domain attachment succeeds, and
    disabled ATS before attaching the blocking domain.
  - Removed the obsolete deferred-flush capability, unused geometry,
    and redundant device-private-data clearing.
  - Made the Hyper-V domain settings explicit at each caller instead
    of deriving them from the Linux domain type.
  - Added transactional create/configure domain handling with rollback.
  - Required only the base page size and masked the domain page-size
    bitmap with the Hyper-V-supported bitmap.
  - Silenced detection for unsupported hosts while retaining errors
    for actual hypercall and capability failures.
  - Clarified Kconfig support for assigned PCI devices and documented
    the lack of guest hibernation/resume support.

- iommu/hyperv: page-selective IOTLB flush:
  - Removed the inclusive-end overflow and kept the range calculation
    in byte addresses until the final page conversion.
  - Cleared both the fixed hypercall header and the range entry.
  - Warned on selective-flush failure before falling back to a
    full-domain flush.

v1[3] -> v2:
- Dropped the "move to subdirectory" patch; the directory now exists
  upstream.

- hv: logical device ID registry:
  - Moved the registry to hv_common.c so it can be shared, and derived
    the prefix via a shared helper instead of caching it in pci-hyperv's
    private struct.
  - Moved the lookup out of the irq-disabled region (PREEMPT_RT).

- iommu/hyperv: para-virtualized IOMMU:
  - Removed the unused detach_dev op.
  - Rejected a hypervisor not advertising x86 page sizes instead of
    masking and warning.
  - Statically initialized the identity and blocking domains.
  - Gave the blocking domain its own attach op, which returns the hypercall
    status and WARNs on failure.

- iommu/hyperv: page-selective IOTLB flush:
  - Used a single descriptor covering a slightly larger power-of-two
    range, instead of splitting the range into multiple descriptors.
  - Fixed the inclusive-end corner case in the flush range calculation.

RFC v1[4] -> v1[3]:
- Scoped platform support to x86 only (Intel VT-d and AMD IOMMU);
  initialization now uses x86_init.iommu.iommu_init
- Added page-selective IOTLB flush support
- Disable device ATS in hv_iommu_release_device()
- Addressed review comments from Michael Kelley:
  - Reversed dependency: pvIOMMU exports registration API for
    pci-hyperv to call, instead of pci-hyperv exporting
    hv_build_logical_dev_id()
  - Dropped separate output page allocation patch; hypercall input
    and output now share the same per-CPU page
  - Cleaned up Kconfig (removed PCI_HYPERV dependency, unnecessary
    selects)
  - Removed dev_list, per-domain spinlock, and syscore_ops
  - Removed forward declarations by reordering functions
  - Fixed typos, cleaned up Kconfig selects, improved pr_info
    messages, etc.

[1] v3:
https://lore.kernel.org/linux-hyperv/20260811155022.108148-1-zhangyu1@linux.microsoft.com/
[2] v2:
https://lore.kernel.org/linux-hyperv/20260702160518.311234-1-zhangyu1@linux.microsoft.com/
[3] v1:
https://lore.kernel.org/linux-hyperv/20260511162408.1180069-1-zhangyu1@linux.microsoft.com/
[4] RFC v1:
https://lore.kernel.org/linux-hyperv/20251209051128.76913-1-zhangyu1@linux.microsoft.com/


Wei Liu (1):
  hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

Yu Zhang (4):
  Drivers: hv: Add logical device ID registry for vPCI devices
  iommu/x86: Add architectural MSI reserved region helper
  iommu/hyperv: Add para-virtualized IOMMU support for Hyper-V guest
  iommu/hyperv: Add page-selective IOTLB flush support

 arch/x86/hyperv/hv_init.c             |   4 +
 arch/x86/include/asm/iommu.h          |  14 +
 arch/x86/include/asm/mshyperv.h       |   4 +
 drivers/hv/hv_common.c                | 113 +++++
 drivers/iommu/Kconfig                 |   1 +
 drivers/iommu/amd/iommu.c             |   6 +-
 drivers/iommu/hyperv/Kconfig          |  16 +
 drivers/iommu/hyperv/Makefile         |   1 +
 drivers/iommu/hyperv/hv-iommu-guest.c | 694 ++++++++++++++++++++++++++
 drivers/iommu/hyperv/iommu.h          |  49 ++
 drivers/iommu/intel/iommu.c           |   6 +-
 drivers/pci/controller/pci-hyperv.c   |  21 +-
 include/asm-generic/mshyperv.h        |   4 +
 include/hyperv/hvgdk_mini.h           |  10 +
 include/hyperv/hvhdk_mini.h           | 155 ++++++
 include/linux/hyperv.h                |   8 +
 16 files changed, 1091 insertions(+), 15 deletions(-)
 create mode 100644 drivers/iommu/hyperv/Kconfig
 create mode 100644 drivers/iommu/hyperv/hv-iommu-guest.c
 create mode 100644 drivers/iommu/hyperv/iommu.h

-- 
2.52.0
