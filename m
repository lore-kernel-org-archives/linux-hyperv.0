Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A73CF1FD;
	Tue, 18 Aug 2026 15:55:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787068524; cv=none; b=c9Rtw9W2l4ZJg7ivSNKHw9+0wZNRN4lW5zYEVfb/kJc3TZHL4u8FTIP3rN7ePSJ4aeQ8VCPAf3uxEWHAgYWJ51WMCPouS1Fq0WwALmCq8c/F0LQpl1KdBXuWFk6DAb55mpJRpwgDtRUj4AoLewEDbt/sa++2fcsnew02u++zvPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787068524; c=relaxed/simple;
	bh=yBB5Ah18TwalqEmv2x0ZGwuCUI1Tc8gkXWpKPtytP4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I3zsbNc6w0XOKnbiU3FRMIIJOAvezv5UyihMi+pscw2M4s7gFC2ytWnRKPN99HM/xNhNeqAq/MCGpQpfuOTjOiMCB/rVbvfTAYzpPM3KKykAy1+ZyePXSxb98PTZAsZmB9DXmi1+AP4LBLukXvbo2QGA07kegHcuz85inFpybOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=pass smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ui5KdUDl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ui5KdUDl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=Oib1sAGemzHmu6ROtRkEHyhCtwDTicVNKskycatCaao=; b=Ui5KdUDlipNO9Vm4nINkg/+v4R
	bOUqu7BxrFpPjJPyyxL5/SQNc4/JySqtBdMrb5CyEz/IRILpW8+YnFuGzsaYbvWJv+9e0YtT8uwx/
	eE0eXe6fRPjm1sfCVSmOReeGwtH7/zEHlNxdnu5tpHNRyMiy4cejksDu81kvbeMEFRTaItbMt/IGi
	Q61CWpoF2IThZoi159FSHVf/TCVp1AzMzc9ZSRaQVSMkGFqvkSEm1dUtgG8Qvp88FNz5jkcBhNEOs
	ACjeQ2XWgqHevHSOffjhKrvnRBjt4Y+4cNGXzMxdf7NzZpsvk2bac1B5a/UMTuKt7keKswSiklY2c
	JG0mN6zA==;
Received: from [50.53.43.113] (helo=[192.168.254.34])
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwM9g-00000008JC7-1PPo;
	Tue, 18 Aug 2026 15:55:12 +0000
Message-ID: <916c4bd5-c73f-466e-8e9b-aee9d4d7d742@infradead.org>
Date: Tue, 18 Aug 2026 08:55:11 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/12] drm/panic: Move panic display code into helper
 library
To: Thomas Zimmermann <tzimmermann@suse.de>, jfalempe@redhat.com,
 javierm@redhat.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 linux-hyperv@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, nouveau@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org, virtualization@lists.linux.dev,
 sashiko-reviews@lists.linux.dev
References: <20260818125012.468092-1-tzimmermann@suse.de>
 <20260818125012.468092-12-tzimmermann@suse.de>
Content-Language: en-US
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20260818125012.468092-12-tzimmermann@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 8/18/26 5:28 AM, Thomas Zimmermann wrote:
>  M:	Hans de Goede <hansg@kernel.org>
> diff --git a/drivers/gpu/drm/Kconfig b/drivers/gpu/drm/Kconfig
> index 323422861e8f..cdfd72d9a9c5 100644
> --- a/drivers/gpu/drm/Kconfig
> +++ b/drivers/gpu/drm/Kconfig
> @@ -45,6 +45,7 @@ config DRM_MIPI_DSI
>  config DRM_KMS_HELPER
>  	tristate
>  	depends on DRM
> +	select DRM_PANIC_HELPER if DRM_PANIC

but DRM_PANIC_HELPER depends on DRM_TTM so
DRM_KMS_HELPER should also depend on DRM_TTM. Otherwise:

WARNING: unmet direct dependencies detected for DRM_PANIC_HELPER
  Depends on [n]: HAS_IOMEM [=y] && DRM [=y] && DRM_TTM [=n]
  Selected by [y]:
  - DRM_KMS_HELPER [=y] && HAS_IOMEM [=y] && DRM [=y] && DRM_PANIC [=y]


>  	select FB_CORE if DRM_FBDEV_EMULATION
>  	help
>  	  CRTC helpers for KMS drivers.
> @@ -130,6 +131,10 @@ config DRM_PANIC_SCREEN_QR_VERSION
>  	  Smaller QR code are easier to read, but will contain less debugging
>  	  data. Default is 40.
>  
> +config DRM_PANIC_HELPER
> +	bool
> +	depends on DRM_TTM
> +
>  config DRM_RAS
>  	bool "DRM RAS support"
>  	depends on DRM

-- 
~Randy

