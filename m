Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2877B1E32A2;
	Mon, 11 May 2026 03:35:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778470555; cv=pass; b=asW7Eckx0naINXz1RkRybO+fViTr7HsP8maUcLlLg7fzwWSal/nKJ8mdsZqDUNlahQLdXL9A678/CNT8j0T5XStnV0xB+Aagw8CA2sL80r3L4T873TbTi5aa8/qwmRYkeY6tm7ZWpBxbZZEf2KSCFAciXAM9tqc6PgNXlq5N408=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778470555; c=relaxed/simple;
	bh=6Yu+kRTRuowIrgkM3pdYK1kLMadad5neKwnNzxioeGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cu/bKE17N6LOpLMMTfR6Al4RRbVbUGIeTs8L4Ul61zxAtLZ4/bISC0evYsIcrbv6QZtrB2sSXRaA6P1EQfzhmrYg16KNJjCUT6Kns4AP2OK89mRdky2QqVLnMFrzSQsunC75uCRfjTbm+5O7YcaHvEywNqzNLx8y3EgL6PuUnXk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=Lztjtt6a; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="Lztjtt6a"
ARC-Seal: i=1; a=rsa-sha256; t=1778470545; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=PNxq+onPCmAq6vsIWTLZ5i6l7VpxpUr7YKrk3yDMViEefZupzUxWKFW2V75i+LEZZQe1ugr5Bji8mymlt9rgQPhwB1yPzAynnq4piKNsiyHNWZbCxXAPy62yrcfYEaLOzfEx08eZSnSeXlgOsQL3cb41NsGivKBm1usGWuwo5pc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1778470545; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=JHE6UshxxnD10Q0tS0hnJRssBT9sSeCXb3Z5/EIwhjs=; 
	b=IOBOQAF/t1qeQQr9fCQYcjwZzZ+ie1E0H+rKJTQTKBeP1RuxaOEN6IiZbap11+BZTx15ApgVsAi49kDNr0LoTkDGwK1xgXDS8hkti46KfPqy3ugIMhQeMc2ZENBbvlRqqDbhwfX8vqxrNsJOl1J3KDkxliFxJyD0O54s0Qg0ar8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1778470545;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Subject:Subject:Message-ID:References:MIME-Version:Content-Type:In-Reply-To:Message-Id:Reply-To;
	bh=JHE6UshxxnD10Q0tS0hnJRssBT9sSeCXb3Z5/EIwhjs=;
	b=Lztjtt6afotQ7FgM9Ag0w/scQxpG36KmFJ9Ay1jKzhYbeN8/I4m3H+uLT4JnORu1
	sgo5ACe88Cr1CdGAt7qzfQROzopbLOepJiLhRdiaiKINTkLsCP8XgWeZy3ATI3rkluD
	xKMGzfm+PuMC5CtW3Y5gnwrM80fLbLsov3Tg/jBY=
Received: by mx.zohomail.com with SMTPS id 1778470543505756.2551519676897;
	Sun, 10 May 2026 20:35:43 -0700 (PDT)
Date: Mon, 11 May 2026 03:35:37 +0000
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 18/18] mshv: Fix missing error code on VP allocation
 failure
Message-ID: <20260511-spiritual-wombat-of-expression-04dc66@anirudhrb>
References: <177816592843.21765.4364464279247150355.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177816867776.21765.517737797103386752.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177816867776.21765.517737797103386752.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
X-ZohoMailClient: External

On Thu, May 07, 2026 at 03:44:37PM +0000, Stanislav Kinsburskii wrote:
> In mshv_partition_ioctl_create_vp(), when kzalloc for the VP struct
> fails, the code jumps to the cleanup path without setting ret. At that
> point ret is 0 from the preceding successful mshv_vp_stats_map() call,
> so the function returns success to userspace despite having failed to
> create the VP. No fd is installed and no VP is registered in pt_vp_array,
> but userspace has no way to know the operation failed.
> 
> Set ret to -ENOMEM before jumping to the cleanup path.
> 
> Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_root_main.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 1c18d1c1f7947..03c65ff6a7397 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1189,8 +1189,10 @@ mshv_partition_ioctl_create_vp(struct mshv_partition *partition,
>  		goto unmap_ghcb_page;
>  
>  	vp = kzalloc_obj(*vp);
> -	if (!vp)
> +	if (!vp) {
> +		ret = -ENOMEM;
>  		goto unmap_stats_pages;
> +	}
>  
>  	vp->vp_partition = mshv_partition_get(partition);
>  	if (!vp->vp_partition) {
> 
> 

Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

