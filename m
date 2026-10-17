Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683C3F54A4;
	Sat, 17 Oct 2026 06:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792219416; cv=none; b=aPATpk/9QLutl4+kzBmnfUnipX+wTF8Lqtg6TBm8+bNpnyrDIdU46rHU080Dk4qIA86/yzKTvg+sv2LMnCUWyg1Dq0gaaRBWF5SzYAFz2ydcHj3vZq6tUxs5mJD7ghldOWbZcdk+NrG7fo7GMKaNPr7TsZZlmhjPb2TifhPZAgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792219416; c=relaxed/simple;
	bh=b3tMaiQ2hssYNI+bMQ2eb374esrnSRoI/O3Rx8o8sYQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cYlWjzlG/amb28bylbwu/fD/c+j9mF5anOOMq3tyG7sG7phEVnxdcgAsBxQNFJ6Qdifx3dEo41NvFqG4gpDeWpZeXdhcJ24xYpNnuOy/r+8q6tyEpQWasUDhPbEIF6O1Lu/sgKUs38HtPiku+JVQogiHoK7lcrPOHjKoYhsYBBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Sy29U7YI; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Sy29U7YI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=IU
	rSoz5pIgkZqxQyx+MI0UKsAu+MTHdaY/fV5Q5UcgY=; b=Sy29U7YI1BqKTkRKtz
	oBUoO8AO00NCjl2xDKNHlKLUD9pflkauzhQfGNs25YxFdm11AxakTbJV/ErG8dhK
	toj7am2XbefriCONqeY5+hXwDd0+g/aVyr4dwnBEljb4xgi7Cl4iJkX4OErQuZWd
	X2HQXIZlxZ3NrDZeiWWpc9LAE=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wD3fxYDGdNqY4zXAg--.20256S2;
	Sat, 17 Oct 2026 14:43:16 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] Drivers: hv: vmbus: Check ACPI companion before use
Date: Sat, 17 Oct 2026 14:43:13 +0800
Message-Id: <20261017064313.3816553-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3fxYDGdNqY4zXAg--.20256S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF1rJw17CFWrAryfWrWUCFg_yoWkGrXEvw
	18urZrWr1UCF1rKwsxGrnxZr93KanFvr4kWr47t3sYy39xWwnIvr4qyw17XFW5W3y0kFn3
	Z3WDAr4fAw1xujkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRiHq27UUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC7wTWEWrTGQQtHwAA36

Platform drivers can be forced to bind to devices outside their match
tables through driver_override. vmbus_acpi_add() assumes that every bound
device has an ACPI companion and dereferences it without checking.

Return -ENODEV when the companion is absent to avoid a NULL pointer
dereference.

Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/vmbus_drv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4692687cdbf3..28f459679406 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2571,10 +2571,14 @@ EXPORT_SYMBOL_GPL(vmbus_free_mmio);
 #ifdef CONFIG_ACPI
 static int vmbus_acpi_add(struct platform_device *pdev)
 {
+	struct acpi_device *ancestor;
+	struct acpi_device *device;
 	acpi_status result;
 	int ret_val = -ENODEV;
-	struct acpi_device *ancestor;
-	struct acpi_device *device = ACPI_COMPANION(&pdev->dev);
+
+	device = ACPI_COMPANION(&pdev->dev);
+	if (!device)
+		return -ENODEV;
 
 	vmbus_root_device = &device->dev;
 
-- 
2.34.1

