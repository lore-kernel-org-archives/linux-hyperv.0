Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5052278F29;
	Fri,  5 Jun 2026 19:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780686709; cv=none; b=NFqZuIS5ezNBXGIFLlNiTGBIexViap37sq1dLUEYAhiNmtue/kPPw/V+R039fJkXk8Fnd4u0Cc7mUy1NfNrk1dGUuYs+/bzKAG8v4eRy5l02XmDdqcNeRGykTbVqOG9UF44JynHzEbLfmP3Bb+hqQrIlhrjcFD+4y7sdvesQIqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780686709; c=relaxed/simple;
	bh=SKp5A5HIZ5LbGgMxAlOWW38knJh5nsNKeP4rRRaOunY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AvMGROxhbNm3w+eNRtESdWOfvnJatwQfadb+Cyo3rkT0jqs+nImizxlicsx+XX7oqP5ci4cIO+mbRgtPBN0Rmv9i71Y2I4FskgxkzduAZotdHE2bNS1nS1wXhOH408SiIL4WL7U7x8fJcjl+U3pCzoV6IQk+i0+JIrUV3TH6vYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y8L6Xv72; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y8L6Xv72"
Received: from [192.168.1.6] (unknown [106.222.229.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id A29DA20B716A;
	Fri,  5 Jun 2026 12:11:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A29DA20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780686691;
	bh=g+C/A1n1XipAX/omglYkXyb1smfS0wsd04VTHPRIuFA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Y8L6Xv72+P63O7Se6Gq3ROF34iCXfCPtuO1QN/+yYOpGh2VvRMo+neGjZtzMZ+WxE
	 G1snnBsuBlDUHlu3GTvdsrznfWzTSvRTukKs4TCnusBIn+e7d+XVoIQwZkIiMlo9WV
	 rQ7eajfzOhIueP7REbuO8T1MF/Nxk0x7hCmpaCzg=
Message-ID: <43b4f0e4-e071-4e49-b1a2-b56303297c49@linux.microsoft.com>
Date: Sat, 6 Jun 2026 00:41:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hv_balloon: Simplify data output in
 hv_balloon_debug_show()
To: Markus Elfring <Markus.Elfring@web.de>, linux-hyperv@vger.kernel.org,
 Dexuan Cui <decui@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Long Li <longli@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>
References: <4f969d00-df24-4cde-8539-8cbe4a09f417@web.de>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <4f969d00-df24-4cde-8539-8cbe4a09f417@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 05/06/2026 18:20, Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Fri, 5 Jun 2026 14:44:54 +0200
> 
> Move the specification for a line break from a seq_puts() call
> to a seq_printf() call.
> 
> The source code was transformed by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   drivers/hv/hv_balloon.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
> index 9a55f5c43307..42ce27be344d 100644
> --- a/drivers/hv/hv_balloon.c
> +++ b/drivers/hv/hv_balloon.c
> @@ -1862,9 +1862,7 @@ static int hv_balloon_debug_show(struct seq_file *f, void *offset)
>   	if (hot_add_enabled())
>   		seq_puts(f, " hot_add");
>   
> -	seq_puts(f, "\n");
> -
> -	seq_printf(f, "%-22s: %u", "state", dm->state);
> +	seq_printf(f, "\n%-22s: %u", "state", dm->state);
>   	switch (dm->state) {
>   	case DM_INITIALIZING:
>   			sname = "Initializing";

Reviewed-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
