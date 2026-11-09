Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794262025;
	b=fu5KpeXPgIXfebTgklwuKhsk1WQib0M68F1Dn4eag5gbacCrOMWzbqwUzvZuTxGrRK45
	 oT3X4K17qwlyND+35jcfKEBewiEYgXEdg0OYl/0vpk25v9Ttm5lfHthfOftK8GovnEHaC
	 ql3wClyV9sJv2VrFQkbaLbzdW/0zF9BBmE4sSKTYgb6O3I2+bca+y5Dogrj6R0hFCHVDT
	 n641ELsCBd0v/1c354it7SgFia3YaDOHJucywRtmhj6crSQD+oJSN0e0yzQy04PEkFOe+
	 iQRLTMQoFoTc7ulRaR2mxoB1Yl3mptQzVeaO5H4Ma9TisFhlFZhZvFxpTbfCaV1wUXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794262025;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=FojzXsTv6Y+YEm4k8gUu4cy3Bf4RRdBAAG4ubxfrbl0=;
	b=gAfAzFGyY6q7slB902AeXfOxwVnxy2S87L6DwgcZ/QvbBhBSk9kWaJDOT8eQeTissukj
	 Lt94XlaO1LSrILNS+NWvxA341cbSlGokSTCnmkxjNTaakdFM4bbV8wiQ7v6/2tZGOCFIj
	 92QfZmHZZ27IsZHB7+2ADLksJeOEobfiNimUtXJekRXakvYm+BmlDCKz5QFyfykwgwp9b
	 aW3D507d3/iAMujKYS/wp3SVcOTFFnLRd4ns5qbm4U+ZZAAB97c/SHEFADYSYDt3qtL6L
	 2aJtQI8Q7Y4Rbmi3f95DHWgTFAPFFD18oGEZWgDRAMrwE3WEWew1evSNly07yIQ8dwQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=doiwQeqe;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AB3606A330
	for <linux-hyperv@vger.kernel.org>; Mon,  9 Nov 2026 22:07:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 43AB3606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=doiwQeqe
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B9B2320B7168; Mon,  9 Nov 2026 14:07:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9B2320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794262022;
	bh=FojzXsTv6Y+YEm4k8gUu4cy3Bf4RRdBAAG4ubxfrbl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=doiwQeqeLPJqIJkCZ2pVLmC0DW83f7uvmFT+mjYcgt3T48qzdze2TzuzAg0SnbFwI
	 0bIdQ681waPkCSynG7aF80Vp3SJ3CgMaTJkBPQQRlrvAFDlF4hnfVBEOQQPF11E1+4
	 5iN//JTDKNSCe7m0H7OAhvXPFntms35Xawuh510I=
Date: Mon, 9 Nov 2026 17:07:02 -0500
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Dexuan Cui <decui@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: add myself as a maintainer for the Hyper-V
 DRM driver
Message-ID: <avJEBr2OsZLpsB1s@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
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

Applied.

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
