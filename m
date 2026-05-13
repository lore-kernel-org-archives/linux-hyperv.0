Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E343ACA45;
	Wed, 13 May 2026 19:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778699111; cv=none; b=DZwiXhkOyVzodL6pO4G9XUJQ29qeyTJn9Hq8mWjY4ikh0QH/B8GArKzwkECo7FyqtMDNymPXy+J8SQfGrJjuOm3yU7DTE6opfirIRnyk5f+3XtPKCHtRUrSN/WmAQqSn4IUuvTO0RGmore3fK3O4CCt3N/gpqQSTBjgAiWcyWV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778699111; c=relaxed/simple;
	bh=FzMe9/lOU06yXUx9x0/0CV2FJXck9l6xTP3s84RPoTc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Hlwhc9I3S2YNDL5lYGFzonqJi+wELePG12aefY45W2IlnG6nvXhzIRbTWNRnfheQWxIwUR4hojv9QvK9iiznCAoMASIaJIhA2DzsipfapydVHTgBE+gtLapfrXan3YHD9UuSvjBOnTx7OyMMF0toOosfGPcK3NoqdfRFVdTnesg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qARi/5fN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qARi/5fN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D47AC19425;
	Wed, 13 May 2026 19:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778699111;
	bh=FzMe9/lOU06yXUx9x0/0CV2FJXck9l6xTP3s84RPoTc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=qARi/5fN1L6IKtfUJ1SWvyceeDvBwX6LcgijkcA3RlroTAzbEsDgjBNb2cvgyrrIl
	 ca3QRgGusBymhMEJJe5y3U0hOmjHjG/ZA0MH0oruOFOXkj4b0Qsveh9JXCHMKIlQM7
	 5ybI+J8B+00rGNtcORVTUecoOaFVZ2h7aPBHEc2jyPf0lKUHUWlf9zfHuSYlHnkNZA
	 12WifZMe3otmVjC0aSUGUpf9HmU43kg6JpDBAgMfb1dYRLPqXvZiB3iTO3tfhKPzYG
	 lhsn9c+zJ9J18zE0r4Vq5So1mFVbJJEMgg9S572S2kDe3ke7RLy0cI3GB4/LgtE/St
	 JBd0HJ+MoI6+g==
Date: Wed, 13 May 2026 14:05:09 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20260513190509.GA328362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260513184749.GI15586@unreal>

On Wed, May 13, 2026 at 09:47:49PM +0300, Leon Romanovsky wrote:
> On Fri, May 08, 2026 at 06:10:29PM -0500, Bjorn Helgaas wrote:
> > On Fri, May 08, 2026 at 10:47:14PM +0000, Haiyang Zhang wrote:
> > > > On Fri, May 08, 2026 at 03:04:06PM -0700, Haiyang Zhang wrote:
> > > > > From: Haiyang Zhang <haiyangz@microsoft.com>
> > > > >
> > > > > Add callback function for the pci_driver, sriov_configure.
> > > > >
> > > > > Also disable VF autoprobe when it runs as PF driver on bare metal,
> > > > > since the hardware side may not have the VF ready immediately.
> > > > >
> > > > > Export pci_vf_drivers_autoprobe() so the driver can toggle the VF
> > > > > autoprobe flag.
> > > > 
> > > > Technically pci_vf_drivers_autoprobe() doesn't *toggle* the autoprobe
> > > > flag.  That would mean setting it to the opposite of its current
> > > > value.
> > > > 
> > > > Here I would say "so the driver can prevent autoprobing of the VFs",
> > > > which is the intent.
> > > Thanks, I will change the wording.
> > > 
> > > > 
> > > > Out of curiosity, how do the VFs eventually get probed?  I guess
> > > > there's some other mechanism that tells you when they're ready, and
> > > > you manually use sysfs 'sriov_drivers_autoprobe' to enable probing,
> > > > then bind drivers to them via sysfs?
> > > We have a user program talking to the Azure backplane to get that information.
> > > @Paul Rosswurm, do you have more details?
> > > 
> > > 
> > > > The prevention of autoprobing sounds like a critical part of this
> > > > change; might be worth saying something in the subject, because "add
> > > > sriov configure" doesn't include much information.
> > > How about "Add handler for sriov configure with VF autoprobe off"?
> > 
> > OK by me :)
> 
> I believe it is the wrong decision to allow toggling a user‑visible knob  
> without the user’s awareness. In this case, they can either disable  
> autoprobe on the PF or rely on EPROBE_DEFER. In all cases, the same
> functionality can be achieved without changing PCI autoprobe code.

OK, Haiyang, can you drop my ack please?  If Leon's solutions don't
work for you, continue this conversation and we can explore
alternatives.

Bjorn
