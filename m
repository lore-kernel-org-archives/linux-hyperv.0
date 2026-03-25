Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E2406275;
	Wed, 25 Mar 2026 17:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460223; cv=none; b=IZ86UCyMQLliYdefH3iAQOFRf/sDloCa49emwrQ8ylPDjK7Wb+GevPVoaXbUe0w/id7+TL9EQHXZHHvoAJ5zXgARiI2mWzAEqH8ryze4apbEbSC/OsXkQD/kUJ/jP+wg1x/4u9a0nyrSS+x8S6MRYJ5TfVYm/GqAbYN6RR1/Nq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460223; c=relaxed/simple;
	bh=kQf/QYvEpAprlxoMSXXppaBQluI/GUGeL0WpD2EWSyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K70AZ8oiA+Z5VU0zPaIXOfG+iofJa0SezMY/cTd1YXEEK3C3gW6gB1OJVWkVp67CyMN45cR/wSqO9C/ZVk3efy+4HMiZFfuPvke5Ub7fn53GkYfQaVUtrvgGOhPFoR7jdzkNmodaBu2jVqLE5S+SDouspSdQCtapL02gguoSdYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P81fZloI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P81fZloI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82376C4CEF7;
	Wed, 25 Mar 2026 17:37:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774460222;
	bh=kQf/QYvEpAprlxoMSXXppaBQluI/GUGeL0WpD2EWSyY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P81fZloId0W7qeL1d/xNr2TcWZuLWlAAvmaCZGFcSrXHhjfKHsJOt+B1Tl8KYpou0
	 VkR3VHHM64bAln1XHYVg7+CTMig99mdSNSbvzzA+eCF+uqPYB4jgH6nZam691DDxyb
	 LhNZkvsPEaxYTEGIcQyb3FLKSlrmod2jdDQljn1Z/Ne4Hjb8aVkC7oBfD4KbE+pomc
	 y1ogdgRsTM6gnRSHYyNFJVKcSa9Oo9F2MHJ2sJkB1bGzkqEhEX6jvKTXQJtJvv+Zap
	 ecvJFNbVUPPEid2e+K+6pptqReNg8lzEhFLr8GVKkJY6/UqCtvgvLPaiZL3su046ds
	 fwU7IzZEgY2kA==
Date: Wed, 25 Mar 2026 17:37:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: hv: Set default NUMA node to 0 for devices
 without affinity info
Message-ID: <20260325173701.GA2061088@liuwe-devbox-debian-v2.local>
References: <20260316210742.1240128-1-longli@microsoft.com>
 <20260320051741.GA761114@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320051741.GA761114@liuwe-devbox-debian-v2.local>

On Fri, Mar 20, 2026 at 05:17:41AM +0000, Wei Liu wrote:
> On Mon, Mar 16, 2026 at 02:07:42PM -0700, Long Li wrote:
> > When hv_pci_assign_numa_node() processes a device that does not have
> > HV_PCI_DEVICE_FLAG_NUMA_AFFINITY set or has an out-of-range
> > virtual_numa_node, the device NUMA node is left unset. On x86_64,
> > the uninitialized default happens to be 0, but on ARM64 it is
> > NUMA_NO_NODE (-1).
> > 
> > Tests show that when no NUMA information is available from the Hyper-V
> > host, devices perform best when assigned to node 0. With NUMA_NO_NODE
> > the kernel may spread work across NUMA nodes, which degrades
> > performance on Hyper-V, particularly for high-throughput devices like
> > MANA.
> > 
> > Always set the device NUMA node to 0 before the conditional NUMA
> > affinity check, so that devices get a performant default when the host
> > provides no NUMA information, and behavior is consistent on both
> > x86_64 and ARM64.
> > 
> > Fixes: 999dd956d838 ("PCI: hv: Add support for protocol 1.3 and support PCI_BUS_RELATIONS2")
> > Signed-off-by: Long Li <longli@microsoft.com>
> 
> I can pick this up next week. PCI maintainers, if you want this to go
> through your tree instead, please let me know.

Applied to hyperv-fixes.
