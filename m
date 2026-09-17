Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F953BD64A;
	Thu, 17 Sep 2026 04:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789618682; cv=none; b=abdfrVG2XMg8Pc2gdrRZpNYFsKiTmbYwX+flfJqt4IbfLCfz2h2Z4n3FXxnFvvdTDYhsRmrMuXQh0XyemC7vppTGmpAY9TzKq+gkszd8nuNQQAtKWzW12C9yPD3QN/3SVoaulzU7lyPeXIw4lUyo2+5oydlNKwmEQlG56gNu6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789618682; c=relaxed/simple;
	bh=26GnqgYxtB9JdP+RDaDXJjF+NXvLunCYGnwedQjCFS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F9rF7+sZhK+K3MheOeHqq23NTk6ZNpIVSrhuh+Wiu28Q5FDra1yboa3PCpZUG0nYjWHNUNIeDRy7VShWr+JzBNMRbidgeDOUY/Y5SxEg1yqNa/1H5lYlqk5MJ+N/zl/nM6/i41uLbh2+n4M6rJuluyFgRll/drfNbvGyXr7WQpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dKW0rFh+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dKW0rFh+"
Received: from [10.95.64.142] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68FD320B7166;
	Wed, 16 Sep 2026 21:17:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68FD320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789618628;
	bh=EWkJaPCGnadf9C319Yf1I683reFcIoPIjbK3zxDokJM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dKW0rFh+GSoaiomIVQO6ibYNYDFtq6bv3eaaW/28BE4tzPdBucxVMSFbAgEmGAQ8h
	 QQe7xs73adXtG/q/dIDlMYk7GdN6dgGOOUBd+u2993MhZkmY3QI9O/r7+OezsyeocE
	 jRJMEuAbAV6ueNx/sfoCk+KSpwJaQPS4slnROwzc=
Message-ID: <933f9e42-9f35-4513-ab69-93aef2284da5@linux.microsoft.com>
Date: Thu, 17 Sep 2026 09:47:49 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: hv: Probe vPCI buses asynchronously
To: sashiko-reviews@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
References: <20260907054742.235389-1-namjain@linux.microsoft.com>
 <20260907060205.2B97C1F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20260907060205.2B97C1F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 9/7/2026 11:32 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] VMBus transaction mappings are not removed when wait_for_response() aborts early, leading to stack or heap Use-After-Free (UAF) upon delayed host completion.
> - [High] Memory leak of child PCI devices (struct hv_pci_dev / hpdev) on the error paths of hv_pci_probe().
> - [High] Workqueue leaked on hv_pci_remove() if hv_pci_resume() previously failed.
> --
> 

All of the issues reported by Sashiko are pre-existing and unrelated to 
my patch. No action required.

Regards,
Naman

> commit acbe68fb0b4a7fd692c44acd0bc27c2e48b030db
> Author: Naman Jain <namjain@linux.microsoft.com>
> 
> PCI: hv: Probe vPCI buses asynchronously
>      
> On Hyper-V guests each virtual PCI bus is enumerated by its own
> hv_pci_probe() call. The probe performs several synchronous host
> request/response exchanges while negotiating the protocol, querying bus
> relations, entering D0, and reporting allocated resources.
> 
>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>> index 89816a2bd7cd3..056d379b3cee4 100644
>> --- a/drivers/pci/controller/pci-hyperv.c
>> +++ b/drivers/pci/controller/pci-hyperv.c
>> @@ -4155,6 +4155,9 @@ static struct hv_driver hv_pci_drv = {
>>   	.remove		= hv_pci_remove,
>>   	.suspend	= hv_pci_suspend,
>>   	.resume		= hv_pci_resume,
>> +	.driver = {
>> +		.probe_type = PROBE_PREFER_ASYNCHRONOUS,
>> +	},
>>   };
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential memory leak of child
> PCI device structures (struct hv_pci_dev) in the error paths of
> hv_pci_probe() in drivers/pci/controller/pci-hyperv.c.
> 
> If hv_pci_enter_d0() fails, the error path jumps directly to
> release_state_lock:
> 
>      ret = hv_pci_enter_d0(hdev);
>      if (ret)
>          goto release_state_lock;
> 
> This completely skips hv_pci_bus_exit(), which is responsible for unlinking
> and freeing the children.
> 
> Additionally, if an error occurs earlier and it jumps to exit_d0, it calls
> hv_pci_bus_exit() but skips freeing the devices:
> 
> exit_d0:
>      (void) hv_pci_bus_exit(hdev, true);
> release_state_lock:
>      mutex_unlock(&hbus->state_lock);
> 
> The keep_devs=true argument explicitly skips freeing the children.
> 
> In both situations, the hbus structure is subsequently freed, leaving the
> previously populated hbus->children list permanently leaked. Could these
> error paths be adjusted to ensure child devices are properly freed?
> 
> [Severity: High]
> This is a pre-existing issue, but could a workqueue be leaked in
> hv_pci_remove() if hv_pci_resume() had previously failed?
> 
> In drivers/pci/controller/pci-hyperv.c:hv_pci_resume(), hbus->state is
> initially set to hv_pcibus_init. If a subsequent operation fails, the
> function returns an error without restoring the state.
> 
> Later, when the device is removed, hv_pci_remove() checks the state before
> destroying the workqueue:
> 
>      if (hbus->state == hv_pcibus_installed) {
>          tasklet_disable(&hdev->channel->callback_event);
>          hbus->state = hv_pcibus_removing;
>          tasklet_enable(&hdev->channel->callback_event);
>          destroy_workqueue(hbus->wq);
>          hbus->wq = NULL;
>          ...
> 
> Since the state was left as hv_pcibus_init, this block is bypassed, and
> the workqueue is leaked when hbus is later freed. Does this state check need
> to be modified to ensure the workqueue is always destroyed on removal?
> 
> [Severity: Critical]
> This is a pre-existing issue, but can VMBus transaction mappings be left
> dangling when wait_for_response() aborts early, leading to a Use-After-Free
> upon delayed host completion?
> 
> In drivers/pci/controller/pci-hyperv.c, several functions allocate a
> struct pci_packet on the stack or heap, pass it to the VMBus requestor,
> and then wait for a response. For example, in new_pcichild_device():
> 
>      if (wait_for_response(hbus->hdev, &comp_pkt.host_event))
>          goto error;
> 
> Or in hv_pci_enter_d0():
> 
>      ret = wait_for_response(hdev, &comp_pkt.host_event);
>      if (ret)
>          goto exit;
> 
> Similar early returns occur in hv_read_config_block() and
> hv_write_config_block().
> 
> If wait_for_response() aborts immediately (e.g. returning -ENODEV due to a
> channel rescind), the caller returns and destroys its stack frame or frees
> the heap allocation.
> 
> However, the transaction ID mapping remains in the VMBus requestor. If the
> host sends a completion packet just after this, the hv_pci_onchannelcallback()
> tasklet will retrieve the dangling pointer and execute its completion_func,
> corrupting the stack or heap.
> 
> Should these functions use vmbus_request_addr_match() to remove the mapping
> on failure, similar to how hv_pci_bus_exit() handles it?
> 

