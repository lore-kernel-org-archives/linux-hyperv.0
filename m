Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792802483;
	b=KcZVWJSvVLqgI7A9qa4HnaPc4WPxKIFytdE06dUJoX18f9HSrHx3cuxvoCB0jqlSJEwj
	 cf6qR58OKuuhiQfsTWvvDSZ0nprmw3bonly4r7gENx4PbdwE/NgEINmcr6ZeR8qwKyf8e
	 fCOJbpvUK+coduQfD5+3lhNRqesaGzpsYop1DZSgBspk1TYpfUFfOcHSeDbmLcFfd1F63
	 5l8MizopF+d8kzB2paQB9qlWBSyDF64+57A8cf9p9vbG3qbeoE4kM8L1tKlTxkaVcZNjW
	 CjYDRq0AHbAkVkZN87gL3uMDOMI+BiUPiC4oAVddMARV5Q1HEDLoT8+e9OVd2qW5acg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792802483;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=e+3yikLRyd25QVAHi64GlaMAtZSjYf4vQyOD0JTh6mg=;
	b=I3cViTkALPyp3QbetbJr1h+aQ/lh2Eica283a38TnUs+tIvvZ/pAURiuSug2CSWgjxd+
	 7WbDVhMAZyUuR/xbLQqiC2ri/Bx5Vwjtlfg3v8Q9+egr9dR0AmaMP/eT4g5ScVSVkLtxD
	 DhMb6q/enObIpYj5dR/Rf0e2BG0cqXyoFBtHkhYJ/UFkpvsndUUvOqlf+KTWu1chsbbxt
	 fZYOZY0S0kl8o3z0d59LDegBZG7nh4Z32nP04aR2amv/5goTSaD46Eda+Mhj1RbxO26xU
	 eLdFvAVlV3ZzeCI3uXINGNa9gzMCzdBfPCv1z2QJlO6wT6S1G50to6BHsHfRadC4wAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gT1G1TGx;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37D606A31A;
	Sat, 24 Oct 2026 00:41:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B37D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=gT1G1TGx
Received: from [192.168.0.15] (unknown [52.172.102.219])
	by linux.microsoft.com (Postfix) with ESMTPSA id 955D920B7166;
	Fri, 23 Oct 2026 17:41:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 955D920B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792802473;
	bh=e+3yikLRyd25QVAHi64GlaMAtZSjYf4vQyOD0JTh6mg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=gT1G1TGxFQnd4QjMonPQ+AeRk2ZwkG8kKkaQH3fpXPjjn6phe0rje9VOZZu9u7DMe
	 ufZK32KTmHQeB1RA0ciGkkACNsXlIHLt0IhvPURlQgRm0mYuTru9HrX0VxY+PtFk1E
	 YNgzclldBzkqbTzNk8NbbwgxGttA5lLW60JMlDdE=
Message-ID: <d04125b1-1228-4322-a455-3b8970167239@linux.microsoft.com>
Date: Fri, 23 Oct 2026 17:41:17 -0700
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
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: copy dynamic IDs before
 dropping the lock
To: Jiale Yao <yaojiale02@163.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261021143323.338146-1-yaojiale02@163.com>
 <20261021143323.338146-3-yaojiale02@163.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20261021143323.338146-3-yaojiale02@163.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/21/2026 7:33 AM, Jiale Yao wrote:
[...]
> @@ -860,13 +862,17 @@ static int vmbus_match(struct device *device, const struct device_driver *driver
>   */
>  static int vmbus_probe(struct device *child_device)
>  {
> -	int ret = 0;
> +	const struct hv_vmbus_device_id *dev_id;
> +	struct hv_vmbus_device_id dev_id_copy;
>  	struct hv_driver *drv =
>  			drv_to_hv_drv(child_device->driver);
>  	struct hv_device *dev = device_to_hv_device(child_device);
> -	const struct hv_vmbus_device_id *dev_id;
> +	int ret = 0;

Nit: the reordering of these declarations is unnecessary.
In a stable patch, we shouldn't include any purely style changes.

-- 
Regards,
Kameron

> +
> +	dev_id = hv_vmbus_get_id(drv, dev, &dev_id_copy);
> +	if (!dev_id && !is_hvsock_channel(dev->channel))
> +		return -ENODEV;
>  
> -	dev_id = hv_vmbus_get_id(drv, dev);
>  	if (drv->probe) {
>  		ret = drv->probe(dev, dev_id);
>  		if (ret != 0)
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9e109d91aa14..0f0423e8a184 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -1264,6 +1264,7 @@ struct hv_driver {
>  		struct list_head list;
>  	} dynids;
>  
> +	/* The device ID pointer is only valid during the probe callback. */
>  	int (*probe)(struct hv_device *, const struct hv_vmbus_device_id *);
>  	void (*remove)(struct hv_device *dev);
>  	void (*shutdown)(struct hv_device *);



