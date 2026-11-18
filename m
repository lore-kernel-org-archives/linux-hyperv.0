Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794971569;
	b=DEHWOmCacu/cL+avnd9HGEICcRRHue3WXR2iRfdR398bRt2aOvHrjvcDXVjk1ZZNKcrn
	 j14URc2RagJyX8p4E1PRF0ujbggNZPCMUsQQ5PIeQ2W2itSAjxtbrZv5zc0aiTH5sIgC2
	 AB0YNMKuO8sm4T/izyRqE1hHuyakXRGKKqky5+l3UeCRRAreulRQJ5XBmG6Xt4TC+HIdT
	 qltzhnbhansyZPH+soe1YAT7daPvurhoaUF2c+0PnMGoh06+GrUsAOqWUevKTEuL7QH4E
	 JpiazxUGtSNUCa2zmeVPWcGiPfEGDHXFihEISb1KrNP6royvNSqjP/AxLk/rXetK5aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794971569;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=GeYupmXjjJ6HSmGG8//5No5YJeJeQrfXBvsDr1IXzRA=;
	b=H3+vFZgADvO5ZyPRBBIlVEZRRh6YFDs8tJJNwew66p4XDNTpdwtnFvORTjhApsu647MC
	 TbfieO6spmYz6BXmm+JZcZ9m4r4UskEJ2NxCYzbaNfAmsR7VByKD4tmvwdSb3/w825m1m
	 z3tneN49AuEEfOSBxe88ag1uaENRHTCSuGjorkc/YZ7vtUgCi4EZk8qSyhVMZEmbrSbti
	 K9rDimO5LOLO3rl8omBZcC79nqLfE7fd7rmarNPrpPOhMKiSkdauwaFPB5/odRvobON9Q
	 kq9ynkkx13431eeuRLn6Lj9ru+zJ/hqXjeqpzV8UET5K11MSWjTIg4MQHtRKHWjugsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Y/XkJG12";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58763606A31C;
	Wed, 18 Nov 2026 03:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y/XkJG12
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE081F000C4;
	Wed, 18 Nov 2026 03:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794971568;
	bh=GeYupmXjjJ6HSmGG8//5No5YJeJeQrfXBvsDr1IXzRA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Y/XkJG12oDfXu8vvKMMfQXorc+Ra/OTnPdYTzPN73gz1Ls3ExIyWPuEcn7WospCmv
	 yJg8Hc1eUr6+AAx4iSPY3q0Wk7o98Qry7kCvFHeUnBkKQ5NVKWIDR6bQvWywuWJ6R7
	 7DMnux2L7F2xrZm+WLeuh3FAkON68G8CrBqSaykM/Hlm1dAw5yNcD0v3cbfdnh1z+5
	 UGfgcLGNlw3FeGWmT6dEu6vvze1YB78ZtNzB/NdtAiBzcOHjFkPcEOypUQZDftXnBy
	 oOJ9o2vajWKwHZAuFOkTs1GFpe+d/hzWpTXVvGwfDXF17Qv6Jsfy+Q1+CABDHXNJSb
	 u5SR+w5Bc+KDQ==
Date: Tue, 17 Nov 2026 19:12:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 ernis@linux.microsoft.com, "linux-hyperv@vger.kernel.org"
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH net-next v2 3/5] hv_netvsc: treat the VF's XDP program
 the way bonding treats a slave's
Message-ID: <20261117191247.28c6ce0c@kernel.org>
In-Reply-To: <dc137a5c-66ee-429e-944a-58a802ebfb97@linux.microsoft.com>
References: <20261109194843.1353592-1-kuba@kernel.org>
	<20261109194843.1353592-4-kuba@kernel.org>
	<dc137a5c-66ee-429e-944a-58a802ebfb97@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 16:39:48 -0800 Kameron Carr wrote:
> > -	if (netvsc_vf_join(vf_netdev, ndev, context) != 0)
> > +	if (netvsc_vf_join(vf_netdev, ndev, context) != 0) {
> > +		ret = prog ? netvsc_vf_setxdp(vf_netdev, NULL) : 0;
> > +		if (ret)
> > +			netdev_warn(ndev, "failed to remove XDP program from VF %s: %d\n",
> > +				    vf_netdev->name, ret);
> >  		return NOTIFY_DONE;
> > +	}  
> 
> If netvsc_vf_join() fails here, did we potentially just
> netdev_update_features() a VF we don't own? Can we restore the old
> features on failure? And / or reject VFs with a busy RX handler before
> making feature changes?

To me the first question is why this driver thinks its appropriate
to override wanted_features in the first place??  That's not how
normal feature propagation works for uppers.

Slightly more to your point - I don't see the driver restoring the
original features when VF detaches. So why should we bother worrying
about the failure case when normal detach doesn't clean up?

> >  	dev_hold(vf_netdev);
> >  	rcu_assign_pointer(net_device_ctx->vf_netdev, vf_netdev);
> > @@ -2363,9 +2391,6 @@ static int netvsc_register_vf(struct net_device *vf_netdev, int context)
> >  	vf_netdev->wanted_features = ndev->features;
> >  	netdev_update_features(vf_netdev);
> >  
> > -	prog = netvsc_xdp_get(netvsc_dev);
> > -	netvsc_vf_setxdp(vf_netdev, prog);  
> 
> I think Sashiko has a point that this patch might introduce edge case
> issues when netvsc_detach() fails.
> 
> I wonder if moving the netvsc_xdp_set() after netif_device_detach() in
> netvsc_detach() fixes some of the faiure paths (RNDIS close or ring
> drain fails)? I haven't yet fully thought through all the scenarios
> Sashiko brought up.
> 
> I understand improving XDP accounting is the end goal, but I hope we can
> get there without introducing new bugs.

"Improving" is not strong enough, the propagation bypassed all safety
checks. See the next series in the sequence:
https://lore.kernel.org/all/20261112235027.4072149-1-kuba@kernel.org/
Pretty sure I left netvsc in a much better state that before the series,
but there's plenty of bugs left to fix. I hope Microsoft will address
them.
