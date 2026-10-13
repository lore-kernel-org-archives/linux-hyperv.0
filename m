Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3340B3B47E9;
	Tue, 13 Oct 2026 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791880901; cv=none; b=AIyvo62eX99nCez6Si5XS+eNR+kMlZU56WI4M9T3DR4Qf+Zfzs/Hsyrae5J5lo/1eVF/BAMOILm0ZinIPgs/DylnQrGGksrQVigYLQs/qCXQ4ynVZdZAHreJZunIoRofi7ZwPeBfmwM7LvaSAHqFS2mMKuHknpkrL1NV0y10gp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791880901; c=relaxed/simple;
	bh=9GkcdBGWGjcROfqYz3vlsWuRZQVRN/tOO3UKwwsgXGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=YDOl+lQ0k/Sfrv9m7rk4Iz18sxb4bLFrqjn3bKZ2dt8YsO/LEtAs9j90uUUEWaU3l9Ha7Y1G8RUz/Px0QOHfhfXDh4u8VRb6JM+L/gKIZm7ead0+eOKuYDGPe7Uy9jrOW3PHL2LiZ8AKKoxw4jTcaqMUC7w0nEv4/y8fLkscNZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mBWgSNHd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mBWgSNHd"
Received: from [192.168.1.70] (unknown [4.194.122.162])
	by linux.microsoft.com (Postfix) with ESMTPSA id E6AFE20B7166;
	Tue, 13 Oct 2026 01:41:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6AFE20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791880896;
	bh=4F1RGKPtPfpJKOMQ/5NOZDdZGVwhfvIULiHyvea+tWM=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=mBWgSNHdYJIKf5nUC9iXnk0UVrCsl7Kg3F78YIS4svn8UIkNzSwe8oRLSmbyGfpJk
	 BGE4FkpV7/7VgkVm9XHVDQK4Hv2tMpNHDuavMFHqKqvM0cdbbG5nPtw2dZ5WvrBF/S
	 7L1ar4UruSxcpxyLr8jWjY+4HW0s0ybyB0Krs/rA=
Message-ID: <14013a11-b9e4-4cf9-b4ff-3253d179c991@linux.microsoft.com>
Date: Tue, 13 Oct 2026 14:11:33 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261013014354.18023-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261013014354.18023-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/13/2026 7:13 AM, Michael Kelley wrote:
> The functions for sending VMBus packets have changed.
> vmbus_sendpacket_mpb_desc() can target multiple ranges, and
> vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_getid()
> has been added. Update the documentation accordingly.
> 
> Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v3:
> * Fixed typo in the documentation text [Sashiko]
> 
> Changes in v2:
> * Add vmbus_sendpacket_getid() to the documentation. [Naman Jain]
> 
>   Documentation/virt/hyperv/vmbus.rst | 17 +++++++++--------
>   1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
> index 654bb4849972..c546e821ce6b 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -141,14 +141,15 @@ Three functions exist to send VMBus channel messages:
>   
>   1. vmbus_sendpacket():  Control-only messages and messages with
>      embedded data -- no GPAs
> -2. vmbus_sendpacket_pagebuffer(): Message with list of GPAs
> -   identifying data to transfer.  An offset and length is
> -   associated with each GPA so that multiple discontinuous areas
> -   of guest memory can be targeted.
> -3. vmbus_sendpacket_mpb_desc(): Message with list of GPAs
> -   identifying data to transfer.  A single offset and length is
> -   associated with a list of GPAs.  The GPAs must describe a
> -   single logical area of guest memory to be targeted.
> +2. vmbus_sendpacket_getid(): Similar to vmbus_sendpacket() but returns
> +   a transaction ID that is matched against a reply from the Hyper-V
> +   host. Useful when the struct completion (or other rendezvous data)
> +   must reside on the caller's stack. By invalidating the transaction
> +   ID before exiting the function due to a timeout or other error, a
> +   late arriving interrupt is assured to not trash the stack.
> +3. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
> +   to target. Each range consists of a single offset and length plus
> +   a list of GPAs that describe a logical area of guest memory.
>   
>   Historically, Linux guests have trusted Hyper-V to send well-formed
>   and valid messages, and Linux drivers for synthetic devices did not

We can retain the review tags for minor edits.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
