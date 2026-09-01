Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5AA472530;
	Tue,  1 Sep 2026 22:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788303368; cv=none; b=cqks2DgzOSrpL8jazGmuyQQ+5TvIsS8nl2492KRi/F0NEUNvNStf/SuP20bOfvs1FuZHdxqhSlmXe1ccwsMyi3YYx3z6u6Td7CCyWo4smxWvghAsTQNMTYXk45n4yng6Lyy0OXoY6wqJXBRQpESLOslrcO/fcCF7q0yoRYscOq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788303368; c=relaxed/simple;
	bh=s+q459yaN0F55+u/je5aCNFYxAThkd8ArmeHWDZ0wiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fActWntNSAZyx1IY8DdctotMLgYyvWZl8+KK8h4HGNdE91u+PL4bA/YyFNzpI4tJthNqZdIAJoNiXJW6s2Jo3ME2zBHD5AazBkC7F2zSZ5Y12hYObdXTv5zRBKeJr7u7jvMmTpBRMF+MxQry242ZtgRUJUplIdFJeL+TBH3zd+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XO7rRgPY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XO7rRgPY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 292081F00A3D;
	Tue,  1 Sep 2026 22:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788303367;
	bh=IDp+efHeDEGLzMGKCGDhAFfyBmcn87nrQlkYRT8DJw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XO7rRgPY6fPyhnXwuX7jKevwJyoThN1v0+xO9JxwWkl3iNs9yLoCd7ZW1T38NneBt
	 Mwj/3jv6BtulAtHHPvRxspGw9K1YtP+RDhlTwDkrWSNf4aV07HUc1X3Q53K8uFluOq
	 SbWBLJKJEWENqk/n2HNEfECErD+8oy0E5qNQaywq3WzfeMM4TOSs6o8+pp9lTsn54s
	 Hyjr1YwynoCbJCn9Hesg8vLfrAcP2IQNXQdRriloXpgXJWUDrnR1gSEYO94MIC74BX
	 aywZVwHuuviIBXbN/lFm2q7+e0Ygwt0uvN4Sz26ZEtdnS/Ie8HH47g5iNxqboxjENR
	 hgkUt9Zt3x/XQ==
Date: Tue, 1 Sep 2026 15:56:06 -0700
From: Wei Liu <wei.liu@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: Thara Gopinath <tgopinath@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, Wei Liu <wei.liu@kernel.org>
Subject: Re: [RFC PATCH 02/12] drivers: hv: hv_common: Allocate Hyper-V
 output arg page when VSM is enabled
Message-ID: <20260901225606.GA2583463@liuwe-devbox-debian-v2.local>
References: <20260901165647.3160413-1-tgopinath@linux.microsoft.com>
 <20260901165647.3160413-3-tgopinath@linux.microsoft.com>
 <20260901171238.834601F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260901171238.834601F00A3A@smtp.kernel.org>

On Tue, Sep 01, 2026 at 05:12:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] hv_apicid_to_vp_index() unconditionally dereferences the unallocated hyperv_pcpu_output_arg pointer in standard/SNP guests.
> --
> 
> commit 0ee3313e113c9ca7969923f2af5a1ed18ddb25d2
> Author: Thara Gopinath <tgopinath@linux.microsoft.com>
> 
> drivers: hv: hv_common: Allocate Hyper-V output arg page when VSM is enabled
> 
> This commit extends hv_output_page_exists() to return true when 
> CONFIG_HYPERV_VSM is enabled. This ensures the per-CPU output argument
> page is allocated at boot for VSM hypercalls.
> 
> > diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
> > index 31256cb22b39e..44f4a10984618 100644
> > --- a/drivers/hv/hv_common.c
> > +++ b/drivers/hv/hv_common.c
> > @@ -259,7 +259,8 @@ static void hv_kmsg_dump_register(void)
> >  
> >  static inline bool hv_output_page_exists(void)
> >  {
> > -	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
> > +	return hv_parent_partition() || IS_ENABLED(CONFIG_HYPERV_VTL_MODE) ||
> > +		IS_ENABLED(CONFIG_HYPERV_VSM);
> 
> [Severity: High]
> This is a pre-existing issue, but modifying this function highlights a
> vulnerability for SEV-SNP guests where VSM and VTL modes are disabled.
> 
> When an SEV-SNP guest boots secondary CPUs, hv_smp_prepare_cpus() overrides
> the wakeup callback with hv_snp_boot_ap(), which then calls
> hv_apicid_to_vp_index() in arch/x86/hyperv/ivm.c.
> 
> If CONFIG_HYPERV_VSM and CONFIG_HYPERV_VTL_MODE are both disabled,
> hv_output_page_exists() evaluates to false. This means hyperv_pcpu_output_arg
> is never allocated during hv_common_init() and remains NULL.
> 
> Consequently, arch/x86/hyperv/hv_init.c:hv_apicid_to_vp_index() dereferences
> this unallocated pointer:
> 
> arch/x86/hyperv/hv_init.c:hv_apicid_to_vp_index() {
>         ...
>         output = *this_cpu_ptr(hyperv_pcpu_output_arg);
>         ...
>         status = hv_do_hypercall(HVCALL_GET_VP_ID_FROM_APIC_ID, input, output);
>         ...
> }
> 
> Since this_cpu_ptr(NULL) resolves to the base of the per-CPU area, it
> dereferences a garbage pointer. This is then passed to hv_do_hypercall(),
> causing the hypervisor to overwrite random physical memory with the hypercall
> result, and eventually oopsing the kernel when output[0] is read.
> 

This looks like a real bug. It should / will be fixed separately.

Wei
