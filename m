Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0260D3F4112;
	Wed, 13 May 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698220; cv=none; b=RWSR96pYi+mSHsHpVljgClc3/vlPWf8F/tCVgH0s+6hVnZL2imfgSbJLH61BPUOg+5LKFZZb8SIahM9gxRWqD6TdN2qY8Tid6Nqz8ixsGjeusm/qMog5C5CSuGESEtO49wG0L5aF8+FlqIGgzfgoedXHIkH7PzDvCzHsIaLNWbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698220; c=relaxed/simple;
	bh=0Yq/yb08LElBMqhBLbYTcCcWBg/YcIjiDzcgC0i4X7U=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=Q2dNV3HQmuNJ7kOc0K8djIQXV+pfGT8FH/DM0/wxHciTrHNYL41FQb4yNf5apCTrOElWgHKpAVlD2eV/H4RiGuMu3bvsj7Zt68fMSF97DNmsBqt+Qx7tdufq6cTagU3LkMNoT5Zw1llwfnmbSfFGIKSqrCcyy2T1ulXWHENZ4Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Wqe7jJ5g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Wqe7jJ5g"
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id B2FFF20B7166;
	Wed, 13 May 2026 11:50:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B2FFF20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698214;
	bh=+nWEY3JfFMwElo2cOytM/EOCWHb6+J89FxUMn8nfLbg=;
	h=Subject:From:To:Cc:Date:From;
	b=Wqe7jJ5gwtJ30fHbhSnV4pK0AqA9IHi0LSN7wl2mnOQnTUQimbvAjXbR25t+8hrPu
	 X+eIbkF5NwDg9Tci2dLwxujLaNmZLDh4MiTcqC0j+Ic/eA/eJX+N35z1KfKqreM/Lw
	 gpqV75kAJPfRSrNwrLRcpXsgtIdvWmVD1orMSraE=
Subject: [PATCH v3 00/11] mshv: Refactor memory region management and map
 pages at creation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:50:17 +0000
Message-ID: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series refactors the mshv memory region subsystem in preparation
for mapping populated pages into the hypervisor at movable region
creation time, rather than relying solely on demand faulting.

The primary motivation is to ensure that when userspace passes a
pre-populated mapping for a movable memory region, those pages are
immediately visible to the hypervisor. Previously, all movable regions
were created with HV_MAP_GPA_NO_ACCESS on every page regardless of
whether the backing pages were already present, deferring all mapping
to the fault handler. This added unnecessary fault overhead and
complicated the initial setup of child partitions with pre-populated
memory.

v3:
 - Fixed a few issues.
 - Reworked the code flow to simplify the logic.

v2:
 - Rebased on top of latest mainline, simplified the check for valid PFNs,
   added other minor cleanups and improvements.

---

Stanislav Kinsburskii (11):
      mshv: Don't reject huge-page stride on unaligned region length
      mshv: Don't request HMM write fault for read-only regions
      mshv: Convert region storage from page pointers to PFNs
      mshv: Refactor region segmentation into a dedicated helper
      mshv: Support address range holes in remapping
      mshv: Iterate VMAs when faulting in region pages
      mshv: Scale fault granularity for non-4 KiB host pages
      mshv: Move pinned region setup to mshv_regions.c
      mshv: Map populated pages on movable region creation
      mshv: Extract MMIO region mapping into separate function
      mshv: Add tracepoint for map GPA hypercall


 drivers/hv/mshv_regions.c      |  636 ++++++++++++++++++++++++++++------------
 drivers/hv/mshv_root.h         |   30 +-
 drivers/hv/mshv_root_hv_call.c |   52 ++-
 drivers/hv/mshv_root_main.c    |  105 +------
 drivers/hv/mshv_trace.h        |   36 ++
 5 files changed, 530 insertions(+), 329 deletions(-)

