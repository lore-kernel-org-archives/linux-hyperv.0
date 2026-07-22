Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E827C329C6B;
	Wed, 22 Jul 2026 13:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784726107; cv=none; b=gbls9DKFiKhcecovqbywrYdrrzOViZ3W23NakJfO+auUdJkvahAS83F9aCimOaZbMNnpna6HLOhZUE7fBrjVskwQmrBMQvRGz4nNc0TP545Rq8Dq0hc6s0uT4vpk+cH52ZIefRoouXnzkqRjgquUZrkdO0o8F52AQO0mO2KjHVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784726107; c=relaxed/simple;
	bh=1yJoVlAUVm1e5JEJlJpcPXhUqxYn+vgAq1lvdLlKdp8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Zs8ZedpEImToQtSByTwHk49WXlNFakL8N7J0HPskxJlgw/4WcQuiQAiV/D+4giNdVEQKcABcyoRfyRmiM+S7AmfGaIw2iMnJ995zU5vDLfy+9GlWdTelw8ZzGcTr//v4oaApu+GCBGttCogLzny/cxOQqEc1ZN6UYd0xnSCNLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fJBCVeUf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fJBCVeUf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949791F000E9;
	Wed, 22 Jul 2026 13:15:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784726105;
	bh=7MevgaJ5QB9qOS6Rkwxd7av4uSzSi7PMpVhOnI2xPVs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=fJBCVeUfigjy9RKmiFcAXi1fxy1StkhToM9JwZFAhDbzLISSksBEN3fkBXbSa8rNv
	 Lmq2ID6hEG4WhSEBj8uuwOVdPYQLQo8rGZHgZQV8fgu7LwQhFyQYXnDDS5sQ5nRjY3
	 sU+soeTe/B9TkKER0HlbJauwsGo7p43EWhQbSSx5M0srV2CTmmRa4O2QhnS+OO44GF
	 g+KlI0cap5MQ/kF5wbwaF6v0DeXFv+YVUnfhuOOkGz195YPCWTzC45CGSAyPviVnCk
	 VOqnLl5fgRV1xxK6UJr7smBlxMyRGUW4e3B+ZG1dwLgySWUhr9VsKm95YFOycGw/+2
	 n4t3gjW6eAhnQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H . Peter Anvin"
 <hpa@zytor.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [RFC PATCH] x86/apic: Fix lost IRQ during forced vector
 migration on Hyper-V
In-Reply-To: <12557e3a-5feb-4601-ad53-cf4846052edd@linux.microsoft.com>
References: <20260710054007.288807-1-namjain@linux.microsoft.com>
 <874ihskq1h.ffs@fw13>
 <12557e3a-5feb-4601-ad53-cf4846052edd@linux.microsoft.com>
Date: Wed, 22 Jul 2026 15:15:01 +0200
Message-ID: <87y0f3jhd6.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Naman!

On Wed, Jul 22 2026 at 14:59, Naman Jain wrote:
> I completely agree with your comments, and now that I know how to fix 
> this, do you suggest me to -
>
> 1. add irq_retrigger callback in pci-hyperv.c
> or
> 2. go with your fixup-irq() change to no longer need drivers to add the 
> above? And then see what all stale irq_retrigger inits can be removed
>
> Going with 1) would be easier for me to fix this bug, and back port it 
> to older kernels, with proper Fixes tag (pointing to some pci-hyperv.c 
> change).
> Then later, we can go with 2) separately as a general enhancement (not a 
> Fix).

This should be one patch series:

  1) Add the callback to pci-hyperv, i.e. in hv_pcie_init_dev_msi_info()

     +    chip->irq_retrigger = irq_chip_retrigger_hierarchy;

     That sets it on the outermost domain interrupt chip (PCI/MSI
     device domain), which is what fixup_irqs() looks at.

     This one needs a Fixes: tag (The first commit which introduced the
     driver) and a Cc: stable@... so it will be backported.

  2) Change fixup_irqs() to use irq_chip_retrigger_hierarchy()

     Feel free to pick up the patch I gave you, add a proper change log
     and a Suggested-by: Thomas .... tag.

  3) Remove the initialization of the outermost chip from arch/x86/* and
     drivers/iommu/amd/* as that's not longer required then.

Thanks,

        tglx


