Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 248B9331EB8;
	Tue,  9 Jun 2026 18:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028650; cv=none; b=NMGJTR3kwi6ZF7J/3Pws7TsuTVKJF27t0dqMakZr8cSS6UYW8XRLAjxxQlziSn/Q66Q9SkhkLQm4hqbKhN89+FCjhtsDXPZCSnd48b7MOfjAf2IQcHaPFGlOckIpGSX95Zjzsi7Afk6FHezPiUJJpQwvvLZHXJF+q8urdNOxqxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028650; c=relaxed/simple;
	bh=owuM0QZbtkXlCACU618LAWJ8SAeYHBUoFvjzxN+twBY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eN9xAZpZs4TYjI1Ib/GEVbLUz5dTz1e4GgGu64YRgW/YYnPbbjG70KOxx1ju7yZRvqyejiVu3X2aQzKlSkWy0UmFA0rPDS4mvObJnFcarhpCJ5Bu0qZ71ztzYDBhsYgkjTB3GSTOOAaJuN1F+chwzlUqvwL/SH8oTBaC17jVop0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=M7tlh53U; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="M7tlh53U"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AE44B20B7167;
	Tue,  9 Jun 2026 11:10:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AE44B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781028630;
	bh=6DFAB7G1itCWZw/Vj7LMdF5D1S7CykR/gddopXwvBU8=;
	h=From:To:Cc:Subject:Date:From;
	b=M7tlh53UoCFVDin1XTimLOl0D51t5JlWfrI5m/sGTXeFI+iFH4qF8h5JrLIffywFt
	 Vt6wUuwAyaOHP2O9LhZC0h+3LU/UcSOQCvhmzusdBkDkVArSIssc+0Wf7V8OUMm4FJ
	 iLILTRQBihGwoYWBYl6RxHc98PR5FjNZNSw9wNZ8=
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
Subject: [RFC PATCH 0/6] arm64: hyperv: Add Realm support for Hyper-V
Date: Tue,  9 Jun 2026 11:10:24 -0700
Message-ID: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kameron Carr <kameroncarr@microsoft.com>

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

[1] https://lore.kernel.org/all/20260521205834.1012925-1-kameroncarr@linux.microsoft.com/

Kameron Carr (6):
  arm64: rsi: Add RSI host call structure and helper function
  firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
  arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
  Drivers: hv: Mark shared memory as decrypted for CCA Realms
  arm64: hyperv: Route hypercalls through RSI host call in CCA Realms
  arm64: hyperv: Implement hv_is_isolation_supported() for CCA Realms

 arch/arm64/hyperv/hv_core.c       | 175 ++++++++++++++++++++++++------
 arch/arm64/hyperv/mshyperv.c      |  88 ++++++++++++++-
 arch/arm64/include/asm/mshyperv.h |   3 +
 arch/arm64/include/asm/rsi_cmds.h |   9 ++
 arch/arm64/include/asm/rsi_smc.h  |   6 +
 drivers/firmware/smccc/smccc.c    |  41 ++++++-
 drivers/hv/hv_common.c            |   9 +-
 include/asm-generic/mshyperv.h    |   1 +
 8 files changed, 294 insertions(+), 38 deletions(-)


base-commit: 7a035678fc2bdee81881170764ef08a91a076147
-- 
2.45.4

