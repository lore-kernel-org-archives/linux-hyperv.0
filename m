Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024116;
	b=OvMrUAXU+ShzoTDPD9UQdAoCb+7bStJIeJpFGV/m8TJ0RkuOqG7wYT0Rh3LflspZqxM2
	 I0AKGMi06RcV4/ngph6yAl9Bt0fZmXaEOR15FjqIDEz1wwGffqz//DD8VHydRIk/UZaFY
	 KWLhYKKx1WCF/yRjHHoeK76eE1HLTNq5uEpni2jENP2ld8iP7QKiIyzDtMPv5PpuiGLfw
	 15wauop1XUDU/beg9EbrCw8vo8U5WDBfmLUG4jbSD5pr9DAiHT2uRveF+yk+LvhyPEDlf
	 IuzT0DZcDCSbtdYtvkje/t6YovJ9gvojTcqgNkc5g0awtgGZCQ9/gEwNn5AojZAmw+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024116;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=Q3kzFWZouH6HMVsFJg/CjIT+Um5UEG0KcT8hAco3398=;
	b=1VTyK4TFpUvXPtOSPKcPJXfiBNnYGTq7JLXafYURSnjWvlLQIfAQFpwh/KWzZ3vPUpBb
	 nBJdQ+NMWnchU7eH7+Ql1jjxR9U9s+5bfMxXymEZVNNJhDonoxjTbOKOOWCoffJASZvY1
	 qGj0kohsxU34gGU79DqI0jF7Th0V3rRRAAjiOM+A0hOpg5pi3f7wpUnDnBkGFfJp4EQr3
	 30/kDsYd/FQ3fecGxFZU5QMXftSxapePIvpDFmiEQYZFxTEFtDimTj0P1scbZsFkCZWCS
	 iFiSohQkmVcsD0wYPlyaX64omxXnygxzWaR7M2JihlPhlmcdqhCCFdeRJOzkCBmWdmg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=U0hfKLRm;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9255D606A31A;
	Mon, 26 Oct 2026 14:15:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9255D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=U0hfKLRm
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 61AB820B7166;
	Mon, 26 Oct 2026 07:15:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 61AB820B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793024104;
	bh=Q3kzFWZouH6HMVsFJg/CjIT+Um5UEG0KcT8hAco3398=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0hfKLRm7+yE4JS5WARbg847sQ0ofpJm1rJehjzIG3fFdfz6IYUc8gPaXBFTEArKe
	 p8vZo0JLV2F9SYdEMP5cfpYpjtCVEVjzjUjXbDMEmN/U7jSfiiIDdufnG4cYn2vqBM
	 xytvVkwVzMTpB71tdwgTbrAJbaX+elnydhwdJiFU=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	weh@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v8 0/9] mshv: add SEV-SNP support for MSHV root partitions
Date: Mon, 26 Oct 2026 14:14:47 +0000
Message-ID: <20261026141512.2987985-1-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922041043.171543-1-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
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

Per Wei Liu's recommendation, v8 is based on linux-next next-20261022:

  bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab

This includes both the MM/HMM changes and hyperv-next. The complete series
also applies without conflicts to the separately checked hyperv-next tip:

  347f8745462dad74022284e34ddd9d1c16b7473f

Changes since v7:

  - Rebase onto linux-next, resolving the patch-1 conflict with
    39899823ad38 ("mshv: use hmm_range_fault_unlocked_timeout() for region
    faults").
  - In patch 1, retain the unlocked HMM helper and let it manage mmap_lock.
    Preserve the region fault-admission gate, mm lifetime reference,
    notifier-sequence recheck, and checked-unmap teardown ordering.
  - Preserve hyperv-next's updated hypervisor memory-deposit logic.
  - Reflow ordinary code and comments toward 80 columns without splitting
    diagnostic strings. Keep conventional alignment where long type or
    argument names make an 80-column layout impractical.
  - Apart from patch 1's HMM adaptation, source changes relative to v7
    are formatting-only. There are no UAPI layout, ioctl-number, or
    request-limit changes. The UAPI header is no longer byte-identical.

Formatting-only verification:

  - Every intermediate patch preserves the previous v8 snapshot's C
    tokens, complete literals, comment words and preprocessor directives.
  - Strict checkpatch at 80 columns: no errors or CHECKs; seven remaining
    long-identifier warnings.
  - x86-64 and ARM64 W=1 affected-object builds.
  - All nine existing MSHV host-access KUnit tests.
  - Exported UAPI layout assertions for x86-64, x86-32, and ARM64, plus
    x86 and ARM64 Rust bindgen checks.
  - Exact mailbox replay on the stated linux-next base.
  - Plain git am application and affected x86 object builds on the stated
    hyperv-next tip.

The previous v8 source, b4b111a45c54, passed the full x86-64 kernel/modules
build and the nested-host CVM tests: normal 16-CPU host boot, the dedicated
Cloud Hypervisor integration test, and a four-vCPU/1-GiB SNP guest reaching
login with successful teardown. Those are prior, source-equivalent runtime
results, not a new deployment or hardware run of this formatted revision.

The development host needs local runtime prerequisites: EFI HvLoader root
partition boot enablement, its adaptation to linux-next's UTF-16 formatter,
the nested-VMBus interrupt-vector workaround, and preservation of the nested
SIGNAL_EVENT control bit. These and the KUnit follow-up remain excluded from
the nine-patch submission.

Link: https://lore.kernel.org/linux-hyperv/20260922041043.171543-1-weh@linux.microsoft.com/

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

 drivers/hv/mshv_regions.c      |  482 ++++++++++++---
 drivers/hv/mshv_root.h         |  129 +++-
 drivers/hv/mshv_root_hv_call.c |  379 ++++++++++--
 drivers/hv/mshv_root_main.c    | 1334 +++++++++++++++++++++++++++++++++++++---
 drivers/hv/mshv_synic.c        |  174 +++---
 include/hyperv/hvgdk_mini.h    |   31 +
 include/hyperv/hvhdk.h         |  124 +++-
 include/hyperv/hvhdk_mini.h    |   53 ++
 include/uapi/linux/mshv.h      |  122 +++-
 9 files changed, 2563 insertions(+), 265 deletions(-)

base-commit: bd1ecbb61afefc6a8b876ccbc31e9228b44e9eab
-- 
2.43.0
