Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981B392C21;
	Wed, 23 Sep 2026 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790137867; cv=none; b=Q98Hg/SdtH5bsvGd8fNGU78yUo8K5XE2NZ1LkOcc9hkGYEo1k6H3YbbfreYJ/WvJ3K9jWJqRCEcI8Ge4XhMx8nWudWdiRFPN1Rx+NyFSyvysx965vfgmV0ZVhGKkIPyRyOp7pmIeBCGDTSXoFScfi1UAsndTumgGSRe8jEfOfnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790137867; c=relaxed/simple;
	bh=Pi7Ov/Kal92hj7ToqKQT4yMx8oPKKvCb1enscGJV2wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=axnLf61j/7t1yIqP1FZ4O2hfJ8lfsoDBCmEtHpnkQyRQ1i4IvUF/fePqHmgyPSsYhWTJcnMzNxEm0XDw3tbFcPdYxwRUDi9WAS4q9hYYFZ6UU4xr3u5OSlpafWXUMzIK2thH47SM4GXfyRXDduOhfh4QhD0iLkg0tFjyjR8PN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=aKfjzPiI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="aKfjzPiI"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id A3F1720B7167;
	Tue, 22 Sep 2026 21:30:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A3F1720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790137818;
	bh=LJpQliJCdciXzpLxkEWt9focC/jmzFSv0JiuBHEflec=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aKfjzPiIkX1O9wCWkgkoLnZNExfLC3wpqtRuj4xmrLqZVT0Vnf690D0yQoYFY+ZdQ
	 KcJqxiVdbsjmGn9LJYYDFAe+I53w6kKjVFrb7nbj00VSqKDtqCR8j3PxlFs4Q+DhYA
	 dP7q4oWF/YoSfwm05jxMhrwd6GIBH2WEssnI4V38=
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
Subject: [PATCH v6 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in msi_set_affinity()
Date: Wed, 23 Sep 2026 04:30:22 +0000
Message-ID: <20260923043023.3150498-4-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260923043023.3150498-1-namjain@linux.microsoft.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The irqchips used by msi_set_affinity() are initialized by
x86_init_dev_msi_info(), which sets their irq_retrigger() callback to
irq_chip_retrigger_hierarchy(). Call the hierarchy helper directly instead
of invoking it indirectly through the irqchip callback.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/apic/msi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db3..9160227b9b32a 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -137,7 +137,7 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 * IRR.
 	 */
 	if (lapic_vector_set_in_irr(cfg->vector))
-		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+		irq_chip_retrigger_hierarchy(irqd);
 
 	return ret;
 }
-- 
2.43.0

