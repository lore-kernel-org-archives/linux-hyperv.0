Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D63519929;
	Mon,  7 Sep 2026 16:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788797996; cv=none; b=in//KL8jsprm3kBIA8dyPZmZtsdnsNANMlQh8QWASgppFJeOweGzHlA0Ndvpf0XWCEjZJH9fCLc7lcs0k/sH77ncJ9ghO+n7W3eU3C0RDD51DxbWDalosGymWJZfs5VRZYWY//dgyZJDMV2C7gkK9GlnDzu+z1mAuIJtixRDYAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788797996; c=relaxed/simple;
	bh=94/6PTfQQHAxtx3vpoS0pW5JB0xmeY9kGBDqMSCUW0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UpuOxS3pymfazfZTbdH6sFOG6y5nTHDwsoz7FfienYf6CJBaRl+0l4upwTC+yx8k3wUn8FMAgkLdWDfx3BH3+u5Ee+BwXGh2EzYlu5DAdsHcALglR6toda+K12D8NephAgJTds2cUyZSEsPg2zHBwnNly2maDI5FSLQDTWCouFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FNanFaVz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FNanFaVz"
Received: from [10.26.7.43] (unknown [4.213.232.23])
	by linux.microsoft.com (Postfix) with ESMTPSA id C457520B7128;
	Mon,  7 Sep 2026 09:19:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C457520B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788797944;
	bh=Fo7GYCo1+WqhMXMFyYhqDp10kubr9hmrubcGwO15lik=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=FNanFaVzOfeDri3m/58Evp9Dch0MhunQG9cPlspyvRVzWGAtQPlOX15E1asHlIx3j
	 CZ5C6MlOsoBRp0LoeYvmVGYkoePn7Fxc9B86ddo69mi2J50AL1OAmUfPcPmgI8HKA5
	 gHocibi1cSpLs9YWSAIKKVfFgSa8SOQCHtO2FjJk=
Message-ID: <ac921650-8648-4d5f-a4f9-cadd9dfca27e@linux.microsoft.com>
Date: Mon, 7 Sep 2026 21:49:37 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: hv: warn when wait_for_response() waits
 indefinitely
To: Michael Kelley <mhklinux@outlook.com>,
 "kys@microsoft.com" <kys@microsoft.com>,
 "haiyangz@microsoft.com" <haiyangz@microsoft.com>,
 "namjain@linux.microsoft.com" <namjain@linux.microsoft.com>,
 "hamzamahfooz@linux.microsoft.com" <hamzamahfooz@linux.microsoft.com>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>,
 "decui@microsoft.com" <decui@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "mani@kernel.org" <mani@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
 <SN6PR02MB41576349B2BDB3D44815E894D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <SN6PR02MB41576349B2BDB3D44815E894D4B62@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03-09-2026 22:18, Michael Kelley wrote:
> From: Sahil Chandna <sahilchandna@linux.microsoft.com> Sent: Wednesday, September 2, 2026 4:59 AM
>>
>> A guest can wait indefinitely in wait_for_response() for the host to
>> send either a rescind message or a packet completion. If the
>> host does not send either, the guest can remain blocked with no
>> diagnostic indicating a reason.
>> This was observed during a guest kernel upgrade in which the
>> host-side application handling the PCI channel faulted, causing the
>> guest to never receive the completion request.
>> Add a warning in wait_for_response() when the wait exceeds
>> a timeout so that such a hang is visible in the guest's kernel log
>> and can be correlated with host-side state.
>>
>> Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
>> Suggested-by: Naman Jain <namjain@linux.microsoft.com>
>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
>> ---
>> Changes since v1:
>> - Removed periodic warning to one time warning in 2 minutes
>> - Include vmbus relid and stuck PCI msg.
>> Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
>> ---
>>  drivers/pci/controller/pci-hyperv.c | 48 +++++++++++++++++++++++------
>>  1 file changed, 38 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 89816a2bd7cd..ca9d8efd748c 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -1040,19 +1040,40 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>>
>>  /*
>>   * There is no good way to get notified from vmbus_onoffer_rescind(),
>> - * so let's use polling here, since this is not a hot path.
>> + * so let's use polling here, since this is not a hot path. If
>> + * wait_for_response() has been polling for PCI_RESPONSE_HANG_TIMEOUT_SEC
>> + * without either a rescind or completion, add a warning.
>>   */
>> +#define PCI_RESPONSE_HANG_TIMEOUT_SEC 120
> 
> This all looks good to me and it should work as written. But the code
> seems more complex than it needs to be. There are two timers running in
> parallel -- the 100 millisecond timer in wait_for_completion_timeout(),
> and the larger 120 second timeout for printing the "stuck waiting" message.
> A simpler approach would be to count iterations through the "while(true)"
> loop. Print the "stuck warning" message when the count is exactly
> 1200. Print the "late completion" message if the completion occurs and
> count is > 1200. Then there's no need to manipulate jiffies and the "warned"
> flag isn't needed. Make the loop counter 64-bit so overflow isn't an issue.
> 
> Arguably this suggested approach is a little too clever, but it seems clear
> enough to be easily understood.
> 
> Michael
> 
Thanks for reviewing. Sure, this makes sense.I will share proposed
implementation in v3

Regards,
Sahil
>> +
>>  static int wait_for_response(struct hv_device *hdev,
>> -			     struct completion *comp)
>> +			     struct completion *comp,
>> +			     const char *msg_type)
>>  {
>> +	unsigned long delay = secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
>> +	u64 timeout = get_jiffies_64() + delay;
>> +	bool warned = false;
>> +
>>  	while (true) {
>>  		if (hdev->channel->rescind) {
>>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>>  			return -ENODEV;
>>  		}
>>
>> -		if (wait_for_completion_timeout(comp, HZ / 10))
>> +		if (wait_for_completion_timeout(comp, HZ / 10)) {
>> +			if (warned)
>> +				dev_warn(&hdev->device,
>> +					 "Late %s completion arrived.\n", msg_type);
>>  			break;
>> +		}
>> +
>> +		if (!warned && time_after64(get_jiffies_64(), timeout)) {
>> +			dev_err(&hdev->device,
>> +				"%s stuck waiting for response, relid = %u\n",
>> +				msg_type, hdev->channel->offermsg.child_relid);
>> +
>> +			warned = true;
>> +		}
>>  	}
>>
>>  	return 0;
>> @@ -1518,7 +1539,8 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
>>  	if (ret)
>>  		return ret;
>>
>> -	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
>> +	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event,
>> +				"PCI_READ_BLOCK");
>>  	if (ret)
>>  		return ret;
>>
>> @@ -1607,7 +1629,8 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
>>  	if (ret)
>>  		return ret;
>>
>> -	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event);
>> +	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event,
>> +				"PCI_WRITE_BLOCK");
>>  	if (ret)
>>  		return ret;
>>
>> @@ -2624,7 +2647,8 @@ static struct hv_pci_dev *new_pcichild_device(struct
>> hv_pcibus_device *hbus,
>>  	if (ret)
>>  		goto error;
>>
>> -	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
>> +	if (wait_for_response(hbus->hdev, &comp_pkt.host_event,
>> +			      "PCI_QUERY_RESOURCE_REQUIREMENTS"))
>>  		goto error;
>>
>>  	hpdev->desc = *desc;
>> @@ -3256,7 +3280,8 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
>>  				(unsigned long)pkt, VM_PKT_DATA_INBAND,
>>
>> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>>  		if (!ret)
>> -			ret = wait_for_response(hdev, &comp_pkt.host_event);
>> +			ret = wait_for_response(hdev, &comp_pkt.host_event,
>> +						"PCI_QUERY_PROTOCOL_VERSION");
>>
>>  		if (ret) {
>>  			dev_err(&hdev->device,
>> @@ -3476,7 +3501,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>>  			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
>>  			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>>  	if (!ret)
>> -		ret = wait_for_response(hdev, &comp_pkt.host_event);
>> +		ret = wait_for_response(hdev, &comp_pkt.host_event,
>> +					"PCI_BUS_D0ENTRY");
>>
>>  	if (ret)
>>  		goto exit;
>> @@ -3553,7 +3579,8 @@ static int hv_pci_query_relations(struct hv_device *hdev)
>>  	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
>>  			       0, VM_PKT_DATA_INBAND, 0);
>>  	if (!ret)
>> -		ret = wait_for_response(hdev, &comp);
>> +		ret = wait_for_response(hdev, &comp,
>> +					"PCI_QUERY_BUS_RELATIONS");
>>
>>  	/*
>>  	 * In the case of fast device addition/removal, it's possible that
>> @@ -3644,7 +3671,8 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>>  				VM_PKT_DATA_INBAND,
>>
>> 	VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>>  		if (!ret)
>> -			ret = wait_for_response(hdev, &comp_pkt.host_event);
>> +			ret = wait_for_response(hdev, &comp_pkt.host_event,
>> +						"PCI_RESOURCE_ASSIGNED");
>>  		if (ret)
>>  			break;
>>
>> --
>> 2.53.0

