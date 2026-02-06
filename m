Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDFD30AD06;
	Fri,  6 Feb 2026 07:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770361575; cv=none; b=bXyCMImlRnWrgE3A1n+s/CP1k45vuJtDeiq+2Kojqro4Uat/AakemcJvdY2E8kA1imCc5qJMz6UlMgPCKou+PVm/F24ALd3DlW5CNRG9/+/RPt5uvzmD1YYsfldb13uDwNjEmnbIQly2apvuYIT30HAw+K64NJ3xL87YTt5F+lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770361575; c=relaxed/simple;
	bh=9MREmfRKgXOB0rR/neOcsI+SDmg3AvOh0poaMMQePqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V98LgpkaYh0+NIDsGi66BuT2UldcNx2CU3bsbIFfPhh8P0MCZ67+PtSpw58NCMEhKoLd3HIEdCaoqKUg49PJxhD2Sq5VDEDhx/p3l6ynKILikrwVyEtgClvtMwxeExeCdslTSMC7DczjmCkUGKY19960LA9YQpkzQY1AVBa4lnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtiETBFd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtiETBFd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C541C2BC9E;
	Fri,  6 Feb 2026 07:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770361575;
	bh=9MREmfRKgXOB0rR/neOcsI+SDmg3AvOh0poaMMQePqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QtiETBFd32z8V0oYRw6wla9e/+iwp5pi7VuMEMZcY3+JCJ5WwtC+RHkPARpAA0y+/
	 nvSptxPvUZMMmZPnD4ewLVz8wT8uqk3FUxzEHAe46u/hwX7iCU+qhaC7746ZdE1fzx
	 F2djCuwuXDHflEtIR/EUYDJ6E+EswbpY4h4WWFiWfZhmKf2HDI2t3HhTUAvYAiaey8
	 QNm76yzJvJrSbuDi8kmDmQRVaqyPrmqQVvl7wA3tG2vyCTqmaOuXuRmSzOhY7H6xly
	 ikVVukiITNrBMmvyCL5CnXELf1teReVomwPPsEdDhM2sTljkc8EsGpmv9fexDv9eDb
	 a50WgGiHV1k+w==
Date: Fri, 6 Feb 2026 07:06:13 +0000
From: Wei Liu <wei.liu@kernel.org>
To: lirongqing <lirongqing@baidu.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: fix SRCU protection in irqfd resampler ack handler
Message-ID: <20260206070613.GB691451@liuwe-devbox-debian-v2.local>
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
> Signed-off-by: Li RongQing <lirongqing@baidu.com>

Thank you for the patch. Applied.

I also added a Fixes tag to the commit message.

Fixes: 621191d709b14 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")

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
