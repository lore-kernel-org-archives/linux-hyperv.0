Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794842771;
	b=MUPj2mFazUv+JOTuZPijdCvFixA7YvSM40wT8gYvK4GRSILqDEmt8KaLpaJxYn35RnN2
	 KAJ4TL1w+gmw5abzGXXAFRuhkhQuU5max23Ox0UM9vHCctcfzQqoI/BISzxJR4TrnxJzZ
	 0aA7yWfF2wjv1ouxGwOjilPmcg3S4qbuJGIHzjt7TkJ+am+kIBpE26ZufU4I/f9prnihP
	 Yw84OngStkk57tzI0yH4uzK/riYwLpSb0jJuGAblWjxgxPntd8GXKzYPMsFYtPKwjbbsE
	 rtYWKXx3REwBsAjc2bNtSUyftJruu0IsQ7XsSbxavBbxFPnzhiXmhUT0seGSAe03nVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794842771;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=LLaThhqLKe0aksQH0Zm2GrBih3Tohw+zEBDBZ5Zk8EI=;
	b=iPOyPJq+dKi7e5ohmcpB2rRw2pukCIXsKq+6JTYzVmyTrqFUn4Qo11tCeR8xMrhtF23W
	 c9UCUvVh3UO3htjAsJFNxw5nvFQjO3DlxaqZy7RDmgYVHfoWazw7rnCl24y4zFmbcVGaC
	 4tCaH6Sli73q2criTFaxipd8lswWifx0qP9JCyCMWtbbxNLROQKTRFMLb5CZfBj4RrGvX
	 ZUtN7L1jgXxP9oUO+8gi8GwMfLcJW0NZALke6cl+7PLkBL31h79EHFUUwpjxAdGclc7O0
	 QNz2o+nUYjCTl5E5tPdEPePcJ7lpY/qAQmIduCEVrPCwIT+zDk8GKnMHsQvZtHt1j4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.intel.com;
	spf=pass smtp.mailfrom=linux.intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kq1DUr40;
	arc=none smtp.remote-ip=192.198.163.18
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA88F606A338;
	Mon, 16 Nov 2026 15:26:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA88F606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Kq1DUr40
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794842771; x=1826378771;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hSMNs/i6uFfexL26eFrUhHX8pqIbOuQWyOeo5UimEkU=;
  b=Kq1DUr40pLDqq3k8mYvAIol1CCKF3dMeyOl9HATJFjZXw3YvsTrT12jK
   9/W+QYQv5pDN8+fdM83yBtnqkdTKl2zzr6QqlpqIlDMhRlkleEFyargaP
   7A2gAj2xU1HmZVRKnsr7I2Qmcq/sQ2/4imfWTJJhmYJjx9pnzYzfWk2Hj
   HktwBjykV0CB7bad5l8fyWoWJXvH5A6++NUUU1OukYCsrz2WjirbUINGj
   MhlJbXyuVApeK8jsYLVC/F0AKlH14b0FYIer//1KTk5zLwzVb404SjUsu
   Y0+ee8bFypiHKwYUeiow2x0kBzoIWYg8fNOVqKH4SHWO6u7X0Vv3NvI3C
   A==;
X-CSE-ConnectionGUID: 5IRSG+mdR1ODOoE+vem/Cg==
X-CSE-MsgGUID: c+znEwBOT4S7NjlEMxLr+A==
X-IronPort-AV: E=McAfee;i="6800,10657,11968"; a="3614237"
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="3614237"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:26:10 -0800
X-CSE-ConnectionGUID: sOG5WWdqRbiYO2OpoMlcDw==
X-CSE-MsgGUID: ATRrtVZtToSS7a24JLB5gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,216,1787036400"; 
   d="scan'208";a="9504923"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.151])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2026 07:26:06 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 12/13] PCI: hv: Convert to pci_assign_unassigned_bus_resources()
Date: Mon, 16 Nov 2026 17:23:57 +0200
Message-ID: <20261116152403.2672-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
References: <20261116152403.2672-1-ilpo.jarvinen@linux.intel.com>
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
the extra sizing should be no-op.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
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

