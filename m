Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FE83A7F60;
	Fri,  9 Oct 2026 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565116; cv=none; b=LcJQEihI4iZfWvYKdJLk+ML+vPIcjIdhbR3VgJ6Hjfznb8PRFemyM0ubc85CxX2eoViw6urPFZU9EPRuKExunBNlbB1NXJRBAVjmTmR5md4rqtf1jGz+soRDCqMGerc9d5CorpXfqHEpXYGSCFeh0JusdLFWGVnaHAZ8TfFRaDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565116; c=relaxed/simple;
	bh=vZUUCPkR42j2Q6m7d0wSJzBAnLa4QHv12WhFAYBChmA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eVIXoUskSJEOMDLFsdgjxcBo1QRoyRFZ66yteRFKk0Ze+DeNy9R0fjg246q9dPRKRob0baf+KEnVONXCo70gVnUzwfwmBAWAbqdgfD/8D2MxUjLCgkw6wB5fyr12njPYBtJingTLUNI88W/9ETgDhFSL0M/rZew3rgEooCgW+Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BVoXvf4K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BVoXvf4K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5901F00893;
	Fri,  9 Oct 2026 16:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791565115;
	bh=gWAZfmGtLpnZ15mtiy/59v4KdsbXL8BjzcebF5S/Icw=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=BVoXvf4Koh6siMmZ7rbJRKVPCewM9nb5GQvZ3RKnJFbcEBh3H5TPZ+L0a/nJ/v8iC
	 OYrZ5OBC1dlkR8yp1Wsoic0CxAThiApYK8FO57cuI856bCZBqPlStvusp3wZlbdnGq
	 JfOhKReXHRZmdQyVPZ/3EN6bJGbdz0t7UPVL/aI5SuChJaElCJ+MAOVdofMn5oPHuG
	 RsYKeuYF7w4oEamvEzKy7W1UlPFCsVZfJl+CLxbnXYvegy3O2UImHzMU0QTV4YHrbs
	 5Mm+L1Q5InWEcnJMz9SR/ikI+jK8YPeslP2t/dGsVx7w9+cNkEnF9vQwg+wK20EYql
	 VDcx2AXmStxUA==
Date: Fri, 9 Oct 2026 11:58:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Pavel Popov <pavel.e.popov@intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Jim Chow <jim.chow@broadcom.com>,
	Radu Rugina <radu.rugina@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Lukas Wunner <lukas@wunner.de>, Leon Romanovsky <leonro@nvidia.com>,
	Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
	bcm-kernel-feedback-list@broadcom.com,
	virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI/P2PDMA: Allow P2PDMA in VMware and Hyper-V
 guests on Intel hosts
Message-ID: <20261009165833.GA991924@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009154034.82321-1-pavel.e.popov@intel.com>

On Fri, Oct 09, 2026 at 08:40:32AM -0700, Pavel Popov wrote:
> VMware and Hyper-V expose passthrough devices to guest VMs without an
> explicit host bridge device. Consequently, host_bridge_whitelist()
> cannot automatically identify the underlying host bridge structure,
> causing Peer-to-Peer DMA (P2PDMA) requests to be rejected unless the
> device IDs are explicitly listed in pci_p2pdma_whitelist[]. To enable
> P2PDMA support in virtualized environments on Intel hosts, this series
> introduces hypervisor_supports_p2pdma().
> 
> Although alternative P2PDMA mechanisms are in development [1], their
> adoption timeline in hypervisors remains uncertain. This solution
> addresses the immediate need to support both new and existing
> hypervisor deployments.
> 
> The patches are organized by hypervisor for clarity. While the primary
> focus is VMware, a corresponding Hyper-V patch addresses the same
> pattern and is included for maintainer consideration.
> 
> [1] https://lore.kernel.org/r/20260812-hmat-p2p-v1-0-75ac41380585@nvidia.com
> 
> Pavel Popov (2):
>   PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel hosts
>   PCI/P2PDMA: Allow P2PDMA in Hyper-V guests on Intel hosts
> 
>  drivers/pci/p2pdma.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)

Applied with the #ifdef tweak Logan suggested to pci/p2pdma for v7.4,
thanks!

FWIW, it's better if responses like Jim's Reviewed-by actually appear
on the mailing list.  I don't see anything in lore, so I assume it
must have been private review.
