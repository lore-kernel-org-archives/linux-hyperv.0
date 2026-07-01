Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7049253F;
	Wed,  1 Jul 2026 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922306; cv=none; b=nIu13RyIXeqtD+siOOjDQedHxhN21er5DP3hzkSqkbT+XlOzBhFUPT1E9RcWbmAkFouDky4vffdT7mDsIoyb4+zEZhWWEdiEqX7RGO0aIWhoqrxeRgfAVZEI+7XO+1gjNqLQCTDvjMPyzXD1HEekA7Vmz1bDWZ0TwpDhFb9+HXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922306; c=relaxed/simple;
	bh=ncGd+Uia4lKlhwhfW9nV026tLmncxGBny7bzdz7OzrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M+6BHgP22Dyi4d3psjbRGrdPU+Eytwokv1CMzmKzwtBblNK1WiQa07PBNIvilkfIiZegq6tkVQdPVt0heKY+xVONdTL2wSMHrjUPYBr4fobSOdmJt4OOPMxeILXn3unIv1XfaU3UfpvaXuIyCSrI2r6s4j0XzTzIxkV4FZrUB9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kESdWjN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kESdWjN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0D91F000E9;
	Wed,  1 Jul 2026 16:11:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922305;
	bh=DnlZv/MpX+OVj13OgCdjbs/+8RI6gQY6u8lZA89nDWk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kESdWjN8F0SiK3UeDe/pOomSYoIGu6PmGf1QjiDI6mKabcv/RzJkLxfADwtlxry7a
	 Z6j+HOb8q82gknLtTWAWyYmdw73bUWx9ZVW9h774X/6lSC1qOl8WC6/HRGyiBnGjkq
	 h1dM2x9ElyROcODLs+ySCeAjf2Elcv4zrTbdqZBTysdKIXiHYtKnwGUUc/OOrDJ9Ex
	 tt6044C6OzRBRK3ykEqnBoOPiCjV7lcdlCLYZNM6c5r/cbj8WoPAi1D2ZFZL3ORJ8Q
	 jTXXq2EUgwxpkxAD7ATgSJYCdJGk7cLHlDMIxU3GKj3RLkm8CPtqhfQg+J4Tox6RHE
	 l1M3OKU8tsLjQ==
Date: Wed, 1 Jul 2026 09:11:43 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: wei.liu@kernel.org,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	stable@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: fix hv_input_get_system_property struct
Message-ID: <20260701161143.GA201446@liuwe-devbox-debian-v2.local>
References: <20260630215754.200779-1-wei.liu@kernel.org>
 <akRIKl4wTuZVw/t0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akRIKl4wTuZVw/t0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Tue, Jun 30, 2026 at 06:50:18PM -0400, Hamza Mahfooz wrote:
> On Tue, Jun 30, 2026 at 02:57:54PM -0700, wei.liu@kernel.org wrote:
> > From: Wei Liu <wei.liu@kernel.org>
> > 
> > Keep it in sync with the correct definition.
> > 
> > The old code worked by chance.
> > 
> > Cc: stable@kernel.org
> 
> Any idea how far back this goes? Also, does it require a check on the
> hypervisor version, or was it always wrong?

This should go as far as possible. The upstream version has always been
wrong.

We cannot check versions. Version numbers are not reliable indicators.

Wei

> 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> > ---
> >  include/hyperv/hvhdk_mini.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> > index b4cb2fa26e9b..035ba20870f7 100644
> > --- a/include/hyperv/hvhdk_mini.h
> > +++ b/include/hyperv/hvhdk_mini.h
> > @@ -184,8 +184,9 @@ enum hv_dynamic_processor_feature_property {
> >  
> >  struct hv_input_get_system_property {
> >  	u32 property_id; /* enum hv_system_property */
> > +	u32 reserved;
> >  	union {
> > -		u32 as_uint32;
> > +		u64 as_uint64;
> >  #if IS_ENABLED(CONFIG_X86)
> >  		/* enum hv_dynamic_processor_feature_property */
> >  		u32 hv_processor_feature;
> > -- 
> > 2.53.0
> > 
