Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2104F5E16;
	Fri,  9 Oct 2026 18:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791569333; cv=none; b=nG/3yHfLRBTfYJyeZbiInOL2JG1FXGNP3gqZUdbV+S6ne8zxOHTvLx/JCHbW5msMhv8VIcw4TBxqW5k6skOUsSLpEMj+iyunP8p1WghnYHvrVivjVCvfwXbRqG/bEQGprxHRx3VFTNaWEunLXyGHeRU7fzThLMX39NxailjM6ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791569333; c=relaxed/simple;
	bh=Vb/W5crSnHZvMjRDYGpdK7yRdgtKNTBcDR4pdGIYMVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5R5Te0+7BrdAi0nzk40wGx05yPRbpFDJtxtQrlCUI9B8l0Pi/MkJv9pN156fFSb+kj4I7xUg5xpnzBq32Vs2ZTdouLn8eHRHvtqKU9N4lBooClNxjA7i9MSA917wP0v4HU5Lu0ikXrjaD9635LvOgU2I8n1X3VM3R3APn1VIaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKeiI94K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKeiI94K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA6CA1F0089A;
	Fri,  9 Oct 2026 18:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791569332;
	bh=yMKB0/CDrKrwBDu8KE21+bn+guH2IF+9Jd0i82ZwBf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QKeiI94KeCKXTSuCxu29bghIVPHTcHhMe6C+q0zk4ceIWT7/F3eUq3NKmlkR63XpQ
	 iF3jEkevdU6L4Ai0caGnzGicG5NegV1fv/WyvINDCWHGRjjbbeCctDDoIy5jyN108D
	 VdyGzzye45sowhr5OuxHo+kZ8BPonuQe+ptG22uB54pYi72w3NQ2et14aSNzqzYjwq
	 8uJeS2mPqX6TYeCssO6n4XBEYUb6HvAGqsnV+kEoEoTWbi6v25L+kqSgKcA6d3X7tC
	 dtOifCb3a0B0/5aK0fzR73uYAAr+wmDJ556BClcr3Xh9jcBa4fCHgh9B+qIK0bC1a+
	 g52dUgg1J/oiw==
Date: Fri, 9 Oct 2026 21:08:47 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Pavel Popov <pavel.e.popov@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Message-ID: <20261009180847.GD11438@unreal>
References: <20261009154034.82321-1-pavel.e.popov@intel.com>
 <20261009165833.GA991924@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009165833.GA991924@bhelgaas>

On Fri, Oct 09, 2026 at 11:58:33AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 09, 2026 at 08:40:32AM -0700, Pavel Popov wrote:
> > VMware and Hyper-V expose passthrough devices to guest VMs without an
> > explicit host bridge device. Consequently, host_bridge_whitelist()
> > cannot automatically identify the underlying host bridge structure,
> > causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
> > device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
> > P2PDMA support in virtualized environments on Intel hosts, this series
> > introduces hypervisor_supports_p2pdma().
> > 
> > Although alternative P2PDMA mechanisms are in development [1], their
> > adoption timeline in hypervisors remains uncertain. This solution
> > addresses the immediate need to support both new and existing
> > hypervisor deployments.
> > 
> > The patches are organized by hypervisor for clarity. While the primary
> > focus is VMware, a corresponding Hyper-V patch addresses the same
> > pattern and is included for maintainer consideration.
> > 
> > [1] https://lore.kernel.org/r/20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com
> > 
> > Pavel Popov (2):
> >   PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts
> >   PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts
> > 
> >  drivers/pci/p2pdma.c | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> 
> Applied with the #ifdef tweak Logan suggested to pci/p2pdma for v7.4,
> thanks!

Bjorn,

I disagree with this decision for several reasons:

1. Note where `hypervisor_supports_p2pdma()` is called: before
   `host_bridge_whitelist()`. This means the code ignores the hypervisor
   topology. The claim that the VM has a virtual bridge, causing
   `pci_p2pdma_whitelist()` to fail, describes exactly how P2P is expected
   to work today.

2. We are not developing an alternative solution. This is the right
   solution, and there is broad agreement that it is the only reliable
   way to enable P2P in VMs, for ALL emulation software stacks.

3. This problem has existed and been known for at least the past eight
   years, since Logan upstreamed P2P support. The claim "we need it now
   and ASAP" is not valid at all.

4. The proposed hack does not solve the P2P-in-VM problem; it only makes it work
   in some random cases. An HMAT-based solution will still be needed, even on systems
   that use this hack.

Let's get the HMAT solution merged sooner rather than later. To make that happen,
we need a coordinated effort across the industry, not hacks to work around the
problem.

> 
> FWIW, it's better if responses like Jim's Reviewed-by actually appear
> on the mailing list.  I don't see anything in lore, so I assume it
> must have been private review.

Unfortunately, this patch series was not given enough time for review.

Thanks

> 
