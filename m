Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B7ED373C0B;
	Fri,  3 Apr 2026 08:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204958; cv=none; b=AnVLYT7/kXvfxMLjnBroMfCeFquSBhoRflHA5mgLaabBbRFBtFQ95KZ62eQXCrBe9qT/T5QHZ/uBZFTyvJ481WkFbbPv3F71iAqykdXtIw1CIHc30olay5Z7O8Vgq21f1b+XLzK2Dm/JHKJe20/Wb6ZMk0wTbmdYMqI/VVe83ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204958; c=relaxed/simple;
	bh=DFj6+xYvOya9ETWJlCIvTlaFBNztC9g7Ab8bapUZZD8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IVWIdzxNMbICqZ0oih1B4XAgCrg+pu4V85pdySL34YSyWUSFPDBT1t3v+hrHZstDk2GcBDIEwcvYXD6fHmiOiQdyHAXLK5idX77nRtFgyS8A2BiJha3oOixO28eFNvC/R0jv9CSOGB3EOk7R/xyR7u64U+EUV4gmZ8PiK9rJffE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=TPUAChNj; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="TPUAChNj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775204954;
	bh=DFj6+xYvOya9ETWJlCIvTlaFBNztC9g7Ab8bapUZZD8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TPUAChNjqAbKCw+lDG2zqeKygn6a3omK47VNjKmMDthHyCOnRKH/Obul6yU5YyFqT
	 /croBt5SCYZVji7O5N6SiWvKFt7fFevGS+HX2TcSjqQiRU91VXcHzj8P/9JL/hREap
	 EllCHbmAJandxrWU4vy9NVsvb1W9NUpVFxUPJXo4=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Date: Fri, 03 Apr 2026 10:29:13 +0200
Subject: [PATCH v2 1/4] drivers: hv: mark chan_attr_ring_buffer as const
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260403-sysfs-const-hv-v2-1-8932ab8d41db@weissschuh.net>
References: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
In-Reply-To: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775204954; l=1073;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=DFj6+xYvOya9ETWJlCIvTlaFBNztC9g7Ab8bapUZZD8=;
 b=1mrJldI0HGP6Ktb8gmkkt51osKboLt0NrOoMEHtX/u4cMLaM3os6sRG2WScTQnVs1O7wTuTeN
 KL+IgHuOJ6wC3kyaDGXUh/TnmDI5lhC7TXp2cxEpfMdzLjFm7H8KIzX
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The structure is never modified, mark it as const.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..5f9b7cc9080c 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1959,7 +1959,7 @@ static int hv_mmap_ring_buffer_wrapper(struct file *filp, struct kobject *kobj,
 	return channel->mmap_ring_buffer(channel, vma);
 }
 
-static struct bin_attribute chan_attr_ring_buffer = {
+static const struct bin_attribute chan_attr_ring_buffer = {
 	.attr = {
 		.name = "ring",
 		.mode = 0600,
@@ -1985,7 +1985,7 @@ static struct attribute *vmbus_chan_attrs[] = {
 	NULL
 };
 
-static const struct bin_attribute *vmbus_chan_bin_attrs[] = {
+static const struct bin_attribute *const vmbus_chan_bin_attrs[] = {
 	&chan_attr_ring_buffer,
 	NULL
 };

-- 
2.53.0

