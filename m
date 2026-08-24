Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0AD340A6F;
	Mon, 24 Aug 2026 16:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590750; cv=none; b=Vkwhm/nxuIGvzNUuTa3lvNzq++OkYsP0ddwjDzMKUq9P54o9xEbiC1IFJe0b0rjZRzevgwZm6Jjw2jqmvQjunjft7eRPwY+pwzA7/jfA/Ti8NmYH0QkkUz09hdnTciI3gsdOUv7vwuXEUCCf6Sa0QHFsmVNmPMQithuzCYxQZ4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590750; c=relaxed/simple;
	bh=xbQa7dZ9Yyh1PjOBCsUdSB4J3sIWqKu8xF2eMCloQo8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWJWfrW43B+jdAW4ifa+D5tnZEtqlVSk7UDkBqAAV1mpQWqDcTNU2WawU3kII9EEIKyg90zjQxTVHdnWOMI4FUCxgCtLNc1wkSKx7mHY8KuT/q4BFLaScWhHZ+EVIzm2vMwjZdW7xGOZ//uTAC//r0TRPAVx6SaE2QxyIeNV2Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LnyTdvHz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LnyTdvHz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 375881F000E9;
	Mon, 24 Aug 2026 16:59:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590749;
	bh=5/BH79+CqA6IIdAR2F8+dBdDhwPn29fwNmv8Nwu8Y+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LnyTdvHz2YraQUh4NvxfioN15s/U8HaegOZT09dZkHuomh1kk5ULHX1nwyhosuOG+
	 bE59RMkdfnFOzqj3/s93kQ7bv4wA4WulnSZBeV4jqvU6SV6zEZBKUbZpqAjhiF2bdx
	 AVJ4FJRALUpQQDeQBriuhCAb7UPCwwWnPj3jZdxtfhx6TMHZ80eEy6LpvU+b8ZY1c0
	 szlVY0UYzNWjyxzd07tBSAhyVEblhTUg7Mc0//rOXJtz1HZA653vnxtWg0WlLQlikc
	 ByMA44TJvzj4F/8kQp4DUibVs5//d50bgGDPN8nCyoBQBAf0eQ7GVib2meMCp4n5C6
	 HsJ21sCD9X6iw==
Date: Mon, 24 Aug 2026 09:59:08 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, sashiko-reviews@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V
 PCI MSI irqchip
Message-ID: <20260824165908.GC3665124@liuwe-devbox-debian-v2.local>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-2-namjain@linux.microsoft.com>
 <20260728140427.714311F000E9@smtp.kernel.org>
 <a9d44162-3c90-44c8-aae7-4813678234a9@linux.microsoft.com>
 <20260824001406.GC3566091@liuwe-devbox-debian-v2.local>
 <c165f17f-b214-4a96-a446-6dd4e6cb2161@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c165f17f-b214-4a96-a446-6dd4e6cb2161@linux.microsoft.com>

On Mon, Aug 24, 2026 at 11:57:56AM +0530, Naman Jain wrote:
> 
> 
> On 8/24/2026 5:44 AM, Wei Liu wrote:
> > On Thu, Jul 30, 2026 at 04:56:27PM +0530, Naman Jain wrote:
> > > 
> > > 
> > > On 7/28/2026 7:34 PM, sashiko-bot@kernel.org wrote:
> > > > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > > > 
> > > > Pre-existing issues:
> > > > - [High] The fix for dropped pending interrupts during CPU hot-unplug was missed in the sister Hyper-V root partition MSI domain.
> > > > --
> > > > 
> > > > --- Patch [1]: [PATCH 1/3] PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip ---
> > > > commit b8b1c843c457dd145f0d360b44f4b1bf34bd8cf5
> > > > Author: Naman Jain <namjain@linux.microsoft.com>
> > > > 
> > > > PCI: hv: Set irq_retrigger callback for the Hyper-V PCI MSI irqchip
> > > > 
> > > > The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
> > > > On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> > > > the outgoing CPU to a new target. As the Hyper-V PCI/MSI chip does not
> > > > provide that callback, the pending interrupt is silently dropped, which
> > > > can result in lost interrupts, stalls and "No irq handler for vector"
> > > > messages.
> > > > 
> > > > Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
> > > > Cc: stable@vger.kernel.org
> > > > Suggested-by: Long Li <longli@microsoft.com>
> > > > Suggested-by: Thomas Gleixner <tglx@kernel.org>
> > > > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > > > 
> > > > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > > > index cfc8fa403dad6..89816a2bd7cd3 100644
> > > > > --- a/drivers/pci/controller/pci-hyperv.c
> > > > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > > > @@ -2119,6 +2119,7 @@ static bool hv_pcie_init_dev_msi_info(struct device *dev, struct irq_domain *dom
> > > > >    	info->ops->msi_prepare = hv_msi_prepare;
> > > > >    	chip->irq_set_affinity = irq_chip_set_affinity_parent;
> > > > > +	chip->irq_retrigger = irq_chip_retrigger_hierarchy;
> > > > 
> > > > [Severity: High]
> > > > This isn't a bug introduced by this patch, but does the sister Hyper-V root
> > > > partition MSI domain in arch/x86/hyperv/irqdomain.c also need this fix?
> > > > 
> > > > Looking at hv_init_dev_msi_info(), it appears to be missing the exact same
> > > > callback initialization for the root partition's top-level irq_chip:
> > > > 
> > > > arch/x86/hyperv/irqdomain.c:hv_init_dev_msi_info() {
> > > > 	...
> > > > 	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
> > > > 		return false;
> > > > 
> > > > 	chip->flags |= IRQCHIP_SKIP_SET_WAKE | IRQCHIP_MOVE_DEFERRED;
> > > > 
> > > > 	info->ops->msi_prepare = pci_msi_prepare;
> > > > 
> > > > 	return true;
> > > > }
> > > > 
> > > > If a CPU is hot-unplugged while a device MSI interrupt is pending in its
> > > > local APIC IRR, could fixup_irqs() fail to resend the pending interrupt
> > > > to the new target CPU because this callback is NULL?
> > > > 
> > > > This could potentially lead to the same lost interrupts and I/O stalls
> > > > described in this commit message, just in the root partition MSI domain
> > > > instead of the guest paravirtual MSI domain.
> > > > 
> > > > >    	if (IS_ENABLED(CONFIG_X86))
> > > > >    		chip->flags |= IRQCHIP_MOVE_DEFERRED;
> > > > > 
> > > > 
> > > 
> > > I am not planning to include this in this series, since this issue is not
> > > seen in root partition yet and I am not sure if it is applicable here.
> > > Second patch would anyways fix it going forward, but I am OK adding the
> > > change for this, if we need.
> > 
> > What's the downside of fixing the root partition irq domain?
> 
> No downside as such. It would be a latent bug, exposed only if we exercise
> hotplug in root partition, which seems like we don't. After patch 2 of this
> series, that would go away anyways. If you tell me, I can add a change
> similar to patch 1, which is backportable, but then I would need to remove
> it similarly in patch 3.

Yes, please fix that for the root partition, too. Being consistent
across different use cases is going to save us some headache in the
future.

Wei
