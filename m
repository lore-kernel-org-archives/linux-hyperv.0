Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDD6202976;
	Thu,  9 Oct 2025 16:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760025918; cv=none; b=PAhuGa2PbR7PpLMqo7XvO+mftcJgNsugARlzB2zE413I5m1p6bfXR/EcGQqaOYBqQdtT0XAEsorZllwVqWb/EVPGuqW0kryxotm4rEx1QHdFSnfsiIBAqvB4Djb069j6toCaYduUVyjmibyQaa3q0VTJ47a7DLpAGx0SRqup3XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760025918; c=relaxed/simple;
	bh=ZSv2zS+g76ID43d0Lc8Mh8gop1IY19oNgkdlP5TN/Tg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m06388PT67pob8Pljcc+OGHSH/l3s7h9P1VzB02kxx855B1h5h1ww4STXfIL++MJC8sZJwpTLwaK/TcC6xJHjotROAAMU7l4x8BszBHI7VpdllUnge8mh3vQg++71nznXQvkxHizTieenQWwfDDcvKXmQHnKzzVTU0juYSLC/Qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nDQns3t7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nDQns3t7"
Received: from home (syn-072-191-074-189.res.spectrum.com [72.191.74.189])
	by linux.microsoft.com (Postfix) with ESMTPSA id BD4DD211CE0E;
	Thu,  9 Oct 2025 09:05:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD4DD211CE0E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1760025910;
	bh=3CcayQJwYTqP1BYZ+NmvsUILe24zZrmyJoTdpIMw/KQ=;
	h=From:To:Cc:Subject:Date:From;
	b=nDQns3t7aJwhO2EhuEZxZqgH3CAdCi5MY5+P8KglPduLeDbbLOqeC1mMK8YnTbSI3
	 Erc1P1oQxFEk0OppWOihQw0SgWW8q6GJUGKlp57bdj+G5j54yVeaXCMg4ZYA7+Fsnd
	 hCayFAffhzRUO96cBcNsIVHPAXzP5Do7DtXIrfzA=
From: Praveen K Paladugu <prapal@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de
Cc: anbelski@linux.microsoft.com,
	prapal@linux.microsoft.com
Subject: [PATCH 0/2] Add support for clean shutdown with MSHV
Date: Thu,  9 Oct 2025 10:58:49 -0500
Message-ID: <20251009160501.6356-1-prapal@linux.microsoft.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for clean shutdown of the root partition when running on MSHV
hypervisor.

Praveen K Paladugu (2):
  hyperv: Add definitions for MSHV sleep state configuration
  hyperv: Enable clean shutdown for root partition with MSHV

 arch/x86/hyperv/hv_init.c      |   7 ++
 drivers/hv/hv_common.c         | 118 +++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h |   1 +
 include/hyperv/hvgdk_mini.h    |   4 +-
 include/hyperv/hvhdk_mini.h    |  33 +++++++++
 5 files changed, 162 insertions(+), 1 deletion(-)

-- 
2.51.0

