Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EECF737269C;
	Tue,  6 Oct 2026 19:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791313521; cv=none; b=hs0VsjzEMKAiCW6UWcgax5oJqfdsYP2w+fhYvsWqyZooyJye3xr7NA1zTzRLWMcHcCiNtY/Uv1EdT/wbcI963+Q8Yv/r8BdhuN8y1p55VS9CLLHqREIXVKTbUODk3Ctm4MDMjFJLCHdr/9WvoPd1gnUTFTzKxIMg81j/eHUkSCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791313521; c=relaxed/simple;
	bh=zQtt7HxACahWkJMUND4HHPod4L2ogOPqrJdS/tbxGv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uSieA6GGDWtvQ5raupAvhDt+fWLDGHfZdCL5eCD0ym+SvIsihmhwl4W98tHRnvUpA4HXoKbB2G3aQjdJ+ibNjayRuId66xixQjEOfdmUAcrwEu4PWep162fqz7+xBcYZbTWcxLVenlZrzu7dnsI9ixKVozepx3n1QIg1cdMgFjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SxiU8jxc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SxiU8jxc"
Received: from [192.168.4.134] (unknown [52.172.102.222])
	by linux.microsoft.com (Postfix) with ESMTPSA id C976320B7175;
	Tue,  6 Oct 2026 12:04:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C976320B7175
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791313463;
	bh=FY9kI9KlSQjQKGGd5vqvSNeS2Onh88UrYVFTZP4peVM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SxiU8jxcp0IqHzLxwE3msYDGihbzf+zhfloAvVftai+u9P8KqDKDSIOXjxVk+4q/u
	 cAwaQdKzuxhjnjWfEf8GjaO/zikd8DizimCFLWFHZOVJNDOUiN7/mW3UjZKx9Tc71s
	 yy/kzoBg5TwATYQesNkSXLA1uz+rWu+Mkiq52/Mo=
Message-ID: <2188ea84-8fb3-4170-a4b7-01dcab459ceb@linux.microsoft.com>
Date: Tue, 6 Oct 2026 12:05:15 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/5] hv_netvsc: fix the program refcount when the
 VF refuses XDP
To: Jakub Kicinski <kuba@kernel.org>, haiyangz@microsoft.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 wei.liu@kernel.org, decui@microsoft.com, linux-hyperv@vger.kernel.org,
 hawk@kernel.org, andriin@fb.com, stable+noautosel@kernel.org
References: <20261001014131.310771-1-kuba@kernel.org>
 <20261001014131.310771-2-kuba@kernel.org>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261001014131.310771-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/30/2026 6:41 PM, Jakub Kicinski wrote:
> ndo_bpf() takes over the reference it is passed only on success, the
> caller puts it back itself on failure. netvsc_xdp_set() takes that one
> plus num_chn - 1 more for its channels, and the rollback after the VF
> refuses the program clears the channels again, putting all num_chn of
> them. dev_xdp_install() then puts the one it passed in a second time,
> and the program can be freed while the fd which loaded it still points
> at it.
> 
> The VF refuses a program netvsc has already committed to when the
> program is single-buffer and the VF has header-data split enabled, when
> the VF has a memory provider bound, or when the VF's driver has
> conditions of its own.
> 
> Reported by Sashiko during core rework. Unverified and untested.
> 
> Cc: stable+noautosel@kernel.org # untested fix to unlikely driver error path
> Fixes: 184367dce4f7 ("hv_netvsc: Fix XDP refcnt for synthetic and VF NICs")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  drivers/net/hyperv/netvsc_bpf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/net/hyperv/netvsc_bpf.c b/drivers/net/hyperv/netvsc_bpf.c
> index 1dd3755d9e6d..731bb7721fe2 100644
> --- a/drivers/net/hyperv/netvsc_bpf.c
> +++ b/drivers/net/hyperv/netvsc_bpf.c
> @@ -216,6 +216,13 @@ int netvsc_bpf(struct net_device *dev, struct netdev_bpf *bpf)
>  			netdev_err(dev, "vf_setxdp failed:%d\n", ret);
>  			NL_SET_ERR_MSG_MOD(extack, "vf_setxdp failed");
>  
> +			/* Since we haven't completed the installation
> +			 * of bpf->prog the reference core implicitly
> +			 * transfers to us on success isn't ours.
> +			 * Take a reference to balance the accounting.
> +			 */
> +			if (bpf->prog)
> +				bpf_prog_inc(bpf->prog);
>  			netvsc_xdp_set(dev, NULL, extack, nvdev);
>  		}
>  

The refcount part looks right to me.

Not new, but this rollback clears the channels rather than restoring
them. If the VF refuses a replace (P1 -> P2), or refuses the NULL on
detach (memory provider bound, mana failing to re-create its queues),
the core keeps P1 in xdp_state and the VF keeps running P1, but the
synthetic path is left with no program at all.

Could we save a reference to the old program before netvsc_xdp_set() and
restore it here instead of setting NULL? In patch 3/5
netvsc_unregister_vf() decides the take-back based on the channels, so
this matters there too.

-- 
Regards,
Kameron
