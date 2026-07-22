Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A2F843CE6F
	for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 21:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784756688; cv=none; b=Yq7YiWC953k0lhLAFeDnDmMN8LPW6HsBkie2qsC1qL9z0TTUwgzGrGRbYv3Y7dP5BEk6+utN86ZF/4LjzoDuUqwhrl558ca9n3ca84dgsFheH+tM2Vto2X3YnGWzod1UbXuXGkSlzDdB8NpSWgKsGWJdNsqGZ8x+AFyDU0fwkV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784756688; c=relaxed/simple;
	bh=GYHNo/XGeE9xtQ1NfZoCvPIFOUdd9M9aSo+hbXMqC0E=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ObFhFyAZ0dxAUwU4WE2UIVqUpxooHhyHPmo9za6DERx0RoO+z2QhoNJKsTvtQ5atbP42/v2tg/4mW3wvvG8JtUkJSlEyeoNKKX5Zws0FUhiC1V5+wb1yBqVYHX0XnPO/i/VX8mA5rb3zGGc4ER6cMfUQd46xTenpH77knPnPjaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nvzd8mA/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nvzd8mA/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a2dcede83so12909104b3a.3
        for <linux-hyperv@vger.kernel.org>; Wed, 22 Jul 2026 14:44:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784756686; x=1785361486; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aLLCLDIkaVkTiiSr3am1nl8JfcuH2IYbuxdGPPNwyW8=;
        b=nvzd8mA/IXgz9G8pPXE/yDzTk9nZ7UxL55utJZFRXdJdjEQeNeiXTqohe5my+nLw0T
         gnTa0TkzidfSiRG2iUt0WrkHfY8VUkCMwBLef+1g8gkZf65jlu1dBWLRIXx1cdOVTvrW
         OfTgABPz0HfhzYTmu+vwYhSkXyaNYt5/8ay0H2nPx9cu473xmuUUvznlvnlqRKbdr5jR
         z7yUDqcdmIUpto712ibh2KN919eckmzUMgKSad3lSTAzXBf5gLNDSYTyLS1Fq/RQh8Lr
         vAaeiONUdUa1G8Fk9I+lPuB+vOFevtdvSlAz/cmIokLvfaoKC5hPJY8vCRdVZ3S4/u65
         Hyhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784756686; x=1785361486;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aLLCLDIkaVkTiiSr3am1nl8JfcuH2IYbuxdGPPNwyW8=;
        b=aTNEDmb4YtWIIaXzA3ZWZwFVqgIig+Bq3xuycbLmlC44AN+AkwUPzwvmDjrcELhb99
         yu2DjATtFLGoc/RUQd9wOrx8tk7X8AZufpK73MzmREF1SpNpyimeZsqLiiu+vF76zjni
         e+5xQSgZymaqOk/cb++2iqicu3NPGm14XEjQ7gumWqdPVvXVsHox7akdNXH9nE0uzrCU
         wOUMbzRdeqapsDr2FUD7rUSlUZ9JvhagFZlA8p6rbyRRCGD4QeGDTEoQFk4hPSPlOP9p
         xaa3gUCM1ZZoEERODgKBV+Wxc/BOxsHyttWYgVPW+yXT0GCH+YohHmpQcQXBzCoBksBT
         okzA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4q+zgdhGLx8BQovT3tDG9H3RhICWeWfyKeUILuwr6ZJisPz0EzQpQdM3kprgYiTPuG2VXc1//B/+BBi8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGOWALNQUHSoEa7S4akfmFQ5U7sXKYfvv4rhfFlRx4XTyscclQ
	pbpxCo+VIO3lBBNJiD8Go9cw+67ThS/WB9WcWOwreFSnd3aXfjRYBW0r
X-Gm-Gg: AR+sD13VfbL7Pb3f0odvHrlCWpnK5aW9niDlrNO0TD6RSIXKra1Mvhj2oL1fb5K85uy
	0omr/tVSiZl/qiOEl7notb+8QGHFVz11X51Pm2ze/P1uCX6KvzmQmtel0uk94TCbthpbqbVmVPF
	0+94VDNRWLn7gLqScGT4oGLm8T+Mll77sxhphy5l5CLAi36mmgIyqU5DKhghVYJWf5ASI1mdk1O
	BmKX3h+4SYC3qhcM0dpduznNWJzSaUx1/TzgOvfeMVAxdVDp8Jxba8juH2mUxmzm9Za0d7gRjCg
	Md/AV90XDiPdxAkVwxinxO/1WBebMDqRmtSztvhmj2SFkhlkkLKVuEQ0eFlZjhJPszA54pIIihD
	SdkU3CO7/sjQ3EoD2VUhnq0D43aA/y2Jm6jBXkcSq8K7JMSl3ONSscL2KcQHTRltgJFQ4U31FM+
	3x6QMJCx8ZuOXxkbqT79w50oizO3/QaMTtiHya7xAlLO/U+i4h
X-Received: by 2002:a05:6a00:b82:b0:848:4424:2b8e with SMTP id d2e1a72fcca58-84e2bbecf09mr656348b3a.3.1784756685757;
        Wed, 22 Jul 2026 14:44:45 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e17237c3fsm1946297b3a.9.2026.07.22.14.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 14:44:45 -0700 (PDT)
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
Subject: [PATCH v10 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
Date: Wed, 22 Jul 2026 14:44:22 -0700
Message-Id: <20260722-hmm-v10-v1-0-606464dd601a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALY5YWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMj3YzcXN0yQwNdcyPzlCSjpCTLFGMTJaDqgqLUtMwKsEnRSkAFSrG
 1tQBIaEitXgAAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784756683; l=8816;
 i=skinsburskii@gmail.com; s=20260722; h=from:subject:message-id;
 bh=GYHNo/XGeE9xtQ1NfZoCvPIFOUdd9M9aSo+hbXMqC0E=;
 b=+/kQG1iX/yRHeUfcwg6WZMiVcO3TSQDq9pOkpGr0vDEFgbY5Bydw04mNJ9njGp2oykHM0oS2i
 VmnQAUaI/jpCI1GH6nJe6/niHsBdn0yt1UpO4W6lecLt6cy2N4FM3XS
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
 mm/hmm.c                               | 256 +++++++++++++++++++++++++--------
 tools/testing/selftests/mm/hmm-tests.c | 150 +++++++++++++++++++
 11 files changed, 551 insertions(+), 219 deletions(-)
---
base-commit: a4271215228d2bd2a50eea03ab0a948b36036948
change-id: 20260722-hmm-v10-727db2bb9d34

Best regards,
-- 
Stanislav Kinsburskii <skinsburskii@gmail.com>

