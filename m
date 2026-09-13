Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233D7386C3F;
	Sun, 13 Sep 2026 23:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340628; cv=none; b=i0ZlnYAes2DL3UHfHrc6eTohK15oMQ7UxHBIgBtzNNdbN+d8QlKvCUknXwqBfzQw7XEJEhu84lumlP9v+MZwIAd9AiAn8eTa91yovXEwCDioISg0e8+Tl8VNUGId5BeZGR5Uo/QQDElg5YDjpCqHldlhViw8GTs1N6wJqchOFj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340628; c=relaxed/simple;
	bh=htNhTUYnrLPOLMcApobjqHAZ9koIePcdkjpvsjQRsGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Myi0GGvpF5xFWKFSfoOjfV3jcbIxOYN2Hlz7Lxx4LyFeMlKB0ZV2y3FhgCCIeEIxfdL3sEDbs5uLSorR+j6j2T36Abn1cW+/9CA+fOm3S16lVVxis2CANEYGjkY4fCqWsWFN0Jmrj0Oi5xlhgD5NGPHskTrJyeILtKYGiXTG3p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JPWbhQuw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JPWbhQuw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 907B31F000FF;
	Sun, 13 Sep 2026 23:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789340626;
	bh=x86Xkw2S2pPIip/cKOLKriM2DECY1ED2Y7lj8zh1b+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JPWbhQuwjMRNKPTSQuMOcYI/Ruvh1tYpd6/WsdNkstGuwUlUSWLAKaJk4zC0dLxa/
	 NyAzG7g+QBxrw5TkAFsBwTtj72zDa8RNIabQBTF0jLOnxuEk5k2lqEs/BNpKRtx+aj
	 bpePpQJ+FYl8Pz8AG0dSIg/jYsM2NHLvyna44l3Y8AeaViYHVx7Nq8hT+xghlw32Mm
	 XieOmEE4TPTAtNO5yALT/+xk0D8F3VGGstcDJ1ToFZl1CNwiIT3Cg1wehzQo4EBlcY
	 KV9kya1IcXqGjyefWtMuUOpI9xOX7hQXXeTPwI/X5jha8oSpu5mjEZTXP3Nb49e8j6
	 m1xUpUiooHUTg==
Date: Sun, 13 Sep 2026 16:03:45 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: fix typo "substract" in
 comment
Message-ID: <20260913230345.GJ2219269@liuwe-devbox-debian-v2.local>
References: <20260907044946.10813-1-hemanth.selam@gmail.com>
 <20260907044946.10813-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907044946.10813-2-hemanth.selam@gmail.com>

On Mon, Sep 07, 2026 at 10:19:45AM +0530, Hemanth Selam wrote:
> Correct "substract" to "subtract", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches a comment, no
> code changes.
> 
> The subject prefix changed since v1, from "hv:" to "Drivers: hv: vmbus:",
> for consistency with the rest of the subsystem's history as Michael Kelley
> pointed out.

You can drop this long wall of text. It is pretty clear what this patch
does.

Wei

> 
> Assisted-by: Cursor:claude-opus-5
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  drivers/hv/channel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index f4370617deac..c36ec14529b9 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -79,7 +79,7 @@ static inline u32 hv_ring_gpadl_send_hvpgoffset(u32 offset)
>  	 * therefore leaving a (PAGE_SIZE - HV_HYP_PAGE_SIZE) gap.
>  	 *
>  	 * And to calculate the effective send offset in gpadl, we need to
> -	 * substract this gap.
> +	 * subtract this gap.
>  	 */
>  	return (offset - (PAGE_SIZE - HV_HYP_PAGE_SIZE)) >> HV_HYP_PAGE_SHIFT;
>  }
