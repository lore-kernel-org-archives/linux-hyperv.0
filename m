Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3252127979A;
	Wed, 18 Feb 2026 23:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771458478; cv=none; b=lQ/jUm6jzs+zh1ZOc7M34LhXWDp5F9injd3zslzHuyOtXk0Y+RYFPO7DQ63T459Xe8pgpPG7eF1nprOEQ4d3uYcFErQgjxa0XSB4Zst4GFvh+A9riKcDwucsYU14EvtYjnarg4kNZ/KqqwDY/DJJfdZGoodPxlNTzBdNZJWseSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771458478; c=relaxed/simple;
	bh=4oCNwPt48r0U5zYD18OHEyt2LnQJRvFTY3+xEQX1qnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PsQmSSaN9+bpRTu4Lfg9UJ4ayDTsX0owvhIbwLwtg6eNyy9zo4UQ9TwgF8In8khhj9CBAYohq8GrGqzuRhmKbwA6Atc9x9PNj7LhdTr7nkI9cfQbUGOKDivyX/jplmrzAu/tb8XSKMY6HIdpfr/ZLrl08vdKNJnnQIFmjE5z4zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv1Q+8Tx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv1Q+8Tx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB11AC116D0;
	Wed, 18 Feb 2026 23:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771458478;
	bh=4oCNwPt48r0U5zYD18OHEyt2LnQJRvFTY3+xEQX1qnk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jv1Q+8TxKHVLP+GqWPMYP0vXH5X+AgbRqLI4bKpAhtc7Z9zpPw5hoBZf+s3FakNft
	 BDd2hFkHYXWiF3boKxHBHMKYKf+R2T15ZuGl0FKgHQoACN/RwgPI1xYd3FipOz1+ux
	 3ZF4qSvoXdSrPlUAi5C+JD2SRsRD9mkU65zMAxwz8WEewXIJNkeBXbWrT9ctdYohau
	 Q4KvPP86rvpB0xD/zBmFjVH+a/XXpbEYQmAWUAxLhO/xNzYJ5zR24C+LqmOJL/j8Uq
	 mBSk95PAwUcvt3yfKtcUEVFkj2juzOX5axJcfoyyFnb3VBfxR9GCzgav2Quh2J8yD5
	 LtrE8Q7bnSCzw==
Date: Wed, 18 Feb 2026 23:47:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Long Li <longli@microsoft.com>
Cc: "mhklinux@outlook.com" <mhklinux@outlook.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	Dexuan Cui <DECUI@microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXTERNAL] [PATCH 1/1] Drivers: hv: vmbus: Simplify allocation
 of vmbus_evt
Message-ID: <20260218234756.GN2236050@liuwe-devbox-debian-v2.local>
References: <20260218170121.1522-1-mhklkml@zohomail.com>
 <DS3PR21MB5735CA49BF2A99E320D69C8ACE6AA@DS3PR21MB5735.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DS3PR21MB5735CA49BF2A99E320D69C8ACE6AA@DS3PR21MB5735.namprd21.prod.outlook.com>

On Wed, Feb 18, 2026 at 09:52:41PM +0000, Long Li wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > The per-cpu variable vmbus_evt is currently dynamically allocated. It's only 8
> > bytes, so just allocate it statically to simplify and save a few lines of code.
> > 
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> 
> Reviewed-by: Long Li <longli@microsoft.com>

Applied to hyperv-next.

This has a conflict with Jan Kiszka's patch. It is easy to resolve.
Please check and shout if something is off.

Wei
