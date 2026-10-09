Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0847340401;
	Fri,  9 Oct 2026 06:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528724; cv=none; b=GOgdQSk8AW7irJF831EcI8LaLS2VsU7ZHKky7l9vwYYCnaSBtRxnX0CbGrAuL8PQGy3f4qOVKiGW35QZxH6S0Q9O7mQBDIrhPB3qN/n03Y2ToRw2bOR7NhVXAhAn3RmeOTEGlbnu5mUSDhfqHtYlN8uy1LP/gDUpzZhyGtuiLeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528724; c=relaxed/simple;
	bh=K+zcPdGKYhEz/GfXGMxYBlKNl9J2g0VW9XMuv82NXzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KF8IeMoxIDIsqcdZuBxqWOlwqlCpiLcB+wZmbzpV+G2vokiTv748LVu/HC4WTsnIR/Ybme8dfErU7EQJmeCVzUhOTV2VnAyV5T/9O6myfQNZ+4+pnnHMM2080CQNiThO0ZWsHcPFoXwL5fbISOhfdca/ZUgaBJrfpTTMe2U7Nvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Ggne8UvM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Ggne8UvM"
Received: from [10.95.65.84] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 395D020B716A;
	Thu,  8 Oct 2026 23:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 395D020B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791528722;
	bh=tzSyUMbaOVP4PqZjpoUmE5ENxFdraryzwtCBhVn0SF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ggne8UvMa+5nVG8g64tWRtb60F1gCaZM0Suf/oukOj2uYpX+kckKqMSZb9EmkchRz
	 N/FntKp/jymWswPnwdC9jTarcU/CnhOvGh1+yryMTgZe81a1rPjg25JJmM4cILbRSL
	 EcXKguPFQxZqxm15DiFxVS8xrxuWku3M5d8zm6a4=
Message-ID: <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
Date: Fri, 9 Oct 2026 12:21:57 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2026 11:24 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October 8, 2026 10:06 PM
>>
>> On systems with several fast NVMe controllers, completion interrupts can
>> keep returning to the same CPUs faster than scheduled work can run. Each
>> handler may drain only a small number of completions, but the combined
>> interrupt stream can still prevent scheduler and watchdog progress.
> 
> See this recent proposal [1] that sounds like it is addressing the same or a
> similar issue. And there is this [2] more global approach. It's worthwhile to read
> through the discussion on both threads. I haven't done a detailed comparison
> of either vs. your proposal.
> 
> Michael
> 
> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@bytedance.com/
> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-lrizzo@google.com/
> 


Thanks for sharing these Michael. I'll check more on these, and try it out.

Regards,
Naman
