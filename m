Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C760538D95;
	Tue,  8 Sep 2026 12:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869661; cv=none; b=lfs/KURrO7cu0nINsVPEEAKjTIx+YvWwFMOXQVj/CGa13f55LQXVflwuO+zMxuyaWLaBT4WzoQ+bPuAHp0nt/GvKhUkMT0JyMlaD4B7JH5asbeui0UKgRHxS4xb1OoR5cRWXLCsrwC70DXcb3+1Bl0+NRc4ZWngZikw5rA+0jQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869661; c=relaxed/simple;
	bh=g2/s7us4qoEc16x+qImUeCztg69KlCs29DA5gMGh1Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oifu/AMA2lUPldoC/ZXIBYgPrSAKWhzwO4OmpFhNM/cbD8qC48zoThu5HliDmL4dvL7dpxIkrG4pm18VAhFOy3JLw5lnU0iGoPMYj5VbytR8LwI0HUFuCMOSghtHN9gBkAxgv7tviGpZkPEHJuTQ1jpssW5sxqDQAsPtu5XgCcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UKby7Z8G; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UKby7Z8G"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C63CF20B7128;
	Tue,  8 Sep 2026 05:13:24 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C63CF20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788869605;
	bh=CuYJ3/PPHt7giy/YcrzQQEsPf3e7hzkrMKJcg+8WVNg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UKby7Z8GINt8L7TgrPYV8cDoZGfUXOlGMTOpBMe0FYu22IOlllvHfn6v6q/Q4ynKa
	 me6O51vxARAPR/TvngDwWBJlPK5xEW9TqnsSel4WnOgeKVE3u/HU1vNb8uLW7/BUdt
	 fkUfFs4MUvhcV1sev+3pBz3tpdjep6k9V596FfkM=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v5 0/9] mshv: add SEV-SNP support for MSHV root partitions
Date: Tue,  8 Sep 2026 12:13:33 +0000
Message-ID: <20260908121403.1160280-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831112704.2851147-1-weh@linux.microsoft.com>
References: <20260831112704.2851147-1-weh@linux.microsoft.com>
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

Two prerequisite fixes lead the series. The first makes memory-region
unmap ownership explicit and retains mappings, pinned pages, the partition,
and the module whenever checked hypervisor unmap cannot prove cleanup. The
second publishes and withdraws per-CPU SynIC pointers so interrupt readers
cannot observe mappings after initialization failure or CPU teardown.

Testing:

  - Built all four affected x86 MSHV objects with W=1 at every commit.
  - Built the complete x86_64 kernel and modules with W=1.
  - Built the affected ARM64 objects with W=1.
  - Ran scripts/checkpatch.pl --strict on every patch.
  - Verified installed UAPI layouts in 64-bit and 32-bit userspace builds.
  - Generated rust-vmm MSHV bindings from the installed kernel headers.
  - Passed all 8 KUnit host-access tests on a separate test-only branch.
  - Passed the corrected single-CVM runtime test.
  - Booted a four-vCPU SEV-SNP guest to login.

The development host needs two additional local runtime patches to boot as
a nested MSHV root partition: EFI HvLoader root-partition boot enablement
and the non-upstreamable nested-VMBus interrupt-vector workaround. Neither
patch, the KUnit follow-up, nor any runtime-only commit is part of this
nine-patch series.

Changes since v4:

  - Separate faults_blocked admission state from mapping_may_exist proof in
    patch 1. The interval notifier no longer takes the fair rwsem, always
    publishes its interval sequence after taking the region mutex, and a
    movable fault drops all attempt-local locks before retry. This removes
    the v4 ABBA cycle while preserving checked-unmap proof requirements.
  - Correct patch 5's commit message to describe the isolated-page import
    and import-completion wrappers actually added by that patch.
  - Replace patch 6's region-wide host-access boolean with per-page READ,
    WRITE, EXCLUSIVE, and UNCERTAIN state and exact completed-prefix updates.
    Recovery restores only the known completed prefix; teardown restores
    only nonbaseline state and retains uncertain pages.
  - Make MAKE_EXCLUSIVE and MAKE_SHARED explicit ownership transitions.
    Permission-only operations preserve ownership, and the child partition
    ID is supplied only for MAKE_EXCLUSIVE. Support arbitrary cross-region
    arrays, reject duplicate GPA/PFN entries and pinned aliases, and restore
    PSP request pages to their exact original state.
  - The first v5 runtime iteration exposed an incorrect forced MAKE_SHARED
    and child partition_id model. The corrected wire/state matrix passed the
    single-CVM runtime test and a four-vCPU guest boot to login.
  - Leave two findings that predate this series unchanged and explicitly out
    of scope: MMIO VMA/PFN validation and the blockable notifier remap-failure
    contract. The reported L1VH local-SIRBP path is also pre-existing and is
    unreachable for the hardware-CVM partition type exercised here.

Link: https://lore.kernel.org/linux-hyperv/20260831112704.2851147-1-weh@linux.microsoft.com/

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

 drivers/hv/mshv_regions.c      |  510 ++++++++++---
 drivers/hv/mshv_root.h         |  120 ++-
 drivers/hv/mshv_root_hv_call.c |  369 ++++++++--
 drivers/hv/mshv_root_main.c    | 1267 ++++++++++++++++++++++++++++++--
 drivers/hv/mshv_synic.c        |  172 +++--
 include/hyperv/hvgdk_mini.h    |   31 +
 include/hyperv/hvhdk.h         |  124 +++-
 include/hyperv/hvhdk_mini.h    |   53 ++
 include/uapi/linux/mshv.h      |  111 ++-
 9 files changed, 2452 insertions(+), 305 deletions(-)


base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0

