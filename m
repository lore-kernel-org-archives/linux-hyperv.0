Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708363A5422;
	Thu, 10 Sep 2026 07:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789024297; cv=none; b=bBMc7AXqUidQS4Q7hdd1cpQbDItmoGsXmfvAPlOd9TX43llZUu0w2/AALfe/FvhhxN2ivdHYtN2mUETZmTPnGR9DrIhEWmdbe7t8w52TIQtp55CcWVMlttAdwg/IabIWM6AT/AQDH9kgeo/YGgKqmmn3xyG+ffThUrfIx5SAmuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789024297; c=relaxed/simple;
	bh=veNmLyS77khJqxy+yf9wT4pFcgSAoLEhQ271L5jMhx0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=n7yW7c9YZJ+Y9+H73k2nohGxWN2CrxA1odK7cpljlY4CIT+DSbEJOzTysSESV0xLdxMuJdXq1aLdO0YvT2GQFDw3yZGnW1dTYQwNFfZWFXUe2vhp0eVnR10S3lLnGT+dQbOAUWhBQXw2hzOzcyxQqkAnRTZdjN2Xce3sp8bYXrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=17UCVnuy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iiJf0YBO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="17UCVnuy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iiJf0YBO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789024293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veNmLyS77khJqxy+yf9wT4pFcgSAoLEhQ271L5jMhx0=;
	b=17UCVnuy9tSpkKuE60hhVX8DDBolKcEpU7UA/+b0pvuIGSSUKPVx5UqiP/XKWCvtLAhxlV
	P17/d0YyZ5qGmm6bCbdUAbLplDuWUAe/if1k2Kd9wwI8e1ofie1SIlT/q1OcLcgAfRVoTT
	krHoHcUmv6+aHg5WwaHMjQpe7eBCVESe7+u2hDKuL+divLaGqzzOSj0xl16PZ2LvO2nEZX
	gL+W/VwxULOn/igb+s/qVz5z5UEYMVGs9nkw0ibUI13Ttu5FR9vALEq7XUmPIx1XSA43zs
	ZmaSVUgs/N45PXszUECsYRb7+CR7WpAigW1bk/67TGSjhvPtOY7pcETk//siig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789024293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=veNmLyS77khJqxy+yf9wT4pFcgSAoLEhQ271L5jMhx0=;
	b=iiJf0YBO9FjPc269ArHeTW+A0VN1iK0mNeqJATzM8ZpZu44/cSyA65uKGerLhQyaJZNoUT
	5+otwtNr61hxaTCQ==
To: Naman Jain <namjain@linux.microsoft.com>, Thomas Gleixner
 <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Wei Liu <wei.liu@kernel.org>, "K . Y .
 Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, Long Li <longli@microsoft.com>,
 Joerg Roedel <joro@8bytes.org>, Suravee Suthikulpanit
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
Subject: Re: [PATCH v4 1/4] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
In-Reply-To: <20260909064448.1004-2-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
 <20260909064448.1004-2-namjain@linux.microsoft.com>
Date: Thu, 10 Sep 2026 09:11:27 +0200
Message-ID: <87tsnxfun4.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Naman Jain <namjain@linux.microsoft.com> writes:

> The Hyper-V root partition vPCI MSI irqchip lost its irq_retrigger()
> callback when it was converted to msi_create_parent_irq_domain(). The
> callback was present on the original irqchip and was dropped during that
> conversion.
>
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> the outgoing CPU to a new target. If an interrupt still has its pending bit
> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on the
> new target through the irqchip's irq_retrigger() callback. As the root
> partition PCI/MSI chip no longer provides that callback, the pending
> interrupt is silently dropped, which can result in lost interrupts, stalls
> and "No irq handler for vector" messages during CPU hotplug.
>
> Restore irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
> the root partition PCI/MSI irqchip, so that a pending interrupt is resent
> on its new target CPU via the parent x86 vector domain.
>
> Fixes: 4691db0704ac ("x86/hyperv: Switch to msi_create_parent_irq_domain()")
> Cc: stable@vger.kernel.org
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Reviewed-by: Nam Cao <namcao@linutronix.de>
