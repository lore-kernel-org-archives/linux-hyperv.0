Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76F43218BA;
	Sat, 19 Sep 2026 23:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859355; cv=none; b=h/GAd4hfHc5Lq+QFctDidqVU0C0OvvJWwzJRVnPEXsnFaCCJjMOO1vM0B25s+dcbvrNJcBeUITIqXtLImlp71t3kIsFytXcCdLcoZPeFoFNFKwg/oR9rpfNmDiJNfbA8BN21rlFw/Pdb7wpH3Sxv2+X81yqFCsYrExM5DELWKX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859355; c=relaxed/simple;
	bh=3iK2MKrfH1CUO9tUQ+QSinyhYVhPXccw9tzEt/xFNdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r7Sk6MCj3NtCIAuJn1JTqbShEgDTI6irPDAVTy0C1dH51kjaVT8JAfasOjyzL3U2OmLgME3JzFo87quCGWd2cCkX4Iyx9DynsRvO4NjGAMuhjPScL4IjeIXAg0ayERcypuH3VVvwrDbvuBBicZ7IVT4f4VlIdyRiNJ4F/sExWbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmHLF+1t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmHLF+1t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 062771F000FF;
	Sat, 19 Sep 2026 23:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789859354;
	bh=iBosbdAHqee/hC/cy+hlYKBPHE3XVSHZxs2lJHZwFXo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jmHLF+1tITod8RdxGEivZdKPyzI3cgNa8pXwCyeo7HjGCNLs4TgywrN8YagpW5bTP
	 SLZlR6tsKsvm6wCyPvckby9Frzt4f1whkKCh7ckmyZ+Wb2SFy6mNQ5ZV4HlzXqzk1/
	 byDlXjBaF1NZpSclcHqbOksz9wDyr94ynbvoYhKv0+1GftlV9iX3AoyrT0KMpxnCAT
	 Ly0aGqvhV6jI4SPf0dxQJdDwH64tGEwYYWriolSD5U6WJ7K6tU+GbWGJfxuKT/79Ut
	 zR8vhSTRa9UBefbA0AWityAp7d3lwUb2lTbpD8DNtENwkSPNqdRZ4D0FXcneMZiwE2
	 3EIhTPlxhsT4Q==
Date: Sat, 19 Sep 2026 16:09:12 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Sahil Chandna <sahilchandna@linux.microsoft.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Probe vPCI buses asynchronously
Message-ID: <20260919230912.GD1008213@liuwe-devbox-debian-v2.local>
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
 <011f1fa5-89c5-4bc5-8b2e-c5f415a57559@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <011f1fa5-89c5-4bc5-8b2e-c5f415a57559@linux.microsoft.com>

On Thu, Sep 17, 2026 at 11:01:03AM +0530, Sahil Chandna wrote:
> On 07-09-2026 11:17, Naman Jain wrote:
> > On Hyper-V guests each virtual PCI bus is enumerated by its own
> > hv_pci_probe() call. The probe performs several synchronous host
> > request/response exchanges while negotiating the protocol, querying bus
> > relations, entering D0, and reporting allocated resources. These waits
> > are latency-bound rather than CPU-bound.
> > 
> > hv_pci registers as an ordinary VMBus driver, so driver_register() walks
> > matching vPCI buses and probes them sequentially while the driver's
> > initcall runs. On guests that expose several devices, each through its
> > own vPCI bus, this serialization adds the host round-trip latencies to
> > device initialization.
> > 
> > Each bus is described by its own struct hv_pcibus_device, so
> > independent buses can be probed concurrently. Request asynchronous
> > probing via PROBE_PREFER_ASYNCHRONOUS, causing the driver core to
> > schedule matching buses for asynchronous probe work.
> > 
> > On an Azure Standard_L32s_v3 guest with five vPCI targets (four NVMe
> > controllers and one Mellanox VF), Linux 7.2.3 was tested with one warm-up
> > and three measured boots per variant. The median interval from the first
> > hv_pci_probe() entry to the last return decreased from 2847.968 ms to
> > 2786.709 ms, a 61.259 ms (2.15%) improvement.
> > 
> > Co-developed-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> > ---
> > 
> > Previous discussion around this change:
> > https://lore.kernel.org/all/20230420024037.5921-7-decui@microsoft.com/
> > 
> > Skipping removal of pci_rescan_remove_lock, due to possible
> > synchronization problems associated with this lock removal. Also, with
> > my current setup, I was not able to see much improvements with this
> > change, so keeping it for later. Asynchronous probing change is not
> > dependent on this.
> > 
> > ---
> >  drivers/pci/controller/pci-hyperv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > index 89816a2bd7cd3..056d379b3cee4 100644
> > --- a/drivers/pci/controller/pci-hyperv.c
> > +++ b/drivers/pci/controller/pci-hyperv.c
> > @@ -4155,6 +4155,9 @@ static struct hv_driver hv_pci_drv = {
> >  	.remove		= hv_pci_remove,
> >  	.suspend	= hv_pci_suspend,
> >  	.resume		= hv_pci_resume,
> > +	.driver = {
> > +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
> > +	},
> >  };
> >  
> >  static void __exit exit_hv_pci_drv(void)
> LGTM.
> Reviewed-by: Sahil Chandna <sahilchandna@linux.microsoft.com>

Applied. Thanks.
