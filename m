Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB382BE7DD;
	Thu,  9 Apr 2026 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775748241; cv=none; b=pSio9H+t7EsBcg8OMUPwdhmyfy5IhKe/J55GZnJaWTEELeBQQzsKXhPDzat2PujsRTmdz8lvLSCG3btM+3rXhQ9CCiQnTr7XueMtpewnA/QFggf5wb5ctTMSn6FYh40jKdb4+hXA3IL4TAYFtYNq3qBLWTcV6wIgatqyisCcLYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775748241; c=relaxed/simple;
	bh=rHU+lvIU4Q7BqaS8oRPV3/9+o6NyNvtQS1cIOBGOM/4=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=uY3xT0gq9M1Jx+jZIkx+w96bwmCiq5u2iNrjfJUSVk9TfVEJqvblwseNTIjTOEcZT/jEl1dcdQmVbuUQfwfOomO0dpjI35d4KRKCsl7BY4ObDUSl6aGMMsWkA9Jl0twlZDlVzyKba3AAXVD/HFWu5hmenU3reuMN96yRlfx6X+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r8G3lk2T; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r8G3lk2T"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id F05BE20B710C;
	Thu,  9 Apr 2026 08:23:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F05BE20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775748240;
	bh=3naoBAGXp/5hTU0bA2EU47yyS/ApqKhv2ayEJbheb/A=;
	h=Subject:From:To:Cc:Date:From;
	b=r8G3lk2TDPI6IYvbd5kZszZxHE5RWfJWw6XsGSkTcU/pU9Agc1+PRn+G3EaIdQiNz
	 qBXtMN1OneIDqXm74hLTC3uLNxhRYQE8u4bI6/Jz3+qxJq2hWsJ4AHCpIg043kkjl2
	 PWlko7RdiT7kDiIpwtcp9b9+qvEO+QOyXNVL9NEs=
Subject: [PATCH v3 0/7] mshv: Reduce memory consumption for unpinned regions
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 09 Apr 2026 15:23:59 +0000
Message-ID: 
 <177574802240.19719.4873018419452139691.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series reduces memory consumption for unpinned regions by avoiding
PFN array allocation. A 1GB unpinned region currently wastes 2MB for an
unused PFN array that HMM-managed regions don't need.

The first three patches are preparatory refactoring. Patch 1 consolidates
region creation and mapping logic, reducing API surface by 4 functions.
Patch 2 introduces a typedef for PFN handler callbacks to simplify
function signatures. Patch 3 renames mshv_mem_region to mshv_region to
align with existing function naming conventions.

Patch 4 optimizes unmap and no-access remap operations by eliminating
redundant PFN iteration when all frames are guaranteed to be mapped.
This uses large page flags for aligned chunks and removes unnecessary
helper functions.

Patches 5-6 decouple PFN processing from the region->pfns storage.
Patch 5 threads the pfns pointer explicitly through the processing
chain. Patch 6 removes offset-based indexing by having callers pass
pre-offset pointers.

Patch 7 converts the pfns array from a flexible array member to a
conditional pointer, allocated only for pinned regions that need it
for share/unshare/evict operations. This eliminates the memory waste
for unpinned regions and allows using kzalloc instead of vzalloc.

v3:
- Fix missing unmap/remap of pages before the first huge page.

v2:
- Improved commit message
- Fixed invalid vfree(region->mreg_pfns) call for MMIO-backed regions
- Fixed unpinning of already-released pages in the error path during
  pinned region creation
- Removed redundant mshv_map_region helper in favor of the new
  optimized mapping logic

---

Stanislav Kinsburskii (7):
      mshv: Consolidate region creation and mapping
      mshv: Improve code readability with handler function typedef
      mshv: Rename mshv_mem_region to mshv_region
      mshv: Optimize memory region mapping operations
      mshv: Pass pfns array explicitly through processing chain
      mshv: Simplify pfn array handling in region processing
      mshv: Allocate pfns array only for pinned regions


 drivers/hv/mshv_regions.c   |  372 ++++++++++++++++++++++++++-----------------
 drivers/hv/mshv_root.h      |   26 ++-
 drivers/hv/mshv_root_main.c |   79 ++++-----
 3 files changed, 271 insertions(+), 206 deletions(-)

