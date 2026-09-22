Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C603CCFBD;
	Tue, 22 Sep 2026 04:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050247; cv=none; b=QT3N3VL5h95HLvl7oBAudVahvfLtFr8N8EZVFX5WyDoRhw50rEn1lL9IORu5ipBkwJxrPR5bb15AvsuNgnj+yKs3ccSTXITop25NJO39GcNj7s+sML6NwSI2OXzuoPzX8aSJ3NBqJeD4IkFY5PdrmCu+C6sXkiclAw/tgaqmHLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050247; c=relaxed/simple;
	bh=Yzxahd1B1qEMnxcp9Mtjxm/QCxKEcu2D8ztdUv3LEzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a7OsRCN1QvmSuMY6RnmHzKHvH/VUXmAcGFuyVJSx0KU5pleoejeyDnM/wCUcbncrAts91B/Ax1qdI0sIktCPtEmaFkI8ViN7I4Wm5SQwNSLUGQ4RosLt2dUfIOVFFkfLG2F6Vhk4xB91VJRfuuyNvQZ8laJOCzo1M8LlrPx7M1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JGBN5fl9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JGBN5fl9"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id F412820B7167;
	Mon, 21 Sep 2026 21:09:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F412820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790050197;
	bh=ZQUjR/mmw/iuaI8lrHtdHNmGo83qzNDE6vwl0+ItDWg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JGBN5fl953iGyZdNSLy/XyQYbuEhfGL2SrgtaSyH5NjAe+EOaa2h2HcWa3GmKH0oN
	 wWQ01lybNBvIltsfXbE+55McSkJBfKYC7iZmfxb+SpRdlySCHmO0k/i5o/P+2TV63f
	 Up80hIbIxiwKN8vUiMbbksFBigEWSXuQzdGUL2mc=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v7 0/9] mshv: add SEV-SNP support for MSHV root partitions
Date: Tue, 22 Sep 2026 04:10:17 +0000
Message-ID: <20260922041043.171543-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918115741.3791682-1-weh@linux.microsoft.com>
References: <20260918115741.3791682-1-weh@linux.microsoft.com>
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

  - Built the complete x86_64 kernel and modules with W=1.
  - Built the affected ARM64 objects with W=1.
  - Ran scripts/checkpatch.pl --strict on every production patch.
  - Passed all 9 KUnit host-access tests on a separate test-only branch.
  - Passed the Cloud Hypervisor single-CVM launch test on the exact
    userspace revision used for v6.

The development host needs two additional local runtime patches to boot as
a nested MSHV root partition: EFI HvLoader root-partition boot enablement
and the non-upstreamable nested-VMBus interrupt-vector workaround. Neither
patch, the KUnit follow-up, nor any runtime-only commit is part of this
nine-patch series.

Changes since v6:

  - In patch 6, periodically reschedule newly added region-sized scans,
    bitmap updates, duplicate-PFN validation, and host-access hypercall
    batching so large memory regions cannot monopolize a CPU.
  - In patch 6, allow a fatal signal to stop isolated-page import between
    completed batches. Return -EINTR with the exact completed prefix so
    userspace can resume safely without abandoning an in-flight async
    hypercall.
  - Patches 1-5 and 7-9 are unchanged from v6.

Link: https://lore.kernel.org/linux-hyperv/20260918115741.3791682-1-weh@linux.microsoft.com/

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

 drivers/hv/mshv_regions.c      |  522 ++++++++++---
 drivers/hv/mshv_root.h         |  128 ++-
 drivers/hv/mshv_root_hv_call.c |  370 +++++++--
 drivers/hv/mshv_root_main.c    | 1325 ++++++++++++++++++++++++++++++--
 drivers/hv/mshv_synic.c        |  172 +++--
 include/hyperv/hvgdk_mini.h    |   31 +
 include/hyperv/hvhdk.h         |  124 ++-
 include/hyperv/hvhdk_mini.h    |   53 ++
 include/uapi/linux/mshv.h      |  117 ++-
 9 files changed, 2538 insertions(+), 304 deletions(-)

-- 
2.43.0

