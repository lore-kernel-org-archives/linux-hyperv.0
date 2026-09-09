Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32B63B83E1;
	Wed,  9 Sep 2026 06:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936331; cv=none; b=daa+HtPlAw+IrJIz8qIXGjhKpEV3IfcUeU8dJuFneltlDxVC7ieG79xV+OIRtYezpmhq6KgVb3XjAYbITT+YmJWR8o2xzknqpS5GgQr9kV+SUDtfy4MkSRsuHiSCKITD1F5apR/4Wu+FJvAU05EfU7Q1ROWOC4fTZvRfsV9esEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936331; c=relaxed/simple;
	bh=HSoqkeQpnPn0IcBwaWar28Zz7ZtQC3OqmJMY9ypZ6MQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GZo4tkLZHvWmHYJnC8lGLRZ4D5VQVm4Tap8yFUN1H+n2AsEd0AdSnJcjJvoqFEAdOoN8v/FdjPSELbFK110OZqs2PW+rkznYWLWw/7i0PLTvoQWKlEbpKQicw9ODiqem7fi4TQQA8LXWZ59DgRh9Av3WIJcbAfx0yES2y7H6Lqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mvYEGR/K; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mvYEGR/K"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id EF3C220B7136;
	Tue,  8 Sep 2026 23:44:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EF3C220B7136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788936289;
	bh=koAnNaNQyQ/gB5aR9yFBdh8NzxgGLfEa9F99gJSBoUo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mvYEGR/KujxX6Lsdz2WkBnsDGVh6iYqoCJdJMLkOt8uVD8W7w/l19D0L7jAt54MQM
	 fjFqP74Hz0Z3M3R8j5KSchvpHs5lVnV/O83g6limIrMUazJGWDix5qk4i/6AcCFNL+
	 S5fQ5kUBkhwcXM6Jzf9UpJfTyjSPbDCrsFSD1t/I=
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
Subject: [PATCH v4 3/4] x86/irq: Fall back to irq_chip_retrigger_hierarchy() in msi_set_affinity()
Date: Wed,  9 Sep 2026 06:44:47 +0000
Message-ID: <20260909064448.1004-4-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909064448.1004-1-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

msi_set_affinity() re-injects a pending interrupt on its new target by
looking at the outermost domain chip and invoking its irq_retrigger()
callback directly, without checking whether that callback is present.

Keep calling the outermost chip's irq_retrigger() when it is present,
but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
up the interrupt hierarchy until it finds a chip that implements
irq_retrigger().

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/apic/msi.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 66bc5d3e79db3..66647d51c0473 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -136,8 +136,14 @@ msi_set_affinity(struct irq_data *irqd, const struct cpumask *mask, bool force)
 	 * underlying vector store. It's just checking the local APIC's
 	 * IRR.
 	 */
-	if (lapic_vector_set_in_irr(cfg->vector))
-		irq_data_get_irq_chip(irqd)->irq_retrigger(irqd);
+	if (lapic_vector_set_in_irr(cfg->vector)) {
+		struct irq_chip *chip = irq_data_get_irq_chip(irqd);
+
+		if (chip->irq_retrigger)
+			chip->irq_retrigger(irqd);
+		else
+			irq_chip_retrigger_hierarchy(irqd);
+	}
 
 	return ret;
 }
-- 
2.43.0

