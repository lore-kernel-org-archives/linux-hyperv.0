Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79EC34E50B8;
	Fri, 18 Sep 2026 11:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732666; cv=none; b=eoqGXb5xqSOWxXXyiduXpbUjFQGvASg66HqWvdSzqqiGr7mKz/jxd6DR18wN54iMtq/7wBR3LUSaZd0DAoiUUZGXFt6ToP1ReOZ+Uk8tSs18sIjKSXNISuWcBOO63kukxuvDPe0jIbFulCbhjHpi+VvP6AH43rXCCb8dWyzUUVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732666; c=relaxed/simple;
	bh=vxCWhFr+RM4qSYd+zDX3huhagwR8jHfFBDfngVcEoZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ajsLIMN86iDyOJ1x+qgTQN+LqYGZKz9zAGzICEETkrWjKAoaGGZPFrWg3wRTG1ydapIr3YEpmfAdHlagTNWJVHhF9l587A7PI64KXyxOvMw4Qg+IcX4TFpc0t/8JxX9o2TOv6KojWJEI2jkqMtBdayLmaKrnv8Zwpq1g77JwPYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m7cnMq6F; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m7cnMq6F"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 308AA20B7166;
	Fri, 18 Sep 2026 04:56:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 308AA20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789732617;
	bh=BAULP8mYtdCcqUB4JbYQdoc1HBM4y+JPJPl5h3WYJJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7cnMq6F1Cg1iVvKiOlCfUMfTyR71uKA6ST1JngZ2lza2NIRF/G3fyWHpL/g7Z0DX
	 2JAaXl/EvQjeYSsc0eO3fy3XESmb1Y83/M9CfYX82oBAcbf1M3nxUoVEAuAcy48CjF
	 vkSK+7DuNbUHktIUTIfow6QBwHekT9Fm3/g04mUc=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v6 0/9] mshv: add SEV-SNP support for MSHV root partitions
Date: Fri, 18 Sep 2026 11:57:12 +0000
Message-ID: <20260918115741.3791682-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908121403.1160280-1-weh@linux.microsoft.com>
References: <20260908121403.1160280-1-weh@linux.microsoft.com>
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

  - Built all four affected x86 MSHV objects with W=1 at every commit (9/9).
  - Built the complete x86_64 kernel and modules with W=1.
  - Built the affected ARM64 objects with W=1.
  - Ran scripts/checkpatch.pl --strict on every production patch.
  - Verified installed UAPI layouts in 64-bit and 32-bit userspace builds.
  - Generated rust-vmm MSHV bindings for x86_64 and arm64.
  - Passed all 9 KUnit host-access tests on a separate test-only branch.
  - Passed the Cloud Hypervisor single-CVM launch test.
  - Booted a four-vCPU SEV-SNP guest to login; Cloud Hypervisor exited cleanly.

The development host needs two additional local runtime patches to boot as
a nested MSHV root partition: EFI HvLoader root-partition boot enablement
and the non-upstreamable nested-VMBus interrupt-vector workaround. Neither
patch, the KUnit follow-up, nor any runtime-only commit is part of this
nine-patch series.

Changes since v5:

  - In patch 1, keep the existing failed-chunk rollback, then attempt checked
    full-region cleanup for any earlier mapped chunks before quarantining an
    unpublished region. Preserve the original map error and serialize the
    initial movable NO_ACCESS map with mreg_mutex.
  - In patch 6, cap MODIFY_GPA_HOST_ACCESS at 65536 4K array entries. Reject a
    larger request with -E2BIG and completed set to zero before variable
    allocation or side effects. Use sort_nonatomic() and bounded scheduling
    points in long user-controlled loops.
  - Document in patch 6 that a successful PSP request intentionally leaves
    request and response pages host-none for encrypted guest consumption;
    explicit access changes or teardown restore them.
  - In patch 7, use CONFIG_X86_64 for the in-kernel SNP reporting block. Keep
    __x86_64__ in exported UAPI because headers_install rejects CONFIG_* leaks;
    x86_64 and arm64 bindgen output and UAPI layouts remain correct.
  - Classify the reported PSP-success restoration issue as a false positive.
    Findings identified as pre-existing remain unchanged and out of scope.

Link: https://lore.kernel.org/linux-hyperv/20260908121403.1160280-1-weh@linux.microsoft.com/

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

 drivers/hv/mshv_regions.c      |  510 +++++++++---
 drivers/hv/mshv_root.h         |  122 ++-
 drivers/hv/mshv_root_hv_call.c |  369 +++++++--
 drivers/hv/mshv_root_main.c    | 1324 ++++++++++++++++++++++++++++++--
 drivers/hv/mshv_synic.c        |  172 +++--
 include/hyperv/hvgdk_mini.h    |   31 +
 include/hyperv/hvhdk.h         |  124 ++-
 include/hyperv/hvhdk_mini.h    |   53 ++
 include/uapi/linux/mshv.h      |  117 ++-
 9 files changed, 2518 insertions(+), 304 deletions(-)


base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0

