Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCE23A8F7;
	Wed,  8 Apr 2026 12:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775651809; cv=none; b=c21xOVOhAuyBKV0ATN5QWRzoMdyMlLZTwwXentOfOigBoAFMEw/Y47CotJjiYjcoNMirN673BWXG0Ldg4OjOm8Pj2S9cR+qSZQ029tTB/iXuPLpgYOK0x3KYb59sq27yGl08wy24YqhqWBifY7HEn8nBt1JmbnjAzjwyeCIz7EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775651809; c=relaxed/simple;
	bh=cfLvegZNO53193yr2zj6oS2OvbJ7h+NLEZCjSA6HoBI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=la/N60lE4XPN+/ZuYgNNkScGBlhgw/EMiPuBfmvDFLrl+om8Qbo0L5dI6ZoJX6FMPG1Zdns8ieH+BA5k0edrKL8JdGo2jBIg9TL3REfzFRqsmhoAbW7YGU0OLqMjioxN6BsZM9YwFrcTG8BBOVWKl0uTZb5Sw/4zx2YRpxGn690=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fQwaf9Ms; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fQwaf9Ms"
Received: from [10.18.181.206] (unknown [167.220.238.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3C73020B710C;
	Wed,  8 Apr 2026 05:36:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3C73020B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775651806;
	bh=egaGSZowdTL79yUX8ORYXrI7m0mQpIq7GO5y3CEWVv8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=fQwaf9MsNhkxvNFBsPy5bzren8vBPuwSfH1rgs/64VXp2wj3V9cMVRSZbb7W+P5JH
	 ZQ4bOPnkWC0OjEmiK46KSr7b3IuZxeZExH/EByHzcYmZ0e1Ob1MCCa+K6zBQLEIm5C
	 6Tg9rCUEArnY0Vas4MmrQw3WcQxAKnXW/GvbDk4U=
Message-ID: <9c10dff7-455a-4ad4-94c8-92e3b04a5780@linux.microsoft.com>
Date: Wed, 8 Apr 2026 18:06:40 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tools: hv: Fix cross-compilation
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, gregkh@linuxfoundation.org,
 ssengar@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, romank@linux.microsoft.com,
 avladu@cloudbasesolutions.com, vdso@mailbox.org, gargaditya@microsoft.com
References: <20260407122040.249733-1-gargaditya@linux.microsoft.com>
Content-Language: en-US
From: Aditya Garg <gargaditya@linux.microsoft.com>
In-Reply-To: <20260407122040.249733-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 07-04-2026 17:50, Aditya Garg wrote:
> Use the native ARCH only in case it is not set, this will allow the
> cross-compilation where ARCH is explicitly set.
> 
> Additionally, simplify the check for ARCH so that fcopy daemon is built
> only for x86_64.
> 
> Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
> Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
> Closes: https://lore.kernel.org/linux-hyperv/PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com/
> Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
> ---
> Changes since v1:
>      - Dropped the info target printing CC, LD and ARCH
> 
> v1: https://lore.kernel.org/all/1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com/
> ---
>   tools/hv/Makefile | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/hv/Makefile b/tools/hv/Makefile
> index 34ffcec264ab..e377caf89fb6 100644
> --- a/tools/hv/Makefile
> +++ b/tools/hv/Makefile
> @@ -2,7 +2,7 @@
>   # Makefile for Hyper-V tools
>   include ../scripts/Makefile.include
>   
> -ARCH := $(shell uname -m 2>/dev/null)
> +ARCH ?= $(shell uname -m 2>/dev/null)
>   sbindir ?= /usr/sbin
>   libexecdir ?= /usr/libexec
>   sharedstatedir ?= /var/lib
> @@ -20,7 +20,7 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
>   override CFLAGS += -Wno-address-of-packed-member
>   
>   ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
> -ifneq ($(ARCH), aarch64)
> +ifeq ($(ARCH), x86_64)
>   ALL_TARGETS += hv_fcopy_uio_daemon
>   endif
>   ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))

Sashiko AI review flagged an issue, I tested it and confirmed.
When building via make tools/hv from the top-level kernel directory,
scripts/subarch.include normalizes x86_64 to x86, and since ARCH is
exported, the ?= assignment in tools/hv/Makefile preserves the
normalized value, causing ifeq ($(ARCH), x86_64) to be false and
hv_fcopy_uio_daemon to be silently excluded.

I'll change this to include x86 as well in v3.

Regards,
Aditya
