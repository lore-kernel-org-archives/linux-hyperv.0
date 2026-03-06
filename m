Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6002136C0BC;
	Fri,  6 Mar 2026 03:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768656; cv=none; b=m5QVosBg5eiQPLxPB1MJi6gRPqr/+B5ugKHSSgj3ZzjScj2ZUiCcBvm6RJ6D1/5suKLxe/GXFuJGJ38k+r2XI3A/gpqWlDtkTIoT0iVgjreWTCkFFb69OGDbdGr3KqtWNpCgFkvYnXMUc06pmKmtG9yG+Nh/pneMgjUw3/kuxFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768656; c=relaxed/simple;
	bh=JNT0vjJuz/KBv011eww8vYCCrQEKrmKgCyppsMpLzu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AkBvofqSeH/SJjvJ86wvyPOFloCF9ZT1ffQ682QBlUZG9yIRTTBQ/n5mOm7Xe1akCNZyKV3gClUdZIA2/c4dqT5a9Q0pfFmnY9vFlG8g6GpZIBJUC2FpazkKLRxEXZWNBvhmhFBhrX9jF2mO1nvGOzDmnFQGOeLVEIReMKT0eW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lbTbZMwC; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lbTbZMwC"
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7DB8C20B6F02;
	Thu,  5 Mar 2026 19:44:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DB8C20B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772768654;
	bh=OaysICBarmTwk634PqTq4ITRekvu9Nhr059+RMSlGT4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lbTbZMwC6ZQzSwT9TJZoTIOdvoaQl1ydoqxPwdEoqq2MqjOM0KpMmvihSNHNNReVd
	 dS8N7zzp9vcNXoLnqZp8ak9Pa0vvhVX+ZXVcesYuGlkjqVxmAbRicYAfzGdnJ6x192
	 az5Wf5UFIx3n5tpK75gH2RXLcYXcTikCmsmaslj8=
Message-ID: <d32d73d6-aa89-a587-6c41-b934ac26bd27@linux.microsoft.com>
Date: Thu, 5 Mar 2026 19:44:14 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH 0/4] mshv: Fix and improve memory pre-depositing
Content-Language: en-US
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
References: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/3/26 16:23, Stanislav Kinsburskii wrote:
> This series fixes and improves memory pre-depositing in the Microsoft
> Hypervisor (MSHV) driver to avoid partition and virtual processor
> creation failures due to insufficient deposited memory, and to speed
> up guest creation.
> 
> The first patch converts hv_call_deposit_pages() into a wrapper that
> supports arbitrarily large deposit requests by splitting them into
> HV_DEPOSIT_MAX-sized chunks. It also doubles the deposit amount for
> L1 virtual hypervisor (L1VH) partitions to reserve memory for
> Hypervisor Hot Restart (HHR), since L1VH guests cannot request
> additional memory from the root partition during HHR.
> 
> The second patch moves partition initialization page depositing from
> the hypercall wrapper to the partition initialization ioctl. The
> required number of pages is determined empirically. Partitions with
> nested virtualization capability require significantly more pages
> (20 MB) to accommodate the nested hypervisor. The partition creation
> flags are saved in the partition structure to allow selecting the
> correct deposit size at initialization time.
> 
> The third patch moves virtual processor page depositing from
> hv_call_create_vp() to mshv_partition_ioctl_create_vp(). A fixed
> deposit of 1 MB per VP is used, which covers both regular and nested
> virtualization cases. Deposited memory is now properly withdrawn if
> VP creation fails.
> 
> The fourth patch adds pre-depositing of pages for guest address space
> (SLAT) region creation. The deposit size is calculated based on the
> region size rounded up to 1 GB chunks, with 6 MB deposited per GB of
> address space. Deposited pages are withdrawn on failure.


Can't we just get away with changing deposit for most cases to just
2M? My theory is with that we won't really find any measurable
performance hits, and it keeps things simple.

Thanks,
-Mukesh


> ---
> 
> Stanislav Kinsburskii (4):
>        mshv: Support larger memory deposits
>        mshv: Fix pre-depositing of pages for partition initialization
>        mshv: Fix pre-depositing of pages for virtual processor initialization
>        mshv: Pre-deposit pages for SLAT creation
> 
> 
>   drivers/hv/hv_proc.c           |   58 +++++++++++++++++++++++++++++++++------
>   drivers/hv/mshv_root.h         |    1 +
>   drivers/hv/mshv_root_hv_call.c |    6 ----
>   drivers/hv/mshv_root_main.c    |   59 +++++++++++++++++++++++++++++++++++++---
>   4 files changed, 104 insertions(+), 20 deletions(-)
> 

