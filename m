Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CAB27D780;
	Wed, 18 Jun 2025 22:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750286724; cv=none; b=VqGzHLjgrRjRWqqjC9bhw09HxZRtLkfC3dy0DyqayhzNRPZ0qTNkKRroqQoGa+86B49B6tesaXZ84l2hXZZUxeIxx4MAIJj5/cf0Tl3Tr4gSGdLvQUOOzaHuR7GACcj2+XsOjUG3b/plIOiEYEJ6/LrEHeTN1/7ercLwoasnrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750286724; c=relaxed/simple;
	bh=2no9jXrLkrDEBABuUEgY97uFl5Yw6QEJCcmzucSWsFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKTH6bXfpLz/CVIliU28hKVBVpI5XdoQ8ROP01EX2wj7K6dc75LDr1JIBfXgLxDS8OdwCtzc1fV2Yk98QUHOxHkXE3LUo7IQ4sft/r6FkEFr7QnSrYasyxSd8O9gsjdmPL0kU2U2E64oEASu3SGCwBM/4xMwslWVeVN4452U+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L68sOx3u; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L68sOx3u"
Received: from [100.64.233.194] (unknown [52.148.171.5])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8006E211936F;
	Wed, 18 Jun 2025 15:45:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8006E211936F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1750286723;
	bh=rJs6TsFM1aXGlAgdipcm0UQBa8DTSKlhPilE+LUrsic=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=L68sOx3uTtlWroiS/eOpJnEcntdicNrsTjKS/S0supUx+TTZJxftHulUkZihpSpzY
	 MkuWVko7E7VWaC0YpxYB8KuRpsNlORdz5C+RO3DinJj9vIuhoNVLmN8kelX4omLH79
	 Kk19I9RHzd0dBxBEHyRI2tweyqVI5z1Cw4Kf2fio=
Message-ID: <f6c8da5d-9dc0-488e-88e5-39f53127b6a3@linux.microsoft.com>
Date: Wed, 18 Jun 2025 15:45:21 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] PCI: hv: Use the correct hypercall for unmasking
 interrupts on nested
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, mhklinux@outlook.com,
 decui@microsoft.com, catalin.marinas@arm.com, will@kernel.org,
 tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, lpieralisi@kernel.org,
 kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 bhelgaas@google.com, jinankjain@linux.microsoft.com,
 skinsburskii@linux.microsoft.com, mrathor@linux.microsoft.com, x86@kernel.org
References: <20250613193616.GA971782@bhelgaas>
Content-Language: en-US
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
In-Reply-To: <20250613193616.GA971782@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/13/2025 12:36 PM, Bjorn Helgaas wrote:
> On Tue, Jun 10, 2025 at 04:52:06PM -0700, Nuno Das Neves wrote:
>> From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
>>
>> Running as nested root on MSHV imposes a different requirement
>> for the pci-hyperv controller.
>>
>> In this setup, the interrupt will first come to the L1 (nested) hypervisor,
>> which will deliver it to the appropriate root CPU. Instead of issuing the
>> RETARGET hypercall, we should issue the MAP_DEVICE_INTERRUPT
>> hypercall to L1 to complete the setup.
> 
> Maybe strengthen this to say that this issues MAP_DEVICE_INTERRUPT
> instead of RETARGET in this case?  (Not just that we "should".) 
> 

Good suggestion, thanks.

>> Rename hv_arch_irq_unmask() to hv_irq_retarget_interrupt().

