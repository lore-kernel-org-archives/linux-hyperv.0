Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5C7349CF3;
	Fri,  9 Oct 2026 04:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791520731; cv=none; b=OMvltF9ZrsRWLOhL5r2T8Jbfb7UDHBWkneuB4knPcZf+W0aTTFI2uybVPn3P8H5/D4QGVIWKUjZWbNFycia/BIua3hwNLMOCFhjvNxL2+q43R+iYGZ8jhVtzXkHQ19E0/45yWIt4mQ+goG2cy1ZUM4w7wHJjFE3+zAYCmuWAD58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791520731; c=relaxed/simple;
	bh=1eHApctttwmY6Rtyg/wIpkMvoeSAqn+lvGZsSQ2WMkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=g7fty2V1O6QAbV8i2Wkqg7A3dASvFiekE1aefIobF9NHY56LXHvH5GCNBlg1eQ9Ib+wNve8nUsU63fOfI+2M5CsGfLT/uyvgQIdl5vCLggJVaz8SZ4b+aBdE6KWulu297ulyNUe26jkqbCu1Pg/b+1hIM0q0y24ibnH2Kl1/KfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SHPJy9Sb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SHPJy9Sb"
Received: from [10.95.65.84] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2D0F320B7166;
	Thu,  8 Oct 2026 21:38:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D0F320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791520729;
	bh=8H6c0N4ZGkWDbwW6f71HIiPk+xQG6yOk/RNBcbZj0BE=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=SHPJy9SbZT7BlTlVVIOk9EUByxzLSpZ2swriD7t14Hs6Bx7lDc6WNmljQWOZSY+Hk
	 hniLpdKmbV1bbdBBDLQ9GSQ9kyqDM1Icjc9V68FZv7UjpBtg743AaaRqkN6QEg/oIs
	 3rzl6nkMBqo4tPcLeQ6fYN+YXeyxzi2ZXVXN+5zs=
Message-ID: <db1a6c90-f2d9-44e4-be4b-1dbc96c66691@linux.microsoft.com>
Date: Fri, 9 Oct 2026 10:08:43 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261009030637.3869-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261009030637.3869-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2026 8:36 AM, Michael Kelley wrote:
> The functions for sending VMBus packets have been simplified.
> vmbus_sendpacket_mpb_desc() can target multiple ranges, and
> vmbus_sendpacket_pagebuffer() has been removed. Update the
> documentation accordingly.
> 
> Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> The Fixes: tag reflects the code change that was made. The
> documentation update should have been included with the
> original code change.
> 
>   Documentation/virt/hyperv/vmbus.rst | 13 ++++---------
>   1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/vmbus.rst b/Documentation/virt/hyperv/vmbus.rst
> index 654bb4849972..77a437969b49 100644
> --- a/Documentation/virt/hyperv/vmbus.rst
> +++ b/Documentation/virt/hyperv/vmbus.rst
> @@ -137,18 +137,13 @@ control message contains a list of GPAs that describe the data
>   buffer.  For example, the storvsc driver uses this approach to
>   specify the data buffers to/from which disk I/O is done.
>   
> -Three functions exist to send VMBus channel messages:
> +Two functions exist to send VMBus channel messages:
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
> +2. vmbus_sendpacket_mpb_desc(): Message with one or more data ranges
> +   to target. Each range consists of a single offset and length plus
> +   a list of GPAs that describe a logical area of guest memory.
>   
>   Historically, Linux guests have trusted Hyper-V to send well-formed
>   and valid messages, and Linux drivers for synthetic devices did not

vmbus_sendpacket_getid() is also part of the exported VMBus API and has
an active caller in pci-hyperv.c. It might be useful to include it here
and explain that it uses the same packet format as vmbus_sendpacket(),
but additionally returns the transaction ID assigned to the packet.

Otherwise, the update LGTM.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Thanks,
Naman Jain

