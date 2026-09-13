Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF52370ACC;
	Sun, 13 Sep 2026 22:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789338870; cv=none; b=rQ9siMP4UpsDFnl1NMEKO7C2dHoAD3A4cQeqT7dMWAn74Ist9A3ApTioXoycL69mavmTgxkplVmMs1jLoekqVR296bvqAJWscCZ/ubD5tQ8n7UZ5RSTBtF2/XfFgyZxtth6vSrY63l3W1h0Fc+AsGPTqqwsmlcvp74bM8shqxC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789338870; c=relaxed/simple;
	bh=uV6gjQ0klV+cLZJoC4pLY6n4dRtgeBwjwpg8qKG7sr8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IydSMRGKpiFjCnyHWD/vFZaMBzjk9IICwexD9fNuubDkMeWkA/cQoJ9FeimB7+Occg21IyMvYfFwEMldfoTrVuvItf671KdxoccyRwR+LcNvKx4zQam9/LAbY5d0ScJfqoN17EB+dZPxczayZG25StMN+thgaATAQwncmoP1nPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dce+XBrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dce+XBrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E84E1F000FF;
	Sun, 13 Sep 2026 22:34:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789338867;
	bh=GpCLsVbQG/jHbWLtz2xUn5/UGi0T7hOeGp6JgMKn2uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=dce+XBrvDp4BeQiGdsiDnwlLrwzYDiDXS+Ysx0FQvwAzSulBoBDsov/HnBOEXSZ63
	 Ou/ePDAqyQdOYfMaVY+LSZvJw+PhStpiLAaVXAa8b0/0i/YEMgxY/Is5bckv/U3KJR
	 MgOizWQTS2jYSSLghHCeiO3L2n41ghmHbgZ++OIGlWVTHWVln6VVkFMFbAN9yBzZMK
	 Cz3aHSwudNUY8PbWw6nscXiUsdt5vRVnDc1jDehXd86UYAYMT9hySul6l32eEqngGw
	 XtAmai02KYDXoUCo9Tl8aj/+sbIM6NDxY1AGMy1OUX/UbbwKNv/mQHFLf8C/LhyqeQ
	 KSvaUXv/Y5jdQ==
Date: Sun, 13 Sep 2026 15:34:26 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Michael Kelley <mhklinux@outlook.com>
Cc: Waiman Long <longman@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] Drivers: hv: Avoid infinite retry loop in
 init_vp_index()
Message-ID: <20260913223426.GB2219269@liuwe-devbox-debian-v2.local>
References: <20260830234124.878502-1-longman@redhat.com>
 <SN6PR02MB41574F4E654477ADF0242F4AD4A92@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB41574F4E654477ADF0242F4AD4A92@SN6PR02MB4157.namprd02.prod.outlook.com>

On Mon, Aug 31, 2026 at 01:25:23AM +0000, Michael Kelley wrote:
> From: Waiman Long <longman@redhat.com> Sent: Sunday, August 30, 2026 4:41 PM
> > 
> > There is a retry loop in init_vp_index() where the CPUs from a certain
> > node are stripped out if they have already been in the allocated cpumask
> > or not in HK_TYPE_MANAGED_IRQ housekeeping cpumask. If there is no
> > CPU left, the allocated cpumask is ignored and the process is retried
> > again. However, if the HK_TYPE_MANAGED_IRQ housekeeping cpumask turns
> > out not to contain any CPU in that particular node, that will become an
> > infinite retry loop.  This particular problem was reported by sashiko
> > [1]. This should rarely happen, but we still need to guard against this.
> > 
> > Fix this infinite loop problem by also skipping NUMA node that has no
> > housekeeping CPU in the inner while loop of init_vp_index(). Also update
> > the early abort check to check for the absence of online housekeeping
> > CPUs instead of just the emptiness of the cpumask. As the outer for
> > loop will only be reached if the housekeeping cpumask has at least one
> > online CPU, a NUMA node with housekeeping CPUs will eventually be found.
> > 
> > Link: https://sashiko.dev/#/message/20260422030903.E1BFCC2BCB0%40smtp.kernel.org [1]
> > Fixes: 6640b5df1a38 ("Drivers: hv: vmbus: Don't assign VMbus channel interrupts to isolated CPUs")
> > Signed-off-by: Waiman Long <longman@redhat.com>
> > ---
[...]
> 
> Looks good.
> 
> Reviewed-by: Michael Kelley <mhkelley@outlook.com>

Applied. Thank you both.

Wei

> 
