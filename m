Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D3C4562BB
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 08:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790150548; cv=none; b=dVd5yI4xpwk+YszpzQpMdbj/qWchrswO4jXDMmosGsKdquJ0W581NNTTyw7D67LpJUFWn8AW4/9ZO7jAl+u1WRKd1wmeJSbckCq19s1oB9+j8mp0NivWKBj5LX4Mf/NMEku2MojzOlNRklwn0o+3Rhoa9szQI9Q1g3UBX1tfzLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790150548; c=relaxed/simple;
	bh=NjFFa+JHvwkzY8oVLiPbDgALrnp7a6rOqFillHQtSDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g3w/xGRktRXG0AFyO98qzn0DIhVWMdSL8/ZQxRlUkrJ/7gZmKVQCHCl4etjrVFuxu5pgFiKaVkMO/mEVKcA2iMjrZ9pKW9ZoU51uRjixfM0kp0pSGLplkZpeMop7BYCugp4OIRaEaAnSpjPiDpHAs15GPT/qZQkvNFqJixaOAxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=kYyd7LHl; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="kYyd7LHl"
Received: from eig-obgw-6003b.ext.cloudfilter.net ([10.0.30.175])
	by cmsmtp with ESMTPS
	id 9GK4xu4e0c3Xs9HvtxAO97; Wed, 23 Sep 2026 08:02:25 +0000
Received: from gator4166.hostgator.com ([108.167.190.91])
	by cmsmtp with ESMTPS
	id 9HvsxRIQZ97Dy9HvsxGnsG; Wed, 23 Sep 2026 08:02:24 +0000
X-Authority-Analysis: v=2.4 cv=asGyCTZV c=1 sm=1 tr=0 ts=6ab38791
 a=vY9Mjuda9oMEc2E4Cx1x2A==:117 a=vY9Mjuda9oMEc2E4Cx1x2A==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=7T7KSl7uo7wA:10 a=1XWaLZrsAAAA:8
 a=fr3FARZsm93X7T_27y0A:9 a=QEXdDO2ut3YA:10 a=2aFnImwKRvkU0tJ3nQRT:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:
	List-Archive; bh=23Gz0e2PpXnP7QWwvqhbo8Ydj4EwHwL4tYVA9bUXDic=; b=kYyd7LHl4Xou
	lhlH3DoiSfFZYrwHIwZmS3iYMpq4UY9DF/E0qic4FT0u/OacLA3Zc4R1q16tzCY5ompfugq1zWzmt
	xAXQ88saJdOmRUYwthnqE+APx0CHk94HdYFrw4CfBq3EkvOVtbP2xoDW5wZ7riAaOSxoodQcUjZ9S
	0MCIHbgp7Mm7x2OyPxZKe842db8QdhksnRGWcf3FhIsQVug/thvvOIwCRZblzQL001mnlohAqlyFs
	sheXApKQp/f2zyy9TNU+eKkFl4OSoB6n72ybWGaq95nYept+RXv3JND59fKfjegBhmdsL7XORtHjc
	JccJmQPHJRUPNIg3KrwbOQ==;
Received: from flh4-125-195-69-90.tky.mesh.ad.jp ([125.195.69.90]:56168 helo=[10.203.100.34])
	by gator4166.hostgator.com with esmtpsa  (TLS1.3) tls TLS_AES_128_GCM_SHA256
	(Exim 4.100)
	(envelope-from <gustavo@embeddedor.com>)
	id 1x9Hvq-0000000476T-3FYT;
	Wed, 23 Sep 2026 03:02:22 -0500
Message-ID: <204fb990-7b45-4ce1-8e6a-260538bfb678@embeddedor.com>
Date: Wed, 23 Sep 2026 17:02:12 +0900
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Drivers: hv: vmbus: annotate struct vmbus_gpadl with
 __counted_by_ptr
To: Kees Cook <kees@kernel.org>
Cc: Bill Wendling <morbo@google.com>, "K. Y. Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>,
 Justin Stitt <justinstitt@google.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 llvm@lists.linux.dev, codemender-patching+linux@google.com
References: <20260923055320.2602534-1-morbo@google.com>
 <a51283e0-7d55-4d06-bf7d-3cd7b7a21faa@embeddedor.com>
 <202609230021.7F6F2140@keescook>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <202609230021.7F6F2140@keescook>
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
X-Exim-ID: 1x9Hvq-0000000476T-3FYT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: flh4-125-195-69-90.tky.mesh.ad.jp ([10.203.100.34]) [125.195.69.90]:56168
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOgrrXUplcqgMeE3Dma9JgJbfh6zQzA3KT2a2RIn9L3Xm7QfcjCS4Ees4lxwOcQKiFikXEI3IyYUYmgYmuVkWCGNd/wQ0+IyUWFgsC1ENFzXeJcf4nH6
 RkGnRRwxeZAk0vcJTfLn/p6L8QAzdPkS0yg/SC0u88N5ofltoiXQ4lz5gyH1tyv8xdKXtyePbdCqoQVzeBlqPOItohpmTTv3FouXdOjz8/yVEg9tyq/v3QVB



On 9/23/26 16:23, Kees Cook wrote:
> On Wed, Sep 23, 2026 at 03:10:08PM +0900, Gustavo A. R. Silva wrote:
>>
>>
>> On 9/23/26 14:53, Bill Wendling wrote:
>>> Add the "__counted_by_ptr" attribute to the buffer field of "struct
>>> vmbus_gpadl". This allows compilers (GCC and Clang) to perform
>>> compile-time and runtime bounds-checking when KASAN is enabled, preventing
>>> potential out-of-bounds accesses to the GPADL buffer.
>>>
>>> The fields "buffer" and "size" of "struct vmbus_gpadl" are assigned
>>> exactly once, during GPADL establishment inside
>>> "__vmbus_establish_gpadl()" in "drivers/hv/channel.c".
>>>
>>> To ensure that the count field ("size") is initialized before the
>>> pointer field ("buffer") is assigned, we reorder the assignments in
>>> "__vmbus_establish_gpadl()" so that "gpadl->size" is written before
>>> "gpadl->buffer".
>>>
>>> Cc: codemender-patching+linux@google.com
>>> Assisted-by: LLM
>>> Signed-off-by: Bill Wendling <morbo@google.com>
>>> ---
>>>    drivers/hv/channel.c   | 2 +-
>>>    include/linux/hyperv.h | 2 +-
>>>    2 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
>>> index 7e4cc6f55237..7042de2dd481 100644
>>> --- a/drivers/hv/channel.c
>>> +++ b/drivers/hv/channel.c
>>> @@ -548,8 +548,8 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
>>>    	/* At this point, we received the gpadl created msg */
>>>    	gpadl->gpadl_handle = gpadlmsg->gpadl;
>>> -	gpadl->buffer = kbuffer;
>>>    	gpadl->size = size;
>>> +	gpadl->buffer = kbuffer;
>>
>> I think in some cases these subtle changes are worth a short but
>> informative comment saying that the _counter_ must be initialized
>> before the first reference to the pointer.
> 
> But that's only for dereferencing it... there's no ordering requirement

Ah yes, I got a bit carried away by the change itself.

> here at all (and I think swapping order is needless churn). Neither
> order is correct: only having them both set before dereferencing
> "buffer" is required.
Yes; maybe this is something the LLM should learn.

Thanks
-Gustavo
