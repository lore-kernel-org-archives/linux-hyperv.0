Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792517860;
	b=VZmKgUrXb1CWgKB1HyBL/5+9n6yYyhIRbq0tcwH+DgBm05bb4oSOte69rK2KZ4lemg0D
	 7x/p+Ho6gCR4afYbInattUtPMVsQiy/tnbmtiJN5sMm07ADZpQDHkHo+NWkpLRmfGDkGe
	 T4oIQQitzZJqKUob2w1xyZGgup92z4McZNWikGshHXAT35PkyUW+W/eSBOu+mFIyMaRdK
	 2Edyfi6pWaHV4LO4pQU/B9XzoU4RAHXumCpbWIf+7snDFfaEXXdarnyU4Dxm2zEzMW5hy
	 EWTIrWlaf29tt4ICDGleZXUWN4ZVNKgDNwQyZCSpoS24Wa+ltPFg2WQSdUYJrJ+6YWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517860;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=TKkOlr8jhwPsaGpPmPHJTkYY5YSC6yQCu+UpabW7Ryk=;
	b=zHD1bsrrs5hvkPSJ9F35tP2Bazx1nlrzZOk+5FfsFqwsz1r3ICWqFCfDP7foT6wDrHlX
	 VyeqD9i/LNl4RrqTQHrbWl9hrrM7IiQu5ZHb2DvukAxcJgj/kf1IxiZAWOJocj44p4tT/
	 D973uAJ20VCClOgUQAxxhzVaY1nI2DS/njRQZsxy8Cd2t1llFyCVQKXsG+QU5HqhOWq7o
	 MmHMySQ7kydzQnBeXBtHUFxZ91q4HeamgtQAimPVnjgKW5OjE2+yXLBmw7pfaZJcx28K/
	 UNt/eW31vS11as39cEcbTE5dzzCmRlAHpnckgdzw1duqrnCgzoheSc5rq0mFRtegmHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hs3J4h8C;
	arc=none smtp.remote-ip=198.175.65.18
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7181606A323;
	Tue, 20 Oct 2026 17:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7181606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hs3J4h8C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1792517858; x=1824053858;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LT+IC68DFoWhCEiVuCUJvJbdsesQnL9TfpdLkDLQFfY=;
  b=hs3J4h8CefC7YvKTaUxFksCxEnoDo0o8C+4IRtZmLx5lOGKlDC2NjwAi
   VpVS14OdkS0chputMCcFVu87TIBNjsM5BObRb1Zkg3mIp2x5cXtB0tVYy
   0EtIuaq0MszB/mHwDSD9ACV8VPtVo6COAydD7BV9sLwunwX7qLecgsn2Q
   jQ/2vnMK0ej6XiqhyUau6QsiKtr/6z0EoQUKoM68ARNDO46AehOkcp62J
   VxUBF1U1GxBKuqx3Gv2vr2cU/aLnmpLjk48sckYqL7gpmdyad9OuD1OJn
   iByR2IL6sHqxu3P2oi25MYltzsmZ7gwc4oObsc4LaJ83URKpF1QyeZiwd
   w==;
X-CSE-ConnectionGUID: QVevI6H7RjO2vUmrplfmSA==
X-CSE-MsgGUID: VgKFSGtZTySWANdDJKVZOg==
X-IronPort-AV: E=McAfee;i="6800,10657,11941"; a="1240977"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1240977"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2026 10:37:38 -0700
X-CSE-ConnectionGUID: WWnwPJbtStKN75lp7RYfhg==
X-CSE-MsgGUID: HfTLR9KCTPefXawqQbOVdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2875812"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.amr.corp.intel.com) ([10.3.206.11])
  by orviesa009.jf.intel.com with ESMTP; 20 Oct 2026 10:37:38 -0700
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
Date: Tue, 20 Oct 2026 10:37:35 -0700
Message-ID: <20261020173736.81755-2-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261020173736.81755-1-pavel.e.popov@intel.com>
References: <20261020173736.81755-1-pavel.e.popov@intel.com>
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

cpu_supports_p2pdma() has an #ifdef CONFIG_X86 block inside the
function body. Put the whole function under #ifdef CONFIG_X86 instead,
with a stub returning false for !CONFIG_X86.

No functional change.

Suggested-by: Logan Gunthorpe <logang@deltatee.com>
Signed-off-by: Pavel Popov <pavel.e.popov@intel.com>
---
 drivers/pci/p2pdma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9334eb314663..6b4f0843b404 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -519,18 +519,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
+#ifdef CONFIG_X86
 static bool cpu_supports_p2pdma(void)
 {
-#ifdef CONFIG_X86
 	struct cpuinfo_x86 *c = &cpu_data(0);
 
 	/* Any AMD CPU whose family ID is Zen or newer supports p2pdma */
 	if (c->x86_vendor == X86_VENDOR_AMD && c->x86 >= 0x17)
 		return true;
-#endif
 
 	return false;
 }
+#else /* !CONFIG_X86 */
+static bool cpu_supports_p2pdma(void)
+{
+	return false;
+}
+#endif /* CONFIG_X86 */
 
 static const struct pci_p2pdma_whitelist_entry {
 	unsigned short vendor;
-- 
2.53.0

