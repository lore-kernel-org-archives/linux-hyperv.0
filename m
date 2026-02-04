Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F582274FDF;
	Wed,  4 Feb 2026 01:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770168942; cv=none; b=HUQlJcIqCO+hNk1wwClNJ1FArm8cViMnCpOkS9WJDYIKqNIl2CMPGrZWi+KWzGciReN2PDF2wFWcRl2fRKOfBJ6n3qf7JOtUXNUUua7h4HkuYsmfpaIcyZGfFmr48GKrEaz9wLDI0JHVcgVnldBl7/nLs4Vhj350UiK8PH5dmQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770168942; c=relaxed/simple;
	bh=/rQhPV/v276KahwnQo4Vq3jBxiqD5+w6OPOfwGtw4rs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iRR2mqiIk2asxui2csV9dX5AbpN2Th4h8foEX6n7E61+f9o4QuqdzYKsdtZKPQsHlu6cEh3VgrJLji7kRq1o6A8EvR+Bw7V/6V+XibrXuHQy5bnInfBdwTv9OnqX91eI2xDvNPv9REYuiEiFwI81nYX6fG97gunszJXq0PUJ/kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lYaIfl1N; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lYaIfl1N"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id E2E7920B7168;
	Tue,  3 Feb 2026 17:35:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E2E7920B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770168941;
	bh=cM00EVjRHqFZFDl8PsjAvnC7pPmVoJVnGLcJEur/+xY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lYaIfl1NI/KFpAwRDi8++0/5tTipvWjsr0QiNnOni0rWBH8ZIBfUHgMcgC8SLOMGe
	 w7LGigFCQFqCKtifQdx2bxDwrrfChap1j45gAsKhz9nXy4fZC0aVDWB+wia4S9f8IB
	 wiSRIKAqwn8aYgAOolwP7IkWYftAxS1akLM0ERSc=
Message-ID: <9904b018-7a14-4648-073f-8a7599097ddf@linux.microsoft.com>
Date: Tue, 3 Feb 2026 17:35:40 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v0] x86/hyperv: Move hv crash init after hypercall pg
 setup
Content-Language: en-US
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 wei.liu@kernel.org
References: <20260203224121.26711-1-mrathor@linux.microsoft.com>
 <ae52e158-d138-4344-ab0c-74b2fae56ddb@linux.microsoft.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <ae52e158-d138-4344-ab0c-74b2fae56ddb@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/3/26 16:25, Easwar Hariharan wrote:
> On 2/3/2026 2:41 PM, Mukesh R wrote:
>> Fix a regression where hv_root_crash_init() fails a hypercall because
>> the hypercall page is not fully setup. The regression is caused by
>> following commit:
>>
>> commit c8ed0812646e ("x86/hyperv: Use direct call to hypercall-page")
>>
> 
> Is that the right commit? The named commit was merged in v6.18-rc1 and
> hv_root_crash_init() was only merged in v6.19-rc1...
> 
> Thanks,
> Easwar (he/him)

Ah, you are right. I guess that commit was not in our internal
hyper-next mirror, so testing did not reveal the issue and I did not
notice it. Because of few missing things, we've to use internal mirror
to test. Anyways, will fix the commit and resend.

Thanks,
-Mukesh
