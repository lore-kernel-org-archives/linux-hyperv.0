Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E93E3C07A;
	Sat, 12 Sep 2026 19:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789239990; cv=none; b=fVnlpBcOGKMPRskEQcv8Xfg25+ExmN82+M5zY4D6nGYh3hDTg+LiAdBKnQ1P7ks7CCMivhinMWAnjX9BChhJx27aGHXKGoGsclA8oBqGQRXx+MQFw4qg5jHJdfseoJAlj9iGEgyjLtz9G+mJkapt4yHKkIKOkTB/6jo1xbX+0TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789239990; c=relaxed/simple;
	bh=zeTe4tKiIB/QhKaXz3hjBqg2wYQfACSCbBkKYDJvGs4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Ljpvji+MVnX65kLL9JBZ2ohDnwVV5ivpspnuSyBwZ9gmLi9u5VunB7cgeYwq0m9GTxkByBPTWRTwxlFIb+fUc9p6DR7IU7h5/bx+zBqSARA22qqwl73CbWlC+MNDh5iiS9VIbRijcyTC3i92hegOhdxVB9zcKe39xSi+eAIJ4fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VxJ4R2b7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VxJ4R2b7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC45C1F00893;
	Sat, 12 Sep 2026 19:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789239987;
	bh=NQBwv5tJstjSwHUw8j5kbWZiXw1sWfFyu3zL0el12n0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=VxJ4R2b7ZN/1Sn6us9EL5b0R1P+YBW+VSt/sHm0rCA1uItcvcB3SsAxRuBO02Lkkm
	 yvgxyYQE7HCRtayTY8DDilSkzG0/7mjex0Zvi8MdoDGAH6Usd8Dm09zlqg8F589XzB
	 XdYV7tkDEaCMr5oIYsfes88eLZFJQzWG3+l+YQwx7fOpnjmclSYFTNQi09Wqvmv11I
	 1po58fFdiQkJa+GdBkCVfQk/Tos5tdazEgwp0HCeYYgp21EMOy/uoYFWk/IGogMF3L
	 34qzlfxC/M1nkxOsqdqVfYZi5a6H4NAXhQQnzsQA8MZ3sm8Cz29U3c4B8MXXN3BIiD
	 EfDDPOkiigdJw==
From: Thomas Gleixner <tglx@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>, Naman Jain
 <namjain@linux.microsoft.com>, Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan
 Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Bjorn
 Helgaas <bhelgaas@google.com>, "namcao@linutronix.de"
 <namcao@linutronix.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Robin
 Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Aditya Garg
 <gargaditya@linux.microsoft.com>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
In-Reply-To: <SN6PR02MB4157B093E09517D408FD58DAD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com>
 <875x0e204j.ffs@fw13>
 <SN6PR02MB4157F453542D6003038CAC3DD4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <87mrtoyzoy.ffs@fw13>
 <SN6PR02MB4157B093E09517D408FD58DAD4BE2@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Sat, 12 Sep 2026 21:06:24 +0200
Message-ID: <87y0d6xpan.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Sep 11 2026 at 16:32, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@kernel.org> Sent: Friday, September 11, 2026 1:12 AM
> As for the future, you may remember my RFC patch set from a couple
> years ago for the Synthetic Interrupt Controller (SynIC) that Hyper-V
> provides to guests. The SynIC currently has special case nodes under
> /sys/bus/vmbus to manage CPU affinity. As a better approach, the patch
> set modelled the SynIC as an irqchip so standard Linux mechanisms could
> manage affinity. You and I corresponded about per-cpu flow handler
> tweaks to make it all work. The RFC patch set didn't get traction with
> the Microsoft folks and I didn't push it. But it had a stand-alone IRQ
> domain not parented to VECTOR because Hyper-V interrupts are hard
> coded to HYPERVISOR_CALLBACK_VECTOR. As a stand-alone domain,
> a .irq_retrigger function might have been useful in fixup_irqs(). That's
> all speculative, but it was in the back of my head when I suggested to
> Naman that the outermost chip .irq_retrigger function should be
> checked. I'm fine with not doing that check now, and if a future case
> like the Hyper-V SynIC arises, the check can be added.

It doesn't because that domain is not parented by the vector domain, so
interrupts in that domain cannot have a descriptor in the descriptor
array and neither will end up in msi_set_affinity().

These interrupts are handled in the generic cpuhotplug mechanism.

fixup_irqs() is really only about the vector domain to handle the case
where an interrupt was raised on the old vector on the outgoing CPU
before the generic hotplug affinity change took effect.

>> Devices might have a way to retrigger at the device level, but that's
>> not reachable from the interrupt chip.
>> 
>> So both places fixup_irq() and msi_set_affinity() can use retrigger
>> hierarchy safely without the conditional checking the outermost domain
>> chip.
>
> And setting .irq_retrigger in x86_init_dev_msi_info() becomes
> superfluous, right?

Yes.

Thanks,

        tglx
