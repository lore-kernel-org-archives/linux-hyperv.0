Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=192.198.163.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794440687;
	b=kA4TBLOT6B0x+xkyQNbJIP27fEBOjbyB3wqUJ3peULiWUEEmwq4YZ1pmqe9gbg5e9z3g
	 aDRiC4lC6rI6WKMOIxfzYsqgqWvtYnl8CYXq4AX5Fqg7vUIyJfKTqYDWB/KVrXLOcPOsI
	 fLnUSC7scsafB8eS8eiqycifMQsGxb4T9LV8fXhI9GItxSt/BK52GN1h5+tiXjF4S0kGA
	 jwzaMr8UA/R8vXVUjgvqIrA1Oligdzf+HmHcj4020WlY0MOjtYTvd79kE50wiLXLfaRrq
	 9J8i2Ze5f++20LjB1rfCIddC8YJdYSvbcpK1ARmX0dBgWE8xQc1EE9mzong6eSoui4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794440687;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=I0fFVuwofq/UFgVDjwtEw5LgWKHDdS/HD+gmpNBafaU=;
	b=o2OrZMwFRGT6zbyJMnUbaXc5Fy0K+9wtaTeeS9CQOahzsTxnL2FdYOkOJIMZjk9Yh8+W
	 eTL+9Pky5Zi3kDjJazJmX4dYQJBFJbzfR2s+R8JVW2jKs2Y1nAeLo43C2cgjhbZH8vNlJ
	 2PQY68ip/lxfoKWzg36MoMwP/xCrY/LS/f6hp63HSfOb8kOZHtOYW0ljjYK65rjmFTPh8
	 P5TPKbAODkhyv1iryNy/eJTyqqvKkpaN7f1kxftM6s2e8YwouDeeJ2HLXvGnah/+3vE9f
	 PO0Z1YHk6WrjXEXJZes2KHs7WzI8Nnh945jbegWXXfw1wEPn3PXg4dPH9e25cKzxPUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nv9QrP71;
	arc=none smtp.remote-ip=192.198.163.9
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05E5606A8B7;
	Wed, 11 Nov 2026 23:44:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05E5606A8B7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=Nv9QrP71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1794440685; x=1825976685;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PkDXqhiJGj1+9nHIcsbg58aoG97zoWIJiMiw7qrLzFM=;
  b=Nv9QrP71IxDtTMoyGZDYFlUBm4uI+P81lbGw7829NrnCn05UZR9kh8f3
   Gqleh7z0tL0lTfEXzbenDzMXMtRE7MitaijRGGEXITK0wqGZzAB1XyzJR
   A7NGdIrSuk7kvpR08dHdJy7I+xybL+1TFsEjD/kLrER6/NMDJQ9MkWT8k
   28pyIcOMJs8mko3c4heEkJxBDzELCFvjU267/Tn3JwJQEU7U+ghcoPMtj
   SpSbZxqfyEFaVZqcZ/cC0qlB0uPev9SEVaIFPNPK3AjX+usoz4Xfjn5r0
   GqsMq1EVNN95EWIt9hz9zDOjCdxlzxozNDI1fzpJM8W7997A3MtHoizRW
   A==;
X-CSE-ConnectionGUID: 0iSJolwhTvGurvt/YVgWLA==
X-CSE-MsgGUID: W8meQ1CGTEasfzrh057TSA==
X-IronPort-AV: E=McAfee;i="6800,10657,11963"; a="3099111"
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="3099111"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2026 15:44:44 -0800
X-CSE-ConnectionGUID: PNnPqmP1Q7yHiP3QKAKyFg==
X-CSE-MsgGUID: 499YSC7UQfmiBrqt/kz+nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,208,1787036400"; 
   d="scan'208";a="10241293"
Received: from pavel-dev.sc.intel.com (HELO pepopov-mobl2.intel.com) ([10.3.206.11])
  by fmviesa012.fm.intel.com with ESMTP; 11 Nov 2026 15:44:43 -0800
From: Pavel Popov <pavel.e.popov@intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Lukas Wunner <lukas@wunner.de>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 2/3] PCI/P2PDMA: Move CONFIG_X86 #ifdef out of cpu_supports_p2pdma()
Date: Wed, 11 Nov 2026 16:44:38 -0700
Message-ID: <20261111234439.4098-3-pavel.e.popov@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261111234439.4098-1-pavel.e.popov@intel.com>
References: <20261111234439.4098-1-pavel.e.popov@intel.com>
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
index 9e6e22542a9..180fe5d6228 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -520,18 +520,23 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
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
2.54.0

