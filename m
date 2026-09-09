Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68E2F691D;
	Wed,  9 Sep 2026 06:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936311; cv=none; b=UFNEzp46+e+71jpzSlxf0V4cG+KD26XtVtpA//6/niBfpN6Qk86h1F/jUSCUD6NcZEkx98zaD/Y2UbmsxbpFHQQmtkAGuOA7ek+/mvyEmXCQKrkzVGsu+2feUIpiIOYZpwPH0axH3eM4pvJTB4sUK54GDs+lPxuZAHiL6ktyqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936311; c=relaxed/simple;
	bh=fudgSko1uyn6b/jzQYCBTsav8YTLi0nmj5z9Zc9yCZg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DAFc6usDyd9qXUZtGGW6lugOBpVUe6NLTd7F6sbIgJc/WRmRxOs/Lt9TNLg3igo1rokmsMa1OlO9/dkEFs/Ymh8EuOMM4E2FHOphK6OlWLzwQ4X9dqgyFgoMXqjCszC47bZNy6YDf4qhX+Ei0kbiHeupJv7zwGvTOeoICVgLykQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qYGdzgUd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qYGdzgUd"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id 580E620B7128;
	Tue,  8 Sep 2026 23:44:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 580E620B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788936261;
	bh=D2jMSvJ0QumxAlxtQi3sXRQT3/KmY5yZSB1ZodcX/0w=;
	h=From:To:Cc:Subject:Date:From;
	b=qYGdzgUd3mkOz5Uakq9RbP3Ib5HK/OGgHQbrlZEjTQIDnVSMJ+rumckpAq1SlGSey
	 ZcBeOJ7P8qEHDxo/3+2iRyBLsXPWDjmKCWr/IOY7ICt/Xo6vpy6ugiToU1h/nU7cEA
	 vEEjKffDoDVs1k5vV7XVY7nuqel90+zF0uqA2GCY=
From: Naman Jain <namjain@linux.microsoft.com>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Wei Liu <wei.liu@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
	Long Li <longli@microsoft.com>,
	Nam Cao <namcao@linutronix.de>,
	Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kees Cook <kees@kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Radu Rendec <radu@rendec.net>,
	Sean Christopherson <seanjc@google.com>,
	Kai Huang <kai.huang@intel.com>,
	Dmitry Ilvokhin <d@ilvokhin.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Thierry Reding <treding@nvidia.com>,
	Jiri Wiesner <jwiesner@suse.de>,
	Daniel J Blueman <daniel@quora.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: [PATCH v4 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
Date: Wed,  9 Sep 2026 06:44:44 +0000
Message-ID: <20260909064448.1004-1-namjain@linux.microsoft.com>
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
callback. The Hyper-V root partition PCI/MSI irqchip lost that callback
when it was converted to msi_create_parent_irq_domain(), so such a
pending interrupt is silently dropped, leading to lost interrupts, stalls
and "No irq handler for vector" messages.

Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that restores
irq_chip_retrigger_hierarchy() on the Hyper-V root partition PCI/MSI chip.
The equivalent guest pci-hyperv.c fix from the previous version is already
merged, so it is dropped here.

Patch 2 then switches fixup_irqs() to have a fallback call to
irq_chip_retrigger_hierarchy() directly, if a chip does not define
irq_retrigger callback.

Patch 3 makes a similar change in msi_set_affinity()

Patch 4 then drops the now-redundant irq_retrigger() initializations.
This way, patch 2-4 do not need to be backported.

Changes since v3:
https://lore.kernel.org/all/20260907065129.269262-1-namjain@linux.microsoft.com/
* Move irq_retrigger setting to hv_init_dev_msi_info() in patch 1
  (Michael, Nam) 
* Add if-else fallback check in msi_set_affinity() in patch 3 (Michael)
* Break patch 3 into two separate patches, while *keeping review tags*.

Changes since v2:
https://lore.kernel.org/all/20260810090716.2325295-1-namjain@linux.microsoft.com/
* Add a backportable fix for Hyper-V root partition irqchip (Wei)
* Add a check for custom irq_retrigger implementations and add direct
  irq_chip_retrigger_hierarchy() calls as a fallback if it is not
  defined by a chip. (Sashiko, Michael)
* Removed local loop variable change, and continue using the irq_desc
  accessor function (Michael)
* Did not pick "Acked-by: Manivannan Sadhasivam" as it was on v1, and v3
  is a functionally different to some extent, specially patch 2.
  Requesting you to please review again.

Changes since v1:
https://lore.kernel.org/all/20260728135117.2888175-1-namjain@linux.microsoft.com/#t
* Added Review tags
* Adding minor clarification in commit msg of patch 2 (Shradha)

Original RFC: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/

Naman Jain (4):
  x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
  x86/irq: Fall back to irq_chip_retrigger_hierarchy() in fixup_irqs()
  x86/irq: Fall back to irq_chip_retrigger_hierarchy() in
    msi_set_affinity()
  x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger
    inits

 arch/x86/kernel/apic/io_apic.c      |  2 --
 arch/x86/kernel/apic/msi.c          | 12 ++++++++----
 arch/x86/kernel/hpet.c              |  1 -
 arch/x86/kernel/irq.c               | 19 +++++++++++--------
 drivers/iommu/amd/init.c            |  1 -
 drivers/pci/controller/pci-hyperv.c |  1 -
 6 files changed, 19 insertions(+), 17 deletions(-)


base-commit: 944a035ecca915ae947905dcfb03f2b9dc6d032c
-- 
2.43.0

