Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E30B131D366;
	Fri,  2 Oct 2026 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978334; cv=none; b=NOzTU599FD87OBa6aktenuYYRulIp7MUGeVfqSwJQsi/GuURAmo7lhm4rvM6dzyMgB8SK81alJlMZkj4P6QjuK5uYz6irim8SAC71gWB0ob5mOVCp7iQaOxwGF+eMNccD30RG4oJ/Ny5uecLw2YFWSvLQ4B7qu8gmMM0vBTYotM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978334; c=relaxed/simple;
	bh=kb4nGcWIQYMIF/mSDF1BRQw9Lc65Mcc1UdLHBvxGxMw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OdRBRB9PtBsnURrBEp/mGq1StmSg14M93vrFMLTadN/JKIPIZWYtKWEZTTItG/vqRAi/AEZsA7hMeQXD83+6TTq0tzGHVzl5O4fFJeOj602F50ITcsSJlD1mLW6NlsZH75AOeQXrEFbONJbOv+N+POPTwEUc3qrPhvrQM9Fhtjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=R1PdC9D/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="R1PdC9D/"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3A1A120B7166;
	Fri,  2 Oct 2026 14:57:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A1A120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790978278;
	bh=fB8AWI5fN2ddbjjum5NsS8hnJ5Z4HHJhTGA5ByCK5bc=;
	h=From:To:Cc:Subject:Date:From;
	b=R1PdC9D/o8T6DS0YoXLIkaCdWW1Sx0fM8Uzz0vRdaAdi45/xlRo0UOGnzwjb7n6mb
	 ooK3ZYqUVnEHou65FCHOufxw1bUIPGBAJHPO49hEYa37mCAxwR/TXlzw0EQiSTskxq
	 4Cy+P35X6WwrXvXuV1+fOcs1N4KOfRyFGbYP0/Pc=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
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
Subject: [PATCH v5 0/6] arm64: hyperv: Add Realm support for Hyper-V
Date: Fri,  2 Oct 2026 14:57:19 -0700
Message-ID: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
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
             arithmetic.~ (reverted in v3)
  Patch 5: Add a helper function to reduce repetition
           Check for NULL before indexing into host call array

Changes since v2 [3]:
  Patch 3: Remove hv_hostcall_free() and inline the logic for simplicity
           Reorder edits to keep #include line at the end of the file
  Patch 4: Remove kasan_reset_tag()

Changes since v3 [4]:
  Rebased onto arm64 for-next/smccc-bus which includes moving RSI header
  files out of arch/arm64 [5]

Changes since v4 [6]:
  Patch 1, 2, 4: Fix commit message to reflect the new header file names
  Patch 5: Remove extra blank line

[1] https://lore.kernel.org/all/20260721195633.1438361-1-kameroncarr@linux.microsoft.com/
[2] https://lore.kernel.org/all/20260609181030.2378391-1-kameroncarr@linux.microsoft.com/
[3] https://lore.kernel.org/all/20260625173500.1995481-1-kameroncarr@linux.microsoft.com/
[4] https://lore.kernel.org/all/20260721201148.1441143-1-kameroncarr@linux.microsoft.com/
[5] https://lore.kernel.org/all/20260923140405.1111554-4-aneesh.kumar@kernel.org/
[6] https://lore.kernel.org/all/20261001220552.1793471-1-kameroncarr@linux.microsoft.com/

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
 drivers/firmware/smccc/smccc.c    |  41 +++++++-
 drivers/hv/hv_common.c            |  17 +++-
 include/asm-generic/mshyperv.h    |   1 +
 include/linux/arm-rsi-cmds.h      |  22 +++++
 include/linux/arm-smccc-rsi.h     |   7 ++
 8 files changed, 244 insertions(+), 41 deletions(-)


base-commit: bce57945f5e7207960b2bd567a6e880f90258ffb
-- 
2.45.4

