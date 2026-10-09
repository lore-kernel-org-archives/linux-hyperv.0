Received: from va-2-111.ptr.blmpb.com (va-2-111.ptr.blmpb.com [209.127.231.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B7F44D1799
	for <linux-hyperv@vger.kernel.org>; Fri,  9 Oct 2026 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791545822; cv=none; b=aLP1OzihZYSC9O2bS5x9TJ+DJfPDoqcsnPzuCpXti8iWwT+jv9nDRyn/QDANYPlGEuddNAKeHdMNhnhs/mOtbCbXt+/jqnlqJjHmnHgAhJwB0p3XPGER4TIlIFV3AJ1YpcldaFCvyJA8sd4gaywd/aWW4TTpiZcfkxfQVss+Ino=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791545822; c=relaxed/simple;
	bh=8k/5Z4rr3v5wnnmXNnfIwgUPTOxhtEbWjXvsVy/YWCk=;
	h=From:Subject:Cc:Content-Type:References:Message-Id:Date:
	 In-Reply-To:To:Mime-Version; b=XkyTt9O4JcL2P0/noWz5DdJUiMZs8HYBqSDzieuxrZVzHaA6x77xpRKLeO3JSCbcM0T9dXQW2ER2MseswLzND1dapphQU3F9B1RIcfl8eUlHvxUJ1AVhqq3FSyd9+CJvp1e/ohAcUOkx5jtxRFDqVWu24i4LHBQiw8A6kk2tgAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=WA/ISWET; arc=none smtp.client-ip=209.127.231.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="WA/ISWET"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1791545799; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=8k/5Z4rr3v5wnnmXNnfIwgUPTOxhtEbWjXvsVy/YWCk=;
 b=WA/ISWET9Nbp/njNn1DyIiLzQ3vKGEsb6zSV8I5bc5MBy5iLPhw8OWlnewkUp3t7VlQT9/
 QcULvw+1vKo1p0tPEvvTK8bMaNd+uNuZWvHluSS70L626NIurm8OnImqc8tcOk8KrhRSVS
 8mQupZLZ8BXNsTRKk8Qt2/oAbnHYf6syoX4RCn8K93lPBIS9+LCWiv1r818dR9ZB5AEHX+
 gLI9Tl9ZcXCDswKxCXtNEk50VERVh2l9nDUT1vXkCWranHvmJH7/NDU54k36zpO9pcRIof
 LrrbTtoafn2Ikyk0jDy+yYmEQsOW76vVBn3bERKJ8EXw1rBdDhqO2NVpC9kZWA==
From: "Fengnan" <changfengnan@bytedance.com>
Subject: Re: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
Cc: "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>, 
	"Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"Luigi Rizzo" <lrizzo@google.com>
Content-Type: text/plain; charset=UTF-8
References: <20261009050556.2817978-1-namjain@linux.microsoft.com> <MN2PR02MB6863FBC36CE4F1D6419F0E8BD4922@MN2PR02MB6863.namprd02.prod.outlook.com> <04d88297-1732-4761-ae82-d68c441a7156@linux.microsoft.com> <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
Message-Id: <1c7c7fd9-e2e6-41ac-ac97-9c4d71b1c2fc@bytedance.com>
Date: Fri, 9 Oct 2026 19:36:18 +0800
In-Reply-To: <3f4a11ea-bbc0-4dc5-9720-3447346739cf@linux.microsoft.com>
X-Original-From: Fengnan <changfengnan@bytedance.com>
X-Lms-Return-Path: <lba+26ac8d1c5+4ec76c+vger.kernel.org+changfengnan@bytedance.com>
To: "Naman Jain" <namjain@linux.microsoft.com>, 
	"Michael Kelley" <mhklinux@outlook.com>, 
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
User-Agent: Mozilla Thunderbird
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

Hi Naman:

This is an issue I hadn=E2=80=99t noticed before.=20
I'll take a closer look at this issue later.

Regarding testing, there are a few points to note:
1. My patch has been updated to V2, https://lore.kernel.org/linux-nvme/2026=
0826061546.56006-1-changfengnan@bytedance.com/
2. In my experience, when do performance tests, it=E2=80=99s best to do pre=
condition
first and then execute an ABBA test; this ensures reliable results.
3. IIRC, disabling interrupts in the QEMU kernel does not actually disable =
hardware
interrupts; QEMU still handles them, which has a significant impact on perf=
ormance testing.
Perhaps you could test this on a physical machine.

Also, I=E2=80=99d like to ask: does this softlockup issue only occur on QEM=
U+ARM?
or does it also occur on x86 physical machines?
Have you tried enabling the =E2=80=9CPosted Interrupt=E2=80=9D feature in V=
M? Maybe this will solve
this problem in VM.

Thanks.

=E5=9C=A8 2026/10/9 18:16, Naman Jain =E5=86=99=E9=81=93:
>=20
>=20
> On 10/9/2026 12:21 PM, Naman Jain wrote:
>>
>>
>> On 10/9/2026 11:24 AM, Michael Kelley wrote:
>>> From: Naman Jain <namjain@linux.microsoft.com> Sent: Thursday, October =
8, 2026 10:06 PM
>>>>
>>>> On systems with several fast NVMe controllers, completion interrupts c=
an
>>>> keep returning to the same CPUs faster than scheduled work can run. Ea=
ch
>>>> handler may drain only a small number of completions, but the combined
>>>> interrupt stream can still prevent scheduler and watchdog progress.
>>>
>>> See this recent proposal [1] that sounds like it is addressing the same=
 or a
>>> similar issue. And there is this [2] more global approach. It's worthwh=
ile to read
>>> through the discussion on both threads. I haven't done a detailed compa=
rison
>>> of either vs. your proposal.
>>>
>>> Michael
>>>
>>> [1] https://lore.kernel.org/linux-nvme/20260818033846.53790-1- changfen=
gnan@bytedance.com/
>>> [2] https://lore.kernel.org/lkml/20260819124341.4185621-1- lrizzo@googl=
e.com/
>>>
>>
>>
>> Thanks for sharing these Michael. I'll check more on these, and try it o=
ut.
>>
>> Regards,
>> Naman
>=20
> ++ authors of these two series, for awareness and if there is some config=
uration in their patches I should be trying to fix these lockup issues.
>=20
> I tested both GSIM v5 and the NVMe adaptive interrupt polling patch on
> the ARM64 Azure system where the NVMe hardirq soft lockup is reproducible=
.
>=20
> Test system
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> The VM has:
>=20
> =C2=A0 - 128 Arm Neoverse-V2 vCPUs
> =C2=A0 - two 64-CPU sockets / NUMA nodes
> =C2=A0 - approximately 862 GiB RAM
> =C2=A0 - four 3.5-TB Microsoft NVMe Direct Disk v2 data devices
> =C2=A0 - one NVMe OS device and one additional accelerator-facing NVMe
> =C2=A0=C2=A0=C2=A0 controller
> =C2=A0 - Hyper-V vPCI with MSI-X
> =C2=A0 - 14 I/O queues per data controller
>=20
> The four data controllers independently map their I/O vectors to the
> same 14 CPUs:
>=20
> =C2=A0 0, 10, 19, 28, 37, 46, 55, 64,
> =C2=A0 74, 83, 92, 101, 110, 119
>=20
> Thus each of these CPUs handles corresponding queues from all four data
> controllers.
>=20
> The kernel base for both experiments was:
>=20
> =C2=A0 next-20261006
> =C2=A0 eea3fef32a9cf36abcb5975a5a594e4135a6b026
> =C2=A0 7.3.0-rc6-next-20261006
>=20
> The main lockup workload was read-only:
>=20
> =C2=A0 - 4-KiB random reads
> =C2=A0 - libaio
> =C2=A0 - O_DIRECT
> =C2=A0 - four data devices
> =C2=A0 - 128 jobs
> =C2=A0 - iodepth 256
> =C2=A0 - 90-second nominal runtime
>=20
> NVMe interrupt coalescing was disabled (FID 0x08 =3D 0), and
> nvme.use_threaded_interrupts was zero.
>=20
> Without a mitigation, the watchdog reports soft lockups after about
> 26 seconds, normally on all 14 CPUs listed above.
>=20
> Conclusion
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> On this VM:
>=20
> =C2=A0 - GSIM v5 did not prevent the lockup with any tested adaptive or f=
ixed
> =C2=A0=C2=A0=C2=A0 setting, including the documented benchmark settings a=
nd the maximum
> =C2=A0=C2=A0=C2=A0 allowed delay.
> =C2=A0 - NVMe adaptive polling can improve throughput for sufficiently de=
nse
> =C2=A0=C2=A0=C2=A0 individual queues, but it did not prevent the producti=
on lockup
> =C2=A0=C2=A0=C2=A0 because the aggregate cross-controller load was spread=
 across enough
> =C2=A0=C2=A0=C2=A0 queues that most queues did not meet the fixed 10-us a=
dmission
> =C2=A0=C2=A0=C2=A0 threshold.
>=20
> The production failure is triggered by aggregate scheduler starvation
> from many queues and controllers sharing the same IRQ CPUs. Neither
> generic interrupt-rate moderation nor per-queue throughput-based
> adaptation directly observes that condition.
>=20
>=20
> More details:
>=20
> GSIM v5
> =3D=3D=3D=3D=3D=3D=3D
>=20
> I tested the complete seven-patch v5 series:
>=20
> https://lore.kernel.org/all/20260819124341.4185621-1-lrizzo@google.com/
>=20
> The kernel was built with:
>=20
> =C2=A0 CONFIG_IRQ_SW_MODERATION=3Dy
> =C2=A0 CONFIG_IRQ_TIME_ACCOUNTING=3Dy
>=20
> GSIM is runtime-disabled and per-IRQ opt-in by default. I identified the
> 56 dedicated I/O vectors belonging to the four data controllers. All 56
> were eligible and exposed allow_sw_moderation, and only those vectors
> were enabled.
>=20
> I first verified the same GSIM-patched kernel with runtime moderation
> disabled. It reproduced the soft lockup, as expected.
>=20
> I then tested the suggested adaptive configuration from the cover letter:
>=20
> =C2=A0 delay_us=3D100
> =C2=A0 target_intr_rate=3D1000000
> =C2=A0 hardirq_percent=3D70
> =C2=A0 update_ms=3D5
>=20
> I also tested the exact adaptive configuration used in patch 6's
> benchmark section:
>=20
> =C2=A0 delay_us=3D200
> =C2=A0 target_intr_rate=3D1000000
> =C2=A0 hardirq_percent=3D70
> =C2=A0 update_ms=3D5
>=20
> In addition, I tested fixed moderation at:
>=20
> =C2=A0 10, 25, 50, 75, 100, 200 and 500 us
>=20
> The 500-us value is the maximum allowed by the implementation.
>=20
> GSIM was definitely active. For the adaptive 100-us test, on the 14
> affected CPUs it selected delays between about 63 and 100 us, set
> 323,811 moderation timers, enqueued 506,557 IRQs, and recorded 24,332
> hardirq-over-threshold events.
>=20
> However, every full-duration GSIM-only configuration still soft-locked.
>=20
> A summary is:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QD=
1 IOPS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 QD256 outcome
>=20
> =C2=A0 GSIM off=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 24.2K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 soft lockup
> =C2=A0 adaptive 100 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 4.0K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soft lockup
> =C2=A0 adaptive 200 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 3.3K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 soft lockup / time=
out
> =C2=A0 fixed 10 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 22.1K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 so=
ft lockup
> =C2=A0 fixed 200 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 3.2K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sof=
t lockup
> =C2=A0 fixed 500 us=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 1.7K=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sof=
t lockup / timeout
>=20
> My interpretation is that GSIM reduces how often the NVMe interrupt
> handler runs, but it does not bound how much work the handler performs
> once entered. Delaying an interrupt permits more CQEs to accumulate, and
> the NVMe hardirq still drains the CQ until empty. On this topology that
> produces fewer, larger, still-unbounded hardirq executions.
>=20
> This does not contradict the reported GSIM benefits for systems limited
> by aggregate MSI-X traffic or PCIe/SoC backpressure. It means that on
> this VM the limiting issue is scheduler fairness inside the NVMe
> completion handler rather than interrupt-delivery overhead.
>=20
> NVMe adaptive interrupt polling
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
>=20
> I also tested:
>=20
> https://lore.kernel.org/linux-nvme/20260818033846.53790-1-changfengnan@by=
tedance.com/
>=20
> The posted revision also has the irq_poll full-budget bookkeeping issue
> reported in the review thread: it can call irq_poll_complete() and still
> return the full budget. Since the author acknowledged this and said it
> would be fixed in the next revision, I added only the corresponding
> one-line fix before boot testing. I did not boot the known-buggy state.
>=20
> The tested adaptive algorithm uses fixed constants:
>=20
> =C2=A0 - 10-us poll period and admission threshold
> =C2=A0 - 8,192 CQEs per sample/trial window
> =C2=A0 - irq_poll budget of 64 CQEs
> =C2=A0 - 64 successful windows per polling episode
> =C2=A0 - two immediate failed trials followed by a 524,288-CQE backoff
>=20
> I tested the same patched kernel with:
>=20
> =C2=A0 1. adaptive policy off
> =C2=A0 2. adaptive policy enabled at runtime through
> =C2=A0=C2=A0=C2=A0=C2=A0 /sys/class/nvme/nvmeX/adaptive_irq_polling
> =C2=A0 3. nvme.use_adaptive_irq_polling=3D1 at boot
>=20
> The runtime policy was enabled only for the four data controllers.
>=20
> For the production lockup workload, both runtime-on and boot-default-on
> still soft-locked at about 26 seconds.
>=20
> IRQ_POLL increased by only about 520 callbacks during the entire
> runtime-on test and by about 539 during the boot-default-on test.
>=20
> The reason appears to be the fixed per-queue admission threshold. With
> about 5M aggregate IOPS spread across 56 I/O queues:
>=20
> =C2=A0 5M / 56 ~=3D 89K CQEs/s per queue
> =C2=A0 average interval ~=3D 11.2 us
>=20
> The adaptive patch attempts polling only when the measured per-queue
> completion interval is at most 10 us. The workload is intense in
> aggregate, but the individual queues are just below the polling
> admission threshold.
>=20
> Boot-time enablement produced the same result, so runtime sysfs
> switching was not the issue.
>=20
> I then tested workloads intended to match the patch's expected dense
> per-queue case.
>=20
> With one SSD, one job:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 IRQ mode=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 adaptive mode
>=20
> =C2=A0 QD32=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 328K IOPS=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 328K IOPS
> =C2=A0 QD64=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 335K IOPS=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 443K IOPS
> =C2=A0 QD128=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 406K IOPS=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 232K IOPS
>=20
> At QD64, adaptive polling was clearly active (about 1.83M IRQ_POLL
> callbacks) and improved IOPS by about 32% while reducing latency. This
> matches the direction reported by the author.
>=20
> The results were not stable across repeats, however. A repeated QD64
> run was approximately neutral. QD128 produced both a regression and an
> improvement depending on run order/device state. This appears consistent
> with the author's comment that some benchmark results were still
> affected by drive-state variability.
>=20
> I also tested one SSD with 16 deep jobs pinned to one CPU. Adaptive
> polling activated, but averaged about 3% fewer IOPS than IRQ mode.
>=20
> Thanks,
> Naman
