Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8D720F067;
	Wed, 11 Feb 2026 23:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770852656; cv=none; b=W0+oX+jImrex1/U5ln/YPUme4efjLoSNCy5csz2slCa5v1pChhXI5mEZQw/42pZBURpBLYEnRZNVx2mez5wT71pVgopkmrrQ/5udzY+4wYaA5dTqg4E1LNGs9+vG0aEAzcbhFR9AQaUU8s6XjuRoPlO2t6XbPag9oSWqmrpTi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770852656; c=relaxed/simple;
	bh=DVvyZqvwMlqPbJooJp4va8JTCF/7GxzDL1ZwzA+ZyNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VkW2BjRDrobrJBlAYDraZ8LWotGinbgi6L93Yn2XnSO4bT5DQLxpNugFJma7yNGadP2fOIPsifGR9FiVp5dhFJztluXi43m8ZuOr407er/Isv3HGA3GnbRbYIBPVOgdtyblU/161s2Wfug5+NPmMaFD4rZh7jp8vtfaiWhUO6Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gkoJY9Vf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gkoJY9Vf"
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AF3320B7165;
	Wed, 11 Feb 2026 15:30:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AF3320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770852653;
	bh=vVkPJxeFqre8GXwMKfPL88jdlevbQ2wGI8hai57pULU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gkoJY9VfrcOLuh7kU2526UYX5qYs3LgDqlnRjZ84vbbshTIGKI+tgzSdzYpzx70hU
	 9CojwoyBQ6CaCs+rAIiRjttwRiJV7NCvxtqu8t2h3APukDX54kAfxUjyLD63vQeSXk
	 /x/HtZuhWq8zqNS8GuosfWl+UoU7IWni0Qia7Trg=
Date: Wed, 11 Feb 2026 15:30:51 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: rppt@kernel.org, akpm@linux-foundation.org, bhe@redhat.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com
Cc: kexec@lists.infradead.org, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] kexec: Refuse kernel-unsafe Microsoft Hypervisor
 transitions
Message-ID: <aY0RK8cADz3MkUdY@skinsburskii.localdomain>
References: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <176962149772.85424.9395505307198316093.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Wed, Jan 28, 2026 at 05:41:56PM +0000, Stanislav Kinsburskii wrote:
> When Microsoft Hypervisor is active, the kernel may have memory “deposited”
> to the hypervisor. Those pages are no longer safe for the kernel to touch,
> and attempting to access them can trigger a GPF. The problem becomes acute
> with kexec: the “deposited pages” state does not survive the transition,
> and the next kernel has no reliable way to know which pages are still
> owned/managed by the hypervisor.
> 
> Until there is a proper handoff mechanism to preserve that state across
> kexec, the only safe behavior is to refuse kexec whenever there is shared
> hypervisor state that cannot survive the transition—most notably deposited
> pages, and also cases where VMs are still running.
> 
> This series adds the missing kexec integration point needed by MSHV: a
> callback at the kexec “freeze” stage so the driver can make the transition
> safe (or block it). With this hook, MSHV can refuse kexec while VMs are
> running, attempt to withdraw deposited pages when possible (e.g. L1VH
> host), and fail the transition if any pages remain deposited.
> 
> ---
> 
> Stanislav Kinsburskii (2):
>       kexec: Add permission notifier chain for kexec operations
>       mshv: Add kexec blocking support
> 

Hi,

I’m sending a gentle follow‑up on the patch series below, which I posted
about two weeks ago. I wanted to check whether anyone has had a chance
to look at it, or if there are concerns I should address.

Any feedback would be appreciated.

Thanks for your time.

Best regards,
Stanislav

> 
>  drivers/hv/Makefile            |    1 +
>  drivers/hv/hv_proc.c           |    4 ++
>  drivers/hv/mshv_kexec.c        |   66 ++++++++++++++++++++++++++++++++++++++++
>  drivers/hv/mshv_root.h         |   14 ++++++++
>  drivers/hv/mshv_root_hv_call.c |    2 +
>  drivers/hv/mshv_root_main.c    |    7 ++++
>  include/linux/kexec.h          |    6 ++++
>  kernel/kexec_core.c            |   24 +++++++++++++++
>  8 files changed, 124 insertions(+)
>  create mode 100644 drivers/hv/mshv_kexec.c
> 
