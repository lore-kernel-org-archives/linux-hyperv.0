Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB0D39023C;
	Fri,  8 May 2026 23:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281831; cv=none; b=OiFSxsWA49J4rK7CssNXnTaiBDCbxNafiI8846ufxCGMT9fHHXQhO5wr0juMlas6Lm9BQVIgyUajH/gb3e4d4rRIPAd4KNbmaorFfSshFM3DiJt/i+be6WSrDbGo4AIwyLmHn6GVk9a+9YYad5HELySoyuY0dNisD1ACMd9Xmqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281831; c=relaxed/simple;
	bh=ySSKNmhBmlbCwTc0DPhIiKcRM0NcLjA5RuILh88UDEk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=f83rT/W6kJe9H5gcR62xCmt5htETi2BUmX8nqObmhBGwpSCChT82M8qwku6KtV+OSSXkYgOLFaTg+ZN7m+25r4mj4krFrkZeI6eeFOnMEmdbIMvYXgy2Msp2RtC15SqVv1wY0lboychIZ6TuQXsTek8FuKn3Wfak8IBblSuNIp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YhzIhad3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YhzIhad3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26C9C2BCB0;
	Fri,  8 May 2026 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281830;
	bh=ySSKNmhBmlbCwTc0DPhIiKcRM0NcLjA5RuILh88UDEk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YhzIhad3JpZoQLiG1QsRwKmHv8W9dRcmTX7fgKRT/iemiasDbrUGDgaa17zPcUCKx
	 THBEIVz4gshoTWRQ2fh1n0JqCaqT+ZaXbXP1KsWdkXTJW02B8aHLMJB9NP7NSUS2xS
	 ebqXk48BZVebddGA36/UpUZsTbWq9saLNHm1wLfDgXdGWFusvMenEpzu/FwNgwlPFo
	 xnNIGseZ/P1e685A1Ex/FUe3XzhOPeInxdO2E2M1dxC35qX4ckTbmzgfq90m8cUabg
	 5UudYMVyB3g6z+59MNBKKc87VmbDP3aIzbIGXggfJ1D/RoYG77FRbdQthJHLnOZFCc
	 jLoBHGDUr83Zw==
Date: Fri, 8 May 2026 18:10:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Haiyang Zhang <haiyangz@linux.microsoft.com>,
	Paul Rosswurm <paulros@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>, Long Li <longli@microsoft.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Simon Horman <horms@kernel.org>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
 configure
Message-ID: <20260508231029.GA44712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR21MB38676896F76FD9C27127DA87CA3D2@SA3PR21MB3867.namprd21.prod.outlook.com>

On Fri, May 08, 2026 at 10:47:14PM +0000, Haiyang Zhang wrote:
> > -----Original Message-----
> > From: Bjorn Helgaas <helgaas@kernel.org>
> > Sent: Friday, May 8, 2026 6:38 PM
> > To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> > Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> > <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> > <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Bjorn Helgaas
> > <bhelgaas@google.com>; Simon Horman <horms@kernel.org>; Shradha Gupta
> > <shradhagupta@linux.microsoft.com>; Dipayaan Roy
> > <dipayanroy@linux.microsoft.com>; Erni Sri Satya Vennela
> > <ernis@linux.microsoft.com>; linux-kernel@vger.kernel.org; linux-
> > pci@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> > Subject: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
> > configure
> > 
> > On Fri, May 08, 2026 at 03:04:06PM -0700, Haiyang Zhang wrote:
> > > From: Haiyang Zhang <haiyangz@microsoft.com>
> > >
> > > Add callback function for the pci_driver, sriov_configure.
> > >
> > > Also disable VF autoprobe when it runs as PF driver on bare metal,
> > > since the hardware side may not have the VF ready immediately.
> > >
> > > Export pci_vf_drivers_autoprobe() so the driver can toggle the VF
> > > autoprobe flag.
> > 
> > Technically pci_vf_drivers_autoprobe() doesn't *toggle* the autoprobe
> > flag.  That would mean setting it to the opposite of its current
> > value.
> > 
> > Here I would say "so the driver can prevent autoprobing of the VFs",
> > which is the intent.
> Thanks, I will change the wording.
> 
> > 
> > Out of curiosity, how do the VFs eventually get probed?  I guess
> > there's some other mechanism that tells you when they're ready, and
> > you manually use sysfs 'sriov_drivers_autoprobe' to enable probing,
> > then bind drivers to them via sysfs?
> We have a user program talking to the Azure backplane to get that information.
> @Paul Rosswurm, do you have more details?
> 
> 
> > The prevention of autoprobing sounds like a critical part of this
> > change; might be worth saying something in the subject, because "add
> > sriov configure" doesn't include much information.
> How about "Add handler for sriov configure with VF autoprobe off"?

OK by me :)
