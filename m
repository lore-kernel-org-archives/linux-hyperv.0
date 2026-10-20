Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792520685;
	b=xMFtwE2SEPbnL1I1xBySAgTBXMiLqFGwNaJQuB4LifxOeeCgiwK/Eip8D+sgMt/1iYjf
	 YEzGMs8GdGtcm+2i+J+9/oxNZPMIb0eYOSfQLPpntHwVZpWE/m7NksDnTfSUWUdsGvXCs
	 1UUndFfeepFElpxMh324gxchaoVRtRccVE1MfSe3IFH2BIR2CS0nTavxPIbfCtbk9A31T
	 3eajbw1tff2wA+d/L8IRLOS2uQ4AIt5kaclCTpWKcVi8PNaGR2vjWkv2wkyAaP8fLdoKY
	 N/HJXtELO7M5oIwXSqnNwL1Y6/viDxgDUoiy1un6Gr+GB8dYafA5+cgKMheBrLgyIQw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792520685;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=X9IgOVKkLpQ1ZKnnSNRsmikwcvRAYdkY+NKhG4LXiUE=;
	b=mfztr7Tfa8J1iPbhnXDW+SsqsdR2TmMyyRpt7bG0zDJmKMy11aSRRj5iB9vdhKXXYQg+
	 BWYm5fv9/gP0a3HYufILJxD5p3cEEyls2ZnLxTCiS8mb4iTrlDRKoeV2iMYTqSwfPPU5h
	 hnfetNn5IhNLsOT1qKGXVQfx0Uah4PuwL/R+VsJH9umBaq35easdlJ6gPsNQy+KTJbawk
	 ZeW6eMcy/8qrpEjO2Bt4T3zeaez1Diao6BuS26kaO4/Nw4HF61gYyJW2xMrxjVo7hC7Ff
	 PqehTyq4mYOMwCUj0Q3Rbdmzp20fwGKBx6oQAUYY+Z/IO+T0txtTNEtKP7Mvo2/VQmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bIYqeafH;
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74428606A31D
	for <linux-hyperv@vger.kernel.org>; Tue, 20 Oct 2026 18:24:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74428606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bIYqeafH
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ac7c7b3a90so1677369a91.3
        for <linux-hyperv@vger.kernel.org>; Tue, 20 Oct 2026 11:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792520684; x=1793125484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=X9IgOVKkLpQ1ZKnnSNRsmikwcvRAYdkY+NKhG4LXiUE=;
        b=bIYqeafHaX8PX++2LHb1j07gXXgFIeJcbT9Bi7cK64iwIj2rPqq4AE+TcNn9cN3OPP
         evaUU6idlsW4MkJX5vHfhD8FbJRd2GPrEwmsm4QqxKa5TF3eNQQ9T3KCJ38trkv7Rmw1
         x3IvoKO4PkrfrmiKM4UowPDAC7FPmBQk09DQLDI8rf2A6Cp07Krn1C3o68wncKGHbtyb
         Jz94vWUAXQ9LjeOB3XLQhXhFKskNOsaXkcs438BkIzgmCnB03gwf4sWd6pDM/EG021lx
         sY+BDr9o52pZ77PiP6N9tpzzN4kmXa2Fw+OZwO91quZXgUUlK5Z60nbewAryqKfWLbo8
         YcfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792520684; x=1793125484;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=X9IgOVKkLpQ1ZKnnSNRsmikwcvRAYdkY+NKhG4LXiUE=;
        b=FBHIbUWdaOsjOfsQqS8e3uTQs7Dipxl7xOkGTveCwBGvtRptbajL7AGgKkId3eCtnf
         fjFR4l09yqeSI1YxFzmkgFcAxmGBygHi+UADOH1Rw3oYKHrNcYmPpDSaqvtg/Rws4+Zt
         i5cPijbOHfxs12OeyMFSLOp3aSz30sWcxp9va7a8/dMAHbOTraK7FA7cuyhhoT4szIpG
         F/9KCgAv1+pJm/Kxt1rUpD+LzUDEoQ+ltNgbAnTpN899bIMyQo3DToN85mj2obhUtJyH
         jgKHJ2g8xeIJGQ11hp19X86ZXLQOe9pTeZuRxjl1b8n2udWKmoC63KldT606AdiKZuMz
         h7Ew==
X-Forwarded-Encrypted: i=1; AKwUvBy0j270pqKuc0/NHsZXo2WQlQdq3RQMt7qo8HCq6uqBcaV5jCkLNS8I8nTG5l1nLQENcg564/pFkOe9RUs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyzmjawjQg7i/79bA+4ly5MFze9jsySkTEE52Di74dy4TWb/BU
	kzdTe3fDQJApC1DHYT0r0oXqfIl/dRy/Pg36QDXFfkFgPi1CWgNGrH3R
X-Gm-Gg: AYBFou0o1154SZDE93M98MSCKeMl8+/7JunlUhR2DtSg3HbTQhJlzcBE9umEGGAJlhH
	qaZOgDEfmOc+XsrugJRrcP6M23SgB6bYiuNu3PibkyY81cfaE7Q7RfBJmGmFsH/UuVlK2B8hhHu
	oj3MkuhK28G2eEHRkbItMqVmGL0ipR9pJgA/AWJUttJhc+9UfUiahcOlyTK2M8KaLo1hVZmFQqN
	BGM8tlgw35eMkGU3x9xAa8CJmE4Bepa+4uPA0TXBMJGeAjqMCWTO0RIu+ro14h7OnHZmB4vQxZs
	x7sCh6EvC6ADZCq+1SCm3UvIPAq2DoFpMPvrVL9OIb2t1KagWXEYNNITmzJIP1U5p0ddwLUn12x
	H1k3Y0e88rVVgHkmeWw9CnEquHi4InPfHt8c5JfUwNR61ORDVzgmf3QGlovslGgVlz/VIbETTJS
	/4RD/FPSoZx5sfT7DFyZuzswoKtsDDGWlgUFW6tDiXdpAwgal+104a+9Rhq4vn0PMY0WPdz+8Ce
	fl2hB341ihZYF3BPKXRWvmus4fihCsUS3xuyPyE9k6ySGiVCe+13+r1jKoSEmOTOmBYI7QT30s=
X-Received: by 2002:a17:90a:d010:b0:3aa:ff61:9504 with SMTP id 98e67ed59e1d1-3acef134b64mr9721601a91.20.1792520683712;
        Tue, 20 Oct 2026 11:24:43 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b464dd7sm2159985ad.52.2026.10.20.11.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 11:24:43 -0700 (PDT)
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
Subject: [PATCH 1/1] PCI: hv: Spread load across CPUs when selecting effective affinity CPU
Date: Tue, 20 Oct 2026 11:24:33 -0700
Message-Id: <20261020182433.336637-1-mhklinux@outlook.com>
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
---
As an alternative, this spreading functionality could be implemented
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

 drivers/pci/controller/pci-hyperv.c | 144 +++++++++++++++++++++++++++-
 1 file changed, 142 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 85d826f8f68d..1706090cebeb 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -746,10 +746,132 @@ struct hv_pci_chip_data {
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
+	atomic_t	count[2];
+};
+
+static DEFINE_PER_CPU(struct cpu_spi_count, cpu_spi_count);
+
+static void hv_pci_inc_spi_count(struct irq_data *d, int cpu)
+{
+	int idx = irqd_affinity_is_managed(d);
+
+	atomic_inc(&per_cpu_ptr(&cpu_spi_count, cpu)->count[idx]);
+}
+
+static void hv_pci_dec_spi_count(struct irq_data *d, int cpu)
+{
+	int idx = irqd_affinity_is_managed(d);
+
+	atomic_dec(&per_cpu_ptr(&cpu_spi_count, cpu)->count[idx]);
+}
+
+static unsigned int hv_pci_arm64_get_min_load_and(struct irq_data *d,
+					   const struct cpumask *cpu_mask1,
+					   const struct cpumask *cpu_mask2)
+{
+	unsigned int cpu = nr_cpu_ids, tmp;
+	int count = S32_MAX, this_count;
+	int idx = irqd_affinity_is_managed(d);
+
+	for_each_cpu_and(tmp, cpu_mask1, cpu_mask2) {
+		this_count = atomic_read(
+				&per_cpu_ptr(&cpu_spi_count, tmp)->count[idx]);
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
+				       const struct cpumask *cpu_mask)
+{
+	return hv_pci_arm64_get_min_load_and(d, cpu_mask, cpu_possible_mask);
+}
+
+static int hv_pci_arm64_select_cpu(struct irq_data *d,
+			  const struct cpumask *aff_mask)
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
+	if (prev_cpu < nr_cpu_ids)
+		hv_pci_dec_spi_count(d, prev_cpu);
+
+	if (force)
+		cpu = hv_pci_arm64_get_min_load(d, mask_val);
+	else
+		cpu = hv_pci_arm64_select_cpu(d, mask_val);
+
+	if (cpu >= nr_cpu_ids)
+		goto err;
+
+	ret = irq_chip_set_affinity_parent(d, cpumask_of(cpu), force);
+	if (ret < 0)
+		goto err;
+
+	hv_pci_inc_spi_count(d, cpu);
+	return ret;
+
+err:
+	if (prev_cpu < nr_cpu_ids)
+		hv_pci_inc_spi_count(d, prev_cpu);
+	return -EINVAL;
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
@@ -888,21 +1010,39 @@ static int hv_pci_vec_irq_domain_alloc(struct irq_domain *domain,
  * composing MSI from the hypervisor. GIC will eventually set the right
  * affinity for the irq and the 'unmask' will retarget the interrupt to that
  * cpu.
+ *
+ * The first cpu is always used for initial activation because spreading the
+ * initial CPU would have to be done without information about affinity groups
+ * that may exist. The resulting assignments would pollute the "least loaded"
+ * data for making the final assignments. Everything would still work, but
+ * the spreading would be less even than it could be.
  */
 static int hv_pci_vec_irq_domain_activate(struct irq_domain *domain,
 					  struct irq_data *irqd, bool reserve)
 {
-	int cpu = cpumask_first(cpu_present_mask);
+	int cpu = cpumask_first(cpu_online_mask);
 
+	hv_pci_inc_spi_count(irqd, cpu);
 	irq_data_update_effective_affinity(irqd, cpumask_of(cpu));
 
 	return 0;
 }
 
+static void hv_pci_vec_irq_domain_deactivate(struct irq_domain *domain,
+					     struct irq_data *irqd)
+{
+	int cpu;
+
+	cpu = cpumask_first(irq_data_get_effective_affinity_mask(irqd));
+	if (cpu < nr_cpu_ids)
+		hv_pci_dec_spi_count(irqd, cpu);
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

