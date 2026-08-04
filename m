Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050D53009CB
	for <linux-hyperv@vger.kernel.org>; Tue,  4 Aug 2026 19:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785870329; cv=none; b=ljMFgb8uTuPBIy8lH01m/6oxrx+3fRPgzsUQINi/bvhmShEQpIlxr3HHT7Fbl+mhITDvNKGAeZu8cbMoY1KA4HcqU7LVVm8XhxlesPGl88IZOS8kb6ULGObv1rzkqpc/D8q4OxPq+83QFBTwWLdcKAyAW2K5btSFP3sFL70N/So=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785870329; c=relaxed/simple;
	bh=qS2uK6gYq/TJZfonUTybYN1+YgHn7HcsyyB7PGtzfrQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vmil0o7OEoYeqZU+zEyRecBxxAOU/U0b2Vm7pzSjxzLVqxauo/cPVmUYWEkoZtHj9LIMhsVS3hCBSd9DPY52Rvy46updaGKgbjCjPNPDvCr09tiYD4ZDdH6GIH8isziaWvKcj2C3e7HwlDbX8pnyYlWqJTES4gJDJO/s2e5FaxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TDc0VobP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TDc0VobP"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84e507b079dso135352b3a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 04 Aug 2026 12:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785870327; x=1786475127; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4OCm7hMG2uL3Ch+dyCwwgy/siQwC2sEO4cWQGHy38A=;
        b=TDc0VobPNzPLq7pKWp85bHuqmbNWv8A+OgAaw9fPwj8apGGD2PHQM6cNcDQwMBOQL+
         ScbP9a1oz4nvBTObfXChoU7YcSZyrl/fR9IS8HIhf3n43QSVnB+iBAMmKQR+ousCBoPf
         AvyjenYPgAr+sKkDjJjylPjh6iWPAdWYY3chJY6DFz21v7b4lkloDSUf4qL2zEOnDceR
         NALNLGEr5h44Vlh+woA6Z6A7byv7xx1ptLSet9MbpHK+qB2M7u/PymofnBe3HFy7i6Tc
         RrAAwq/eY7Hgyd9me9MDlWPC8umtAvg/5nStInK7kYIV8HWIr78xjJTysFxgCtR9J6Qi
         OFUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785870327; x=1786475127;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V4OCm7hMG2uL3Ch+dyCwwgy/siQwC2sEO4cWQGHy38A=;
        b=N+IQFlA6dfpRNtAQ+BD7KI5vrO8Jc79Aeaz2GSXWjfjjfwUW4ugINaVoJZHowTuJuJ
         pgs8BjIlI6PfsYmmQYmHuxEh3zF5Nv+5lDHFv5xcPb6pAFCOk8yX/8lnHdJpfHmTM3K0
         GArecnEd8+5VmOXlBDBWLHXZjq1/6cf5V8lnq3/2V4OZGm7x8trk8G3QJ4A6d6M78YWT
         e8/PpquXo1pdprFcZxxFCeLdhKHUa2Po/uPHVvcVk/xCd98Q3+iqzyy39YkieLF9kSoj
         PTxBI8oy7dFFn+tA7Gex/btlmcswicnKxisFYpTpR+rA0+Kxk062bKvNXDD7XMd9EOWD
         Ro0A==
X-Forwarded-Encrypted: i=1; AHgh+RoEVDjKK+hDI99ewqkppfNmNx4sqBZCXREUXjFLL0DrtTymkfKjhkzpyx4rAmZ4cgGEnkqi9crvWHoC+c8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdESo7VNDx2RSva2NotMdTF7/HbkPnQVi5R7UL5uk90MLZulrN
	MpLQCgu+gWBFRgyQwzJYsTaxOi7E6O1m/9PEfGULGYVYqikWqQw3kWqC
X-Gm-Gg: AR+sD10td1H8P6B7WZNdvmbayRybicZmNxOtWGSVqRZTXZCwNpJQEP7e1UlzdKOdqiL
	6dQunp7jkGIBJPexT8OHbrtnvoTiDkh9EJ9JKT/WqqlLU5K6BXBN1ZJG4N1Vv0XtU4l/Xej65xI
	svBNK4bAg8ArpNRGD/V48hwOHaqPzQcfeLQ/BnLNBWyD64lGGMFlHYy2Xv8DWZf1G+67IpQV54v
	Ow9EVc8QQ1NiRT0sFNDjjlnFo3u0xJmAwPYPS/CrImhHyzYa6HEz0AzITTJmlh/LypbO0ObtPL6
	hK7Nqm6ODbdGmcVpIUgDNWk//KgaOKC3zLE7bBMWqxOpTrry+7WJxMhlq32ZpzICrXBhHIZ/PGE
	VBbQzAzSotpAdAnzCPEVIyXoFlPxGLY9EAnIXB/s/YJtmM+RWH7SKQPlAZoOpP1+gzvsJRBa3Xp
	t6g8Q9pNUjndx6BIIiQgOKgjCxx6lGa8yJUy8b5l95KPASlnTKAbuG0oYg1Z37xNLpW+whLlLge
	Lm27EDxl3gMVaeroSYphptj6gppTJbate/vTOrezMg=
X-Received: by 2002:a05:6a20:734c:b0:3c4:1c9f:d7d with SMTP id adf61e73a8af0-3cb8600ae1dmr632312637.46.1785870327231;
        Tue, 04 Aug 2026 12:05:27 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe708beae5sm158788a12.18.2026.08.04.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 12:05:26 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Drivers: hv: vmbus: Fail VMBus module init for non-nested root partition
Date: Tue,  4 Aug 2026 12:05:17 -0700
Message-Id: <20260804190517.101981-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMBus module should not be loaded when Linux is running directly
in the root partition and root is not nested in another VM. Current
code checks this condition and skips VMBus module initialization, which
works. But it returns 0 as the result, so Linux thinks the module has
successfully loaded. Later, if the module were to be unloaded, the
VMBus module unload code tries to clean up things that were never
initialized, resulting in memory faults and a panic.

Fix this by having VMBus module initialization return -ENODEV for this
case. The module is then not loaded, and the unload path can never run.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index e19ec73b0187..849d7e1a7320 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2976,7 +2976,7 @@ static int __init hv_acpi_init(void)
 		return -ENODEV;
 
 	if (hv_root_partition() && !hv_nested)
-		return 0;
+		return -ENODEV;
 
 	/*
 	 * Get ACPI resources first.
-- 
2.25.1

