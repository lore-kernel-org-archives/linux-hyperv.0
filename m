Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C574CF48E;
	Sun, 18 Oct 2026 03:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295210; cv=none; b=ZmnHVvl9tg2x4+ApQRKnH89xpb8335PR7/N0O9jhDGUg1BSSRIDTCpmkmhw/HMR4/gpfUHk+1tByzX+UX6q4TxTmwuXUQnJftO+ih7kGD8eWze/P47LR2xJinj1pqNTVTZwcoCeUhQg+IKLa2NiBrX44GykYG5TXIQ6ie99F/Fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295210; c=relaxed/simple;
	bh=LJDyS37yewZRx1v22+AwoSQHeTLJKv6pM3GpweTz7o8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l0yf+WNEVn/7akHnf5TAJdu/U4xNimho28mHhQ2Q+qz8k020q0T3nPYEqEaFtNeKLGFmn410QRIF510aXjkqOxXUAAEDDAIaFsV/Mixic/ApdWrzMmIZdvyhUBWbKAZd6GfUwIlC/0QvT6CqUdJopsqQFoJHfqHaxFH2rlWmfQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=e79eOkI7; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="e79eOkI7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ao
	cTYe11pbOdAFX39W/I1IMYsM6ydPRQ7LfkVeAA8p4=; b=e79eOkI72r9wjTIVfq
	LwYqFaVK3b36lgwh3L/03wGd9vZ16QemVnNaAXmg0AN3FVD8IQg9qpZkRGiSiukB
	7QQknPG1bE4RUdslaABbct5SzmmVEy6jkOrfV57zB/dTf5Di56aiJxqWOxbMLVhs
	TYuj+ChBl4EfXk0O6w6KmAy8I=
Received: from pc.localdomain (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgDHCJIKQdRqbogNAg--.664S2;
	Sun, 18 Oct 2026 11:46:19 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Naman Jain <namjain@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] mshv_vtl: initialize poll file mutex before device registration
Date: Sun, 18 Oct 2026 11:46:16 +0800
Message-Id: <20261018034616.508850-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgDHCJIKQdRqbogNAg--.664S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFyUCF4kJw4fZrWUAF48Xrb_yoW8JFWDp3
	y0g3WrArW5ta1xAa1DX3WxJFyF93Z7Kay8C34rua409wnrAryqva4UG3yj9Fy0qrWxAF1a
	vF4kX3y8C3y5JF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piAnYrUUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbCzQwjXWrUQQxofwAA3b

mshv_vtl_init() registers /dev/mshv before initializing the poll file
mutex. A concurrent MSHV_SET_POLL_FILE ioctl can therefore attempt to lock
an uninitialized mutex while module initialization is still in progress.

Initialize the file-scope mutex statically so it is ready before the misc
device becomes visible.

Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/mshv_vtl_main.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index d8225242c73f..2b40c9e3bf88 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -95,7 +95,7 @@ union hv_synic_overlay_page_msr {
 	} __packed;
 };
 
-static struct mutex mshv_vtl_poll_file_lock;
+static DEFINE_MUTEX(mshv_vtl_poll_file_lock);
 static union hv_register_vsm_page_offsets mshv_vsm_page_offsets;
 static union hv_register_vsm_capabilities mshv_vsm_capabilities;
 
@@ -1370,8 +1370,6 @@ static int __init mshv_vtl_init(void)
 		goto free_low;
 	}
 
-	mutex_init(&mshv_vtl_poll_file_lock);
-
 	device_initialize(mem_dev);
 	dev_set_name(mem_dev, "mshv vtl mem dev");
 	ret = device_add(mem_dev);
-- 
2.34.1

