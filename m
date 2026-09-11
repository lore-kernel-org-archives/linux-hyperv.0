Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B93831618B;
	Fri, 11 Sep 2026 10:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789122555; cv=none; b=iDXWmUievfwtAXtnELwoMIjse6Y0wsMfsJnJa/Y4Mxvb8Jyfvuk+OpPI/zy2wSVD+Nr1TjJksxRUlZbN8aw9srdxQaWPE5v5DZW01f9Rtkp6x7HGTZcLwiX3CCZAm8azff4wBHhMcgriEc2seODf/Xz3eYypJZ7ym735yogVjQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789122555; c=relaxed/simple;
	bh=LKuzjAqbxaDQ2qfgnGQCalE+d0UygJTMMx96Iz8eQu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPBvBcB9ruZGJWkgoL7lpPh0qLAhdrywmJqf7YWJJrEEjPxJioS+sQYk93aFCP24k5PqE/7P9igltSotbFpLUCpt8to2aZ/odehJDuNAFgmZNq0AOqJBE0xfqvEONZkqVUrj1IcQ1vYqdHCPGtOQH2QAOkWRxdDAuH3Mhl/6SFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da8rHM4+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da8rHM4+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2311F000FF;
	Fri, 11 Sep 2026 10:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789122554;
	bh=X7MA/w3ezZEEYFe3391SsFlW7VhiU5zJ62So+wophUI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Da8rHM4+x+8xT/ItysFYV01rwIJDPoO359WB72JaC8Nx8c50qHWsVb7dhdU/UDszZ
	 CcZYb6DVxK72uoKOClai7YDGvNAvK9gPU25EYgLb8hIHNqbW0JnONvtXXLTimk5qJv
	 toYlvAR2BEiTYOorKfPyrNrmSlH7Jfk7OKebnsjmNDCp4VIfrQn0TVmWrVg5/09yTr
	 SS/oTus8A4+U8RuQ6gxMWQJMbTA99kMJ/YaYOCb/Sf+WS9gkJdKwXjB57oEmcPWFYL
	 4pd4WJkdker8vgPJQUCi3+dVCZ3Zq6mxUWiU7PbncmjfXUpk74SIzWLPjfZKn70dnr
	 omRECRVCZMZEQ==
Date: Fri, 11 Sep 2026 12:29:05 +0200
From: Manivannan Sadhasivam <mani@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Sahil Chandna <sahilchandna@linux.microsoft.com>, kys@microsoft.com, 
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mhklinux@outlook.com
Subject: Re: [PATCH v3] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Message-ID: <hen5k4ejonfffwdir7tfa2gnmxwfbbqabrjtwooo4o5pjf5gnz@x52vfm5phv3l>
References: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
 <c8b6e10f-dd52-4c74-8d16-268563d8bc1f@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c8b6e10f-dd52-4c74-8d16-268563d8bc1f@linux.microsoft.com>

On Wed, Sep 09, 2026 at 03:01:22PM +0530, Naman Jain wrote:
> 
> 
> On 9/8/2026 5:00 PM, Sahil Chandna wrote:
> > A guest can wait indefinitely in wait_for_response() for the host to
> > send either a rescind message or a packet completion. If the
> > host does not send either, the guest can remain blocked with no
> > diagnostic indicating a reason.
> > This was observed during a guest kernel upgrade in which the
> > host-side application handling the PCI channel faulted, causing the
> > guest to never receive the completion request.
> > Add a warning in wait_for_response() when the wait exceeds
> > a timeout so that such a hang is visible in the guest's kernel log
> > and can be correlated with host-side state.
> > 
> > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> > ---
> > Changes since v2:
> > - Add counter based timeout instead of introducing another timer
> > Link to v2: https://lore.kernel.org/all/20260902115854.2629164-1-sahilchandna@linux.microsoft.com/
> > 
> > Changes since v1:
> > - Removed periodic warning to one time warning in 2 minutes
> > - Include vmbus relid and stuck PCI msg.
> > Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
> >   drivers/pci/controller/pci-hyperv.c | 46 ++++++++++++++++++++++-------
> >   1 file changed, 36 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 89816a2bd7cd..bd07402c47ed 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -1040,19 +1040,38 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
> > 
> >   /*
> >    * There is no good way to get notified from vmbus_onoffer_rescind(),
> > - * so let's use polling here, since this is not a hot path.
> > + * so let's use polling here, since this is not a hot path. If
> > + * wait_for_response() has been polling for 2 minutes
> > + * without either a rescind or completion, add a warning.
> >    */
> > +#define PCI_RESPONSE_HANG_TICKS 1200
> > +
> 
> Nit, I think this variable name could be misleading, as this represents a
> loop counter for a retry logic, but not exactly *ticks* from kernel
> terminology.
> 
> I would have preferred something like: PCI_RESPONSE_WARN_POLL_COUNT.
> 

PCI_RESPONSE_POLL_COUNT?

- Mani

-- 
மணிவண்ணன் சதாசிவம்
