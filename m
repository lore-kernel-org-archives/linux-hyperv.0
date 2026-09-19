Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEA62DEA7B;
	Sat, 19 Sep 2026 23:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789859804; cv=none; b=FaluamKwzBnnJ4iYosqQ11GhL/2oTj+tc2zGl2CexqVXm6eZVXD3I9qO1QbiuqhA1dQyEGiQdOUQlhSQDd/P8vxLOEahm9CcAxC9DzJxU9wRhPnvC+8ShFJopnXl4nvm9Db+FaQ0Lfc/6/otCHkQ42KCffYSSK/zsOExyiV6kzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789859804; c=relaxed/simple;
	bh=EeaxHF1qYlp58g3MD1cXseZ0NqA6E1pGGpVQA666GZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HRaEvlMxTwmXe3NMjsPiwYZzxJC4S4MXr8RP+l0Fx/rmTkHCwMJtbinYiuC0cYB2ukWl+sikmMmflQAEzyttiyLVBKLH/fa+9GFFe2bdZieHHUiBgOqiXfVHivOE3gPM9/SQeWup8VKpmr+ouzG5Agg13NfZ8w40dDusiwgnqOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O62iAsWc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O62iAsWc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F8F1F000FF;
	Sat, 19 Sep 2026 23:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789859803;
	bh=+2bApAD4zKwIrRUoeakVCrPn2bQflOxVnZ4qveW4Il0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=O62iAsWcA3YBjuDFtICnSoKEOxfvuVByZAL31U+yZm/ZsK50Ju0al3DV6+3YQxyWc
	 cEcVWOg9f2WQisqizTPB8j/p/NDxXUDNV4oe6IqemccqrHiOQsO/1JMSA7qk/VmK45
	 LKFaYrKINZ7qmXIfWmG3064Yowx4tbMB9gdM9CHJ5ybiFnHkOHQvi05xmCLOzdtL89
	 wa3+GtRQ4bg0tR5lBLpnPq9K7uxNm0r/GUUTkEkMdCEugG0AY4TwVA5ir/vOh5Ha3/
	 3+rrjkPtuWiWFmuEAdatWmjgPrFX6XA0StXmJRHCwgvvF8MQ6Qb7eR5QtN56zrB9da
	 amwUjZPuzP7zw==
Date: Sat, 19 Sep 2026 16:16:41 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: Mukesh R <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
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
Message-ID: <20260919231641.GE1008213@liuwe-devbox-debian-v2.local>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <a543145c-4503-bdd8-bd73-a2cbcce1e06e@linux.microsoft.com>
 <aq0W/c9SKCympVHE@example.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aq0W/c9SKCympVHE@example.com>

On Fri, Sep 18, 2026 at 12:48:29PM +0200, Magnus Kulke wrote:
> On Thu, Sep 17, 2026 at 05:23:15PM -0700, Mukesh R wrote:
> > On 9/17/26 13:10, Magnus Kulke wrote:
> > 
> > FYI:
> > 
> > https://lore.kernel.org/linux-hyperv/20260912000318.2959621-1-mrathor@linux.microsoft.com/
> > 
> > Thanks,
> > -Mukesh
> > 
> > 
> 
> Thanks, the change to a larger single page makes sense. I assume we
> would still be susceptible to a #GP once the kernel steps into it?
> 
> Since this is addressing acute crashes on L1VH, it would be good to
> merge a fix first IMO. it can then be easily cherrypicked into
> backports or distro-kernels.
> 

I think we should get a fix that's easy to backport committed first.

Wei

> Or would you rather see the problem addressed as part of in your
> deposit-pages refactoring?
> 
> best,
> 
> magnus
