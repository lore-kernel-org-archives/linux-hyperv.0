Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C663349CF3;
	Fri,  9 Oct 2026 04:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520735; cv=none; b=pOdAIFtLtrTDfOioeoT/iGBjLvVGcCJdXuxzPGzs2dXiiZvRS/+6HLvU7u+0FGjrlBdbEREzBbQd6Tbejghr+AbdNQJZmKcRayAo91PuCVoti2mM+ExrqdUAKetNVR4PZnIA6/NCZl0RNsc/WAbEQxPRs/gkUpqd0BjK8oxNCWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520735; c=relaxed/simple;
	bh=40PhoDpFwRMrrCSgvozCqNIV1mEtoQSqQkxl43AkcUA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=BAbCgOUMKnFXO0zji2JfWMerV1QfxIWWT8dfmxv1IXmCgfmSoeD4jcJjTnXwT31bEYEzuljKNpZH9Wsnh+w8YOcV7+nAKwt6/PQuq2VR9p9NyBZu6BvXx7ZRTzi9Ur4TGLi0kE5r0p9q/iJWzKBjZ6EBg41L2iYEdmAg7KOaxpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=h5lNvXGH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="h5lNvXGH"
Received: from [10.95.65.84] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id C692420B7167;
	Thu,  8 Oct 2026 21:38:49 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C692420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791520732;
	bh=Y22h9L7Z0Omcr36XbYZ2pAvWDo1kv9/vTOpu5KrYdCw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=h5lNvXGHP7MdC9Vus+cKTGbikmv2qaxt1YffjN60IP2xtNZJRxBlW4Sa4kAeOcPe6
	 5lQemD4lu4/zhSY9T6Xpn3douKIFSVUKNFbKdoQ7DI2CdNbvfP/1ciQmMVmSxFhsjH
	 hlaCPUtDiDnL6DkF0jmsHgFhX7ilinZ/E7CU/4Wo=
Message-ID: <396ae01e-c1c4-49f5-a9fa-6dc4430e8690@linux.microsoft.com>
Date: Fri, 9 Oct 2026 10:08:48 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: hyperv: Remove support for guests on
 Hyper-V 2012/2012R2
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261009023437.3326-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261009023437.3326-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2026 8:04 AM, Michael Kelley wrote:
> Support for running Linux guests on Windows Server 2012/2012 R2 Hyper-V
> hosts and Windows 8/8.1 hosts has been removed, which includes removing
> support for operating Hyper-V synthetic timers in other than Direct Mode.
> Update the documentation to reflect these removals.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This patch reflects changes that are already in linux-next for merging
> into the 7.4 kernel.
> 
>   Documentation/virt/hyperv/clocks.rst   | 8 ++------
>   Documentation/virt/hyperv/overview.rst | 6 +++---
>   2 files changed, 5 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/clocks.rst b/Documentation/virt/hyperv/clocks.rst
> index 176043265803..9527e6073654 100644
> --- a/Documentation/virt/hyperv/clocks.rst
> +++ b/Documentation/virt/hyperv/clocks.rst
> @@ -64,12 +64,8 @@ applying the scale and offset to get the constant 10 MHz clock.
>   
>   Linux clockevents are based on Hyper-V synthetic timer 0 (stimer0).
>   While Hyper-V offers 4 synthetic timers for each CPU, Linux only uses
> -timer 0. In older versions of Hyper-V, an interrupt from stimer0
> -results in a VMBus control message that is demultiplexed by
> -vmbus_isr() as described in the Documentation/virt/hyperv/vmbus.rst
> -documentation. In newer versions of Hyper-V, stimer0 interrupts can
> -be mapped to an architectural interrupt, which is referred to as
> -"Direct Mode". Linux prefers to use Direct Mode when available. Since
> +timer 0. stimer0 is operated in what Hyper-V calls "Direct Mode"
> +where timer interrupts are mapped to an architectural interrupt. Since
>   x86/x64 doesn't support per-CPU interrupts, Direct Mode statically
>   allocates an x86 interrupt vector (HYPERV_STIMER0_VECTOR) across all CPUs
>   and explicitly codes it to call the stimer0 interrupt handler. Hence
> diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
> index 77408a89d1a4..c4c262b77aa3 100644
> --- a/Documentation/virt/hyperv/overview.rst
> +++ b/Documentation/virt/hyperv/overview.rst
> @@ -157,9 +157,9 @@ when accessing data shared with Hyper-V.
>   Versioning
>   ----------
>   Current Linux kernels operate correctly with older versions of
> -Hyper-V back to Windows Server 2012 Hyper-V. Support for running
> -on the original Hyper-V release in Windows Server 2008/2008 R2
> -has been removed.
> +Hyper-V back to Windows Server 2016 Hyper-V and Windows 10. Support for
> +running on Windows Server 2012/2012 R2, Windows Server 2008/2008 R2,
> +and Windows 8.1 and earlier has been removed.
>   
>   A Linux guest on Hyper-V outputs in dmesg the version of Hyper-V
>   it is running on.  This version is in the form of a Windows build

Thanks Michael. Change LGTM, but while at it, please add a similar 
change in 
Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst as 
well.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman


