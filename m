Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA7EA47253F;
	Thu, 23 Jul 2026 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784822789; cv=none; b=NiX2PM1tweqBQRLmBzYOsVX6TnPfM1WSuZcAUVGpjyNPHrOskRhfhzmmBHYhAWjaYmYpHSxfJc578Q5aTfZeU8k3D904GWQGj5hhYVc5oYW5H5xqAoKxBFio39xgk7mbBqYAWFlPQk/ImqMN9DnSYKDm5kNgKlRUlr+HAjv03WY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784822789; c=relaxed/simple;
	bh=r3X+8xatwIPLwhGMC9H/BSJvP/KN2i+fE+9PuI4Gf/A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gAfE8wiM2v66f6tzfZXqSZLweR3wYKtGhQxnFyXirhHHXg4Xy12SzQYsoSnmr+R4hqaB8g1BhdIkPpk7KLFBW7a9jO+E5x5VHIKogC6gs3nWY9x0rtHYeYmVRs86wmk/TrI9VJfKjAajOWuXwiizJFPVnNuu/MYdABupyjFy3Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5PrGocu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5PrGocu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 629491F000E9;
	Thu, 23 Jul 2026 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784822783;
	bh=6iwj5gZoEV4DjWps0bO4XDW7fPwA5oXYvrNKmjS2P6M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=S5PrGocuFjfbKBzvOVaYAiPEl1j+jadi1s7LlyQso7CVj/uHVr6tPXmSaxoGP3Nc9
	 YbemekQEDmeKSEkkIfFnsyI/CNL4wqbsKuWQJfqUgUC2togHkXs5C3n+P6+o35VLbP
	 oTSi+Zed3mB7HOQGqQ4kHXTmfnHGMgPEkhan45d3COCpQNjZDbBbIoEfvkKTpoy71H
	 kl6IpzqmSZn7LKW6A6wDcEP+ToBPpv9Jbykmqh1RKQ8a3ESwTkHNV3aBStZiAXSBak
	 a78zIFhR21w8u9k7HlCnyDd0U5CF+XBuV4lmuvEvuzwtaF/IXHh5oYrJ1N7YDAtKo9
	 mNu4jsDflZ/KQ==
Date: Thu, 23 Jul 2026 09:06:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Aditya Garg <gargaditya@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ernis@linux.microsoft.com, horms@kernel.org,
 dipayanroy@linux.microsoft.com, shacharr@microsoft.com,
 stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ssengar@linux.microsoft.com, gargaditya@microsoft.com
Subject: Re: [PATCH net] net: mana: Return error code from mana_create_rxq()
Message-ID: <20260723090621.6261a3e8@kernel.org>
In-Reply-To: <20260718024818.560552-1-gargaditya@linux.microsoft.com>
References: <20260718024818.560552-1-gargaditya@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 19:48:18 -0700 Aditya Garg wrote:
> Change mana_create_rxq() to return an int and pass the created rxq back
> to the caller through an output parameter. The caller now propagates the
> returned error code directly instead of substituting -ENOMEM.

We generally prefer the use of ERR_PTR to output arguments in 
the kernel. Looks like it'd work here nicely.
-- 
pw-bot: cr
