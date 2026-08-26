Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420C348C77;
	Wed, 26 Aug 2026 21:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787779922; cv=none; b=ROTaiHSvT2VQ7fX51CHCKaCf07qVwhxspemlZ+F+1Cxoc7Xwiu6ESsXrC1OUQbgqSZNaemEhDN7R20qeP5b6S3sSKSrjpNp1pzaC8URQBimiKQyl/GqJklYqIPaO/3CAJcKpE3REPTCc+iXCAzdeg7t2ST6RO4cCfS/YZsRDZpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787779922; c=relaxed/simple;
	bh=4r94Q+SUGqGb9kCXjqRUxC+etohQDsFIfSdMtkKPMP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mD3uURsYnWfPI5lgHpDzYCDiIxhlzouNDSo7LQwAVMrsAO67lWbUFtlIyUcdMHJtZhGgInbNTBHa34DmycYWBbPq8NZcWjfpK6NuUDZRFX92R4tK6JjxKF1phmh6IdL7L4V6QpR2UwnOogWMCxrZpEacn5au3IoTAItPCO8GpsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IOn2J7FR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IOn2J7FR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0203D1F000E9;
	Wed, 26 Aug 2026 21:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787779921;
	bh=TMAUIOPCEoNGFW/VYMcMOyRCFLYO6uDIOAx7yhMyKuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IOn2J7FRnlQRmR7sDQh1Zw1xd2UfVJLwE7vS+8+Tn1aRojEbDWrhe2T0QHMBbpKjz
	 tCyvuHMwNPXBDCkeUgmzN4fv5t0OmPYdorY7020Q5ev7MbOTJl+9jPtgcWK9dlVd2/
	 O387a+KF4rvW1UZcIqYIH7u1jKMpRemN7IaNip2WSlSTX3mSYk9g5eWHMll8/7Jjpl
	 I91yuPoazkPGD6/7G59c6JR6MXp4mdjoecpXrIv5aV0w221wn8Ql5dJG7Sv3MvM6vr
	 mOttew0dr+CAwwlHz7f6Vw1fu9xiP2FqEHYIObRJ0fTq74XrZIQuSw09SivPsGtWMW
	 vlxtfMSRCD8aA==
Date: Wed, 26 Aug 2026 14:31:59 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "wei.liu@kernel.org" <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	"mukeshrathor@linux.microsoft.com" <mukeshrathor@linux.microsoft.com>,
	"anirudh@anirudhrb.com" <anirudh@anirudhrb.com>,
	"schakrabarti@linux.microsoft.com" <schakrabarti@linux.microsoft.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <DECUI@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 2/3] PCI: hv: unmap MSI interrupt on the
 nested root partition teardown path
Message-ID: <20260826213159.GA698442@liuwe-devbox-debian-v2.local>
References: <20260822003623.2925128-1-wei.liu@kernel.org>
 <20260822003623.2925128-3-wei.liu@kernel.org>
 <SA1PR21MB6683F98FD2FF83D39F93B473CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB6683F98FD2FF83D39F93B473CEAF2@SA1PR21MB6683.namprd21.prod.outlook.com>

On Tue, Aug 25, 2026 at 08:12:33PM +0000, Long Li wrote:
[...]
> > +static void hv_vmbus_unmap_msi_interrupt(struct pci_dev *pdev
> > __maybe_unused,
> > +					 void *chip_data)
> > +{
> > +	struct hv_msi_int_entry *ie = chip_data;
> > +
> > +	if (!ie || !ie->hv_entry.source)
> > +		return;
> > +#ifdef CONFIG_X86
> > +	hv_unmap_msi_interrupt(pdev, &ie->hv_entry); #endif
> 
> Since you don't want to check the return value from
> hv_unmap_msi_interrupt(), add a (void) to the front to prevent some
> tools from giving warnings.

No problem. Thanks for your review.

Wei
