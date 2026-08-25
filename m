Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43F723EDE42;
	Tue, 25 Aug 2026 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787659422; cv=none; b=uBrXlEMq9xU9DVAaJWGqo2MP/dK2Ohh+sfFMELMvqWyUoDEI6/cXeJC4kdK7q6NcAYz6XY1N+bMm/A1nvUDmR9j48SMMTKu59ySRhZPTgqWliomNFgtG5keAJJrwfalxxToIughvIGL4rmSQDu3YhOp+FoXZ7Myhi02d9F9dTy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787659422; c=relaxed/simple;
	bh=fPqr/EV01DZeLMNybyhvsd2HLJZZ+JYAapEFSNJGiug=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rC0U3RCwgt7y8tnU9WVDSEpuX51gBAwOKs5SptrYwVswQAmjmvXADM0RZLUFriXY+mAVlvKrMWSmaa5hp/f/6op6iXPIZR/Ky9TVsQRJg3w/I5NbuUPMrOA0o1m2KsZKCopbR+SdcJ2KPJQOEcz78Twn7bRE/vTlCjiuhUyQz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WdJGNF11; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WdJGNF11"
Received: from [10.26.7.43] (unknown [4.213.232.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 19C9120B7166;
	Tue, 25 Aug 2026 05:03:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 19C9120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787659388;
	bh=CidMC3bbQbtopc3+urwjKEIrX3V1aqV006bC2KWJ3bM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WdJGNF110VxZ92ya5lB2J6QLj4F9E72Rzk1CKaeEqusjsplNXbChHKXRQP0tZR/eH
	 mFA1mYK9PcdfipahINhCpr67bHUNSjho2gLhcGsxYlLyKWp/mxp4ninsyIbD7UsWdk
	 m7KQjjRbutwQPxvkica89HZhpGGOxFCOWsQjk5EE=
Message-ID: <31a67165-65c5-4a74-9637-0edc4ce7f210@linux.microsoft.com>
Date: Tue, 25 Aug 2026 17:33:37 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
 <20260825053015.B26731F000E9@smtp.kernel.org>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <20260825053015.B26731F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25-08-2026 11:00, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Use-After-Free on Error Path for VMbus Completion Packets
> --
> 
> --- Patch [1]: [PATCH] PCI: hv: Warn when wait_for_response() waits indefinitely ---
> commit 7a3f315fe3798f61aaba375b4ed84ec32d84ef0f
> Author: Sahil Chandna <sahilchandna@linux.microsoft.com>
> PCI: hv: Warn when wait_for_response() waits indefinitely
> 
> This commit adds a periodic warning to wait_for_response() if the guest waits
> too long for a rescind message or packet completion. This makes indefinite hangs
> visible in the guest's kernel log so they can be correlated with host-side state.
> 
> Link: https://lore.kernel.org/linux-hyperv/20260612174010.2598695-1-hamzamahfooz@linux.microsoft.com/
> 
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index cfc8fa403dad6..c4fba00391649 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
> [ ... ]
>>  static int wait_for_response(struct hv_device *hdev,
>>  			     struct completion *comp)
>>  {
>> +	unsigned long delay = secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
>> +	u64 timeout = get_jiffies_64() + delay;
>> +
>>  	while (true) {
>>  		if (hdev->channel->rescind) {
>>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>>  			return -ENODEV;
> 
> [Severity: Critical]
> This is a pre-existing issue, but does this early return on rescind lead to a
> use-after-free for the completion packets?
> 
> When wait_for_response() detects hdev->channel->rescind and returns -ENODEV,
> callers like hv_read_config_block() will immediately return and unwind their
> stack:
> 
> drivers/pci/controller/pci-hyperv.c:hv_read_config_block() {
>     ...
>     ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
>     if (ret)
>         return ret;
>     ...
> }
> 
> This pops the stack frame containing the completion context without
> deregistering the request. If a late completion packet arrives, wouldn't
> hv_pci_onchannelcallback() retrieve the dangling pointer and execute the
> invalid completion function?
> 
> drivers/pci/controller/pci-hyperv.c:hv_pci_onchannelcallback() {
>     ...
>             comp_packet = (struct pci_packet *)req_addr;
>             response = (struct pci_response *)buffer;
>             ...
>             comp_packet->completion_func(comp_packet->compl_ctxt,
>                                          response,
>                                          bytes_recvd);
>     ...
> }
> 
> Could this result in memory corruption or a control-flow hijack if the
> hypervisor sends a completion packet after the rescind offer, but before
> the channel is completely closed?
> 
>>  		}
>>  
>>  		if (wait_for_completion_timeout(comp, HZ / 10))
>>  			break;
> [ ... ]
> 
This warning was flagged earlier as well [1], I will address this in a
separate patch.

Regards,
Sahil
[1]
https://lore.kernel.org/linux-hyperv/20260612175219.220581F000E9@smtp.kernel.org/




