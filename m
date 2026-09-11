Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E55443C02;
	Fri, 11 Sep 2026 11:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789125149; cv=none; b=Nwdh0kgI8n5awMc+xm8twN7N5LzP8AvvFPjFV3kYI/djtKbsuw8gwt3E0Yg6x1pA4/ntPZN+pF/KDS0dYUqppI68XERZ2zIAHvaqsojJk+JZECNS0ZIwhiQR9p5Ubd5idhAJJeAOrRSIudccpq5N/zqaqaFwMvzeviynVCyYS1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789125149; c=relaxed/simple;
	bh=ZjvJhN1sUcXl/KlhudMLw6Au683rhTCl8o0lO63aipM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO7NScyKc93nu5YfGNwdqMSs17JLFoxq41zJ6mxQAFRZL+qHgfN7L5I6UAHF/4uMYFls+vlF31JSWOURU119lytS39oOiMONs40MHAg40JyMlv7x1SdvygAZB19xhMGntQkMGtWTkaheOw59F3rlUG1680XuHS3dmo5XWPm3KMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nrdbgWLd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nrdbgWLd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D9011F000FF;
	Fri, 11 Sep 2026 11:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789125146;
	bh=I2vgVpqPQ1ZhtBK9NLDLlAeVZpr4d0jIeDhEU9WUw9I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nrdbgWLd/DZexiWEEIHBp9mThONVdd4WayBySHTzHcfspy90UPG0DNhAIV9injCT/
	 dNZL8F5/yUydONCnmV9oBMCYML7+iRwsE5SipOHa2JV8XU/fBPJB/KuKVBkuPxu62Q
	 m6CbbmSBucLI2Csa8a18sajIjkb6Mng3K7khAx6NYCPvr3hmH6cTq4LLQ/k6FSRhtn
	 0Fyuf5wEg7DkKrxpYyIctr1vwm+JS77s/b4b2MkXxCs4xqeqBJYDCKsKMtjWyHzT/y
	 NZYwELo+OrUfQDRFltJNxRdD2MTdyBq3HD3IYw62tPRBVmuRzA4g+WvW+MbTZWFQeA
	 1+2D+5CzdQfYw==
Date: Fri, 11 Sep 2026 12:12:21 +0100
From: Simon Horman <horms@kernel.org>
To: Gunter Woytowitz <gunter@vcinity.io>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"open list:Hyper-V/Azure CORE AND DRIVERS" <linux-hyperv@vger.kernel.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:XDP eXpress Data Path:Keyword:?:b|_xdp?:b|_" <bpf@vger.kernel.org>
Subject: Re: [PATCH net] net: mana: never hand a non-page_pool buffer to XDP
Message-ID: <20260911111221.GE48209@horms.kernel.org>
References: <20260910-mana-xdp-pagepool-v1-1-dab140d91fed@vcinity.io>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910-mana-xdp-pagepool-v1-1-dab140d91fed@vcinity.io>

On Thu, Sep 10, 2026 at 11:17:47AM -0400, Gunter Woytowitz wrote:
> mana_create_rxq() registers MEM_TYPE_PAGE_POOL for the rxq
> unconditionally, so every buffer XDP can see must be owned by that
> page_pool: on XDP_REDIRECT the frame is freed through __xdp_return()
> -> page_pool_put_full_page().
> 
> mana_xdp_set() assigns apc->bpf_prog before calling
> mana_pre_alloc_rxbufs(), which allocates with dev_alloc_pages(), and
> mana_fill_rx_oob() prefers those buffers whenever mpc->rxbufs_pre is
> set, leaving from_pool false. So for a port that is up when a program
> is attached, the entire re-created ring is filled with pages the
> page_pool does not own.
> 
> The page_pool then sees pp_ref_count == 0 when such a frame is
> returned, so the atomic_long_sub_return() in page_pool_unref_netmem()
> goes negative and trips its WARN_ON(ret < 0), once per redirected
> frame. Observed on a 5.14-based distro kernel, where that warning sits
> at helpers.h:269:
> 
>   WARNING: CPU: 3 PID: 0 at include/net/page_pool/helpers.h:269
>                                             __xdp_return+0x2b3/0x2c0
>   mana_process_rx_cqe -> mana_run_xdp -> mana_rx_skb -> xsk_map_redirect
>                                             -> __xdp_return
> 
> On a VM booted with console=ttyS0 the resulting stack traces peg the
> console thread and the machine becomes unusable.
> 
> Fill from the page_pool when a program is attached, using
> mana_xdp_get() -- the predicate mana_get_rxbuf_cfg() already uses to
> choose the XDP buffer geometry. With no program attached nothing
> changes, so the pre-allocation still does its job of keeping
> mana_attach() from failing on allocation.
> 
> Leaving the pre-allocated buffers unconsumed is safe:
> mana_pre_dealloc_rxbufs() dma-unmaps and put_page()s the remainder,
> and every caller (mana_xdp_set(), mana_change_mtu(), and both ethtool
> ring and channel paths) already runs it after mana_attach().
> 
> The rxq->xdp_save_va reuse in mana_get_rxfrag() also leaves from_pool
> false, but that cache is fed only by the drop path's non-pool branch,
> which this change makes unreachable while a program is attached, so
> it needs no fix.
> 
> Found and fixed on a 5.14-based distro kernel running AF_XDP over
> MANA in copy mode: 24M+ redirected frames with no warnings, where the
> unpatched driver warned on essentially every redirected frame. All of
> the code involved is unchanged in mainline.
> 
> Fixes: b1d13f7a3b53 ("net: mana: Add page pool for RX buffers")
> Signed-off-by: Gunter Woytowitz <gunter@vcinity.io>

Unfortunately the CI failed to apply this patch to net.
Which is curious, because I am able to apply it locally.

But perhaps it would be best to (rebase and?) repost
after waiting for the usual 24h[*] to elapse.

[*] https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested
