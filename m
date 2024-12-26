Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D218C18E1F;
	Thu, 26 Dec 2024 21:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735249460; cv=none; b=t9VZICFVkPe2AZTIcxXQQHrbqofWON+bHsf1pqzTrkdWq6/dwlWvQPiYsVlVEuFCjFo4KXgDkCBoFotjjzve9qiu5G+CYb4cpBaDJkbhVNxZV/+NLTweG3NKhhXb73HngzrT4/nQr9xVbPnjSv2vD0U5g6l9xPFpNEk+DBSGExU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735249460; c=relaxed/simple;
	bh=5NPuYYyX1bpvdAMT3mB7wCRyTBPc5LrGlfw035uRrDA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FYYzgGZKWGa6mjFCYRh/ocGExTRlkA2feYYbpGs6jzhyvwzTgjBzGd2V/Lcfv4/Eat7/Kxsf/rSYKZuZ5gCWT9gZCYOtQ6HhDZOE2RC/JqfagXHQtRZMj/1CWHCxzOfiQb/WPoRDzX71rE2W+COJuElBRUhDAky5FL1/EVDyGys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m2F0DwZ0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m2F0DwZ0"
Received: from [100.65.224.184] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1899E203EC22;
	Thu, 26 Dec 2024 13:44:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1899E203EC22
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735249458;
	bh=vIv4b/5ZtZxq9lppl5BEhi7hNVMLOtrrKeHohTg8wpM=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=m2F0DwZ0NocaAdp+UEg7QyBdRnLsiVV5nbCoAVtG+DOv5hj085kCuunujOGZscSTC
	 5sJiyBhAvNOD4jNU26W46k8ORBTJHq46zJkAQyJcGG5b3GK2w+nxTydfpIetkC6Da+
	 XeuhrVlJ8gej8XJozfzJYOXEez1McO9Tqh7TexMw=
Message-ID: <4fc9e5b0-352a-40e6-974d-5a2f173c65ee@linux.microsoft.com>
Date: Thu, 26 Dec 2024 13:44:20 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: hpa@zytor.com, kys@microsoft.com, bp@alien8.de,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 mingo@redhat.com, mhklinux@outlook.com, nunodasneves@linux.microsoft.com,
 tglx@linutronix.de, tiala@microsoft.com, wei.liu@kernel.org,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 eahariha@linux.microsoft.com, apais@microsoft.com, benhill@microsoft.com,
 ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
Subject: Re: [PATCH v3 4/5] hyperv: Do not overlap the hvcall IO areas in
 get_vtl()
To: Roman Kisel <romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
 <20241226213110.899497-5-romank@linux.microsoft.com>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241226213110.899497-5-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/26/2024 1:31 PM, Roman Kisel wrote:
> The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
> disallows overlapping of the input and output hypercall areas, and
> get_vtl(void) does overlap them.
> 
> Use the output hypercall page of the current vCPU for the hypercall.
> 
> [1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
> [2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
> 
> Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  arch/x86/hyperv/hv_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
