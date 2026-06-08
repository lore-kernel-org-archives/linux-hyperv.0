Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7282E9729;
	Mon,  8 Jun 2026 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780942187; cv=none; b=mk6zDtBgX81R85mdjZ2gx1ITT4FzJVu3oTK9g+cAQThqv/PMRglUsYqIuukYO+Zt1ijjBjO/bN+rdRoF7sRM8XHRfRWRpnw80nQ7onVq/j2oCYnPoNEK7NNTCejBXhP1MxmIiLZyccGrAv/U3NCIQIjwzfx3Oj1Wi33qWHfnLqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780942187; c=relaxed/simple;
	bh=yQi0FehVr0hnoiorPe50JtCERf51hXdcTjU/5ztdS7E=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=DZzox2d2tQ+KysJ4OhdhCZcqzxAA9gEGk+MpzBRijU4raDW6noHw128WgU3mGZTjDoAFaXiAeMX9B1+3Dm69aWXCWEfXJpqqZZXGhnaJmj1z4R4swxaH7p+/0cBFsE7GJm7f7JQEbLTYW1IN6GhWBhsiEDqqFA58zMGy4DcBg58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOfrT7oT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOfrT7oT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A02341F00893;
	Mon,  8 Jun 2026 18:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780942185;
	bh=w6Sj9KBVpWBu0IRBBMFLVz+Qm72fUyU8TG/ZcqyT+mQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=iOfrT7oT1QEv19CjUppniUxpZRLrPye+538+5g/gjz57wWECexZHVxWR24m6NuN9I
	 m8PgHRimnwWufc3+eE3slC2N+r5IXlAQj+v6g9U/HjqNbrujNxOZIghMt4V57rM/0D
	 3Agrc/ozlytPfSNzJLxRD7NTONUSKNqZm5GGY+oBQfNFb81bnWCjgu0vuBPk2Kvax9
	 1wtamivtMZZbWQvpr3RzXFoIs49Ihu9Kn9m2edgYFRY/zDkeR74v02PJAfNoxb0Ql3
	 hFpn4DgBvYBRLXPPxFgY65Y6YL/b6pso964+Csv5zA0MZqiSX5BYL5QP8O98EBoFcR
	 oOvrRw5Acxrdw==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 08 Jun 2026 20:09:40 +0200
Message-Id: <DJ3VBAU543O4.1MCNNBJ7U9IRN@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 0/4] Convert remaining buses to generic
 driver_override handling
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <driver-core@lists.linux.dev>, <linux@armlinux.org.uk>,
 <andersson@kernel.org>, <mathieu.poirier@linaro.org>, <kys@microsoft.com>,
 <haiyangz@microsoft.com>, <wei.liu@kernel.org>, <decui@microsoft.com>,
 <longli@microsoft.com>, <nipun.gupta@amd.com>, <nikhil.agarwal@amd.com>,
 <linux-remoteproc@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-hyperv@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <jianhao.xu@seu.edu.cn>
To: "Runyu Xiao" <runyu.xiao@seu.edu.cn>
References: <20260602160829.560904-1-runyu.xiao@seu.edu.cn>
 <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260604035239.1711889-1-runyu.xiao@seu.edu.cn>

On Thu Jun 4, 2026 at 5:52 AM CEST, Runyu Xiao wrote:
> Runyu Xiao (4):
>   amba: use generic driver_override infrastructure
>   rpmsg: core: use generic driver_override infrastructure
>   vmbus: use generic driver_override infrastructure
>   cdx: use generic driver_override infrastructure

Given that you changed the approach to use the new driver_override
infrastructure, I assume you read the message in [1]?

In this message I also explained that this all has been addressed and was m=
erged
into driver-core-next already.

[1] https://lore.kernel.org/all/DIYPR0K2CZW7.254R8K7ONBX5D@kernel.org/
