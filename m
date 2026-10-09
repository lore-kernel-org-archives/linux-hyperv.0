Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CED43712D;
	Fri,  9 Oct 2026 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541024; cv=none; b=bG0Axz9LcJd2GSeULE5neup6iYcQrppvHen8Vh5bWUl+JSkUYy8ERpCcHJ9f39T4/ImyKnd5+uMUt0Oacibjnzdx9/s2wBbrkyA8WglgXc3sTOTB7YgtYkFATugFrRJrVmFAeCSk39tmgcZ5wXNeWsmMLFcUwtkNb1rJk1rB0LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541024; c=relaxed/simple;
	bh=ISto/j656UEgSat7gnPG1nEukC7wgx6ne0uBqf8rbEs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XcUAhg4m4zR2rn0XYX0+PR0hciV4YhTBXsjkla2Vjw5n39XERZ7U2pFXHAzDHx8gKt6LLdHg4fAfQpn805JjA1ewu+GCifQBk1ApPs0J/1OldoZVpcTLmgxE8t7l7qWNN/24meg2gPTy5J04pCK/ObjIPExEQycJ9fYr/7/m3+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J31GRIcG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J31GRIcG"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E63620B7168;
	Fri,  9 Oct 2026 03:16:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E63620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791541021;
	bh=95KYDsC/jQyaQyl+pchLNxtyaRNhg4WZf9oEozC3kTI=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=J31GRIcGb5XJZct6UdxyxnnbY9Pvd4QGcEtGD5mj6myd1Ld7b3xiKeiGm/vms8AdB
	 joxsm0K95Idvxa6roehEka+Otg/n6Srg+0ysUXeQojxW9eWXzEhy6Q7m+Ib5FDidnw
	 QOuKZWe8EcFEmAEAf0sknHCuNMW/5Ug/5vpdQc7k=
Message-ID: <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
Date: Fri, 9 Oct 2026 15:46:55 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
From: Naman Jain <namjain@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 changfengnan@bytedance.com, Luigi Rizzo <lrizzo@google.com>
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/9/2026 12:21 PM, Naman Jain wrote:
> 
> 
> On 10/9/2026 11:24 AM, Michael Kelley wrote:
>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October 
>> 8, 2026 10:06 PM
>>>
>>> On systems with several fast NVMe controllers, completion interrupts can
>>> keep returning to the same CPUs faster than scheduled work can run. Each
>>> handler may drain only a small number of completions, but the combined
>>> interrupt stream can still prevent scheduler and watchdog progress.
>>
>> See this recent proposal [1] that sounds like it is addressing the 
>> same or a
>> similar issue. And there is this [2] more global approach. It's 
>> worthwhile to read
>> through the discussion on both threads. I haven't done a detailed 
>> comparison
>> of either vs. your proposal.
>>
>> Michael
>>
>> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1- 
>> changfengnan@bytedance.com/
>> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1- 
>> lrizzo@google.com/
>>
> 
> 
> Thanks for sharing these Michael. I'll check more on these, and try it out.
> 
> Regards,
> Naman

++ authors of these two series, for awareness and if there is some 
configuration in their patches I should be trying to fix these lockup 
issues.

I tested both GSIM v5 and the NVMe adaptive interrupt polling patch on
the ARM64 Azure system where the NVMe hardirq soft lockup is reproducible.

Test system
===========

The VM has:

   - 128 Arm Neoverse-V2 vCPUs
   - two 64-CPU sockets / NUMA nodes
   - approximately 862 GiB RAM
   - four 3.5-TB Microsoft NVMe Direct Disk v2 data devices
   - one NVMe OS device and one additional accelerator-facing NVMe
     controller
   - Hyper-V vPCI with MSI-X
   - 14 I/O queues per data controller

The four data controllers independently map their I/O vectors to the
same 14 CPUs:

   0, 10, 19, 28, 37, 46, 55, 64,
   74, 83, 92, 101, 110, 119

Thus each of these CPUs handles corresponding queues from all four data
controllers.

The kernel base for both experiments was:

   next-20261006
   eea3fef32a9cf36abcb5975a5a594e4135a6b026
   7.3.0-rc6-next-20261006

The main lockup workload was read-only:

   - 4-KiB random reads
   - libaio
   - O_DIRECT
   - four data devices
   - 128 jobs
   - iodepth 256
   - 90-second nominal runtime

NVMe interrupt coalescing was disabled (FID 0x08 = 0), and
nvme.use_threaded_interrupts was zero.

Without a mitigation, the watchdog reports soft lockups after about
26 seconds, normally on all 14 CPUs listed above.

Conclusion
==========

On this VM:

   - GSIM v5 did not prevent the lockup with any tested adaptive or fixed
     setting, including the documented benchmark settings and the maximum
     allowed delay.
   - NVMe adaptive polling can improve throughput for sufficiently dense
     individual queues, but it did not prevent the production lockup
     because the aggregate cross-controller load was spread across enough
     queues that most queues did not meet the fixed 10-us admission
     threshold.

The production failure is triggered by aggregate scheduler starvation
from many queues and controllers sharing the same IRQ CPUs. Neither
generic interrupt-rate moderation nor per-queue throughput-based
adaptation directly observes that condition.


More details:

GSIM v5
=======

I tested the complete seven-patch v5 series:

https://lore.kernel.org/all/20260819124341.4185621-1-lrizzo@google.com/

The kernel was built with:

   CONFIG_IRQ_SW_MODERATION=y
   CONFIG_IRQ_TIME_ACCOUNTING=y

GSIM is runtime-disabled and per-IRQ opt-in by default. I identified the
56 dedicated I/O vectors belonging to the four data controllers. All 56
were eligible and exposed allow_sw_moderation, and only those vectors
were enabled.

I first verified the same GSIM-patched kernel with runtime moderation
disabled. It reproduced the soft lockup, as expected.

I then tested the suggested adaptive configuration from the cover letter:

   delay_us=100
   target_intr_rate=1000000
   hardirq_percent=70
   update_ms=5

I also tested the exact adaptive configuration used in patch 6's
benchmark section:

   delay_us=200
   target_intr_rate=1000000
   hardirq_percent=70
   update_ms=5

In addition, I tested fixed moderation at:

   10, 25, 50, 75, 100, 200 and 500 us

The 500-us value is the maximum allowed by the implementation.

GSIM was definitely active. For the adaptive 100-us test, on the 14
affected CPUs it selected delays between about 63 and 100 us, set
323,811 moderation timers, enqueued 506,557 IRQs, and recorded 24,332
hardirq-over-threshold events.

However, every full-duration GSIM-only configuration still soft-locked.

A summary is:

                          QD1 IOPS       QD256 outcome

   GSIM off                 24.2K        soft lockup
   adaptive 100 us           4.0K        soft lockup
   adaptive 200 us           3.3K        soft lockup / timeout
   fixed 10 us              22.1K        soft lockup
   fixed 200 us              3.2K        soft lockup
   fixed 500 us              1.7K        soft lockup / timeout

My interpretation is that GSIM reduces how often the NVMe interrupt
handler runs, but it does not bound how much work the handler performs
once entered. Delaying an interrupt permits more CQEs to accumulate, and
the NVMe hardirq still drains the CQ until empty. On this topology that
produces fewer, larger, still-unbounded hardirq executions.

This does not contradict the reported GSIM benefits for systems limited
by aggregate MSI-X traffic or PCIe/SoC backpressure. It means that on
this VM the limiting issue is scheduler fairness inside the NVMe
completion handler rather than interrupt-delivery overhead.

NVMe adaptive interrupt polling
===============================

I also tested:

https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@bytedance.com/

The posted revision also has the irq_poll full-budget bookkeeping issue
reported in the review thread: it can call irq_poll_complete() and still
return the full budget. Since the author acknowledged this and said it
would be fixed in the next revision, I added only the corresponding
one-line fix before boot testing. I did not boot the known-buggy state.

The tested adaptive algorithm uses fixed constants:

   - 10-us poll period and admission threshold
   - 8,192 CQEs per sample/trial window
   - irq_poll budget of 64 CQEs
   - 64 successful windows per polling episode
   - two immediate failed trials followed by a 524,288-CQE backoff

I tested the same patched kernel with:

   1. adaptive policy off
   2. adaptive policy enabled at runtime through
      /sys/class/nvme/nvmeX/adaptive_irq_polling
   3. nvme.use_adaptive_irq_polling=1 at boot

The runtime policy was enabled only for the four data controllers.

For the production lockup workload, both runtime-on and boot-default-on
still soft-locked at about 26 seconds.

IRQ_POLL increased by only about 520 callbacks during the entire
runtime-on test and by about 539 during the boot-default-on test.

The reason appears to be the fixed per-queue admission threshold. With
about 5M aggregate IOPS spread across 56 I/O queues:

   5M / 56 ~= 89K CQEs/s per queue
   average interval ~= 11.2 us

The adaptive patch attempts polling only when the measured per-queue
completion interval is at most 10 us. The workload is intense in
aggregate, but the individual queues are just below the polling
admission threshold.

Boot-time enablement produced the same result, so runtime sysfs
switching was not the issue.

I then tested workloads intended to match the patch's expected dense
per-queue case.

With one SSD, one job:

               IRQ mode       adaptive mode

   QD32        328K IOPS      328K IOPS
   QD64        335K IOPS      443K IOPS
   QD128       406K IOPS      232K IOPS

At QD64, adaptive polling was clearly active (about 1.83M IRQ_POLL
callbacks) and improved IOPS by about 32% while reducing latency. This
matches the direction reported by the author.

The results were not stable across repeats, however. A repeated QD64
run was approximately neutral. QD128 produced both a regression and an
improvement depending on run order/device state. This appears consistent
with the author's comment that some benchmark results were still
affected by drive-state variability.

I also tested one SSD with 16 deep jobs pinned to one CPU. Adaptive
polling activated, but averaged about 3% fewer IOPS than IRQ mode.

Thanks,
Naman
