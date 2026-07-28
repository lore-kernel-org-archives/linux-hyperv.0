Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D81025A2DD;
	Tue, 28 Jul 2026 13:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785246694; cv=none; b=Wbaw1njpvE0U37QA2nZTaUBDPIy5cbMAlQtC+f12R/WM7tzTK2qD5smkex1D48z/pBtNiriGVwjplJUsB8VfW5D28Mx/n0a+MIPlfhXAyGECqdkqvowrijwcVr5FhMCVCPuQPVUtT+C/nqOjgoTFuYITjBNenn4rrrSGImGvKrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785246694; c=relaxed/simple;
	bh=hRvBtimUkN5HTwmrRjs1Te44eljEyxGDej4qebzkedw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pXJU9Eazjj6w0G3D/Xk4IZFZkLyZcy36ibLjRwSY01gOnKc4UQR0VlY/3nIs7WX+ew6OfS1GwaSJxyMY+HBtRnZyUjwWT3qKW4AJu3qwh6j2hzLNuGlPFTE0zZMNzRjTmz492zwEIn2NXb9z3/K4tSjI6APWe8hy+8UmPllLh/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l4YGstsG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l4YGstsG"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id 265D920B7166;
	Tue, 28 Jul 2026 06:51:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 265D920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785246671;
	bh=/s0NBGO5Nwu0FBhXzB5m3wygkVQ4fkuc2i5s5t6+ff8=;
	h=From:To:Cc:Subject:Date:From;
	b=l4YGstsGT9GrJUEivZR6SFeqwFcVYMDy4+eExl4Z2eLoduQlU5K0LedDFa9IOEGFv
	 dsPEQjC/cLtgve4mikobwwFImpSnuR4vr2hmcETQcZoziVISfInzbR+kT5Ox30yPYv
	 u1RmwnnetKzXldrOkptQy5HhbUbmgOprGkIbwmeY=
From: Naman Jain <namjain@linux.microsoft.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>
Cc: x86@kernel.org,
	Jake Oshins <jakeo@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] x86/irq: Fix lost interrupts on CPU hot-unplug for Hyper-V PCI/MSI
Date: Tue, 28 Jul 2026 13:51:14 +0000
Message-ID: <20260728135117.2888175-1-namjain@linux.microsoft.com>
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

The series follows the original RFC:
Link: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/

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


base-commit: 0d33d21e47d9dc66f91e44da3fc9220c74d93df7
-- 
2.43.0

