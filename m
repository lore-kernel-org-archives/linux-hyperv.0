Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F816391825;
	Thu,  3 Sep 2026 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426093; cv=none; b=TQXbGQIhi07IByMatGf3y3eGlAKenTyCr1ytFO6p1TG37h3GOvhwtbiPl2y4MBvCEQMOCh78dXGxnCGV+kdMu+4qbevouTNFvEG3qRvQPu78wxi2nnf+Jc14I5WkcojOUoIIlQzPK0OSJgjtijQ1HvD8v4t0F5FnCTmzKXqLZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426093; c=relaxed/simple;
	bh=pJLqEdh5BKyLk+Z0K0nd9obpHNYsjuYK0HXdHdH74bA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tEeuobgcp26XbxSJeF0cBBjTZfjjq7emK/lVZtdwAzJWp1x/HKKYhMKg1Jfo8SPO4P+49XYszlZkAfZV3tEguE0u8/81VgrLmvJuE/IGny7ObPU40jdPawSzyi1ZcdsdQoLmHQ56z7R195Rhps0C3A6bpfW8K0DIzPBQ6XEX0HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nRn0N9/M; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nRn0N9/M"
Received: from [10.95.64.226] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id B5A4120B712D;
	Thu,  3 Sep 2026 02:00:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B5A4120B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788426055;
	bh=xWSrpShJ59jVErQSUL2BzyHUDerOTAuOsEeioNN/qhQ=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=nRn0N9/Mm7G1Sb+sxYsXIGjkocvUB3sZqbkJfga+dqiJHIceT+JsuY+Vby6RP3Zxg
	 t+MSMoBVNB1/kA4nc8bAQ5DhQxHIQtK8dYXZgskgjPGsvp21/TFYaugd1vi7Hsrryd
	 pfJUV1sxUXGIeliwQe+AjGGUqlzjdSZe8Jchk+0E=
Message-ID: <f3fe2dd2-51d9-42c0-8692-83976139f7a7@linux.microsoft.com>
Date: Thu, 3 Sep 2026 14:31:24 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] PCI: hv: warn when wait_for_response() waits
 indefinitely
To: Sahil Chandna <sahilchandna@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, mhklinux@outlook.com,
 hamzamahfooz@linux.microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 longli@microsoft.com, lpieralisi@kernel.org, kwilczynski@kernel.org,
 mani@kernel.org, robh@kernel.org, bhelgaas@google.com,
 linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260902115854.2629164-1-sahilchandna@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/2/2026 5:28 PM, Sahil Chandna wrote:
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
> Suggested-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> Suggested-by: Naman Jain <namjain@linux.microsoft.com>
> Suggested-by: Michael Kelley <mhklinux@outlook.com>

These two tags can be omitted IMO.

> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
> ---
> Changes since v1:
> - Removed periodic warning to one time warning in 2 minutes
> - Include vmbus relid and stuck PCI msg.
> Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
> ---
>   drivers/pci/controller/pci-hyperv.c | 48 +++++++++++++++++++++++------
>   1 file changed, 38 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 89816a2bd7cd..ca9d8efd748c 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1040,19 +1040,40 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
> 
>   /*
>    * There is no good way to get notified from vmbus_onoffer_rescind(),
> - * so let's use polling here, since this is not a hot path.
> + * so let's use polling here, since this is not a hot path. If
> + * wait_for_response() has been polling for PCI_RESPONSE_HANG_TIMEOUT_SEC
> + * without either a rescind or completion, add a warning.
>    */
> +#define PCI_RESPONSE_HANG_TIMEOUT_SEC 120
> +
>   static int wait_for_response(struct hv_device *hdev,
> -			     struct completion *comp)
> +			     struct completion *comp,
> +			     const char *msg_type)
>   {
> +	unsigned long delay = secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
> +	u64 timeout = get_jiffies_64() + delay;
> +	bool warned = false;
> +
>   	while (true) {
>   		if (hdev->channel->rescind) {
>   			dev_warn_once(&hdev->device, "The device is gone.\n");
>   			return -ENODEV;
>   		}
> 
> -		if (wait_for_completion_timeout(comp, HZ / 10))
> +		if (wait_for_completion_timeout(comp, HZ / 10)) {
> +			if (warned)
> +				dev_warn(&hdev->device,
> +					 "Late %s completion arrived.\n", msg_type);
>   			break;
> +		}
> +
> +		if (!warned && time_after64(get_jiffies_64(), timeout)) {
> +			dev_err(&hdev->device,
> +				"%s stuck waiting for response, relid = %u\n",
> +				msg_type, hdev->channel->offermsg.child_relid);
> +
> +			warned = true;
> +		}
>   	}
> 
>   	return 0;
> @@ -1518,7 +1539,8 @@ static int hv_read_config_block(struct pci_dev *pdev, void *buf,
>   	if (ret)
>   		return ret;
> 
> -	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
> +	ret = wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event,
> +				"PCI_READ_BLOCK");

Instead of hard-coding this msg type two times everywhere, would it be 
better to simply pass corresponding variable.message_type.type?

>   	if (ret)
>   		return ret;
> 
> @@ -1607,7 +1629,8 @@ static int hv_write_config_block(struct pci_dev *pdev, void *buf,
>   	if (ret)
>   		return ret;
> 
> -	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event);
> +	ret = wait_for_response(hbus->hdev, &comp_pkt.host_event,
> +				"PCI_WRITE_BLOCK");
>   	if (ret)
>   		return ret;
> 
> @@ -2624,7 +2647,8 @@ static struct hv_pci_dev *new_pcichild_device(struct hv_pcibus_device *hbus,
>   	if (ret)
>   		goto error;
> 
> -	if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
> +	if (wait_for_response(hbus->hdev, &comp_pkt.host_event,
> +			      "PCI_QUERY_RESOURCE_REQUIREMENTS"))
>   		goto error;
> 
>   	hpdev->desc = *desc;
> @@ -3256,7 +3280,8 @@ static int hv_pci_protocol_negotiation(struct hv_device *hdev,
>   				(unsigned long)pkt, VM_PKT_DATA_INBAND,
>   				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>   		if (!ret)
> -			ret = wait_for_response(hdev, &comp_pkt.host_event);
> +			ret = wait_for_response(hdev, &comp_pkt.host_event,
> +						"PCI_QUERY_PROTOCOL_VERSION");
> 
>   		if (ret) {
>   			dev_err(&hdev->device,
> @@ -3476,7 +3501,8 @@ static int hv_pci_enter_d0(struct hv_device *hdev)
>   			       (unsigned long)pkt, VM_PKT_DATA_INBAND,
>   			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>   	if (!ret)
> -		ret = wait_for_response(hdev, &comp_pkt.host_event);
> +		ret = wait_for_response(hdev, &comp_pkt.host_event,
> +					"PCI_BUS_D0ENTRY");
> 
>   	if (ret)
>   		goto exit;
> @@ -3553,7 +3579,8 @@ static int hv_pci_query_relations(struct hv_device *hdev)
>   	ret = vmbus_sendpacket(hdev->channel, &message, sizeof(message),
>   			       0, VM_PKT_DATA_INBAND, 0);
>   	if (!ret)
> -		ret = wait_for_response(hdev, &comp);
> +		ret = wait_for_response(hdev, &comp,
> +					"PCI_QUERY_BUS_RELATIONS");
> 
>   	/*
>   	 * In the case of fast device addition/removal, it's possible that
> @@ -3644,7 +3671,8 @@ static int hv_send_resources_allocated(struct hv_device *hdev)
>   				VM_PKT_DATA_INBAND,
>   				VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
>   		if (!ret)
> -			ret = wait_for_response(hdev, &comp_pkt.host_event);
> +			ret = wait_for_response(hdev, &comp_pkt.host_event,
> +						"PCI_RESOURCE_ASSIGNED");

There is an if-else condition before this, which can lead to message 
type be one of PCI_RESOURCES_ASSIGNED or PCI_RESOURCES_ASSIGNED2. 
Hard-coding it this way will miss PCI_RESOURCES_ASSIGNED2.

>   		if (ret)
>   			break;
> 
> --
> 2.53.0

Regards,
Naman

