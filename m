Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38ED46EC77;
	Mon,  7 Sep 2026 13:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786800; cv=none; b=fGAuTgMSwQD/63iUTqsHW1Tr16Ay/SVAz32lCiSGXkBljr/bcIjJ/HWF/RJK4RePPGflHLPeCAOlXcDS09TTugw+9xcpd/fgzRBQHsDw1xa3H4gjyuormbbgoFeQTJFMBw7JbvZqTYH6pz6pj/JjidzPCwuhm82B8MWgkBPLrsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786800; c=relaxed/simple;
	bh=sCyqdA7XYz/cXsFKfyuwykcilF3WMPlvoJkerdQfDrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O2YhCzUgDBNziiD1Gp9nOhXXKLk9p7MwXm+vRE0RyfDCpSxwyAxEP29fSXpHPkdPas+/+yBwvI6zdPj+jHA+13KPy51boRqZa+XSI3JxxMFUET8tBIm+UEDy127V+Esq2OHlNPhn9X4Ihhif+gdgd7g5AOTJnClbp9NUuZbJfGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mHWLJ5ee; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mHWLJ5ee"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9BB81F00A3A;
	Mon,  7 Sep 2026 13:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788786795;
	bh=sCyqdA7XYz/cXsFKfyuwykcilF3WMPlvoJkerdQfDrs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=mHWLJ5eejw1DAWE24BKkr7csqEjBElRPKGHJPmtHXeCTNjccZW0Dnu3fn8UL955U3
	 fQB5ucZqA9OMqXI/Md+NP2OC/gXAYre7PULDNaJ8H2eeyCspoD4Z1829FeRSylPUQX
	 vOLSNE8ULcuYlgf7uMpicB7OVcyrUV5VKD96apvjkgKtwBFP2ywujSY6a+DvyoDRk3
	 LSEZ3cm8B0atA6WRgQvHnQe1VR3EmE4xai945KgHQNXoFTOxrxmYuc8BfDrHEOCqKy
	 XgGLXMdc9qrCCNrvYrOTCH1/lcg8eyRjljzDeJUDFYH7GAZ87WpC1ONUgaqhpviwJU
	 9bAWGKoVLzxJg==
From: Thomas Gleixner <tglx@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>, Wei Liu <wei.liu@kernel.org>, "K . Y . Srinivasan"
 <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui
 <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Nam Cao <namcao@linutronix.de>, Joerg Roedel <joro@8bytes.org>, Suravee
 Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
 <robin.murphy@arm.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Manivannan
 Sadhasivam
 <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Kees Cook <kees@kernel.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, Radu Rendec <radu@rendec.net>, Sean Christopherson
 <seanjc@google.com>, Kai Huang <kai.huang@intel.com>, Dmitry Ilvokhin
 <d@ilvokhin.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Thierry Reding
 <treding@nvidia.com>, Jiri Wiesner <jwiesner@suse.de>, Daniel J Blueman
 <daniel@quora.org>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 3/3] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
In-Reply-To: <20260907065129.269262-4-namjain@linux.microsoft.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-4-namjain@linux.microsoft.com>
Date: Mon, 07 Sep 2026 15:13:12 +0200
Message-ID: <87o6e92oif.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 07 2026 at 06:51, Naman Jain wrote:

> With fixup_irqs() and the generic resend path (try_retrigger()) now both
> falling back to irq_chip_retrigger_hierarchy(), installing it as the
> irq_retrigger() callback on the outermost domain chips is no longer
> required. The hierarchy walk reaches the x86 vector domain's
> apic_retrigger_irq() for all of these stacked domain chips.
>
> Remove the now redundant irq_retrigger() initializations from the outermost
> domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
> msi_set_affinity() is the only site that invoked the outermost chip's
> irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
> the x86_init_dev_msi_info() initialization can be dropped as well.
>
> No functional change intended.
>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>
