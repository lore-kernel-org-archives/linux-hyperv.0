Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BEC3F4DDD;
	Mon,  7 Sep 2026 06:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763907; cv=none; b=EIkb8+Tnf0SRQcBkJwJXuDIkdok1/LTlRl2Grt4QNzY+XhgCv0LOyeyAEJm3GwOWtnKKsAMunwTMxzTGBpt8o143KWzXMdXiWb6zMM0h8MlC/xcMY8394Xy7gTOJEoew4zE+TcAyMcTOAGWdLinJW71e6DLA02Qzog9GqXIDYag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763907; c=relaxed/simple;
	bh=osB73+WJEfL+bitVCQcNrAGr5rrFgpOteaVjaOYKQF8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uuYOfeqgg261hLTKVl2tS9CmCmMuqqz3atfP7cW2pxwtb2FOvin4OF3Z99YmaCPjW5Sw5AVmhpnG7cMZYYqiC+Maot2iOaiX3dEDazNjwT8BlB2UJMBuWNkgfH5XOjkThYednvGCbbOqefMxz1blD4+dEyxKTBFV+9zQTQfI5Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EfXoaIdW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EfXoaIdW"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5D28620B710C;
	Sun,  6 Sep 2026 23:50:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5D28620B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788763865;
	bh=VJl1l3GK3Fqd0mALpCdqP/jq1V49Q1rEogZ8Xn0aOI0=;
	h=From:To:Cc:Subject:Date:From;
	b=EfXoaIdWwrHESnecekdAjvWE6nZEd58bkelcEbh3OnMQNmbWz/3HYXjj06tRMAVmb
	 jmo5BKvkSIE4O9NBkiXgIFGRpcEpnFfJMKF5hy0YrLLd/cAEagfu6v9lFAKJntFImL
	 6j6bIah8j/AT2Kl8xpo6mF0Zkrh2bgsDDksa4DxY=
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
Subject: [PATCH v3 0/3] x86/irq: Fix lost interrupts on CPU hot-unplug
Date: Mon,  7 Sep 2026 06:51:26 +0000
Message-ID: <20260907065129.269262-1-namjain@linux.microsoft.com>
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

Patch 3 drops the now-redundant irq_retrigger() initializations.
This way, patch 2 and 3 do not need to be backported.

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


Naman Jain (3):
  x86/hyperv: Set irq_retrigger for root partition PCI/MSI irqchip
  x86/irq: Fall back to irq_chip_retrigger_hierarchy() in fixup_irqs()
  x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger
    inits

 arch/x86/kernel/apic/io_apic.c      |  2 --
 arch/x86/kernel/apic/msi.c          |  4 +---
 arch/x86/kernel/hpet.c              |  1 -
 arch/x86/kernel/irq.c               | 19 +++++++++++--------
 drivers/iommu/amd/init.c            |  1 -
 drivers/pci/controller/pci-hyperv.c |  1 -
 6 files changed, 12 insertions(+), 16 deletions(-)


base-commit: af5f12805e5cefa4fe68d6127c7e1fb78cd5535c
-- 
2.43.0

