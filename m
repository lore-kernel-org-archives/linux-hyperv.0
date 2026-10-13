Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810364AF9EF;
	Tue, 13 Oct 2026 06:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791872525; cv=none; b=T4XjhNp7frAKWc2ygUVqEGrVD9h+iH1agT+6x/R3HxqVTQa+2xptqd0DXQnWyvLnj/d1SduF6+dlVfaWkWD1TBNTthAGyBWkxkww6clBc46uQSrkwGE8IMQSDm7oH1YFFi0ycUcZWtU2cLaBpfNAYNOdELx6XPSYXoaGTNnnylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791872525; c=relaxed/simple;
	bh=xgOLk7flWMhVw6U8jDioV5eeg1StxLwoYDsFNv9Y4OE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KnTVLRPxBCq7wgURpapscwCsQfSsyQN/eC6uIzXp13uFqTnEALN98GfODlD45U31Y6v1AVG0e6iyivHzUxBrg1o2zp5oLZVW0nvmAvCV8KK5jY1jmPiO9/aBVBMli4BuCbpZeLEhJDJGECJK8zV1UCGWMOlQHl6gVjlfW/3u+JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kXohCe+e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kXohCe+e"
Received: from [192.168.1.70] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id D5CAF20B7168;
	Mon, 12 Oct 2026 23:21:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D5CAF20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791872513;
	bh=NAGrMKjtlZz/eupW1dfiN+r+MTw8HHSL7BCtqPOMXSs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kXohCe+e/8OZlIl+kjyehwPMMqX7l7u4nj+dfYELNVZWXEX43IP8FKgBudaab8NKl
	 QU2EMS/rhe/5osPdg5GUj5IRvkgQc85pTnWwDe0Sa1xGXwv5JUi0rbZOhK127jwK2i
	 2Uky1LG+tnMp/t3ZMFcXkvAVTfhxwk8vDIVKeCVU=
Message-ID: <1d12109d-2f47-4ca5-af7b-66c032a379a7@linux.microsoft.com>
Date: Tue, 13 Oct 2026 11:51:50 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler
 pressure
To: Luigi Rizzo <lrizzo@google.com>
Cc: Michael Kelley <mhklinux@outlook.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 changfengnan@bytedance.com
References: <20261009050556.2817978-1-namjain@linux.microsoft.com>
 <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com>
 <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com>
 <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
 <CAMOZA0Ljw-DueDP3WvmtYe4x9Y_fNaptAo+3Hv8xzYHOZi9vbQ@mail.gmail.com>
 <CAMOZA0KJoS4GFrKmaGa7+qMCNktTUg-YpkzX_EoA2KfAW3iN_g@mail.gmail.com>
 <53b199f9-56f6-4b44-93a5-be6437fd3fc4@linux.microsoft.com>
 <CAMOZA0JrxakyxxYPu72hk-jWQpW33-0BGFkZX-n_3D+28eDuGA@mail.gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <CAMOZA0JrxakyxxYPu72hk-jWQpW33-0BGFkZX-n_3D+28eDuGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/12/2026 2:47 PM, Luigi Rizzo wrote:
> On Mon, Oct 12, 2026 at 10:19 AM Naman Jain <namjain@linux.microsoft.com> wrote:
>>
>>
>>
>> On 10/9/2026 8:28 PM, Luigi Rizzo wrote:
>>> On Fri, Oct 9, 2026 at 1:27 PM Luigi Rizzo <lrizzo@google.com> wrote:
>>>>
>>>> On Fri, Oct 9, 2026 at 12:17 PM Naman Jain <namjain@linux.microsoft.com> wrote:
>>>>>
>>>>>
>>>>>
>>>>> On 10/9/2026 12:21 PM, Naman Jain wrote:
>>>>>>
>>>>>>
>>>>>> On 10/9/2026 11:24 AM, Michael Kelley wrote:
>>>>>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October
>>>>>>> 8, 2026 10:06 PM
>>>>>>>>
>>>>>>>> On systems with several fast NVMe controllers, completion interrupts can
>>>>>>>> keep returning to the same CPUs faster than scheduled work can run. Each
>>>>>>>> handler may drain only a small number of completions, but the combined
>>>>>>>> interrupt stream can still prevent scheduler and watchdog progress.
>>>>>>>
>>>>>>> See this recent proposal [1] that sounds like it is addressing the
>>>>>>> same or a
>>>>>>> similar issue. And there is this [2] more global approach. It's
>>>>>>> worthwhile to read
>>>>>>> through the discussion on both threads. I haven't done a detailed
>>>>>>> comparison
>>>>>>> of either vs. your proposal.
>>>>>>>
>>>>>>> Michael
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1-
>>>>>>> changfengnan@bytedance.com/
>>>>>>> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1-
>>>>>>> lrizzo@google.com/
>>>>>>>
>>>>>>
>>>>>>
>>>>>> Thanks for sharing these Michael. I'll check more on these, and try it out.
>>>>>>
>>>>>> Regards,
>>>>>> Naman
>>>>>
>>>>> ++ authors of these two series, for awareness and if there is some
>>>>> configuration in their patches I should be trying to fix these lockup
>>>>> issues.
>>>>
>>
>> Hi Luigi,
>> Thanks for looking into it.
> ...
>> GSIM was creating gaps for individual sources, but the other NVMe
>> sources sharing that CPU were filling most of them.
>>
>> I traced irq_handler_entry/irq_handler_exit with trace-cmd for the four
>> NVMe queue vectors routed to CPU0. The test used GSIM fixed at 10 us
>> with all 56 data-NVMe I/O vectors opted in.
>>
>> Without timer push, I recorded 37,218 NVMe handler invocations in three
>> seconds. The median handler duration was about 2 us, but the median gap
>> between NVMe handlers was only 4 us. The p99 gap was 872 us.
> 
> (medians are not a good metric in an environment where there might be
> a lot of idle runs because a previous, delayed run already consumed all CQs.
> You may want to look at the full distribution, I expect to see a step at some
> point, the exact percentile depends on how many queues share the same CPU)
> 
> Just a clarification, the pattern I expect on CPU0 is something like this
> NVME0 NVME1 NVME2 NVME3 TIMER_PUSH NVME0 ...
> what is "mediam gap between handlers", is it the time between NVME0 and
> the next NVME0, or between any two NVMEx and NVMEy ?

The earlier term was ambiguous. I now use two separate definitions:

   any-source gap:
     previous NVMe handler exit to the next NVMe handler entry for any of
     the four CPU0 NVMe vectors, i.e. NVMEx -> NVMEy

   same-source recurrence:
     previous exit to the next entry of the same vector, e.g.
     NVME0 -> next NVME0

The earlier 4-us push-off and 517-us push-on medians were the any-source 
gaps, not same-source recurrence.

I reran the tests, and the distribution confirms two effects:

1. Without push, many handler runs remain very short, but different NVMe 
sources can run almost back-to-back.

2. With push, the CPU gets much larger gaps, but CQ work accumulates and 
the replayed NVMe hardirq commonly runs for several milliseconds.

The multi source pattern you mentioned, is correct.
NVME0 NVME1 NVME2 NVME3 TIMER_PUSH NVME0 ...

> 
>> With timer push enabled, the same three-second CPU0 trace contained only
>> 531 NVMe handler invocations, and the median gap increased from 4 us to
>> 517 us. This confirms your diagnosis, adding one delay per additional
>> source restores a real CPU-wide gap.
>>
>> The full QD256 workload then completed without a soft lockup or kernel
>> taint. There was a significant cost, though. The delayed completions
>> accumulated into much larger CQ batches:
>>
>>     - median NVMe handler duration increased from 2 us to 3.1 ms
>>     - p99 handler duration increased from 106 us to 7.1 ms
>>
>> For comparison on the same workload:
>>
>>     fixed 10-us GSIM + timer push: 1.906M IOPS
>>     adaptive GSIM + timer push:    1.712M IOPS
>>     threaded NVMe IRQs:            3.165M IOPS
>>     NVMe IRQ-poll fallback:        4.986M IOPS
>>
>> So the timer-push idea does prevent the lockup, and the trace confirms
>> the multi-source gap issue. On this NVMe topology, however, delaying all
>> sources creates very large completion batches, and the NVMe handler
>> still drains each batch without a bound in hardirq context. That causes
>> the large throughput and tail-latency cost above.
> 
> Yes, without touching the nvme handler to limit the number
> of entries processed in each run, there is only so much
> a generic solution like GSIM can do.
> This definitely warrants some NVME-specific changes
> such as those proposed by Fengnan, and they are in line
> with what NAPI already does by using a bounded batch
> and rescheduling the handler.

Agreed. Timer-push GSIM changes when the NVMe hardirq runs, but it does 
not move NVMe completion processing out of hardirq or bound the amount 
drained after replay, which is required to avoid lockups.

> 
> I am a bit surprised by your numbers regarding the differences with
> and without timer push, so I would like to understand
> the numbers better.
> (As an aside, 10us is really a bit too short for GSIM delay, because
> almost 50% of the time gets eaten by the context switching.
> At least for an initial assessment I would start testing with a fixed 30-50us)

The push-off/push-on IRQ trace was an earlier short experiment with 
fixed 10-us GSIM:

                                   push off       push on
   short-run IOPS                    2.164M         1.944M
   CPU0 handlers / 3 seconds        37,219            531
   eventual full-test lockup            yes             no

Those short-run IOPS are not completed 90-second results, as all the 
long duration timer push off experiments eventually soft-locked.

The latest controlled three-run matrix used timer_push=1 for every GSIM row.

> 
> Can you clarify the following, specifically for the "full QD256 workload"
> - how many vectors are sharing one interrupt CPU (the previous test says 4),
>    and how many interrupt CPUs are used in total ?

There are four data NVMe controllers, each with 14 interrupt-driven I/O 
queues.

Corresponding queue vectors from the four controllers are routed to the 
same CPU. Therefore:

   vectors per affected CPU:       4
   affected interrupt CPUs:       14
   total data-NVMe I/O vectors:   56

The affected CPUs are:

   0, 10, 19, 28, 37, 46, 55,
   64, 74, 83, 92, 101, 110, 119

The matched unmodified control reproduced soft lockups on exactly those 
14 CPUs. The first watchdog report occurred 25 seconds after fio launch.

The production fio command is equivalent to:

   --filename=dev1:dev2:dev3:dev4
   --numjobs=128
   --iodepth=256
   --group_reporting

so the potential total is:
   128 x 256 = 32,768 requests

The NVMe hardware queue depth is 1,024, with 1,023 usable entries.

I tested fixed 30 us and 50 us as you suggested.

Every passing mode was tested three times, with a fresh boot before each 
sample. The workload uses a 10-second ramp followed by a 90-second 
measured runtime.

NVMe fallback: this series
threaded NVMe IRQs: Default kernel with nvme.use_threaded_interrupts=1

High-load results are medians of three runs, you can find complete 
minimum-to-maximum range:

                               IOPS median       complete range
   NVMe fallback                 5.004M          5.002-5.004M
   threaded NVMe IRQs            3.140M          3.100-3.169M
   GSIM fixed 10 us + push       1.962M          1.935-2.025M
   GSIM fixed 30 us + push       1.790M          1.775-1.822M
   GSIM fixed 50 us + push       1.744M          1.736-1.746M

Completion latency:
                               mean        p99          p99.9
   NVMe fallback              6.533 ms    14.352 ms     16.908 ms
   threaded NVMe IRQs        10.421 ms    22.151 ms     24.510 ms
   GSIM fixed 10 us + push   16.570 ms    38.011 ms    270.533 ms
   GSIM fixed 30 us + push   18.283 ms    40.108 ms    492.831 ms
   GSIM fixed 50 us + push   18.743 ms    40.632 ms    541.065 ms

Relative to the fallback median, threaded IRQs are 37.24% lower, while 
fixed 10/30/50-us timer-push GSIM is 60.78%/64.22%/65.15% lower.

QD1 results were:
                               IOPS median       complete range
   unmodified hardirq           25,518          one run
   NVMe fallback                25,520          23,212-25,552
   threaded NVMe IRQs           22,253          22,035-22,466
   GSIM fixed 10 us + push      21,080          21,032-21,931
   GSIM fixed 30 us + push       5,496           5,259-5,608
   GSIM fixed 50 us + push       5,492           5,224-5,589

The 30-us and 50-us settings on this VM, do not improve high-load 
performance relative to fixed 10 us and they reduce QD1 performance 
substantially.

I also traced fixed 30 us plus timer push on CPU0:

   handler count:                    550 in three seconds
   handler busy fraction:            53.05%
   handler duration p50:             2.888 ms
   handler duration p90:             5.187 ms
   handler duration p99:             6.655 ms
   handler duration p99.9:           7.461 ms
   handler duration maximum:         7.805 ms
   any-source gap p50:               439 us
   any-source gap p90:               8.073 ms
   any-source gap p99:               13.319 ms
   same-source recurrence p50:       18.782 ms
   same-source recurrence p99:       35.551 ms

> - From my experience (different environments), I have measured
>    < 1 queue - 1 interrupt CPU - 1 user thread > saturating at 400-600KIOPS
>    (I don't remember whether the bottleneck is the user or interrupt CPU).
>    At those rates, 256 outstanding entries may take some 500us to be processed.
>    so it seems strange that the median NVME handler (per queue?) takes 3ms.
> - these times will be scaled down if each drive uses many queues so the
>    average throughput per queue will be lower, and such to keep the total
>    rate for each interrupt CPU below its 400K cap.
> 
> My expectations is something along these lines:
> - the outstanding CQ queue cannot exceed QD ie 256 in your test
> - worst case each handler should run at most some 500us
> - four queues will create a total QD=1024 so the interrupt CPU
>    will take at least 2ms to drain them
> 

At approximately 5M aggregate IOPS, 56 queues (4 devices), an 
even-distribution estimate is:

   5,000,000 / 56
     = approximately 89,286 completions/s/queue

or:
   1,000,000 us / 89,286
     = approximately 11.2 us/completion/queue

The measured queue occupancy is more important here i.e. despite the 
lower average throughput per hardware queue, timer-push batching allowed 
all four traced queues to reach 1,023 outstanding commands.

I also ran a separate experiment matching a true total outstanding depth 
of 256:

   four jobs
   one job per disk
   iodepth=64 per job
   all jobs pinned to CPU0

Therefore: 4 x 64 = 256 total potential outstanding requests

With fixed 30-us GSIM:

                               push off       push on
   total IOPS                    15.52K         15.22K
   handler duration p50           3 us           3 us
   handler duration p99           5 us           5 us
   any-source gap p50           267 us         270 us

Timer push had negligible effect in this sparse case because the 
workload already had large gaps.

Fixed 30-us moderation heavily throttled that control, so I repeated it
without GSIM moderation. It reached 263.6K IOPS total. Handler duration was:

   p50:       1 us
   p99:       4 us
   p99.9:     5 us
   maximum: 106 us

Therefore, your expectation of short handlers applies when total 
outstanding depth really is 256. The millisecond handlers in the 
production reproducer come from the much deeper 128-job workload and the 
accumulation caused by timer push.

Regards,
Naman
