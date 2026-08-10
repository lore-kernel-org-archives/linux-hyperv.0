Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B323D88F2;
	Mon, 10 Aug 2026 12:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365961; cv=none; b=AWlHIJXakih/VPgufcSp0LrE2iZmgH7eKN8qCpVvfsMDecEvP3YZDbUAYx47/jWjKy6xRJC+U8jrp/EaPytpWKfdbWbUa2C7RiTeFty1G9ZY6J5qnO+BJluXIcDO1Z+zCeL1F8cHnq1r2PXKhnlbXVVgLEC09Js9BNNdPNjgMn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365961; c=relaxed/simple;
	bh=1wmsb2EcZk24CXY7ZaMZggkHygrkzjVCyyXRCjrDsnU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k32BJcjD5tJqdNlVwL8xA8GpuEsKufeez++aPDaWFqdJWtfHrBlRuRw78xNWi2eNSXl6gvBcVw/wa2yrmUQRr7mDvoBCtw3CkLBFQg8SxTzevtT0Ci/EQy3h4qz4CjeLrH0KGGPM8oTXGQv6tn/4xFZYTIH7LK9kjCLxlZWhhdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ux5LhZCK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ux5LhZCK"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id B24D920B7167;
	Mon, 10 Aug 2026 05:45:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B24D920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365936;
	bh=l+AbtzlJJ7siA+tKsnaihhguG3EwlbBqnYThJN0sxmY=;
	h=From:To:Cc:Subject:Date:From;
	b=Ux5LhZCKVffiR3758t1lpxDuY83kO+ec+mEf0nQ1eMpEyxAUABgsWI28s78MQtJTr
	 swUlfA3Mqis9Ox6y5HXRRkUpgYqUp8OIbRE3hRDifIexEjqlbH2v4iCYTPoNO+t8rB
	 puJ5s74GcV7DqcQDG7RtPBIWTfFQChuA+jQ4QFOA=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 00/13] mshv: add SEV-SNP support for MSHV root partitions
Date: Mon, 10 Aug 2026 12:44:54 +0000
Message-ID: <20260810124527.1409634-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds support for creating and managing AMD SEV-SNP
confidential virtual machines through the Microsoft Hypervisor root
partition driver.

The series adds the required Hyper-V ABI and MSHV UAPI definitions,
hypercall helpers, partition ioctls, capability discovery, processor
feature handling, memory teardown, and crash-dump support.

It also adds the x86 EFI HvLoader handoff required to boot Linux as an
MSHV root partition and corrects SynIC register ownership when the root
partition is itself running nested.

The patches are based on Linux v7.2-rc5.

Testing:

  - Built the complete 13-patch series on x86_64.
  - Verified the installed MSHV UAPI compiles from userspace.
  - Booted Linux as an MSHV root partition with SEV-SNP available.
  - Passed Cloud Hypervisor's common_cvm::test_focal_simple_launch.
  - Created and booted a four-vCPU SEV-SNP guest.
  - Verified SNP panic-time page unlock for kdump.

Functional testing on the development host used an additional local
nested-VMBus interrupt workaround required by that nested environment.
That workaround is not part of this series.

Changes since v1:

  - Make the isolated-import UAPI self-contained and translate it to
    the internal Hyper-V ABI type in the driver.
  - Preserve the asynchronous import rep count across CALL_PENDING
    completion and reject invalid zero/oversized progress.
  - Validate physical contiguity for large-page host-access requests,
    use kvcalloc() for userspace-sized page arrays, and restore IRQ state
    on defensive error paths.
  - Keep encrypted memory regions registered until ordered partition
    teardown and retry transient SNP state-destruction failures.
  - Make SEV-SNP capability queries informational so unsupported
    platforms retain ordinary MSHV functionality.
  - Fully initialize partition creation properties on all architectures,
    stabilize the extended create-partition userspace fetch, and fix the
    VERW feature-field typo.
  - Serialize panic-time memory-region traversal.
  - Allocate the augmented EFI command line from EFI loader memory,
    add command-line bounds checking, correctly append setup_data,
    compact legacy resource entries, preserve partially parsed range
    state, and release temporary EFI allocations.
  - Limit the EFI HvLoader implementation to x86_64; the unhooked ARM64
    implementation from v1 was removed.

Link: https://lore.kernel.org/linux-hyperv/20260807135134.303943-1-weh@linux.microsoft.com/

Wei Hu (4):
  hyperv: fix hv_input_get_system_property layout for SNP status
  mshv: unlock SNP pages on panic for crashdump collection
  hyperv: add MSHV Dom0 root-partition boot enablement (EFI HvLoader)
  mshv: set up own SynIC registers on a nested root partition

Wei Liu (9):
  mshv: add SEV-SNP UAPI definitions
  mshv: add SEV-SNP PSP request hypercall
  mshv: add SEV-SNP isolated page hypercalls
  mshv: wire SEV-SNP partition ioctls
  mshv: detect and report SEV-SNP support at init
  mshv: default to safe partition CPU features
  mshv: accept partial CPU feature banks
  mshv: define full processor and xsave feature masks
  mshv: unmap SNP memory before state teardown

 MAINTAINERS                                   |   2 +
 arch/x86/hyperv/hv_init.c                     |   3 +
 arch/x86/include/asm/mshyperv.h               |   1 +
 arch/x86/include/uapi/asm/setup_data.h        |   3 +-
 arch/x86/kernel/cpu/mshyperv.c                |  81 +-
 drivers/firmware/efi/libstub/Makefile         |   5 +-
 .../firmware/efi/libstub/efi-mshv-common.c    | 148 ++++
 drivers/firmware/efi/libstub/efi-mshv.h       | 109 +++
 drivers/firmware/efi/libstub/x86-efi-mshv.c   | 217 ++++++
 drivers/firmware/efi/libstub/x86-stub.c       |  18 +-
 drivers/hv/hv_common.c                        |  82 ++
 drivers/hv/mshv_regions.c                     |   2 +-
 drivers/hv/mshv_root.h                        |  28 +
 drivers/hv/mshv_root_hv_call.c                | 180 ++++-
 drivers/hv/mshv_root_main.c                   | 729 +++++++++++++++++-
 drivers/hv/mshv_synic.c                       |  16 +-
 include/asm-generic/mshyperv.h                |   7 +
 include/hyperv/hvgdk_mini.h                   |  31 +
 include/hyperv/hvhdk.h                        | 124 ++-
 include/hyperv/hvhdk_mini.h                   |  56 +-
 include/linux/efi.h                           |   1 +
 include/uapi/linux/mshv.h                     | 104 ++-
 22 files changed, 1914 insertions(+), 33 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/efi-mshv-common.c
 create mode 100644 drivers/firmware/efi/libstub/efi-mshv.h
 create mode 100644 drivers/firmware/efi/libstub/x86-efi-mshv.c


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.43.0
