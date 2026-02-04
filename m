Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DEF23C51D
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Feb 2026 20:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770236659; cv=none; b=VeIa3/TaHn+rrQ/ZEEkGtt+E7rk/bb+SEizahyeHYChUfKz+u2TjzK+Tb1sMVbsd7YTPv9Bn2IOFul/ao7K0jW1VTgEUZb6sM8Cnz9nHUEiI8bfmhFCbMh+hDU0WNdS2Emchky/gODjSv+Zh7YHHZMRZS580k3lWOinWH471n9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770236659; c=relaxed/simple;
	bh=loaiiTuLVVFm+xzUg/j8C/5oKnIfuWFsGrFqEILaayA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kbLAiG79APeQbOW/dZHvwqsm12oBDPT5gaLaGVdRnhhYRtZP9H5t00IcGx8KjToMv9/CNzwv8BaWpQhdH7c3A6v1RbCQcKxnS34hTxTWa5FrsfzCzimiGQjW5BOw4jjkPhp+MyqaPIlb3bf49K8zTpeF8cntrco1HgTTjaBCRQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=j5Xf056Z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="j5Xf056Z"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86D7620B7165;
	Wed,  4 Feb 2026 12:24:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86D7620B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770236659;
	bh=x77o/yONEpfb4yF7y0leezNiiVUyk6kz5pCKv4/XQkU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=j5Xf056ZYcQywqTUe9Hlh1fjmePZL/1RMQWyphj8LROQPhNj2ArEFCnpTXMfo64qV
	 d6MmqV+dKd/f1razDtNgvS1xMguExnZxq6CdI3Nzq21fjRonehCenMNj1rs4CBaeqQ
	 XGvYWLCaQjSntnGsUhV+ZHSdxpd67rzXY7tKgPVk=
Message-ID: <0647b8f6-f12c-4307-fdd9-9a523b58946d@linux.microsoft.com>
Date: Wed, 4 Feb 2026 12:24:18 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2] mshv: make certain field names descriptive in a header
 struct
Content-Language: en-US
To: Wei Liu <wei.liu@kernel.org>
Cc: linux-hyperv@vger.kernel.org
References: <20260116224904.2532807-1-mrathor@linux.microsoft.com>
 <20260204060620.GB79272@liuwe-devbox-debian-v2.local>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260204060620.GB79272@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 22:06, Wei Liu wrote:
> On Fri, Jan 16, 2026 at 02:49:04PM -0800, Mukesh Rathor wrote:
>> When struct fields use very common names like "pages" or "type", it makes
>> it difficult to find uses of these fields with tools like grep, cscope,
>> etc when the struct is in a header file included in many places. Add the
>> prefix mreg_ to some fields in struct mshv_mem_region to make it easier
>> to find them.
>>
>> There is no functional change.
>>
>> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
> 
> I generally don't mind such changes, but this patch doesn't apply
> anymore. Please rebase to the latest hyperv-next.
> 
> Wei

Done, please find V3. Thank you.

-Mukesh

