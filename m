Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A4F29AAEA;
	Fri,  9 Oct 2026 05:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522368; cv=none; b=H/H/TCI8JB+iKIcxx3+YaF4spdopfeGBm+BAwZu1m8HzUMVmvSR7hKOqYRoiN+/kDiWQTtcMzypKTltGcE+QJBUhA2zPswCWqfihthcM6P049t/digW+9XP0DccLPc0SnDIV5MBxpz+OwLZjyill60vVBr0fex8Bv/p0Djgn35k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522368; c=relaxed/simple;
	bh=I5I1a96iUXq92TXMrwLibYLvQ0pPbbUE7YE1153Ej4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fObrqTSY8HOwcvJcicwDdIhXLbsbwMgcp0tMVxYETLZnUxgVFyQBJznvcU4uKU21IbnBIEpWWvmjjOX1E7zIczmpXhSqsTC/Xq2s3JOytjbqlhUz9/ceoPH6kkPsfJHS8Rp05ek+EghjZQwt965+/LEcizKTlRCulokC9s0gCkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KLsXUZDP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KLsXUZDP"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B78620B7168;
	Thu,  8 Oct 2026 22:06:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B78620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522365;
	bh=krzHIwcfibK7gOF4hb73/webqprmVFn/kkFH14YrjSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KLsXUZDPoBCSEy8wG/u7gjXtLG2ECC5KTYBGZg0TxWdd03KBPFWXQHyxNys7PLSWG
	 +wjGNPzIVNkkiUCDgNlAaHWYBP5pBXjUQvdZasP7wt78xwrZ0yuZm76GpK4tzfR/bO
	 8nnshNNyrkdqeS2WejN6dJq8XdlKoJPQdMjEJUrw=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 1/3] nvme-pci: select IRQ_POLL
Date: Fri,  9 Oct 2026 05:05:54 +0000
Message-ID: <20261009050556.2817978-2-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261009050556.2817978-1-namjain@linux.microsoft.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A later patch uses irq_poll to process NVMe completions in bounded
batches. Select IRQ_POLL so that support is available when the NVMe PCI
driver is built into the kernel or as a module.

Assisted-by: LLM
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 drivers/nvme/host/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c9..22164b901da85 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -5,6 +5,7 @@ config NVME_CORE
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
+	select IRQ_POLL
 	select NVME_CORE
 	help
 	  The NVM Express driver is for solid state drives directly
