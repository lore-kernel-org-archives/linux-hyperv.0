Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2932D46DFF3
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Aug 2026 14:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546384; cv=none; b=JTeFBVhzRLDjacvbdyzHdsAtzn4MaSqUr8V3gnuBSuhm6GSbtzxMU0MbPzf1p06iaXIHYwC6y5IBwl3bSZU7W4AiB8GBz1REvgx3dl227i4RdiM2Yci88AWxUtyvNmxuWoidJtPTur/fc09OE60EPIUbCRHkw5M3kzaAeXlbsfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546384; c=relaxed/simple;
	bh=BgxGmF/gEVjhGh2kZVcaq+xYjvvkScCWLA+i0CJhRdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Or6owIlEsE8TAGCsmtYAO2ztK/2ZlH1XvGu+VKMkNVg9pNSshRFqpvq0GBGtOQpJ7/maOPTvmE3kdwLyNorlDdAhaYylq8kLJUrZt9pMUW24uZMEZo9HWEpBl4cdGSkhPyn34e3mwZTXNLLiQmcXXC35AjElKBykJWRb1kOb86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YD0ETkPY; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YD0ETkPY"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso778275a12.0
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Aug 2026 07:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786546373; x=1787151173; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WWBBeOrxKs82FFOYNNbA/6UdKGIQh+oHC8GNFO/oR8k=;
        b=YD0ETkPYojKmBHOG+fCyxM5WjDeQqlYA88SVxjkgWOPcHOuDB4GiFZGnLLPMvnsx3f
         IJXZp9YEFdKbCWXHI7U/TNKU3AODkzhlZ3tsK7C3pwh3MsxIibfUgrKKMDLy0jmaWwBa
         RkyFLa8ZAs/i5WicyUuQjYtjLGt6l2BeWcf/sXaVPZiLLE2diiIObsD2tORSvXW7GY5b
         B+kPWyWG2HblFLhlk9dFzrTg41z3khOSLStqPP8EV9+4cPPHq1HCUEHzeuvs2PoBdwrK
         xNtSN+Ra79aX4t5Y3CebkS6EsviQb8z8EXJt6Ties3Gv/QkJSP7NT8IeuyaikJiIwGbV
         VvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546373; x=1787151173;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WWBBeOrxKs82FFOYNNbA/6UdKGIQh+oHC8GNFO/oR8k=;
        b=gJztlWFTw0gcT1N1HnxELkQDbcxOEbn/En+K0W0dvCALxxyUGpM8DBAeUXPdG4t87D
         h6jMOt4TGS+WlvXICzKXdsbNlSfPCxXQ4WGvhVkWPvZIHje0rFV/pmpEk2q2HmaM7Aaq
         fA5yFX5MUXaah5gUPrD0zoAfXkXVWosWydHe0uQ2KPwUoe4EKC6Vss44I92zynPCQTE0
         6DcdNfuJhC3T2lg5DlbD9Mo6lvBvvJUkzyyG6nxOghSsXvL0s2tYDYxocVL4Ulk5fvAn
         t5+XInCNxmxFm7vJYre3AphpTdg2ysdfmX0w4kQnY/YOw6Xu1pNhJZw+i6znZB+IEB/n
         ETFQ==
X-Forwarded-Encrypted: i=1; AHgh+RpU+2GSrowiQIvo9nHrFt85Jtq9zvzKW17VRHj2xSDpw/nBdoiFAIE3T+nfwD9AvK/KmaNUTi2LA2C3wNc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3SX06ohkMhtWryVGbSUpJG3LwBsPAeNOXZjTpJiUnUuhlVVjy
	hOYP0zKv0nE8WEOjX0e9J2/ydjwyYi4Gc8lndcPu33iKIKnH7bAJ4kCw
X-Gm-Gg: AR+sD1002qQ28QhxIF+lH+JN98KRyuIX5AlTRA7tWsVCiLwyJ5SY8fleHs26As1ekHW
	3bYAC3uGtXQClJdL6udnrLSb/xU44RZdcJ3s1Xw1Hvg/ZVBZ/V+QuZguAQN1uiBBhCV7IA2TqM+
	MhEy2L70VSybnj3MM/XsUgsIzs6wqyEIQdPyaNCtsCBj7iDnQPqo4J2IUKvnRKFhgml1HtblOhj
	5UjAxWMxF4ndD0rezSZhh57LXOlFGCFTjlerdEmTX4gbweyzM9RkU8HQG5aBbjMGkNbzW5+lzSy
	Azwd2Q4t/iIeYpoEbVzZqL6cvU8NrPL/SVjqmlFEASTvvG8T/xLIw03Rc/zPYVaJqGaDDuhtOlM
	QcEQdvOHHEoDMBg4J8EnhmbKXYJ327awcSZ27RqsCm6wiAaMfHvhCUdWqU6KzWbct/aNeWVOJV7
	GuPFwXqGnd25Ga/3+uQZ1xxv/sShHo0KIcGYTI+oKXNoUxvWsxRoWjGFeTsPiKhNK0/JYAocSeD
	cM2d81MmEfksVqvU3bxwSArDe1cFluKG35d1fm8qw2iyMhEYZeDTA==
X-Received: by 2002:a05:6a00:148a:b0:848:700d:c950 with SMTP id d2e1a72fcca58-84fb55bbb9cmr4903182b3a.37.1786546372718;
        Wed, 12 Aug 2026 07:52:52 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fb1cf7fadsm1191885b3a.7.2026.08.12.07.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:52:52 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup for non-nested root partition
Date: Wed, 12 Aug 2026 07:52:23 -0700
Message-Id: <20260812145223.85949-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VMBus module initialization function, hv_acpi_init(), currently
does nothing when running in the root partition and root is not nested
in another VM. But the initialization function reports success, so the
VMBus module is indeed loaded. VMBus functionality is not actually
needed, but the VMBus module must be loaded so that hv_vmbus_exists()
can answer correctly. Furthermore, the mshv_root dependency on the
VMBus module is needed as described in the commit message for
840b740a35bf ("mshv: Add conditional VMBus dependency").

Loading the VMBus module without actually initializing it causes
failures if the module should later be unloaded. The module unload code
tries to clean up things that were never initialized, resulting in
memory faults and a panic.

Fix this by having VMBus module exit function perform the same
check for non-nested root partition, and do nothing in such a
case, just like hv_acpi_init().

In the long run, the code that manages the Hyper-V provided SynIC
should be refactored to better coordinate the requirements of
root partition scenarios and normal VM scenarios, and to hopefully
remove the hv_vmbus_exists() dependnecy between mshv_root and
VMBus modules. Preventing the current unload failure scenario is
an expediency until such a refactoring is done.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
---
v2: https://lore.kernel.org/linux-hyperv/20260805142421.104797-1-mhklinux@outlook.com/
v1: https://lore.kernel.org/linux-hyperv/20260804190517.101981-1-mhklinux@outlook.com/

Changes in v3:
* Add code comments in hv_acpi_init() and in vmbus_exit(). No code
  changes. [Easwar Hariharan]

Changes in v2:
* Use a different solution: Allow the VMBus module to load but have the
  unload function do nothing for non-nested root
* Change the patch Subject and commit message to reflect the new approach

 drivers/hv/vmbus_drv.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 6824bd7cb3c4..18ee549d9880 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2982,6 +2982,13 @@ static int __init hv_acpi_init(void)
 		return -ENODEV;
 
 	if (hv_root_partition() && !hv_nested)
+		/*
+		 * A non-nested root partition does not need VMBus client
+		 * functionality. However, the mshv_root module may have
+		 * a dependency on the VMBus module as described in
+		 * commit 840b740a35bf. Return success so the module
+		 * loads even though no VMBus initialization is done.
+		 */
 		return 0;
 
 	/*
@@ -3030,6 +3037,14 @@ static void __exit vmbus_exit(void)
 {
 	int cpu;
 
+	if (hv_root_partition() && !hv_nested)
+		/*
+		 * If a non-nested root partition loaded the VMBus module,
+		 * hv_acpi_init() did not do any VMBus initialization.
+		 * There's nothing to clean up, so just return.
+		 */
+		return;
+
 	unregister_syscore(&hv_synic_syscore);
 
 	hv_remove_kexec_handler();
-- 
2.25.1

