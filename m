Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795592618;
	b=et0rxpt4lyWz0GrBDTspK2ddD5VebUK5WpRIb/18OaKCEzPIT6zEksTmJDaYGhzeGRnk
	 1kPh4BWMi0xTHHPjEkTQHOT0byQ7eAxj24npOSeg648BjfkmferSxwyCdIRP5mde4dig3
	 sTreQEDbLeP/H0V+Mt5lqpVmLOaKsWlDf0zLTQWn7oXz5RoxHEzO2rDgimiytRhufpBe1
	 qA445mzQj1S9jGy1ueb7VKE34vk/6ikqBvGAvgFFIQztDLCDECj+NB2yn8VI/iRmZwcvI
	 Iang15KJU7iuyfNsKHKm0tLzfgngh6WWWgwCiCjZfdTbLM+9j2pSGlPh2Ll8oxDafOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795592618;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=MvidlHPU8zvIqyySx25kBpinAsib8zkl7VX76ecSDBw=;
	b=ysE/5t6AWqDlyd6gqpfebxBdF85FvJX5T7AVyn9rJT3VvKl9SYcXoOKZb/CkGmF1FTO5
	 55qqho9quvXjSGINQtXZ3TrZex9VDbOTqVF49Ry4GrAg4G0zkhq3C2AALZYR1tQ+Y9BnW
	 /Gtjllp/3WhUaYD9FJT5fGoqHeTehChCBmipyNd3vTJ3YlSx7wvOwjkHTDdlEJ00sjDXb
	 upMbGnhEankoWeehhyr9sqk1xuSa4gzvHZO00k5lVnl5qcxVm5oD3nP/L5VW9X7Lb76GF
	 a2fRlAPCEUWpd/MZMKp72036paW9hEJ2Ztvca7eN749Qu/o9bDoQbUONl3lOrS8yV0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="gL6+D7/t";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DC1606A31E;
	Wed, 25 Nov 2026 07:43:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 32DC1606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gL6+D7/t
Received: from zhangyu-hyperv.mshome.net (unknown [167.220.233.38])
	by linux.microsoft.com (Postfix) with ESMTPSA id BC16120B7170;
	Tue, 24 Nov 2026 23:43:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BC16120B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795592613;
	bh=MvidlHPU8zvIqyySx25kBpinAsib8zkl7VX76ecSDBw=;
	h=From:To:Cc:Subject:Date:From;
	b=gL6+D7/tP+NARCMQe/7ktmUFQv32T7IljpieRbSaIBU++NmAwQ82xDvAtFFD3NxW9
	 dQCF3x5x9QbVptO4OasySrQxmMTJPQoCsqh9/axGmDklVzNpGFF1NpAb4JbzYba9Mu
	 lvUHfkrnBFn7IXcISE/wmWUf/asbWv0WB9yb3azE=
From: Yu Zhang <zhangyu1@linux.microsoft.com>
To: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>
Cc: Robin Murphy <robin.murphy@arm.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Jacob Pan <jacob.pan@linux.microsoft.com>,
	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>,
	Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Mukesh R <mrathor@linux.microsoft.com>,
	Thara Gopinath <tgopinath@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add dedicated entry for Hyper-V IOMMU
Date: Wed, 25 Nov 2026 15:43:30 +0800
Message-ID: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
X-Mailer: git-send-email 2.52.0
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

Changes under drivers/iommu/hyperv/ are merged through the IOMMU
subsystem tree, while MAINTAINERS currently lists the directory under
"Hyper-V/Azure CORE AND DRIVERS" pointing to the Hyper-V tree.

Move drivers/iommu/hyperv/ into a dedicated "HYPER-V IOMMU DRIVER"
entry pointing to the IOMMU tree, with Yu Zhang as maintainer and Jacob
Pan, Easwar Hariharan, and Tianyu Lan as reviewers. Keep
linux-hyperv@vger.kernel.org on the mailing list entries so the Hyper-V
community stays copied on patches.

Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
---
Easwar, Tianyu: please let me know if you have any other thoughts or
suggestions.

Wei, Haiyang, Dexuan: feel free to chime in if you have any feedback on
moving drivers/iommu/hyperv/ out of the Hyper-V core section.

 MAINTAINERS | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8..dcdc73e9ce6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12448,6 +12448,17 @@ L:	linux-media@vger.kernel.org
 S:	Maintained
 F:	drivers/media/i2c/hi847.c
 
+HYPER-V IOMMU DRIVER
+M:	Yu Zhang <zhangyu1@linux.microsoft.com>
+R:	Jacob Pan <jacob.pan@linux.microsoft.com>
+R:	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
+R:	Tianyu Lan <Tianyu.Lan@microsoft.com>
+L:	iommu@lists.linux.dev
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
+F:	drivers/iommu/hyperv/
+
 Hyper-V/Azure CORE AND DRIVERS
 M:	Haiyang Zhang <haiyangz@microsoft.com>
 M:	Wei Liu <wei.liu@kernel.org>
@@ -12470,7 +12481,6 @@ F:	drivers/clocksource/hyperv_timer.c
 F:	drivers/hid/hid-hyperv.c
 F:	drivers/hv/
 F:	drivers/input/serio/hyperv-keyboard.c
-F:	drivers/iommu/hyperv/
 F:	drivers/net/ethernet/microsoft/
 F:	drivers/net/hyperv/
 F:	drivers/pci/controller/pci-hyperv-intf.c
-- 
2.52.0

