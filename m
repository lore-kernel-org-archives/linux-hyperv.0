Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 540EF30BB8A
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458957; cv=none; b=nyPfwDv8dTpNHAEqayYXH+eTbLD1QPDwSFBkhZViDcXGG/Q1LoVnr6kh7Y4Xu3nG0opfNJCcpJcj7DQOR7Plk/UMdnkS6jwExemOQH4xRURBcmhomLeovzgilU5CKdAKiLW1hjnaw6w8pU7Cfz4xn/jCe9l2qrHf5pgI5K3e2EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458957; c=relaxed/simple;
	bh=Yx3BUer0lbfOU7Y5P086295+ctu6ZjK7E7A3FDLhbF4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F3IwD1K2VxAlu/IjraAM/Bz/5Hqj8mtXa94KxqqFch6+nOuNNgh/FNBQnuP3ZH8q5umJRpRGVyf+zm6PVto2nnh0s518fSCrixZKHMOnSyZp/EyybuJZIIxGRHJd/6/19LiUQi7DEuLJ6v5oRKlPeId+cl9DVyGOAvxo7B+U0v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qTarO9F5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qTarO9F5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 226BEC116D0;
	Wed, 18 Feb 2026 23:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771458957;
	bh=Yx3BUer0lbfOU7Y5P086295+ctu6ZjK7E7A3FDLhbF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qTarO9F5GJvvI4qMb+oONQkfmwIQ6uGfSgQcVuFRlvpqIfrSipmMNxGG/J4GaCXZ3
	 jPRDe3537mawFZoqLRbBVPxpyyGNELN4+KBqF+lFED9J+p3sG3I7fFgTiPzFFidsrS
	 zL4dpR/iNojf2F7IwZPzGb+93H67hD48oC46yDgTho2cas46S16Ly36aYk9ydJJKfC
	 MfGsTzK2L5rC2G6qHoqOZme33v23Krr3qlbp7bNpvyZOtnfZ5PA4Rq28Ar0LwgkOa0
	 nLlxI4G1QqBZ1kPhWQcSkpPzDtY5bH9/QVTOpnpbI8+TFp5jH5xeNLDVuJbYl8pz14
	 pYh7QwHONKqiw==
Date: Wed, 18 Feb 2026 23:55:55 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anatol Belski <anbelski@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, wei.liu@kernel.org, muislam@microsoft.com
Subject: Re: [PATCH 1/4] mshv: Add nested virtualization creation flag
Message-ID: <20260218235555.GO2236050@liuwe-devbox-debian-v2.local>
References: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218144802.1962513-1-anbelski@linux.microsoft.com>

On Wed, Feb 18, 2026 at 02:47:59PM +0000, Anatol Belski wrote:
> From: Muminul Islam <muislam@microsoft.com>
> 
> Introduce HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE to
> indicate support for nested virtualization during partition creation.
> 
> This enables clearer configuration and capability checks for nested
> virtualization scenarios.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> Signed-off-by: Muminul Islam <muislam@microsoft.com>

Series applied. I squashed the first three patches into one.

Wei
