Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10478374756;
	Fri,  3 Apr 2026 08:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775204960; cv=none; b=HhWueJ0GBweaYNx3DrdGRzy+AIueZDBu+61tByxS6+46j3bUPMVKC0+aNNCG7Ji/vjnbLBIAQZPHxS6Q9UT0zr1XLcnjRDCUg/4xq+KTMOsuI5xQM7ohpoMZj+M5c3wP//mqp6nUa0SfAqsIdpB4VtNl31Lc00EuKzF3rSJilGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775204960; c=relaxed/simple;
	bh=4z2eitNd+f61kErWF1oF9zfJACTA97Nm8U0KYlieqXI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Z9jKp/YtavCFEbNgSL9wpK0jCM02HLxKg2FLabb6dHKFOk+7F2Vrc74kFAJ6ReQznMNpblWwBcoNUAb87GqiqLAN2WxzqRaffu0VB1VFMGIZsLZdHySrRVWgnzUdjviSZnxhZPXCrRXcS1BC/RIMdfbcGAFW5IvXRkTa9T4dO6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=isxf4URV; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="isxf4URV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775204954;
	bh=4z2eitNd+f61kErWF1oF9zfJACTA97Nm8U0KYlieqXI=;
	h=From:Subject:Date:To:Cc:From;
	b=isxf4URVq/5E2H5h9yFI/5+gKMHNSBGlY+BUOIep8D3CEB7e8NsFFyQP3VYpG6Ut9
	 M8gDMByHBEol1kNUxFZAINPioFc2B0iUlY6xxUOmYIAys4bC6kR50doWDnAMUJinUN
	 662Ojy4a4G2L31v+klTF8fds/iJoSxbvESNbM+Sg=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH v2 0/4] drivers: hv: mark some sysfs attribute as const
Date: Fri, 03 Apr 2026 10:29:12 +0200
Message-Id: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/12NwQ6DIBAFf8Vw7jaAFkxP/Y/GA8W10AM2LNIa4
 79X9NbjJPPmLYwweiR2rRYWMXvyY9hAnipmnQlPBN9vzCSXite1AJppILBjoAQugzU9v2jRWtU
 ato3eEQf/3YP37mCaHi+0qVSK4TylMc77YxbFO+INl//xLICDaZTu1aC1VHj7oCci6yZ3DphYt
 67rD1SF1d3DAAAA
X-Change-ID: 20260331-sysfs-const-hv-cad05718c68a
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1775204954; l=966;
 i=linux@weissschuh.net; s=20221212; h=from:subject:message-id;
 bh=4z2eitNd+f61kErWF1oF9zfJACTA97Nm8U0KYlieqXI=;
 b=57gc5+dh6PRV358SefOIgLTA7ThkJYEaO1o5BHXBSKyZlIpOdsspVmXNjjSn4ZM/Su4Ci4DuE
 bZ0ECo/lOI/BXlLaDdPTc+yzyMzxN+p4g1T4VCR/sYsFKy15OZ3VRKE
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=

The sysfs attribute structures are never modified.
Mark them as const where possible.

This excludes the device attributes for now, as these will have their
own migration.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---
Changes in v2:
- Mark missed four channels attributes as const (Michael Kelley)
- Link to v1: https://patch.msgid.link/20260402-sysfs-const-hv-v1-0-a467d6f7726e@weissschuh.net

---
Thomas Weißschuh (4):
      drivers: hv: mark chan_attr_ring_buffer as const
      drivers: hv: use ATTRIBUTE_GROUPS helper
      drivers: hv: mark bus attributes as const
      drivers: hv: mark channel attributes as const

 drivers/hv/vmbus_drv.c | 51 ++++++++++++++++++++++++--------------------------
 1 file changed, 24 insertions(+), 27 deletions(-)
---
base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
change-id: 20260331-sysfs-const-hv-cad05718c68a

Best regards,
--  
Thomas Weißschuh <linux@weissschuh.net>

