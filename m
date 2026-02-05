Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D8243CEDA;
	Thu,  5 Feb 2026 17:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770311680; cv=none; b=MyIx4DNvQaOTdbD9sd2dak51bF50iuUwwPod4MwnSMX/ISGokebKtgSd85UEqgaZasRfTt5l6MakYLRM+8ObcLX7eVJHQAEPSstYpq2YXnC+gysnmouHOgZPPzNEnNyRCLbcHZOEzSCy2ZwfGpkAFayoJWBUAPoZ2ZUV6Powyf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770311680; c=relaxed/simple;
	bh=//PquAWO58fi24r/fZbJVRtOM6XZ0Pl4qtd5wHhXnjI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyNtoqJqGjGL0c+Bt/+sVG5XSAm1SCDGYwsbwibMxTMq/W/POkGs3OE1cdJ5ReESZSTd6Q1sC4sgGTp1UdrDPALhnPh8mqX88/S+Nialj/MgFjAyhWWmQRdtDdfUIDWBvGVsqwuFjIGs9Q4CSqAiLLPaVFtZ1at/CVznxaUDrnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ath5KqjZ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ath5KqjZ"
Received: from skinsburskii.localdomain (unknown [52.148.138.235])
	by linux.microsoft.com (Postfix) with ESMTPSA id AEF8D20B7168;
	Thu,  5 Feb 2026 09:14:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AEF8D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770311679;
	bh=2i4ZSeIA7hu8g/5wqWmRxrmAdVWjpmG3ZIHPcGdGHo4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ath5KqjZV22ClIdHKVRUAsKsdBx/De6mQsBcDBhOfgheGbZ0vujdl22grmNEg+h0G
	 PfaYeFcRFxDNmsNZgq5KYb6ESm5Prp3RaY7xokHQGd757IFtc/mvh1htLu0kWe9BpL
	 SALnBOJfSKluewz2CnpLUZ1k7j3CH8uY6bcmqdoo=
Date: Thu, 5 Feb 2026 09:14:38 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: lirongqing <lirongqing@baidu.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: fix SRCU protection in irqfd resampler ack handler
Message-ID: <aYTP_sgl5fqQoaO8@skinsburskii.localdomain>
References: <20260205094010.4301-1-lirongqing@baidu.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205094010.4301-1-lirongqing@baidu.com>

On Thu, Feb 05, 2026 at 04:40:10AM -0500, lirongqing wrote:
> From: Li RongQing <lirongqing@baidu.com>
> 
> Replace hlist_for_each_entry_rcu() with hlist_for_each_entry_srcu()
> in mshv_irqfd_resampler_ack() to correctly handle SRCU-protected
> linked list traversal.
> 
> The function uses SRCU (sleepable RCU) synchronization via
> partition->pt_irq_srcu, but was incorrectly using the RCU variant
> for list iteration. This could lead to race conditions when the
> list is modified concurrently.
> 
> Also add srcu_read_lock_held() assertion as required by
> hlist_for_each_entry_srcu() to ensure we're in the proper
> read-side critical section.
> 

Thank you.

Acked-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> ---
>  drivers/hv/mshv_eventfd.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index 0b75ff1..6d176ed 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -87,8 +87,9 @@ static void mshv_irqfd_resampler_ack(struct mshv_irq_ack_notifier *mian)
>  
>  	idx = srcu_read_lock(&partition->pt_irq_srcu);
>  
> -	hlist_for_each_entry_rcu(irqfd, &resampler->rsmplr_irqfd_list,
> -				 irqfd_resampler_hnode) {
> +	hlist_for_each_entry_srcu(irqfd, &resampler->rsmplr_irqfd_list,
> +				 irqfd_resampler_hnode,
> +				 srcu_read_lock_held(&partition->pt_irq_srcu)) {
>  		if (hv_should_clear_interrupt(irqfd->irqfd_lapic_irq.lapic_control.interrupt_type))
>  			hv_call_clear_virtual_interrupt(partition->pt_id);
>  
> -- 
> 2.9.4
> 
