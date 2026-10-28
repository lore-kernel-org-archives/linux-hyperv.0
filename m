Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793202969;
	b=LZbCGK5ecISqBP0meQNG1aF7pZedZSzPALKkKjp6UQWwydTEM0jbfst+2D7BlI4wfX+E
	 V4lCdhTci/thLRMZtV3Os418G0q2uM/bTqQ+8og+ujeCBv1m5eyxjdOxsgqQLvy7e8Nws
	 rcpzXFfUkxaG7WnzJO1nhJzX8w54+udQ2jzjVqoWZWP0dLu/hj5Xq2DVp93TLSv8EAJ/o
	 +c2RhYPz0MamgAB0e3+qZnExnm0IXiHBAfIElGgtsPqf5W2z/zVwR8KNAHdYMyqATiDM7
	 fJQyXuikFSNGlreuLojWe2dok2N1r9kthHKEowPrJiAq4KSgGo7H/sOjCRGfV1s2vSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793202969;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=LUX/pf2qabe/0ZyYMT/V3ospAZzmAY2TDXmNCn4mSD8=;
	b=jq/vwqoiEVaDCWNky2ZUY5Au9QrxnIk8r1jEo0Xv+tfGFN9/6mETyWla/ybybSxJcV46
	 mSmC7MMuksAcK8UkqBsswDBNYssMJ+xdOOLp4Tr2DpNyYWpoOGQbCMmAPddOlysBcod2j
	 OScShOmVHUBZJcr+o8JPw7jFJn25A4+EcMvIN1Vq6YjXPfqzhCtkfkk9CzWWtVscabaeb
	 pT/etMcRUIKE4AdzXQ73b/StYOTEGAzdmbiMYGqseRe2FNOFmjPO0QJp7XBOqMjcSAZHk
	 AtrN53kT67Hiscvo2/7PWTQvzzFiRWpcK/Njl3SKyttBiVaQKapeVzxgtN1mISB03RA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwZq8Aj8;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D93606A32F
	for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 15:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6D93606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=DwZq8Aj8
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ea138a3497so6948965ad.2
        for <linux-hyperv@vger.kernel.org>; Wed, 28 Oct 2026 08:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793202968; x=1793807768; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LUX/pf2qabe/0ZyYMT/V3ospAZzmAY2TDXmNCn4mSD8=;
        b=DwZq8Aj8iQIR0ry4jfYG8OYe/+7un/ONqnc8aUBYOPfe+540viFFVv/Ll1deO8AYYs
         gAnA9wSvR8pC3aBebJTALFOl9mYFhWF/8pBYafkD3ek9lVvCFg+CBkaJJ4HzjrlJDmCx
         srY/ArKw3nzFEHhJJAdZacWFca3nCF6ummkfhajjOLE+03iQ88Z1qkpcQbwhcEfaEvgn
         KhhTLZ2XCfJCeazIGobkTd67O02jdDSvqDOgeryO7lmFhmEPo2KG309xHKzg9h8+nTy1
         fW055+t++qFS4uo2hyZ50SALojt9CtQ/FAPJpC+jkszE0CryUCUu+LgRHDhjzgam+/9x
         Jemw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793202968; x=1793807768;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LUX/pf2qabe/0ZyYMT/V3ospAZzmAY2TDXmNCn4mSD8=;
        b=oXs3uzUC74DTHor8Youw380ayZI6xLw9465ze4a6W182yAGNOqrSZ4SpWBhrXtmclq
         OyUVu8iYkpe1IQt6pvx7f0FRjEnaiwpLWAN/5p0KjBc5y0x4MCcnxPv90DhTSl6wfPuw
         UvUp9bQV6rcPstHmzBtnIicCRn0Jl3LirjJL/SKWOVW1svCEte5B4eaEleNhpaS6rP0V
         RqHfWxDX8Jr4yu/b2+gjsxfuPob/4MOUv7nyaT3yembDvpqo6UTRiBGTjbe96gXXG/5F
         zMQ3Tkz5Hd8WRAVBL66QPi4g283P1pojckO/Ep+MYHeTCF5tGfTjVdZA+5hZfzEsn9qN
         YLrw==
X-Forwarded-Encrypted: i=1; AKwUvBxLpDZBqqWVrsCNSMkD8SExB2gVEjdekHnxoQ9C908m59YZ17m2hFZUqU81cBGK4/lmH3vg+9Uu5s7zFUI=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRboMbSkazkAyKgp/D/D6aruTbV2fVO6cKj3gJsriu3Xc5Wyy0
	UGwKHB2XFc2OJqMKfsId4pAATvX0Ck7t1Wu+RhL9rxpbxoTBQ1zUoQck
X-Gm-Gg: AYBFou22wTuSXkZdbAKW0d+uanhB2ArM/fdR4djqu7WDKt1nLUgHsz4wg7cdXfy3iAK
	N1gk2ZSTDHdLQhRzu0HN0flSUlXsjD/ESF3m05WeCM3/VimL5VEh41DSaLyDxAp6ZxuI5DcAs7E
	V1dm5/uO8+7G0Dv46RZCPDcyB7s23UwamqL25rqRZ9C+7GWrOgolqmJWwIIPCob9ot4Dri13MtK
	YOA+aa7/Ema04vXslH9OAYiMgXQjU6T8gKfvUMYnYkgMLRryuXVcchu5jshEpzP1/BMsZSptibp
	7rXvlIPFbEh/hHn0iI0J1xnJCGqEu8P1ak+ir454/MogkAQaTQaebJN1hGot6avSfAwWGiUlx55
	JIJecIo3XWfh5h6TicNrJCPI5Q7gDTO0ZKeBQrphxuGcbhQurVhfhA78MiheuxQR5AyVALpaUiq
	2Oz6PVHp1eoLWpYZzYtvpgw1hf2U8jp2tKWGybqk6H0R+CmGdw7OKYqRE32xJ0V3YKnpzj55eOL
	PvTR8QS1JFjEynnSwqeHc39qDCQEMFhCHfZvBJWJ/urIe1tckzpTjRZp9ls7oUvEPKBzefSz+t4
	Nuu0CIHDWgx938PXU3qRTH1kttPg3d5xPWdL62COXsNu7ublla0/cdmGjNdhz7hLtMC7ZkVjyLQ
	fV77OXfrs9HAm+PO/5KpuTuuODDm9SCitkMVcywVnpnCKr+4FZJ0ooQ==
X-Received: by 2002:a17:902:da85:b0:2e5:6158:b9c1 with SMTP id d9443c01a7336-2eb00468987mr25712445ad.47.1793202967907;
        Wed, 28 Oct 2026 08:56:07 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eae6b7cdebsm24361285ad.12.2026.10.28.08.56.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 08:56:06 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH v3 1/1] PCI: hv: Spread load across CPUs when selecting effective affinity CPU
Date: Wed, 28 Oct 2026 08:55:59 -0700
Message-Id: <20261028155559.138833-1-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
Reply-To: mhklinux@outlook.com
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a system with multiple devices with the same configuration (such as
NVMe controllers), the affinity masks are the same for all such devices.
Linux typicaly must select a single CPU from each mask to be the effective
affinity. If a fixed algorithm is used, such as picking the first CPU
in the mask, interrupts from multiple devices are assigned to the same
CPUs, while other CPUs are not assigned any interrupts, producing an
interrupt load imbalance.

On x86, the "APIC" IRQ chip avoids this problem by spreading the
interrupts across the CPUs in an affinity mask. It tracks the number
of IRQs assigned to each CPU, and chooses the CPU in the mask that
has the fewest assignments. Because Hyper-V vPCI device IRQs eventually
parent to APIC, the spreading done by APIC accrues to Hyper-V vPCI
devices, so all is good in x86 systems.

On arm64, the "ITS" IRQ chip for the GICv3+ITS does the same kind of
spreading for LPI interrupts. But Hyper-V provides guest VMs only with
a virtual GICv3, not including an ITS or LPI support. IRQs for vPCI
devices on arm64 are mapped to SPIs and parented to the "GICv3" IRQ
chip. The GICv3 IRQ chip always chooses the first CPU in the affinity
mask as the effective affinity, producing an interrupt load imbalance
for Hyper-V vPCI devices in arm64 systems.

The Hyper-V vPCI driver already has an arm64-specific IRQ chip to
allocate and managed SPIs for use by vPCI devices. Solve the imbalance
problem by extending this IRQ chip to implement a "set affinity"
function that tracks SPIs assigned to each CPU, and chooses the
least-loaded CPU as the effective affinity. Then invoke the parent
IRQ chip (GICv3) to actually set that single CPU as the effective
affinity in the virtual GICv3 hardware. As a result, IRQs are spread
across CPUs like on x86 and interrupt load imbalances are avoided.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
Tested-by: Naman Jain <namjain@linux.microsoft.com>
---
As an alternative, this spreading functionality could be implementedi
for SPIs directly in the GICv3 IRQ chip, similar to what the ITS IRQ
chip already has for LPIs. While Hyper-V's scheme of using SPIs for
vPCI interrupts is allowed by the arm64 architecture, it's atypical.
So the original decision was for the Hyper-V vPCI driver to handle
the allocation and management of SPIs for this purpose rather than do
it in generic GIC code. That led of the introduction of the "MSI" IRQ
chip in the Hyper-V vPCI driver. This implementation of the spreading
functionality follows that original decision by extending the "MSI"
IRQ chip. If reviewers have reasons to prefer enhancing the GICv3 IRQ
chip driver instead, I'm open to doing that.

I have not added any documentation to Documentation/virt/hyperv/vpci.rst.
That documentation needs an entirely new section on the IRQ domains
and chips, and their hierarchy differences on x86 and arm64. I'm
working on a separate patch to add that documentation. But I don't
want to hold up this improvement for that larger documentation task.

Changes in v3:
* Moved checks for cpu < nr_cpu_ids inside hv_pci_inc/dec_spi_count()
  to reduce duplication and code clutter. [Naman Jain]

Changes in v2:
* Added call to irqd_set_affinity_no_activate() so cpu_spi_count is
  not corrupted by affinity changes to inactive IRQs [Sashiko]
* Added comment for hv_pci_vec_irq_domain_activate about why it's
  OK for always choose the initial CPU even though that biases
  the spreading algorithm against that CPU [Sashiko]
* In hv_pci_arm64_set_affinity(), updates to the SPI counts and the
  selection of a new CPU are made atomic via a raw spin lock, like the
  x86 "VECTOR" IRQ chip (though not the arm64 "ITS" IRQ chip). As a
  result, struct cpu_spi_count no longer needs atomic_t. [Naman Jain]
* Changed back to using cpu_present_mask instead of cpu_online_mask
  in hv_pci_vec_irq_domain_activate() since the change wasn't
  necessary. [Naman Jain]
* Minor formatting changes to meet checkpatch --strict requirements.
  [Naman Jain]

 drivers/pci/controller/pci-hyperv.c | 164 +++++++++++++++++++++++++++-
 1 file changed, 161 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 824cf27e85e6..5ad12ac41f30 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -743,10 +743,139 @@ struct hv_pci_chip_data {
 /* Hyper-V vPCI MSI GIC IRQ domain */
 static struct irq_domain *hv_msi_gic_irq_domain;
 
+/*
+ * Data structures and helper functions for spreading the CPU in the
+ * affinity mask that is picked for the effective affinity. Such
+ * spreading is done by the "APIC" IRQ chip on x86 and by the
+ * "ITS" chip for LPIs with GICv3+ITS on arm64. But Hyper-V provides
+ * only a GICv3 with SPIs (no ITS or LPIs) to arm64 guests. For SPIs
+ * the "GICv3" IRQ chip always picks the first CPU in the affinity mask,
+ * which can overload that CPU and reduce parallelism in processing
+ * interrupts.
+ *
+ * While the Hyper-V configuration is architecturally allowed, it's not
+ * typical, so the spreading is done here in pci-hyperv.c with the "MSI"
+ * IRQ chip parented to "GICv3". Track how many SPIs have been assigned
+ * to each CPU, and use that data to spread the IRQ load evenly across
+ * the CPUs instead of just picking the first CPU. The code follows a
+ * pattern similar to the spreading logic for the "ITS" IRQ chip.
+ */
+
+struct cpu_spi_count {
+	/* Index 0 is unmanaged. Index 1 is managed. */
+	unsigned int	count[2];
+};
+
+static DEFINE_PER_CPU(struct cpu_spi_count, cpu_spi_count);
+static DEFINE_RAW_SPINLOCK(cpu_spi_count_lock);
+
+static void hv_pci_inc_spi_count(struct irq_data *d, int cpu)
+{
+	int idx = irqd_affinity_is_managed(d);
+
+	if (cpu < nr_cpu_ids)
+		per_cpu_ptr(&cpu_spi_count, cpu)->count[idx]++;
+}
+
+static void hv_pci_dec_spi_count(struct irq_data *d, int cpu)
+{
+	int idx = irqd_affinity_is_managed(d);
+
+	if (cpu < nr_cpu_ids)
+		per_cpu_ptr(&cpu_spi_count, cpu)->count[idx]--;
+}
+
+static unsigned int
+hv_pci_arm64_get_min_load_and(struct irq_data *d,
+			      const struct cpumask *cpu_mask1,
+			      const struct cpumask *cpu_mask2)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX, this_count;
+	int idx = irqd_affinity_is_managed(d);
+
+	for_each_cpu_and(tmp, cpu_mask1, cpu_mask2) {
+		this_count = per_cpu_ptr(&cpu_spi_count, tmp)->count[idx];
+		if (this_count < count) {
+			cpu = tmp;
+			count = this_count;
+		}
+	}
+
+	return cpu;
+}
+
+static unsigned int hv_pci_arm64_get_min_load(struct irq_data *d,
+					      const struct cpumask *cpu_mask)
+{
+	return hv_pci_arm64_get_min_load_and(d, cpu_mask, cpu_possible_mask);
+}
+
+static int hv_pci_arm64_select_cpu(struct irq_data *d,
+				   const struct cpumask *aff_mask)
+{
+	int cpu;
+
+	if (irqd_affinity_is_managed(d))
+		cpu = hv_pci_arm64_get_min_load(d, aff_mask);
+
+	else if (cpumask_intersects(aff_mask, cpu_online_mask))
+		/* Try the intersection of the affinity and online masks */
+		cpu = hv_pci_arm64_get_min_load_and(d, aff_mask, cpu_online_mask);
+
+	else
+		/* If that doesn't fly, the online mask is the last resort */
+		cpu = hv_pci_arm64_get_min_load(d, cpu_online_mask);
+
+	pr_debug("IRQ%d -> %*pbl CPU%d\n", d->irq, cpumask_pr_args(aff_mask), cpu);
+
+	return cpu;
+}
+
+/*
+ * Track the count of SPIs assigned to each CPU. Pick a single CPU from the
+ * affinity mask based on the SPI loading data, and have the parent IRQ
+ * chip (should be "GICv3") set the effective affinity to that single CPU.
+ */
+static int hv_pci_arm64_set_affinity(struct irq_data *d,
+				     const struct cpumask *mask_val,
+				     bool force)
+{
+	unsigned int cpu, prev_cpu;
+	int ret;
+
+	prev_cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
+
+	scoped_guard(raw_spinlock_irqsave, &cpu_spi_count_lock) {
+		hv_pci_dec_spi_count(d, prev_cpu);
+
+		if (force)
+			cpu = hv_pci_arm64_get_min_load(d, mask_val);
+		else
+			cpu = hv_pci_arm64_select_cpu(d, mask_val);
+
+		if (cpu >= nr_cpu_ids) {
+			hv_pci_inc_spi_count(d, prev_cpu);
+			return -EINVAL;
+		}
+
+		hv_pci_inc_spi_count(d, cpu);
+	}
+
+	ret = irq_chip_set_affinity_parent(d, cpumask_of(cpu), force);
+	if (ret < 0) {
+		guard(raw_spinlock_irqsave)(&cpu_spi_count_lock);
+		hv_pci_inc_spi_count(d, prev_cpu);
+		hv_pci_dec_spi_count(d, cpu);
+	}
+
+	return ret;
+}
+
 /* Hyper-V PCI MSI IRQ chip */
 static struct irq_chip hv_arm64_msi_irq_chip = {
 	.name = "MSI",
-	.irq_set_affinity = irq_chip_set_affinity_parent,
+	.irq_set_affinity = hv_pci_arm64_set_affinity,
 	.irq_eoi = irq_chip_eoi_parent,
 	.irq_mask = irq_chip_mask_parent,
 	.irq_unmask = irq_chip_unmask_parent
@@ -874,6 +1003,12 @@ static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
 					      hwirq + i,
 					      &hv_arm64_msi_irq_chip,
 					      domain->host_data);
+		/*
+		 * Defer affinity changes on inactive IRQs so the cpu_spi_count
+		 * can be maintained for spreading purposes.
+		 */
+		irqd_set_affinity_on_activate(irq_get_irq_data(virq + i));
+
 		pr_debug("pID:%d vID:%u\n", (int)(hwirq + i), virq + i);
 	}
 
@@ -881,25 +1016,48 @@ static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
 }
 
 /*
- * Pick the first cpu as the irq affinity that can be temporarily used for
+ * Pick the first CPU as the irq affinity that can be temporarily used for
  * composing MSI from the hypervisor. GIC will eventually set the right
  * affinity for the irq and the 'unmask' will retarget the interrupt to that
- * cpu.
+ * CPU.
+ *
+ * The first CPU is always used for initial activation because spreading the
+ * initial CPU would have to be done without information about affinity groups
+ * that may exist. The resulting assignments would pollute the "least loaded"
+ * data for making the final assignments. Everything would still work, but the
+ * spreading would be less even than it could be. This approach typically
+ * produces a large count on the initial CPU until the final affinity
+ * assignments are made, and hence biases the spreading against that initial
+ * CPU. But that's OK because that initial CPU is used for interrupts not
+ * tracked here, such as VMBus slow-speed devices and the PL011 console UART.
  */
 static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
 					  struct irq_data *irqd, bool reserve)
 {
 	int cpu = cpumask_first(cpu_present_mask);
 
+	scoped_guard(raw_spinlock_irqsave, &cpu_spi_count_lock)
+		hv_pci_inc_spi_count(irqd, cpu);
 	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
 
 	return 0;
 }
 
+static void hv_pci_vec_irq_domain_deactivate(struct irq_domain *domain,
+					     struct irq_data *irqd)
+{
+	int cpu;
+
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+	guard(raw_spinlock_irqsave)(&cpu_spi_count_lock);
+	hv_pci_dec_spi_count(irqd, cpu);
+}
+
 static const struct irq_domain_ops hv_pci_domain_ops = {
 	.alloc	= hv_pci_vec_irq_domain_alloc,
 	.free	= hv_pci_vec_irq_domain_free,
 	.activate = hv_pci_vec_irq_domain_activate,
+	.deactivate = hv_pci_vec_irq_domain_deactivate,
 };
 
 #ifdef CONFIG_OF
-- 
2.25.1

