Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA2E3AE6E2;
	Wed, 13 May 2026 18:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698074; cv=none; b=ccRQ7a0gJYNy9RQFPsIpitZwiY8OcLQ2RYxtK/D6Wb6reWYjGRB4S6qF0xeYam50Va8VGwhok7EmzxyRphwMByk0bdnfkunv0OwAS4aS3H7GYgX06O/l3DQdIf6zwD6zR9chAIQz6oZSrr24Xg//pNB+vwZV+CH6QjHr9xWRZQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698074; c=relaxed/simple;
	bh=erC7woJFVDIP0guJSuazt/H++XssVTUYjKzmOshpQVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dUqlOiKs+JW7uTaQ8KXImN9alLH45yVh6SHtLn8N+/B322OFrVVvHhYl9QJJ39DNDO6cQRrHhHQkrsvuM5TSAZdwPwSa0rDv+6zpOweEs08aUV/B22pU9KviJKaVBAspJprLNPbfRQYP/p2CGV/+vKNvBofvhs0Qc9KC8U33hxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=awT7zjdg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="awT7zjdg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D632C2BCC6;
	Wed, 13 May 2026 18:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778698073;
	bh=erC7woJFVDIP0guJSuazt/H++XssVTUYjKzmOshpQVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=awT7zjdgJyOru8bU9mrbyY8ZLpO77VzumzKLlauOvWte3vlcg8/FD78kX0AMye4g8
	 FE/iB+BpRrezItb7YSnKIBHfZp/bh0eXdaA/ZfOcjHwys/NzI5T5TqPa6HMBfGXmBO
	 1B/h845+dRPKgIngApElFKK7LhqxTlLqmPgfocAXapEVl2B63dDjbuNsG0xWNHEJmJ
	 hvVnyZY4oc+b2zOU1xwezIuNZ7iwCflRu+L9k6JIKwWTxmDmUFcMpSs1niGL7Wz6ej
	 7c0AlPZ++8CB/MEBhyhOD0MRWyZAEP2cGIF9rlu7/FBMxUDJLeiTDOJpxNUYF5NU8X
	 5DKVDOMu6weJw==
Date: Wed, 13 May 2026 21:47:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Haiyang Zhang <haiyangz@microsoft.com>,
	Haiyang Zhang <haiyangz@linux.microsoft.com>,
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
Message-ID: <20260513184749.GI15586@unreal>
References: <SA3PR21MB38676896F76FD9C27127DA87CA3D2@SA3PR21MB3867.namprd21.prod.outlook.com>
 <20260508231029.GA44712@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260508231029.GA44712@bhelgaas>

On Fri, May 08, 2026 at 06:10:29PM -0500, Bjorn Helgaas wrote:
> On Fri, May 08, 2026 at 10:47:14PM +0000, Haiyang Zhang wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Friday, May 8, 2026 6:38 PM
> > > To: Haiyang Zhang <haiyangz@linux.microsoft.com>
> > > Cc: linux-hyperv@vger.kernel.org; netdev@vger.kernel.org; KY Srinivasan
> > > <kys@microsoft.com>; Haiyang Zhang <haiyangz@microsoft.com>; Wei Liu
> > > <wei.liu@kernel.org>; Dexuan Cui <DECUI@microsoft.com>; Long Li
> > > <longli@microsoft.com>; Andrew Lunn <andrew+netdev@lunn.ch>; David S.
> > > Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>; Jakub
> > > Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>; Bjorn Helgaas
> > > <bhelgaas@google.com>; Simon Horman <horms@kernel.org>; Shradha Gupta
> > > <shradhagupta@linux.microsoft.com>; Dipayaan Roy
> > > <dipayanroy@linux.microsoft.com>; Erni Sri Satya Vennela
> > > <ernis@linux.microsoft.com>; linux-kernel@vger.kernel.org; linux-
> > > pci@vger.kernel.org; Paul Rosswurm <paulros@microsoft.com>
> > > Subject: [EXTERNAL] Re: [PATCH net-next] net: mana: Add handler for sriov
> > > configure
> > > 
> > > On Fri, May 08, 2026 at 03:04:06PM -0700, Haiyang Zhang wrote:
> > > > From: Haiyang Zhang <haiyangz@microsoft.com>
> > > >
> > > > Add callback function for the pci_driver, sriov_configure.
> > > >
> > > > Also disable VF autoprobe when it runs as PF driver on bare metal,
> > > > since the hardware side may not have the VF ready immediately.
> > > >
> > > > Export pci_vf_drivers_autoprobe() so the driver can toggle the VF
> > > > autoprobe flag.
> > > 
> > > Technically pci_vf_drivers_autoprobe() doesn't *toggle* the autoprobe
> > > flag.  That would mean setting it to the opposite of its current
> > > value.
> > > 
> > > Here I would say "so the driver can prevent autoprobing of the VFs",
> > > which is the intent.
> > Thanks, I will change the wording.
> > 
> > > 
> > > Out of curiosity, how do the VFs eventually get probed?  I guess
> > > there's some other mechanism that tells you when they're ready, and
> > > you manually use sysfs 'sriov_drivers_autoprobe' to enable probing,
> > > then bind drivers to them via sysfs?
> > We have a user program talking to the Azure backplane to get that information.
> > @Paul Rosswurm, do you have more details?
> > 
> > 
> > > The prevention of autoprobing sounds like a critical part of this
> > > change; might be worth saying something in the subject, because "add
> > > sriov configure" doesn't include much information.
> > How about "Add handler for sriov configure with VF autoprobe off"?
> 
> OK by me :)

Bjorn,

I believe it is the wrong decision to allow toggling a user‑visible knob  
without the user’s awareness. In this case, they can either disable  
autoprobe on the PF or rely on EPROBE_DEFER. In all cases, the same
functionality can be achieved without changing PCI autoprobe code.

Thanks.

> 
