Received: from mail.crpt.ru (mail.crpt.ru [91.236.205.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1E236827B;
	Tue, 10 Mar 2026 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.236.205.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773133087; cv=none; b=dwgkRA87Hn8fjQFBmPue74gOczRZbPzMWtg7b22GeL71vh/XyJqNICtFruGPh+v//qvlo+IvW+RKmRSxoSWdmuHcplZxDKB2lNF4TUX4Kd9C6wzp3Q335QpBO+h5vcHRmc//zxXb9+YpYy9WNhJQ5aC4mpTzP7wcvL5JSt6b+q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773133087; c=relaxed/simple;
	bh=3RrpRjReVymBfyb4xIdfsZUJ+FK0gTKqmDLRD4gsv5I=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=h4tPC+at4aN/ebY6/WiItnL7aqlKo6PdLoHE38BTYAOCtKO8mswzYZOTCrgghEe9Mdcm2mA35nEQc0EaZwHlIZCzDOQBu+YvXflibNX/ZGgRYcfWTAXuUW7pQUs3S/7fVpeHpHIhokhCaMAlwAPBBjQAEvqj6fjETRgg0L3UIDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru; spf=pass smtp.mailfrom=crpt.ru; dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b=foAtgYpL; arc=none smtp.client-ip=91.236.205.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=crpt.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crpt.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=crpt.ru header.i=@crpt.ru header.b="foAtgYpL"
From: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>
To: "K. Y. Srinivasan" <kys@microsoft.com>
CC: =?koi8-r?B?98HUz9LP0MnOIOHOxNLFyg==?= <a.vatoropin@crpt.ru>, Haiyang Zhang
	<haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
	<decui@microsoft.com>, Long Li <longli@microsoft.com>, Saurabh Sengar
	<ssengar@linux.microsoft.com>, Michael Kelley <mikelley@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: [PATCH] Drivers: hv: vmbus: Fix potential NULL pointer dereference in
 vmbus_acpi_add()
Thread-Topic: [PATCH] Drivers: hv: vmbus: Fix potential NULL pointer
 dereference in vmbus_acpi_add()
Thread-Index: AQHcsGnQcs8U8y7QekevkznGntmFMQ==
Date: Tue, 10 Mar 2026 08:42:22 +0000
Message-ID: <20260310084140.473079-1-a.vatoropin@crpt.ru>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-kse-serverinfo: EX1.crpt.local, 9
x-kse-antivirus-interceptor-info: scan successful
x-kse-antivirus-info: Clean, bases: 3/9/2026 10:22:00 PM
x-kse-attachment-filter-triggered-rules: Clean
x-kse-attachment-filter-triggered-filters: Clean
x-kse-bulkmessagesfiltering-scan-result: protection disabled
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=crpt.ru; s=crpt.ru; c=relaxed/relaxed;
 h=from:to:cc:subject:date:message-id:content-type:mime-version;
 bh=RU/ZTA8FVx4grNavjSBpD9dtKVrPBZpsDu9SHD5dpQw=;
 b=foAtgYpL9s2nbKsOPWVWbdzSsaM0BOI+cqdSEWez8SiMu6icWYASP/OXBAr7JB/5U6VS9pigQ4AK
	yTiAZcGDxZ484S6yzdf629Lul/devIt/fpLDIie3rHxy78T/FbK3c2lDLqh94JMpd1sGtrPErQQI
	fLCRIwRkGn9j2iDibNvokio/aw6oP0wfuqTrnMa3IQ5V3xxu3QVDJIumzvbksgH/fGW8xE48w0gq
	/ybBfh9u22kf0FtlFcG37TFtIkyFo/2M4GiGq99J8Kj2joixABHB3jCSi+2sq1dlXXttaNPB/ZE3
	yxaIluFRogDg7FuZfMy9wTK28b96iB4wi3AgEw==

From: Andrey Vatoropin <a.vatoropin@crpt.ru>

The current driver supports detection via both the ACPI interface and the
Device Tree interface (OF).

In the function vmbus_platform_driver_probe() upon driver detection via OF,
the branch vmbus_device_add() should be executed.

However, the variable "acpi_disabled" is a global variable that, in general
equals 0 when CONFIG_ACPI is enabled. Therefore, it may enter another
branch with vmbus_acpi_add().

Therefore, in the function vmbus_acpi_add(), when the device is not ACPI,
the ACPI_COMPANION macro may return a NULL value, and this pointer is then
dereferenced.

Add a NULL pointer check for the "device" pointer before dereferencing it.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: f83705a51275 ("Driver: VMBus: Add Devicetree support")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Vatoropin <a.vatoropin@crpt.ru>
---
 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index bc4fc1951ae1..c9ee3375b524 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2571,6 +2571,9 @@ static int vmbus_acpi_add(struct platform_device *pde=
v)
 	struct acpi_device *ancestor;
 	struct acpi_device *device =3D ACPI_COMPANION(&pdev->dev);
=20
+	if (!device)
+		return -ENODEV;
+
 	vmbus_root_device =3D &device->dev;
=20
 	/*
--=20
2.43.0
