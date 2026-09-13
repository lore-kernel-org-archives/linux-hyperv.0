Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14A035B634;
	Sun, 13 Sep 2026 22:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339195; cv=none; b=t6lWGSSy9qSRbOEgf1YSzvr/M/GYzENeFBdYaahWV4YgGjndKOj1GzthT9FeQoJdzjIzlWh0sAhEzGtOmh2lqXBJVtdFyB/5JqdJF6WN5V6LpcTzobLC2nKwp4KwPw2m9YrVjOdEKxRmh+Y8nhqF5oDMa05Y2YcsVt8pujgI+8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339195; c=relaxed/simple;
	bh=aZiqDReMsM2D4iUFh0xQPvNQvFw8ZLj4F4ePkL+P+e0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oTIjTtNR6U9vq59uggSLw+kka2n/KItH7evyzvPhMP+730rSLV+Hz1zhaN2Twj5xoa16si0/X6xi4JlYMKrIHWu23As20taAb5D67iQ0Dr68R7C07lWh2mqNUJguOh8KPR4AMtX8Uf8t+1+RtYoVdNwgrLU+SaqULxn4Qy9O4ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvE9wa3e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvE9wa3e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C54D1F000FF;
	Sun, 13 Sep 2026 22:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339194;
	bh=0Rf62qtp2T8RCmF5Smaw5L38HTOThi3MhIC+kh2jwjo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WvE9wa3eTytCyxqyze1VTsgM1uk3z/LhPEMWvJVlMGzXnXv7dUlG/FmTeOcja8RKK
	 e824AJsggfeOCbDer7Uhl7PyRizyUEPb6Ln/Ek87kInm8fPJrrMuh+XUKgdE20SBDl
	 pZLs+jjOkasJiVjKKRFrrHLlkjdUfDXvpcWgK9QYss6XrepN7Pr5L+fi3TCdMqwHp1
	 Z7RNSTcUeGXU54DN3/YvPDaWIjY20yb6JKoGa9K8NNk9jrtyR7FSo4fGrdeuBrw00Z
	 2/04bExXsIcruC4dey1QTpOzz5yzFwTLInPY8YLhFf30vP85CWmGaX+EoKMfJnOBmH
	 KnezgssVdah0Q==
Date: Sun, 13 Sep 2026 15:39:52 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	Sahil Chandna <sahilchandna@linux.microsoft.com>, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	longli@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
	robh@kernel.org, bhelgaas@google.com, linux-hyperv@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com
Subject: Re: [PATCH v3] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Message-ID: <20260913223952.GE2219269@liuwe-devbox-debian-v2.local>
References: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
 <c8b6e10f-dd52-4c74-8d16-268563d8bc1f@linux.microsoft.com>
 <hen5k4ejonfffwdir7tfa2gnmxwfbbqabrjtwooo4o5pjf5gnz@x52vfm5phv3l>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hen5k4ejonfffwdir7tfa2gnmxwfbbqabrjtwooo4o5pjf5gnz@x52vfm5phv3l>

On Fri, Sep 11, 2026 at 12:29:05PM +0200, Manivannan Sadhasivam wrote:
> On Wed, Sep 09, 2026 at 03:01:22PM +0530, Naman Jain wrote:
> > 
> > 
> > On 9/8/2026 5:00 PM, Sahil Chandna wrote:
> > > A guest can wait indefinitely in wait_for_response() for the host to
> > > send either a rescind message or a packet completion. If the
> > > host does not send either, the guest can remain blocked with no
> > > diagnostic indicating a reason.
> > > This was observed during a guest kernel upgrade in which the
> > > host-side application handling the PCI channel faulted, causing the
> > > guest to never receive the completion request.
> > > Add a warning in wait_for_response() when the wait exceeds
> > > a timeout so that such a hang is visible in the guest's kernel log
> > > and can be correlated with host-side state.
> > > 
> > > Suggested-by: Michael Kelley <mhklinux@outlook.com>
> > > Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> > > ---
> > > Changes since v2:
> > > - Add counter based timeout instead of introducing another timer
> > > Link to v2: https://lore.kernel.org/all/20260902115854.2629164-1-sahilchandna@linux.microsoft.com/
> > > 
> > > Changes since v1:
> > > - Removed periodic warning to one time warning in 2 minutes
> > > - Include vmbus relid and stuck PCI msg.
> > > Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
> > >   drivers/pci/controller/pci-hyperv.c | 46 ++++++++++++++++++++++-------
> > >   1 file changed, 36 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> > > index 89816a2bd7cd..bd07402c47ed 100644
> > > --- a/drivers/pci/controller/pci-hyperv.c
> > > +++ b/drivers/pci/controller/pci-hyperv.c
> > > @@ -1040,19 +1040,38 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
> > > 
> > >   /*
> > >    * There is no good way to get notified from vmbus_onoffer_rescind(),
> > > - * so let's use polling here, since this is not a hot path.
> > > + * so let's use polling here, since this is not a hot path. If
> > > + * wait_for_response() has been polling for 2 minutes
> > > + * without either a rescind or completion, add a warning.
> > >    */
> > > +#define PCI_RESPONSE_HANG_TICKS 1200
> > > +
> > 
> > Nit, I think this variable name could be misleading, as this represents a
> > loop counter for a retry logic, but not exactly *ticks* from kernel
> > terminology.
> > 
> > I would have preferred something like: PCI_RESPONSE_WARN_POLL_COUNT.
> > 
> 
> PCI_RESPONSE_POLL_COUNT?

Sahil, let me know if you will send out another version. If it is only
changing one macro name, I can do that.

Wei
