Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4E3359A86;
	Wed, 25 Mar 2026 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774478262; cv=none; b=llWJ/fJD8HQOriIrVVQ9y2uccOMkv/45hmIEPYht5HT8VMH+tBW3ZWlC8Nxud/ImzrkjgN/nfJRqWAklZXEyDyULW/6dVZl2/FSuE9LBGgc06GOz+obeShdEvcvw6GfnwsGClbem5UxxpeVTcF2zZ3/8JI019+rSEOQ+wPl/TLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774478262; c=relaxed/simple;
	bh=kKPuPuAq9+WjwY+8bFx3gRSsb1PSLfDwWJDP1gG8QaM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mDLs3hLQpCBw5qj33/8KqYknlCMcfpj/rJnMyjLsCKZaJAuKeJ4bZW1wUno+jrUj5lqGnv8lc9iKqLNBUnhTwQmA9ItCnrNSngaSpDdOqyOGgD/OKigV4OlWTykXbDHs4/qtEOzzIwIsQIckY913yWbPh+LYn3IY+4BToA5Bwo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=rOwmMSZf; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="rOwmMSZf"
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4fh1xk2Sqhz9tp3;
	Wed, 25 Mar 2026 23:37:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1774478250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M1dqCCnolwl7xvMLB69ztd09Es3YIuxQBKsw4YJ4KhQ=;
	b=rOwmMSZfviohmKchsOopSe+aH1zOmXSXhChifFJrNIz6gD5BfaI4WaOMhyydtHc0bOej40
	drCZG3xtP1Y1vHVUdrTko9afKEzr/8qgqPAMz0+y9n2F9YBuGclRZ17/hJTPGJJ7gcYafU
	odR1e6BsAgCMc3XVVM8EfMuNaS3PIeBFox0YwplodA1AHp0bzBOqaQKFxKe4YLB1M2WykZ
	tkyu9bcno+YfKaPWP2FPG9sXi3xESZnER5+/CJlwXAbudaH2BQFMon+XkxSU6+YBSTh271
	FQPJqwAb7fazYkLOCpHWCrbFo394U5EByjgAi2LD6709OY8fHDpM+kKcW5YYCw==
Date: Wed, 25 Mar 2026 14:37:26 -0800 (PST)
From: vdso@mailbox.org
To: Junrui Luo <moonafterrain@outlook.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Mukesh Rathor <mrathor@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Roman Kisel <romank@linux.microsoft.com>,
	Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: Muminul Islam <muislam@microsoft.com>,
	Praveen K Paladugu <prapal@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	Yuhao Jiang <danisjiang@gmail.com>, stable@vger.kernel.org
Message-ID: <1907009368.292168.1774478246295@app.mailbox.org>
In-Reply-To: <SYBPR01MB7881689C0F58149DD986A6D1AF49A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881689C0F58149DD986A6D1AF49A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Subject: Re: [PATCH] Drivers: hv: mshv: fix integer overflow in memory
 region overlap check
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-MBO-RS-META: ou4i7fwsc97c76z1zfkuxyp7gmk7yuq5
X-MBO-RS-ID: b4273cbd46c7ddf2afe


> On 03/24/2026 9:05 PM PDT Junrui Luo <moonafterrain@outlook.com> wrote:
> 

Hi Junrui,

I think that checking for overflow as implemented can be improved.

`guest_pfn` is a guest page frame number (GPA/page size). Hyper-V uses
page size of 4KiB (`HV_HYP_PAGE_SIZE`). On x86_64 GPAs are limited to
52 bits, and max GFN = (1<<52)/(1<<12) = 1<<40. On ARM64, 52 bits is
also the limit for the bits used in GPA. Thus checking for overflowing is
not the only thing needed here because _well_ before overflowing there is
that (1<<40)-th GFN which is problematic as using it or going above means
going over the arch limits of bits used in GPA (the processor won't be able
to map the memory through the page tables).

So we could check for (1<<40)-th GFN, too. That is, if we'd like to return
an error early instead of trying to do physically impossible things and
erroring out later anyway.

Perhaps something along the lines of

|  if (mem->guest_pfn + nr_pages > HVPFN_DOWN(1ULL << MAX_PHYSMEM_BITS))
|      return -EINVAL;

could be an meaningful improvement in addition to checking overflow which
alone doesn't take into account the specifics outlined above.

If folks like that, maybe could hoist an improved check out into a function
and apply throughout the file.

--
Cheers,
Roman

>  
> mshv_partition_create_region() computes mem->guest_pfn + nr_pages to
> check for overlapping regions without verifying u64 wraparound. A
> sufficiently large guest_pfn can cause the addition to overflow,
> bypassing the overlap check and allowing creation of regions that wrap
> around the address space.
> 
> Fix by using check_add_overflow() to reject such regions.
> 
> Fixes: 621191d709b1 ("Drivers: hv: Introduce mshv_root module to expose /dev/mshv to VMMs")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/hv/mshv_root_main.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 6f42423f7faa..6ddb315fc2c2 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -1174,11 +1174,16 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
>  {
>  	struct mshv_mem_region *rg;
>  	u64 nr_pages = HVPFN_DOWN(mem->size);
> +	u64 new_region_end;
> +
> +	/* Reject regions whose end address would wrap around */
> +	if (check_add_overflow(mem->guest_pfn, nr_pages, &new_region_end))
> +		return -EOVERFLOW;
>  
>  	/* Reject overlapping regions */
>  	spin_lock(&partition->pt_mem_regions_lock);
>  	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
> -		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
> +		if (new_region_end <= rg->start_gfn ||
>  		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
>  			continue;
>  		spin_unlock(&partition->pt_mem_regions_lock);
> 
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260325-fixes-9a58895aea55
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>
