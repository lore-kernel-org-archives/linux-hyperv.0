Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795182595;
	b=yBRWR5Tcv8PIEM+9d52ZL7koHTeybpbPuUR7sHaFq0p2KEDzFabyQfpkVbgCmNxQ0dU8
	 gpmSOg8vxeQ4Yzh7Wb43fOLHYYh2FzBknxiLFiajaihD+/BaXJDzRU27Ju0WNEZHsNpwi
	 CEPXD94BuUpWqV8aKNL3qj1Uoq0z00+sI552c5fMoU5OZtkkXzy0jtHdBceGrGP8VwbZ6
	 qJW9YFpxEVFBW8hDiz90Z8PQ9VLB5oFFBbFAMMBvmBgsxr/air7LThj9xMeiKUFTJObMy
	 skJt3orcfcPjRO1JMFKvnqM94jDMHd2gIY6NuFxZvvIAdWXeNIuEoEDShmVaQ4UOjKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795182595;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dQsC8Em24j0enhtJEO9W2biegfwuW1IuR9HsU9U/7Yo=;
	b=nSLzyex5pKGfj7H3P2ADYDnjIocZzLRAGCsmWnK3ox86zpHXWZihjWjZJxL0ecF1B3FZ
	 0pSAalA/0YBm9rKq1aOz0kXR7ELgnepa8cAUwjYHomGq5OIeEbMb+FZsOkv4rhFlhoTea
	 hX2nOwnM1G2I0cwrbCc4srTalp+Bg7lO/BJLfeY2bFLcBoTduGPFADSSqoiZSAJf7RrJT
	 pHqMSPG3w4r3CzVQejwjXJK3X67FKQw2JANDdcNmc+rZRGThUrJ7Txro0DV65hGh61F+H
	 WBRuuVBbVFjBJVouLh15JCZkBXWFvUcSeQUZ0KI8wb5jGZqmno+ST3GxefhRPKYW/VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lG4j15GH;
	arc=none smtp.remote-ip=198.175.65.11
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BB606A32A;
	Fri, 20 Nov 2026 13:49:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9D8BB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lG4j15GH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795182595; x=1826718595;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4JVZTIJzMBzjR3BvQ5MUbLmwmToG1SjLJRyWYjqD/Y=;
  b=lG4j15GHdGMFEAoKhfwhohmoMeDf8WF2SX2gLn4eCjmZMd3aC56VWcKG
   kYu50Jaky4jJrcXNl740ALxqvB3GBUlmc4hxvxcHrrXqNj+Ni2h10X+G0
   0xYLsEBeheE5bkE2xfPfVdBpiiIS/MlGJXmeHesHFAVkbM5Jtah7WuWjR
   uGTI++OCW2G0gjR0bVd8bWmGXLi+pvtsbWLfrR8FNCjVcujNtDf663QTi
   qG8XfJ2378WoEYqgEAOKkgs5OMVK50iU3lgYYNH2O4A6DcUT6GDbejiSA
   pKOCFvVd8KJr0J4GaoQDbUVBcmCjBd1zlRooHOFcbGME6XZAgOIRufV8C
   g==;
X-CSE-ConnectionGUID: OKYcYlgGQUS7pQsxe+1K3A==
X-CSE-MsgGUID: efs6pJ5aRzSego0w+Ev/6Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11972"; a="3955298"
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="3955298"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:55 -0800
X-CSE-ConnectionGUID: 3qvLOrIvTl6fkADZfI3Qwg==
X-CSE-MsgGUID: ye71YMW/R2iSoQLb/hdBgQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,223,1787036400"; 
   d="scan'208";a="10971584"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.16])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 05:49:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	"Rafael J. Wysocki (Intel)" <rafael@kernel.org>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v2 15/16] PCI: hv: Convert to pci_assign_unassigned_bus_resources()
Date: Fri, 20 Nov 2026 15:47:10 +0200
Message-ID: <20261120134716.3027-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
References: <20261120134716.3027-1-ilpo.jarvinen@linux.intel.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The pci-hyperv driver scans the bus and assigns resources using
pci_bus_assign_resources(). That function makes bridge window sizing
disjoint from the assignment phase and is going to be removed.

Convert pci_bus_assign_resources() to
pci_assign_unassigned_bus_resources(). If no other bridges are involved,
the extra sizing should be a no-op.

Tested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
---
 drivers/pci/controller/pci-hyperv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 824cf27e85e6..8eff3e9b325f 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -2549,7 +2549,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 
 	pci_lock_rescan_remove();
 	hv_pci_assign_numa_node(hbus);
-	pci_bus_assign_resources(bridge->bus);
+	pci_assign_unassigned_bus_resources(bridge->bus);
 	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(bridge->bus);
 	pci_unlock_rescan_remove();
-- 
2.47.3

