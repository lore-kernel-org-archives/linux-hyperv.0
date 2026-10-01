Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D712314D13;
	Thu,  1 Oct 2026 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892695; cv=none; b=XcITFL/dJhVofcjhRn6I/hzrjHe2Jn8AhuWao+8A0bPDPmZYOrMSVjChdOkJ2ileKIfoo61ixohOLkrf77W1mDP/XJ61lsDsrEv7QH8Y6n/7W1TqAxytTjmx1/7L9bPWbSO9qYZMC+1Ik3+dRnbfQXvEb/IB4vbxt9LIgZU+kl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892695; c=relaxed/simple;
	bh=e1oP7MRFB4YZbjBMVGbmWBTkqNZpe6TIT0NlgaeyALg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SZepg5HR4tdKvF0SndbjUkgUWzyuehado+gC9zc+00i/KfM1iFOxxjeplj5jixmFzpw0jLF5e0PHZFaAQMHJFsPHqayfBLJgk8H3gXelpe/YXpgLYRHVTvoXsVNAHyu3CJgIMQ13yYQ7UK6aJyeAeYxHvyUFbid4EBki+u+xpjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EmPgyIFt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EmPgyIFt"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id AF60B20B716D;
	Thu,  1 Oct 2026 15:10:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AF60B20B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892640;
	bh=aeaGeEY/azumkDJEvseevkc4d3hGxwZ4MIfAGLotwfA=;
	h=From:To:Cc:Subject:Date:From;
	b=EmPgyIFtc+qSI+koFX2sYfqXvXKEDMwtbZH0qprt9XVuezPnmJYBrVQRUs9FgsWsH
	 yFLsn7RpdllS2sC14mMVVgUpAZUE1r2fdGXEdxzz2WCqRddtdV9wgAB9ZShHRhlmqZ
	 b2CEaFIC/aBfoUEAa9F/4KaiKJe4HFY1An/fFCBM=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] Drivers: hv: vmbus: Harden the ring buffer against a malicious host
Date: Thu,  1 Oct 2026 15:10:36 -0700
Message-ID: <20261001221040.1794904-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a CoCo VM the host is untrusted. Since the VMBus ring buffer read and
write indices live in shared memory, the guest has to treat both as
potentially malicious and as changing at any time. This patch series
adds bounds checking and reuses the validated indices instead of
re-accessing them.

Patch 1 contains the minimum security fix, and is the only patch in the
series intended to be backported. hv_ringbuffer_write() copies into the
ring at the write index, so a malicious host can make the guest write to
memory outside the ring buffer. This is reachable on any channel a CoCo
VM accepts.

Patches 2 and 3 add READ/WRITE_ONCE annotations and refactor the helper
functions to allow the caller to work with a consistent snapshot of the
ring buffer indices.

Patch 4 adds the rest of the bounds checking. The memcopy() in
hv_pkt_iter_avail() can only result in an out-of-bounds read if
rbi->pkt_buffer_size exceeds the ring's data size. KVP is the only
in-tree channel whose max_pkt_size exceeds its ring's data size (16K vs
12K on a 4K page guest). CoCo VMs reject the KVP channel, so this bug is
currently unreachable on CoCo VMs. The other paths patch 4 checks can't
cause a bad access, only a nonsense byte count or a wrong signaling
decision.

Patch 1 applies cleanly to v5.15 and later. The unchecked write goes
back to the original driver, but the host is only untrusted in CoCo VMs,
which Linux has supported since v5.12, so patch 1's Fixes tag points at
the original driver while its stable tag starts at 5.15.x.

---
Kameron Carr (4):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices
      Drivers: hv: vmbus: Annotate accesses to the shared ring buffer indices
      Drivers: hv: vmbus: Compute ring byte counts from a caller-held snapshot
      Drivers: hv: vmbus: Keep the ring byte counts sane for a bad index

 drivers/hv/ring_buffer.c | 112 +++++++++++++++++++++--------------------------
 include/linux/hyperv.h   |  58 ++++++++++++++++++------
 2 files changed, 94 insertions(+), 76 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
