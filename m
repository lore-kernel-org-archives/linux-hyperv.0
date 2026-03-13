Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4506733689D;
	Fri, 13 Mar 2026 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773439563; cv=none; b=Pw7MoHXvNICTaEHvogo8bDl1p/KizYAnoqhHjHvVs701wekEtO4LmkKSfY8U/Fxs11LCpxRoIhtdBO4hmlflOJcVrxxgXekAEXGTNtX7VuOLt3kEYmbhCwZoZiyBqfmXtEssPxqsah3NSzGj3HG1iromZ8tydycmZeIjIc6W2f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773439563; c=relaxed/simple;
	bh=slfYVYxubpJAno3aWqQfDeRnprvBCtRast5S6OisBAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rz63VcxcU0HSyLWqEKZ58f8+S7NEEHvLxqHzDnnC5qg+X+Q4PfXK6RcbnKbdySoPDGeVDpNBi/Em0rsyzZw+HwVk5mVTA5VVdOMUfTwDiEgnGsE8sSrM56aCwaBsuI1slqxeU+2N2sZwjw2fNi8alAHMAYtJSl1elZKl0qGwLsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J2w84rxA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J2w84rxA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C701EC19421;
	Fri, 13 Mar 2026 22:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773439562;
	bh=slfYVYxubpJAno3aWqQfDeRnprvBCtRast5S6OisBAs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=J2w84rxA7MkrqHHbFmVZkWmtih89eTOsVemDpTiV/idGKLc/w5zAx14SfKjhcfL+f
	 D7flvwCZMNdi6Wzoq9gztTPdwVaYceQ9iFvy94EEaF5TsxRcf4otP1X8+rLqGJMTeU
	 zHnT2lNtEJWGdDVDijiVJXbk07TTL3BsBhPS41e5Ap1ex3WCmlqjuAt0reXNKNSIH0
	 IzF799bddD19yhTJGEvHAwaFM1qHH/TvEasgxJRYUX44spEbNGdXs5fov3/20g5eUg
	 M84mG5EMQuz1dEGxt86KMp/9d358GoEoapo5lQ/u9/Yqmle0bTyentUGkX+8O5Xxov
	 B6oh/jYQ7DxWg==
Date: Fri, 13 Mar 2026 22:06:01 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Saurabh Sengar <ssengar@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	drawat.floss@gmail.com, ssengar@microsoft.com
Subject: Re: [PATCH] MAINTAINERS: Update maintainers for Hyper-V DRM driver
Message-ID: <20260313220601.GB412650@liuwe-devbox-debian-v2.local>
References: <20260313042148.1021099-1-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313042148.1021099-1-ssengar@linux.microsoft.com>

On Thu, Mar 12, 2026 at 09:21:48PM -0700, Saurabh Sengar wrote:
> Add myself, Dexuana, and Long as maintainers. Deepak is stepping down
> from these responsibilities.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>

Thank you for stepping up. And thank you Deepak for your contributions
to this driver.

I fixed the typo in the commit message and applied. Thanks.

> ---
>  MAINTAINERS | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 6358dd7f1632..d67afcb0acc3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8028,7 +8028,9 @@ F:	Documentation/devicetree/bindings/display/himax,hx8357.yaml
>  F:	drivers/gpu/drm/tiny/hx8357d.c
>  
>  DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
> -M:	Deepak Rawat <drawat.floss@gmail.com>
> +M:	Dexuan Cui <decui@microsoft.com>
> +M:	Long Li <longli@microsoft.com>
> +M:	Saurabh Sengar <ssengar@linux.microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
>  S:	Maintained
> -- 
> 2.43.0
> 
