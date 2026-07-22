Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3ED439340;
	Wed, 22 Jul 2026 22:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784757705; cv=none; b=tLuLu/6ltRM1aQ59dSCS9j77eFZPsLIOrcP1f8lcajinFxGcV7D888/pE/nmfYMyuFr2iOMPxp1k3vXDtnxDsOQ+81XGIEpOVtqoTfqDxjpsJKoWdGsBBT4woGGB7sbQBmyW4GfQA+/9bMsK6I8lJUEQih1y7g0ADHy7/dXyKI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784757705; c=relaxed/simple;
	bh=jR3oS+AjfgEuiTrbRZzEu9RAZyTFy+lhIWA3EMwhFsg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B8K42359P06APrXFGiBFyXXsnb/KS+KrfIIY90xFKetfC9KSvEpsOMb/7FhK+bPjF3fWw3mQlkipkoDen1u7ozDsQrwzp9rVVCq+hUSBshiD9K/Am3SST0hsshv6aoj+eQXAZfx4V5H1cAkU1jBlX1Wu2ycQNdtIsgZJJ6mfBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMgLEQ3P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMgLEQ3P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530D21F00A3A;
	Wed, 22 Jul 2026 22:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784757700;
	bh=FqOjwZAHKaFLejtS/hgp6cp3XwW2oiZU7XIm8xdxe5w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bMgLEQ3PbbmXKLYvrhn4sro4whQqA+NF+iSDj5ESbFKcQ7f+4MTIik3YdVz7AdUDE
	 TO2MJ3Ol0xVJgEWFluRH/WUhzfYemYTxKfEFoPSU1A5s5Eh+NZfMkDb4/TUcgXz1IV
	 Iw4tkHrb3fR9KYdGGr1Ye/qYGq9wL56QTi0FG08Ol6a4eLccObuyPbYjklcHHkn1HL
	 LbGoDB095riaqijKk6E0/FIT05ryHxgqhNC9maWukVzSAl5AZIzUOOh5TT/7Z8u8Bb
	 0qDYaLXN3po5jV5QF/KHdpweIu7C5t1wpMssvurhvtdvv3YkXXOqis43P4FlA9Ho08
	 5A13ennBO18Pw==
Date: Wed, 22 Jul 2026 15:01:39 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] Drivers: hv: vmbus: Set DMA coherent mask for VMBus
 devices
Message-ID: <20260722220139.GC2020652@liuwe-devbox-debian-v2.local>
References: <20260608020616.52852-1-mhklkml@zohomail.com>
 <SN6PR02MB415756E14DDAFCD7ECED3971D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415756E14DDAFCD7ECED3971D4C72@SN6PR02MB4157.namprd02.prod.outlook.com>

On Thu, Jul 16, 2026 at 05:57:49PM +0000, Michael Kelley wrote:
> From: Michael Kelley <mhklkml@zohomail.com> Sent: Sunday, June 7, 2026 7:06 PM
> > 
> > In current code, the coherent_dma_mask for VMBus devices is not set, so
> > it has the default value of 0, which essentially means "invalid". Because
> > drivers for VMBus devices do not use dma_alloc_*() functions, the usual
> > use of the coherent mask does not occur, and no errors result.
> > 
> > However, a valid coherent_dma_mask may be needed even though the drivers
> > don't use dma_alloc_*() functions. In a CoCo VM, the VMBus storvsc and
> > netvsc drivers must bounce buffer DMA operations through the swiotlb
> > because the Hyper-V host can't DMA into encrypted guest memory. If the
> > kernel is built with CONFIG_SWIOTLB_DYNAMIC and the initial swiotlb size
> > is small, swiotlb code may need to grow the swiotlb in response to a DMA
> > mapping request. That growth first allocates a transient pool while the
> > swiotlb is expanded in the background. The transient pool memory is
> > allocated from the DMA atomic pools, and the allocation code checks for
> > a valid coherent_dma_mask. With current code, this check fails, then the
> > DMA mapping request from the storvsc or netvsc driver fails, and finally
> > an I/O error occurs.
> > 
> > Fix this problem by setting coherent_dma_mask for VMBus devices at the
> > same time that dma_mask is set. Being a synthetic bus, VMBus does not
> > have any restrictions on coherent DMA, so the coherent mask is set to
> > the full 64 bits for all VMBus devices, just like with dma_mask.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> 
> Gentle ping:  Anyone able to review this patch? There's a
> Sashiko comment, but it's for an issue in an unrelated error path,
> so I'm not planning to respin this patch for that comment.

Applied. Thanks.
