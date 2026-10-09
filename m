Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1BF727B35F;
	Fri,  9 Oct 2026 05:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791522365; cv=none; b=dyBOftllhElFkwxZTG3iAGF3wwYFpzepKXSRoMPXp0TISVld3v3v2Dqf7kc035Vc9Dl260N6py6GEHo3UqwEZUrPJRfcMWEzNmA6SUXgw4wyDM5PWyrJ9XE8sgwumu+Pkg3kiuEEwnnYv4xH/Zh1rrJyKoArlm45psD4jFNvJUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791522365; c=relaxed/simple;
	bh=oudSEG2LlP69gVam2I4tXXvj58D8RUehRTIph05vmZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BNQd2KUf4PLKXyjZmcRO2Vv5tjn+QaEBuhRRswMqHyhDu3DGnJ9Ecg8bxr7GBmQku7apIso/+PU4zb3fjg/bkEbRrAPYx7kIeZLxRdiLkwSAP+325df/za6Ayg1ibOi4zkB+5RGf/jc4VzGWszKBuvE9FWJN6SwgFF5QdidOa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=api2nSQv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="api2nSQv"
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1561420B7166;
	Thu,  8 Oct 2026 22:05:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1561420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791522362;
	bh=EZHcU/fJ75D/YFV+/52EKTOe0fXHRks66pGLOM+iPCY=;
	h=From:To:Cc:Subject:Date:From;
	b=api2nSQvkXes0vTfLg8ltk+65TUyn+gYl+AKbhcr7+VC2/zdTpYLVLuL4KJZUNhWg
	 1fb48ktyspoGOlV+iTWyo2lRKhQWjSZxarROwXNlGD3strzkxf571jrckizgqp9HIT
	 NkGL4E/SOlFQgUz6QMuXH1mDieFosT0CCqV9nBSM=
From: Naman Jain <namjain@linux.microsoft.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Michael Kelley <mhklinux@outlook.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/3] nvme-pci: yield completions under scheduler pressure
Date: Fri,  9 Oct 2026 05:05:53 +0000
Message-ID: <20261009050556.2817978-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On systems with several fast NVMe controllers, completion interrupts can
keep returning to the same CPUs faster than scheduled work can run. Each
handler may drain only a small number of completions, but the combined
interrupt stream can still prevent scheduler and watchdog progress.

This series keeps the existing hardirq completion path for normal I/O.
For an I/O queue with a dedicated MSI-X vector, if an interrupt arrives
with a completion pending while need_resched() is set, mask that vector
and hand the queue to irq_poll. The poller drains bounded batches and
returns the queue to interrupt mode as soon as it catches up.

The completion-path transitions are:

                         +-----------------+
                         | normal IRQ mode |
                         +-----------------+
                                  |
                   CQE pending and need_resched()
                                  |
                                  v
                     mask vector, schedule irq_poll
                                  |
                                  v
                +--------------------------------+
          +---->| drain up to one poll budget    |
          |     +--------------------------------+
          |              |                 |
          |         full budget        short batch
          |              |                 |
          |              v                 v
          |     remain on poll list   irq_poll_complete()
          |              |           mark handoff allowance
          |     generic irq_poll      clear poll ownership
          |     invokes next pass     enable vector
          |              |                 |
          +--------------+                 v
                                  +-----------------+
                                  | normal IRQ mode |
                                  +-----------------+

A full-budget return deliberately stays on the irq_poll list. The generic
irq_poll core invokes another bounded pass. Eventually a pass consumes
less than its budget, takes the short-batch path, and restores interrupt
mode.

An MSI-X message may have been latched while the vector was masked, but
not every MSI-X hierarchy can report pending state. The handoff allowance
therefore does not claim that an interrupt is known to be stale. It lets
exactly one empty interrupt after unmasking return IRQ_HANDLED. If a new
completion is present, the normal completion path handles it.

The core idea is simple: when a hardirq sees need_resched(), it masks the
interrupt and offloads completion processing to irq_poll. The interrupt is
unmasked once the CQ catches up. Everything else handles queue and
controller state changes while irq_poll is active, because its asynchronous
callback can outlive the hardirq that scheduled it.

The lifecycle transitions are:

  normal IRQ mode / irq_poll
              |
              | set PAUSED, join IRQ and irq_poll, mask vector
              v
          +--------+
          | paused |---- temporary ----> resume after controller is ready
          +--------+                      clear PAUSED, restore IRQ mode
              |
              | permanent stop
              | clear INIT, balance owned mask, synchronize replay
              v
        free registered IRQ

INIT means the queue has an initialized irq_poll instance and a dedicated
MSI-X vector. IRQ_POLL owns completion processing, while MASKED records the
matching disable_irq_nosync(). PAUSED blocks IRQ handling and new admission.
HANDOFF allows one empty interrupt after unmasking. A temporary pause keeps
MASKED set for resume; permanent stop keeps PAUSED set through IRQ removal.

Admin, shared, legacy, and threaded interrupt paths are unchanged. Explicit
polling never enters irq_poll; it only disables bottom halves while holding
the shared CQ polling lock. The series adds no timer, rate sampler,
workqueue, sysfs knob, module parameter, or IRQ thread.

Why not use nvme.use_threaded_interrupts=1 instead?

Threaded mode installs nvme_irq_check() as the primary handler and
nvme_irq() as the IRQ thread. When the primary handler finds a pending
completion, it returns IRQ_WAKE_THREAD, so completion queue draining runs
through a schedulable task rather than the normal hardirq fast path.

That remains a useful opt-in mode and this series does not change it. On
the affected VM it prevented the lockup, but it also reduced peak
throughput. This series has a narrower goal: retain direct hardirq
completion while the CPU is keeping up, and use bounded irq_poll work
only after the scheduler has already asserted need_resched().

The distinction is not that irq_poll is always faster than an IRQ thread.
It is that the normal path is left alone, while the fallback creates a
scheduling boundary only after a reschedule request is observed.

need_resched() is used here as a best-effort pressure signal, not as an
interrupt-flood detector or an elapsed-time guarantee. It is transient,
and irq_poll may execute one bounded callback before the scheduler runs.
The narrower claim is that, once an NVMe hardirq observes an already
pending reschedule request, it stops unbounded CQ draining in hardirq.

Previous NVMe attempts made the fallback the normal high-load path. An
all-irq_poll RFC in 2016 reported an 8-10% single-core IOPS loss and a
measurable low-queue-depth latency cost. A hardirq-first, threaded
overflow series in 2019 fixed the Azure lockup, but Azure testing
reported a substantial throughput loss.

Relevant discussions from the past around this problem:

  https://lore.kernel.org/linux-nvme/1475660534-16681-1-git-send-email-sagi@grimberg.me/
  https://lore.kernel.org/lkml/1566281669-48212-1-git-send-email-longli@linuxonhyperv.com/
  https://lore.kernel.org/linux-nvme/20191209175622.1964-1-kbusch@kernel.org/

The first patch selects IRQ_POLL. The second makes existing task-context
CQ polling safe against the new softirq user. The third adds the NVMe
queue handoff and lifecycle handling.

The RFC starts with a per-queue weight of 256, matching the existing
global irq_poll budget. This is a starting point, not a claim that 256 is
the optimal NVMe value.

Testing included:

  - full x86_64 kernel build and strict checkpatch
  - four-controller QEMU fio, full-disable S3, controller reset, and
    post-reset I/O
  - QEMU lockdep, prove-locking, and atomic-context validation
  - ARM64 Hyper-V VM with four 14-queue NVMe data controllers
  - natural irq_poll activation with threaded interrupts disabled
  - matching default-hardirq, IRQ-poll fallback, and threaded-IRQ comparison
  - four controller resets followed by successful reads

Read-only 4 KiB random-read results follow. "Default hardirq" uses the
unpatched base. The other modes use the same kernel built from this series:
"IRQ-poll fallback" uses the default nvme.use_threaded_interrupts=0, while
"threaded IRQs" uses nvme.use_threaded_interrupts=1. Low-load values are
medians of two 30-second runs. High-load fallback and threaded values are
medians of two and three 90-second runs respectively; the default-hardirq
run locked up before it could complete.

                              default       IRQ-poll      threaded
                              hardirq       fallback      IRQs
  1 disk, QD1
    IOPS                      24.42K        24.96K        21.24K
    mean completion latency  38.94 us      38.17 us      44.60 us
    p99 completion latency   90.6 us       90.1 us       94.2 us
    p99.9 completion latency 94.7 us       94.7 us      103.9 us

  4 disks, 128 jobs, QD256
    status                    lockup (26s)  pass           pass
    IOPS                      N/A           4.986M         3.165M
    bandwidth                 N/A          19.0 GiB/s     12.1 GiB/s
    mean completion latency   N/A           6.544 ms      10.332 ms
    p99 completion latency    N/A          14.483 ms      22.151 ms
    p99.9 completion latency  N/A          22.544 ms      24.773 ms

IRQ-poll fallback prevents hardirq starvation while avoiding the 15-37%
IOPS loss and higher latency observed with threaded interrupts, by
activating only under scheduler pressure.

Naman Jain (3):
  nvme-pci: select IRQ_POLL
  nvme-pci: make completion queue polling softirq-safe
  nvme-pci: defer completions when rescheduling is needed

 drivers/nvme/host/Kconfig |   1 +
 drivers/nvme/host/pci.c   | 295 ++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 283 insertions(+), 13 deletions(-)

base-commit: eea3fef32a9cf36abcb5975a5a594e4135a6b026
-- 
2.43.0
