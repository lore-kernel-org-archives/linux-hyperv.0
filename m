Received: from sender5-of-o55.zoho.com (sender5-of-o55.zoho.com [165.173.182.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7A28B4E2;
	Mon, 28 Sep 2026 12:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=165.173.182.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790599481; cv=pass; b=Ztb9jzvszLHOlsNeHdZPJwjOhhBGL983Od+7/FBcbW5N7XVGbh02hZnsDPh9Kz1X57NxJS/Tj8Hc9DPMcCXT+y+ZE76deCAAavaRz+DaL2BLKs8x+jiVXNRQ4y852F3LpGCUURUz6s9vRA7487kHldy3oQN2l3ngjXBef22U/bA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790599481; c=relaxed/simple;
	bh=t1ct19muTVVA6a3YOMPbo5iCaIyj1pbHQTM7tA7TqO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrzbhCjq4LAgC/q6QWmPEmeVFrIc3CAJih1rbI+GPyhkmEREoLc8Weh2pn178X9ClJfIFY8JeF0znc4M75L8uqejEg9NOmei2gYOrNh015GTbB4fHVTlR7l3TUTpEJ0NHFF3vhBqHyhN93DWb9lWNqwoc1CF+pBxtYxMX8crK48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=EbLFQIAQ; arc=pass smtp.client-ip=165.173.182.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="EbLFQIAQ"
ARC-Seal: i=1; a=rsa-sha256; t=1790599467; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hH2KWiLobGVC1XOgDrmKl0zuJgIIXrjIkOYFBcfs6knXT3T2F31AclB4aYJ3D9Vh49SQG8lfRLCr7YoKY4NCpmA49LxoIRN5dZdaZgDA0Beqx73UKUTSSN6e80ThqVUvc6souzpPJeyWczD2fWCI95nJILRu6vcXwY3Z9rlq980=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1790599467; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ntNyoBsPo5i8+2vYK1FbvQG8xjYGXEqBk9oRJ1mBLw0=; 
	b=O+VNDNzGlu6w+lbXYtUzd2OCjAPxNEJkxyu0gQ7SFk1UMLf6t0xCQ3ffXnIbPQnGzVn3Tt3RF2FubvHh9g375XqcLwxv3IszyZ6hFrRGrkaNJvINp585e+AHHHvy8Fij2ywfvg8E4RxurVge/LIN3WS4bhnTgMihzilX6ykRvLE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1790599467;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=ntNyoBsPo5i8+2vYK1FbvQG8xjYGXEqBk9oRJ1mBLw0=;
	b=EbLFQIAQl5U0CFTa6/owiYk9ImlR4oH0eN0fpDgqPqfRORjePjqOPI2NVRl0WT3+
	MnAVf2NA3e+pLXtSmSYeVrnj9S3gEi3zT5OjSS7BXfgucu+6EVQks1WWEYDyCyadskM
	VKW3HVRRh2i3VAqmvHHxU52h4fthBkmUsFWWELes=
Received: by smtp.zohomail.com with SMTPS id 1790599463967550.0402211931;
	Mon, 28 Sep 2026 05:44:23 -0700 (PDT)
Date: Mon, 28 Sep 2026 12:44:16 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@microsoft.com>,
	Wei Liu <liuwe@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Magnus Kulke <magnuskulke@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v3] drivers/hv: remove deposited pages from direct map
Message-ID: <20260928-hopping-illustrious-guppy-d4fd41@anirudhrb>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <20260924-outrageous-nebulous-spaniel-7bf6f7@anirudhrb>
 <arZhqarRnacsApc0@example.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arZhqarRnacsApc0@example.com>
X-Zoho-Virus-Status: 1
X-Zoho-AV-Stamp: zmail-av-0.2.13.1.5.4/290.579.46
X-ZohoMailClient: External

On Fri, Sep 25, 2026 at 01:57:29PM +0200, Magnus Kulke wrote:
> On Thu, Sep 24, 2026 at 01:51:10PM +0000, Anirudh Rayabharam wrote:
> > On Thu, Sep 17, 2026 at 10:10:52PM +0200, Magnus Kulke wrote:
> > > +
> > > +	for (i = 0; i < count; ++i) {
> > > +		page = pfn_to_page(pfns[i]);
> > > +		ret = set_direct_map_valid_noflush(page, 1, true);
> > 
> > Should we batch this? (i.e. collect a batch of contiguous PFNs and restore them
> > at once)
> 
> yeah, seems conceivable. let me check.
> 
> > 
> > > +		/*
> > > +		 * HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
> > > +		 * a 2MiB page, so deposited pages are of 4k granularity and cannot
> > > +		 * be collapses into a 2MiB page, which would require an allocation
> > 
> > 511 is the limit for one deposit call. But after multiple deposit calls,
> > a deposited range can cover a 2 MiB page.
> >
> > > +		 * and can potentially fail.
> > 
> > It is unclear to me what requires an allocation and can potentially
> > fail. Could you please clarify?
> > 
> 
> yeah, admittedly this is properly an overly defensive comment. the point
> was: set_direct_map_valid_noflush() is fallible. I understand one of the
> reasons for it to fail would be reoganization of the direct map,
> which would imply allocations, which in turn could fail.
> 
> but this is contrived and should not happen for the deposit case. Also,
> with Mukesh's proposed rework, this comment would not be accurate anymore.
> So, I'd remove the reasoning from the comment (but keep the logic), ack?

Yeah, sounds good!

Thanks,
Anirudh.

> 
> > > +		 *
> > > +		 * Should it fail anyway we leak the page, if we would hand it
> > > +		 * back to the allocator we would introduce faults into random other
> > > +		 * parts.
> > 
> > I agree this is what we should do. I just don't understand what the
> > first part of this comment block is talking about.
> > 
> > Thanks,
> > Anirudh.
