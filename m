Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A92264B0;
	Wed,  4 Feb 2026 06:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770186602; cv=none; b=oD1TFTAGEJFQgTHEIOenK4+9pdJW1Q5EzTax/z/ey+WsoKgMSldk3dn14VRLYNy1wRDBIxJWod4rdut5mJ81dmD121fyZHhx6TGi3xUre8KEvpPNSNFm1nV2oENsBS8zd1zWzS0+92sk8QzErkjdxnwA70+KjfFYBvI2bS8Ei8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770186602; c=relaxed/simple;
	bh=W6obNCQykAG10M15SMmvYCUFjcyCCfNa8V6CIY2hFuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gszRNfkMJBIAbZkrwSGMyDzArIzFzkEwxVzqrdUNV/bWMkiOqTDTxwUonKOX3e8MOe4JJfx8q18MHk9vpstSQypoLXSS7/NNQm7ELRWpo3UKTNSKZCE1AWALUIYuddkJA2Gu8hh1yxecDuaxmz97OlCxYmaDQmoevk2MWuYCYsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CXEuDQOJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CXEuDQOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CA8C4CEF7;
	Wed,  4 Feb 2026 06:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770186602;
	bh=W6obNCQykAG10M15SMmvYCUFjcyCCfNa8V6CIY2hFuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXEuDQOJgBjiRWjjNe8Hdgt14QSmjuLgVtCZxNsLfLLO9JMah8FbZf4jX5piIM8OI
	 35rQXNHgNtK7HiUmpuXumQJ7SJG1PUpJK+cyP/l5ez0K3VoRiIDZ5gbaGU7dMUO7wu
	 4Ol6vHJvMdqn7Bl0a1GxPrLgFyMJRjI7joD493pTUrnR/HfmjmPWYZ3KbihrIIF/aM
	 HegLWQZveFVP3fmLAGpx5Gs4LddUhZH3Ag6CYq/V8iqj0ALUVQYb1mCd5MCljpWs7a
	 YcONaJ0T+y7VcrftLyf/gwso1KbFyQfDZgrthmSZ3mP4SCeX7WVZjxw3dB58hAnnLE
	 dWEkXPlFncF6w==
Date: Wed, 4 Feb 2026 06:30:00 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Use memremap()/memunmap() instead of
 ioremap_cache()/iounmap()
Message-ID: <20260204063000.GJ79272@liuwe-devbox-debian-v2.local>
References: <20260119155937.46203-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119155937.46203-1-mhklinux@outlook.com>

On Mon, Jan 19, 2026 at 07:59:37AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> When running with a paravisor and SEV-SNP, the GHCB page is provided
> by the paravisor instead of being allocated by Linux. The provided page
> is normal memory, but is outside of the physical address space seen by
> Linux. As such it cannot be accessed via the kernel's direct map, and
> must be explicitly mapped to a kernel virtual address.
> 
> Current code uses ioremap_cache() and iounmap() to map and unmap the page.
> These functions are for use on I/O address space that may not behave as
> normal memory, so they generate or expect addresses with the __iomem
> attribute. For normal memory, the preferred functions are memremap() and
> memunmap(), which operate similarly but without __iomem.
> 
> At the time of the original work on CoCo VMs on Hyper-V, memremap() did not
> support creating a decrypted mapping, so ioremap_cache() was used instead,
> since I/O address space is always mapped decrypted. memremap() has since
> been enhanced to allow decrypted mappings, so replace ioremap_cache() with
> memremap() when mapping the GHCB page. Similarly, replace iounmap() with
> memunmap(). As a side benefit, the replacement cleans up 'sparse' warnings
> about __iomem mismatches.
> 
> The replacement is done to use the correct functions as long-term goodness
> and to clean up the sparse warnings. No runtime bugs are fixed.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311111925.iPGGJik4-lkp@intel.com/
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next. Thanks.
