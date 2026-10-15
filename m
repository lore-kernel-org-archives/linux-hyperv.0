Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE3BB4CDA2B
	for <linux-hyperv@vger.kernel.org>; Thu, 15 Oct 2026 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792062898; cv=none; b=OIOfz0ZMfu31QwJ5ha0njzyodyNNhNtZZzIFVwzwI07lVAVz5In7b5dsu3O6SKoJ/5ph6bCWxxatRyHpJjfIxtO6LtIdqQ99OpLrTZOX6K1JKI7JmUkkYWf4YMsGKbH5vFupVnUI3u2p9+c76V+x16IraMtFpvOApmtoV1JCGkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792062898; c=relaxed/simple;
	bh=ERD7cVIhMTzswl7ciPS77PvinWtYw8YESsmFAYPw8J0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrNzsv6eZg/krPhEKv0O2XiTWh0bYIlJ2tpdS1zgkllQO/d4H8PtYqVd/Pk1buUsRoJSSIRGWr7iD4P/9vPGO6z9HD0e+ysmdZIf+pVGByY8JrXOfIQOLxvfGKUDADDpkVCrSrHbVOVRUjlpVNrSg5vi191LwxILcgUsy7ucCQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bIdLe+45; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bIdLe+45"
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2BCFD20B7167; Thu, 15 Oct 2026 04:14:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2BCFD20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792062892;
	bh=ZL8nnzLUNTL3zUNbmnNPodXug8ZfJ0H1444W1zzr2cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bIdLe+45NxF3LMB7moWQ16meOloiGVDORQo+RUgsoDWgoK5MfoJM/jdFSuCSkDsm3
	 nDzCu+FhmdMykPlYAdvtbzpdw58zgwBVG+EL15bYygPl4ppKbcEHM0WED2+R8hEz6Q
	 q4s3H7yABfDW6o5ovTw6ztIPpNbjJjlDd1EAtYyk=
Date: Thu, 15 Oct 2026 04:14:52 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Maxime Ripard <mripard@kernel.org>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 24/75] drm/hyperv: Switch to
 drm_atomic_helper_connector_create_state
Message-ID: <atC1rBMREaDZN79W@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20261014-drm-no-more-connector-reset-v1-0-586c9c026823@kernel.org>
 <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261014-drm-no-more-connector-reset-v1-24-586c9c026823@kernel.org>

On Wed, Oct 14, 2026 at 07:26:47PM +0200, Maxime Ripard wrote:
> The hyperv connector implementation uses the deprecated
> drm_atomic_helper_connector_reset() as its reset hook.
> 
> Switch to drm_atomic_helper_connector_create_state() instead.
> 
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Dexuan Cui <decui@microsoft.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Cc: linux-hyperv@vger.kernel.org
> ---
>  drivers/gpu/drm/hyperv/hyperv_drm_modeset.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> index 523d1c7ea072..da399cb951a5 100644
> --- a/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> +++ b/drivers/gpu/drm/hyperv/hyperv_drm_modeset.c
> @@ -64,11 +64,11 @@ static const struct drm_connector_helper_funcs hv_drm_connector_helper_funcs = {
>  };
>  
>  static const struct drm_connector_funcs hv_drm_connector_funcs = {
>  	.fill_modes = drm_helper_probe_single_connector_modes,
>  	.destroy = drm_connector_cleanup,
> -	.reset = drm_atomic_helper_connector_reset,
> +	.atomic_create_state = drm_atomic_helper_connector_create_state,
>  	.atomic_duplicate_state = drm_atomic_helper_connector_duplicate_state,
>  	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>  };
>  
>  static inline int hv_drm_conn_init(struct hv_drm_device *hv)
> 
> -- 
> 2.55.0

Reviewed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
