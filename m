Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B743A3E40E7;
	Wed,  9 Sep 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946308; cv=none; b=lTv6R91iPFmofYG/6dUxkoGFjUxEeTYCJGKbvJu0oZ0D6goXgOJTzvsFZwA8tGQZGuJoE5QzReDCfp0+WHeBXc8R/jdOKiOvn9oUWu2IIUSXZiamgZc92fy70g4dUfzhfmnRVdYhTlc2TiIYYPBZTz2rnwwXitBdoNvqiPNfCNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946308; c=relaxed/simple;
	bh=U/TSjfiyoy1kR4oMlsX6WetGoZU/9+forBtwTZDVlgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e+yKCF0UDiBs2fMXvTpCloOKrtDCJuZLA9v1pCVTHJwKRhHzfK4YUNpBfJmoCT2eW3VQtSBeEvEpjxrbIGccSI8Mpo4Qsoj1jxhCcdWdSXrr92hw45DUxvz8x15cYeguHr6W5VdF3a5ZTivX3J9cknbJaZY2dL2cbw8pYvZESbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YCsca2mo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YCsca2mo"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0727520B7128;
	Wed,  9 Sep 2026 02:30:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0727520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788946247;
	bh=UImAoP06X/mSbbiARCqbMx2kej7THt6I1rcHgFKHVsA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=YCsca2moKVD3MxWmfxPcMRv6pDUwe32Sh3Cyho5rDJO/Yudx8HO+sUplPtjGR1L12
	 avqJ3MoVDUnwvD5ikRTmViIDxxETtRKGoWVB1MGnAC1ePW6qQXUYw/AhYQ7YJu0Vr2
	 zYgISlgxEUtyMCC+MftQD9JIAYDm2DcPkYzyIYs0=
Message-ID: <c8b6e10f-dd52-4c74-8d16-268563d8bc1f@linux.microsoft.com>
Date: Wed, 9 Sep 2026 15:01:22 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: hv: Warn when wait_for_response() waits
 indefinitely
To: Sahil Chandna <sahilchandna@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhklinux@outlook.com
References: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/8/2026 5:00 PM, Sahil Chandna wrote:
> A guest can wait indefinitely in wait_for_response() for the host to
> send either a rescind message or a packet completion. If the
> host does not send either, the guest can remain blocked with no
> diagnostic indicating a reason.
> This was observed during a guest kernel upgrade in which the
> host-side application handling the PCI channel faulted, causing the
> guest to never receive the completion request.
> Add a warning in wait_for_response() when the wait exceeds
> a timeout so that such a hang is visible in the guest's kernel log
> and can be correlated with host-side state.
> 
> Suggested-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> ---
> Changes since v2:
> - Add counter based timeout instead of introducing another timer
> Link to v2: https://lore.kernel.org/all/20260902115854.2629164-1-sahilchandna@linux.microsoft.com/
> 
> Changes since v1:
> - Removed periodic warning to one time warning in 2 minutes
> - Include vmbus relid and stuck PCI msg.
> Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
>   drivers/pci/controller/pci-hyperv.c | 46 ++++++++++++++++++++++-------
>   1 file changed, 36 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 89816a2bd7cd..bd07402c47ed 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1040,19 +1040,38 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
> 
>   /*
>    * There is no good way to get notified from vmbus_onoffer_rescind(),
> - * so let's use polling here, since this is not a hot path.
> + * so let's use polling here, since this is not a hot path. If
> + * wait_for_response() has been polling for 2 minutes
> + * without either a rescind or completion, add a warning.
>    */
> +#define PCI_RESPONSE_HANG_TICKS 1200
> +

Nit, I think this variable name could be misleading, as this represents 
a loop counter for a retry logic, but not exactly *ticks* from kernel 
terminology.

I would have preferred something like: PCI_RESPONSE_WARN_POLL_COUNT.

Rest LGTM.

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman Jain
