Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C444213B;
	Mon, 14 Sep 2026 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789384753; cv=none; b=KOuLnXsObw2rj7JQQ91Gw37hLBIpAtkj+eKCIlzPC4Tjm3Dp+6M58DSLIv2rShB0nRp7zTjkNeQmCGLSS3YFDxxox22vKJP4ex92pojmt2q4WtSc38jiCnXNqEJd3NTxOAcx23uaYq+Sv9eCPr6Fj9CtHPctWPJClUmdT7oqqIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789384753; c=relaxed/simple;
	bh=IAj6O9TWB5j3sb7TuZQBxiu5BFrNeDP365fgK1xbVL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rxE+PYhb3GW3fIioAu10rcIXh9A6WM7Y6QnslkgP+2sxZ7RVfqqnULHIOjpSIS8kOY8mjK7JjuGQxwOw7YRwUXUxS3ykFuv2EJj3UnDDg0RMVc/5hak5+QjMfIxqKjXUUllQVE45+uBzTRHZvgW8p0voIArqvur/+9EWn0yTxyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=E5MTN+SK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="E5MTN+SK"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id 32B2B20B7168;
	Mon, 14 Sep 2026 04:18:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 32B2B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789384707;
	bh=Utg+w+7CqN11KK2BGZ+VSQWhLTxBwfn5P+4AvosbRBU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E5MTN+SKwsaw9OpI3rZxDaLRSFuekOJbT8awTJ20lJM3Zt7HtVw5q71Z70nHu15i0
	 26rMJ6pNSiLT1kMQ8knt/yFXGNo/nfNtq06PDm1pnXmIuMg53+PdzjuN6YvY2AlLax
	 ewiceQxAFoMOHBu0x2J19T4mWkNxADC0tqC1KPoM=
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
Subject: [PATCH v5 2/4] x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()
Date: Mon, 14 Sep 2026 11:18:34 +0000
Message-ID: <20260914111836.2119301-3-namjain@linux.microsoft.com>
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

fixup_irqs() re-injects a pending interrupt on its new target CPU by
looking at the outermost domain chip and invoking its irq_retrigger()
callback directly. When the outermost chip does not implement
irq_retrigger(), the pending interrupt is silently dropped, which can
lead to lost interrupts on CPU hot-unplug.

Use irq_chip_retrigger_hierarchy() instead, which walks up the interrupt
hierarchy until it finds a chip that implements irq_retrigger().

While at it, use a scoped guard for desc->lock. VECTOR_RETRIGGERED is
now set only when the retrigger succeeds instead of unconditionally,
which is harmless today since apic_retrigger_irq() always returns 1.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/irq.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 30122f0b3af96..acdc1145cce6d 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -469,7 +469,7 @@ void fixup_irqs(void)
 	unsigned int vector;
 	struct irq_desc *desc;
 	struct irq_data *data;
-	struct irq_chip *chip;
+	int ret;
 
 	irq_migrate_all_off_this_cpu();
 
@@ -490,21 +490,19 @@ void fixup_irqs(void)
 	 * nothing else will touch it.
 	 */
 	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
-		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
+		desc = __this_cpu_read(vector_irq[vector]);
+
+		if (IS_ERR_OR_NULL(desc))
 			continue;
 
 		if (is_vector_pending(vector)) {
-			desc = __this_cpu_read(vector_irq[vector]);
-
-			raw_spin_lock(&desc->lock);
+			guard(raw_spinlock)(&desc->lock);
 			data = irq_desc_get_irq_data(desc);
-			chip = irq_data_get_irq_chip(data);
-			if (chip->irq_retrigger) {
-				chip->irq_retrigger(data);
+			ret = irq_chip_retrigger_hierarchy(data);
+			if (ret)
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

