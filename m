Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839473ACA75;
	Tue, 14 Apr 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776181298; cv=none; b=HzOFRleuY609Hwzq1rsAkYyzMFTf/EonRCvs4VsUcjbwSd+dMG5Sn1BC9gFZmaoekcI3ENHybMTIY4zMjLwfJ3IbQIQCeFFgwyfIY0O805sZwUWBM4/zuFvUBpD9F+B0uRwVZj/SnVs+iNsfD4uqFrVzWzmNhQoeTxSREcr9O4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776181298; c=relaxed/simple;
	bh=/rqmdxMeR036Syl1itezKUXvkauEBNM3wagDhMvIPAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UEI7WE4YoWgWj56YIoRz+NY/a3k4vBWDB6USaggGs7GkIvRr1vmqqN+NqJOuCq0tNFZfP/6WEMNFryi88uLobM9GWRlkyb45dhav99Coip5fgrxlEIXZ45XixSv7b7EwxW8FhMF2PwRr5cHrV7433jiE7fnES4vETHp6ZG+Ko4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4Bg/Wmm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4Bg/Wmm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F5CC2BCB3;
	Tue, 14 Apr 2026 15:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776181298;
	bh=/rqmdxMeR036Syl1itezKUXvkauEBNM3wagDhMvIPAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B4Bg/Wmmu9L4CZOmqdptP7/hrYFTjxP5BVDgQUs1dPzSYQ58vsaP2X3emrv8cO8R9
	 eR06XJuNZEV/POlJwz1KzYX4nEqL57pcHu16Q5uMab1dNQu9vWwdzDkvN7i3m1Uuw6
	 pWa5u8U7aQtPLZPa5+4QWRlp4HFWDwo5NEx25Q0OHC2aNE0KnnV5e/6Ed5wikvK8pK
	 hQYgPaY8WoJpuQY4MX3EdEO+1wwbYA38jhPQZGGUeFKM7pb5esOYzAMpIYaFN1Q5ZX
	 GS0LGcKAEyxsOdEB/kr33A2hB/NLrcBowpUw6SCLSfh3evRbtRDVlFQ1kiDKFoBJXV
	 C99rDtrl+DJ+Q==
Date: Tue, 14 Apr 2026 16:41:31 +0100
From: Simon Horman <horms@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, ssengar@linux.microsoft.com,
	dipayanroy@linux.microsoft.com, gargaditya@linux.microsoft.com,
	shirazsaleem@microsoft.com, kees@kernel.org,
	kotaranov@microsoft.com, leon@kernel.org, shacharr@microsoft.com,
	stephen@networkplumber.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 1/4] net: mana: Init link_change_work before
 potential error paths in probe
Message-ID: <20260414154131.GH469338@kernel.org>
References: <20260413050843.605789-1-ernis@linux.microsoft.com>
 <20260413050843.605789-2-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260413050843.605789-2-ernis@linux.microsoft.com>

On Sun, Apr 12, 2026 at 10:08:37PM -0700, Erni Sri Satya Vennela wrote:
> Move INIT_WORK(link_change_work) to right after the mana_context
> allocation, before any error path that could reach mana_remove().
> 
> Previously, if mana_create_eq() or mana_query_device_cfg() failed,
> mana_probe() would jump to the error path which calls mana_remove().
> mana_remove() unconditionally calls disable_work_sync(link_change_work),
> but the work struct had not been initialized yet. This can trigger
> CONFIG_DEBUG_OBJECTS_WORK enabled.
> 
> Fixes: 54133f9b4b53 ("net: mana: Support HW link state events")
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v2:
> * Apply the patch in net instead of net-next.

Reviewed-by: Simon Horman <horms@kernel.org>

