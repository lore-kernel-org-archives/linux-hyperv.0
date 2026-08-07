Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF63330BF6B;
	Fri,  7 Aug 2026 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110713; cv=none; b=QLcjYTxHvbqYS1LER/Xyt/Nr1gThCsLOtO8FOU9QW9M8aKZjobwW2XFSxwG7J/59XDD6Xnc6u2SlvFeXO3XcdcFVJyevVakmiuVlGZt5S4wX0dQLt5EJb5LIw3EmARQnKkIsUeKS6i1eS3Q7+cnet8t846z9HZrPIIprZwQA/8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110713; c=relaxed/simple;
	bh=LdKccxaJO0TnDlZca2fnnqlK8HkspsOpzuhWWU4HCzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FY+Bk6g2bqBSw7LhDz/dU4trCNFQeLASEQ6rtj4NN31a4izQs/Nmpy8ShEPT2f38QAvrk0X+zuGyF5fErULSMxA0u+m+rSSAL5N4QoiJDLDD6M11TpGlMPh1i+DPwA7IFoaV9kPD4Pb8z0nhjmFjy+zNJC7xNOcCqHjuSfDdRSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UuqmQH8f; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UuqmQH8f"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 48C4620B710C;
	Fri,  7 Aug 2026 06:51:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 48C4620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110680;
	bh=HsqfztqaAMsUD7h8v/EZKp3GdwkZmPtIRAc+r9QmVSg=;
	h=From:To:Cc:Subject:Date:From;
	b=UuqmQH8faKb7gMAqUwu1a+iaPZM9WfFNbk9pK1h5386okwpA06S4ZGxcX5SGfNo8v
	 GUp5ozMixJ0D3Y2S7AsY8D36E7illXxiZgBgrcrTVn/uiQl61srh+YdQKpmJXTkZxm
	 dwie8Wafnocs7HbBgnxZ6GAg2Z8kR2Ei81M6FIgk=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v1 00/13] mshv: add SEV-SNP support for MSHV root partitions
Date: Fri,  7 Aug 2026 13:51:06 +0000
Message-ID: <20260807135134.303943-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Hu <weh@microsoft.com>

This series adds support for creating and managing AMD SEV-SNP
confidential virtual machines through the Microsoft Hypervisor root
partition driver.

The series adds the required Hyper-V ABI and MSHV UAPI definitions,
hypercall helpers, partition ioctls, capability discovery, processor
feature handling, memory teardown, and crash-dump support.

It also adds the EFI HvLoader handoff required to boot Linux as an MSHV
root partition and corrects SynIC register ownership when the root
partition is itself running nested.

The patches are based on Linux v7.2-rc5.

Testing:

  - Built the complete 13-patch series on x86_64.
  - Booted Linux as an MSHV root partition with SEV-SNP available.
  - Created and booted single-vCPU and four-vCPU SEV-SNP guests with
    Cloud Hypervisor.
  - Verified SNP memory teardown and panic-time page unlock for kdump.

Functional testing on the development host used an additional local
nested-VMBus interrupt workaround required by that nested environment.
That workaround is not part of this series.

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
 arch/x86/kernel/cpu/mshyperv.c                |  80 ++-
 drivers/firmware/efi/libstub/Makefile         |   7 +
 drivers/firmware/efi/libstub/arm64-efi-mshv.c |  41 ++
 .../firmware/efi/libstub/efi-mshv-common.c    | 136 ++++
 drivers/firmware/efi/libstub/efi-mshv.h       | 118 +++
 drivers/firmware/efi/libstub/x86-efi-mshv.c   | 202 ++++++
 drivers/firmware/efi/libstub/x86-stub.c       |  18 +-
 drivers/hv/hv_common.c                        |  82 +++
 drivers/hv/mshv_regions.c                     |   2 +-
 drivers/hv/mshv_root.h                        |  26 +
 drivers/hv/mshv_root_hv_call.c                | 171 +++++
 drivers/hv/mshv_root_main.c                   | 679 +++++++++++++++++-
 drivers/hv/mshv_synic.c                       |  16 +-
 include/asm-generic/mshyperv.h                |   7 +
 include/hyperv/hvgdk_mini.h                   |  31 +
 include/hyperv/hvhdk.h                        | 124 +++-
 include/hyperv/hvhdk_mini.h                   |  56 +-
 include/linux/efi.h                           |   1 +
 include/uapi/linux/mshv.h                     |  58 +-
 23 files changed, 1834 insertions(+), 30 deletions(-)
 create mode 100644 drivers/firmware/efi/libstub/arm64-efi-mshv.c
 create mode 100644 drivers/firmware/efi/libstub/efi-mshv-common.c
 create mode 100644 drivers/firmware/efi/libstub/efi-mshv.h
 create mode 100644 drivers/firmware/efi/libstub/x86-efi-mshv.c


base-commit: f5098b6bae761e346ebcd9da7f95622c04733cff
-- 
2.43.0
