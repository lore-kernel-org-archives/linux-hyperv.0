Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5091F3D969E;
	Mon, 31 Aug 2026 11:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175637; cv=none; b=qtdFnU6SNr3VZV2i0LFvsGuatUL1GYFXHT7hekSw1kdLKXJh8EbcMEB3evpGJc7wngQNQWgK1xzV3B6sc2sA9iD9J1+D4MsEJxzUHxRTZuxR2ovYUHOTHaM1p5Ro0+KdnklbmAWUcuUtHy9GRI4oo+BejTZLV91c1vQAZXXgkWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175637; c=relaxed/simple;
	bh=CXiKp3cZ09jf1dpkPnEk57IpxPBqd1hs15x1awALGus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ht5QHbsudkdUdz/S44HBnsx0TwzY8Puy+Wp5IbVTt3Pfnw8h6iaDtaRTfj4hxb1WtIkWBD+PFkUbztvaubACokCzEzJiSlp31CzJmLzkVsEVr2fgfw8qfMsJIdQu77zv6vzH7nw1F4FFF9cWaxab6DozrVsRMTyBY8fTdhlYKWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cZDFbiAX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cZDFbiAX"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C2DE620B710C;
	Mon, 31 Aug 2026 04:26:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C2DE620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788175600;
	bh=gocMXCyvjmLDOe0RLsMl08gxUCa79z897Mw4qKKccg4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cZDFbiAXNuX+iir245Ba0sIC9twbHkiK8TEaizhQQoIIXCGCFV8uHjrrrNdrzEcRf
	 dKKQ6B0oWJ/g65yc6xXrx5fycg+ywu8JGjHCT6CRXOaq6FxmaEiu1au9tfMxTG4Tt5
	 QEiyPBstBNx2+3Xd//yQ7kuwhlLgSrU050KiuMbI=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v4 0/9] mshv: add SEV-SNP support for MSHV root partitions
Date: Mon, 31 Aug 2026 11:26:38 +0000
Message-ID: <20260831112704.2851147-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825040505.826600-1-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
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

The series adds fixed-size MSHV UAPI definitions, the required Microsoft
Hypervisor ABI definitions and hypercall helpers, partition ioctls,
capability discovery, processor-feature handling, ordered encrypted-memory
teardown, and nested-root SynIC handling.

Two prerequisite fixes now lead the series. The first makes memory-region
unmap ownership explicit and retains mappings, pinned pages, the partition,
and the module whenever checked hypervisor unmap cannot prove cleanup. The
second publishes and withdraws per-CPU SynIC pointers so interrupt readers
cannot observe mappings after initialization failure or CPU teardown.

The patches are based on the current hyperv-next branch.

Testing:

  - Built all four affected x86 MSHV objects at every commit.
  - Built the complete x86_64 kernel and the affected objects with W=1.
  - Ran scripts/checkpatch.pl --strict on every patch with zero findings.
  - Verified installed UAPI layouts in 64-bit and 32-bit userspace builds.
  - Generated rust-vmm MSHV bindings from the installed kernel headers.
  - Built the affected ARM64 objects with W=1 and no warnings.
  - Passed Cloud Hypervisor's common_cvm::test_focal_simple_launch.
  - Booted a four-vCPU SEV-SNP guest to login.

The development host needs two additional local runtime patches to boot
as a nested MSHV root partition: EFI HvLoader root-partition boot
enablement and the non-upstreamable nested-VMBus interrupt-vector
workaround. Neither patch is part of this series.

Changes since v3:

  - Add checked memory-region unmap ownership as prerequisite patch 1. Keep
    pages pinned and quarantine uncertain setup or teardown instead of
    freeing memory that may remain child-accessible.
  - Add SynIC pointer publication/withdrawal cleanup as prerequisite
    patch 2.
  - Rate-limit guest-triggerable PSP and isolated-page hypercall errors.
  - Publish and consume driver readiness with release/acquire ordering.
  - Make both array ioctls _IOWR interfaces with an MBZ input/completed
    output
    field, exact resumable progress, and defined no-rollback semantics.
  - Preserve the exact asynchronous completion result, encode only bounded
    repetition progress, and keep the distinct substatus out of result
    bits.
  - Check setup, explicit unmap, and teardown transitions; preserve list
    and
    kref ownership and quarantine any state whose safe release is
    uncertain.
  - Unmap child mappings before restoring host access for uninitialized as
    well as initialized SNP partitions.
  - Map hypervisor SynIC pages as decrypted shared-GPA mappings and
    withdraw
    per-CPU pointers before unmapping or freeing them.
  - Validate VMSA and PSP GPAs before PFN conversion and retain the
    existing
    large-page alignment and physical-contiguity checks.
  - Reject SNP isolation in intermediate commits until its complete ioctl
    and
    lifecycle implementation is present.
  - Guard the SNP-only GPFN conversion helper so ARM64 W=1 builds do not
    emit
    an unused-function warning.
  - Resolve additional adversarial-review findings: initialize common
    region
    locks for every region type, avoid mmap/remap lock inversion, validate
    zero/oversized REP progress, and initialize all common copyout paths.

Two Sashiko findings were investigated and dismissed rather than papered
over.
Hyper-V consumes the PSP request input synchronously before returning
HV_STATUS_CALL_PENDING, so the shared per-CPU input page need not remain
reserved while waiting for completion. Also, MSHV's modify-SPA-host-access
operation transfers root-to-child SPA/SLAT ownership in Hyper-V; it does
not
perform an in-place SNP RMP transition on Linux-owned direct-map pages, so
kernel direct-map invalidation, encryption-attribute changes, and
shared-bit
rewrites would be incorrect here.

Link: https://lore.kernel.org/linux-hyperv/20260825040505.826600-1-weh@linux.microsoft.com/

Wei Hu (3):
  mshv: retain memory regions until unmap succeeds
  mshv: clear SynIC mappings before freeing them
  mshv: set up own SynIC registers on a nested root partition

Wei Liu (6):
  mshv: add SEV-SNP UAPI definitions
  mshv: add SEV-SNP PSP request hypercall
  mshv: add SEV-SNP isolated page hypercalls
  mshv: wire SEV-SNP partition ioctls
  mshv: detect and report SEV-SNP support at init
  mshv: use safe partition CPU feature defaults

 drivers/hv/mshv_regions.c      |  160 +++--
 drivers/hv/mshv_root.h         |   50 +-
 drivers/hv/mshv_root_hv_call.c |  303 +++++++--
 drivers/hv/mshv_root_main.c    | 1045 +++++++++++++++++++++++++++++---
 drivers/hv/mshv_synic.c        |  172 +++---
 include/hyperv/hvgdk_mini.h    |   31 +
 include/hyperv/hvhdk.h         |  124 +++-
 include/hyperv/hvhdk_mini.h    |   53 ++
 include/uapi/linux/mshv.h      |  111 +++-
 9 files changed, 1813 insertions(+), 236 deletions(-)


base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0

