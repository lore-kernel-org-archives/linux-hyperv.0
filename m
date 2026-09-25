Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADBA0258EF9;
	Fri, 25 Sep 2026 00:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790296205; cv=none; b=XNpKwbZc2DTUKFu6n/JIC/Blh8AEWa8tahxk1HfbNqcl/XtYxkd1E00X8ftuU4o11nJuS+Ay/Q/ji+IgiPfTk9mc/M5yF9oSevdmUamIX2vsXPUsXd3WtAiNkg9Oz4qUsN8xoLyOG1hYOJfLU3iTVHIhEFj6d59oh2XG6WSzBJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790296205; c=relaxed/simple;
	bh=RfJ+pCDi1ZUjWqufhcIPMDMVXH9G9qtEx38d1vGukQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+4IwMg15vEvcP5K9JkYf3nBFNLcrlMmgNkHL6Tqfkof5PdFrZ/dSbiQLZ20TvzBxKuwzdnHAe8aNisNZBzf+ODrvKU5jaQD/WSYQXyyE7eE89z+a7TLsmY4kuca7Ya/nVZ7uBcmRa5qhQHPWEMg1d7HfiGOeroULDKAtuygRKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pARK0JrO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pARK0JrO"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2492120B7167;
	Thu, 24 Sep 2026 17:29:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2492120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790296154;
	bh=5cFrqqqN1Z7FFrVFTvPFQupZpTEiWB43yHPdJggxGlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pARK0JrOkof2YKhGQm2YQUBtivNK/VWS/3zPWZhbAtFTG5dWs5BYOJ0jlO2QHjJ4o
	 6HRQajYlmLM7R10Xe5EZBzrVrsOfoSa3hnlON1wt+jRk0+GYEjoski1WcKW6ZOCRi2
	 7Qzj95SQ69XospBsP0swi8ybIU8YhY6k97NM/1fM=
Message-ID: <7363cfd4-31f0-451f-0cf5-879e878b30ef@linux.microsoft.com>
Date: Thu, 24 Sep 2026 17:30:02 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v3] drivers/hv: remove deposited pages from direct map
Content-Language: en-US
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
 Souradeep Chakrabarti <schakrabarti@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, Magnus Kulke <magnuskulke@microsoft.com>,
 Long Li <longli@microsoft.com>, linux-arch@vger.kernel.org,
 "K. Y. Srinivasan" <kys@microsoft.com>,
 Anirudh Rayabharam <Anirudh.Rayabharam@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
 Wei Liu <wei.liu@kernel.org>
References: <20260917201052.2123701-1-magnuskulke@linux.microsoft.com>
 <a543145c-4503-bdd8-bd73-a2cbcce1e06e@linux.microsoft.com>
 <aq0W/c9SKCympVHE@example.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <aq0W/c9SKCympVHE@example.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 9/18/26 03:48, Magnus Kulke wrote:
> On Thu, Sep 17, 2026 at 05:23:15PM -0700, Mukesh R wrote:
>> On 9/17/26 13:10, Magnus Kulke wrote:
>>
>> FYI:
>>
>> https://lore.kernel.org/linux-hyperv/20260912000318.2959621-1-mrathor@linux.microsoft.com/
>>
>> Thanks,
>> -Mukesh
>>
>>
> 
> Thanks, the change to a larger single page makes sense. I assume we
> would still be susceptible to a #GP once the kernel steps into it?
> 
> Since this is addressing acute crashes on L1VH, it would be good to
> merge a fix first IMO. it can then be easily cherrypicked into
> backports or distro-kernels.
> 
> Or would you rather see the problem addressed as part of in your
> deposit-pages refactoring?

no, we need to backport deposit-pages also (it is already in the
internal 6.18) as not only it enhances the deposit, but also fixes
couple bugs, so best to keep this separate. the deposit patch does
address your comment:

  +     HV_DEPOSIT_MAX is capped at 511, so a deposit range cannot cover
  +    * a 2MiB page, so deposited pages are of 4k granularity and cannot
  +    * be collapses into a 2MiB page, which would require an allocation
  +    * and can potentially fail.

IOW, as soon as it's merged, above will not be true always.

Thanks,
-Mukesh

> best,
> 
> magnus

