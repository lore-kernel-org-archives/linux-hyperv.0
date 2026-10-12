Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1B533290F;
	Mon, 12 Oct 2026 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791787714; cv=none; b=c48wOX0+aQoVAr4q3SwLNi/b1hFfUBbkZuNEofPU3CccDQvJw7M6e+fQp1Cl4L+aoKb24RrtmYPxD9Ox5AGekeP/h4nP6fFWIpXJ6Y4nY8f9cUDYYcvEW4PZgVdm/bz2ri33hnxHsS9rfrX3TI4z3CgaXPfsLsmGl13kTptcUeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791787714; c=relaxed/simple;
	bh=rtT3tTGa8gk0CuzSrAtSFZUDstS8Z/9Ns+H2QJMPs/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pERkgFVjO/XENQ2lD5HnTFuCHmWcQXHYGYtMBEe7uyt93wQJfF4eBfFOZ4WM4Twnz8blSsWl6hn5Afg8NIKDf7WSw6nuXqR6h1xGpZHL8+FfGpgXXouvEVRU5fIm2bIYcJ9HQopAwqW9a2CTdc9zow2h3C54Bw38XkFtvV7XYG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VToYsxpI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VToYsxpI"
Received: from [10.95.64.165] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7365E20B7166;
	Sun, 11 Oct 2026 23:48:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7365E20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791787709;
	bh=S8IKX8ubkHtKOLf9cl0KgaNRiyp0Q9kQDAqwQx6N3RI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VToYsxpIspJqiag8idxiIMMi3tmMPGrOm5xt17l26yxhccwutNlG/kXCEf8jSjLCP
	 EqJ+mtgAP83YOtcQS32FTiW+T5uYT/y5QuZCGqPYmoBVC11nEl0TPVO1HTl1gR7wxC
	 Xax6C80GdUTc7dZTi/dVTtsfzotmmYim9G+qNNSw=
Message-ID: <8bff7953-a9df-4ede-b3de-a4df558946a9@linux.microsoft.com>
Date: Mon, 12 Oct 2026 12:18:26 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
To: Fengnan <changfengnan@bytedance.com>,
 Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Luigi Rizzo <lrizzo@google.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
 <1c7c7fd9-e2e6-41ac-ac97-9c4d71b1c2fc@bytedance.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <1c7c7fd9-e2e6-41ac-ac97-9c4d71b1c2fc@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/9/2026 5:06 PM, Fengnan wrote:
> Hi Naman:
> 
> This is an issue I hadn’t noticed before.
> I'll take a closer look at this issue later.
> 
> Regarding testing, there are a few points to note:
> 1. My patch has been updated to V2, https://lore.kernel.org/linux-nvme/20260826061546.56006-1-changfengnan@bytedance.com/
> 2. In my experience, when do performance tests, it’s best to do precondition
> first and then execute an ABBA test; this ensures reliable results.
> 3. IIRC, disabling interrupts in the QEMU kernel does not actually disable hardware
> interrupts; QEMU still handles them, which has a significant impact on performance testing.
> Perhaps you could test this on a physical machine.
> 
> Also, I’d like to ask: does this softlockup issue only occur on QEMU+ARM?
> or does it also occur on x86 physical machines?
> Have you tried enabling the “Posted Interrupt” feature in VM? Maybe this will solve
> this problem in VM.
> 
> Thanks.

Hi Fengnan,
Thanks for the suggestion.

I was using QEMU just for sanity, all the test results are based on 
experiments in an Azure ARM64 Hyper-V VM. I could not create enough load 
on my local QEMU VM to cause a lockup, so I am relying only on the Azure 
VM I have. I would not rule out x86 for this issue, as we have seen 
spurious lockups in the fleet, which are more common on certain SKUs, 
but my current experiments are limited to arm64. The proposed solution 
should solve it for both.

The guest exposes a GICv3 CPU interface and Hyper-V vPCI maps the NVMe 
MSI-X vectors as guest GIC SPIs. I do not see an ITS, LPIs/vLPIs, GICv4 
VPEs, or another direct virtual interrupt injection interface exposed to 
the guest. Also, posted/direct interrupts would reduce host-to-guest 
interrupt injection overhead, but the lockup here occurs after delivery, 
while nvme_irq() repeatedly drains completion queues in guest hardirq 
context. So I would not expect posted interrupts alone to provide the 
missing scheduling boundary.

Thanks,
Naman

> 
> 在 2026/10/9 18:16, Naman Jain 写道:
>>
>>
>> On 10/9/2026 12:21 PM, Naman Jain wrote:
>>>
>>>
>>> On 10/9/2026 11:24 AM, Michael Kelley wrote:
>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October 8, 2026 10:06 PM
>>>>>
>>>>> On systems with several fast NVMe controllers, completion interrupts can
>>>>> keep returning to the same CPUs faster than scheduled work can run. Each
>>>>> handler may drain only a small number of completions, but the combined
>>>>> interrupt stream can still prevent scheduler and watchdog progress.
>>>>
>>>> See this recent proposal [1] that sounds like it is addressing the same or a
>>>> similar issue. And there is this [2] more global approach. It's worthwhile to read
>>>> through the discussion on both threads. I haven't done a detailed comparison
>>>> of either vs. your proposal.
>>>>
>>>> Michael
>>>>
>>>> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1- changfengnan@bytedance.com/
>>>> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1- lrizzo@google.com/
>>>>
>>>
>>>
>>> Thanks for sharing these Michael. I'll check more on these, and try it out.
>>>
>>> Regards,
>>> Naman
>>
>> ++ authors of these two series, for awareness and if there is some configuration in their patches I should be trying to fix these lockup issues.
>>
>> I tested both GSIM v5 and the NVMe adaptive interrupt polling patch on
>> the ARM64 Azure system where the NVMe hardirq soft lockup is reproducible.
>>
>> Test system
>> ===========
>>
>> The VM has:
>>
>>    - 128 Arm Neoverse-V2 vCPUs
>>    - two 64-CPU sockets / NUMA nodes
>>    - approximately 862 GiB RAM
>>    - four 3.5-TB Microsoft NVMe Direct Disk v2 data devices
>>    - one NVMe OS device and one additional accelerator-facing NVMe
>>      controller
>>    - Hyper-V vPCI with MSI-X
>>    - 14 I/O queues per data controller
>>
>> The four data controllers independently map their I/O vectors to the
>> same 14 CPUs:
>>
>>    0, 10, 19, 28, 37, 46, 55, 64,
>>    74, 83, 92, 101, 110, 119
>>
>> Thus each of these CPUs handles corresponding queues from all four data
>> controllers.
>>
>> The kernel base for both experiments was:
>>
>>    next-20261006
>>    eea3fef32a9cf36abcb5975a5a594e4135a6b026
>>    7.3.0-rc6-next-20261006
>>
>> The main lockup workload was read-only:
>>
>>    - 4-KiB random reads
>>    - libaio
>>    - O_DIRECT
>>    - four data devices
>>    - 128 jobs
>>    - iodepth 256
>>    - 90-second nominal runtime
>>
>> NVMe interrupt coalescing was disabled (FID 0x08 = 0), and
>> nvme.use_threaded_interrupts was zero.
>>
>> Without a mitigation, the watchdog reports soft lockups after about
>> 26 seconds, normally on all 14 CPUs listed above.
>>
>> Conclusion
>> ==========
>>
>> On this VM:
>>
>>    - GSIM v5 did not prevent the lockup with any tested adaptive or fixed
>>      setting, including the documented benchmark settings and the maximum
>>      allowed delay.
>>    - NVMe adaptive polling can improve throughput for sufficiently dense
>>      individual queues, but it did not prevent the production lockup
>>      because the aggregate cross-controller load was spread across enough
>>      queues that most queues did not meet the fixed 10-us admission
>>      threshold.
>>
>> The production failure is triggered by aggregate scheduler starvation
>> from many queues and controllers sharing the same IRQ CPUs. Neither
>> generic interrupt-rate moderation nor per-queue throughput-based
>> adaptation directly observes that condition.
>>
>>
>> More details:
>>
>> GSIM v5
>> =======
>>
>> I tested the complete seven-patch v5 series:
>>
>> https://lore.kernel.org/all/20260819124341.4185621-1-lrizzo@google.com/
>>
>> The kernel was built with:
>>
>>    CONFIG_IRQ_SW_MODERATION=y
>>    CONFIG_IRQ_TIME_ACCOUNTING=y
>>
>> GSIM is runtime-disabled and per-IRQ opt-in by default. I identified the
>> 56 dedicated I/O vectors belonging to the four data controllers. All 56
>> were eligible and exposed allow_sw_moderation, and only those vectors
>> were enabled.
>>
>> I first verified the same GSIM-patched kernel with runtime moderation
>> disabled. It reproduced the soft lockup, as expected.
>>
>> I then tested the suggested adaptive configuration from the cover letter:
>>
>>    delay_us=100
>>    target_intr_rate=1000000
>>    hardirq_percent=70
>>    update_ms=5
>>
>> I also tested the exact adaptive configuration used in patch 6's
>> benchmark section:
>>
>>    delay_us=200
>>    target_intr_rate=1000000
>>    hardirq_percent=70
>>    update_ms=5
>>
>> In addition, I tested fixed moderation at:
>>
>>    10, 25, 50, 75, 100, 200 and 500 us
>>
>> The 500-us value is the maximum allowed by the implementation.
>>
>> GSIM was definitely active. For the adaptive 100-us test, on the 14
>> affected CPUs it selected delays between about 63 and 100 us, set
>> 323,811 moderation timers, enqueued 506,557 IRQs, and recorded 24,332
>> hardirq-over-threshold events.
>>
>> However, every full-duration GSIM-only configuration still soft-locked.
>>
>> A summary is:
>>
>>                           QD1 IOPS       QD256 outcome
>>
>>    GSIM off                 24.2K        soft lockup
>>    adaptive 100 us           4.0K        soft lockup
>>    adaptive 200 us           3.3K        soft lockup / timeout
>>    fixed 10 us              22.1K        soft lockup
>>    fixed 200 us              3.2K        soft lockup
>>    fixed 500 us              1.7K        soft lockup / timeout
>>
>> My interpretation is that GSIM reduces how often the NVMe interrupt
>> handler runs, but it does not bound how much work the handler performs
>> once entered. Delaying an interrupt permits more CQEs to accumulate, and
>> the NVMe hardirq still drains the CQ until empty. On this topology that
>> produces fewer, larger, still-unbounded hardirq executions.
>>
>> This does not contradict the reported GSIM benefits for systems limited
>> by aggregate MSI-X traffic or PCIe/SoC backpressure. It means that on
>> this VM the limiting issue is scheduler fairness inside the NVMe
>> completion handler rather than interrupt-delivery overhead.
>>
>> NVMe adaptive interrupt polling
>> ===============================
>>
>> I also tested:
>>
>> https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@bytedance.com/
>>
>> The posted revision also has the irq_poll full-budget bookkeeping issue
>> reported in the review thread: it can call irq_poll_complete() and still
>> return the full budget. Since the author acknowledged this and said it
>> would be fixed in the next revision, I added only the corresponding
>> one-line fix before boot testing. I did not boot the known-buggy state.
>>
>> The tested adaptive algorithm uses fixed constants:
>>
>>    - 10-us poll period and admission threshold
>>    - 8,192 CQEs per sample/trial window
>>    - irq_poll budget of 64 CQEs
>>    - 64 successful windows per polling episode
>>    - two immediate failed trials followed by a 524,288-CQE backoff
>>
>> I tested the same patched kernel with:
>>
>>    1. adaptive policy off
>>    2. adaptive policy enabled at runtime through
>>       /sys/class/nvme/nvmeX/adaptive_irq_polling
>>    3. nvme.use_adaptive_irq_polling=1 at boot
>>
>> The runtime policy was enabled only for the four data controllers.
>>
>> For the production lockup workload, both runtime-on and boot-default-on
>> still soft-locked at about 26 seconds.
>>
>> IRQ_POLL increased by only about 520 callbacks during the entire
>> runtime-on test and by about 539 during the boot-default-on test.
>>
>> The reason appears to be the fixed per-queue admission threshold. With
>> about 5M aggregate IOPS spread across 56 I/O queues:
>>
>>    5M / 56 ~= 89K CQEs/s per queue
>>    average interval ~= 11.2 us
>>
>> The adaptive patch attempts polling only when the measured per-queue
>> completion interval is at most 10 us. The workload is intense in
>> aggregate, but the individual queues are just below the polling
>> admission threshold.
>>
>> Boot-time enablement produced the same result, so runtime sysfs
>> switching was not the issue.
>>
>> I then tested workloads intended to match the patch's expected dense
>> per-queue case.
>>
>> With one SSD, one job:
>>
>>                IRQ mode       adaptive mode
>>
>>    QD32        328K IOPS      328K IOPS
>>    QD64        335K IOPS      443K IOPS
>>    QD128       406K IOPS      232K IOPS
>>
>> At QD64, adaptive polling was clearly active (about 1.83M IRQ_POLL
>> callbacks) and improved IOPS by about 32% while reducing latency. This
>> matches the direction reported by the author.
>>
>> The results were not stable across repeats, however. A repeated QD64
>> run was approximately neutral. QD128 produced both a regression and an
>> improvement depending on run order/device state. This appears consistent
>> with the author's comment that some benchmark results were still
>> affected by drive-state variability.
>>
>> I also tested one SSD with 16 deep jobs pinned to one CPU. Adaptive
>> polling activated, but averaged about 3% fewer IOPS than IRQ mode.
>>
>> Thanks,
>> Naman

