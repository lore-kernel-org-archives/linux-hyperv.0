Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C071F41443A;
	Mon, 14 Sep 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384734; cv=none; b=Sait4P1wpOJ2bp0/M+SRMKtunDbWjJXDLM8i7hpUZlhbFe+H7lAF+a9xb59SohXryM/+DE9vbmFh54P9YyMg/xuE/TEC8Keh9LkXG1CHUemE/ugL7wQNr/pgq2KyQgUvqn5vTNJAbE7qEcr3iYX6Cg8QAifYni0N+jL29MUL0SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384734; c=relaxed/simple;
	bh=cs3HC34FbdWyzUdrKaAQBTzgEAr7NxZgG9Tk+vArI0E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CM0KovHYgJJvGSzPba8JF5Ow774ZeaxEjSWPTrIezniVHwr4yBq+1Yn0fANqm+uMTrXXwCcqueWIAGdo5GoFGYRjWIB54eiEWWoYLcq0M0HmVwNq5PIN6Q2BKMyW2Y7uf2JhqGbxpwMMU0NW1PT9BsTZ2J5vOxPUwgbEe0MUZWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=JaKd4eaS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="JaKd4eaS"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 849C820B7168;
	Mon, 14 Sep 2026 04:18:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 849C820B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789384689;
	bh=5VsQQgnlV1OPE39rOHel3eT1qB8YmOagnuCRv9KWKrw=;
	h=From:To:Cc:Subject:Date:From;
	b=JaKd4eaSvpCjnfV/YU4EvPbkGnrtjBZohW7Gd/K/rwaOPwQox29gj3nR5YyToBBKK
	 wRfiCxHB9Ngg7340pS2rA3Hib7iPNvPeZue8dBmCQAokvX0L+SvuTZQ6idmCHFu9GD
	 +Sinn60DXVIZxwrxoJcoHf54FH4GKaqCuQ7y0aYQ=
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
Subject: [PATCH v5 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
Date: Mon, 14 Sep 2026 11:18:32 +0000
Message-ID: <20260914111836.2119301-1-namjain@linux.microsoft.com>
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
irq_chip_retrigger_hierarchy() directly

Patch 3 makes a similar change in msi_set_affinity()

Patch 4 then drops the now-redundant irq_retrigger() initializations.
This way, patch 2-4 do not need to be backported.

Changes since v4:
https://lore.kernel.org/all/20260909064448.1004-1-namjain@linux.microsoft.com/
* Discussion between Thomas and Michael concluded that if-else check for
  irq_retrigger callback is not required, and
  irq_chip_retrigger_hierarchy() can safely replace all irq_retrigger
  invocations. Make the change to remove if-else blocks and update commit
  msg accordingly. Older series could not be picked because there was a
  genuine change in patch 1 of this series.

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
  x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
  x86/irq: Use irq_chip_retrigger_hierarchy() in msi_set_affinity()
  x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger
    inits

 arch/x86/kernel/apic/io_apic.c      |  2 --
 arch/x86/kernel/apic/msi.c          |  4 +---
 arch/x86/kernel/hpet.c              |  1 -
 arch/x86/kernel/irq.c               | 18 ++++++++----------
 drivers/iommu/amd/init.c            |  1 -
 drivers/pci/controller/pci-hyperv.c |  1 -
 6 files changed, 9 insertions(+), 18 deletions(-)


base-commit: 68142f986ff04b2b70b31db00f719bf690f64a9a
-- 
2.43.0

