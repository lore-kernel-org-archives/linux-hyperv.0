Received: from omta038.useast.a.cloudfilter.net (omta038.useast.a.cloudfilter.net [44.202.169.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AD402B9E
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 06:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790143817; cv=none; b=UN+WItRjHfI4mcP+zWs8vpLdOxshnP7AfSqLyYVeO3d7Y2lTqJ4iY81JwyhvgODkmaLZAcqafsbOFUhkI/AG299OMUYxMsfB6lVSHuC3Oj/chnkYLfBFF1sWjqgYDTnLyBDGnwsylMzJQBHrPGIwCdALEp9XKjb8Dw7V8rV29nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790143817; c=relaxed/simple;
	bh=dy2CeYpd+lXAnmlW07mW4QKCWyh5ASqU6aif4ORmxO0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oPGwpxBoHutP/Slmm+dqBb4E9HzWhsw0HgtD/rT/NiDL96ndLVydkcmd4uN8rokxx+TEt4h888w9LiWGZyUg425SVqDPQHsxryh7olSwTGsUuvV7nHy4r6YXQX2LrmHwXjbXbV8Mcq9VeQ9CcUmMsk9Eg66DtVOaiW18s/6cKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=qzxqJIpN; arc=none smtp.client-ip=44.202.169.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="qzxqJIpN"
Received: from eig-obgw-6005b.ext.cloudfilter.net ([10.0.30.162])
	by cmsmtp with ESMTPS
	id 92ucx26tpJFmF9GBLxmUzL; Wed, 23 Sep 2026 06:10:15 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9GBKxv9H9QQTW9GBKxvo6K; Wed, 23 Sep 2026 06:10:15 +0000
X-Authority-Analysis: v=2.4 cv=CuK/cm4D c=1 sm=1 tr=0 ts=6ab36d47
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=VwQbUJbxAAAA:8 a=vmMgSTcIRG_wnqpSMZkA:9 a=QEXdDO2ut3YA:10
 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=0+Ti3ClvEeyB0mxjZ6Y5EozLt9wFOSnnKiPH9XINcK8=; b=qzxqJIpNrJXl
	3zJRZ6IK7MgKuMmJuyFiMJ3YHCWMzzbhJ0Al6OcwtbFRyunv+E39aorQU6e1yGW6heNp/swhwkp4M
	LxReoQFGHv0kdBmkKM5Ip/itJIaZzl9H10IxE0HVyyLskyhGAEpFB/aBQHO3o0cVX1ik7aKZwiQFR
	cgi8Gas1OrtSZsaSPuTkVXxLhyCzOF3fNEWJalsyUIQS+AqCdha6Vbzp2I7xS5GpAwHVkpAa+63KX
	YDIPER3OUvxPiqcog+cEc8LFN9OjeygVafALX88uRADuWhb/YjyVzTg3N3r5/VmZRoOV/uGpY42ch
	BD3PN/5igNRDKI1yJ3MAjg==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:35276 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9GBJ-00000002LmZ-1RVU;
	Wed, 23 Sep 2026 01:10:13 -0500
Message-ID: <a51283e0-7d55-4d06-bf7d-3cd7b7a21faa@embeddedor.com>
Date: Wed, 23 Sep 2026 15:10:08 +0900
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with
 __counted_by_ptr
To: Bill Wendling <morbo@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, codemender-patching+linux@google.com
References: <20260923055320.2602534-1-morbo@google.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20260923055320.2602534-1-morbo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 125.195.69.90
X-Source-L: No
X-Exim-ID: 1x9GBJ-00000002LmZ-1RVU
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:35276
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFhklSdSNRbPh0PHL8SMG6LV7JUk5KQ/F+QYzwcn14zBuhhBPnWZOOUufPxwYoJ0XdysjMHEXHwDA4wuATmWj+7kBBstCpbiRC9lnuePSxrmQepvGq6F
 x3ZWBWg+ikEQfNy6owqi0k/AHOlQzfdHP+UWhBRNDuPp0AkkFpy0nbFabl+f7RLE6UlpF7vvzKg10k0PYrgi7VhiFBjymXBj37GYVHUITnEXT1tfwC82b+/g



On 9/23/26 14:53, Bill Wendling wrote:
> Add the "__counted_by_ptr" attribute to the buffer field of "struct
> vmbus_gpadl". This allows compilers (GCC and Clang) to perform
> compile-time and runtime bounds-checking when KASAN is enabled, preventing
> potential out-of-bounds accesses to the GPADL buffer.
> 
> The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
> exactly once, during GPADL establishment inside
> "__vmbus_establish_gpadl()" in "drivers/hv/channel.c".
> 
> To ensure that the count field ("size") is initialized before the
> pointer field ("buffer") is assigned, we reorder the assignments in
> "__vmbus_establish_gpadl()" so that "gpadl->size" is written before
> "gpadl->buffer".
> 
> Cc: codemender-patching+linux@google.com
> Assisted-by: LLM
> Signed-off-by: Bill Wendling <morbo@google.com>
> ---
>   drivers/hv/channel.c   | 2 +-
>   include/linux/hyperv.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 7e4cc6f55237..7042de2dd481 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>   
>   	/* At this point, we received the gpadl created msg */
>   	gpadl->gpadl_handle = gpadlmsg->gpadl;
> -	gpadl->buffer = kbuffer;
>   	gpadl->size = size;
> +	gpadl->buffer = kbuffer;

I think in some cases these subtle changes are worth a short but
informative comment saying that the _counter_ must be initialized
before the first reference to the pointer.

We can see this as part of the learning curve people have to go
through before the counted_by annotations and their requirements
are more widely known and understood. But I guess this can be
handled on a case-by-case basis.

Regardless:

Reviewed-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Thanks
-Gustavo

>   
>   
>   cleanup:
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 9e109d91aa14..408748a05440 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -780,7 +780,7 @@ struct vmbus_device {
>   struct vmbus_gpadl {
>   	u32 gpadl_handle;
>   	u32 size;
> -	void *buffer;
> +	void *buffer __counted_by_ptr(size);
>   	bool decrypted;
>   };
>   

