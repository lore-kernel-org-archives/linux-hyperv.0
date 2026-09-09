Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7D93B4E9E;
	Wed,  9 Sep 2026 06:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936322; cv=none; b=UJmdTn26T04yR+VFahayX71tEqqxcY7bu9cQXgkH4F22Djqew06/tk0jJcgwywvhbMaAv716vdMBH7pFc+Abnw17eb/GVclmW0xtu5IjoHp3Pe9JVh4lkfOvhfDe2drfjEEgOrUx2M0f+LXg5RCgcMM65Loc1r7IuWRklqfsGN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936322; c=relaxed/simple;
	bh=ACtM0ln6JZ2gAJn8zdqUiPxoN1dOvYPm/vxZH7yp738=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0mnBhxt6mVp6B6Mk/EvW9ZifyWzJrLzenA0jO3kddq0cIv/26kTrGis8bNNY0ZwwclY856xqkmY81cjqU0JjYFgYYBuJCFyiIALMsSVb9pjTFhHb9c4WrsA5Uy7cEKeoEsPlaEJRHqmR/eVVQ9zUdRyVLRm43Lgut5GYTyPr1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kJ1Uv2jx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kJ1Uv2jx"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.16])
	by linux.microsoft.com (Postfix) with ESMTPSA id D7E0220B7135;
	Tue,  8 Sep 2026 23:44:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D7E0220B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788936280;
	bh=25n1hifoI7H95J5sd4UpdUDOwzl+ABM/W2jzOhr2TeE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kJ1Uv2jx0Ith/mxvfI/zV3pQuRvfhXU0fyl2Y/abI2YwMkRICf8FBQtfUncDmQG08
	 9t3eMPBzl+HMTpL0nrY8m8+fwdzj3ZZIUY5okXWaJriOQvG8NunQtlWwSB2RqfYwIl
	 458yBUTDuhLb/HPEfcL0jyYECeFfO8gKsZYvNTuw=
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
Subject: [PATCH v4 2/4] x86/irq: Fall back to irq_chip_retrigger_hierarchy() in fixup_irqs()
Date: Wed,  9 Sep 2026 06:44:46 +0000
Message-ID: <20260909064448.1004-3-namjain@linux.microsoft.com>
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

fixup_irqs() re-injects a pending interrupt on its new target CPU by
looking at the outermost domain chip and invoking its irq_retrigger()
callback directly. When the outermost chip does not implement
irq_retrigger(), the pending interrupt is silently dropped, which can
lead to lost interrupts on CPU hot-unplug.

Keep calling the outermost chip's irq_retrigger() when it is present,
but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
up the interrupt hierarchy until it finds a chip that implements
irq_retrigger().

While at it, use a scoped guard for desc->lock. VECTOR_RETRIGGERED is
now set only when the retrigger succeeds instead of unconditionally,
which is harmless today since apic_retrigger_irq() always returns 1.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
---
 arch/x86/kernel/irq.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 30122f0b3af96..e0163f7ac7368 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -470,6 +470,7 @@ void fixup_irqs(void)
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
+	int ret;
 
 	irq_migrate_all_off_this_cpu();
 
@@ -490,21 +491,23 @@ void fixup_irqs(void)
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
 			chip = irq_data_get_irq_chip(data);
-			if (chip->irq_retrigger) {
-				chip->irq_retrigger(data);
+			if (chip->irq_retrigger)
+				ret = chip->irq_retrigger(data);
+			else
+				ret = irq_chip_retrigger_hierarchy(data);
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

