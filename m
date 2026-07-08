Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 205A02D7BF;
	Wed,  8 Jul 2026 13:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515922; cv=none; b=Hk79hJX8zWw5/XWbSbvXPm9kWwfwq8GJq0Wr+qBJA3kOHhO+idepqSeuvc85YIhDwHDWueSxtM5bNqV8+3orma4WDEdMHHyPzk9lRFTRUKiFxsMkmfe9JVHD6gbN5cwtMnmzG2siDlN21MXRKvZBIK56GsILbATmRidSMQOfXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515922; c=relaxed/simple;
	bh=D80+sHK7oQ+gk/o/uHFNOev3aQMwbuQIuU8DjcxiGno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p7lPpZY75AMods4YddqqI3RYkmfAb8MhxglCUW7AenxrsXCMaCFsAUjWaEnK0iagnxb8d7Pj/OhvZQERh3vLZ7nhZPl7I+HUAEbvEUJ/K6AOGffSTgInpJ9xrneUhwC1d6FK0xlyPivlwQ77/T1ueebbtezLSScUE+1s0cATbJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=o5SMCqDd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="o5SMCqDd"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 16F2E20B7166; Wed,  8 Jul 2026 06:05:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16F2E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1783515916;
	bh=QWhOUjoq7glD3ulLx+EiI8YDgxzBwmTEbtliBi47jGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o5SMCqDdEnDKNnoi5nReXrmeA6sNVr+6tqanMAQVuwUMmmc8CyN41XEwYXahHMDIE
	 ugII6JjDkMAQYxPLCjp0zvvJry8V2StlUtPmtVn4ojNxLa9sACsurZA8tMUBtnXxCk
	 J8AVxuASMLmtM8priCqgTkXOEYxC4vrZbPKVlZ2Q=
Date: Wed, 8 Jul 2026 09:05:16 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Yi Xie <xieyi@kylinos.cn>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl()
Message-ID: <ak5LDBRXOVYTrZ9r@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260708012852.36824-1-xieyi@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708012852.36824-1-xieyi@kylinos.cn>

On Wed, Jul 08, 2026 at 09:28:52AM +0800, Yi Xie wrote:
> put_unused_fd() if anon_inode_getfile() fails.
> 
> Signed-off-by: Yi Xie <xieyi@kylinos.cn>

Reviewed-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

> ---
>  drivers/hv/mshv_vtl_main.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
> index 0d3d4161974f..897a41b08d02 100644
> --- a/drivers/hv/mshv_vtl_main.c
> +++ b/drivers/hv/mshv_vtl_main.c
> @@ -129,6 +129,7 @@ mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
>  	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
>  				  vtl, O_RDWR);
>  	if (IS_ERR(file)) {
> +		put_unused_fd(fd);
>  		kfree(vtl);
>  		return PTR_ERR(file);
>  	}
> -- 
> 2.34.1
