Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F69493625;
	Sat, 22 Aug 2026 00:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787359002; cv=none; b=khl48NNUoWEH+BF7ekZL3R3bZCBG1PdylFRvxlBgF7DOc3Kd4A7CYJjZGT+bXmIXSKVxXKkH4dmZDJ3UMlAuxbfpJKpugfCFWWCpQipDD9TNDGD8nZOm7Ivc6K4tH+cv131Ame8ptyGm/v7F41K77iu08J8f7FU92wmxuXIigpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787359002; c=relaxed/simple;
	bh=vlADIcGsfYHoE+hnFHNxgq64VwesgGMJjRkHtPZPcoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tytK889agtOZtd2BEvy5/BhM4QEnttJX8zeLXxumY2TdnkBy+nFQVFajGGwCWz8WH+3jrwcGgyYlyCB94TK7UXpA5wQZ0qwZGSwa9r4JkQlA2FjgCGLHoCUKL3B+RG7C65EAvdwchV1fbcnF0P+JR9VshYl8+PptnFcKn7wqH/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ScC9J1Kq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ScC9J1Kq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91DB91F000E9;
	Sat, 22 Aug 2026 00:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787359000;
	bh=ZOvUC6PESOkUMpk5F9oFP8/YSsKlyINxepe2v4cyTLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ScC9J1KqexHkfVpFPoGdvwSs4G4n7/ecgHOLCtAzQSRvAPUKa+0fr//fP5UdC2xq/
	 lKEKHV64zDmOVyADAWlbR+8whSGid9vjbKmN4SXm3oX19ROwoKqy+keXoHEYbw3O5B
	 X23F31jv53wtl6daSQb5+MsWN6xGtuZ7KJh7wDap9XIpFC3yQOV1K48BGp12pB9a8o
	 88/C84gcMSvCaBnqww/mbhA+dnhtoYZ0D5HZBolOmNVZOlha54fRByJk2sVgxfJJH9
	 8V6zbVz4Zm33Pdl1Cst/M8t2wTTwCjK3niur5TXPZVNH6M+Ag2LtG4IKcVrfRsF94j
	 k/YzNRNvobnXQ==
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
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH 1/3] x86/hyperv: export hv_unmap_msi_interrupt()
Date: Fri, 21 Aug 2026 17:36:20 -0700
Message-ID: <20260822003623.2925128-2-wei.liu@kernel.org>
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

hv_unmap_msi_interrupt() issues the UNMAP_DEVICE_INTERRUPT hypercall that
tears down a device-interrupt mapping created by hv_map_msi_interrupt().
The latter is already exported and used by the pci-hyperv driver to map
vPCI interrupts on a nested root partition; export the unmap counterpart
so the driver can remove those mappings on teardown.

No functional change.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/irqdomain.c     | 9 +++++----
 arch/x86/include/asm/mshyperv.h | 2 ++
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dc..ecd18e9a97d8 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -213,8 +213,8 @@ static void entry_to_msi_msg(struct hv_interrupt_entry *entry,
 	msg->data = entry->msi_entry.data.as_uint32;
 }
 
-static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
-				  struct hv_interrupt_entry *irq_entry);
+int hv_unmap_msi_interrupt(struct pci_dev *pdev,
+			   struct hv_interrupt_entry *irq_entry);
 
 static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 {
@@ -266,14 +266,15 @@ static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	entry_to_msi_msg(data->chip_data, msg);
 }
 
-static int hv_unmap_msi_interrupt(struct pci_dev *pdev,
-				  struct hv_interrupt_entry *irq_entry)
+int hv_unmap_msi_interrupt(struct pci_dev *pdev,
+			   struct hv_interrupt_entry *irq_entry)
 {
 	union hv_device_id hv_devid;
 
 	hv_devid = hv_build_devid_type_pci(pdev);
 	return hv_unmap_interrupt(hv_devid.as_uint64, irq_entry);
 }
+EXPORT_SYMBOL_GPL(hv_unmap_msi_interrupt);
 
 /* NB: during map, hv_interrupt_entry is saved via data->chip_data */
 static void hv_teardown_msi_irq(struct pci_dev *pdev, struct irq_data *irqd)
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f64393e853ee..7c84e27d777b 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -191,6 +191,8 @@ struct irq_domain *hv_create_pci_msi_domain(void);
 
 int hv_map_msi_interrupt(struct irq_data *data,
 			 struct hv_interrupt_entry *out_entry);
+int hv_unmap_msi_interrupt(struct pci_dev *dev,
+			   struct hv_interrupt_entry *hvirqe);
 int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
-- 
2.53.0

