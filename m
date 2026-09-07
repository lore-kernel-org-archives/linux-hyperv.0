Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8AF46DFF1;
	Mon,  7 Sep 2026 13:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788786772; cv=none; b=TcYZPDAj/V+UJjVcvyZMVb5GINY5npiYzjY8DVLer1qyvctql824zpynSA90IHHmscioE65gCLKvsFv5LroF9Gl7il1C0UGJPbinX92JUTZ5bDtsbTSC5FUv8/Oy8/JJpUQBY2DWbezyiSU85Cts6/h6Yw0RycZm9feunNClgL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788786772; c=relaxed/simple;
	bh=ZArz3sw1T0RuypyxhGQkyTg2rcfJq/JMIpEbvqqrpf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QKCFiLok38XJyfheIx/wGbizQ0oKxTwyr5hbKQ0qqH0tXisjkAng4wXi7OBms+GgzynsyB4XB28q0CWqjhkhjGGx831DtFKC+5ydy4a4+8KmU3HuydcoM3TF5Cczu4VmnGhcc20/Hxqo9EZbytWQrNuzUefON7S3Ii3ABdF9aOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKchw7qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NKchw7qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09AE01F00A3A;
	Mon,  7 Sep 2026 13:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788786767;
	bh=ZArz3sw1T0RuypyxhGQkyTg2rcfJq/JMIpEbvqqrpf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=NKchw7qo1SvSDyp/8R/+mMJ451mJyRqZw3jUnzvFRFRGsZECAJx48ikVn7wen5z1i
	 JtH3auEVBmz0+SEXZhYEy48Np2phewVI4bVmpmOWn/kmII3m0TZRLW5Uqi93WoI90A
	 kLOkk62jG8gjAwwqTJSlhDrhPn48XmvqOXqTTRyw14pLR9oYP64/onQdzvLwRYBJa4
	 7onUZ5lqrfWMxv72jvjEeA7mb4eyih4AdQoRZkYCKZeeZKmDZA4wG+xuQkZgAWBt5T
	 USZ/gteY2RrfFWPpSGQqi4C/xwWWmDcPByd9hpxBAasxNnirRl5Ewk/vSS6eftvES4
	 e561gnAzKjd/Q==
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
Subject: Re: [PATCH v3 2/3] x86/irq: Fall back to
 irq_chip_retrigger_hierarchy() in fixup_irqs()
In-Reply-To: <20260907065129.269262-3-namjain@linux.microsoft.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-3-namjain@linux.microsoft.com>
Date: Mon, 07 Sep 2026 15:12:44 +0200
Message-ID: <87qzj52oj7.ffs@fw13>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Sep 07 2026 at 06:51, Naman Jain wrote:
> fixup_irqs() re-injects a pending interrupt on its new target CPU by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback directly. When the outermost chip does not implement
> irq_retrigger(), the pending interrupt is silently dropped, which can
> lead to lost interrupts on CPU hot-unplug.
>
> Keep calling the outermost chip's irq_retrigger() when it is present,
> but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
> up the interrupt hierarchy until it finds a chip that implements
> irq_retrigger().
>
> While at it, use a scoped guard for desc->lock. VECTOR_RETRIGGERED is
> now set only when the retrigger succeeds instead of unconditionally,
> which is harmless today since apic_retrigger_irq() always returns 1.
>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Reviewed-by: Thomas Gleixner <tglx@kernel.org>
