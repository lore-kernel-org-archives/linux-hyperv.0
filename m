Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793854275;
	b=gZD12nYNv75JBopK8O8fGhG3pZuRIFGnwF6HaIhScYC/kEuIDdRxK6MU7LGb2mDTLhBH
	 sG3TpiSxseqhGTAVCVLacUWYPfmEy5y+3z479FEShcqGUF0RnCSHzBYfuteHn/uAeh0lV
	 Glaik4ts0RNTiVYEd0/g8Qemx6kkQ/S3kTUrnRwKRvk2tbG0eHW+tgLaGQDQeeE/7/E0z
	 YSN6TcTIks4lDtNuRcTpmgNN5zbdP/M5TWbfII/AJqfCVmOfq2nKpQqFgte6q1YYWPQGh
	 WkHk1LbSdNMeYuJYeMRsAmLEEGrs0YAB4mglojGB1C/tu5I/blAm+Yx7jY9GP8ZxdUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854275;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=Vfq0TNvq9NyO6vZuuRepnN0RAUv+v8/WWoekttVAPv8=;
	b=YWA5CPcGA/+uST7fRxbB2kBycAyN54UJtLrBOylbsaW6B2d0Jb0XizRL329nE/075SRn
	 y3WtH5xe/DIAl3iMTfVQh+Dej8SFSqK1mZH8fTLVFldaFCh0zpnZXEIci0ADceXH46wHc
	 VxOct4ySuSQG+v2Qltk0BC1Y639oA6lwH23KMojxabdv4kjA6JIDbX78e2XNFXyCSp8sy
	 7UqX8zEpgWoxHaAcArSAMzx12iTbrtl8lE6iPA6fbaEKuUduzlBcmeOg950bqy9+V1qSR
	 SyRdnJeo7kbtBgchRfAL2dPfj0Dlww8QaESNfzhNkDPYVowbY2FVZk2r5Ubq0SBCMag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=AJHZK9nw;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A90A606A32D;
	Thu,  5 Nov 2026 04:51:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7A90A606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=AJHZK9nw
Received: from [100.64.64.82] (unknown [40.65.108.177])
	by linux.microsoft.com (Postfix) with ESMTPSA id 97FFC20B7166;
	Wed,  4 Nov 2026 20:50:58 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 97FFC20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793854259;
	bh=Vfq0TNvq9NyO6vZuuRepnN0RAUv+v8/WWoekttVAPv8=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AJHZK9nwC4tnOrfHJNHtkpHk+FMamxle8J5hrQ1pVAX217lTXHiqZRdtWuBxanIBP
	 IfnQIUbmv2LfhtS+4+iS2FGpjWghkXohvNgel+yQb83rxpeKRu1n9pucxd+bp/H3Yr
	 qCHU/GPgYUtxa1yhRR1EFtpWTZPFP4kuLgJ8ODQY=
Message-ID: <3a436266-89e5-4471-83df-4f25e09f11fe@linux.microsoft.com>
Date: Wed, 4 Nov 2026 20:51:13 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V4 1/5] mshv: Add gfp flags to deposit memory logic
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-2-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261105020106.3496339-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 18:01, Mukesh R wrote:
> Currently GFP_KERNEL is hard coded in hv_alloc_dep_pages(). Add gfp_flags
> parameter so it can be called in atomic context from map_pages callback in
> struct iommu_domain_ops and other places in future. A new function
> hv_deposit_memory_gfp() is added to facilitate this, so hv_deposit_memory()
> can continue to function as is.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/hv_proc.c           | 20 +++++++++++---------
>  include/asm-generic/mshyperv.h | 14 +++++++++++---
>  2 files changed, 22 insertions(+), 12 deletions(-)
> <snip>

Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
