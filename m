Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD42141687D;
	Fri, 25 Sep 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790337458; cv=none; b=mvZknMfP/lYq4G6E9IZT/LdYzWmKTsaEETNYn1rTVAPgBmYz5NUQu1Wtep8QbcDZuBk8+QSkLnzee3Ak3D4ZRk5HK835PcAe0h6zU7bPyhxnIv3aUEvlYJIKh+qh8saQQJENcg05uJ1104G0jMijr1mgLPnlold+SygXxIfed3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790337458; c=relaxed/simple;
	bh=Zi6wr26YA9OIx5Da31+KpmC5h6g2hnmGAwSzJGjQMiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uvSHceVt7QsmHMXmSlMfRbfKM4noD/MDmhaE2gC0WzLBGFfZOID9x5LejVjavLbzmnA4v8ATAF5MvIT59fXD2GdmfZtL63RdydGra8B5mmBVO+jJcM8oeel5mrdZjVi1a1hlMDQjVA2F5Q1oEVi7y4n0gsDUiY5D0TktzUf3c7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RKPJZyxH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RKPJZyxH"
Received: from example.com (p3e9c0608.dip0.t-ipconnect.de [62.156.6.8])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0B5F920B7167;
	Fri, 25 Sep 2026 04:56:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B5F920B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790337406;
	bh=/b9Bhls9/dlkd/KWJh5Yn3Ls5ZvkZcjV0Nz9UfrDS1g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RKPJZyxHRIaoGkxPZQsqkr8mTpNG285qG0gguddB+SksdyP1swyyVePkyhIEmWFhc
	 JsCM8Rr2TWvsqz1sozX+AzE89TGbYczwJNzb6ua/CFG4peDaVJAoeApEFENxudX9hb
	 QKzoP/FYtekhkz4tpttYvDnXgxc4iU+9S/fQsTGc=
Date: Fri, 25 Sep 2026 13:57:29 +0200
From: Magnus Kulke <magnuskulke@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
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
Message-ID: <arZhqarRnacsApc0@example.com>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <20260924-outrageous-nebulous-spaniel-7bf6f7@anirudhrb>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924-outrageous-nebulous-spaniel-7bf6f7@anirudhrb>

On Thu, Sep 24, 2026 at 01:51:10PM +0000, Anirudh Rayabharam wrote:
> On Thu, Sep 17, 2026 at 10:10:52PM +0200, Magnus Kulke wrote:
> > +
> > +	for (i = 0; i < count; ++i) {
> > +		page = pfn_to_page(pfns[i]);
> > +		ret = set_direct_map_valid_noflush(page, 1, true);
> 
> Should we batch this? (i.e. collect a batch of contiguous PFNs and restore them
> at once)

yeah, seems conceivable. let me check.

> 
> > +		/*
> > +		 * HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
> > +		 * a 2MiB page, so deposited pages are of 4k granularity and cannot
> > +		 * be collapses into a 2MiB page, which would require an allocation
> 
> 511 is the limit for one deposit call. But after multiple deposit calls,
> a deposited range can cover a 2 MiB page.
>
> > +		 * and can potentially fail.
> 
> It is unclear to me what requires an allocation and can potentially
> fail. Could you please clarify?
> 

yeah, admittedly this is properly an overly defensive comment. the point
was: set_direct_map_valid_noflush() is fallible. I understand one of the
reasons for it to fail would be reoganization of the direct map,
which would imply allocations, which in turn could fail.

but this is contrived and should not happen for the deposit case. Also,
with Mukesh's proposed rework, this comment would not be accurate anymore.
So, I'd remove the reasoning from the comment (but keep the logic), ack?

> > +		 *
> > +		 * Should it fail anyway we leak the page, if we would hand it
> > +		 * back to the allocator we would introduce faults into random other
> > +		 * parts.
> 
> I agree this is what we should do. I just don't understand what the
> first part of this comment block is talking about.
> 
> Thanks,
> Anirudh.
