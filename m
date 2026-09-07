Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C637F300;
	Mon,  7 Sep 2026 09:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788772914; cv=none; b=ZveS+DS8UZu7zmP51KVYCPD+fm6eLH5iSXEUFdXQ4jKy9sRBsj2TDJhvs/bsOBH0Wf9DNRnlDLmE5t8Dc1AYUn8SClP0sgJek3YiCrqnVGG42If7KdlMMy0GIByc1SMVpXTABCh3ZQetBOgcrnmxsO6EiAOlxLgIQ9Bpr+Jc1Fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788772914; c=relaxed/simple;
	bh=t4HVwL+CfSB3/5dXWTctaeJ66uVZqls+8Yc2VzWZ3Ag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qUzqJZzWpoiRQtV8m+zvGw+RB1Xze6XgWNpyEdf7lP97CaXE67oGxLlzzndha+fvLwxVDtR1uX8owBjfpJ5RNFuZ5LsBiquvzFWZ8cJODpBe+WtNhUD8Mm4tovJYlc1D+FHLrhznomYKOyh+iZ2l8cYOIMutpDMc+Q9J2TWCYHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bPr6HCmz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bPr6HCmz"
Received: from [10.95.64.224] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id E734520B710C;
	Mon,  7 Sep 2026 02:21:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E734520B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788772873;
	bh=V74XC9ZmOr8D3oNT40AbiLqYcwxnV5vD2AZ32zaDL7k=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bPr6HCmzgrnuy9vVJEj2qhBj92btJKwEIA73s4K3zNUxH29t7LFCPVsrZIWNk+NFO
	 0yZjw7Om6bq9VaV5Zw9gUMLcyxDyPFgXGnNoCpneYx1tjmS3a4b5I1A24K4LuMwCeA
	 QmLciKO6B1hTjS715Th2P9im9kZowZiavZZpPxmQ=
Message-ID: <f307de11-8915-47f9-a743-250296f10804@linux.microsoft.com>
Date: Mon, 7 Sep 2026 14:51:47 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] Drivers: hv: vmbus: fix typo "substract" in
 comment
To: Hemanth Selam <hemanth.selam@gmail.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>
References: <20260907044946.10813-1-hemanth.selam@gmail.com>
 <20260907044946.10813-2-hemanth.selam@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260907044946.10813-2-hemanth.selam@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2026 10:19 AM, Hemanth Selam wrote:
> Correct "substract" to "subtract", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches a comment, no
> code changes.
> 
> The subject prefix changed since v1, from "hv:" to "Drivers: hv: vmbus:",
> for consistency with the rest of the subsystem's history as Michael Kelley
> pointed out.

Hi,
The change-log (these 3 lines) go after "---" line as a comment so that 
these do not get propagated to the git log in kernel tree.

> 
> Assisted-by: Cursor:claude-opus-5
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---

Here.

Refer: https://docs.kernel.org/process/submitting-patches.html#commentary

Example: 
https://lore.kernel.org/all/20260907054742.235389-1-namjain@linux.microsoft.com/

Regards,
Naman

>   drivers/hv/channel.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index f4370617deac..c36ec14529b9 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
> @@ -79,7 +79,7 @@ static inline u32 hv_ring_gpadl_send_hvpgoffset(u32 offset)
>   	 * therefore leaving a (PAGE_SIZE - HV_HYP_PAGE_SIZE) gap.
>   	 *
>   	 * And to calculate the effective send offset in gpadl, we need to
> -	 * substract this gap.
> +	 * subtract this gap.
>   	 */
>   	return (offset - (PAGE_SIZE - HV_HYP_PAGE_SIZE)) >> HV_HYP_PAGE_SHIFT;
>   }

