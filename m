Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB22043CED8;
	Mon, 14 Sep 2026 10:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789382507; cv=none; b=NV6qrjAIdPwXrGn+k7zIE/ouWwcUac9YjaNJ+6W/jKGjFsz9/pK5rkOIWYQfmxOlhCbdulLtfnTVb+pM1wECk9gCMdLQDQY2UdUmmRQPvi1XGlg5olw4C/+3/BBAfcBNxX2YnYd4k4at2+XmuMtAVGEnUvJ4r63ZJMMBcQ4/7IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789382507; c=relaxed/simple;
	bh=94qu4rAdu9BDdMWqu386QnYL1IBJ4EFaF1ClssR1BME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lcy7XC/9WCd+ndsetc03m1EHUTiCzPGzeROBdJDRpmefPh84Ypb6zG64D/Jr5nvKUNP8nhNH8rDH2zM+qFmu6tGGFBW0SqgGe3A+ywTsHwYUV3C5mEAUstRV05mzTr3BQcvB/ObZaBJbBfNuX0d1EoOnOZFOvMq5eUoj/znbCNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BKnlUBUG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BKnlUBUG"
Received: from [10.26.7.43] (unknown [4.213.232.17])
	by linux.microsoft.com (Postfix) with ESMTPSA id CFD0E20B716A;
	Mon, 14 Sep 2026 03:40:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CFD0E20B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789382461;
	bh=ywbtivO3C7A9YnZodIeAOtYclDeN4qmK+nporFagxcw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BKnlUBUGB0PgLKRWoEyW/SfW9EnwOFv73PqSowkdaGoZSxVHi4I+ST4+/xc9y9Q4u
	 Nh1yKz8hC/hsq65kNrbsO605LhHPiTO5zIgHuTUSk8/G96/Xv2vF4/gxj2jd6eOkJs
	 JcC+8mPUyrQZQu1NTL1HqTNLFDk85O8XSpTvzjAk=
Message-ID: <59a834d6-0041-4eee-8ac0-5f035d093d71@linux.microsoft.com>
Date: Mon, 14 Sep 2026 16:11:38 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] PCI: hv: Warn when wait_for_response() waits
 indefinitely
To: Wei Liu <wei.liu@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: Naman Jain <namjain@linux.microsoft.com>, kys@microsoft.com,
 haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com,
 lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org,
 bhelgaas@google.com, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, mhklinux@outlook.com
References: <20260908113009.3005964-1-sahilchandna@linux.microsoft.com>
 <c8b6e10f-dd52-4c74-8d16-268563d8bc1f@linux.microsoft.com>
 <hen5k4ejonfffwdir7tfa2gnmxwfbbqabrjtwooo4o5pjf5gnz@x52vfm5phv3l>
 <20260913223952.GE2219269@liuwe-devbox-debian-v2.local>
Content-Language: en-US
From: Sahil Chandna <sahilchandna@linux.microsoft.com>
In-Reply-To: <20260913223952.GE2219269@liuwe-devbox-debian-v2.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14-09-2026 04:09, Wei Liu wrote:
> On Fri, Sep 11, 2026 at 12:29:05PM +0200, Manivannan Sadhasivam wrote:
>> On Wed, Sep 09, 2026 at 03:01:22PM +0530, Naman Jain wrote:
>>>
>>>
>>> On 9/8/2026 5:00 PM, Sahil Chandna wrote:
>>>> A guest can wait indefinitely in wait_for_response() for the host to
>>>> send either a rescind message or a packet completion. If the
>>>> host does not send either, the guest can remain blocked with no
>>>> diagnostic indicating a reason.
>>>> This was observed during a guest kernel upgrade in which the
>>>> host-side application handling the PCI channel faulted, causing the
>>>> guest to never receive the completion request.
>>>> Add a warning in wait_for_response() when the wait exceeds
>>>> a timeout so that such a hang is visible in the guest's kernel log
>>>> and can be correlated with host-side state.
>>>>
>>>> Suggested-by: Michael Kelley <mhklinux@outlook.com>
>>>> Signed-off-by: Sahil Chandna <sahilchandna@linux.microsoft.com>
>>>> ---
>>>> Changes since v2:
>>>> - Add counter based timeout instead of introducing another timer
>>>> Link to v2: https://lore.kernel.org/all/20260902115854.2629164-1-sahilchandna@linux.microsoft.com/
>>>>
>>>> Changes since v1:
>>>> - Removed periodic warning to one time warning in 2 minutes
>>>> - Include vmbus relid and stuck PCI msg.
>>>> Link to v1: https://lore.kernel.org/all/20260825051850.2438816-1-sahilchandna@linux.microsoft.com/
>>>>   drivers/pci/controller/pci-hyperv.c | 46 ++++++++++++++++++++++-------
>>>>   1 file changed, 36 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
>>>> index 89816a2bd7cd..bd07402c47ed 100644
>>>> --- a/drivers/pci/controller/pci-hyperv.c
>>>> +++ b/drivers/pci/controller/pci-hyperv.c
>>>> @@ -1040,19 +1040,38 @@ static void put_pcichild(struct hv_pci_dev *hpdev)
>>>>
>>>>   /*
>>>>    * There is no good way to get notified from vmbus_onoffer_rescind(),
>>>> - * so let's use polling here, since this is not a hot path.
>>>> + * so let's use polling here, since this is not a hot path. If
>>>> + * wait_for_response() has been polling for 2 minutes
>>>> + * without either a rescind or completion, add a warning.
>>>>    */
>>>> +#define PCI_RESPONSE_HANG_TICKS 1200
>>>> +
>>>
>>> Nit, I think this variable name could be misleading, as this represents a
>>> loop counter for a retry logic, but not exactly *ticks* from kernel
>>> terminology.
>>>
>>> I would have preferred something like: PCI_RESPONSE_WARN_POLL_COUNT.
Ack, I have added in v4.
>>>
>>
>> PCI_RESPONSE_POLL_COUNT?
> 
Hi Mani, i am inclining towards PCI_RESPONSE_WARN_POLL_COUNT as
intention of change is to emit a warning when counter has exceeded a set
threshold.

> Sahil, let me know if you will send out another version. If it is only
> changing one macro name, I can do that.
> 
Hi Wei,
I have sent out v4.

Regards,
Sahil
> Wei

