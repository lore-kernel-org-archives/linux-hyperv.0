Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256884908CC;
	Mon, 12 Oct 2026 16:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791822290; cv=none; b=O1aPO5rGpbgZtWsPlHKZAV1vnEoLsWxw7v1Yjb5ivEXOQAz+8Qx6WyWpZOnCzwnJopkw2vt7ps8CeEtbhR7Zz7HXEaYVQ72ymsmyQ0P3P7dPHpIIIsYw/Sw/0wGX/2ZWwKJWLBpZOJ7GAlhF8DGJ+VdIaDoqRuafghck87A8Sg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791822290; c=relaxed/simple;
	bh=ZblkjcOsAUDKA+9cW+EuQoxfC9eX1nfik4gAAhizYas=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KS5ooRXkfp3A59tH18V00vjz8OWuAeZl6JiyEP9KcSalaHE5bv3okTz8QbVIb7Ebl322ro5c+Q9FiH24vZ7gmvvMomqYGWiHXmBJvKN3nRz8eN7g3jb9KbH9MLXTJ0xlQxhOkaEiHqs5bWzWPsM7QaqLc2JIC+vTdl0ayz25vpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=auFpsEqB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="auFpsEqB"
Received: from [192.168.1.70] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9B36F20B7166;
	Mon, 12 Oct 2026 09:24:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B36F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791822285;
	bh=gjubPOuxdvWHce9i4IPxOTkmVc5NCDr07T7TK4hmZvk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=auFpsEqBZP5CtAUsUXapXjiHxzL3yHdCBeIWvsSEpxJ2jaqJdVuHLgCmgl1tyBjlD
	 SwbWsRo7ypCwS0Lmq4EEZ1t4IFLm4BXqUMVFJEY4vADjN8+IA/uluugycMCOwzoEWy
	 GWLSXp/x4gR4qO5Ssazj8JKBL+6LCK30YpoKhci4=
Message-ID: <b3f3b6fe-893c-4a24-b8c0-3a929cb581ac@linux.microsoft.com>
Date: Mon, 12 Oct 2026 21:54:42 +0530
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
 <8aba4809-6655-4bfd-a83a-25c5ab816645@linux.microsoft.com>
 <aszuckZVkc2-kXM3@kbusch-mbp>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <aszuckZVkc2-kXM3@kbusch-mbp>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/12/2026 7:58 PM, Keith Busch wrote:
> On Mon, Oct 12, 2026 at 12:17:38PM +0530, Naman Jain wrote:
>>> The disable_irq_nosync still does non-posted transactions for msi and
>>> msi-x. NVMe has a shortcut for msi, but there's currently nothing for
>>> msi-x. For that case, I have a prep patch I consulted with Thomas, and
>>> the result is below. I'm delayed sending it out while catching up from
>>> travel, but I think this will be even more efficient.
>>>
>>
>> Thanks for sharing. I'll give it a try. IIUC, after your patch goes in, I
>> should be using disable_irq_nowait() in above and see better performance.
> 
> Yes, exactly. It should save hundreds of CPU cycles on every switch from
> irq to polling.
> 

Understood.

>> Please correct me if I am wrong. I'll monitor your patch in LKML for future
>> versions.
> 
> I need a user for the new API. NVMe is the only one I have in mind
> right now, so this new irq disable would have to be tied to the series
> that does the adaptive polling.

Acked. For this series, there are couple of solutions floating around in 
LKML, and we are trying to converge on the final approach. Once 
finalized, if we still need to call disable_irq_sync(), we can make use 
of this new API. In any case, if I happen to send the next version of 
this, I can use the new APIs, creating dependency on your changes.

Regards,
Naman
