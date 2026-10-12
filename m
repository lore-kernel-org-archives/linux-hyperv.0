Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB13F359A6C;
	Mon, 12 Oct 2026 05:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783617; cv=none; b=REWMLssuBiB7rdhdsmT++sAT7tbBanbi2QxjY5uPwFLFfRPrpG7hoy1Kq0R512KNoD8cqnIuBZMJSupt5itWgTeFzCPnH5O6/TeHgFuIers4kVrsnSVnF4JH2ibr6YsuMpriB+Xe5MEfGGDEmbZoIl29dYFvQ59cz6xJdheMKJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783617; c=relaxed/simple;
	bh=R8YTUHbSpFTLz5kjMrARIiK6318Jt9L059MVFzOz0fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=pZoty9/G7XWUwKD+rvLGNUpVli1yYfcaWVhlSdejuQWeW5xBv3sNGgqWHFxZZvOtwdgVRc6n4yc+/ckk+o+XA2W360Xt75wxvueKs1IYzxbZILnFZOZg1eiHyWoOlzsblIlFEeGQfxv6XU8lgNCSMjd8x+Fpkq1vcvcsXl8L+Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=szR0yvLv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="szR0yvLv"
Received: from [10.95.64.165] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id DF99320B7168;
	Sun, 11 Oct 2026 22:40:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DF99320B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791783613;
	bh=F8BLM/EN+EMQVfOrQkeXaSwR2I2+MDBRB8M+3XqUjwY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=szR0yvLvkCjQynZDfRY4Fwvohdfx/AqvI1DvsAAsSjaXDKVy7uPfOc0VMvmLhnuCw
	 pcvLGSO/TRgdPsuJd9ZGfUKD4DlTLlR1fFLIA5FthKMU5KEybs+VI+VaDkn+7BifRk
	 0V4udmWqSLU0KU9In04QeX3emLcMxHWEp1/W7dWU=
Message-ID: <12b726c0-46c6-4f3e-9119-24f6c877e3fb@linux.microsoft.com>
Date: Mon, 12 Oct 2026 11:10:08 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Remove support for guests
 on Hyper-V 2012/2012R2
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261009174007.6745-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261009174007.6745-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2026 11:10 PM, Michael Kelley wrote:
> Support for running Linux guests on Windows Server 2012/2012 R2 Hyper-V
> hosts and Windows 8/8.1 hosts has been removed, which includes removing
> support for operating Hyper-V synthetic timers in other than Direct Mode.
> Update the documentation to reflect these removals.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes since v1:
> * Updated the netvsc.rst network driver documentation [Naman Jain]
> * My "below the line" comment in v1 wrong. It said that removal of WS2012
>    support was going into 7.4. But it is actually already in 7.3. So
>    ideally these doc changes would go into 7.3 as well.
> 
>   .../device_drivers/ethernet/microsoft/netvsc.rst   | 14 +++++++-------
>   Documentation/virt/hyperv/clocks.rst               |  8 ++------
>   Documentation/virt/hyperv/overview.rst             |  6 +++---
>   3 files changed, 12 insertions(+), 16 deletions(-)
> 

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman

