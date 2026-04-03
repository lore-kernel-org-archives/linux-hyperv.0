Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A193CC9EA;
	Fri,  3 Apr 2026 16:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.69.126.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775232945; cv=none; b=UxUdZ1lWxFT8cDFyLxgzQW0rd32QT7hOxYpaBa1zXsgqpPCdjVJ7WqrcXSgV+N1RvuVl+P8x2LELS05o77LO9jOD3sXVmQUv9O9bE1wdfwhjrhjmf8BboTklKnVzLhjMR2C4fedgRK933NPq7ZUb6AQW+PATWKEEcNd3Ald1QWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775232945; c=relaxed/simple;
	bh=j9p4nn3sUrBeAOZ2qtLv/38plEowvM4AfGlGd0sDgz8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMZ/frSCjERyo14dENGM7EKgHyZGItFjadoRLTAVcFiwsoNjzPyYGYGuoNcQkkEIIqQcCFJDaLNO7U6loddwJNheRTdrjIH/+z6YHxs2+eVsfoWrhNbhw9dBfZeywestaFsZO6xT+0Z37he+Akz8p+YwJ9iBZv4l3HxHnQwdnAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net; spf=pass smtp.mailfrom=weissschuh.net; dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b=iBdy/s0i; arc=none smtp.client-ip=159.69.126.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=weissschuh.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=weissschuh.net header.i=@weissschuh.net header.b="iBdy/s0i"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
	s=mail; t=1775232935;
	bh=j9p4nn3sUrBeAOZ2qtLv/38plEowvM4AfGlGd0sDgz8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iBdy/s0id8EwmLJVXzkVnXmA1TLK6Ol/Kuo7vRGAx8+0qnfku53ihahHi0E5tsN/C
	 qRC4GpdT+h/1NhTt2R2MV8xzG2aOxrRHkMB71TPDglxFWl56bTtDMOme16g9hEhKRc
	 5ISstTkVQiu5xmao40AoUlLjdAxYl5A+3avUi3X4=
Date: Fri, 3 Apr 2026 18:15:35 +0200
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Long Li <longli@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drivers: hv: mark channel attributes as const
Message-ID: <8d8fdf46-5374-4e23-9c79-140117724441@t-8ch.de>
References: <20260403-sysfs-const-hv-v2-0-8932ab8d41db@weissschuh.net>
 <20260403-sysfs-const-hv-v2-4-8932ab8d41db@weissschuh.net>
 <SN6PR02MB4157D5F04608E4E3C21AB56ED45EA@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157D5F04608E4E3C21AB56ED45EA@SN6PR02MB4157.namprd02.prod.outlook.com>

On 2026-04-03 15:56:54+0000, Michael Kelley wrote:
> From: Thomas Weißschuh <linux@weissschuh.net> Sent: Friday, April 3, 2026 1:29 AM
> > 
> > These attributes are never modified, mark them as const.
> > 
> > Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> > Tested-by: Michael Kelley <mhklinux@outlook.com>
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thanks.

> But take a look at this analysis from Sashiko AI:
> https://sashiko.dev/#/patchset/20260403-sysfs-const-hv-v2-0-8932ab8d41db%40weissschuh.net
> 
> This seems to be a valid concern with your earlier commit 7dd9fdb4939b9
> "sysfs: attribute_group: enable const variants of is_visible()".

Indeed, I missed this user of ->is_visible.
I'll send a fix for that, but it shouldn't affect this series.


Thomas
