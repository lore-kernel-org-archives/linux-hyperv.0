Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555C221FD4;
	Mon, 24 Aug 2026 00:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787530511; cv=none; b=LlJf2Gfd0p42gz+g9JWZk9OI1xj/SMt84yeKohOLxU8jTlvRf9/KxbbKQsty/Hi3+A2a24Mwi7VWvoUCl4H5CZEBvYoeHoooFKU11Yv30SCCgRvagB4MUyH28/Clykv9gOezhlJIIfC4khTS9Jqgt2ua/Z7pZw8PJZB6CAW/Nwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787530511; c=relaxed/simple;
	bh=pMNSADQiouJzV/Ti6y5BHwS4ZQ41OY6GE3E9eFniJZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fQzQmzjM/h9ToED0NpIF3wpC8ipjSGXOq8chUbXm24qPbBSEbEZP/hYrKxtXaBuEl/hU+2s060XfqyadgT3yYAl6BGyRkxSNH61TBz17oWnQh5+UV69SvOoOSSrgi+yr9KyhWudjZYIlLfgDlkYLbuQBQlkA7VXIIEunIInzEoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bblK9nJw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bblK9nJw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 940021F000E9;
	Mon, 24 Aug 2026 00:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787530510;
	bh=Uk/3glVosXfbFUfyQ7G5VBNFPxn4bq7xO5x07CZjVsc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bblK9nJwYwqTeLgwKVpFbQALk2fxk2+Uz4lCYBUUYL34guP3OUGMB9oEFnIQk0TQ+
	 8PDiD66xrTrZy2Q8QYvqtx953ZY6819w1Sda6fmBQxa4O7TneU3DPoht+iHXFPqcuU
	 gpXgJX5TkfbDfylLxIB9cLUBpEFAzXwBvYg5PX9JxdZngPXF/PW4YOzRKlHCEz2Nye
	 wq2skTsSSg/xqGFTJbmYHvzRq2t2Y9kSPaT7GPQCiHyKGqHTKZ49ebVG5OXfY1kcto
	 1SsfW1cXL5fN1Sms+tf2wi5RcVAk0d60P/Do9MxYFafZ8FDoo/zQeGEj1k4fch6Z1k
	 Q99LIeYGU1r5Q==
Date: Sun, 23 Aug 2026 17:15:08 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, x86@kernel.org,
	Jake Oshins <jakeo@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Message-ID: <20260824001508.GD3566091@liuwe-devbox-debian-v2.local>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-3-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728135117.2888175-3-namjain@linux.microsoft.com>

On Tue, Jul 28, 2026 at 01:51:16PM +0000, Naman Jain wrote:
> fixup_irqs() re-injects a pending interrupt on its new target CPU by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback directly. That only works when the outermost chip happens to
> install an irq_retrigger() callback, which is not guaranteed for every
> irqchip and could lead to lost interrupts on CPU hot-unplug.
> 
> Use irq_chip_retrigger_hierarchy() instead, which walks up the interrupt
> hierarchy until it finds a chip that implements irq_retrigger().
> 
> While at it, move the loop-local variables into the loop scope and use a
> scoped guard for desc->lock.
> 
> No functional change intended for chips which already provide an
> irq_retrigger() callback on the outermost domain.
> 
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

I can pick this up as part of this series but this requires an ack from
Thomas.

Wei

> ---
>  arch/x86/kernel/irq.c | 23 +++++++----------------
>  1 file changed, 7 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> index 30122f0b3af96..ef1bdd3c4659a 100644
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
> @@ -466,11 +466,6 @@ DEFINE_IDTENTRY_SYSVEC(sysvec_posted_msi_notification)
>  /* A cpu has been removed from cpu_online_mask.  Reset irq affinities. */
>  void fixup_irqs(void)
>  {
> -	unsigned int vector;
> -	struct irq_desc *desc;
> -	struct irq_data *data;
> -	struct irq_chip *chip;
> -
>  	irq_migrate_all_off_this_cpu();
>  
>  	/*
> @@ -489,22 +484,18 @@ void fixup_irqs(void)
>  	 * vector_lock because the cpu is already marked !online, so
>  	 * nothing else will touch it.
>  	 */
> -	for (vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> -		if (IS_ERR_OR_NULL(__this_cpu_read(vector_irq[vector])))
> +	for (unsigned int vector = FIRST_EXTERNAL_VECTOR; vector < NR_VECTORS; vector++) {
> +		struct irq_desc *desc = __this_cpu_read(vector_irq[vector]);
> +
> +		if (IS_ERR_OR_NULL(desc))
>  			continue;
>  
>  		if (is_vector_pending(vector)) {
> -			desc = __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> -			data = irq_desc_get_irq_data(desc);
> -			chip = irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			guard(raw_spinlock)(&desc->lock);
> +			if (irq_chip_retrigger_hierarchy(&desc->irq_data))
>  				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>  		}
> +
>  		if (__this_cpu_read(vector_irq[vector]) != VECTOR_RETRIGGERED)
>  			__this_cpu_write(vector_irq[vector], VECTOR_UNUSED);
>  	}
> -- 
> 2.43.0
> 
> 
