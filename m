Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D1A406270;
	Mon, 14 Sep 2026 11:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384761; cv=none; b=ee12gWuddy3warAcLmdnM3e8NudCDTx8mH+nRErtbIrBkWJ5IthpMzalhyLA9VCg40e+ypZwMmRGa6+G4QI6yQUGFQFRgmfK151QMIOF7zovJGrZXsBZfU6eOdeTGvTYT+3XGvRkGY1rod2CBADABm6E8wmLXhpFAfnwpKk3Rsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384761; c=relaxed/simple;
	bh=8FffDPvEV2Gu5JxHuaOB/mtxaX15Zg/FtgnEfe4nqbM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBB09gySonV3kKV3ffQvVjbLj17FUdAJcgVVdyZrlWWlG8tTZ7SaxHRbDK+NXPNW1omoBrmJNv5SUwXLPHAFaxwss1DbOpUNylZ1vp9620+DU5hQx9J/8gzTTzU1oi/I4guQZYIxqaQinZca6f4lRaP/tcCWxJyYERHOVeLO/Vc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m4BNQlNl; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m4BNQlNl"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 92B2B20B716B;
	Mon, 14 Sep 2026 04:18:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 92B2B20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789384717;
	bh=Vcf2YkEKKw2IuHclms9BnKsGKQYNfhSEwzt4veyWEVA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4BNQlNlSN9LcfGE86vTtoxSEfdRIq8w6ZhrwSZpST5jfx9AFuNzJGNI8x1udUXwk
	 m5fm6chLAFzCObXT++Jf2NJvJ0jHgG6a3Ez64xCgUafwGOFMrONWJGMFI8PGqtir8s
	 KJU6Lnrbx26k05iMVWgA6eXjkk8eORwERy7o+KFE=
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
Subject: [PATCH v5 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in msi_set_affinity()
Date: Mon, 14 Sep 2026 11:18:35 +0000
Message-ID: <20260914111836.2119301-4-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914111836.2119301-1-namjain@linux.microsoft.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msi_set_affinity() re-injects a pending interrupt on its new target by
looking at the outermost domain chip and invoking its irq_retrigger()
callback. Since this mirrors the behavior of
irq_chip_retrigger_hierarchy(), use the helper directly instead.

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

