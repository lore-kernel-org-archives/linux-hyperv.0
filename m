Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C53ACA52;
	Wed, 27 May 2026 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779920824; cv=none; b=LiSbQhKo6L4wf9/r+scbdBtn6cmRvjXTroBNc+SsVxmDplwpXfBheeE35L2d4JYEpKEltZo21vB3CfnMltiMsRWmqXDK9v1qSeJaRFMChoOigEHE0djnrQez2TU8g7FFR5MWB6XgexD88jygQ4r1PmO6ZNfVBWYaZJYY1njOMGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779920824; c=relaxed/simple;
	bh=YYPQMaGSOGCyGuRgQ6KkRhpV3psyeiFtLHhVoR8l9Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YClYQ9IQ49YOOOYjG2PcWn7gKNcMJnM85N4NTUmLtyZC6B7CsqInY2eRtW5SDOg2QwMLQJ7xdLm/gbUMudv8He6+KV78zMHwni2AmrtbqK90yB9C2tORZY/vuCbmIrpbBj4Xvn3ei8vhh+U3xAhF/wB8vQEtOFAS//Gr/Mldp4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z7MNn1du; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z7MNn1du"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F2A1F000E9;
	Wed, 27 May 2026 22:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779920823;
	bh=Kq/Q4+ThDF9dZrfshBxHg+q9mvQxgCwlhQwNZ+X8Gq4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Z7MNn1duO1R/t0/sEGLYNEsPcq6ssgXk061l88FLtPgHwJ3NHhnZ+F/v5pgK7D55E
	 isErcKuQ+Y0eeIr/L7BQWcT0w3jQFGRrAx+MYyx+Cvp2p8f+dtucVILdj2q24cDlSo
	 gpoIIpcIiLvT4zl7uYcHVtRXftRJ9RbbFMIoG20+CxPhy3MlaZONsy0wqERu9xE5AG
	 h6rG8kYBe6fFMfj433pnNIFibs6Qj8jWq736BPVYvfwgD8pohHbt9SZNI6p/ix9+Vp
	 D400aQzsPEtBFDo/GqXjaOeIDny0PB6uSlh7zIUi/kFudpxrHzUKGfi5Sg8DlOapwz
	 8ReQcQmgudsUQ==
Date: Wed, 27 May 2026 15:27:01 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Can Peng <pengcan@kylinos.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, decui@microsoft.com,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] drivers: hv: use kmalloc_array in
 mshv_root_scheduler_init
Message-ID: <20260527222701.GC3518940@liuwe-devbox-debian-v2.local>
References: <20260520071632.557990-1-pengcan@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520071632.557990-1-pengcan@kylinos.cn>

On Wed, May 20, 2026 at 03:16:32PM +0800, Can Peng wrote:
> Replace kmalloc() with kmalloc_array() to prevent potential
> overflow, as recommended in Documentation/process/deprecated.rst.
> 
> Signed-off-by: Can Peng <pengcan@kylinos.cn>
> ---
>  drivers/hv/mshv_root_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index bd1359eb58dd..146726cc4e9b 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -2241,7 +2241,7 @@ static int mshv_root_scheduler_init(unsigned int cpu)
>  	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
>  
>  	/* Allocate two consecutive pages. One for input, one for output. */
> -	p = kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
> +	p = kmalloc_array(2, HV_HYP_PAGE_SIZE, GFP_KERNEL);

HV_HYP_PAGE_SIZE is a constant (4096). We don't have any dynamism in code.
There is zero potential for overflow.

That being said, I'm fine with taking this patch to stay consistent with
the document.

Thanks for your contribution.

Wei


>  	if (!p)
>  		return -ENOMEM;
>  
> -- 
> 2.53.0
> 
