Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A396C3B777F
	for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783718785; cv=none; b=EyPQs14PAsyoTSVlzGyIMmDN9hV/ieX3SXY8YTS1o3TogzsFTVMUWHFaS2kHaGgl4HRRWg3K3q52yDApo/FSLTk4nH3//Q+zhEnISagY3HUtEjqWBRQusqhB5x7S7sR7no08+FBHn/JZLsSBa3b0jLSojmejJCF+irOrvVR7Cls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783718785; c=relaxed/simple;
	bh=nZglqMW0/eP7owoyvDUWbmALINlrtJKECjh4WdGf9vY=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=LCBL42qxoMvp5epdjpcveZY6ENTaD/5+8wAHK5Dl1pnlX6m0hbOWg1tq33g8P2cpVgQEKIO76XEp2YNT8QUH/rOUk+70Zn2MuIqVdghPiGGqCIZLLz116Ocvgm6AnqHMF2gqwaQ2wuFA5bZSIHQG/QmOWpqaMUaeorFlqjfXsVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C7LRuU8W; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C7LRuU8W"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cace91f112so11673565ad.0
        for <linux-hyperv@vger.kernel.org>; Fri, 10 Jul 2026 14:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783718783; x=1784323583; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wQ4/e++dwiJ2hODy08BO64CkfLW5GsFjzHevL1ATi0c=;
        b=C7LRuU8WU7HxWahoH2aH6lbeXhC8b5RoQ2vxonF8rVfp7axsRHpaqD8YaUXCCQD+3y
         eULr0jY/wdHMG7QwR6WpZMKI6uRviexewympmlfJyL9kEWSpyJNVnKZu8xvOomTOiv2M
         i/Lm8qD5SLcEkOfRfYPdr6uFX0zyNFxKA2AZRyxky/RuMdZPMqohpu8XJw+M2uu2d36w
         sG/gXExtGkLUkM5IC7kHfiA8jX03xAyRPQmnHGbVWGg0FQJN0JOdioy7sVrJxAyCXAOo
         iR/mQ78lEp9lU9kHm6onxerVy0LJILtD7fiROe30IAw9cCQUkClzVG3LyWy4KNqEPRab
         M2yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783718783; x=1784323583;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wQ4/e++dwiJ2hODy08BO64CkfLW5GsFjzHevL1ATi0c=;
        b=ejK/s4bdWPW2W3JfYAiHnmrCqXQZ45aWjy5oXwvfyp6Y5WL44OCv6bklPhWbjhnTrE
         fHaSrztekNJN1kd4Rstih8wJG71Uwj972h46j6+J37ZMFuc6m14Hkx0l/AkWd89iUHQv
         jXcfkQ8sbFcsE/wO+mbddfjXeihs1wvs0Mug9uPhWpvDfxsUm0fMYEG5jsjlwN4sWZpu
         KSpfaK4FtS+mprjsvgHHM7HWswmGR1rW9qHANKTd92pKXmudXRxs6IabJ5E2nJc+OmOC
         aHmgIOtuwmC8xsh/6BG6iYndRwMoalcW1AmPUEg/CQkx9cf/vEGhOZvkmkgFbVFXkTq3
         5ofw==
X-Forwarded-Encrypted: i=1; AHgh+RpRp6n+aOtp/tZaIDxOf+kDwlFBmNVlxlBT0WdaizxPUIeFQtiFXFzUw8khqu4gUBNCGlbOMYol9CwHMds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy37hi1KgpCnCZxwjIAiiG4VZb5SlcDif5//Nj8EhHKAgPabRV+
	BcI5LoKhNAEGYtbMJHaWWyIYIy1HsqLirrQwd5ywYVFr+1CZ9YXpA8tR
X-Gm-Gg: AfdE7cm46B2EbtJ2DcUuJbq/wg8Vtvtfuzw1es4EdjKRLE8HfN+kRUS4BB7Pdkq7oMK
	OvRzyzDaBjzOyMbzd/VAS3uLIc1/nxUCVfTu8HKuJfmsp2WVUqB+/NIpYp9eYWXyVWywDUj5hyh
	r+UeCEs7XbeWoAN7Z6TSsrLxTkpcORexMBY5t1ePmGXIoUutRPVLb0F8shTCzejtSGozYLVdT8B
	A/AMeoZ1l9PYZchM8/JztXuD8HQAFYd899vlf7DvHFAFURd//MpSzFqK4exEMT1sUWBCh2tKFXH
	6AV73AZE/F4vcyTNMQxpZCmmWWU9mohGsPwVJaxUOUgaQC/aRbap94UtEYMpAR312bT4essKnzz
	urzI0+Z5Z1x5RL14C2nnl4M8cSHH3FZQeCNpDy81leIPzUgMQFqJdeuT9+PiQoWUw+7U0XFhhkw
	FUqZmjRte/jQGw7A8MEHOVF50hMzmQ++7Q7zy/523I1Uj+7nyVPlkNCbNpNYU=
X-Received: by 2002:a17:903:1a0c:b0:2ca:6c8:abde with SMTP id d9443c01a7336-2ce9eacd763mr7143275ad.18.1783718782878;
        Fri, 10 Jul 2026 14:26:22 -0700 (PDT)
Received: from [192.168.0.160] (c-98-225-44-182.hsd1.wa.comcast.net. [98.225.44.182])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d1e28fsm67098765ad.43.2026.07.10.14.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 14:26:22 -0700 (PDT)
Subject: [PATCH v8 0/8] mm/hmm: Add mmap lock-drop support for
 userfaultfd-backed mappings
From: Stanislav Kinsburskii <skinsburskii@gmail.com>
To: airlied@gmail.com, akhilesh@ee.iitb.ac.in, akpm@linux-foundation.org,
 corbet@lwn.net, dakr@kernel.org, david@kernel.org, decui@microsoft.com,
 haiyangz@microsoft.com, jgg@ziepe.ca, kees@kernel.org, kys@microsoft.com,
 leon@kernel.org, liam@infradead.org, lizhi.hou@amd.com, ljs@kernel.org,
 longli@microsoft.com, lyude@redhat.com, maarten.lankhorst@linux.intel.com,
 mamin506@gmail.com, mhocko@suse.com, mripard@kernel.org,
 nouveau@lists.freedesktop.org, ogabbay@kernel.org, oleg@redhat.com,
 rppt@kernel.org, shuah@kernel.org, simona@ffwll.ch,
 skhan@linuxfoundation.org, skinsburskii@gmail.com, surenb@google.com,
 tzimmermann@suse.de, vbabka@kernel.org, wei.liu@kernel.org,
 skinsburskii@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-rdma@vger.kernel.org
Date: Fri, 10 Jul 2026 14:26:20 -0700
Message-ID: <178371866223.900500.12312667138651735591.stgit@skinsburskii>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

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


 Documentation/mm/hmm.rst               |   76 +++++++--
 drivers/accel/amdxdna/aie2_ctx.c       |   17 --
 drivers/gpu/drm/drm_gpusvm.c           |   52 +-----
 drivers/gpu/drm/nouveau/nouveau_svm.c  |   12 -
 drivers/hv/mshv_regions.c              |   54 +------
 drivers/infiniband/core/umem_odp.c     |   18 +-
 include/linux/hmm.h                    |    2 
 lib/test_hmm.c                         |  107 +++++++++++++
 lib/test_hmm_uapi.h                    |    1 
 mm/hmm.c                               |  259 +++++++++++++++++++++++++-------
 tools/testing/selftests/mm/hmm-tests.c |  150 +++++++++++++++++++
 11 files changed, 541 insertions(+), 207 deletions(-)

