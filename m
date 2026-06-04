Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFEAB22F388
	for <linux-hyperv@vger.kernel.org>; Thu,  4 Jun 2026 04:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780546128; cv=none; b=DA8I7Hxkyb/mJI6cT8dBGeDbu0P7LHIUNe1cA8GRMtjvhUNvQuNnMsZra4Xu/DxuJ14cUOYDm95DKXKcHa2MP3PQRJ5r2WG1ORmQ8NRxn4eq3359DB5yd5NrWcZXv42gCq7zeM2/SvDJKTeipCvs1Yx44hb+UNVcEtoSPQYj5BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780546128; c=relaxed/simple;
	bh=aayq66RQR6J4gmKuinU7AJoqHbGx1E31wEpWAz+hPHM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FUH7Ln2Jg+pZR7W73z45IHOsUwOGCmkgztvuyhF+6fLfIGYYSDLlwQq5diYz4nOCT56lgQfjYl/J+nM9Cyn2SU31YlkLgUmXFgovdNmzIf4Xz/3Lmg9BqIjb0RBkGXD0Wy50GT5taKlsQcceXhziun9eh6l7Bs0hiaatT3mFNro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c7WTGYxD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c7WTGYxD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529DD1F00893;
	Thu,  4 Jun 2026 04:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780546127;
	bh=VYjuVaIujWcRzgPdRuD0FUdPFJmHvdgYcYHlyxQbCp8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c7WTGYxDqyufY30CW/yozm5JXiXYgK9AxEGOby3O6tu6e+HRKQpPOh1+f9/oPO8JN
	 rDRHi9yQeKOz3xec1jKBALngvyHdyklBAJ7NrcPQvZgmg3c6kIOcQM+32KRpJwtXjJ
	 08vL31vAMzLjV4fNLrzkbC/ehbKbx0NPEl07pNE3NtEuV7R73IYAN3NXfDbZ/NsOfp
	 2RohBKWdz+3HlH0Bhq3FDp8qBW5+sK3YA59l53WB6GonQEWMYBrtiX/KDDjYLmc9P4
	 4a+5QD2Atj9nO8j+s3ZPVkialFY9AUQzjH1R8ZsehPjlVEFmZwPSd7CG1ZS/+LQNuD
	 PEUoun+x5dqug==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] cdx: use generic driver_override infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260604035239.1711889-5-runyu.xiao@seu.edu.cn>
References: <20260604035239.1711889-5-runyu.xiao@seu.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 04:08:46 +0000
Message-Id: <20260604040847.529DD1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Stale kernel-doc entry for removed `@driver_override` member in `st=
ruct cdx_device`.
--

commit c9a2a632f33a0544d4ef0145d2020070218d6838
Author: Runyu Xiao <runyu.xiao@seu.edu.cn>

cdx: use generic driver_override infrastructure

This commit switches the CDX subsystem to use the generic driver-core
driver_override infrastructure. It removes the private driver_override
storage and uses device_match_driver_override() to prevent races during
bus matching.

Link: https://lore.kernel.org/driver-core/DGRGTIRHA62X.3RY09D9SOK77P@kernel=
.org/

[ ... ]

> diff --git a/include/linux/cdx/cdx_bus.h b/include/linux/cdx/cdx_bus.h
> index b1ba97f6c9ad6..f1a107b232daa 100644
> --- a/include/linux/cdx/cdx_bus.h
> +++ b/include/linux/cdx/cdx_bus.h
> @@ -165,7 +165,6 @@ struct cdx_device {
>  	bool enabled;
>  	u32 msi_dev_id;
>  	u32 num_msi;
> -	const char *driver_override;

[Severity: Low]
Does this leave a stale kernel-doc entry for @driver_override in the
struct cdx_device documentation block?

The struct documentation still references the removed field:

 * @driver_override: driver name to force a match; do not set directly,
 *                   because core frees it; use driver_set_override() to
 *                   set or clear it.

This might trigger an excess kerneldoc parameter warning during the kernel
build (with W=3D1).

>  	struct mutex irqchip_lock;
>  	bool msi_write_pending;
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260604035239.1711=
889-1-runyu.xiao@seu.edu.cn?part=3D4
