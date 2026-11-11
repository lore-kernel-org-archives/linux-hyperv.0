Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363645;
	b=T6Edwn6IFa8v1rBAyqmdVtaEh3XeI1w70sYnm5gSAiia+kbv3pamzmPZLw2A4AaDtwRw
	 1Trgk+hZmkc4b6kepXJ8IbFxo7WQYOiA+tNwhlwQCWWN+iq7w6RpT7f22C5erkpn41BrJ
	 fjCl/7pnLHO8rr2Fsk9RUGnchGdI59mhLw41jkfv2iotgHejvYeccr3sBBUgIiuMIHZjD
	 gOTT40bu7s1HcwBmqrEzkjoQOHwnWH4Qeg/doNhJD7qRYDp+SURCI7kDWUK3wu0+OFmQp
	 bBplxkAbdhWezAiyADrf9hAwx4LOHSMHRlbtcX2Jbq8WPS1IMbyLLjB6LNMdvZtPysQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363645;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=Ec4GAAhrJJvu8Dnnjhq4YjXEucno6/Ltfmi0jA0uQW0=;
	b=llvxUFgC+78phGHEo3MTC7zmbthKzA3Pa7Lvt7KV0zBgmfOolLtlTWLBkUM5nIruSCzh
	 1M9PTNig2ilaxWJ1KKeTLliDJuUTVFAJEFABWrPjqacks5XbciZgMqA0Ci+3CNmwEVkkT
	 Zs6NozL7QpQnblkmbUALTM3vSticfgdwstQZY9anduP/irbuPWN+kU7HwnBL++Vy9yVv1
	 dMYmB8gOq77mXRRm/9AiHYYSwIfjsscCKMUUiNJUqITRZL/+67IQHxXdPyK5AHlm98RCh
	 0NCl20IhaXsmNCrzxRchss6Ie2G014xAY3X1fcA7FndC1nkQlNp0Jbf/Ytl/uZVbWkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="nS/NhTpH";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B205A606A31C;
	Wed, 11 Nov 2026 02:20:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B205A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=nS/NhTpH
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 282B320B7168;
	Tue, 10 Nov 2026 18:20:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 282B320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794363641;
	bh=Ec4GAAhrJJvu8Dnnjhq4YjXEucno6/Ltfmi0jA0uQW0=;
	h=From:To:Cc:Subject:Date:From;
	b=nS/NhTpHDqm3arpghA++Bm9N30esdWFiF/j+T1bMItjUOSrUdEpZrbWEgtb8ouZMG
	 dzIL+5E0dgU4zOQJPfpmFUoaX/goCKUjeaXFvRcnLi5V+kfkeaZCSkD8FaBu9iQbvL
	 9tlkRMo9LkHWeO3YOzYSg4hLp/offQGb95i40iIE=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH V0 0/2] Hyper-V: Fix bugs and issues around repeat hypercall
Date: Tue, 10 Nov 2026 18:20:34 -0800
Message-ID: <20261111022036.351231-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This short series addresses few issues around repeat hypercall, most
importantly the bug around not checking completed entries in case of
failure. 

Mukesh R (2):
  Drivers: hv: Add new function hv_isolation_hw_cvm()
  Drivers: hv: Fix bugs and issues around repeat hypercall

 arch/arm64/include/asm/mshyperv.h |  1 +
 arch/x86/hyperv/ivm.c             |  7 +++-
 arch/x86/include/asm/mshyperv.h   |  1 +
 drivers/hv/hv_common.c            | 11 ++++--
 drivers/hv/mshv_common.c          | 19 ++++++----
 drivers/hv/mshv_root_hv_call.c    | 21 ++++++-----
 drivers/hv/mshv_root_main.c       |  6 ++--
 include/asm-generic/mshyperv.h    | 59 +++++++++++++++++++++----------
 include/hyperv/hvgdk_mini.h       |  2 +-
 9 files changed, 87 insertions(+), 40 deletions(-)

-- 
2.51.2.vfs.0.1

