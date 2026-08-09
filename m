Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5611C5F1B
	for <linux-hyperv@vger.kernel.org>; Sun,  9 Aug 2026 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786290937; cv=none; b=Sb8wMn65NMe4zuMTcvLNpJJqKDx3Truc4NkCaSr3Ke/DsOGh1LX1NfL/rRVJS5J+nt+MMpwr+muG2hXfsmOgd4EQjDmBHRxhri/HuE9nmL1Or3UxClsf3RZsnBllwUbFsvBC4eYXXT1Yf+09pZcG4ir5zG41Gwroa5pqf4z7Za4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786290937; c=relaxed/simple;
	bh=QcFrRCeDI/i3Ew/e11cx7MxC5wvLiH/lxBlsj++ms2E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WLO1TaJrjR0cqopvj+msJZKG5fZMTHNgVbALvD5Cj4PlpgiLpvzjPIbonzijOYWtJ6IaYv6o3TCVSY1cqBJfjgA2Jw/97/lF9ugPALFsGbbB32qbmaaN+zq/eb4yCGkcTymytWXT5f47Y96tVEYpzq4O4ExHgBMWo7cPre/d5QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b=BMBwbgMk; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20251104.gappssmtp.com header.i=@resnulli-us.20251104.gappssmtp.com header.b="BMBwbgMk"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4954dff6536so9134165e9.0
        for <linux-hyperv@vger.kernel.org>; Sun, 09 Aug 2026 08:55:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20251104.gappssmtp.com; s=20251104; t=1786290932; x=1786895732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QcFrRCeDI/i3Ew/e11cx7MxC5wvLiH/lxBlsj++ms2E=;
        b=BMBwbgMkP18hHiz81HK0br1cLQexDPtxAmivgb5rJ1GN5stbdt9BFYDbrlTlWx2a0C
         dsgyVQOggkTPXVOaTL2y2SDL+4LLxG9uUMmg1TSkLT7S7NPBmDndYm84ge+eglHtE6pk
         I8XmE21HWJoU0PYuPb8KkPlU8dT/bbpxsl43loqY3RaK5SvZAlvPrdNMOdPV9r2a6n4w
         hMJKX0jU5Txj8nRhE/Om3WDpz1JtTg3SPeA44DF5yjBE7FXWobKw+VaPM2GLfZUwW75p
         3bUrNcP0Zr0TGGnWRSQ+Z83BjVnUQBqR0Vv15ueYZ41vFWiPSKgNd94XmjZFK1PlaLXh
         zt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786290932; x=1786895732;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QcFrRCeDI/i3Ew/e11cx7MxC5wvLiH/lxBlsj++ms2E=;
        b=KKV3KxETPz5ADTPy3AfeXxP0coePqqqC0yLs32P2laSef8qWko/oL8LLh0XRBzELWH
         EVWUEwCxhWkXSTK4/yewX2EFXJRR3lqS/je93hMx0yOJrnHSvQ9Q7TPU3GGu5Hied7Md
         o0fqIx7IDrzadDLf/dHuk77XExOwHeMm+lK9B4yFpawqnE/Ys4wsTct3IAaGSsO1w6CF
         WAfblXu3x+wyCxaxlhyAjG619sRAFBX+hYFkr4yGbSXIQLn2RoqXyZ0bOyxO1F/oaQDj
         dMOdgVHOv5n7GN9swMbTMyCmeHxPtIctD54ADUnKObG6TGx4PDSoX25kPpU4t/giFvID
         cP1w==
X-Forwarded-Encrypted: i=1; AHgh+RqclkYft86unFW1x5DDO2iebGaR2hRkpayzGJIV9ObMyQ8ifxnDlq5t668jiWObsPNYil7J1D3qtlaYbV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLS4etPn9PIPGJg1lmh1H5eri5gZR+MSC4JOHjcgxu3PkCGiDM
	cOQFUi3/ApVxc4PX+2pNEuFse1hDTQwLvmLAR5Ep2cexsUvBbHIoi7f5UHDHioLV/io=
X-Gm-Gg: AR+sD13aFgfUj7mhf2sufOmoafms7XJhSW+OD72nm5OIX7MIanB1VsScH1jYe4r+WYb
	7aY03WlUTgAe2tv4iSpp93BmSevquTNGm050Zyrs6iGn4wfsmtswDwneu9J/3YHQJ7GZquFEjru
	IgE3PoxUhlow2moHJsuLemvdVQMUnBBJepPkH49aD8gU84tcUo22YfyADIQyuydxU6SPDkvoa4t
	KSt0uEE1JdkObY76ah5yAYRLAaA6ULi+6nhoVOaVtkyFwck28gjo66iNS3ep43BrDqpMb31IIRB
	VZNulcRMdOSwFczlM58IkOCpho/7oQAWN/F3RVY1JhYxEvwft9AtpzQUexvOl7g5fGjBtIVwOHS
	pBCDTq7zYIhCwRM1zNxZpH1CGxB0KQ9ABwCk8dNwRWXomJVKHIp/LqQL0W5vW93/PBqAi3d6I28
	0t1IUxCisMgwC0ykppdoi0wp/t5/+0afGnnGvxQkgoc2O4HIFaZ1VTvwJHMSccyMUahOt1vje5G
	EKYQFLe
X-Received: by 2002:a05:600c:6c50:b0:499:48bb:417e with SMTP id 5b1f17b1804b1-49959e0176bmr225272675e9.2.1786290931844;
        Sun, 09 Aug 2026 08:55:31 -0700 (PDT)
Received: from localhost ([140.209.217.211])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4995e9f060bsm217952505e9.7.2026.08.09.08.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2026 08:55:31 -0700 (PDT)
Date: Sun, 9 Aug 2026 17:55:27 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Konstantin Taranov <kotaranov@microsoft.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "leon@kernel.org" <leon@kernel.org>, 
	Long Li <longli@microsoft.com>, "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH rdma-next] RDMA/mana_ib: Retain create CQ flags field name
Message-ID: <aniik0sdK04Ie4HH@FV6GYCPJ69>
References: <20260731091041.2250897-1-jiri@resnulli.us>
 <DU8PR83MB0975547820CBB956D4EFFE57B4C82@DU8PR83MB0975.EURPRD83.prod.outlook.com>
 <anCBtLSxn8TtFcSz@FV6GYCPJ69>
 <20260807231356.GM200537@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807231356.GM200537@ziepe.ca>

Sat, Aug 08, 2026 at 01:13:56AM +0200, jgg@ziepe.ca wrote:
>On Mon, Aug 03, 2026 at 01:59:07PM +0200, Jiri Pirko wrote:
>
>> That is not doable in UAPI. Some userspace app, like rdma-core in
>> this case, might use it and rename breaks the compilation. Some other
>> app you don't know about may use it.
>
>Linus actualy had some comments on this once (which I will never be
>able to find I guess), but we broadly follow what he outlined. The
>userspace has copies of the kernel headers embedded in it. When the
>kernel headers change the user space updates it's copy and fixes any
>build breaks.
>
>So long as the build breaks are fixable, and don't change the ABI, it
>is fine.
>
>Many parts of the kernel work like this because userspace is not
>supposed to directly use the kernel headers themselves, they are
>supposed to be sanitized by glibc or some other helper library.
>
>There are a few places that don't work like this of course..

Yeah, me being mainly netdev-guy, that was never allowed there. Not sure
about now. But makes sense. Would be nice to have it explicitly
documented in kernel docs though.

Thanks!

