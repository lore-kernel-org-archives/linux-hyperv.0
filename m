Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793768924;
	b=IJdv3YrWNpdIYv7OM398L0pFhqMKhhtQ49uT0pOMXGrYTmewMB8BfDnFB0KEDX6OcoFL
	 73XFcYxdxYU70WaWhsGsOyhOBQqwYA+weUKkWQHBLaESSfxzXWGbLEnz4OEDEBaiw908/
	 qa7KNOJlQwvEIF0Jkj4QhVuFeDoX4Iq6+aYeiVLlBBH6PEVDwTk2qn01+hbrHctpn3f/5
	 3Fh8UD/gdCXGBOvy5LxEIJipaZRGqBP4Bzet7NX61dfKXrYKIQHvXiUQ/lwZSLzBrzxGn
	 tERbt6Mrtqgt0JtQr3CZY73AADw+9T3NxiMAO/FwHJsbQMRonU7eFCvKqLX8la/0a8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793768924;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=n0Xywr94Vk3WtL8YoWlzK4ISWgOH/R1JCv5dLFPIkIM=;
	b=nPwVNTPGdb32M13LHZfB4jN0EIkPMEssOkqVLUOIoc6/KqN6sZYS4r7rVBnvN0/oMOdQ
	 E0oor+IKouu3LhAnNRmai2Aa8IadfvuF3BJl7Pmayi7Xre/mcvP+Ge8sshzteDxnvhZ5u
	 qp55AppODLpy2kIXULnJUOtWV/G8jITDcUL/mARSbm8a92aqEEz1s1cksF3Vz4yIqWkAN
	 rLrCwPuf1Fv8FNjgpfl4es/wgzZsG60ftlTlTzrJP0wN9Ue9kHX1FHdGXyiksIygwhWEJ
	 oUCPlXrrxM/rBMrfnHy28CinDHDsEzYWtHqBzVJkA3mGY5R1Se8yWvoA/4pawvFwqSw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=sBtyhiUk;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C37606A326;
	Wed,  4 Nov 2026 05:08:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84C37606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=sBtyhiUk
Received: from [192.168.1.7] (unknown [103.212.145.77])
	by linux.microsoft.com (Postfix) with ESMTPSA id 88CC920B7166;
	Tue,  3 Nov 2026 21:08:27 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 88CC920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793768908;
	bh=n0Xywr94Vk3WtL8YoWlzK4ISWgOH/R1JCv5dLFPIkIM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sBtyhiUkjSOC/y4YU7Q21hwoxP7b2bPy3yWUAXMGrspoYU6r5YJoWUxbiU4IRvLbk
	 /tZfk/4PiSP0xw10D+e45eGHP/iBPIXSq3nwkE0Ldk18NG74S4XnxOMi5T10kFk22t
	 E2t3gAlfocgO7RXnyG7s3rJ2BFSso9F36oI52sXQ=
Message-ID: <c3ec0e88-5077-4eee-8ed8-9b2f71f00b0a@linux.microsoft.com>
Date: Wed, 4 Nov 2026 10:38:39 +0530
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: hv_netvsc: user-configured RSS indirection table is zeroed on MTU
 change
To: Amir Boussejra <amir@boussejra.com>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org
Cc: amir.boussejra@gatewatcher.com
References: <40fb2352-4859-4334-849b-f6a4229605a1@boussejra.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <40fb2352-4859-4334-849b-f6a4229605a1@boussejra.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 29-10-2026 14:40, Amir Boussejra wrote:
> Hi,
> 
> On Azure/Hyper-V, any MTU change on an hv_netvsc interface silently 
> zeroes a
> user-configured RSS indirection table, so all RX traffic lands on ring 0.
> 
> Reproducer in our case (any multi-queue hv_netvsc NIC, ethtool and ip 
> only):
> 
> ```
>   ethtool -X eth0 hkey $SOME_KEY equal 4
>      ethtool -x eth0             # See conf
>      ip link set eth0 mtu 1600     # must differ from the current MTU
>      ethtool -x eth0               # all zeros in indirection table
> ```
> 
> With the table left to the driver (ethtool -X eth0 default) the same MTU
> change is harmless: the table comes back correctly spread.
> 
> Confirmed with kprobes on 6.12.90 - these all fire on the MTU write:
> 
> ```
>      netvsc_change_mtu
>      netvsc_detach
>      rndis_filter_device_remove
>      netvsc_attach
>      rndis_filter_device_add
> ```
> 
> [`netvsc_change_mtu()`](https://github.com/torvalds/linux/blob/v6.12/ 
> drivers/net/hyperv/netvsc_drv.c#L1209)
> 
> An MTU change re-creates the device:
> [detach](https://github.com/torvalds/linux/blob/v6.12/drivers/net/ 
> hyperv/netvsc_drv.c#L1233), then
> [attach](https://github.com/torvalds/linux/blob/v6.12/drivers/net/ 
> hyperv/netvsc_drv.c#L1239).
> 
> The detach [frees the RSS indirection table](https://github.com/ 
> torvalds/linux/blob/v6.12/drivers/net/hyperv/rndis_filter.c#L1622)
> (`rndis_filter_device_remove()`), and the attach
> [allocates it zeroed](https://github.com/torvalds/linux/blob/v6.12/ 
> drivers/net/hyperv/rndis_filter.c#L1557)
> with `kcalloc()` and refills it only if
> [`(!netif_is_rxfh_configured(net))`](https://github.com/torvalds/linux/ 
> blob/v6.12/drivers/net/hyperv/rndis_filter.c#L1572)
> (`rndis_filter_device_add()`).
> 
> 


Hi Amir,
Thanks for reporting this bug
I'll post a fix for this and notify here as well

Regards,
Aditya
