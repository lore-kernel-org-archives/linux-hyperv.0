Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794256299;
	b=ER0Gf+5vTZej0A0aFYkDvdl5YRg4UZfZzDpjbGz4A7cjkUi6gYnRCzPCz0er4dTUkijr
	 eshOPGG/8lw0vEIiRG5XDE93R5CE+F81dD89Whbw6C/DJ1/m0DP5+Hw+7wP75uBiK5g2d
	 iTrli9L3/nLE1C8mQmTWcBclaZjKfgLkHRczuTlhVTyAMhLg4lcpavb0iV6IFhPC4Pup5
	 JO/i6MNinKHTj/lrL6mTYdqFmcJcn0RaieqDZ9QR+rTxXxkAaA+jPkUCZY6+/z0ANgOAb
	 pTJcY9dwM2VHueIQLpnVCJgV9GBltJ8nXenw2vU0HcYKU9xXZCqhqKrMpgmKFmeqveg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794256299;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=FJoDa9wz9XzvY9w6y77OOd0io38jmhgmSiRUcMxPUUo=;
	b=SC0Mq9If8BS2lmeE9P2nfTikANjTpfR8yAxgw1U4lF194r6+uGOLxXIbzmBDcuA2xZ2e
	 k1/JcqhUhm9pqs4uwYdxPxH8cf4XokfPTpQAhOwjRWru2MilK3A0oefVx4q/W4Ny/Yryv
	 6ahz4cDbxsq7ClIfkySmBn8h2TV5fWEkd8lQ0ynZOIQ5ZfheaLt2QIi3MN+RVkxduJjPe
	 stboEblfy4Od+o3YCxv5WOTqVSee463OP5gol1pOGDlypE+0esU6dKLROokYYMz1tAZGd
	 +O60wNw9dBGDwfdU28qa6c+pTqF3SWzNbNbh3yvQ0JPx992qpJncINe23P55+OlRT5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr5XONFw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4464E606A31C
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Nov 2026 20:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jr5XONFw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCF6B1F0089F;
	Mon,  9 Nov 2026 20:31:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794256298;
	bh=FJoDa9wz9XzvY9w6y77OOd0io38jmhgmSiRUcMxPUUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jr5XONFwCUzkmlIfk1tGPq41PP5kMdJKEcsd73aBOIH7sEOTaXUOFw3iWWxg7Rn32
	 kL45OcMazcOP6EMUv903X+5K5X4Fxk40lPUitQabxyCB6JpwZSDPiQljDDpM9pidFO
	 t0sr+CwajdaBkm+ys927mntXTnchvjPXqUZUlaD+O33nK+UlCpoisHCNmbujvsZoAh
	 P9LHWRT1UC4d0//bDhAhYXlXmC0IFoPoO8fw37Z3YacE8olu6ZfMt/KUZp6m0+D3tt
	 gxN9/3QZl/2Ky399S+l0azfToosGZuSd39oMCHBEk1EJ6EzLep5impwlPwwmuMmcc3
	 tvtscAX4O7L4g==
Date: Mon, 9 Nov 2026 12:31:37 -0800
From: Wei Liu <wei.liu@kernel.org>
To: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the Hyper-V
 DRM driver
Message-ID: <20261109203137.GA3536171@liuwe-devbox-debian-v2.local>
References: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261109160004.796790-1-hamzamahfooz@linux.microsoft.com>

On Mon, Nov 09, 2026 at 11:00:04AM -0500, Hamza Mahfooz wrote:
> I have been informally co-maintaining the driver for some time now,
> so make it official.
> 
> Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

Please take it via your tree.

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c10342aa32f3..63b70f3da896 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8359,6 +8359,7 @@ F:	drivers/gpu/drm/tiny/hx8357d.c
>  
>  DRM DRIVER FOR HYPERV SYNTHETIC VIDEO DEVICE
>  M:	Dexuan Cui <decui@microsoft.com>
> +M:	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>  M:	Saurabh Sengar <ssengar@linux.microsoft.com>
>  L:	linux-hyperv@vger.kernel.org
>  L:	dri-devel@lists.freedesktop.org
> -- 
> 2.56.0
> 
> 
