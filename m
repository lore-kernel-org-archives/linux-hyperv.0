Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECF0220698;
	Fri, 11 Jul 2025 23:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752275565; cv=none; b=pCA7YP3RQ0haZ2awWVbsQORRFZyE9+WYGvE/GLSYsV2AXVDT2TnmnK7rzXRDUIgt6gC85e7tPkKJPGPeGIG2pPpu6b1hln4hUdJcxAPKIzu28xqCLXUm26e6frVTKSgqbIJNFGqlffZK1vM7tWas5ma5U3l7hPmuk3OOzrV1Wx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752275565; c=relaxed/simple;
	bh=rcEM94qudE/5/XmhjCGjmRJ8GIDM6gxglpKOGagwb3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TWZqsHc5/iLLtd+TlJYyGx78qVr2jwpJInYCzAcDNCCBzcuJpaPm7OmG+/c//4DWNCRc87sKoLdoMWD2F/9yXzBRHAESCEFODzpTnMD18QYy6bEwlUB+pRg4O2adxAlm/GTOb6+BBJAU5cmcn/Q70vZSTufYneHdnG78rZmyDWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pEHYTxj/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pEHYTxj/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F161C4CEED;
	Fri, 11 Jul 2025 23:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752275563;
	bh=rcEM94qudE/5/XmhjCGjmRJ8GIDM6gxglpKOGagwb3w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pEHYTxj/qkhDlunyOLB2QsgZw+7+UDz6a24OdaGsE+9eskvxd1tIazSaQf3cKQKKk
	 TVpmy5xo6jwTK3L0ndTNk0HtYd75xehavALa8bl5OIS4Cp8EMFFV61/Z8DJZ13oxC+
	 Dy/wHWBdiBdNIMJ9qitIStQ4rHhyKYDvj3BUV92SUpdiv05byQq8O92VOD3wJu11Sm
	 hCETeq+z3mGKL4lLjHmuEAk9RbGrzMTyVov7S6fykdVIdsLSoGEnBNdvY7oOeHbWuf
	 97d5H4XeWoKcoLmmxA8BMHDq0YGM90oUXm988OSGsx+CVEfqmVKrFbgwa9QWTiwnBj
	 p4PzM/YaJnopQ==
Date: Fri, 11 Jul 2025 16:12:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Li Tian <litian@redhat.com>
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Stephen Hemminger
 <stephen@networkplumber.org>, Long Li <longli@microsoft.com>
Subject: Re: [PATCH v2] hv_netvsc: Set VF priv_flags to IFF_NO_ADDRCONF
 before open to prevent IPv6 addrconf
Message-ID: <20250711161241.772af0eb@kernel.org>
In-Reply-To: <20250711041700.13103-1-litian@redhat.com>
References: <20250710024603.10162-1-litian@redhat.com>
	<20250711041700.13103-1-litian@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 11 Jul 2025 12:17:00 +0800 Li Tian wrote:
> Commit 8a321cf7becc6c065ae595b837b826a2a81036b9
> ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")

Please trim the hash to the same length as in the Fixes tag.
 
> This new flag change was not made to hv_netvsc resulting in the VF being
> assinged an IPv6.
> 
> Fixes: 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> 
> Suggested-by: Cathy Avery <cavery@redhat.com>
> 
> Signed-off-by: Li Tian <litian@redhat.com>

Please remove the empty lines between the Fixes tag, and the ...-by:
tags.

Please remember to increase the patch version between revisions.

Please don't post the new versions in reply to old versions.

Please don't post new versions within 24 of the previous one.

Please read:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
-- 
pw-bot: cr
