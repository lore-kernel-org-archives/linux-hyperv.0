Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C2324B16;
	Mon, 23 Mar 2026 14:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774276022; cv=none; b=cWlmA5E39594Wfz9q9v8tg3oImPWWpdTFUIfxVHezfWkERNfEEeV0mJNb75DF22FWjSWsMl/5ih9rQA0ZlzxzSa5506CZu094WaV0akWJUI31B7bwQY5nEyDM8WXiE0uJ9+5BlqcN7C5uTQ+e2Gdrv031nAcHzmLA4Ul0PT5paI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774276022; c=relaxed/simple;
	bh=8KRLhH33i2FNLApu94OPmDw6j0N213zWBF9kRptSPlk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r1+hztIhT4htDyyN7+HVFyaCaO+o1+qAxupuhJmBkf6VQwtRY+PSQ9+zojhKuotCrXlyh3ltcxSh2sY7BFC3CGer4VwORy+W1DsPr+Cp8n8a1lK4U8A89UP1Pc8axY0WRkeDWS/uUS199KhAUzGhm3z2YbmOYlpsrluMZGp/LDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWNs/yi7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWNs/yi7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DDDCC4CEF7;
	Mon, 23 Mar 2026 14:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774276022;
	bh=8KRLhH33i2FNLApu94OPmDw6j0N213zWBF9kRptSPlk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OWNs/yi7fQcGCIlhgUN5CL2LsU+TSRm7mvw2/H1hy6QIU5I/a18pSN+Bcj7UvGDab
	 Lt/j72orxmdQOzoiv911AZXrYCDzQLuYYwOWA60UKDFWiJeR/b1iSjtErtRFwYsmX7
	 GubbSzwrngbKJYKrfHaz/dn6s9cENPdO6N8ej15gojnXeymkkfgc6zMFySVtx4hyo0
	 /s4IKXZ4m89h3CUoGo0OZnC71PVuNC9eKQctdKiHF7frYK5KMqAE6/G7NOAzPRJGNO
	 Zbqd3m9dz1PTWNeyOebbJMUEJl4ui2nCqzQj8bFHeAqCA62+OLXO++jU1Jqqor8mcl
	 Hl/YpXRiYZFoQ==
Date: Mon, 23 Mar 2026 14:26:55 +0000
From: Simon Horman <horms@kernel.org>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Erni Sri Satya Vennela <ernis@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Aditya Garg <gargaditya@linux.microsoft.com>,
	Dipayaan Roy <dipayanroy@linux.microsoft.com>,
	Shiraz Saleem <shirazsaleem@microsoft.com>,
	Leon Romanovsky <leon@kernel.org>, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: mana: fix use-after-free in add_adev() error
 path
Message-ID: <20260323142655.GA85922@horms.kernel.org>
References: <20260321053918.791068-1-lgs201920130244@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321053918.791068-1-lgs201920130244@gmail.com>

On Sat, Mar 21, 2026 at 01:39:18PM +0800, Guangshuo Li wrote:
> If auxiliary_device_add() fails, add_adev() jumps to add_fail and calls
> auxiliary_device_uninit(adev).
> 
> The auxiliary device has its release callback set to adev_release(),
> which frees the containing struct mana_adev. Since adev is embedded in
> struct mana_adev, the subsequent fall-through to init_fail and access
> to adev->id may result in a use-after-free.
> 
> Fix this by saving the allocated auxiliary device id in a local
> variable before calling auxiliary_device_add(), and use that saved id
> in the cleanup path after auxiliary_device_uninit().
> 
> Fixes: a69839d4327d ("net: mana: Add support for auxiliary device")
> Cc: stable@vger.kernel.org
> Reviewed-by: Long Li <longli@microsoft.com>
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
> v2:
>   - explain the UAF in more detail
>   - retarget to net
>   - preserve reverse xmas tree order for local variables

Thanks for the update.

Unfortunately the patch doesn't apply cleanly against net,
which breaks our CI.

Please rebase and repost.

-- 
pw-bot: changes-requested
