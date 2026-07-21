Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE8C46EF9C;
	Tue, 21 Jul 2026 20:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784664722; cv=none; b=rhcuJBEm6VrHssZOT8oYW/mHDT/NpY/wsiJtcQbocmwUh4KsUKMPOOaEBkL88ss+IZa/BVFdNEOVXJKn4LqKyuPknN6uKf+yL0bRnm/+qiUsZ6tVW/FHpLXZh+Q+HNifTiKPKOUgyrZoz9RVJAsjZBsGtF14ONXjKvDG9R1PcLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784664722; c=relaxed/simple;
	bh=vPmI5INqBEYqNbww5bdFHBcxTExyQVzgtn6D8fBvRV4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CecbC5Wci1S2+6ZFdPhZqcZLzAqeStrTnA+EKvvixO1Mfuv77M+91ngM1PzwqqN8TVWIUAWXUAGGbskTnXwUPNO2ig0kYAGtGosnA3bDax2sICzIekylnYKF1+/0Lz8EUc7ybqKqE1CYN9WXI5OODjEreCDHO+0rBxiKq8ul5FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=THw6yirl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="THw6yirl"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 630B420B7167;
	Tue, 21 Jul 2026 13:11:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 630B420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784664708;
	bh=KvELOKnXweNAABsGu85MvPOUP6ZAsKveNW1hQG8kwQ4=;
	h=From:To:Cc:Subject:Date:From;
	b=THw6yirloThwygFAOBUVRn0KR+4/+r6OHOZBOFbETFfvSd4XcPJTTKk0OsA+tjgv0
	 dKoCrTOV2FwHp/xtqpdwZV64gT0Q8fQYjeFKwx3JrDNTyBFrs4J9KTqSmrxPkt6Upv
	 BhgGrhCfo4Sx456SG7kTMwEZOfxvnvgc7jOVsqUs=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	mhklinux@outlook.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 0/6] arm64: hyperv: Add Realm support for Hyper-V
Date: Tue, 21 Jul 2026 13:11:42 -0700
Message-ID: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Realms (CoCo VMs on ARM) require host calls to be routed through the RMM
(Realm Management Monitor) via the RSI (Realm Service Interface). This
series implements most of the necessary changes to support Realms on
Hyper-V.

One required change is not included in this series. The two buffers
allocated via vzalloc() in netvsc_init_buf() cannot be decrypted in
vmbus_establish_gpadl(). Currently only linearly mapped memory can be
decrypted.

This patch series was tested by booting a Realm on Cobalt 200 running
Windows. I tested 4KB and 64KB page size. I replaced vzalloc() in
netvsc_init_buf() with alloc_pages_node() -> set_memory_decrypted() ->
vmap() in my testing as a workaround for the issue mentioned above [1].

Changes since v1 [2]:
  Patch 1: Add explicit padding to the RSI host call structure
  Patch 3: Change from a per-cpu pointer lazily allocated to an array
             of host call structs indexed by cpu id
  Patch 4: Align input_page + output_page allocation to PAGE_SIZE since
             that is the smallest unit of memory that can be decrypted
           ~Remove KASAN tags before passing address to
             set_memory_decrypted() since __is_lm_address() does pointer
             arithmetic.~
  Patch 5: Add a helper function to reduce repetition
           Check for NULL before indexing into host call array

Changes since v2 [3]:
  Patch 3: Remove hv_hostcall_free() and inline the logic for simplicity
           Reorder edits to keep #include line at the end of the file
  Patch 4: Remove kasan_reset_tag()

[1] https://lore.kernel.org/all/20260721195633.1438361-1-kameroncarr@linux.microsoft.com/
[2] https://lore.kernel.org/all/20260609181030.2378391-1-kameroncarr@linux.microsoft.com/
[3] https://lore.kernel.org/all/20260625173500.1995481-1-kameroncarr@linux.microsoft.com/

Kameron Carr (6):
  arm64: rsi: Add RSI host call structure and helper function
  firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
  arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
  Drivers: hv: Mark shared memory as decrypted for CCA Realms
  arm64: hyperv: Route hypercalls through RSI host call in CCA Realms
  arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms

 arch/arm64/hyperv/hv_core.c       | 155 +++++++++++++++++++++++-------
 arch/arm64/hyperv/mshyperv.c      |  38 +++++++-
 arch/arm64/include/asm/mshyperv.h |   4 +
 arch/arm64/include/asm/rsi_cmds.h |  22 +++++
 arch/arm64/include/asm/rsi_smc.h  |   7 ++
 drivers/firmware/smccc/smccc.c    |  41 +++++++-
 drivers/hv/hv_common.c            |  17 +++-
 include/asm-generic/mshyperv.h    |   1 +
 8 files changed, 244 insertions(+), 41 deletions(-)


base-commit: a4ffc59238be84dd1c26bf1c001543e832674fc6
-- 
2.45.4

