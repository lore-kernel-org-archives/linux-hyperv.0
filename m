Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415B23F4DF8;
	Mon, 27 Jul 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151490; cv=none; b=he63GWOkCM3LHKmODGUXyisRo/6PKBjC9bZV9/TNix7zygsULuUssDcBFS6fy89V4SGjOoga/U6c6M7kJ8n+h1EsamSdtM25/AW8oSgXLixOC+Tp9BC+AOEnBZs+nTMtaf3UiUBe1Kq84xs0dDg+SXPX2/+tnLFy654uURCOYiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151490; c=relaxed/simple;
	bh=IDo68A6luGgxre2Ydpce/neMMx8WmDs9e61Nn2/z0Oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SiC9msxADbX69dv6dIPTR9vD6MaZAOXA3HTDCGlNk0nNn0IfE/9yokemMktNG+ZfiOTMVx2iUzhULEZMtXM8sW2g0kD/zE3okdUAg81+pHU+8iQcI/7S2FeL5FtRyiPN2dgHmWxHYieY9L1Iz+xswx/CjX8INHWusk2KpowkqyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IlHB6spb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IlHB6spb"
Received: from [100.67.193.28] (unknown [52.163.71.154])
	by linux.microsoft.com (Postfix) with ESMTPSA id B865220B7166;
	Mon, 27 Jul 2026 04:24:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B865220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785151473;
	bh=yWcKcF9CSBilJ8GH5TNkgtogAM3W1405I1HBlBT2isA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IlHB6spbBWSo4EF2L6o55hdt5CAN1vmdFDKFfwXAUds6aHPSbHxbPoBklJEQwavXK
	 HUVssWAHsOaJ+IYLym/0jw7uzzYkhQXDyAlfTk1KQuPTSn39k4+1ACT4jRY/9FNR4u
	 rxrvY0Yc9BgOFb5hEG2IuvMAOuBQlymVFsBe55mQ=
Message-ID: <5b7bd70d-8fbf-44c5-b5ce-0ce729db9cc1@linux.microsoft.com>
Date: Mon, 27 Jul 2026 16:54:41 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: mana: Return error code from mana_create_rxq()
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 ernis@linux.microsoft.com, horms@kernel.org, dipayanroy@linux.microsoft.com,
 shacharr@microsoft.com, stephen@networkplumber.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 gargaditya@microsoft.com
References: <20260718024818.560552-1-gargaditya@linux.microsoft.com>
 <20260723090621.6261a3e8@kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20260723090621.6261a3e8@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23-07-2026 21:36, Jakub Kicinski wrote:
> On Fri, 17 Jul 2026 19:48:18 -0700 Aditya Garg wrote:
>> Change mana_create_rxq() to return an int and pass the created rxq back
>> to the caller through an output parameter. The caller now propagates the
>> returned error code directly instead of substituting -ENOMEM.
> 
> We generally prefer the use of ERR_PTR to output arguments in
> the kernel. Looks like it'd work here nicely.

Thanks for the review Jakub,
I'll post a v2 using ERR_PTR/PTR_ERR

Regards,
Aditya
