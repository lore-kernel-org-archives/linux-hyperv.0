Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4AC23EA94;
	Tue, 14 Apr 2026 04:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776141893; cv=none; b=IYF2z9+zxeYNIdYtt3qRfKw+DLD1Kc/jRLHGNoavtwtYL09PXTya6fWyRh71yIMEwjXa72KfOb/AC7Q8ceuNw1NuWYhDL4xgyYK/m3J45sa/6JOqLs8ZJYNbzX3s2c9vkPgkgYxH2J0Lo9ldl78wNNSjeZ78MYbASNklZO4ESx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776141893; c=relaxed/simple;
	bh=pGFPmj8n5awGSd9LRZ6ibKKTZ8kTTiDh9K04xUE4e9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GsvC21kO9ZTcxY5lAP9zj5dlUnpzPVhfDIxsMs+2pv06Uyi86DslDQ4xr3+Bi6S+BUj27OlnN/0wmvN4TgOJ/eLhXM2DlqjYQUUnlpOfiXp7EIxljriLVD9kG/VGFKl3ZH/KwXjbhX8wgZzpgKpWwBjoC8JCuSSuo4Zm7eV7kBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JvGmw/Un; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JvGmw/Un"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8B1C19425;
	Tue, 14 Apr 2026 04:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776141892;
	bh=pGFPmj8n5awGSd9LRZ6ibKKTZ8kTTiDh9K04xUE4e9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JvGmw/Une0mElFmRpM6oIlz/zm3V2ZeNpuD1aoltkFP7F3dfzL5ziJYYHl3DKUWuv
	 /Mx+i1xOrNHHWoDs1u7g8qILsP8Q+D9CftRKmqyy46OnEoSoj6lNeAOK0LFSeO6LW5
	 7FRKnX5MTiV45AQmSM7fNB6l3k3an1GjN0zbDYjV1cJ8+HkxLoS2dS+VMculBxMnPR
	 SEvC3yPWV6QNH4wIfwFZF4jSz8dTq3XPUyDRQjVZPcPwlQuVMQ4iSc//D8fqPac+cw
	 hinlP1KJuD9mzXItVaQEf1SN8kNsl6sDUuWRcJOqhaACOxpoGitt0H3zRnlNpBzh5L
	 hoakvsnwtq84w==
Date: Tue, 14 Apr 2026 04:44:51 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Naman Jain <namjain@linux.microsoft.com>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER
Message-ID: <20260414044451.GC2787213@liuwe-devbox-debian-v2.local>
References: <20260406092459.2351028-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157AADD1038801A5FA14A5ED45DA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157AADD1038801A5FA14A5ED45DA@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Apr 06, 2026 at 02:08:07PM +0000, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, April 6, 2026 2:25 AM
> > 
> > When registering VTL0 memory via MSHV_ADD_VTL0_MEMORY, the kernel
> > computes pgmap->vmemmap_shift as the number of trailing zeros in the
> > OR of start_pfn and last_pfn, intending to use the largest compound
> > page order both endpoints are aligned to.
> > 
> > However, this value is not clamped to MAX_FOLIO_ORDER, so a
> > sufficiently aligned range (e.g. physical range
> > [0x800000000000, 0x800080000000), corresponding to start_pfn=0x800000000
> > with 35 trailing zeros) can produce a shift larger than what
> > memremap_pages() accepts, triggering a WARN and returning -EINVAL:
> > 
> >   WARNING: ... memremap_pages+0x512/0x650
> >   requested folio size unsupported
> > 
> > The MAX_FOLIO_ORDER check was added by
> > commit 646b67d57589 ("mm/memremap: reject unreasonable folio/compound
> > page sizes in memremap_pages()").
> > 
> > Fix this by clamping vmemmap_shift to MAX_FOLIO_ORDER so we always
> > request the largest order the kernel supports, in those cases, rather
> > than an out-of-range value.
> > 
> > Also fix the error path to propagate the actual error code from
> > devm_memremap_pages() instead of hard-coding -EFAULT, which was
> > masking the real -EINVAL return.
> > 
> > Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Applied. Thanks.
