Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C92E3CF1E7;
	Mon, 12 Oct 2026 14:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815286; cv=none; b=ZNS8LD/yu6rIS2As4KwK2j69KR5pYasgWf9CK3oi6bqNmmBiL65ZaaWX0dNDyHJ6011KlAGnh0TQcaDew+GwMsQcYcbNZrpKI2CbOM/bDXIM+2UOEhhroD0JpdLYgNux/vHfg6m26F6HkuV/261VUOJ1VMpJLYAWVvp1/2fhZrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815286; c=relaxed/simple;
	bh=ghEZQOv8zy0HoC2fCCYOiPaB5g3DcIonwickNLJfxj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJFMQ+YNG3waawM+XsT9UFlDXbQSdw8IYIdTWN7dl1TbuN2qrjhVIZ0RdCfvYWf3CuwSXMokCt1kUHtzqpwLCjW4vbSmK27YaT4rf7CbpwkSJW6DBAosE+cc4FDGlHrcFAyp5DjMUCnsu9ZKttMH5V6NQrG/qOfQ33I99P0WNB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oMf6Ze/1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oMf6Ze/1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B361F0089B;
	Mon, 12 Oct 2026 14:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791815284;
	bh=jJkYG1PF/wRZtcnLQD4tSTi4HXCWksgCTc7BhPtqd9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oMf6Ze/1bhc0nbfftS6JAU2tp3+zT5Dv1XEt5AjMVEHsWQIwOtG1GqJY0XccSF5lL
	 929hXp/lLWitwAKomo8ZfuiSnqY0AjpWZDVHH7dSr/EzDQJbSkkt2iQEc1I7La4AxD
	 YdarSXunGk5KxIGvtMjHVAJH2j3LirSM8dTXt6GQDzzXXs6zr61Gal6cC8D9G1uK0Q
	 c0kMbrOmGZmpgMy6QX8DLE//WxUptTAgt5yIzwP5hi2dUiKM5t0/iBptjp/jYLlIex
	 j5UHdSznIqRwkBrgSun+AIlSj+uTABJEOHA7cXn/IERzrgQ84ySL7rTglMCsI4/rEm
	 /0ti4WotsrNwA==
Date: Mon, 12 Oct 2026 08:28:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is
 needed
Message-ID: <aszuckZVkc2-kXM3@kbusch-mbp>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <20261009050556.2817978-4-namjain@linux.microsoft.com>
 <askIoNon8UVyNJiJ@kbusch-mbp>
 <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>

On Mon, Oct 12, 2026 at 12:17:38PM +0530, Naman Jain wrote:
> > The disable_irq_nosync still does non-posted transactions for msi and
> > msi-x. NVMe has a shortcut for msi, but there's currently nothing for
> > msi-x. For that case, I have a prep patch I consulted with Thomas, and
> > the result is below. I'm delayed sending it out while catching up from
> > travel, but I think this will be even more efficient.
> > 
> 
> Thanks for sharing. I'll give it a try. IIUC, after your patch goes in, I
> should be using disable_irq_nowait() in above and see better performance.

Yes, exactly. It should save hundreds of CPU cycles on every switch from
irq to polling.

> Please correct me if I am wrong. I'll monitor your patch in LKML for future
> versions.

I need a user for the new API. NVMe is the only one I have in mind
right now, so this new irq disable would have to be tied to the series
that does the adaptive polling.
