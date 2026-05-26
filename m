Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 721623D79FD
	for <linux-hyperv@vger.kernel.org>; Tue, 26 May 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779790231; cv=none; b=jpL7XwrfOSPCYembeU9Bge58+2S/yzJj/xRliRFBHrebAsmE+JPMpM17x2ICz9mZvFom0p9qmg0G4ihUGqa65thlh0wHJaHRXjfPHJLwsQc0JASAMY2EqlTmJ05/GM6kO+70C/pELrPnW31n0xOQLeIy/sQ58+iW3TSbPNFGRZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779790231; c=relaxed/simple;
	bh=0IRzkqCfGgqeRC1OAJpSrCokTn68KNFzXADiImK4oBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=AekBjK27d4ny+/kyWYU/YEIysVdZh2U3R6dMSytIop6aaHz+OMntGGJpzd7yhV+YudNv+0ntlE5BNETq0N5CaK1bg0ZO71INsDsD5JsC3XudjUMI/hPvJZMTZAqXcrlZUpz1ZIeFMve6MgHV/0Q43m4UHl63fiHv2U20Y4IquxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ah7qLEpQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ah7qLEpQ"
Received: from [100.67.160.72] (unknown [52.163.76.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 46C8220B7167;
	Tue, 26 May 2026 03:10:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 46C8220B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779790213;
	bh=mSs1qCaLw3bUzfr8s36sKDmpmhBfmc7x+jJPK7op7Fs=;
	h=Date:Subject:To:References:Cc:From:In-Reply-To:From;
	b=ah7qLEpQWEem4bWUqCWsDN4h9txcOXpDEcM0jnwYWaEAcOrdux5WCSpdMrbknNRXn
	 oXeCZyFDgrP+qa8D49G7gsFkEx8TguExnN/PKUagIR/LNzHEuq6kYqnFfV1Kdc/a4/
	 EYCsSdkev/MMQVb967rjL3pOq0TtAkuu7bCsOIhs=
Message-ID: <aa420dc1-029c-408b-aef0-f02d6bfa002c@linux.microsoft.com>
Date: Tue, 26 May 2026 15:40:16 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] uio_hv_generic: Bind to FCopy device by default
To: Ben Hutchings <benh@debian.org>
References: <ahQ6xuhSReidmN-3@decadent.org.uk>
 <b9943717-d804-4496-bf85-54f2a8b988ec@linux.microsoft.com>
 <afdcb1775e7a60b7824b5c540a44f0148abe3e1c.camel@debian.org>
Content-Language: en-US
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-hyperv@vger.kernel.org
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <afdcb1775e7a60b7824b5c540a44f0148abe3e1c.camel@debian.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 5/26/2026 1:59 PM, Ben Hutchings wrote:
> On Tue, 2026-05-26 at 12:15 +0530, Naman Jain wrote:
>>
>> On 5/25/2026 5:34 PM, Ben Hutchings wrote:
>>> The Hyper-V kernel-mode fcopy driver was removed in 6.10 and the new
>>> fcopy daemon requires this uio driver to function.  However, by
>>> default the driver does not bind to any devices, and must be
>>> configured through the sysfs "new_id" file.
>>>
>>> Since the FCopy device is now only usable through this driver, add its
>>> ID to the driver's ID table so that the daemon will work "out of the
>>> box".
>>>
>>> Signed-off-by: Ben Hutchings <benh@debian.org>
>>> Fixes: ec314f61e4fc ("Drivers: hv: Remove fcopy driver")
>>> ---
>>> --- a/drivers/uio/uio_hv_generic.c
>>> +++ b/drivers/uio/uio_hv_generic.c
>>> @@ -395,9 +395,15 @@ hv_uio_remove(struct hv_device *dev)
>>>    	vmbus_free_ring(dev->channel);
>>>    }
>>>    
>>> +static const struct hv_vmbus_device_id hv_uio_id_table[] = {
>>> +	{ HV_FCOPY_GUID },
>>> +	{}
>>> +};
>>> +MODULE_DEVICE_TABLE(vmbus, hv_uio_id_table);
>>> +
>>>    static struct hv_driver hv_uio_drv = {
>>>    	.name = "uio_hv_generic",
>>> -	.id_table = NULL, /* only dynamic id's */
>>> +	.id_table = hv_uio_id_table,
>>>    	.probe = hv_uio_probe,
>>>    	.remove = hv_uio_remove,
>>>    };
>>

++ recipients, assuming you mistakenly clicked reply instead of reply all.


>> Two things worth considering before applying:
>>
>> 1. Please add Cc: stable@vger.kernel.org or is it that we do not want
>> this to be ported to older kernels?
>>
>> 2. Every Hyper-V guest (with UIO_HV_GENERIC enabled) will now have an
>> additional auto-bound /dev/uio0 node for FCopy.
> 
> I don't think that's quite true.  I tested with a Windows 11 host and
> needed to enable "Guest services" for the VM, which was disabled by
> default.  But if that includes other features besides FCopy it might be
> enabled for other reasons.
> 

Yes, meaning if these two conditions are satisfied (enabling guest 
services is also one time step for a Hyper-V VM), we would see uio0 by 
default for fcopy.

>> Anything that hardcodes
>> /dev/uio0 (e.g. ad-hoc DPDK scripts that bind a NetVSC NIC via
>> uio_hv_generic + new_id) may see its index shift, since FCopy now wins
>> uio0 at boot.
> 
> OK, so maybe I should implement the new_id dance in the fcopy service
> startup, to avoid that?  I did already looked at doing it in a systemd
> unit, but it's hard to do right because adding the same ID twice is an
> error.  Maybe the daemon itself ould do it?

Implementing it in uio daemon can introduce race conditions with sysfs 
creation. I guess it's OK then to implement it here, in kernel.

> 
>> The fix for such consumers is the same thing DPDK and the
>> in-tree daemon already do: resolve uio via
>> /sys/bus/vmbus/devices/<guid>/uio/ rather than by number. This is not a
>> regression in the patch, but it's a behavior change worth calling out.
> 
> It would be a good reason *not* to make this change in stable.
> 
> Ben.
> 

What issues are you fixing with this patch exactly? Is there any 
particular sequence of events you are targeting where traditional 
approach does not work?

Regards,
Naman
