Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793499782;
	b=rSPFKEup0ljBRyAXIM/rFf8HkD8QPz/KI3OVr1OsfuGlSH14jqTAhnfZgjCr+o66pExF
	 oHQGZHLQrOY0XVptQefekUt3zCgUz7LFcCf27jMrWKMOR6bJDTs+sHPwE2OXNKQ2n3hTh
	 ICkOx+7lclx6FZ0Z82Y2kkld3mZXDjmv4TbbF/STsrseAWFUHFS+1NAzX0I7+xivLYDPg
	 NS8MRuve4b9YeAz3+Vfe4o43MWV+ywM8x3ut3a/Lj5bL6ni/8NcjMV/mki/w+sJ2tKtXX
	 GB529sh3IZ4IbKitBBxwaj4a1G7hcNF0Epck16PXgvU3j1mv3oUnuK81KL2ZADYQDUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793499782;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Subject:Date:Message-Id:X-Mailer:
	 Reply-To:MIME-Version:Content-Transfer-Encoding;
	bh=SfvhkL24xvl3PAjJXRntjTxag9TSeggpKFFCCl9d1tM=;
	b=J2bgJxwQWRDlWMNtRcFMcpyjIbPfbH4wGdzUS8GPXuNVy26AkW2ouFDj7zJUpJxCT72E
	 ms6ru69CMFRwO5ep1tQ5kwVRrRGCYlQlvNyZsKs1Jy7j796XjK+742zz+dyPVsK3KmBt1
	 FLYdeiiAFsVmJODoSuyX3yd4ZyP3c/PRAkkFXkJ0gRD94609h3XJ28utlQsuzFP7rI1KQ
	 Z9Em4RAo7OR/hFadTnVllnnQeW6WeoHX5dVRI9oYO2++kByLK2HzNVeVWuFbX/XzxDq6R
	 khU8p1mv0q1PQdyWJpcxdtkUQNmLgwMuxOMhPlMqkedwB+KNlPWcrizfS9Mg23DFqjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NT34Dq13;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7045606A32E
	for <linux-hyperv@vger.kernel.org>; Sun,  1 Nov 2026 02:23:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B7045606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NT34Dq13
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cc52c1b8286so1018447a12.1
        for <linux-hyperv@vger.kernel.org>; Sat, 31 Oct 2026 19:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793499781; x=1794104581; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SfvhkL24xvl3PAjJXRntjTxag9TSeggpKFFCCl9d1tM=;
        b=NT34Dq13h8P1lVENiORQWK95jgkDeGPsgUJin8Nlh7dUAiTnOn7P2pXOaiyE1VHhBT
         fCGDKIkbDB+nwhXuBi/1NK+fIS4ZQeq7f1M9ZKjDDSg9OYYUCU377/Lp/d9IHn5XmcaW
         SDXVacVetTcN93dn49E4d0EYku28LMmjrTv/ORlUMSKs5ep8eyxBmyZdNwbHbxhLtUOo
         k/vluJmNvotukMLN2BY7rEI07fHPG80tne/T/lp/LDr7GGOYSpD3KElwsafLErCwDar2
         G+KdCX+uINQTht1d3H7X0tNGj5dHuutvvo1RuiW9NjuRNAoccEqTvshlAbZ3CnRlV/pK
         W2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793499781; x=1794104581;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SfvhkL24xvl3PAjJXRntjTxag9TSeggpKFFCCl9d1tM=;
        b=OKNReRlfOMECBACpcRA5ETkRH6i7ZZ83W/ISnCSyYMt03rJznMpkFht8ceGLL2Kdo6
         mzf2ObS4rvz9TbPgHGFAziVgyp3LGN6XXvMzpEenLZph1GyyMA1rY0UFHlpkX9pU/c8k
         p3eD9hPaUk/Ej5ZDdIdbRu5jjSfHuoFpffXUWOynBBLNwSkENhQ4JgEy5WVrlhQZ1+5d
         XFnt1D+I2KrCvtWTm9cAsQ/so5rg7NPm8ezOikGCTiL0gl5JQVsBIKe00U4T2BEKZpA8
         uiskjWJ3toNuiLO25Y+CFnPoapUX5v3lYtx0V2I055XGLiGal00X+rk7M9LnKj3x5jho
         EHZw==
X-Forwarded-Encrypted: i=1; AKwUvBzJuHkSylqgCGK3i2csuCb43q0pPIILwFta8Fbqsiz/pohxWvCAyL5ouhylC27rbYoqAXU4ySn4JEEefOM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/I+H/4sgpyNLA/iiQLCAkGKLVnC6BrPvG4tu5mPvKAvTAVFst5
	L696e+sbCYsUCHv6UhaatuKGhO6lHLkVInabmMAby4m3rpG3I6fg3lNT
X-Gm-Gg: AYBFou2L0Kq81pXCkwf1S2F/R1pOV5/iSGz+b05uakYoTxqt3iCgV2x7/VqMNqE1Xiq
	0iOJs4jgcdZKc6SAbfvAEfgPwEhKH4CnklfuDUggdUWwYfR2sO9m3RgbTRQ7R8t/AwPFHADgc8g
	v82SLNCns9b0t9dOUh2IBpwKzfKkyGHxjQxxOJTBtn9spHmgQqzgM5BLxNSg46I4BrGT8nWLZs2
	eoGsQZPf6ggCVh5DdY3GDJdkjKNIqZCholYHEQ1O8M1p+/eAsP4BIV/eSvrNmj3SkjXy2CJkGtn
	3KjLNzTrqgZurcxPWHC6U5BQq+LkMZsahM3XfQ2/f0WpbzyPdNj2rYvTFqxFfaFmOhhZHvhPtbo
	GDp7aOqVVUkPt/aj331GYpYLJWSif7oEd8iIOoakvfljf5rtQYtkLOKCwe5IHhl1xK895TG7S9c
	0tlffJGrJRGFsTL8RD8hu3aM5lMthyDF8xphjpR59YpGsVZ/jiXR3IfVsMPwZLkXBl9hgL0hjQz
	BQxiYptQfnKiUGnBE2+Zh8DPtPWZCA98VVajGoYVCrXln4m/1qtqMvZ1pMtUGR1BeaTOG/b3l/t
	QHBuEKX0v+LqDOLFFscC0s4wqjO9MMQoFFQun51Kz6aRBKAoEeogxPlo9bwo9Niz9wQ5C8pxqb/
	beavuFtp+WLpF8VK4+vaz8T8fpYfiQy/D1w==
X-Received: by 2002:a17:90b:5250:b0:3a8:786a:cfed with SMTP id 98e67ed59e1d1-3ae897bfdd8mr3327794a91.37.1793499780877;
        Sat, 31 Oct 2026 19:23:00 -0700 (PDT)
Received: from localhost.localdomain (c-174-165-208-10.hsd1.wa.comcast.net. [174.165.208.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae85e4ff4csm5452542a91.1.2026.10.31.19.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 19:23:00 -0700 (PDT)
From: Michael Kelley <mhkelley58@gmail.com>
X-Google-Original-From: Michael Kelley <mhklinux@outlook.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH 1/1] Documentation: hyperv: Update docs for PCI pass-thru device support
Date: Sat, 31 Oct 2026 19:22:57 -0700
Message-Id: <20261101022257.52819-1-mhklinux@outlook.com>
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

Add a section to the documentation describing the IRQ domain and IRQ chip
hierarchy that is created for virtual PCI devices, including the
differences on x86 and arm64, and the reasons for those differences.

In the context of the IRQ domain and chip hierarchies, describe how the
CPU selected for effective affinity is spread across CPUs in the affinity
masks. Again, account for the differences in x86 and arm64.

Finally, rework existing text on how MSI messages are composed. Provide
an expanded section on the overall approach that Hyper-V takes to MSI
messages. The section provides more context on the handling of MSI messages
in the Hyper-V vPCI driver, and why it is structured the way it is.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
This doc update assumes that the patch to implement effective
affinity spreading for arm64 SPIs [1] is accepted.

[1] https://lore.kernel.org/linux-hyperv/20261101021928.52649-1-mhklinux@outlook.com/

 Documentation/virt/hyperv/vpci.rst | 148 +++++++++++++++++++++++++----
 1 file changed, 131 insertions(+), 17 deletions(-)

diff --git a/Documentation/virt/hyperv/vpci.rst b/Documentation/virt/hyperv/vpci.rst
index b65b2126ede3..881016781c74 100644
--- a/Documentation/virt/hyperv/vpci.rst
+++ b/Documentation/virt/hyperv/vpci.rst
@@ -159,6 +159,62 @@ ejections happen at inopportune times. Care must be taken when
 modifying this code to prevent re-introducing such problems.
 See comments in the code.
 
+IRQ Domains and Chips
+---------------------
+Early in the process of setting up a new vPCI device,
+hv_pci_probe() calls hv_pcie_init_irq_domain() to create an MSI
+parent IRQ domain for the device. This domain has IRQ chip functions
+to interact with Hyper-V to compose an MSI message and to mask
+and unmask interrupts. It becomes the parent domain for the per
+device IRQ domain created by the normal Linux driver for the
+device when it sets up its IRQs -- e.g., the NVMe driver function
+nvme_setup_irqs() calling pci_alloc_irq_vectors_affinity().
+
+This MSI parent domain is parented to what the Hyper-V vPCI
+driver calls the "root" IRQ domain. On x86, the root IRQ domain
+is the VECTOR domain for the APIC. On arm64, the root IRQ domain
+is a domain created by the Hyper-V vPCI driver to overlay the
+"irqchip@<paddr>" domain created by the GICv3 driver when it
+initiaizes the virtual GICv3 hardware provided to the guest
+by Hyper-V. This overlay domain is named "hv_vpci_arm64", and it
+handles the limitation that Hyper-V provides only a GICv3 to the
+guest, not a GICv3 with ITS. As such, there are no LPIs available
+in the guest, so it must use SPIs for vPCI devices. While this
+is valid in the arm64 architecture, it is atypical. The Hyper-V
+vPCI driver glues things together by having hv_vpci_arm64
+allocate and manage the SPIs.
+
+**x86 IRQ domains and chips**
+
++-----------------------+-----------------------+------------------------------------------------------+
+| Domain Name           | Chip Name             | Notes                                                |
++=======================+=======================+======================================================+
+| VECTOR                | APIC                  | Spreads effective affinity                           |
++-----------------------+-----------------------+------------------------------------------------------+
+| <vPCI device GUID>    | Hyper-V PCIe MSI      | MSI parent. Per vPCI device. Created in              |
+|                       |                       | hv_pcie_init_irq_domain().                           |
++-----------------------+-----------------------+------------------------------------------------------+
+| HV-PCI-MSIX-<PCIaddr> | HV-PCI-MSIX-<PCIaddr> | Per vPCI device. Created when driver sets up IRQs.   |
++-----------------------+-----------------------+------------------------------------------------------+
+
+
+**arm64 IRQ domains and chips**
+
++-----------------------+-----------------------+------------------------------------------------------+
+| Domain Name           | Chip Name             | Notes                                                |
++=======================+=======================+======================================================+
+| irqchip@<paddr>       | GICv3                 | Picks 1st CPU for effective affinity.                |
+|                       |                       | Created in gic_init_bases().                         |
++-----------------------+-----------------------+------------------------------------------------------+
+| hv_vpci_arm64         | MSI                   | Spreads effective affinity. Created in               |
+|                       |                       | hv_pci_irqchip_init().                               |
++-----------------------+-----------------------+------------------------------------------------------+
+| <vPCI device GUID>    | Hyper-V PCIe MSI      | MSI parent. Per vPCI device. Created in              |
+|                       |                       | hv_pcie_init_irq_domain().                           |
++-----------------------+-----------------------+------------------------------------------------------+
+| HV-PCI-MSIX-<PCIaddr> | HV-PCI-MSIX-<PCIaddr> | Per vPCI device. Created when driver sets up IRQs.   |
++-----------------------+-----------------------+------------------------------------------------------+
+
 Interrupt Assignment
 --------------------
 The Hyper-V virtual PCI driver supports vPCI devices using
@@ -166,7 +222,7 @@ MSI, multi-MSI, or MSI-X.  Assigning the guest vCPU that will
 receive the interrupt for a particular MSI or MSI-X message is
 complex because of the way the Linux setup of IRQs maps onto
 the Hyper-V interfaces.  For the single-MSI and MSI-X cases,
-Linux calls hv_compse_msi_msg() twice, with the first call
+Linux calls hv_compose_msi_msg() twice, with the first call
 containing a dummy vCPU and the second call containing the
 real vCPU.  Furthermore, hv_irq_unmask() is finally called
 (on x86) or the GICD registers are set (on arm64) to specify
@@ -179,22 +235,8 @@ interrupts on a single CPU, causing a performance bottleneck.
 See details about how this is resolved in the extensive
 comment above the function hv_compose_msi_req_get_cpu().
 
-The Hyper-V virtual PCI driver implements the
-irq_chip.irq_compose_msi_msg function as hv_compose_msi_msg().
-Unfortunately, on Hyper-V the implementation requires sending
-a VMBus message to the Hyper-V host and awaiting an interrupt
-indicating receipt of a reply message.  Since
-irq_chip.irq_compose_msi_msg can be called with IRQ locks
-held, it doesn't work to do the normal sleep until awakened by
-the interrupt. Instead hv_compose_msi_msg() must send the
-VMBus message, and then poll for the completion message. As
-further complexity, the vPCI device could be ejected/rescinded
-while the polling is in progress, so this scenario must be
-detected as well.  See comments in the code regarding this
-very tricky area.
-
-Most of the code in the Hyper-V virtual PCI driver (pci-
-hyperv.c) applies to Hyper-V and Linux guests running on x86
+Most of the code in the Hyper-V virtual PCI driver
+applies to Hyper-V and Linux guests running on x86
 and on arm64 architectures.  But there are differences in how
 interrupt assignments are managed.  On x86, the Hyper-V
 virtual PCI driver in the guest must make a hypercall to tell
@@ -223,6 +265,78 @@ using all the vectors on a CPU doesn't happen. Since such a
 problem is only a theoretical concern rather than a practical
 concern, it has been left unaddressed.
 
+Effective Affinity Interrupt Spreading
+--------------------------------------
+For the APIC and GICv3 interrupt controllers, Linux must select a
+single CPU from the affinity mask to be the effective affinity CPU.
+While Linux is free to choose any CPU in the mask, a fixed algorithm,
+such as always choosing the first CPU, can be problematic in
+configurations with multiple identical devices (such as NVMe
+controllers). Each device has the same set of affinity masks, so
+the same CPU gets chosen for all the devices. Better performance
+is usually achieved for multiple devices by spreading the assignment
+among the CPUs in the affinity mask. No one CPU is overloaded
+and interrupts from multiple devices can be processed in parallel.
+
+On x86, the VECTOR domain and APIC IRQ chip do the spreading by
+tracking the number of IRQs assigned to each CPU, and choosing
+the CPU in the affinity mask that has the fewest assignments.
+Because Hyper-V vPCI device IRQs eventually parent to VECTOR,
+the spreading it does accrues to the IRQs for Hyper-V vPCI devices.
+
+On arm64, the "ITS" IRQ chip for the GICv3+ITS does the same kind
+of spreading for LPI interrupts. But IRQs for vPCI devices on
+arm64 use SPIs and are parented to the "GICv3" IRQ chip, which always
+chooses the first CPU in the affinity mask as the effective affinity.
+That CPU can get overloaded in handling interrupts. So on arm64,
+the hv_vpci_arm64 IRQ domain and associated IRQ chip provide the
+spreading functionality. They track the SPIs assigned to each CPU
+and choose the least-loaded CPU as the effective affinity. Then
+the parent IRQ chip (GICv3) is invoked to actually set the effective
+affinity in the virtual GICv3 hardware.
+
+MSI Messages
+------------
+In a typical guest on KVM, the VMM traps guest writes to a vPCI
+device's MSI/MSI-X registers/tables. The guest writes a virutal
+message (with a guest APIC address and a guest vector), and VMM
+emulation translates the message to program the physical device and
+physical device interrupt remapping (IR) tables on the guest's
+behalf. The guest never sees or handles the host-level MSI message.
+
+Hyper-V takes a different approach in which MSI/MSI-X register or
+table writes are not trapped. The guest writes the device's MSI/MSI-X
+registers/tables directly with a host-valid MSI message. The physical
+IOMMU and its remapping table are still owned by the host, so the
+guest must ask the host for the proper message.
+
+The "asking" is done by the .irq_compose_msi_msg function for the
+"Hyper-V PCIe MSI" chip, which is hv_compose_msi_msg(). The
+implementation requires sending a VMBus message to the Hyper-V host
+and awaiting an interrupt indicating receipt of a reply message.
+Since .irq_compose_msi_msg can be called with IRQ spin locks held, it
+doesn't work to do the normal sleep until awakened by the interrupt.
+Instead hv_compose_msi_msg() must send the VMBus message, and
+poll for the completion message. As further complexity, the vPCI
+device could be ejected/rescinded while the polling is in progress,
+so this scenario must be detected as well. See comments in the code
+regarding this very tricky area. A synchronous hypercall to get the
+MSI message would be a much nicer interface, but the code makes do
+with what's available.
+
+Once the host-valid MSI message is obtained, the guest must treat it
+as a black-box that the guest does not interpret or modify. The only
+valid guest action is to write it to the MSI/MSI-X registers/tables
+using the .irq_chip_write_msi_msg function on the HV-PCI-MSIX-<PCIaddr>
+chip. That function is pci_msi_domain_write_msg(), which calls
+__pci_write_msi_msg().
+
+If the affinity of an IRQ changes, the steps must be
+repeated. A new host-valid MSI message is requested via the
+.irq_compose_msi_msg function and that message is written
+to the MSI/MSI-X registers using the .irq_chip_write_msi_msg
+function.
+
 DMA
 ---
 By default, Hyper-V pins all guest VM memory in the host
-- 
2.25.1

