Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2C3426EC1;
	Mon, 20 Jul 2026 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784558397; cv=none; b=jvveY3v/c+37L/QfJJ9TFmxxNnqOAu8yIGiK2U1wnk+JhNdSWd2Fa9UWl5IepPScq/HoPwEm0QStAw6AIE6ySsyQAW4bkQmOtllc5aX2oemrLinyUuFoQoIOgkGl3Zs5hD6gNtZSD9iDlGD0VmztHOY1wMp5vQuz846CD4UqkJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784558397; c=relaxed/simple;
	bh=d5jTWbb+Gz8tlLV3DIOCv5JqDqLbWlvxS2IUuM7ljDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R3zMhvIy+crwu9e6jpW09PZH9fLPG/C0Y1zYvJw0/6reONx11GhJ0x5QpWXJf7xlCMbiRaIW6yD9Dm9Y0aPBsfGv42LPKcr2X2Hp3/tcVNLeqdVLlW69F/xFuEWV6KAigCGsxNTGwxmXBEjQ1+3IPMAhltn0Q15I0eq9YJicvjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hSlUE3Az; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hSlUE3Az"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B854120B7169; Mon, 20 Jul 2026 07:39:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B854120B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784558381;
	bh=Yd929J3oLULnC2Sok0hZvBBnQSG7U/e/XUsxCPLGcUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSlUE3AzN2EUZz2YFHVo5D5SD0tr6qkYbMQaTSO79rDpo9+dqa5MuzhUjOSSZhlUe
	 whqoetTceWcsTYT1dLm6Aoj5TSOAFYnTPmmtKwzWK2vDwdJ81SGNLPFzkTCKenmi3v
	 d8aLjVYfewxaA+3oxtKQDN9rnQBJRtxI8XO4HnQc=
Date: Mon, 20 Jul 2026 10:39:41 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
Cc: Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Deepak Rawat <drawat.floss@gmail.com>, linux-hyperv@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/4] drm/hyperv: A fix and a few cleanups
Message-ID: <al4zLadVFWOaPXp8@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1782925276.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1782925276.git.u.kleine-koenig@baylibre.com>

On Wed, Jul 01, 2026 at 07:05:18PM +0200, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> while working on a tree-wide cleanup I found a few issues in the
> drm/hyperv driver that are addressed here.
> 
> While the first patch is a fix, the issue is so old (from 2021, included
> in v5.14-rc1) that applying the series during the next merge window is
> probably the right choice.
> 
> Best regards
> Uwe

Applied (sans patch #3), thanks!

> 
> Uwe Kleine-König (The Capable Hub) (4):
>   drm/hyperv: Unregister pci driver in error path before module unload
>   drm/hyperv: Explicitly set subvendor and subdevice for pci match array
>   drm/hyperv: Drop useless empty remove callback
>   drm/hyperv: Move MODULE_DEVICE_TABLE to the device_id arrays
> 
>  drivers/gpu/drm/hyperv/hyperv_drm_drv.c | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)
> 
> 
> base-commit: be5c93fa674f0fc3c8f359c2143abce6bbb422e6
> -- 
> 2.55.0.11.g153666a7d9bb
> 
