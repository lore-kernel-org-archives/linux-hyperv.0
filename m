Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABFBC456DFB;
	Thu, 23 Jul 2026 16:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784825912; cv=none; b=UlKrU8DQt4DxNW7D7GBnn8wT8lRzVaF1Dg5FJhJVWG4LqVjZjqHsp2001kAu6duZJzKd3vT/wxA/dN1knw77+9adVYvq4b5scsuvPUqBaDGPr/JgFNao9retRl3u5BeMsKNABwEItwZJ+SodtCxbynn4ZlK6T10vwn4UK178Tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784825912; c=relaxed/simple;
	bh=ImsTXP5GEh/KZwpwGzfkZjUKmy7KsyvFZjA8CNOSBSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YK290S9tCRiX3Yloou7JxTxKInAiUgwodP4ls5SsOK7xY2vRB4UtpBRxVnctlatCVfqasawsOsI9rnVpVNB5/IUZV6WjFGAD42bDQSg+H/9G+qgBF8ZWCTLeEEs1FhcEqFJO4x+KBHi3TiLv8I7+M0RnWe/NoM7uTziZ7FSPoi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwHkfhTe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwHkfhTe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B261F000E9;
	Thu, 23 Jul 2026 16:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784825901;
	bh=d2U8evFVS8UUgdyNXEaWnwZRMLayCWAZsMQ2h5+G3u4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=iwHkfhTeRfJMCNAzuHQ3+wBQH1dvP7IxufNSLYd1HBKzUKuGi8kIOM2aVaUcRo0WW
	 MyamhdIp07vX0mpIGDy3smzqWGvgUZ633WLISds/nHJNgjO/yDQoKvesJHgOyIhU7j
	 /irvAshTROJLURp2MYyfSD1s8EeYE54QqebnlCQDeKf95NY9olKbig+745wakWkkc/
	 ZtR8sfyA9ODDIkBWuloaN6aTuHbn91WPt9tysnkIxS6Ju6swgPxbD2F9Ery/qkwfMC
	 G9AmHmMwR/uVwMklCWjmgHoYvMxQUH+NrkZTTezkaifXmrWaTFS3uCVnptY2vC0jAw
	 NIpV+taU7Mytw==
Date: Thu, 23 Jul 2026 09:58:19 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: Yi Xie <xieyi@kylinos.cn>, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: bounds-check cpu index in vtl mmap fault handler
Message-ID: <20260723165819.GJ2020652@liuwe-devbox-debian-v2.local>
References: <20260709021947.49436-1-xieyi@kylinos.cn>
 <eb6113fc-4fc8-4f28-8dfc-121cf6de5abd@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb6113fc-4fc8-4f28-8dfc-121cf6de5abd@linux.microsoft.com>

On Thu, Jul 23, 2026 at 02:37:51PM +0530, Naman Jain wrote:
> 
> 
> On 7/9/2026 7:49 AM, Yi Xie wrote:
> > cpu is taken from pgoff & 0xffff.  cpu_online() does not reject cpu >=
> > nr_cpu_ids, and per_cpu_ptr() can then walk off __per_cpu_offset.
> > 
> > Signed-off-by: Yi Xie <xieyi@kylinos.cn>
> > ---
> >   drivers/hv/mshv_vtl_main.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> > index 0d3d4161974f..fc50c44ac1bd 100644
> > --- a/drivers/hv/mshv_vtl_main.c
> > +++ b/drivers/hv/mshv_vtl_main.c
> > @@ -801,7 +801,7 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
> >   	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
> >   	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
> > -	if (!cpu_online(cpu))
> > +	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
> >   		return VM_FAULT_SIGBUS;
> >   	/*
> >   	 * CPU Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.
> 
> The problem fixed by this patch generally does not happen in practice as the
> user space is trusted user space (OpenVMM). Nevertheless, it's good to have
> this check.
> 
> Nit: subject - s/"mshv:"/"mshv_vtl:"
> as this was the agreed upon prefix for changes to mshv_vtl_main driver.
> 
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Thank you. Applied.
