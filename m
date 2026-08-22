Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DB32877DE;
	Sat, 22 Aug 2026 00:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359007; cv=none; b=exZfcnMkGiTdWRO7pe+Cu2rxbqCN5DIGols8kAwBG7xa/fDIp4Eyst6vHvi48iefUhDk/ukqjWyVvwFTkam0ibvwhE7SMSvIiIEfA9obEZOg2grQqif/xDLLGnXxTAzFuepLDKTspmDkWN6MDnZDuMLRnXc5yjPPKd2W0vIz81w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359007; c=relaxed/simple;
	bh=+pkHvdT+l83Tw4aKXnLVQLmRKttr2HFKJIMEqqLCnhg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OviT0DLlwddJBwlEEwwXLQgc14mxTUBjjWppK1cZ1Xip4F6Vud8EzLVcgpxY4TKNZeeDxbRy+NRoHxUuqlx851TyObBfpEBsFzMfJSXm1jPs77LEDaGX4vrezG4W3u6XBt/zN6pY785DqYcgk6EbHHhHbiiuRLPh0UgEWc1B+s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLD8dfPe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLD8dfPe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64721F00A3A;
	Sat, 22 Aug 2026 00:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359006;
	bh=kuTu8yvhI4xwJHJ6qGpDIhDANj4SIchNOzv5SPa3P38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLD8dfPexP9hayujtCZnE4oSn8rayIw3iiaIQIFuV+40inJ2A6RKDcFKT/Ih1iutE
	 Y79k0cAZqIDNJYA5+ML6K87WFU8wyZtg6iGeKhk2KaD0g2dXH0TRGQ0b5E/J3RyPFZ
	 fWz79V3jzUj2nPNJcbQJ4tygagWO3Vx+EAbo9Izw35UEYiaBchG3TkBrXuiS0JlipR
	 kzbRZb7ka4OIh7LTl3o4uLHibNmsR4euGfDmPJhLqoqpEFsHwesM7sxYpCVfNfUQix
	 SBncYsauhJbyqZVNrCWOCtdKA+Q21LLiSMU8NuLMxBhdP0c2vYQXjX5RYG1iEbABOh
	 +wztQ3LqhRO6Q==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com,
	anirudh@anirudhrb.com,
	schakrabarti@linux.microsoft.com,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/3] PCI: hv: fix interrupt affinity change on the nested root partition
Date: Fri, 21 Aug 2026 17:36:22 -0700
Message-ID: <20260822003623.2925128-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260822003623.2925128-1-wei.liu@kernel.org>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

hv_compose_msi_msg() sends PCI_CREATE_INTERRUPT carrying
int_desc.vector, and the vPCI backend programs the device with the
address/data it returns for it.

An affinity change only ran irq_chip_set_affinity_parent(), which
re-allocates the x86 vector and nothing else, and hv_arch_irq_unmask()
then issued MAP_DEVICE_INTERRUPT for the new (VP, vector).  Nothing
re-composed the interrupt, so the device kept signalling the vector it
was created with and the new mapping was never used. This led to loss of
interrupts.

Do the re-target where the vector is known and the interrupt is
quiescent.  If the vector changed, re-compose the VMBus interrupt for
it, write the resulting message to the device, and only then map the new
(vp, vector); the old mapping is destroyed as the new message is
composed.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/pci/controller/pci-hyperv.c | 41 +++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index 5a36382742bf..5acb8e41567e 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -294,6 +294,7 @@ struct tran_int_desc {
 struct hv_msi_int_entry {
 	struct tran_int_desc		int_desc;
 	struct hv_interrupt_entry	hv_entry;
+	unsigned int			mapped_vector;
 };
 
 /* chip_data is passed around as a struct tran_int_desc *, so it must be first. */
@@ -742,6 +743,8 @@ static void hv_irq_retarget_interrupt(struct irq_data *data)
 			"%s() failed: %#llx", __func__, res);
 }
 
+static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg);
+
 static void hv_arch_irq_unmask(struct irq_data *data)
 {
 	if (hv_root_partition()) {
@@ -752,9 +755,17 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 		 * RETARGET_INTERRUPT.
 		 *
 		 * Keep the returned entry so the mapping can be removed again
-		 * when the interrupt is torn down.
+		 * when the interrupt is re-targeted or torn down.
+		 *
+		 * This is also the re-target point.  The core calls us from
+		 * __irq_move_irq() with the interrupt masked once the new
+		 * vector has been assigned, so if the vector changed the vmbus
+		 * interrupt is re-composed for it first -- PCI_CREATE_INTERRUPT
+		 * carries the vector, so the device would otherwise keep
+		 * signalling the one it was created with.
 		 */
 		struct hv_msi_int_entry *ie = data->chip_data;
+		unsigned int vec = hv_msi_get_int_vector(data);
 
 		/*
 		 * A NULL chip_data means hv_compose_msi_msg() failed and the
@@ -763,8 +774,29 @@ static void hv_arch_irq_unmask(struct irq_data *data)
 		if (!ie)
 			return;
 
-		if (hv_map_msi_interrupt(data, &ie->hv_entry))
+		/* Already mapped for this vector, nothing changed. */
+		if (ie->mapped_vector == vec && ie->hv_entry.source)
+			return;
+
+		if (ie->mapped_vector && ie->mapped_vector != vec) {
+			struct msi_msg msg;
+
+			hv_compose_msi_msg(data, &msg);
+
+			ie = data->chip_data;
+			if (!ie)
+				return;
+
+			if (data->chip->irq_write_msi_msg)
+				data->chip->irq_write_msi_msg(data, &msg);
+		}
+
+		if (hv_map_msi_interrupt(data, &ie->hv_entry)) {
 			memset(&ie->hv_entry, 0, sizeof(ie->hv_entry));
+			ie->mapped_vector = 0;
+			return;
+		}
+		ie->mapped_vector = vec;
 	} else {
 		hv_irq_retarget_interrupt(data);
 	}
@@ -1974,6 +2006,11 @@ static void hv_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	if (data->chip_data && !multi_msi) {
 		int_desc = data->chip_data;
 		data->chip_data = NULL;
+		/*
+		 * The descriptor is about to be destroyed, so release the
+		 * hypervisor mapping that belongs to it first.
+		 */
+		hv_vmbus_unmap_msi_interrupt(pdev, int_desc);
 		hv_int_desc_free(hpdev, int_desc);
 	}
 
-- 
2.53.0

