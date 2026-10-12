Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524C12DECD3;
	Mon, 12 Oct 2026 06:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787664; cv=none; b=PEfKboUB6ZH8CFmUR8dX8xcjpCV4ZU1cz8KvRKFgBO+kXCN3lgWo4pJ4KcWEygFwVIL/syyt47tmWwqbAWkOrbgF7S3P/tIUOHXj70cS5YlwekKoWtu3Uge5YlUfgfkfMA0g2ypw+14mmmvQj/vyWKV07uo2Y6/8gkFeXX8H/8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787664; c=relaxed/simple;
	bh=tO+J142F5P3EOuWcl0MfqNEcutaeaDuQS8iUcbYvdHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6Ci9jythDKmg8MK5oKbw/f5AhZ07vCZGjnKI55JdBFbGfHaNgGJ+tESB0opa8EcqnGlipeojUqnLNyJjycp9GQY2NV0dv+IoafGZJqmBy3awuzVdOmy5UkjbLi1XpuARnBqPBoCpejH5ZfJCdZPQ3PZCyV4UGq2aDSSkE9sZ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dw3/VxE9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dw3/VxE9"
Received: from [10.95.64.165] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3472120B7166;
	Sun, 11 Oct 2026 23:47:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3472120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791787660;
	bh=/KXn2Mae47AvoKafUjW5cAwSLHA0Ei67hf+ZpEdJmV8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dw3/VxE9wlO75SFlUpXhbWSw4ayQLfs23MInfKvBPVc4K03c1/hqDU4MY3v65IM09
	 GuTD8dwrZ+lZX20TqgfHb5q1Ihw+59rdHKDIRRD+5vfTvqrjp0UsNeGU/rJUHL4Xkq
	 hDhMvWJejrCbgxTruQhVgn9l5iygO2IzeDDhT6Z8=
Message-ID: <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
Date: Mon, 12 Oct 2026 12:17:38 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 3/3] nvme-pci: defer completions when rescheduling is
 needed
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <20261009050556.2817978-4-namjain@linux.microsoft.com>
 <askIoNon8UVyNJiJ@kbusch-mbp>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <askIoNon8UVyNJiJ@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2026 9:00 PM, Keith Busch wrote:
> On Fri, Oct 09, 2026 at 05:05:56AM +0000, Naman Jain wrote:
>>   static irqreturn_t nvme_irq(int irq, void *data)
>>   {
>>   	struct nvme_queue *nvmeq = data;
>>   	DEFINE_IO_COMP_BATCH(iob);
>>   
>> +	if (unlikely(test_and_clear_bit(NVMEQ_IRQ_POLL_HANDOFF,
>> +					&nvmeq->flags))) {
>> +		if (!nvme_cqe_pending(nvmeq))
>> +			return IRQ_HANDLED;
>> +	}
>> +	if (unlikely(test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
>> +		     (!test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) ||
>> +		      test_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags) ||
>> +		      READ_ONCE(to_pci_dev(nvmeq->dev->dev)->error_state) !=
>> +				pci_channel_io_normal)))
>> +		return IRQ_HANDLED;
>> +
>> +	if (unlikely(in_hardirq() &&
>> +		     test_bit(NVMEQ_IRQ_POLL_INIT, &nvmeq->flags) &&
>> +		     !test_bit(NVMEQ_IRQ_POLL_PAUSED, &nvmeq->flags) &&
>> +		     need_resched() && nvme_cqe_pending(nvmeq) &&
>> +		     !test_and_set_bit_lock(NVMEQ_IRQ_POLL, &nvmeq->flags))) {
>> +		set_bit(NVMEQ_IRQ_POLL_MASKED, &nvmeq->flags);
>> +		disable_irq_nosync(irq);
>> +		irq_poll_sched(&nvmeq->iopoll);
>> +		return IRQ_HANDLED;
>> +	}
> 
> The disable_irq_nosync still does non-posted transactions for msi and
> msi-x. NVMe has a shortcut for msi, but there's currently nothing for
> msi-x. For that case, I have a prep patch I consulted with Thomas, and
> the result is below. I'm delayed sending it out while catching up from
> travel, but I think this will be even more efficient.
> 

Thanks for sharing. I'll give it a try. IIUC, after your patch goes in, 
I should be using disable_irq_nowait() in above and see better 
performance. Please correct me if I am wrong. I'll monitor your patch in 
LKML for future versions.

Regards,
Naman
