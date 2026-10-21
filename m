Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792566921;
	b=HOfCKrYf9OwTGADEn4KzgvStV5EC4ATvxiv2fSEDBlIpOHeUBuEOoMoJjkA1zHNteLk2
	 UTjHj2zIJL32K9BzgRY87jDmUEHgPHBjLs3hAtGC3HbLnvfHCQp4I1Sc4FYK2q0Cws0Y6
	 PCL9wzkGZxorkc1OGfZ7VIO2JyZxlcOQNl31SH4WCy95vnRBGRfiRxdjGrZT40xflZaLC
	 2hYMxNCUzeF27GzqmaaigA22DRFla9QY/G56yEdPIuaRkOMFqgFLrLJif0e7riWxe6xp9
	 h+IN+YZv+hMmUTvbjRt8zQLoyf1RjaF00cjI8QmO9Y3k6Mweait9xizeYrTmw2MtgPg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792566921;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=GJlhSxM8zOGw4pZlr6oN5qsjXrafvLr/XcRq/mpxBXQ=;
	b=YWMjyZdKO8wEPNzOxcIyt2cscEQvXRlA2B0oQySsuANN7nJZp3hQHqCbZgouOeyPRvw2
	 rfCbTXe+/J5nIhHUDf38HIIRCZCiPdRphyFhS0OHbrRhO1JlcJ88/6J7CMeAIIlFHEVqE
	 /LdXzHxqh6L5eCXU0QBCuYDy/IrAp1tw6NAWHYvLclqHUtEvgWzkTcJIBpyQvXyDmUY7N
	 xxGunNnAKlyGxJ9CaxmkV98u01Af69UXnNLuvkN9FdJus6REcrqqqenTs6U5ECVzOY5S1
	 9xg7ld9BCJftyqvOusFMXK5mvwEFDZQ4V6vZqqOdO0hltvWZQ+5GGUU8CtW9TpAU6hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiJSgHIa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E4606A31B;
	Wed, 21 Oct 2026 07:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IiJSgHIa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DEE71F000C9;
	Wed, 21 Oct 2026 07:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792566920;
	bh=GJlhSxM8zOGw4pZlr6oN5qsjXrafvLr/XcRq/mpxBXQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IiJSgHIaw0/3Bs/FO7q64CPg6nJYqPyCCwVUAJirU/zuLJ8fPMLAK2STwrBGOprZo
	 u1UTJzPdWRKSnPeymNgijRfxFNKTp31bu2bvBazJCs7DbG9L+BR8My4BOYNr3HloUt
	 iD3/fDTIro4qM2AqvJsNyXqN+tTFH74zK8iA3/7/BwVB3R3NB3/73+9/bFdDLdA56N
	 ouoPLnaarU9tWBJo3U/Bab6Jj7eIwAcPVmB9ebbd3EyHA19bCKjm8ZRJwGgNfbu37J
	 X7cVkzhD0GKnsdeOCFt0p1kFUgxHsQc4BTPYEvEfsTbj8IP5Bph7tPQsuKXLq/mjjg
	 a2mSOz2uFjfAw==
Date: Wed, 21 Oct 2026 00:15:19 -0700
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	corbet@lwn.net, skhan@linuxfoundation.org, rdunlap@infradead.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
Message-ID: <20261021071519.GD851443@liuwe-devbox-debian-v2.local>
References: <20261013014354.18023-1-mhklinux@outlook.com>
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
In-Reply-To: <20261013014354.18023-1-mhklinux@outlook.com>

On Mon, Oct 12, 2026 at 06:43:54PM -0700, Michael Kelley wrote:
> The functions for sending VMBus packets have changed.
> vmbus_sendpacket_mpb_desc() can target multiple ranges, and
> vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_getid()
> has been added. Update the documentation accordingly.
> 
> Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied. Thanks.
