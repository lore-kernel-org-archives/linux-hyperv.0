Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FFF32E6BC;
	Wed, 23 Sep 2026 04:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137840; cv=none; b=OoI+U/f4EHfirdFx2UOZT3aHg6zFgrHqme9xP9xeE+qU0MDFwAj3AWpdHyY4MeJGwzbgLIDhpoC/os0ppgZ26CCzKyT3QbrqZVBf42dk9vwSa4VR3NQiDSCfE8hXQBkjMxpyzOjpaD3X8zP4S3B9Mode1QF9s6kO9f3nzji2Q60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137840; c=relaxed/simple;
	bh=vg9uaYXmSxJRqtgdteG4ad23jorXd9SvQNq5JmvOsrY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gl7s1YI+xg8VqPndiLSmj2828rbh9ftCBxLx01QGWGm+to/NOPbgUOEyDsdmkLBuZBDXqGNDhF/btAoS6ztTBrQweHAyatijiR7ufJg75bEFn7m9T6svpolne0R5S2YEnqndc9lzOU7FXsFQG+OdL3w9UCMbZxx+GVIHqosK1mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m6Y2h91c; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m6Y2h91c"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7D7AC20B7167;
	Tue, 22 Sep 2026 21:29:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7D7AC20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790137790;
	bh=aQReAO0PaLkNvXEhlkkcXHEpAn5VPDQu8Pd8CslTL90=;
	h=From:To:Cc:Subject:Date:From;
	b=m6Y2h91cP6uLX+qIVNw14KrOjlbQxwDfkTsuFZFYruq8pVgEOy570bLc+vRiX8mFi
	 qVV6oxTIer9fjwZ4iyhtVjNzs154sKZ+bfhX0pW/i+rW6t+Qz/0RRVvrJgmehYYlOk
	 Meh81Y5JCLUISbugqORBFgMIWDeqr57CwFBG4yAY=
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
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: Long Li <longli@microsoft.com>,
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
Subject: [PATCH v6 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
Date: Wed, 23 Sep 2026 04:30:19 +0000
Message-ID: <20260923043023.3150498-1-namjain@linux.microsoft.com>
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

Patch 2 then switches fixup_irqs() to call irq_chip_retrigger_hierarchy()
directly which ensures that this issue does not occur for chips that
miss adding this initialization.

Patch 3 makes a similar change in msi_set_affinity()

Patch 4 then drops the now-redundant irq_retrigger() initializations.
This way, patch 2-4 do not need to be backported.

Changes since v5:
https://lore.kernel.org/all/20260914111836.2119301-1-namjain@linux.microsoft.com/
* Commit messages refinement/correction (Michael)

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

-- 
2.43.0

