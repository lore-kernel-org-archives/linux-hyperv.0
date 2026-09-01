Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B12440EB9C;
	Tue,  1 Sep 2026 14:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788274465; cv=none; b=jbgPOJlBCmRH0zD0rZfbBcXWNxR0YMqx4HUJoq9QDMnBVgAP9ajRXf2BlqLanwIiBZbAZTRPp7hZBjCyxs+YTzrI/0EzvQx1144AQ85FXEGoIsKc91ZTFbA8zemNZ+RfLOPQSxsa0/QF7hiS1pq0cqProa1j6mG3+MglT9VTZNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788274465; c=relaxed/simple;
	bh=2yqEFoZRV/gOa/QOao+FpoDyoS0SOeTraFB+BwNzpAw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OsSENMNrx1fTModBkoRLiXmfzaKniQrwDogGbAvkf8UIQwPtjAB1vFBOqAu8MmbbU3CkKv5rrlhKpfUQZLTOcGGtvdB2RQAIUDNcmICBNQY03RYyyaSaoESiRkCRQUWs+5S+LIBZASSCeqkxLnkzjPQLc+0EHgbmiEPpkXoVA44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IC1MTE/t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IC1MTE/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D34071F00A3A;
	Tue,  1 Sep 2026 14:54:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788274463;
	bh=D2Aw6+sh/9HCL/pfHHy9+7bmNqAJtyeu2dn/jRsQJgE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IC1MTE/tMVT7MfUj42mlnRumBVMs0Rm/xghQWbRQcHvGBNhru2GFH08KM5UhSvayS
	 OALRscp688it1rCVtPNV0IRSPGGmNXq2mjNi7LiNt2WEcFTsPKJ1WzJKsBccr4tsXv
	 tZY0tv2wYn1IjVeCF1Nnt+tZC9sUhqCmIcsHf/zhyscNLrgxVWRM8oDcs68LyjG8vR
	 BxIq4EhT00TQ5qMH9/60r2uYHWsEWZTVUqiOXS2vGF3qZ1HujaBt9h930lqLGdRPat
	 HLEkJMdW+0IBfGakHXd+9uqbqcvWgrQseWY6weoQ0TUlDad0aFyfWblHe8GJyD0QZz
	 DymLFfIyqtr3A==
Date: Tue, 1 Sep 2026 16:53:58 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	"Joerg Roedel (AMD)" <joro@8bytes.org>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org, Jake Oshins <jakeo@microsoft.com>, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] x86/irq: Fix lost interrupts on CPU hot-unplug for
 Hyper-V PCI/MSI
Message-ID: <7zu54oo4dx2dwnmu3ckxjbasszn6ayn2kq6kdhu2ce4ltlsmu3@jbzjlk52ydbf>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260728135117.2888175-1-namjain@linux.microsoft.com>

On Tue, Jul 28, 2026 at 01:51:14PM +0000, Naman Jain wrote:
> On CPU hot-unplug, fixup_irqs() re-injects interrupts that are still
> pending in the outgoing CPU's IRR via the irqchip's irq_retrigger()
> callback. The Hyper-V vPCI MSI irqchip never installs one, so such a
> pending interrupt is silently dropped, leading to lost interrupts, stalls
> and "No irq handler for vector" messages.
> 
> Patch 1 is the minimal, backportable fix (Fixes:/Cc: stable) that installs
> irq_chip_retrigger_hierarchy() on the Hyper-V PCI/MSI chip. Patch 2 then
> switches fixup_irqs() to call irq_chip_retrigger_hierarchy() directly, so
> the retrigger works for any stacked irqchip without a per-chip callback.
> Patch 3 drops the now-redundant irq_retrigger() initializations.
> This way, patch 2 and 3 do not need to be backported.
> 
> The series follows the original RFC:
> Link: https://lore.kernel.org/all/87y0f3jhd6.ffs@fw13/
> 

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com> # PCI

- Mani

-- 
மணிவண்ணன் சதாசிவம்
