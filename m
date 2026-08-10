Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B116F3ACA5A;
	Mon, 10 Aug 2026 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352849; cv=none; b=DiHgIxvdfuai7nVpTSwodBlfdfWEABAHHUbW9vOl1LsdHxQ8xd8w9cgib69BEvcdsBdGBLY2UkHkjh5ovJyGX6eldKRdO4/VKYm+c33u1Mpb99f9CzHOk8k9On7n1VeTyCt2P+FdfGkz+TH/IaYwrC9lqYJwaadyEaSuFB2qChE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352849; c=relaxed/simple;
	bh=RcLbGilKNPNC0RUtf9NSMs+SW3P3+5XKJ39gGa4XbLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mhja4GJWZA6LY1Jfg5mmh6Nz68zxU5QTezXnLPqfJBzqzMne0UnUOQkN941i1911guWl35z6OhPUGX7RThJQlIw+0q4eukGXeJ7/7L348q+8nlljy4BRPhDp1a7Q2xNjxUdQTaZ5VgDhT5FJLV3ftDImVTyT3hZFGFq8z5fxNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nZfvei8m; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nZfvei8m"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id A21AC20B7167;
	Mon, 10 Aug 2026 02:06:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A21AC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786352822;
	bh=1KPmg0Fee/slatq+vNTVHE9Mgne9Fj3pacSFimVqm8U=;
	h=From:To:Cc:Subject:Date:From;
	b=nZfvei8m69pgOEwZikK4apxa1XgVSDms4l3ejMv5mC0rD1qLHcnZurJwtbaegcxGp
	 4ryQzVRKLu50eJvn/yQjwqVtLC+ZhhSzJto0cMnufnl7oktyijbIvWW/qP+y/7JdoN
	 llPnzD4XOgW08QnBlJ8Hbttp9Iv9d9TXpu0UL2+o=
From: Naman Jain <namjain@linux.microsoft.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Rob Herring <robh@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	iommu@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] x86/irq: Fix lost interrupts on CPU hot-unplug for Hyper-V PCI/MSI
Date: Mon, 10 Aug 2026 09:07:12 +0000
Message-ID: <20260810090716.2325295-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
callback. The Hyper-V vPCI MSI irqchip never installs one, so such a
pending interrupt is silently dropped, leading to lost interrupts, stalls
and "No irq handler for vector" messages.

Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that installs
irq_chip_retrigger_hierarchy() on the Hyper-V PCI/MSI chip. Patch 2 then
switches fixup_irqs() to call irq_chip_retrigger_hierarchy() directly, so
the retrigger works for any stacked irqchip without a per-chip callback.
Patch 3 drops the now-redundant irq_retrigger() initializations.
This way, patch 2 and 3 do not need to be backported.

Changes since v1:
https://lore.kernel.org/all/20260728135117.2888175-1-namjain@linux.microsoft.com/#t
* Added Review tags
* Adding minor clarification in commit msg of patch 2 (Shradha)

Original RFC: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/

Naman Jain (3):
  PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
  x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
  x86/irq, iommu/amd, PCI: Drop redundant irq_retrigger inits

 arch/x86/kernel/apic/io_apic.c |  2 --
 arch/x86/kernel/apic/msi.c     |  4 +---
 arch/x86/kernel/hpet.c         |  1 -
 arch/x86/kernel/irq.c          | 23 +++++++----------------
 drivers/iommu/amd/init.c       |  1 -
 5 files changed, 8 insertions(+), 23 deletions(-)

-- 
2.43.0

