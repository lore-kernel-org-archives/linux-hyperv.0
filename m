Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C813806D7;
	Wed,  4 Feb 2026 06:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187439; cv=none; b=SmpGWBQSxs9nJwM8zjXbDukVMZDir8T5vZaHWEXVWUbCzD2gh5PKbBvAGc1pU0OocSelCbmll1nW7i2llGJo1v2Iixte2SKs3tv0xyYUliph+3c+4C5Q52TXopiGTdcTRXGKx4inozulrYNMzzorlR9ui2Djjpu4obowklK5n9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187439; c=relaxed/simple;
	bh=4VpQFex8bzq5hKWM9W44OMFdMgrds5btT7Yy0N2cwu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PTZTzR/sURr/MYUtvNt3/pyjBbHWpJJHwhDPGoR55sO7ZyH26QAClK2BBtuqb3y8fWe5YtBYyqRZfJhn681WUSEaB92hsXvM3OrNGHnDkZ4lCsxFv1ATNbNVeMr9LOGIRvWD5vmKaN+JmmKmMe9MdHFAzoNayDHW8S+7MpCUTrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxjoYlIo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxjoYlIo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF7CC4CEF7;
	Wed,  4 Feb 2026 06:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770187438;
	bh=4VpQFex8bzq5hKWM9W44OMFdMgrds5btT7Yy0N2cwu8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YxjoYlIoUNCqcOZDxuxdvf5E7X4UhCKo/RYjyMBR5Rl4egl8bTuM7OBKLygbm8U63
	 05Tye3cI404IxL+Z0D8eRrwjXa4bfwvf7phR07hQrm0RgQBV2xL42503PuuVdxw1So
	 XPLwKZCJtyJeAFXZHP3ZKvAK+DU296B3Jt1o0cqLZl6c9WvcrKALbTgUJ79RuApPCU
	 CaosGhjtNi3LPu4UKaMcdNLoZ4LwpCp4dDBJWBbonjWxzgPU9HazFnarAxxJRfYHMt
	 YMwlabaqLhnennLeKsnhceNmsas33AzG04jBK/hYoUVZagtAjJXjxHqQ6mzQEr3Kgx
	 mqA4z3BtOYDWw==
Date: Wed, 4 Feb 2026 06:43:57 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Carlos =?iso-8859-1?Q?L=F3pez?= <clopez@suse.de>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	open list <linux-kernel@vger.kernel.org>,
	skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com,
	anirudh@anirudhrb.com, schakrabarti@linux.microsoft.com
Subject: Re: [PATCH] mshv: clear eventfd counter on irqfd shutdown
Message-ID: <20260204064357.GK79272@liuwe-devbox-debian-v2.local>
References: <20260122114130.92860-2-clopez@suse.de>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260122114130.92860-2-clopez@suse.de>

On Thu, Jan 22, 2026 at 12:41:31PM +0100, Carlos López wrote:
> While unhooking from the irqfd waitqueue, clear the internal eventfd
> counter by using eventfd_ctx_remove_wait_queue() instead of
> remove_wait_queue(), preventing potential spurious interrupts. This
> removes the need to store a pointer into the workqueue, as the eventfd
> already keeps track of it.
> 
> This mimicks what other similar subsystems do on their equivalent paths
> with their irqfds (KVM, Xen, ACRN support, etc).
> 
> Signed-off-by: Carlos López <clopez@suse.de>

This looks like a good change to me. I've queued it to hyperv-next.
Thanks!

Also CC our kernel folks just in case I missed something.

Wei

> ---
>  drivers/hv/mshv_eventfd.c | 5 ++---
>  drivers/hv/mshv_eventfd.h | 1 -
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_eventfd.c b/drivers/hv/mshv_eventfd.c
> index d93a18f09c76..4432063e963d 100644
> --- a/drivers/hv/mshv_eventfd.c
> +++ b/drivers/hv/mshv_eventfd.c
> @@ -247,12 +247,13 @@ static void mshv_irqfd_shutdown(struct work_struct *work)
>  {
>  	struct mshv_irqfd *irqfd =
>  			container_of(work, struct mshv_irqfd, irqfd_shutdown);
> +	u64 cnt;
>  
>  	/*
>  	 * Synchronize with the wait-queue and unhook ourselves to prevent
>  	 * further events.
>  	 */
> -	remove_wait_queue(irqfd->irqfd_wqh, &irqfd->irqfd_wait);
> +	eventfd_ctx_remove_wait_queue(irqfd->irqfd_eventfd_ctx, &irqfd->irqfd_wait, &cnt);
>  
>  	if (irqfd->irqfd_resampler) {
>  		mshv_irqfd_resampler_shutdown(irqfd);
> @@ -371,8 +372,6 @@ static void mshv_irqfd_queue_proc(struct file *file, wait_queue_head_t *wqh,
>  	struct mshv_irqfd *irqfd =
>  			container_of(polltbl, struct mshv_irqfd, irqfd_polltbl);
>  
> -	irqfd->irqfd_wqh = wqh;
> -
>  	/*
>  	 * TODO: Ensure there isn't already an exclusive, priority waiter, e.g.
>  	 * that the irqfd isn't already bound to another partition.  Only the
> diff --git a/drivers/hv/mshv_eventfd.h b/drivers/hv/mshv_eventfd.h
> index 332e7670a344..464c6b81ab33 100644
> --- a/drivers/hv/mshv_eventfd.h
> +++ b/drivers/hv/mshv_eventfd.h
> @@ -32,7 +32,6 @@ struct mshv_irqfd {
>  	struct mshv_lapic_irq		     irqfd_lapic_irq;
>  	struct hlist_node		     irqfd_hnode;
>  	poll_table			     irqfd_polltbl;
> -	wait_queue_head_t		    *irqfd_wqh;
>  	wait_queue_entry_t		     irqfd_wait;
>  	struct work_struct		     irqfd_shutdown;
>  	struct mshv_irqfd_resampler	    *irqfd_resampler;
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
> -- 
> 2.51.0
> 
