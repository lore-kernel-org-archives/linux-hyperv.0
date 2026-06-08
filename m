Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 829E232BF5A;
	Mon,  8 Jun 2026 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780893843; cv=none; b=L3pWnZICMgoEtWdnf1SPcOywUwR4GZ2ANovabIkn7krdQ8qWqwS23jzMpAdY6qgSUcSJcksjCzq++guedGdQ9K+Thvm+GFzhODuOttlAYBo9z/ZkHHo7UqZ56znnJggkII/0EFaeUVmjuyGHaXtc5khL37MOdy+UB34CrZhNg+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780893843; c=relaxed/simple;
	bh=bEQA/GxUIVi+8OVTZ2O/kfCxWO2fjdAdbUtXnz6dhWc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pLdWu9gBnxcH/4RPU7dg+UY78RETknPw7c9BwTsClRsZa4CkrOUxxUp6sLYXNvhUnmPc5nvic17Pahi3tRv/2hffUyYZgh/GyB0FMUgxA0qOj/qV1FlWEfrR3AszHmcUkoHpyJ6ITzpioprSvqiaZ+N9ENvyr03GShZowA8YBoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AE00LieU; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AE00LieU"
Received: from [10.18.189.188] (unknown [167.220.238.220])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8594C20B7166;
	Sun,  7 Jun 2026 21:43:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8594C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1780893825;
	bh=wYKrgO8LginE++yguspy37Ps284wCQjptPjsoEmmma0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AE00LieU1Ej+YX/kl6T2rCVqSFhht9nO013icXCqdpir/VQetkIx0qooMjqogfu/c
	 8vdszPshQNaVgf5sQf8dk6xEFeryevVOxMB/NH08XhJyboWZ8jFz62ce7wFlli0hJV
	 IlYbKKlw1NMMn7MAwsI//oV6QPfKpjRcGT6JfjnM=
Message-ID: <be4538a8-88c8-474c-bbb5-7a2a52fa2e5c@linux.microsoft.com>
Date: Mon, 8 Jun 2026 10:13:55 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] net: mana: fix error-path issues in queue setup
To: Jakub Kicinski <kuba@kernel.org>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, shradhagupta@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, ernis@linux.microsoft.com, kees@kernel.org,
 shacharr@microsoft.com, stephen@networkplumber.org,
 gargaditya@microsoft.com, ssengar@linux.microsoft.com,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260604080137.1995269-1-gargaditya@linux.microsoft.com>
 <20260605182748.5f106575@kernel.org>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20260605182748.5f106575@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06-06-2026 06:57, Jakub Kicinski wrote:
> On Thu,  4 Jun 2026 01:01:24 -0700 Aditya Garg wrote:
>> Two error-path fixes in MANA queue setup, both surfaced during Sashiko
>> AI review of a recently upstreamed patch series.
>>
>> Patch 1 initializes queue->id to INVALID_QUEUE_ID in
>> mana_gd_create_mana_wq_cq() so that a CQ creation failure before the
>> firmware id is assigned does not NULL gc->cq_table[0] and silently
>> break whichever real CQ owns that slot. This mirrors the existing
>> pattern in mana_gd_create_eq().
>>
>> Patch 2 guards mana_destroy_txq()'s call to mana_destroy_wq_obj() with
>> an INVALID_MANA_HANDLE check, mirroring mana_destroy_rxq(). Without
>> it, TX setup failures lead to a firmware-rejected destroy of (u64)-1
>> and a spurious error in dmesg.
> 
> Looks like these patches were generated against net-next, please rebase:
> 
> Applying: net: mana: initialize gdma queue id to INVALID_QUEUE_ID
> Applying: net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check
> error: patch failed: drivers/net/ethernet/microsoft/mana/mana_en.c:2351
> error: drivers/net/ethernet/microsoft/mana/mana_en.c: patch does not apply
> Patch failed at 0002 net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

Thanks Jakub for pointing it out.
I'll rebase against net and post a v2

Regards,
Aditya
