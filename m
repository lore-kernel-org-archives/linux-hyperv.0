Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0A742C4FC;
	Mon, 19 Oct 2026 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792382965; cv=none; b=LFwLFIRmM/e/6s5QigiYc05bMGg0Wi/C9/RCfqJlmj81JnfMi8lOklfFlsSDA/dkRv/wRkrWh2JkFUw+Bf3bP7FuQqmcI145/Et20S4Kbid74/cXLF/2q+SSNzo9GJjVYyxOrjMppkxlMo+XvqiVxjq36JTT0/T0gA1Lm6zo3Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792382965; c=relaxed/simple;
	bh=b3yN0+Sqbo+owN9vPmP5jDBhXYVkZHYesravJ0uaDIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c3ZCGrAj5oyCXKvcDmuJSs02aFYND48CGybJ2AkhDdWPJ41d7TciJzFEeVLWrWKgz/cwSkLjW8D9w+IVYdbic/7iTtjotNVmFicTcLkipEuOdj2DQx/yQ5bHQZ2+R6hhjd7a2+VMgNXT/QCKfij3uYUsUEoDmrz9gbR8GkHTLgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ImAEDt4x; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ImAEDt4x"
Received: from [10.95.64.89] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id EBDCD20B7168;
	Sun, 18 Oct 2026 21:09:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EBDCD20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792382951;
	bh=kD3aqbgMW82kfQTV55TBnU5yndyEktZgD20SrHfdxk8=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=ImAEDt4xzfR8mkkVyQ3hEKh3q+yUWvuTnYYGSpZir26oqkWFQkJ2gALjFDjhgay00
	 BdINi+NDeWq4yBtBxGJu/KN83NdUCxYdiAvvS0kBROQFg2Wc9DXusN8LYfSrLkVNJT
	 9k9rYyxmW+MDsXXAIlFXUKTEocpQTXtpXWuPn96c=
Message-ID: <84c95503-b59a-457a-9225-0c746b0b6f44@linux.microsoft.com>
Date: Mon, 19 Oct 2026 09:39:12 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] Documentation: hyperv: Update information on guest
 CPU offlining
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261017160848.14730-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261017160848.14730-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/17/2026 9:38 PM, Michael Kelley wrote:
> In Hyper-V Overview documentation, remove the out-of-date reference
> to explicitly reassigning VMBus channel interrupts before taking a
> guest CPU offline. Instead, reference the VMBus documentation, which
> is already up-to-date on this topic.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
>   Documentation/virt/hyperv/overview.rst | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
> index 77408a89d1a4..63489f73a299 100644
> --- a/Documentation/virt/hyperv/overview.rst
> +++ b/Documentation/virt/hyperv/overview.rst
> @@ -132,11 +132,11 @@ Starting in Windows Server 2022 Hyper-V, the ACPI tables reflect
>   only the CPUs actually present in the VM, so Linux does not report
>   any hot-add CPUs.
>   
> -A Linux guest CPU may be taken offline using the normal Linux
> -mechanisms, provided no VMBus channel interrupts are assigned to
> -the CPU.  See the section on VMBus Interrupts for more details
> -on how VMBus channel interrupts can be re-assigned to permit
> -taking a CPU offline.
> +A Linux guest CPU may be taken offline, and subsequently brought
> +back online, using the normal Linux mechanisms. See the "VMBus
> +Interrupts" section of Documentation/virt/hyperv/vmbus.rst
> +documentation for how VMBus channel interrupts are automatically
> +re-assigned if necessary when taking a CPU offline.
>   
>   32-bit and 64-bit
>   -----------------

LGTM.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
