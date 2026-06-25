Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337683ED135;
	Thu, 25 Jun 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408907; cv=none; b=GlBZw3lKG997DadacBaL2pgxOqNzMosky6pvw9LKK01GAaEz2j/HWlqcObM2EefxAlY/CbERfLTWU3youH8QbpgAodHQOcMihr2FDXMI8RizeXLoQWrx9jSzYI/I4RSBBTYpUa4OXhW/kI4F/7sZCCw8MbaoVoWg5oUjwrHWNsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408907; c=relaxed/simple;
	bh=JYWvCMIuiuJSlHm3SgpwnMmRMLPNJ6XWNO6s28ejWO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u8l3ayOtvP+tXwhQawiqgaBwUwH599mZILS0BABUqY2sPNMioCK40e/+YfeGar3a6nIl8La4BUg8N+nB51m07UfCKxeo6Nt1MEE9SI9mawNajl21jNHbbP5PI4WKEE1uQJjyT1pfJ6J/zuaehFeiafSQBCSuwtlYNEMxW+GqZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=eK3igkyL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="eK3igkyL"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1B0420B7167;
	Thu, 25 Jun 2026 10:35:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1B0420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408900;
	bh=nohWA6Z3QOs8Euk83tp6VSWyE7ASO/iSFcpEAB1p3Gs=;
	h=From:To:Cc:Subject:Date:From;
	b=eK3igkyLatBZ6Tk0y7WVi6+UeBtq5AXuE6onb51ImsVboRJaZbX9dPtZvW2yEgJgd
	 EHMc4bljt1luJvOB8uTWVADhy3oWB+vauUbKMO6NwyBL/PRm+TYrFEPGPJOPlxPJEj
	 TFFTc8l7mX2H9x+KoW16zMM245E89V0cVM4ZEJCg=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
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
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [PATCH v2 0/6] arm64: hyperv: Add Realm support for Hyper-V
Date: Thu, 25 Jun 2026 10:34:54 -0700
Message-ID: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
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
decrypted. See my RFC patch [1]. I will implement the accompanying netvsc
changes based on the feedback I receive on that patch.

This patch series was tested by booting a Realm on Cobalt 200 running
Windows. I decreased the buffer size and used kzalloc() in
netvsc_init_buf() in my testing as a workaround for the issue mentioned
above.


Changes since v1 [2]:
  Patch 1: Add explicit padding to the RSI host call structure
  Patch 3: Change from a per-cpu pointer lazily allocated to an array
             of host call structs indexed by cpu id
  Patch 4: Align input_page + output_page allocation to PAGE_SIZE since
              that is the smallest unit of memory that can be decrypted
           Remove KSAN tags before passing address to set_memory_decrypted()
             since __is_lm_address() does pointer arithmetic.
  Patch 5: Add a helper function to reduce repetition
           Check for NULL before indexing into host call array

[1] https://lore.kernel.org/all/20260521205834.1012925-1-kameroncarr@linux.microsoft.com/
[2] https://lore.kernel.org/all/20260609181030.2378391-1-kameroncarr@linux.microsoft.com/

Kameron Carr (6):
  arm64: rsi: Add RSI host call structure and helper function
  firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
  arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
  Drivers: hv: Mark shared memory as decrypted for CCA Realms
  arm64: hyperv: Route hypercalls through RSI host call in CCA Realms
  arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms

 arch/arm64/hyperv/hv_core.c       | 155 +++++++++++++++++++++++-------
 arch/arm64/hyperv/mshyperv.c      |  42 +++++++-
 arch/arm64/include/asm/mshyperv.h |   4 +
 arch/arm64/include/asm/rsi_cmds.h |  22 +++++
 arch/arm64/include/asm/rsi_smc.h  |   7 ++
 drivers/firmware/smccc/smccc.c    |  41 +++++++-
 drivers/hv/hv_common.c            |  17 +++-
 include/asm-generic/mshyperv.h    |   1 +
 8 files changed, 249 insertions(+), 40 deletions(-)


base-commit: a4ffc59238be84dd1c26bf1c001543e832674fc6
-- 
2.45.4

