Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792567535;
	b=DLVlJEBBPb8WZQLOBL7uS3oc1ISmshvDwYWxd4itgsN8cfCgXTOGlbiskS2BcckVJC+D
	 bzaD2NYdizBNi5DpycXikPbk+c3xe8c0bf2oWdkgWRU0uUDso4qPw4Xm3vVaNvDT+H8uG
	 R0H9cjdAL326gXGlZDiGcTpj9990DP1ZhvPABY7wsXHfNwijZZocLdr8oloJKftPykmeT
	 bQLhuYe2Opr4Hni9OfCrH0r9lIliuyUFA0fm88iJH57Cn8euc2p9dHYCEZcq7APR18hqy
	 c/+ZkLDk72WLw0wnghjHvTPTG8xQm+dK9sL/ZZk6dMEco8MM0b30i3qw9ugY7xCR4RA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792567535;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=BqNlK5oUyB6wKQ8IfAXz0SrJ30GxNkRirmJEJkun1PI=;
	b=imemGo2vo/m8twPwnOVdb0cwujedhvyPRl+TOdT/n+Qr07tfWzVrG0cFOXIVMH79RRnK
	 R6ykiaIDPRfFXf0xQoMaVnEq3FWjLwQ3LG12tgqyNIYKb2xNJOu4WOJCSBAlPUOE+kGek
	 gHTFrqVRUQg/m6JO4pgnm4w6nGqaDk8SNxBPa590Ab5OQh8Bgsem0+zUG6DNxaZdXyXZi
	 gPYcML72csf5y/QXZPP2RjlUcJKmwbCOEuUcUEjr87guSEI9DmVaf9TVG9Y9ZggZS16sv
	 j9EfzUorc22YgbeRAXTWNoGKq/1QrdogkTXFvJxQhIB05SC3IVym9YhOPIffu2gwGFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIo3J4VH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F30606A31A;
	Wed, 21 Oct 2026 07:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AIo3J4VH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79E691F000CA;
	Wed, 21 Oct 2026 07:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792567534;
	bh=BqNlK5oUyB6wKQ8IfAXz0SrJ30GxNkRirmJEJkun1PI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AIo3J4VH+6ukWxcRId4tC/Y15Fr+i02NbF776bKoC7mOcXE2hwvXCp3w/L7g9kKtr
	 ph72GduZmIspAI4g34Vx1RVr2zmbPsdhv9HLdU/l035RWeXSlYZTSTJ1fjbW6tsmo5
	 NK06lzsi2NpWg8EH+Oay4KvFFzx4fXs/i3jk9U56xTHvIbu/OwkuxyQ0f4GtohZSU0
	 kJ8XY3xxBdih9TND6ib/+G08XOw4DM07v8DQwelav5+c19ZLAzJVGUgBuHU5qwluzm
	 q6TN+g3HqG5BmUbjv3rRMxZ9jamOrPrzPaYlQxH9OmJ2TU+B4oH2W1NsWNqZxtbrVW
	 qmeD9OO72GRDg==
Date: Wed, 21 Oct 2026 00:25:33 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
	rdunlap@infradead.org, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Remove support for guests
 on Hyper-V 2012/2012R2
Message-ID: <20261021072533.GG851443@liuwe-devbox-debian-v2.local>
References: <20261009174007.6745-1-mhklinux@outlook.com>
 <12b726c0-46c6-4f3e-9119-24f6c877e3fb@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12b726c0-46c6-4f3e-9119-24f6c877e3fb@linux.microsoft.com>

On Mon, Oct 12, 2026 at 11:10:08AM +0530, Naman Jain wrote:
> 
> 
> On 10/9/2026 11:10 PM, Michael Kelley wrote:
> > Support for running Linux guests on Windows Server 2012/2012 R2 Hyper-V
> > hosts and Windows 8/8.1 hosts has been removed, which includes removing
> > support for operating Hyper-V synthetic timers in other than Direct Mode.
> > Update the documentation to reflect these removals.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > ---
> > Changes since v1:
> > * Updated the netvsc.rst network driver documentation [Naman Jain]
> > * My "below the line" comment in v1 wrong. It said that removal of WS2012
> >    support was going into 7.4. But it is actually already in 7.3. So
> >    ideally these doc changes would go into 7.3 as well.
> > 
> >   .../device_drivers/ethernet/microsoft/netvsc.rst   | 14 +++++++-------
> >   Documentation/virt/hyperv/clocks.rst               |  8 ++------
> >   Documentation/virt/hyperv/overview.rst             |  6 +++---
> >   3 files changed, 12 insertions(+), 16 deletions(-)
> > 
> 
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Applied.

Wei
