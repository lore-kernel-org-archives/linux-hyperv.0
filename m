Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8EE357D12;
	Fri,  9 Oct 2026 15:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791559844; cv=none; b=Ju+kFsdvc5J0+Nqgutrrq7GV0IT6xi9zysYfliY1B949pvEv6bKVXYlftllwfeuIbZzv3rw87Qyl65gjVwCzJeX9ao1iki+akx6l1fW2am6oLhceKwqkidy1WMB8qDMhjjsjXq15djAAdsdIA3BJIzOk3pZlKe5E/Wkgsf26Brk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791559844; c=relaxed/simple;
	bh=eEJy9KhChJUFb+ZeUcA6hHLSY/lviOE0NI4PduGWKoM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FY0cX4+J0pRupN4njup/hTmWF2AZ1wittRXldGylgmDDgSRkcI+GV4mdXYh9b8MZdxgMBpY3LfBFk4yrrL4/2M8Niww/R6mx4J6zHw7Xh8HX1eXVw78/H/5PbfwGfX4bOFW5ew9sjbIMIBgaUw+prRGH4fLLFAfcCe57dJgFQh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ICFtK/An; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ICFtK/An"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A8421F000FF;
	Fri,  9 Oct 2026 15:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791559842;
	bh=SgWsZz5AlYvBRDKN8E6Dsq0TdSgrfowLNWfm0ObfdeI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ICFtK/An9+/0RXqBL51h3xD9xi/ggpTy+N2hPYKSQEHgCDT8e358TlEMxUm3dl7YB
	 Dx/1IzD49YKJdl/ZM0VgzHPaAqtGxsNIH41ETB/FJ2MW7wCNMJRPx7dnhF0CibrC8U
	 LdoOcjvjA+W14eIk/owf1JcHDVeF3uNT/1CUUV6Gvu7BZbNEgWVaU2AG02cSKa1DIi
	 XML3DCwhlGINBV2mhfe0tOPs38Ab6wbnd4AADl5H/gwW0RFksCA+97yowAyP1vw335
	 /fZM1uDXA5ElHwj/hkax4nuxuMZ9302/jbZgJqw6FV5/WOVMjkeXCWoNLbD0uU8Ieg
	 hCRAYE83+/jiw==
Date: Fri, 9 Oct 2026 09:30:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is
 needed
Message-ID: <askIoNon8UVyNJiJ@kbusch-mbp>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <20261009050556.2817978-4-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009050556.2817978-4-namjain@linux.microsoft.com>

On Fri, Oct 09, 2026 at 05:05:56AM +0000, Naman Jain wrote:
>  static irqreturn_t nvme_irq(int irq, void *data)
>  {
>  	struct nvme_queue *nvmeq = data;
>  	DEFINE_IO_COMP_BATCH(iob);
>  
> +	if (unlikely(test_and_clear_bit(NVMEQ_IRQ_POLL_HANDOFF,
> +					&nvmeq->flags))) {
> +		if (!nvme_cqe_pending(nvmeq))
> +			return IRQ_HANDLED;
> +	}
> +	if (unlikely(test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
> +		     (!test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) ||
> +		      test_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags) ||
> +		      READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) !=
> +				pci_channel_io_normal)))
> +		return IRQ_HANDLED;
> +
> +	if (unlikely(in_hardirq() &&
> +		     test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) &&
> +		     !test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
> +		     need_resched() && nvme_cqe_pending(nvmeq) &&
> +		     !test_and_set_bit_lock(NVMEQ_IRQ_POLL, &nvmeq->flags))) {
> +		set_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
> +		disable_irq_nosync(irq);
> +		irq_poll_sched(&nvmeq->iopoll);
> +		return IRQ_HANDLED;
> +	}

The disable_irq_nosync still does non-posted transactions for msi and
msi-x. NVMe has a shortcut for msi, but there's currently nothing for
msi-x. For that case, I have a prep patch I consulted with Thomas, and
the result is below. I'm delayed sending it out while catching up from
travel, but I think this will be even more efficient.

---
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 45e0ed3134ce1..bff622b4839aa 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -126,6 +126,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	 */
 	if (info->flags & MSI_FLAG_PCI_MSI_MASK_PARENT) {
 		chip->irq_mask		= irq_chip_mask_parent;
+		chip->irq_mask_nowait	= NULL;
 		chip->irq_unmask	= irq_chip_unmask_parent;
 	}
 
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 6e65f0f44112e..92a53c2772659 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -162,6 +162,11 @@ static void pci_irq_mask_msix(struct irq_data *data)
 	pci_msix_mask(irq_data_get_msi_desc(data));
 }
 
+static void pci_irq_mask_nowait_msix(struct irq_data *data)
+{
+	pci_msix_mask_nowait(irq_data_get_msi_desc(data));
+}
+
 static void pci_irq_unmask_msix(struct irq_data *data)
 {
 	pci_msix_unmask(irq_data_get_msi_desc(data));
@@ -182,6 +187,7 @@ static const struct msi_domain_template pci_msix_template = {
 		.irq_startup		= pci_irq_startup_msix,
 		.irq_shutdown		= pci_irq_shutdown_msix,
 		.irq_mask		= pci_irq_mask_msix,
+		.irq_mask_nowait	= pci_irq_mask_nowait_msix,
 		.irq_unmask		= pci_irq_unmask_msix,
 		.irq_write_msi_msg	= pci_msi_domain_write_msg,
 		.flags			= IRQCHIP_ONESHOT_SAFE,
diff --git a/drivers/pci/msi/msi.h b/drivers/pci/msi/msi.h
index 0b420b319f50f..337ff9d9da0ed 100644
--- a/drivers/pci/msi/msi.h
+++ b/drivers/pci/msi/msi.h
@@ -40,10 +40,16 @@ static inline void pci_msix_write_vector_ctrl(struct msi_desc *desc, u32 ctrl)
 		writel(ctrl, desc_addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
-static inline void pci_msix_mask(struct msi_desc *desc)
+/* Posted write only: the device may still send an interrupt after return */
+static inline void pci_msix_mask_nowait(struct msi_desc *desc)
 {
 	desc->pci.msix_ctrl |= PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	pci_msix_write_vector_ctrl(desc, desc->pci.msix_ctrl);
+}
+
+static inline void pci_msix_mask(struct msi_desc *desc)
+{
+	pci_msix_mask_nowait(desc);
 	/* Flush write to device */
 	readl(desc->pci.mask_base);
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3bf969ad8fe07..d40c992ddb8a1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -231,6 +231,7 @@ extern void devm_free_irq(struct device *dev, unsigned int irq, void *dev_id);
 
 bool irq_has_action(unsigned int irq);
 extern void disable_irq_nosync(unsigned int irq);
+extern void disable_irq_nowait(unsigned int irq);
 extern bool disable_hardirq(unsigned int irq);
 extern void disable_irq(unsigned int irq);
 extern void disable_percpu_irq(unsigned int irq);
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f485369b1b4f7..de095299f20ed 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -455,6 +455,9 @@ static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
  * @irq_disable:	disable the interrupt
  * @irq_ack:		start of a new interrupt
  * @irq_mask:		mask an interrupt source
+ * @irq_mask_nowait:	mask an interrupt source without waiting for the
+ *			hardware to acknowledge it (optional, falls back to
+ *			@irq_mask)
  * @irq_mask_ack:	ack and mask an interrupt source
  * @irq_unmask:		unmask an interrupt source
  * @irq_eoi:		end of interrupt
@@ -505,6 +508,7 @@ struct irq_chip {
 
 	void		(*irq_ack)(struct irq_data *data);
 	void		(*irq_mask)(struct irq_data *data);
+	void		(*irq_mask_nowait)(struct irq_data *data);
 	void		(*irq_mask_ack)(struct irq_data *data);
 	void		(*irq_unmask)(struct irq_data *data);
 	void		(*irq_eoi)(struct irq_data *data);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index de754db414d1d..4e76f025b5f68 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -399,6 +399,37 @@ void irq_disable(struct irq_desc *desc)
 	__irq_disable(desc, irq_settings_disable_unlazy(desc));
 }
 
+static void mask_irq_nowait(struct irq_desc *desc)
+{
+	if (irqd_irq_masked(&desc->irq_data))
+		return;
+
+	if (desc->irq_data.chip->irq_mask_nowait) {
+		desc->irq_data.chip->irq_mask_nowait(&desc->irq_data);
+		irq_state_set_masked(desc);
+	} else {
+		mask_irq(desc);
+	}
+}
+
+/**
+ * irq_disable_nowait - Mark interrupt disabled and mask it without waiting
+ * @desc:	irq descriptor which should be disabled
+ *
+ * Like irq_disable() with lazy disable turned off, but the hardware may
+ * still deliver an interrupt after this returns. The flow handler deals
+ * with that the same way it does for a lazily disabled interrupt.
+ */
+void irq_disable_nowait(struct irq_desc *desc)
+{
+	if (desc->irq_data.chip->irq_disable) {
+		__irq_disable(desc, true);
+		return;
+	}
+	irq_state_set_disabled(desc);
+	mask_irq_nowait(desc);
+}
+
 void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu)
 {
 	if (desc->irq_data.chip->irq_enable)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 0ce21dd454047..3ba13932ba831 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -98,6 +98,7 @@ extern void irq_startup_managed(struct irq_desc *desc);
 extern void irq_shutdown(struct irq_desc *desc);
 extern void irq_shutdown_and_deactivate(struct irq_desc *desc);
 extern void irq_disable(struct irq_desc *desc);
+extern void irq_disable_nowait(struct irq_desc *desc);
 extern void irq_percpu_enable(struct irq_desc *desc, unsigned int cpu);
 extern void irq_percpu_disable(struct irq_desc *desc, unsigned int cpu);
 extern void mask_irq(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 2fbff2618a1e2..ecb4d2144b9d5 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -705,6 +705,27 @@ void disable_irq_nosync(unsigned int irq)
 }
 EXPORT_SYMBOL(disable_irq_nosync);
 
+/**
+ * disable_irq_nowait - mask an irq without waiting for the hardware
+ * @irq: Interrupt to disable
+ *
+ * Like disable_irq_nosync(), but masks the interrupt at the chip right away
+ * instead of lazily, and does not wait for the hardware to acknowledge the
+ * mask. An interrupt that still arrives is held pending and replayed by
+ * enable_irq(). Use this when an extra interrupt is cheaper than flushing
+ * the mask, e.g. switching from interrupts to polling.
+ *
+ * This function may be called from IRQ context.
+ */
+void disable_irq_nowait(unsigned int irq)
+{
+	scoped_irqdesc_get_and_buslock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		if (!scoped_irqdesc->depth++)
+			irq_disable_nowait(scoped_irqdesc);
+	}
+}
+EXPORT_SYMBOL_GPL(disable_irq_nowait);
+
 /**
  * disable_irq - disable an irq and wait for completion
  * @irq: Interrupt to disable
--
