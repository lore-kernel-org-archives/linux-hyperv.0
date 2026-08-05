Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB63CF20C;
	Wed,  5 Aug 2026 17:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785950898; cv=none; b=o/n9m1hhhYgdouMh9owEksppg0rPh8ZlpMjKYVzQU6Pf0+zgWrzSVqYgDXWuYO6KmZS8aSdZzFG9hzrf5RQX7HoZLAgZee/+lqMEBG/1WCoG/dAJpTBkdFMAd9fF4awqRQCEQ/+hzhNy8uan2tIEsGicmUvPXNv6y5k+3x5hv68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785950898; c=relaxed/simple;
	bh=AttPrNE29aOkIwCAN9vhd9xhjPouQp1MzykRNDlbMDs=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MCsCNTKSY0O7zgB8RRbBqJHnnI0UTQiDuxmiugy7MW/Uloa7aliq1Dx8YtpWEdInV1q0rNrxAkaYK+OM0qLNfonlgBOOwQk6YUPAm0pljWAIIdBUgyQ7QEE9Z2SAf78zTVZsenpfDYCivyf8boUsJv307DwqGHBGpR49KtJycw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KGMMna8b; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KGMMna8b"
Received: from [10.21.58.224] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id B07C420B716A;
	Wed,  5 Aug 2026 10:27:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B07C420B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785950875;
	bh=4uyXdKYRGxLEt+ERt7sZQHNCfotjPYoPhul+uCkTMvY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=KGMMna8bDs19Z1gO5rPDYAKRTo0X4rJ8UivKPjnZEJaJsghUUS/YMdecn9u3FHm9e
	 MDuOXsy2GE/18MEW8XNnq909aONm/t8MwjFB6lCSC9IExNUcCDxY8xdMTXTorrc/lu
	 ZCweTcXJJ+rFaq9oCCfWmkCs7it8oiwxi8V9rxSU=
Message-ID: <4a363c99-e03a-469e-bf4d-bce811586d4a@linux.microsoft.com>
Date: Wed, 5 Aug 2026 10:28:09 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, linux-hyperv@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] Drivers: hv: vmbus: Skip VMBus module cleanup for
 non-nested root partition
To: mhklinux@outlook.com
References: <20260805142421.104797-1-mhklinux@outlook.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260805142421.104797-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/5/2026 07:24, Michael Kelley wrote:
> The VMBus module initialization function, hv_acpi_init(), currently
> does nothing when running in the root partition and root is not nested
> in another VM. But the initialization function reports success, so the
> VMBus module is indeed loaded. VMBus functionality is not actually
> needed, but the VMBus module must be loaded so that hv_vmbus_exists()
> can answer correctly. Furthermore, the mshv_root dependency on the
> VMBus module is needed as described in the commit message for
> 840b740a35bf ("mshv: Add conditional VMBus dependency").
> 
> Loading the VMBus module without actually initializing it causes
> failures if the module should later be unloaded. The module unload code
> tries to clean up things that were never initialized, resulting in
> memory faults and a panic.
> 
> Fix this by having VMBus module exit function perform the same
> check for non-nested root partition, and do nothing in such a
> case, just like hv_acpi_init().
> 
> In the long run, the code that manages the Hyper-V provided SynIC
> should be refactored to better coordinate the requirements of
> root partition scenarios and normal VM scenarios, and to hopefully
> remove the hv_vmbus_exists() dependnecy between mshv_root and
> VMBus modules. Preventing the current unload failure scenario is
> an expediency until such a refactoring is done.
> 
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/linux-hyperv/20260721154943.A09BD1F00A3D@smtp.kernel.org/
> Fixes: 7e279d78664aa ("Drivers: hv: vmbus: skip VMBus initialization if Linux is root")
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> v1: https://lore.kernel.org/linux-hyperv/20260804190517.101981-1-mhklinux@outlook.com/
> 
> Changes in v2:
> * Use a different solution: Allow the VMBus module to load but have the
>   unload function do nothing for non-nested root
> * Change the patch Subject and commit message to reflect the new approach
> 
>  drivers/hv/vmbus_drv.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e19ec73b0187..f837153427f4 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -3024,6 +3024,9 @@ static void __exit vmbus_exit(void)
>  {
>  	int cpu;
>  
> +	if (hv_root_partition() && !hv_nested)
> +		return;
> +

Do you think it'd be useful to have a comment here either saying something to the effect of
"nothing was initialized, so let's skip the teardown", or alternatively pointing to the paired
check in hv_acpi_init()?

Either way,

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

>  	unregister_syscore(&hv_synic_syscore);
>  
>  	hv_remove_kexec_handler();

