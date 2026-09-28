Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57773AB286;
	Mon, 28 Sep 2026 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790613328; cv=none; b=SCp5Of/lLmpphcCGxfYr/3xdKvmBxCzxfJaL7sPyJ/7kjXBYav3sItHkwXK8T1BXMTnmVDhqxeU87ncmxMb0lFyMpeW4GVo8JYmelv0nsZkXJiHmQZTUlNOwEpqprCTGbkidQTiPjdc/SnKSh75p1Hyt7hW6HopScoRXYO3s0bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790613328; c=relaxed/simple;
	bh=fMIldVq79Vg1ECmLOXmgQTg3mIrwGbRobNNMz1KHyTQ=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=MOvSURJ16YESEpVeD9kQyV/LnwQOuIUU6Gm4V+y0zKGOtaDupqb38ytVfsu1Sfhg2K8ePr0fqgYZi4xMmM0cPGR/O0Wp3QbLJ+K+pJAZOteKrak0GLHx85a9H6FkCEiLpoGL+QLypJvUFxfGySz3ktmnm9hzea32DgFz5jBEX4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YIfPw0mx; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YIfPw0mx"
Received: from [192.168.229.253] (c-73-140-209-209.hsd1.wa.comcast.net [73.140.209.209])
	by linux.microsoft.com (Postfix) with ESMTPSA id D650420B7166;
	Mon, 28 Sep 2026 09:34:28 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D650420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790613269;
	bh=wJLUyjptW07lxscnylQF0hc3+nh6crOCKYUu/8hQv00=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=YIfPw0mxbgHKXRVVn3JFMRSbuVnb2fVSpG9ZH2jLIqeUWifrjaZg8TbaoiFnAHRYD
	 CRmtTi3CB/jqI7Sh4So26Hzeb6wIxt1y+23dJtqCykCU/zsgsNZ8auhjHCtx84I5m+
	 5P7r/5NFaWhDKW88DlXkp+J8wcVVYdJK88zBlPE4=
Message-ID: <9f5a919a-5255-4dca-9e83-f124dfec872e@linux.microsoft.com>
Date: Mon, 28 Sep 2026 09:35:22 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: Mukesh R <mrathor@linux.microsoft.com>,
 easwar.hariharan@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-arch@vger.kernel.org, jacob.pan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V1 3/3] x86/hyperv: Implement root VM IOMMU kernel only
 driver
To: Jason Gunthorpe <jgg@nvidia.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-4-mrathor@linux.microsoft.com>
 <179060271395.122959.9162511491972155683.b4-review@b4>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <179060271395.122959.9162511491972155683.b4-review@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/28/2026 06:38, Jason Gunthorpe wrote:
>> [ ... 103 lines skipped ... ]
>> +/*

<snip>

> 
>> +
>> +static void hv_iommu_get_resv_regions(struct device *dev,
>> +				      struct list_head *head)
>> +{
>> +	struct iommu_resv_region *reg;
>> +
>> +	/* reserve the entire LAPIC region */
>> +	reg = iommu_alloc_resv_region(0xfee00000, SZ_1M, 0, IOMMU_RESV_MSI,
>> +				      GFP_KERNEL);
> 
> There was some discussion to make a helper for this, I don't see it
> merged yet..
> <snip>

Hi Jason,

That's patch 3 of the Hyper-V guest IOMMU driver series here:

https://lore.kernel.org/all/20260904075512.174154-1-zhangyu1@linux.microsoft.com/T/#m248fd782be21c7fdb79c97b1764658e6c3c5f623

That's awaiting an ack from you and Joerg to be picked up for the next merge window or additional feedback
for the past couple of weeks.

Thanks,
Easwar (he/him)
