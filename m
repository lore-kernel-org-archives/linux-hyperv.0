Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792451400;
	b=jBY80UIPUCepIVLAXaqUkBF7vFZ54kGzsovOwzggfs/YQEwDOz5Pr1KngXvrVNLJVFV5
	 xg8zbLPzPXERbab8FRIO594F1B6uqJEX0e3yUrh7253Ukz9Q9cfcXigK7UEKQFeOfGos0
	 uauE9/gCazOBOjAyE5OaLqqtR/YajwFv+S8ockVJ2ZtkgWHzZeg0n4wx9h7vgORohO1lW
	 urmhGz8H3FaNm6Mi6YAY0USTRU0mSyyZUOUFi6KFLBP8wE0iKRzEpigrNzTzdTL7ljQ8J
	 jEZdmgOSsJ/rIT4ukjneqJa/s2tAFKviMIPoFgBvD4eyDXbqeDwRpIe83fHlcxLWAdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451400;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=qx8KJNJOi8moaasfyJXmWeZN1M18pHBM2JPzODhuEt0=;
	b=mb3wDG5zBz/JYLUXt+dEtmWQcBlUFZFzfgtEJszI+El15lUZitWqxk8TB/BiXjsjgVTd
	 YRbQv5mw5AB8Ty5QTLaFa8F1mB/y5iCehXc/8QPts7sfZ1tpX95cE1vFfN3sUcHISN+Mf
	 1+TDJji3pfoM12km9XVtWjO+83AS3whILLZZrmug2KzjEQy+UsF0Ly2k8XhgjgyqeSlcu
	 aM/ezssovSNw8ITJtbzjk9m/SAn7/exMCuB6dN23ieRgAnj6nUZcBfsFN/0Bgz0Mm0z+A
	 A6KH36wJO/BTc7mgSqH56DpPjHXwPHunRCdtBSCac0msCglSZ4srJg1fKYlSTULfAdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=h6S8t5y7;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6E606A31A;
	Mon, 19 Oct 2026 23:10:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 11F6E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=h6S8t5y7
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id C499D20B7168;
	Mon, 19 Oct 2026 16:09:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C499D20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792451392;
	bh=qx8KJNJOi8moaasfyJXmWeZN1M18pHBM2JPzODhuEt0=;
	h=From:To:Cc:Subject:Date:From;
	b=h6S8t5y7p147aJh7ncsouE6mRcsUh2DuFxHxQHIxvMC7cWTAVOLJBs1yWD3G1FhsR
	 ZV9r2vx2l7EDe2PwKCohEek20HCzcgO493tKbgRC66BE8B2/4/U+9fv4CtqFmUpfl+
	 0eBXxCyn+lYfBZa6Bc9h+22rO2FG9WvAxeeXSC1w=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] Drivers: hv: vmbus: Harden the ring buffer against a malicious host
Date: Mon, 19 Oct 2026 16:09:45 -0700
Message-ID: <20261019230950.1573677-1-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
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
v2:
  - hv_ringbuffer_index_valid() -> hv_ringbuffer_indices_invalid()
    combines read and write checks and reverses the polarity
  - hv_pkt_iter_avail() reuses hv_ringbuffer_avail_read() arithmetic
  - Document the need to validate ringbuffer indices

v1: https://lore.kernel.org/all/20261001221040.1794904-1-kameroncarr@linux.microsoft.com/

Kameron Carr (5):
      Drivers: hv: vmbus: Bounds check the shared ring buffer indices
      Drivers: hv: vmbus: Use *_ONCE() to access shared ring buffer indices
      Drivers: hv: vmbus: Compute ring byte counts from a caller-held snapshot
      Drivers: hv: vmbus: Keep the ring byte counts sane for a bad index
      Documentation: hyperv: Describe validation of the ring buffer indices

 Documentation/virt/hyperv/coco.rst |   5 +-
 drivers/hv/ring_buffer.c           | 118 ++++++++++++++++---------------------
 include/linux/hyperv.h             |  58 ++++++++++++++----
 3 files changed, 100 insertions(+), 81 deletions(-)
---
base-commit: 72d3fcf802c45d00b300f25b848a93c3a2bd7c7e
