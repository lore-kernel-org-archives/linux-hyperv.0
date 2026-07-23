Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4976A47D447
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 17:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828209; cv=none; b=Vt7nDzIlCtOHQ7FoaOeU4Etqe5o4Bm2RDv5OWB8xgMIRTAfuhMzRXMYU32u/BhThOnSdqRpnaTxIMUTXC7/YscdYMGjuJ1/2WJkpqM/m0Ko2hePpGjXlCHXtZiQa8lPL4irR6aQMpslLlRRXBbqZn2o7GXAezsun5MSTezrOzzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828209; c=relaxed/simple;
	bh=5RWy4Wkr5bgViXPrkI5IwkEQLLeakvDDFGFaJWM2Tgc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=igrvxuMzTk/9Mc9DEEfZto0RInU9Xe5sMyvK+UJaM8XfRubN9/5Mkx9zS/sKcGDWC8A46ViKHu+VEFeqBXRngtg9HjIfua3rV1dXa0AFQCurHMazqFTnGKl6ZYtlrZt7U5brBYhKQ0g2pt19KHlUGHlZVK+XpXaSyS0pobtfH2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EsdwkCIL; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EsdwkCIL"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-84862b0d5f8so871468b3a.3
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 10:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784828205; x=1785433005; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=hxuraTQgEZqYbQmSAqLAHqtM6r0YcdQGYrnF3lC7WW4=;
        b=EsdwkCILIq10dDA5McMqEyKz85U5fY3Zse3ggy0zDNAcQptXu//cclm717K80JKAaI
         YcSF2DTDwGZmeNdzZp4JYsWPbRpQy/TSgbFX4GM8iNxW6jbBrcB/8x/MhOiwXIL64w4C
         03R6CJhF3tUdjsiyrOaXFhNby2cNFzM7YrXKPPFBawgEZHyAikyBVUx3PbjbPITb3HGs
         U7gJab6IXuSRyJB/bIM7xnSOTn6glE3T0UyGF+z02IMyIrreTA2jt+MTFSsFHe/HYay+
         tJKSBEfmrWBWJi5ot5Y/fsw8AiWlo/Gu23ly2l8ztUWeOhUpbrLIryef4DeB07uHhTaM
         6nAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828205; x=1785433005;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hxuraTQgEZqYbQmSAqLAHqtM6r0YcdQGYrnF3lC7WW4=;
        b=FIvQvzxPS5fqPuRCs/ZyQwbCLHMfYTRYGrHiVl3WVBZ8my0MC6zyAQojl2DTs7cEXg
         aOlLKRcwoLYbp6HOOenMgC5yifvPMdxKkC1u8d6CgPGqzNqLdTHBPdncIA11Akwl7ZL7
         giobWr1A2XLMUepH+uaeFLKwDY7+4RFX1rOa6K5SvJc8a6w2l3Y/bMioO+0Awkuovcho
         uVDTciULvedgIjihWu1Svn6e1s73rdVbiWrvLgqhqn9hqjmkeCI/d6RvW7zT6QY5Z5jR
         yPTrSyj4qKEB11e9PnIM783eAtSCHN1pZ8hESGXa3IKiV5AZMskZpqlS+dfyKLlLF/iU
         NJzA==
X-Forwarded-Encrypted: i=1; AHgh+RpXXlcGw2Ew1zL4s0648WNbqVpdg3Y6YSEcLLdxfsECAJa/jx8IgBOZaXlnW8DFkxnwVTFa/EidXIz49sU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEO0UItLzTlNEJai2JiZGw24tTHnCmHalpUqiek68sgjLb36iZ
	iQl7etpV1AmFw2QQknEPo1UhcbTQ73HPmQv9IDV4MY71YZz6+65xYX6d
X-Gm-Gg: AR+sD11skXTLpcBQSrWEOU9WH/0vOhz/wqEMKXYh2eBGdhH+hPiYMR+trz9U3GJ8+tN
	eMyl8q04oAgiuH4DCvwY1MTGvEBSwevkRTkZaOZqmJAOhEAGVVteOa5kmdkDipr5/S2vTmmriqb
	rnSVXJhXk8vOxPfSqlm8JYIrqd7EetnWywsth+ZUTf2efjrENWUUId3gY9lCwMXJ110J3GpwjKL
	3Pwk7GNSC5weDgfoYof30JRcLrg6+/IQyj7B2PO7lEL7LZ5tMC8cn2nL7Di3b6QFpB5WiZtrDwp
	3sbJ8PrYxe2QVHclS/9QzdZkQiccOT9b6eZDc7FGmomDYOuR1DEYu7aD08yaMIyXPAHGzllvS7P
	uoi3b6gXf0iRNzjIAk5cG38wz7h/OHm82c8G/HcyZfIJb8cXgo6dWw7tF1t/NNI4B2FCN2sGeY1
	se7RJH/ukzI2Dv6QgzJy0e4/yR3ZrB9kIFTJUpvRv4j2egXl/l
X-Received: by 2002:a05:6a00:c81:b0:847:7a61:e68e with SMTP id d2e1a72fcca58-84e2b8da6e7mr4786213b3a.31.1784828204458;
        Thu, 23 Jul 2026 10:36:44 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e20622dedsm2691612b3a.11.2026.07.23.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 10:36:43 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Subject: [PATCH v11 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Date: Thu, 23 Jul 2026 10:36:32 -0700
Message-Id: <20260723-hmm-v10-v11-0-c55b003a4b61@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIACFRYmoC/2WMQQ7CIBAAv9Ls2TUsEoie/IfpAQqWTaQ1YIim4
 e9irx5nMpkNSsgcClyGDXKoXHhdOhAdBpiiXeaA7LsAKaQWRkqMKWElgUYa76RzZ39S0OtnDnd
 +76vb2Dlyea35s58r/ez/oxIK1EIrrbzXgux1TpYfx2lNMLbWvmvz8dafAAAA
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, Shuah Khan <shuah@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, 
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Min Ma <mamin506@gmail.com>, Lizhi Hou <lizhi.hou@amd.com>, 
 Oded Gabbay <ogabbay@kernel.org>, skinsburskii@gmail.com
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, linux-rdma@vger.kernel.org, 
 Jason Gunthorpe <jgg@ziepe.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784828202; l=9167;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=5RWy4Wkr5bgViXPrkI5IwkEQLLeakvDDFGFaJWM2Tgc=;
 b=DsSTuR1DRqaS/DIFjBB8yCQcyfhxOja730tI0RS6QEUOq4R2IPDJiPT3gyE6F9ZISrvwMWuad
 bA2XAbxJW9GACTx9F8w3yQ1BguR31nmSesivxAsNeNCUTR7S8vF+PaT
X-Developer-Key: i=skinsburskii@gmail.com; a=ed25519;
 pk=bDpriHBYgeTdkIDweZDCemxsU93neJBOCn3YLIuJpnE=

This series extends the HMM framework to support userfaultfd-backed memory
by allowing the mmap read lock to be dropped during hmm_range_fault().

Some page fault handlers — most notably userfaultfd — require the mmap lock
to be released so that userspace can resolve the fault. The current HMM
interface never sets FAULT_FLAG_ALLOW_RETRY, making it impossible to fault
in pages from userfaultfd-registered regions.

This series follows the established int *locked pattern from
get_user_pages_remote() in mm/gup.c. A new helper function,
hmm_range_fault_locked(), accepts an int *locked parameter. When the
mmap lock is dropped during fault resolution (VM_FAULT_RETRY or
VM_FAULT_COMPLETED), the function returns 0 with *locked = 0, signalling
the caller to restart its walk. The existing hmm_range_fault() is
refactored into a thin wrapper that passes NULL, preserving current
behavior for all existing callers.

Possible approaches to lift this limitation are documented in
Documentation/mm/hmm.rst.

Changes in v11:
  - Reject unstable address spaces in hmm_range_fault_unlocked_timeout()
    after taking mmap_lock and before walking page tables.
  - Compute the remaining HMM timeout budget before the time_after_eq()
    check in drm_gpusvm_get_pages() to make sure it can't result in zero
    and lead to infinite HMM range faulting loop.

Changes in v10:
  - Included contended mmap_lock acquisition in the
    hmm_range_fault_unlocked_timeout() retry budget.
  - Dropped the redundant top-level fatal_signal_pending() check in the HMM
    unlocked retry loop; mmap_read_lock_killable() now covers that path.
  - Restored the absolute outer timeout in drm_gpusvm_get_pages(), since it can
    run from GPU page-fault workers and must not rely on the worker task’s fatal
    signal state to stop invalidation retries.
 
Changes in v9:

  - Folded the fixups into the full 8-patch series instead of sending a
    separate fixup series.
  - Clarified that the HMM timeout bounds repeated HMM/mmu-notifier retry
    attempts, with the helper refreshing range->notifier_seq internally.
  - Kept nouveau’s explicit outer deadline because its retry loop runs in a GPU
    fault worker and cannot rely on fatal signals from the faulting process.
  - Converted amdxdna, and GPU SVM callers to pass the shole timeout budget to
    hmm_range_fault_unlocked_timeout().

Changes in v8:

  - Make hmm_range_fault_unlocked_timeout() the primary documented HMM
    range-fault API, and move hmm_range_fault() into the “use only if the
    caller really must hold mmap_lock” category.
  - Clarify that the timeout is a retry budget for repeated mmu-notifier
    invalidation retries. HMM does not interrupt an in-progress page fault
    when the timeout expires.
  - Restart the retry timeout only when handle_mm_fault() dropped
    mmap_lock, because that indicates a lock-dropping fault handler such as
    userfaultfd made progress. Ordinary -EBUSY retries keep the existing
    deadline.
  - Remove the attempted timeout selftest. The remaining selftest covers the
    intended userfaultfd path by resolving missing-page faults through
    HMM_DMIRROR_READ_UNLOCKED and hmm_range_fault_unlocked_timeout(..., 0).

Changes in v7:
  - Replaced the unlocked HMM API with
    hmm_range_fault_unlocked_timeout(). The helper now takes a timeout in
    jiffies, with 0 meaning retry indefinitely.
  - Moved -EBUSY retry handling into the HMM helper for the unlocked path.
    The helper refreshes range->notifier_seq internally before each retry.
  - Switched the unlocked path to mmap_read_lock_killable() and return
    -EINTR if mmap lock acquisition is interrupted or a fatal signal is
    pending during retry handling.
  - Removed the redundant non-timeout hmm_range_fault_unlocked() interface.
  - Updated Documentation/mm/hmm.rst and kernel-doc to describe the timeout API
    and the intended caller pattern.
  - Updated the HMM selftests to use hmm_range_fault_unlocked_timeout()
    only, including coverage for the finite-timeout path.
  - Added in-tree users of the new helper:
      - mshv
      - nouveau
      - RDMA/umem
      - amdxdna
      - drm/gpusvm
  - Preserved each converted driver’s existing timeout convention:
      - unbounded retry where the old code retried indefinitely,
      - HMM_RANGE_DEFAULT_TIMEOUT where the old code used that budget,
      - existing driver-specific timeout return values such as -ETIME.
  - Used max_t(long, timeout - jiffies, 1) when passing remaining time from
    absolute jiffies deadlines to avoid unsigned underflow while keeping a
    minimum one-jiffy retry window.
  - Left callers on hmm_range_fault() when they already need to hold
    mmap_lock across surrounding work, such as drm_gpusvm_check_pages().

Changes in v6:
  - Reworked the new API from the external int *locked pattern to
    hmm_range_fault_unlocked(), which owns mmap_read_lock() internally.
  - Changed the dropped-lock contract: hmm_range_fault_unlocked() now returns
    -EBUSY when the mmap lock is dropped, and callers restart with a fresh
    mmu_interval_read_begin() sequence.
  - Kept hmm_range_fault() as the locked variant for existing users, preserving
    its caller-held mmap lock contract.
  - Added an in-tree user by converting the MSHV region fault path to
    hmm_range_fault_unlocked().
  - Updated Documentation/mm/hmm.rst and kernel-doc to describe the unlocked
    helper and retry pattern.
  - Updated commit messages to match the new API and return semantics.
  - Kept the userfaultfd HMM selftest using the test_hmm unlocked read ioctl
    path.

Changes in v5:
 - Rework hmm_range_fault_unlockable() retry handling to retry
   VM_FAULT_RETRY internally with FAULT_FLAG_TRIED set, matching the
   fixup_user_fault() pattern and avoiding repeated first-retry lock drops.
 - Distinguish VM_FAULT_RETRY from VM_FAULT_COMPLETED: retry faults now
   reacquire the mmap lock internally, while completed faults return to the
   caller with *locked = 0 so the caller can restart with a fresh notifier
   sequence.
 - Document the two *locked return states, including the -EINTR case when a
   fatal signal is pending after the mmap lock has already been dropped.
 - Update comments around HMM_FAULT_UNLOCKED and the HMM fault loop to match
   the current hmm_range_fault_unlockable() implementation.

Changes in v4:
 - Rebased on 7.2-rc1
Changes in v3:
 - Return -EFAULT from dmirror_fault_unlockable() when the mirrored mm can
   no longer be pinned.
 - Add an eventfd stop signal for the userfaultfd handler thread to avoid
   waiting for the poll timeout on successful test completion.

Changes in v2:

- Split into a preparatory refactor (new patch 1) that moves
   handle_mm_fault() out of the walk callbacks, plus a smaller feature
   patch on top.  Suggested by David Hildenbrand.
 - Hugetlb regions are now supported on the unlockable path; the v1
   -EFAULT short-circuit and the hugetlb_vma_lock_read drop/retake
   dance are gone.
 - Distinct internal sentinels for "needs fault" (HMM_FAULT_PENDING)
   and "lock dropped" (HMM_FAULT_UNLOCKED).
 - Outer loop now re-walks after a successful internal fault so the
   faulted pfns end up in range->hmm_pfns.
 - Kernel-doc on hmm_range_fault_unlockable() and the
   Documentation/mm/hmm.rst example match the implementation.
 - Dropped the mshv driver conversion (v1 patch 2); will post
   separately.
 - Selftest converted to drive the path through test_hmm with a
   userfaultfd handler (new HMM_DMIRROR_READ_UNLOCKABLE ioctl).

---
Stanislav Kinsburskii (8):
      mm/hmm: move page fault handling out of walk callbacks
      mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
      selftests/mm: add HMM test for mmap lock-dropping faults
      mshv: Use hmm_range_fault_unlocked_timeout() for region faults
      drm/nouveau: Use hmm_range_fault_unlocked_timeout() for SVM faults
      RDMA/umem: Use hmm_range_fault_unlocked_timeout() for ODP faults
      accel/amdxdna: Use hmm_range_fault_unlocked_timeout() for range population
      drm/gpusvm: Use hmm_range_fault_unlocked_timeout() for range faults

 Documentation/mm/hmm.rst               |  79 +++++++---
 drivers/accel/amdxdna/aie2_ctx.c       |  23 +--
 drivers/gpu/drm/drm_gpusvm.c           |  60 ++------
 drivers/gpu/drm/nouveau/nouveau_svm.c  |  20 +--
 drivers/hv/mshv_regions.c              |  54 ++-----
 drivers/infiniband/core/umem_odp.c     |  18 +--
 include/linux/hmm.h                    |   2 +
 lib/test_hmm.c                         | 107 +++++++++++++-
 lib/test_hmm_uapi.h                    |   1 +
 mm/hmm.c                               | 262 +++++++++++++++++++++++++--------
 tools/testing/selftests/mm/hmm-tests.c | 150 +++++++++++++++++++
 11 files changed, 557 insertions(+), 219 deletions(-)
---
base-commit: a4271215228d2bd2a50eea03ab0a948b36036948
change-id: 20260722-hmm-v10-727db2bb9d34

Best regards,
-- 
Stanislav Kinsburskii <skinsburskii@gmail.com>

