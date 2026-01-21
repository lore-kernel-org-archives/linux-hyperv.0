Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8552C2FFDD6;
	Wed, 21 Jan 2026 21:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769031987; cv=none; b=ZXjAs4tRQ5kWkEIsFF50bm8cBGhORxtjPY0ag2vefd9KFtB4cfyQ175nMncnMqQ2YuvF5r/C3p3JonYr7Rf4vftc9s87rqbTZyzCsUzPKEf47xYnuXCtRTWK5C56Ga0nRT4npLMkF64biXjWU52a4T1CO1sRHdm+o1wO64KzyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769031987; c=relaxed/simple;
	bh=oUxSPs6ihw9t7gGCIDYwVjzZmRn0zcf/RP8oPEZvCGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MSpGAWCCtEqqAo4AhjMmKQbVrJpi4uwXqS1w5dHmsZC5pZPT/sccaz7W37Aaur7laH4KNO9rI1m/tSqJ7d7r4qfGcXMptBhhJYWRykrtoh5+6iwNSoSAZP9vv+kFIKgBsutbwx1xB5Ei1mbjIAaO3pExv9yabHP8gtTwbuN0aAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XhKBKzIA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XhKBKzIA"
Received: by linux.microsoft.com (Postfix, from userid 1032)
	id 2A4F420B7167; Wed, 21 Jan 2026 13:46:25 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A4F420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769031985;
	bh=N8JLgPrXJfj1CfaNFB4Z08QcfnNWV+vE8a8UsDeOlaM=;
	h=From:To:Cc:Subject:Date:From;
	b=XhKBKzIALbE0ptq6lOOTzzlXEnhHz42V3Gd88rQNovZZvLIPREJ7d0m0NfRaBpzZB
	 5mTRxASaCGvR6x2f7svgUUJluT+VvZlwzerI78A+EZT0lIWvjiw4+/8ybGcV7X67Zm
	 ciFYhPT9nxhdOdRIBiYRW98pWhNcrzNJIHQiyzBc=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mhklinux@outlook.com,
	skinsburskii@linux.microsoft.com
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	prapal@linux.microsoft.com,
	mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: [PATCH v4 0/7] mshv: Debugfs interface for mshv_root
Date: Wed, 21 Jan 2026 13:46:16 -0800
Message-ID: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Expose hypervisor, logical processor, partition, and virtual processor
statistics via debugfs. These are provided by mapping 'stats' pages via
hypercall.

Patch #1: Update hv_call_map_stats_page() to return success when
          HV_STATS_AREA_PARENT is unavailable, which is the case on some
          hypervisor versions, where it can fall back to HV_STATS_AREA_SELF
Patch #2: Use struct hv_stats_page pointers instead of void *
Patch #3: Make mshv_vp_stats_map/unmap() more flexible to use with debugfs code
Patch #4: Always map vp stats page regardless of scheduler, to reuse in debugfs
Patch #5: Change to hv_stats_page definition and VpRootDispatchThreadBlocked
Patch #6: Introduce the definitions needed for the various stats pages
Patch #7: Add mshv_debugfs.c, and integrate it with the mshv_root driver to
          expose the partition and VP stats.

---
Changes in v4:
- Put the counters definitions in static arrays in hv_counters.c, instead of as
  enums in hvhdk.h [Michael]
- Due to the above, add an additional patch (#5) to simplify hv_stats_page, and
  retain the enum definition at the top of mshv_root_main.c for use with
  VpRootDispatchThreadBlocked. That is the only remaining use of the counter
  enum.
- Due to the above, use num_present_cpus() as the number of LPs to map stats
  pages for - this number shouldn't change at runtime because the hypervisor
  doesn't support hotplug for root partition.

Changes in v3:
- Add 3 small refactor/cleanup patches (patches 2,3,4) from Stanislav. These
  simplify some of the debugfs code, and fix issues with mapping VP stats on
  L1VH.
- Fix cleanup of parent stats dentries on module removal (via squashing some
  internal patches into patch #6) [Praveen]
- Remove unused goto label [Stanislav, kernel bot]
- Use struct hv_stats_page * instead of void * in mshv_debugfs.c [Stanislav]
- Remove some redundant variables [Stanislav]
- Rename debugfs dentry fields for brevity [Stanislav]
- Use ERR_CAST() for the dentry error pointer returned from
  lp_debugfs_stats_create() [Stanislav]
- Fix leak of pages allocated for lp stats mappings by storing them in an array
  [Michael]
- Add comments to clarify PARENT vs SELF usage and edge cases [Michael]
- Add VpLoadAvg for x86 and print the stat [Michael]
- Add NUM_STATS_AREAS for array sizing in mshv_debugfs.c [Michael]

Changes in v2:
- Remove unnecessary pr_debug_once() in patch 1 [Stanislav Kinsburskii]
- CONFIG_X86 -> CONFIG_X86_64 in patch 2 [Stanislav Kinsburskii]

---
Nuno Das Neves (3):
  mshv: Update hv_stats_page definitions
  mshv: Add data for printing stats page counters
  mshv: Add debugfs to view hypervisor statistics

Purna Pavan Chandra Aekkaladevi (1):
  mshv: Ignore second stats page map result failure

Stanislav Kinsburskii (3):
  mshv: Use typed hv_stats_page pointers
  mshv: Improve mshv_vp_stats_map/unmap(), add them to mshv_root.h
  mshv: Always map child vp stats pages regardless of scheduler type

 drivers/hv/Makefile            |   1 +
 drivers/hv/hv_counters.c       | 489 +++++++++++++++++++++++
 drivers/hv/hv_synic.c          | 177 +++++++++
 drivers/hv/mshv_debugfs.c      | 703 +++++++++++++++++++++++++++++++++
 drivers/hv/mshv_root.h         |  49 ++-
 drivers/hv/mshv_root_hv_call.c |  64 ++-
 drivers/hv/mshv_root_main.c    | 135 ++++---
 include/hyperv/hvhdk.h         |   8 +
 8 files changed, 1564 insertions(+), 62 deletions(-)
 create mode 100644 drivers/hv/hv_counters.c
 create mode 100644 drivers/hv/hv_synic.c
 create mode 100644 drivers/hv/mshv_debugfs.c

-- 
2.34.1

