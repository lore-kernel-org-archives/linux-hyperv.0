Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794920856;
	b=z62CRQ4znUGezCtRTURPpEXm7hU8mcT1PYw7m+DqAy9yH4U+LqqbTXl07XxibVto1710
	 f8On0EC8/8JwU3TnUMhNJFzrbW/x11cCWUvK2kax+hssTwJc207aEfmtGSUwvEIehxd31
	 Kka0ZZs5aUxPGYiuLy2PPHPExuEdiaG16Z5ZQI51tSznOinX8Y9M0Pgc7TpKidDr6muX/
	 w1R2oYR5TVXj6VGAp1gxhBHPwKeEq4G/eUfDGJr9ZNEHnQQqaoeoCuRsALwjt+POrnG3r
	 tFD/TxAvps3Xt5/xLDzns77k19qHnR7T3EZnV7Ijc0yzAVd3c1lK55wgWKd7q3AzJkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794920856;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=UmMOuYk7GOgGO2Uj4xQY5WbziGT48+mQLZEv3mhfCMM=;
	b=tTHhQPrXCn9dAxFXlJF04wAnZ0kpNriw0SeyFRoOh7cMxuqK3O78JmvlK4BcBVN/NKFs
	 qKbiPoM1EnjVHg49Vx2wlasSzwGYvzl1vMuAcBc2ETygfKMepMAzlviIR36/lxEC+A/ej
	 fh7jBh8g+p+pqoOyMRnTqoquU4VWIZ9t16XMihF1GDI0ACvkvnNQgrQ/aOvQAahATNHfw
	 Cy7eADvBQSfjJrVzSAF2X1qzKQtfNcA1ISY16E6StJjH0xHaI1nUq4r3v/Q2Y76PmfUgl
	 aXwHpMA/l0obtPhOBhV9tJjJ53gvor5/LvbXQzsfQJvIRV3ZTw4a+Ee0TpxvX6akYVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="czmzT0/D";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A6260A6F77
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Nov 2026 13:07:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A3A6260A6F77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=czmzT0/D
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 05C9120B716A; Tue, 17 Nov 2026 05:07:35 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 05C9120B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794920855;
	bh=UmMOuYk7GOgGO2Uj4xQY5WbziGT48+mQLZEv3mhfCMM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czmzT0/DkQB0vju00M9RFTeQzxKqWXCbMxz2JaSeZaZ6I7fcF++uRG8Q9AoX4sGBT
	 8XaBtqnVqxZKbejYXdtwoYbZqGvuFSYK1HU5mrObVumJMU65drppsawQo3e7njGxd9
	 XfCRVBG1frThCDr7H23ZoPOw7MjwCt2t8bUQee1g=
Date: Tue, 17 Nov 2026 08:07:34 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH v2 11/64] drm/hyperv: Switch to
 drm_mode_config_create_initial_state
Message-ID: <avxRlhKfNlW3nVWB@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-11-0bb471f4d1e0@kernel.org>
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
In-Reply-To: <20261116-drm-no-more-config-reset-v2-11-0bb471f4d1e0@kernel.org>

On Mon, Nov 16, 2026 at 11:30:27AM +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
> 
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
> 
> Switch to drm_mode_config_create_initial_state().
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>

Acked-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 759952f4ff19..73938303e663 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -500,9 +500,7 @@ int hv_drm_mode_config_init(struct hv_drm_device *hv)
>  
>  	ret = drm_vblank_init(dev, 1);
>  	if (ret)
>  		return ret;
>  
> -	drm_mode_config_reset(dev);
> -
> -	return 0;
> +	return drm_mode_config_create_initial_state(dev);
>  }
> 
> -- 
> 2.56.1
> 
