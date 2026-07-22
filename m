Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AC3E16B9;
	Wed, 22 Jul 2026 22:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758965; cv=none; b=rdzyZ61BH9CuDMRgPV+caCZNBtJrCY3PyfLVQEkkFyBy7MUQfvHvvYQBafO3VmbDkDOiQptpRYB5y9xVDKXHrl2plPMeqv9cGMwNf8H+T/UNM9sYvd8JiFxiTL7xbXNQCmmVGHW1OPaDYJO8qqTOIVjXxpjDYmGwxtu1yXM8GBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758965; c=relaxed/simple;
	bh=uMM0K6h13mRT4qd3LJFybaloSN042umavFZF8qQs0zE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1F/YYE3sZjY6ELWKgU1ADJZKb6B6NCN+AGuvWd0g2VmBCOMMj2/R60qH0RbnsIRB6/mmtAT7SjD/2+pcm47Y7i2poNrH8XK5aUy4isddtk321RPY8g0qZVAC3r/E3elwEiQq95+O/DqWMatUR+ajfwBgi9NID+j8EKR/RfjWIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2UgxxU+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2UgxxU+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D521F000E9;
	Wed, 22 Jul 2026 22:22:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758963;
	bh=j8gaegb2ADazUievQZINPp/IpA+QVcS+ZZIOnHBDajY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=R2UgxxU+RZSaXBEAnixwp5KiatVzsOYN0fmO/ILHLnVJt2WXSLURaO1Rfp9fbhPYd
	 04vEddE2AlR+cPaBgU+/yTBfaTeaY9myA2YbLF5cxWsXZ62Ap0wQMVmgaIMoli021t
	 wXMSEkVT25I7hwv733wajE2KfQEQvpC1u+GpI6EZEXKkfiYyZeean+pXkC62RO+xc+
	 yi/Q+r1pE6/emrbeFG/6eUiSpVcuRPtWn5D7AYhA1zrZtSVwSL0lmHRXFd7olSwE00
	 Zsd1lNCPS4+k1YqNBKvRJmmmdFKpk8uEaL9ZbnostdkX100hriJby0Zo9N2HGtf4s8
	 e8wZrR2Q7MAiw==
Date: Wed, 22 Jul 2026 15:22:42 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Yi Xie <xieyi@kylinos.cn>, ssengar@microsoft.com,
	namjain@linux.microsoft.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: bounds-check cpu index in vtl mmap fault handler
Message-ID: <20260722222242.GF2020652@liuwe-devbox-debian-v2.local>
References: <20260709021947.49436-1-xieyi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709021947.49436-1-xieyi@kylinos.cn>

Naman, Saurabh, please review this.

On Thu, Jul 09, 2026 at 10:19:47AM +0800, Yi Xie wrote:
> cpu is taken from pgoff & 0xffff.  cpu_online() does not reject cpu >=
> nr_cpu_ids, and per_cpu_ptr() can then walk off __per_cpu_offset.
> 
> Signed-off-by: Yi Xie <xieyi@kylinos.cn>
> ---
>  drivers/hv/mshv_vtl_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f..fc50c44ac1bd 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -801,7 +801,7 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
>  	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
>  	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
>  
> -	if (!cpu_online(cpu))
> +	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
>  		return VM_FAULT_SIGBUS;
>  	/*
>  	 * CPU Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.
> -- 
> 2.34.1
