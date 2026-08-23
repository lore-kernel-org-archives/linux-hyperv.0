Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2762DF134;
	Sun, 23 Aug 2026 23:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787529425; cv=none; b=J1uO7nR7g53E3OQiHp9enkEyPG6SAdnA8n5mjuSbbA9CUVjFRif82gbqu/X/IQETftZYhGHyNqYbEZaCZZUklEQSTJ2qjgxp00eg7quoNNh7E7SkQZU0eCpzQ8XQtxyOGeoRHKktjdegdSJiUbAAs1ennZS2SyF4v8n9Ux1xFfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787529425; c=relaxed/simple;
	bh=/vh9aRIyNRbedagQxMg+fPJvHafgqO2F6w0WizsCJvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVv586JS5ZJbdjUohbSByYJ0jWveVdW+t2I/LBZYd01YrAnl7v4tRgwb10Ve7djGelnnfkrte+crlmmpPOdgiKhUgUUvWRfefnFgjynu/K1JcCbBRfpF7AmZ+SSlD7QYuP/jFGR3RGMFvNQy2/3tWS1bWYa5uWYKiHeewxZdCBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj1qSClo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj1qSClo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E77951F000E9;
	Sun, 23 Aug 2026 23:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787529424;
	bh=O5SbCNfnMjv5k8msoooVD6oD2TypF+9sEXy8sPhvT/8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dj1qSClo5YJmULq7MzR34ONqyxy1qARhbJGsekZcl/Z94GELAFrHCOC5bqzupyUFj
	 K2qYTql5H9Xpt6f8BVtNQYT3XAK2zKr5giovsIUGEZXX7P9COwceyK7HaU6M73i4s7
	 3XI55v5W0gvvMuMrlJkz0DMJQQX82IlAllPMkZ6gGMbZ0LMGqBDlKG0mvOV1gDh4Cr
	 ZhK4zdJm9RoCXYyvTOQi5Iw9QjTR2/BfF7LSK7W8X/eO8aT2a89fPx9afC+IvhCHOk
	 iADdNG6z7TjDvxIOAK0L0KVnuWnEL73/+WI6Wt7VaonYqP8ndaJEHC//9njxRN40gW
	 iw3T7WQPyeakg==
Date: Sun, 23 Aug 2026 16:57:02 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <DECUI@microsoft.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH RFC 2/2] PCI: hv: Add vPCI device reset support
Message-ID: <20260823235702.GA3566091@liuwe-devbox-debian-v2.local>
References: <20260724230844.3259741-1-wei.liu@kernel.org>
 <20260724230844.3259741-3-wei.liu@kernel.org>
 <SA1PR21MB6683A0687C14475889222AACCEDB2@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR21MB6683A0687C14475889222AACCEDB2@SA1PR21MB6683.namprd21.prod.outlook.com>

On Thu, Aug 13, 2026 at 09:40:48PM +0000, Long Li wrote:
> 
> 
> > -----Original Message-----
> > From: wei.liu@kernel.org <wei.liu@kernel.org>
> > Sent: Friday, July 24, 2026 4:09 PM
> > To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>; linux-
> > pci@vger.kernel.org
> > Cc: Wei Liu <wei.liu@kernel.org>; KY Srinivasan <kys@microsoft.com>;
> > Haiyang Zhang <haiyangz@microsoft.com>; Dexuan Cui
> > <DECUI@microsoft.com>; Long Li <longli@microsoft.com>; Jonathan Corbet
> > <corbet@lwn.net>; Shuah Khan <skhan@linuxfoundation.org>; Lorenzo
> > Pieralisi <lpieralisi@kernel.org>; Krzysztof Wilczyński
> > <kwilczynski@kernel.org>; Manivannan Sadhasivam <mani@kernel.org>; Rob
> > Herring <robh@kernel.org>; Bjorn Helgaas <bhelgaas@google.com>; open
> > list:DOCUMENTATION <linux-doc@vger.kernel.org>; open list <linux-
> > kernel@vger.kernel.org>
> > Subject: [EXTERNAL] [PATCH RFC 2/2] PCI: hv: Add vPCI device reset support
> > 
> > From: Wei Liu <wei.liu@kernel.org>
> > 
> > Hyper-V vPCI protocol version 1.5 adds a RESET_DEVICE request for projected
> > PCI functions. Negotiate the new protocol version and issue the request
> > through the vPCI VMBus channel from the PCI controller reset callback.
> > 
> > Use the existing VMBus response path. Return -ENOTTY when the host
> > reports STATUS_NOT_SUPPORTED so PCI core may try another reset method.
> > 
> > Signed-off-by: Wei Liu <wei.liu@kernel.org>
> 
> Reviewed-by: Long Li <longli@microsoft.com>

Thanks for the review!

I still need to find some copious free time to test the new hook
suggested in patch one.

I don't think changes in patch 1 will result in major changes in this
patch, so I intend to retain this tag when I post next time.

Thanks,
Wei
