Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CE83D47A5;
	Thu, 15 Oct 2026 22:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792103814; cv=none; b=HSkqBPLSm8cuv9iqrug/4JcQ7he0D1K2r71EFmIIJidGXdx228sISrSAlyPn2RsPKWOgxwX/34vQ3EViUCZ1FIbcqGM53EsykELm1JlsVZIC8aNo1TYtNgoUkxb2Oaouw4e2b5AKaeIjXmjz2l41xzw4se1MO1PUKyjzSnYzxIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792103814; c=relaxed/simple;
	bh=UvrediL3+glf+ZUnb7Hsv9YP2T7349slM7Ohgj8ctow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PYyFlP3OREHh0xNGBxS4sqKuWx6ouKXThsehUMPjtfFYYM/vJ5z+wsDYfD2ljX6tYu4SDbQhwoZF8ml1pThn1pwEME+0tKqcjPw41S8A6tNBfZS8zPXEUc2OGqEws3xb0lOYi0ci+5jrl30YKS1fQt+1GZ75WNdQeVBVcFl1wMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwhwpnEH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwhwpnEH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DDB1F000C4;
	Thu, 15 Oct 2026 22:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792103812;
	bh=UvrediL3+glf+ZUnb7Hsv9YP2T7349slM7Ohgj8ctow=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YwhwpnEH00xhAOV/iRPgwBMT6Nl8PjM/y9nn/3iS4wy/lA0zwCoXN530gexuEQDnG
	 LhGq7VCaFMXQMmLMVynH1KqKhV11e+ESm8OdpN3gLuXShXRM98r6hZolIke0tClgna
	 t5tU6beBa4jMEV4trd6DEu8Wzvva9de5dBIjnzJ5Cjxhw8WOvPwiGlnnY6IKLqOdF5
	 +cpk3x2lOKgloe3pfmnhhMmXTNKNPL9LhoQu1OgJVVEKC48CE4XRrgSWY4rNW7Cw5W
	 mBH8wSpGemI4s2sbqqjcH8ptWQ98bXW8mLJhR/TbJMyL5G+QtFR9LUxq3o/JnmXr9R
	 bwztX8o6f8qyg==
From: Thomas Gleixner <tglx@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Wei Liu <wei.liu@kernel.org>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
 <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>
Cc: Long Li <longli@microsoft.com>, Nam Cao <namcao@linutronix.de>, Joerg
 Roedel <joro@8bytes.org>, Suravee Suthikulpanit
 <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Kees Cook
 <kees@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>, Radu Rendec
 <radu@rendec.net>, Sean Christopherson <seanjc@google.com>, Kai Huang
 <kai.huang@intel.com>, Dmitry Ilvokhin <d@ilvokhin.com>, Shradha Gupta
 <shradhagupta@linux.microsoft.com>, Christophe JAILLET
 <christophe.jaillet@wanadoo.fr>, Thierry Reding <treding@nvidia.com>, Jiri
 Wiesner <jwiesner@suse.de>, Daniel J Blueman <daniel@quora.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 0/4] x86/irq: Fix lost interrupts on CPU hot-unplug
In-Reply-To: <20260923043023.3150498-1-namjain@linux.microsoft.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
Date: Fri, 16 Oct 2026 00:36:49 +0200
Message-ID: <87ecdqd20u.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Sep 23 2026 at 04:30, Naman Jain wrote:
> On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
> pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
> callback. The Hyper-V root partition PCI/MSI irqchip lost that callback
> when it was converted to msi_create_parent_irq_domain(), so such a
> pending interrupt is silently dropped, leading to lost interrupts, stalls
> and "No irq handler for vector" messages.
>
> Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that restores
> irq_chip_retrigger_hierarchy() on the Hyper-V root partition PCI/MSI chip.
> The equivalent guest pci-hyperv.c fix from the previous version is already
> merged, so it is dropped here.
>
> Patch 2 then switches fixup_irqs() to call irq_chip_retrigger_hierarchy()
> directly which ensures that this issue does not occur for chips that
> miss adding this initialization.
>
> Patch 3 makes a similar change in msi_set_affinity()
>
> Patch 4 then drops the now-redundant irq_retrigger() initializations.
> This way, patch 2-4 do not need to be backported.

Reviewed-by: Thomas Gleixner <tglx@kernel.org>
