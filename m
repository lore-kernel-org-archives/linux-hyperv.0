Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104AEADC;
	Sat, 24 Jan 2026 00:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769213392; cv=none; b=G3dFqR7QhP1cXRtjqL03YVnXGWmnXhaqTLUwY0qw4/iOSoGI9D95m38dIdC7zc3jEG9yU63FJKqfx774XqrjW4MachiY7vVCZHvO5Qj5V3N2Z+GZkJzCVFkH8zhVNpBE8E3bH+CRzhXVUAgRVpde4uH/aa1xDAFFaeJPlWsdfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769213392; c=relaxed/simple;
	bh=jyutI1l3bFazjTEoobWSZTS4jh2mnj5UOOkYLC/dNq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nVoB13vL4SgdSLaxrVbpmEoz+nzbKjYPtOcbuY+/zI//9pmfmQe/6WRd5PJLEBVFRnUJ8vFj2oIKKngWZvc8+PiRV+enWX8OJbZ0vsxp8a4WnyHOAy/RfRaoGYj54tf5L91B5h422abdybdD1LdbDDLJbbPigaTATnV7tJgNMb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=T8mzR/Na; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="T8mzR/Na"
Received: from [100.64.97.48] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46EEE20B7167;
	Fri, 23 Jan 2026 16:09:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46EEE20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769213390;
	bh=F1FTAVODPqwuJaeZy74EbM5GaTPbzR1nURa1bVTjqf0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=T8mzR/NanuoZjsPKu/lUQ2TVTMgNN1nxL1Z6bnZgRwWmI7ZlzM/9oxhtzt8IQvOWk
	 jwFE2O+MJISFUdbsPvY9R6GjsZCnc6EwavSpjKz63I99Q/y6Dz7BZOulu0gbFrDEdn
	 ufVWu8kf8egWVDZXDv7Z6CaUF38K9Ee18x3XTTSA=
Message-ID: <11a20912-65cb-4b67-9a13-e1c9db680c93@linux.microsoft.com>
Date: Fri, 23 Jan 2026 16:09:49 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv: Make MSHV mutually exclusive with KEXEC
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <176920684805.250171.6817228088359793537.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/23/2026 2:20 PM, Stanislav Kinsburskii wrote:
> The MSHV driver deposits kernel-allocated pages to the hypervisor during
> runtime and never withdraws them. This creates a fundamental incompatibility
> with KEXEC, as these deposited pages remain unavailable to the new kernel
> loaded via KEXEC, leading to potential system crashes upon kernel accessing
> hypervisor deposited pages.
> 
> Make MSHV mutually exclusive with KEXEC until proper page lifecycle
> management is implemented.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 7937ac0cbd0f..cfd4501db0fa 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -74,6 +74,7 @@ config MSHV_ROOT
>  	# e.g. When withdrawing memory, the hypervisor gives back 4k pages in
>  	# no particular order, making it impossible to reassemble larger pages
>  	depends on PAGE_SIZE_4KB
> +	depends on !KEXEC
>  	select EVENTFD
>  	select VIRT_XFER_TO_GUEST_WORK
>  	select HMM_MIRROR
> 
> 

Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
