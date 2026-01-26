Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518BC2D7DFE;
	Mon, 26 Jan 2026 20:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769460407; cv=none; b=qujvxqUP1wz05eDp/2HEL5QTFjbNTFPy+i4osJhNKPUYK2uutwSrJ0pUKbluFvuoJ28UtC88mYjAiatar+Ef6g2ErHQb2ylQvgSdOyrWUsa5rbmxA8pwBwsd8NjDyy+2VuHIK+2onyQXVKEW11A2FtnbmqW6Jnez9cbvFqqx4ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769460407; c=relaxed/simple;
	bh=/Rt3uFgkEFvsJSuQhBDn6jiR3OsdxS1YKHgUSbmeIA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WZ/2qJALWa71omyRuaVCWZOmQ4VXKc+f3kPVm2OJ3gBVECO23y15MX1OYdakhRIjv72kZNTF7kkEg0Rf0H+CAnZC8FdgWqeYXPZAKKdnMeiGKV1R4an+mcqimmj7YW2Efk4oRxwdGgwxIDE3S3r/1UL9qkpzwV+SFisxe23AiXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mbRsZlpt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mbRsZlpt"
Received: from skinsburskii.localdomain (c-98-225-44-182.hsd1.wa.comcast.net [98.225.44.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C630320B7165;
	Mon, 26 Jan 2026 12:46:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C630320B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769460405;
	bh=iF2f2ql0FFriZuZkNbddybQR7oFP1PFZ4G3/LKW5c9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mbRsZlpt0ITUS5IhH+eleS3f+Agfs3ini8ZcXPI04jsSOeyMpwVdaVE+OhCHweR0g
	 YImMU7ZE7C2vLKQtxoGydwvLSWTQwiaqkAOXDXt2xnE1vT1Mwa57ayy1q6XSWuJPLO
	 /Ml4AZfaIMzLFlP2UDO+I6ucISBG9cFK6Cdf8wSg=
Date: Mon, 26 Jan 2026 12:46:44 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
Message-ID: <aXfStKqKiSSHEmXj@skinsburskii.localdomain>
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xyzkeqng3767mlpzu7xbmgobjr6ob2wp2brocmjczbbl4dypxh@wkibga46f33c>

On Tue, Jan 27, 2026 at 12:19:24AM +0530, Anirudh Rayabharam wrote:
> On Fri, Jan 23, 2026 at 10:20:53PM +0000, Stanislav Kinsburskii wrote:
> > The MSHV driver deposits kernel-allocated pages to the hypervisor during
> > runtime and never withdraws them. This creates a fundamental incompatibility
> > with KEXEC, as these deposited pages remain unavailable to the new kernel
> > loaded via KEXEC, leading to potential system crashes upon kernel accessing
> > hypervisor deposited pages.
> > 
> > Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> > management is implemented.
> 
> Someone might want to stop all guest VMs and do a kexec. Which is valid
> and would work without any issue for L1VH.
> 

No, it won't work and hypervsisor depostied pages won't be withdrawn.
Also, kernel consisntency must no depend on use space behavior. 

> Also, I don't think it is reasonable at all that someone needs to
> disable basic kernel functionality such as kexec in order to use our
> driver.
> 

It's a temporary measure until proper page lifecycle management is
supported in the driver.
Mutual exclusion of the driver and kexec is given and thus should be
expclitily stated in the Kconfig.

Thanks,
Stanislav

> Thanks,
> Anirudh.
> 
> > 
> > Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> > ---
> >  drivers/hv/Kconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> > index 7937ac0cbd0f..cfd4501db0fa 100644
> > --- a/drivers/hv/Kconfig
> > +++ b/drivers/hv/Kconfig
> > @@ -74,6 +74,7 @@ config MSHV_ROOT
> >  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
> >  	# no particular order, making it impossible to reassemble larger pages
> >  	depends on PAGE_SIZE_4KB
> > +	depends on !KEXEC
> >  	select EVENTFD
> >  	select VIRT_XFER_TO_GUEST_WORK
> >  	select HMM_MIRROR
> > 
> > 
