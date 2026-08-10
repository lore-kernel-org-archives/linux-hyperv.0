Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725423AB286;
	Mon, 10 Aug 2026 09:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786352861; cv=none; b=uc27wb2dIpu66OiZpneIXEQd9FHmswIQWy9YZlNUono2ZOlmvAOQxtNBvPoz5kfnq1jeLoYALJlkpj9NcIfDM8cclOxoCzAcg/1HhfpZcaKMjVWWUBKeROmbTLyOeTSQssws9PBNQK0uKJ7omF+2QMnGPV86k1LZKA/BmL3sZhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786352861; c=relaxed/simple;
	bh=8hRhto7yu1YdfxQ/es9BJ2LPlFdXAoHdDj6NeWX6zQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LCVqUZxB1fzNHAux/JyAtKHFXbkGjK9PuM1fuy9X80ebixOyvpD9Xc3mcNdd9Lvlbijp+oBmmSztyahhxULmVm41Qa8a0tMS4OtxjEIeEQ/t1uExGeAaT94jbWT1XiLcossfWLrGo2Pt4M3SmjSXBlJJVw/RRFi6b6dRPSs5n6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FmGA0vpI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FmGA0vpI"
Received: from CPC-namja-026ON.redmond.corp.microsoft.com (unknown [4.213.232.21])
	by linux.microsoft.com (Postfix) with ESMTPSA id B879020B7168;
	Mon, 10 Aug 2026 02:07:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B879020B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786352836;
	bh=aP+Szq1FgVdmKtut4AqYblFcxzvyIhDJq4aWTv43pM4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmGA0vpIITa1t3cnGHPp6hbpx5ttlLd3lihgXL9JsMZ9vT+09rk4r5XxE0gXo/6bW
	 Juxs3m4kaRvwSZ8XofRV/ExMfU4hgBfDAz2AndojxBcVhvDG485LEwwRjBbDHm/JaO
	 gsx3tIzuMlMadVShlG2Bo3IC6hAOeF8Nq8Fu6oJA=
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
Subject: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
Date: Mon, 10 Aug 2026 09:07:14 +0000
Message-ID: <20260810090716.2325295-3-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810090716.2325295-1-namjain@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fixup_irqs() re-injects a pending interrupt on its new target CPU by
looking at the outermost domain chip and invoking its irq_retrigger()
callback directly. That only works when the outermost chip happens to
install an irq_retrigger() callback, which is not guaranteed for every
irqchip and could lead to lost interrupts on CPU hot-unplug.

Use irq_chip_retrigger_hierarchy() instead, which walks up the interrupt
hierarchy until it finds a chip that implements irq_retrigger().

While at it, move the loop-local variables into the loop scope and use a
scoped guard for desc->lock.

VECTOR_RETRIGGERED is now set only when the retrigger succeeds
(irq_chip_retrigger_hierarchy() returns non-zero) instead of
unconditionally. This is harmless today since apic_retrigger_irq()
always returns 1, and arguably more correct. No functional change
intended for chips which already provide an irq_retrigger() callback
on the outermost domain.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/irq.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 30122f0b3af96..ef1bdd3c4659a 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -466,11 +466,6 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
 /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
 void fixup_irqs(void)
 {
-	unsigned int vector;
-	struct irq_desc *desc;
-	struct irq_data *data;
-	struct irq_chip *chip;
-
 	irq_migrate_all_off_this_cpu();
 
 	/*
@@ -489,22 +484,18 @@ void fixup_irqs(void)
 	 * vector_lock because the cpu is already marked !online, so
 	 * nothing else will touch it.
 	 */
-	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
-		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
+	for (unsigned int vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
+		struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
+
+		if (IS_ERR_OR_NULL(desc))
 			continue;
 
 		if (is_vector_pending(vector)) {
-			desc = __this_cpu_read(vector_irq[vector]);
-
-			raw_spin_lock(&desc->lock);
-			data = irq_desc_get_irq_data(desc);
-			chip = irq_data_get_irq_chip(data);
-			if (chip->irq_retrigger) {
-				chip->irq_retrigger(data);
+			guard(raw_spinlock)(&desc->lock);
+			if (irq_chip_retrigger_hierarchy(&desc->irq_data))
 				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
-			}
-			raw_spin_unlock(&desc->lock);
 		}
+
 		if (__this_cpu_read(vector_irq[vector]) != VECTOR_RETRIGGERED)
 			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
 	}
-- 
2.43.0

