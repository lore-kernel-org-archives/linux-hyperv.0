Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB2A43302F;
	Tue, 21 Jul 2026 19:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784663850; cv=none; b=IxISabgGVZFLBZUCdZJbsaETJNxMBjaDyP5zLvtHPs9AIcG+REeYQznub/9AOgOneGR7qrdYp31ZpYEFCpflZt819Fuj4ZEQ75VSlIlq2/36cVrKdiD0pPgLmarqMUmF+gXpY4eo4cpdSj150deI1uysFt5NacLuXVP44tHjOVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784663850; c=relaxed/simple;
	bh=85dA4YF+6T48pApNEqGznldI8haocj28NCxwqBd7YkI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WX8GiTGSbTSrOj9W9Wv+DPLU+iTVej80FD7gEH2T0ROxODLCGIUJkO8UqGKMqrkQKbyoyBhfCgYW6z6CRXTh5Ijzx4aPijOE4ANBnSVmYnTV0ioGJs8cPLLmdMlsWMqE2JSxDGyFV5ireyjfq2nCUFHq91ynYvcpwn0SD95E4rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Clb+vsvF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Clb+vsvF"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C0E1720B7167;
	Tue, 21 Jul 2026 12:57:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0E1720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784663836;
	bh=0OusrG4o9Ol5JVs1frcLPNp+F+puuBfSAwB+jNOs+WY=;
	h=From:To:Cc:Subject:Date:From;
	b=Clb+vsvFBMpZE4s71upEYorgoi1XOZ6Ev54PXHDhVaHhQQ8Ej/j6AkeO081drAvBg
	 MNtGvAHHFeR9EREMdvKnZcnq54vyg6U6Ri+hh2s/yyGj9jzWyquzq0EIwfbCr4BkHo
	 L0Sg8y3sqKeNrA5Vzh8xZsaEqYKGylughqjSLEVk=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	kys@microsoft.com,
	longli@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [RFC PATCH 0/2] Drivers: hv: decrypt netvsc buffers on contiguous direct-map addresses
Date: Tue, 21 Jul 2026 12:56:31 -0700
Message-ID: <20260721195633.1438361-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some confidential computing implementations only accept linear-map
addresses in set_memory_decrypted(); for example, Arm CCA Realms reject
vmalloc()/vmap() addresses. netvsc currently allocates its large
send/receive buffers via vzalloc() and relies on vmbus_establish_gpadl()
to decrypt them, which fails on those implementations.

This fix allocates the buffers as a list of physically-contiguous chunks,
decrypts each chunk on its direct-map address, and vmap() them together.
Here netvsc fully owns the encryption lifecycle and the vmbus layer must
not call set_memory_decrypted() on establish or set_memory_encrypted() on
teardown.

Kameron Carr (2):
  Drivers: hv: vmbus: add vmbus_establish_gpadl_caller_decrypted()
  hv_netvsc: back GPADL buffers with kmalloc + decrypt + vmap

 drivers/hv/channel.c            | 123 ++++++++++-----
 drivers/net/hyperv/hyperv_net.h |  18 ++-
 drivers/net/hyperv/netvsc.c     | 271 ++++++++++++++++++++++++++++----
 drivers/net/hyperv/netvsc_drv.c |   6 +
 include/linux/hyperv.h          |  11 ++
 5 files changed, 354 insertions(+), 75 deletions(-)


base-commit: a4ffc59238be84dd1c26bf1c001543e832674fc6
-- 
2.45.4

