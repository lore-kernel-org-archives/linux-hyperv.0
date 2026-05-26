Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA9B30C16D
	for <linux-hyperv@vger.kernel.org>; Tue, 26 May 2026 06:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779777915; cv=none; b=FUxZYwTkF9eUSLng4xKPH9sc79BueMjTO+DNoPP7mFQxyAmwMf3sPYUzWWtVQBQKI+PP47LRhM14DN1JtjWR/jSra/KvlUiZvomi6dmUNLYmsfPy8ku/blQg7+e+6ggKk+8C1bFEE+s9Gsz45XnIgcQxVzXGGJz5x+Lpxzhun90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779777915; c=relaxed/simple;
	bh=6amShX66pG0uFP1AXYmBEqQFHJjSC/CawSCIZ/+/29w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KD220WuIYEmgjslCa0WYxtgnIX7tys8EmCW1f1LXNuf/LR9hIBKKAzUjUNOt090jU4yaXuh9+4sY7yTxjgmobv113HP7gA0ylqLCl8rmuWVFDOcM9ppN5X6o0l6Z1j7KWw9YYDdafYtV6XKz4lZGRyO7Tug8k6SmFAEPD5emGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mluy8tqT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mluy8tqT"
Received: from [10.95.65.8] (unknown [167.220.238.72])
	by linux.microsoft.com (Postfix) with ESMTPSA id F250E20B7167;
	Mon, 25 May 2026 23:45:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F250E20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779777903;
	bh=Yf7cIa2Tge4SrGHiydUOc4tsx0bXzeTdrJC4+A7dr2c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mluy8tqTnjDyfDQ/ysD4G4RP9m1ZZVwNdWpKVkTN3bvzn75gArBeTPHgISp6Z++G+
	 GzqESgjYv6tsJcdAK8OyDEC0bSoZNph+xFt5B6QfTTptnALiKYQCYaAqgd7AqMH+qQ
	 NeS8Gpz78H+MKZ2HF18ScnyhKndUCpYgCDn1dez4=
Message-ID: <b9943717-d804-4496-bf85-54f2a8b988ec@linux.microsoft.com>
Date: Tue, 26 May 2026 12:15:08 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Bind to FCopy device by default
To: Ben Hutchings <benh@debian.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-hyperv@vger.kernel.org
References: <ahQ6xuhSReidmN-3@decadent.org.uk>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <ahQ6xuhSReidmN-3@decadent.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/25/2026 5:34 PM, Ben Hutchings wrote:
> The Hyper-V kernel-mode fcopy driver was removed in 6.10 and the new
> fcopy daemon requires this uio driver to function.  However, by
> default the driver does not bind to any devices, and must be
> configured through the sysfs "new_id" file.
> 
> Since the FCopy device is now only usable through this driver, add its
> ID to the driver's ID table so that the daemon will work "out of the
> box".
> 
> Signed-off-by: Ben Hutchings <benh@debian.org>
> Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
> ---
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
> @@ -395,9 +395,15 @@ hv_uio_remove(struct hv_device *dev)
>   	vmbus_free_ring(dev->channel);
>   }
>   
> +static const struct hv_vmbus_device_id hv_uio_id_table[] = {
> +	{ HV_FCOPY_GUID },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(vmbus, hv_uio_id_table);
> +
>   static struct hv_driver hv_uio_drv = {
>   	.name = "uio_hv_generic",
> -	.id_table = NULL, /* only dynamic id's */
> +	.id_table = hv_uio_id_table,
>   	.probe = hv_uio_probe,
>   	.remove = hv_uio_remove,
>   };

Two things worth considering before applying:

1. Please add Cc: stable@vger.kernel.org or is it that we do not want 
this to be ported to older kernels?
2. Every Hyper-V guest (with UIO_HV_GENERIC enabled) will now have an 
additional auto-bound /dev/uio0 node for FCopy. Anything that hardcodes 
/dev/uio0 (e.g. ad-hoc DPDK scripts that bind a NetVSC NIC via 
uio_hv_generic + new_id) may see its index shift, since FCopy now wins 
uio0 at boot. The fix for such consumers is the same thing DPDK and the 
in-tree daemon already do: resolve uio via 
/sys/bus/vmbus/devices/<guid>/uio/ rather than by number. This is not a 
regression in the patch, but it's a behavior change worth calling out.

Regards,
Naman
