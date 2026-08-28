Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E08F3101C0;
	Fri, 28 Aug 2026 13:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787923939; cv=none; b=ZGJvfC+N1FoBISCWtPNcn5YCKjFG6amwSqpQhG77tUrXZMyw8MAFn1uzNhrG5E4u87+ZJPxkh4Mt8Bq5VBnPqkllVg51z9kojWaJM4lwHryk0kklpXJ+hQli+TRx3J7ybKSWqP25IuJBEZOOHqV/T+uG7zM8h2o3AavI5f94mjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787923939; c=relaxed/simple;
	bh=StXA8njzt3+COAR2u3GYujqDMEnk1AgfhNCLcxAQ0cc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXQYFYVrtMBw/1QsBoSUmlTuG5JjVvGQZ4MdmIyrqERIJFA19Xdt0Bu5bBnTvoPmJL+V5+E/JDIInkOJtbH56/02z2zRpWivudVXWXrbilEv14eXi8Kcnl7fZVSIWFk+gdQ75bAcUNjY9Fb/Rgh/BPL5lfyIsNJvZxEKGkJilcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NgeR8nyO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NgeR8nyO"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 2768A20B7168; Fri, 28 Aug 2026 06:31:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2768A20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787923902;
	bh=0jqPLtmyzS7GdCmW02hukbFaUq6ZdO8gYB0t+IhqcDc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NgeR8nyOACFw6Zdv953Jx1buvBCSR/iYKFhbUqD2hYTxLzoqOCaXVWgp4lOBHe7G8
	 c7J/C1rS4NkUjrPivaxpk17M8/K1/4GcTL2QeML0QYRnBZRI3Uhct39FvAB5iRiKTD
	 XwHSM5yeZ8Lg7uxG18r2AxrJEY0SCV4JFfxMlry8=
Date: Fri, 28 Aug 2026 09:31:42 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] Drivers: hv: Remove !CPU_BIG_ENDIAN qualifier for
 arm64
Message-ID: <apGNvkZMlYccBNcv@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260828034448.8291-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260828034448.8291-1-mhklinux@outlook.com>

On Thu, Aug 27, 2026 at 08:44:48PM -0700, Michael Kelley wrote:
> Support for CPU_BIG_ENDIAN configurations on arm64 was deprecated
> in commit 1cf89b6bf660 ("arm64: Kconfig: Make CPU_BIG_ENDIAN depend
> on BROKEN"). The support is now in the process of being completely
> removed.
> 
> The Kconfig for Hyper-V guests on arm64 currently has a
> !CPU_BIG_ENDIAN qualifier since Hyper-V only supports little
> endian. But with Linux on arm64 restricted to little endian,
> that qualifier is no longer necessary. Remove it.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/hv/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index aa11bcefddf2..db8464fcd119 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -5,7 +5,7 @@ menu "Microsoft Hyper-V guest support"
>  config HYPERV
>  	bool "Microsoft Hyper-V core hypervisor support"
>  	depends on (X86 && X86_LOCAL_APIC && HYPERVISOR_GUEST) \
> -		|| (ARM64 && !CPU_BIG_ENDIAN)
> +		|| ARM64

Personally, I think we should leave it be until aarch64_be support is
completely stripped out of the kernel.

Hamza

>  	select PARAVIRT
>  	select X86_HV_CALLBACK_VECTOR if X86
>  	select OF_EARLY_FLATTREE if OF
> -- 
> 2.25.1
> 
