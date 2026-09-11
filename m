Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5E041D4D4;
	Fri, 11 Sep 2026 08:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789114322; cv=none; b=r+DWGZF2VcjPPlRwmydZqC8gzjop+vkUrNuuzKjvuVnmgyR0wgAScaPBXYvEeBjUhysBDdtppeKfkz77nIs/qCXku436SZaHt+urxO2rNthn8+hNkDwyaaxJ1YHjwaNJtJki4xTrXJ5xcbis6o3b/fsZ8B8uRJIlmZ4cDJ/e50c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789114322; c=relaxed/simple;
	bh=uF8zRtw2ob33kH4QdSoEw/OVChcaDoZJcCWUqO86SHM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UwBF2nkKWnbJHaXm7xNaPVRjAtfx5iXHnu0Yvo4Z7Gm3yqJuxNVITrp7TpaAFNyU89ul9vavbLVAdlLLrhx/OAv0AKkfB50Xfw2iZK4gqooCJ5np+7yO1/M7H1ZXAhXEiITIKjrDfymzzUbNbufz1BIMlfAdWOlvMIlZcMTnMBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lVG4qYBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lVG4qYBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13FBD1F000FF;
	Fri, 11 Sep 2026 08:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789114320;
	bh=3wrxQ9teiZ7XZkG0jku0wQGaCfSK17BqNo8qxdGAwhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=lVG4qYBsIf/3ItSuhHq8MIwjr6gkFNC5vcGRlAOS8DkK0jc7bu1NpqDIRq0ZX8o75
	 MOPa5M8WB9KHsfFCi+cBJY5FawqZRt5341U/yAe0Sltx3xzw3LPRIqAIyIzjY08fy1
	 4UZ4e2O85rMYp5OrhpZgfoRMkKCowHZhHTV/pdnEWXDc3JQRbJUNkAR2E4EHlj8u9i
	 Pef6aiezVmptLCRNwGKS83uWVUMc64c9QYLAEnQzFUa4vZE7dD8JSddxr3F2sqx3aA
	 SbGLORZwHKOQU7WKXeHxv7ifhVCWWlzM4+OXMMOAuELangaliyaPDDa+aavnAUqNQ8
	 eAfoV/OkayD3w==
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
In-Reply-To: <SN6PR02MB4157F453542D6003038CAC3DD4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com>
 <875x0e204j.ffs@fw13>
 <SN6PR02MB4157F453542D6003038CAC3DD4BF2@SN6PR02MB4157.namprd02.prod.outlook.com>
Date: Fri, 11 Sep 2026 10:11:57 +0200
Message-ID: <87mrtoyzoy.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 10 2026 at 18:51, Michael Kelley wrote:
> From: Thomas Gleixner <tglx@kernel.org> Sent: Wednesday, September 9, 2026 3:24 AM
>> In any case 'irqd' in msi_set_affinity() will always point to the vector
>> domain and therefore the exiting code is correct and can't be changed to
>> retrigger hierarchy as that would see irqd->parent == NULL and do
>> nothing. Neither will adding a conditional there do anything useful
>> because the vector domain always has the retrigger callback set.
>> 
>
> Hmmm. I've been staring at the code to try to understand it all,
> and I'm not seeing that 'irqd' in msi_set_affinity() always points to
> the VECTOR domain.

You are right and I'm an idiot.

My brain was already melted from debating memory ordering issues, then I
ended up completely confusing the set affinity and the retrigger
logic. Let me try again.

What I completely messed up was that the MSI core sets by default
msi_domain_set_affinity(), which uses the parent domain, but only if the
template/chp does not provide an .irq_set_affinity() callback.

Which is not true when remapping is off because x86_init_dev_msi_info()
sets it to msi_set_affinity(). Duh!

So the change is _not_ broken.

Though my argument that retrigger has to happen at the vector level
still stands because the outermost chip is in fire and forget mode and
to the best of my knowledge none of them have a retrigger at the
interrupt chip level. And from a design perspective there won't be any
in the future (famous last words).

Devices might have a way to retrigger at the device level, but that's
not reachable from the interrupt chip.

So both places fixup_irq() and msi_set_affinity() can use retrigger
hierarchy safely without the conditional checking the outermost domain
chip.

Thanks,

        tglx
