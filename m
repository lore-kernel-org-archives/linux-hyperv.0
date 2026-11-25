Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.17
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795648340;
	b=PJX1BRd/lomRdMpNtS6JdNl7UhI+pZky7FtsdMVhbYEZZaA5Sd+dhJ1engzH3FOOYOuG
	 ZRBBt0FFKIeSM3TodFa+/7A1YcC2IRIaWk0NvU85eAVOxsnHWV8T1GRwfw7e/tm5UWhJq
	 7zstoV+f6O+zTHjNhjcNO/HOsAI9Ziia2LjuRACrafK4AlDX7uOsZ79DbD+QWeyPt/6K2
	 N9LEzz0jJdJILX0h9UsH5uKSDdR52jinKY/iV4sf9Dm3R8CXHaOkEQRhxcplXz9egIR3+
	 yjijifQ2Dh7QHsXuzRLtg9OEWV6qhGSp9G+qMU8FJxcFwJyeI2HhOti1KQeQFZftAbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795648340;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=dQsC8Em24j0enhtJEO9W2biegfwuW1IuR9HsU9U/7Yo=;
	b=0AOvKZpPr2g6WWQIILuai+QfjPhib8XJ7C3kZjIHJuiMaIRp7m+VzgAwqgJyqsUmu8i9
	 DHy6uqqRYd2txjEVer7lmQRgDcsEuVaM31Xkjua7CmfUUshQIoTELpsD1byLXyoMMpitd
	 Qx0w/GOgzcgwoN8Umw8t+swRkEooHWQXswg8/jnsVN3IkXXwRFMPuwi0s6wTnRu+un/9A
	 a1WKtvVTzu2oJeZqxmpBzSbnjP5FKle+QZ8Hz3FAXLEqQyKCTKJBnGrYHHra9bqwOeoJu
	 J7spZ40Z+DHsZ75b5t8ZTa5kzHR7jCylhJ3c5unaC8/Z1AX801ErvTvaTU8zw2WNtQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="C3/Q3Dbk";
	arc=none smtp.remote-ip=192.198.163.17
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBAD606A32D;
	Wed, 25 Nov 2026 23:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BBAD606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C3/Q3Dbk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1795648340; x=1827184340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u4JVZTIJzMBzjR3BvQ5MUbLmwmToG1SjLJRyWYjqD/Y=;
  b=C3/Q3Dbk5Xmb4JsUYKxrrGTxlLLMgX13SekTWE1A2+H8/t3T4EnGQnEF
   D3cPQWOZANIjVi21ZG9vsubuKpnbxbnbnYPlrz5RdYgIqr+wNLRNc4dDY
   WybgyNAXxepUBIfgtE0LNr571uAFwo0dYJBZFtCFrclUfWYzvwY2nMKcH
   DboZxT04nkDiHrI211prD5frAqDeztG+vg0rct9Q4Y+dsd3bXqAkK+AGw
   B8dyFXgiNh90pLW6yeThV4zpLcxfmYosKMzzgUjdAY/tSJM7pEFUCSVUo
   KFz7Jo6dkAzswDL4v29WmfOH3sFeDRSZDPXftj7pBFlkLU5BvdG68j8Zo
   Q==;
X-CSE-ConnectionGUID: lAGHLHczQZ+8HsZoIyUB6g==
X-CSE-MsgGUID: lk1XhAFPSSaG0kx9qMpVcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4538295"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4538295"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:12:19 -0800
X-CSE-ConnectionGUID: WXp3YO27TASS2SVss3xMrQ==
X-CSE-MsgGUID: gJTRs1eMTty4jeyj0LZntQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="12033077"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Nov 2026 15:12:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	David Matlack <dmatlack@google.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
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
Subject: [PATCH v3 16/17] PCI: hv: Convert to pci_assign_unassigned_bus_resources()
Date: Thu, 26 Nov 2026 01:09:15 +0200
Message-ID: <20261125230925.2441-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
References: <20261125230925.2441-1-ilpo.jarvinen@linux.intel.com>
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

