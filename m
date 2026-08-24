Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0B466B1A;
	Mon, 24 Aug 2026 16:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787590517; cv=none; b=IYuxzI3YnCmL46BkI9vy9IVBPgjsrIqqUjzgQFMupD0Uu/ZF9th1EhDDvTD0REHDxTrJK3aNTncI80bQrOyYrsVYQzkZGEf2SK9TFY/5qHs4R3SFaEAmkMNN/C1AQ+q2/F8cuQW44txh9Kbh+I8YGp+Wgj0XGmVy+4thICn47y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787590517; c=relaxed/simple;
	bh=Unx1sUUNjittfjPyw3jMHfp1nhsEvfEWRH/CxKxhsgM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Py+Eln3uFeq1Es3qHJhfW+0jSSjjijUR8+sSWNV7Q1UaI01jcqn46UHP7iY5Iuhp6luqqYxjrIJ5ac4eY9u8rjqpCSzz0vymB97/mvWSN8F24/SGnuCY3Cr2BG/DwVayfcRYAbo7z/NXN0EPUHm7uDSzjozU3duCAU7Eq3fUDEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VayDdRT6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VayDdRT6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECE51F00AC4;
	Mon, 24 Aug 2026 16:55:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787590516;
	bh=OUIL2Z/5Il+cFK4tT/5JjpFm8tkb8ON6KDDmbRUldKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VayDdRT6edOWRghHAo01+7hRHpDvgCUtbv0MM3hp3uRE8uNpf9D/qsp5vdHtgZeER
	 K4PMALbMoiAsUoeepHbfzVPv4/j8XfR26YHf4lPB1+k97YaOrfYKWt4PXMbHK14ndY
	 SIX3KNtz31cgduBF3zPwh2kkVfvAiHxIyI0TYNz8nJWWcXVTGo1wZAbDR7pFavtRzQ
	 ko44l0FGc4aX3n93nHOjE3/PgHisJz58s4b5LUPwMqe0KfHaHR8FC3gwrYz1vhI7Xt
	 XIEmzLkbXMnKAqJRRbhZVSg/7LiNX3/T2X35eyodCWxh6XQxu2gKeEme18THTMMIaq
	 80s18QUkeuBgQ==
Date: Mon, 24 Aug 2026 09:55:14 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Wei Liu <wei.liu@kernel.org>, "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"longli@microsoft.com" <longli@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/6] Remove support for Windows Server 2012/2012R2 &
 Win8/Win8.1 versions of Hyper-V
Message-ID: <20260824165514.GB3665124@liuwe-devbox-debian-v2.local>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260824003803.GI3566091@liuwe-devbox-debian-v2.local>
 <SN6PR02MB415747152F7DD4469F9F945CD4A02@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB415747152F7DD4469F9F945CD4A02@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Aug 24, 2026 at 03:51:51AM +0000, Michael Kelley wrote:
> From: Wei Liu <wei.liu@kernel.org> Sent: Sunday, August 23, 2026 5:38 PM
> > 
> > On Wed, Aug 05, 2026 at 01:37:45PM -0700, Michael Kelley wrote:
> > > Michael Kelley (6):
> > >   Drivers: hv: Remove support for WS2012/2012R2 & Win8/8.1 version of
> > >     Hyper-V
> > >   hv_sock: Remove check for old Hyper-V hosts
> > >   hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts
> > >   drm_hyperv: Remove support for synth video protocol of old Hyper-V
> > >     hosts
> > 
> > This drm_hyperv doesn't apply cleanly. I have applied the rest.
> >
> 
> Thanks!
> 
> The hyperv-next tree doesn't have commit 1502b42819c2 [1] that
> is already in Linus' tree for the upcoming 7.3-rc1. That commit came
> thru the drm tree, which is probably why the hyperv tree doesn't
> have it.
> 
> What's the best way to proceed? Rebase the hyperv tree on
> 7.3-rc1 when it comes out a week from now, and then try
> applying my patch again? Or is there another approach? Redoing
> my patch without commit 1502b42819c2 is just going to create
> merge conflicts later on.
> 
> Michael
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/gpu/drm/hyperv/hyperv_drm_proto.c?id=1502b42819c2eee9658009ff0b7c9249078d7366

Hamza picked up that patch. It should be fine now.

I will carry the other patches.

Wei
