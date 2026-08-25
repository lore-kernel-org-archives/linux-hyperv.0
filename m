Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3A83FF8B0;
	Tue, 25 Aug 2026 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659228; cv=none; b=rc4qjCTKgqQxgSgHCqCU7xPqHMxhHidLO3Z5x+F3SAFmioUq+IhEX9tbLakzIZ0lETmHhsT3VlZJ+rTly91+SgJEUftwHy+7P0txYG3mRO5AnU+MOOhS7fWvKV1HvO/kfBExjlzVSfzphONIZhgwGZHcHrpQDmuFtEbl99HGNIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659228; c=relaxed/simple;
	bh=ArVB6ymMmi0NqLxio4pP6attFEOcGQXJyF4HbLmBd38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=NojZPm7S57WGoNBF7wT/sWvbl4OfA4HKOLXnEr5HRJgy9qpoAPYPksqiuazlk3oXrx8UXWgb137b6b0Z5Bcei7oIZuv3OS/tLUvE+n0RH/2wa/u2BQ4AtXdJrqNX63otkjDLEAYk1ZVvOmgHOORCZCAW7kCoe7diS7pVn7m6ZPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FvjzLZCV; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FvjzLZCV"
Received: from [10.26.7.43] (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 53FD220B7166;
	Tue, 25 Aug 2026 04:59:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53FD220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787659193;
	bh=27g3FCQWu96YeT20zCax2L5SC4e7eynj6z7B7GIEwcw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FvjzLZCVS6xAJPt1TWD5paRZWefKIVnfqguk+GOVM8lLI85Xl6cnZUImdR1Tirzs0
	 WWyj4e1LNe8lFsEDFd5siNGE37fPNk6sLYDsZGeYA5s5gNg7Mz9bwaqYTmrxbdrmK5
	 DnruJJ+t0kp5yeniJb6OcneMv1EyBfVkMizDm1uw=
Message-ID: <f1214baf-b1d1-411e-b5ba-1ee2cfb37b1d@linux.microsoft.com>
Date: Tue, 25 Aug 2026 17:30:19 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely
To: Naman Jain <namjain@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <736091cf-8d00-415e-a890-e2dfa6739325@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25-08-2026 12:16, Naman Jain wrote:
> 
> 
> On 8/25/2026 10:47 AM, Sahil Chandna wrote:
>> A guest can wait indefinitely in wait_for_response() for the host to
>> send either a rescind message or a packet completion. If the
>> host does not send either, the guest can remain blocked with no
>> diagnostic indicating a reason.
>> This was observed during a guest kernel upgrade in which the
>> host-side application handling the PCI channel faulted, causing the
>> guest to never receive the completion request.
>> Add a periodic warning in wait_for_response() when the wait exceeds
>> a timeout so that such a hang is visible in the guest's kernel log
>> and can be correlated with host-side state.
>>
>> Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
>> ---
>> This was sent earlier upstream [1]
>> [1] https://lore.kernel.org/linux-hyperv/20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com/
>> ---
>>   drivers/pci/controller/pci-hyperv.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index cfc8fa403dad..c4fba0039164 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -1040,11 +1040,18 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>>
>>   /*
>>    * There is no good way to get notified from vmbus_onoffer_rescind(),
>> - * so let's use polling here, since this is not a hot path.
>> + * so let's use polling here, since this is not a hot path. If
>> + * wait_for_response() has been polling for PCI_RESPONSE_HANG_TIMEOUT_SEC
>> + * without either a rescind or completion, add a periodic warning.
>>    */
>> +#define PCI_RESPONSE_HANG_TIMEOUT_SEC 300
>> +
>>   static int wait_for_response(struct hv_device *hdev,
>>   			     struct completion *comp)
>>   {
>> +	unsigned long delay = secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
>> +	u64 timeout = get_jiffies_64() + delay;
>> +
>>   	while (true) {
>>   		if (hdev->channel->rescind) {
>>   			dev_warn_once(&hdev->device, "The device is gone.\n");
>> @@ -1053,6 +1060,11 @@ static int wait_for_response(struct hv_device *hdev,
>>
>>   		if (wait_for_completion_timeout(comp, HZ / 10))
>>   			break;
>> +
>> +		if (time_after64(get_jiffies_64(), timeout)) {
>> +			dev_warn(&hdev->device, "PCI stuck waiting for response.\n");
>> +			timeout = get_jiffies_64() + delay;
>> +		}
>>   	}
> 
> There can be some enhancements in above patch to address these problems:
> 1. Logging forever every 5 minutes in case of no completion or rescind.
> 2. If we now print warning once, not knowing if completion ever arrived.
> 3. On solving pt. 1 and 2 by adding a print for completion, one should 
> avoid adding a print by default for regular timely completions.
> 
Ack.
> Basically something like this:
> 
> #define PCI_RESPONSE_WARN_TIMEOUT_SEC 300
> 
> static int wait_for_response(struct hv_device *hdev,
>                   struct completion *comp)
> {
>      unsigned long warn_at =
>          jiffies + secs_to_jiffies(PCI_RESPONSE_WARN_TIMEOUT_SEC);
>      bool warned = false;
> 
>      while (true) {
>          if (hdev->channel->rescind) {
>              dev_warn_once(&hdev->device, "The device is gone.\n");
>              return -ENODEV;
>          }
> 
>          if (wait_for_completion_timeout(comp, HZ / 10)) {
>              if (warned || time_after_eq(jiffies, warn_at))
>                  dev_warn(&hdev->device,
>                       "PCI response received after prolonged wait.\n");
>              return 0;
>          }
> 
>          if (!warned && time_after_eq(jiffies, warn_at)) {
>              dev_warn(&hdev->device,
>                   "PCI still waiting for response.\n");
>              warned = true;
>          }
>      }
> }
> 
Thanks for review, I align on repeated warning every 5 minutes for
stalled guest would add to dmesg noise.I will wait for other review
comments as well and share v2 addressing this.
> Regards,
> Naman

