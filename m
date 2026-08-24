Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D27415F3B;
	Mon, 24 Aug 2026 14:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581352; cv=none; b=BUmmH+zJc+YegdgccwVn9Ub0z9XP+Sx1ZVQqn3rlmUjEJv0YhmJwLDJZ6Ea04jdp1vZ06Aibemmzomne25e/9dQUjBx17ihnxjUq0ib/ZCMMYQRXq+jfirv/SFTnm4+vq6Eqq5NXLKNdLU+jR7HefB7ZUnvJxLOa6gG9fHaUxCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581352; c=relaxed/simple;
	bh=D+4tYAyf4DaTItNcUJePJOcDeRyZSmVBFL3oPIVBqDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8YjTAIwRoOwbWH2aY/EgtyG0udrvAVLlyipWD4qQ0bg3kth7agW0Vuy/gHMep5MOQuoWeP6ucH1aZzLJ1O5wQ2nz4hlPNKmjLxtNMGfS6OCnKx0O7LRv0DYbZdeuLLu9fX/etqgGdKjoyhQq4Vc+q5hWhBq84bIeIpTVdDAB9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=U59ZVEET; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="U59ZVEET"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id B50D320B7166; Mon, 24 Aug 2026 07:21:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B50D320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787581319;
	bh=V648zRbvn2IfPRlwQWD8kqCMILZw1a3NsTdczu0orWU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U59ZVEETLhaL2/NhnxsRUI5q9GxojcZy2GmaAJZSOskG7hLq9kkoMEkivJNnqTFFJ
	 cKzN9EzDmBgpSZRsO63jLSi+d6s4AGGzect2Wp1ofwDA9tyhN5001F7r/rVWi6dZ0T
	 cVoSQeN7r5ZgBWgczlKG1LrGEBgGHwAUjF1pyXsI=
Date: Mon, 24 Aug 2026 10:21:59 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Muhammad Falak R Wani <falakreyaz@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net-next] net: mana: remove unreachable dead code in
 mana_bpf()
Message-ID: <aoxThygUBWq0WqfS@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com>

On Mon, Aug 24, 2026 at 12:39:06PM +0530, Muhammad Falak R Wani wrote:
> mana_bpf() declares an uninitialized 'ret' and falls through to a
> trailing 'return ret;' after a switch statement whose every case
> (XDP_SETUP_PROG and default) already returns unconditionally. This
> statement is therefore unreachable dead code left over from an
> earlier refactor, and it would return an uninitialized value if it
> were ever reached.
> 
> Drop the unused variable and the unreachable return.
> 
> Signed-off-by: Muhammad Falak R Wani <falakreyaz@gmail.com>

Fixes: ed5356b53f07 ("net: mana: Add XDP support")
Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  drivers/net/ethernet/microsoft/mana/mana_bpf.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> index 53308e139cbe9..70bb8c9dc3413 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> @@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, struct bpf_prog *prog,
>  int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
>  {
>  	struct netlink_ext_ack *extack = bpf->extack;
> -	int ret;
>  
>  	switch (bpf->command) {
>  	case XDP_SETUP_PROG:
> @@ -262,6 +261,4 @@ int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
>  	default:
>  		return -EOPNOTSUPP;
>  	}
> -
> -	return ret;
>  }
> -- 
> 2.55.0
> 
