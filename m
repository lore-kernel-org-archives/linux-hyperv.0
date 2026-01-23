Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D433570A6;
	Fri, 23 Jan 2026 02:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769134069; cv=none; b=JNpFLE94E2NpXPIDZrGDjqxupIFOpsCgKyx2gxVDCBHWSGnxTjoxnREgYcpl7HY6kpJeu+94wVXl34r8t6ggTNHzVqhqv87d/sxy7qP7KEB4HmCkls4w6EyOAe/3wbTqKeME+jR3d5J8twN1KK+FSmRYfmR956bXQKJGRW6/QSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769134069; c=relaxed/simple;
	bh=ojY+a6IfkT840fPN5tM8nzTECaysVirE3PfMTI1+SuM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eyiod9JaYIMaFTFQsIFp4gEsXrGy9c3GC6LN7Xz3ZdRL0CzoTBQFwGtLz7R33cbdOfW4lHzADzgtXIM7l/uDYYTR2a0J1cBRCBOmRi/B8ZGTIcNIYJMDSItWpcCqZOBwNDX0Y7X7uf+puPw4gwqRGACDWrZNXORCveTVr6/RC+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee97lJSo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee97lJSo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D625FC116C6;
	Fri, 23 Jan 2026 02:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769134067;
	bh=ojY+a6IfkT840fPN5tM8nzTECaysVirE3PfMTI1+SuM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ee97lJSoS7sUWr1c5RupjKPQxlSGiZTywM5czO+bqyqLr1zUHdT/J7u+gujqQjP+X
	 apZZ5jgm/FcJ/9KFIaWKdZKA+rN/Up/of9JGYsLk/ECdG0qzhRXyYTCt5C0de2rEZa
	 G+Iy5XdtBa0UHV/XwFPleXcv6fD/LdxFAnfYbX7sqEGlHAN6ugd+lphdlHyc6iV3Hs
	 EmIm7lEb3233ejBOafMBTuw/QJu3nDigB4BOL6biA8vJoyC2Zc/HeZsYIUw/gMNMx1
	 O6Jys3frxanSbQAf1dS2iIXmGghyrFcH9MoF0/DRcw7eHst/m6fQQ4PKPF1lJBGX13
	 IDP2v2MA1wJ1g==
Date: Thu, 22 Jan 2026 18:07:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 leon@kernel.org, kotaranov@microsoft.com, shradhagupta@linux.microsoft.com,
 yury.norov@gmail.com, dipayanroy@linux.microsoft.com,
 shirazsaleem@microsoft.com, ssengar@linux.microsoft.com,
 gargaditya@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: mana: Improve diagnostic logging for
 better debuggability
Message-ID: <20260122180745.3b5607cf@kernel.org>
In-Reply-To: <aXJhzi58GqLKtui4@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260121065655.18249-1-ernis@linux.microsoft.com>
	<20260121201412.179f9b37@kernel.org>
	<aXJhzi58GqLKtui4@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Jan 2026 09:43:42 -0800 Erni Sri Satya Vennela wrote:
> On Wed, Jan 21, 2026 at 08:14:12PM -0800, Jakub Kicinski wrote:
> > On Tue, 20 Jan 2026 22:56:55 -0800 Erni Sri Satya Vennela wrote:  
> > > Enhance MANA driver logging to provide better visibility into
> > > hardware configuration and error states during driver initialization
> > > and runtime operations.  
> >   
> > > +	dev_info(gc->dev, "Max Resources: msix_usable=%u max_queues=%u\n",
> > > +		 gc->num_msix_usable, gc->max_num_queues);  
> >   
> > > +	dev_info(dev, "Device Config: max_vports=%u adapter_mtu=%u bm_hostmode=%u\n",
> > > +		 *max_num_vports, gc->adapter_mtu, *bm_hostmode);  
> > 
> > IIUC in networking we try to follow the mantra that if the system is
> > functioning correctly there should be no logs. You can expose the debug
> > info via ethtool, devlink, debugfs etc. Take your pick.  
> 
> We discussed this internally and noted that customers often cannot
> reliably reproduce the VM issue. In such cases, the only evidence
> available is the dmesg logs captured during the incident. Asking them to
> re-enable debug options later is not practical, since the problem may
> not occur again. Similarly, exposing the information via ethtool,
> devlink, or debugfs is less effective because the data is transient and
> lost after a reboot. As these messages are printed only once during
> initialization, and not repeated during runtime or driver load/unload,
> we decided to keep them at info level to aid troubleshooting without
> adding noise.

You will have to build proper support tooling like every single vendor
before you. Presumably you can also log from the hypervisor side which
makes your life so much easier than supporting real HW. Yet, real
NIC don't spew random trash to the logs all the time. SMH. Respectfully,
next time y'all "discuss things internally" start with the question of
what makes your case special :|
