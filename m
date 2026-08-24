Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB072D8DBB;
	Mon, 24 Aug 2026 00:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787531886; cv=none; b=i+8PjSnDXoAwXQZTbXihrA6HgM3R9mafg8tuGjhoGKgYpcv7sKpumI/Arzv7V3ILSRsQN4IHXsSGTZZKQd7SaM6CAsuMZGs3F9XtKxehNiIVnw5JKOE80I2s7txWnBG3X+K/OzZE0vABQMyylNMADff1Hzq3pLcIsVd3J6/KxNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787531886; c=relaxed/simple;
	bh=VdlZR8Gtobu/XrmAn9l2j+YKk3cmGFUVOZvYRDH8MHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qnUA679THgGvmlJCOyNbCThCyI2XoUv1m0DKZROjhhNHXpU7S9TcZFCXJYefa0+e5di12nh3/508IFRG419zL2g7buxUVPEi3tExICX/wucJeByR6E0GY+LjJk1Kb2t8RKs9HiaouMmxo/eo1bVu+vmjTVUS93pO4XzYuL919DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN/T24d3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN/T24d3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 159651F00ACA;
	Mon, 24 Aug 2026 00:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787531885;
	bh=vFhomx4kPyG+9+xmyABHxCpLjFLIbt0D5vKljOyXnUE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CN/T24d369oYix0ltsq9IjJMm0H1G/lFGya+0b6pIelDx8DV029pGo5ipm7h/Yg0S
	 Vk1sneOk1v+LgYcz0kM/DB7JNgn0xDLDDrjYPvwyKrDd+1FCqbClaUPXkE7GBtCws0
	 4LZZmyCFohEcCLQDzryxJRdje6ybE6U6Cm4JMZCcF5A+eWuImJiiyGocxkt+IOmyCv
	 mzlaqhTKfwk6bT/v6LFJBsA0YKHNV1R2MVb6AD/U/3q4atQXin5sfUvKvt3LY8e+Z+
	 QrdTWN2b64LoTT3dqAy5qd2BtgQtj31MmrSIxOPR8HkLddATWlAWyEWv+wjaUzKjzK
	 BMlk/3UaZWKPQ==
Date: Sun, 23 Aug 2026 17:38:03 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Remove support for Windows Server 2012/2012R2 &
 Win8/Win8.1 versions of Hyper-V
Message-ID: <20260824003803.GI3566091@liuwe-devbox-debian-v2.local>
References: <20260805203751.2678-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805203751.2678-1-mhklinux@outlook.com>

On Wed, Aug 05, 2026 at 01:37:45PM -0700, Michael Kelley wrote:
> Michael Kelley (6):
>   Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of
>     Hyper-V
>   hv_sock: Remove check for old Hyper-V hosts
>   hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
>   drm_hyperv: Remove support for synth video protocol of old Hyper-V
>     hosts

This drm_hyperv doesn't apply cleanly. I have applied the rest.

Wei

>   scsi: storvsc: Remove support for storvsc protocol of old Hyper-V
>     hosts
>   clocksource: hyper-v: Remove support for stimer interrupts in message
>     mode
> 
>  arch/x86/hyperv/hv_init.c                 |  17 +--
>  arch/x86/kernel/cpu/mshyperv.c            |   4 +-
>  drivers/clocksource/hyperv_timer.c        | 150 +++-------------------
>  drivers/gpu/drm/hyperv/hyperv_drm.h       |   1 -
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c |  44 ++-----
>  drivers/hv/channel_mgmt.c                 |   8 +-
>  drivers/hv/connection.c                   |  11 +-
>  drivers/hv/hv.c                           |   4 -
>  drivers/hv/hv_balloon.c                   |  36 +++---
>  drivers/hv/hv_snapshot.c                  |   5 -
>  drivers/hv/vmbus_drv.c                    |  10 +-
>  drivers/net/hyperv/netvsc.c               |  20 +--
>  drivers/scsi/storvsc_drv.c                |  53 ++------
>  include/clocksource/hyperv_timer.h        |   6 -
>  include/linux/hyperv.h                    |   5 +-
>  net/vmw_vsock/hyperv_transport.c          |   3 -
>  16 files changed, 82 insertions(+), 295 deletions(-)
> 
> -- 
> 2.25.1
> 
