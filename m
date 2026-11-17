Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794906918;
	b=2SDn8A33eUb2HWA4peiD3c+ElwaBcaViB6V4Ob74NnmgKCYV8AbuEXloBq5vx1JwD3hP
	 xSMwrr/09DcBcJjGZd5Q+8r6dI9lHHQWdKExbWaTP4XFMAxKxRYx9PKBLAnJsn4yzAjYT
	 Y1e04awIbSaJnLDSW5QyZBa8G3UqEcBu0mQ73OlIC/jBj0xL5HDtg/S+skDNQ33ry8sbz
	 aIsIoCdR+vUYiYCnbr6xK0h9RM20sBf9jleQqx3O2ZCO17f/FjUYKuexqxs02kNLoIkl6
	 0S+Y4g3JPbKO63pcvj9IAK5vRpGxJNQKSCl35uxP2ggZKi/D3dOy/Q2N6suJLvHHxEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794906918;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=mE/sVYfiR3G/zoT5bsis6mE+ps6fsx8Mq8v4rEbQFew=;
	b=nn3LcTveRmT/dtvylbCqphMMQltn2iPut6HSFItVI16loYjSuaPRiOefUy/FDc8KXQ6g
	 FnEqOV4+hk96UyxaLd9za87O/tbnd1dO9V21lowEdrPhgQJ1zpzyuEEkClzn0PW8m5vWt
	 SEHCgkXWNa+ExiKAxf2hG0mqu/kvGNsnBM7xqwsUy1bJhkj/FX28YjQ1nrh9IdZ57iiqq
	 8hU8H95UuWsilreu9qRnf9ew7NUpL3G2FdEusgKpNHgjU3POdzle3cHrPwKDYfdKmy/Lt
	 Yv9VF6K/yOcQoGFM3vPzNT5eSgg2eJo4H2vczEWhQZQRjtnB9Q4hBH06ITl2oxeXclg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=KYHjSD4u;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 649ED606A31C;
	Tue, 17 Nov 2026 09:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 649ED606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=KYHjSD4u
Received: from CPC-namja-026ON.localdomain (unknown [4.213.232.18])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6DC820B7169;
	Tue, 17 Nov 2026 01:15:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6DC820B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794906917;
	bh=mE/sVYfiR3G/zoT5bsis6mE+ps6fsx8Mq8v4rEbQFew=;
	h=From:To:Cc:Subject:Date:From;
	b=KYHjSD4u2rUB/1c1nRKVrsS6r6WafgOVmPct5fEsgAa+YBegIV1rYNxaTuKGh90WH
	 thf1xkAT5SB7oDyIt4T3apiul3NeDLW4G2F0Xg1Y1hvXjTJ72dxHl2OCHI3eRoYorv
	 GdxXGUu+87kadhgcpMSYvN6Bzz3ipH8KXiCSrmZY=
From: Naman Jain <namjain@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	luto@kernel.org,
	peterz@infradead.org
Cc: hpa@zytor.com,
	riel@surriel.com,
	mhklinux@outlook.com,
	bigeasy@linutronix.de,
	zhouchuyi@bytedance.com,
	houwenlong.hwl@antgroup.com,
	qq570070308@gmail.com,
	bastien.curutchet@bootlin.com,
	namjain@linux.microsoft.com,
	dianders@chromium.org,
	jgross@suse.com,
	hawk@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] x86/hyperv: Account for lazy mm_cpumask maintenance
Date: Tue, 17 Nov 2026 09:15:02 +0000
Message-ID: <20261117091507.2088642-1-namjain@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
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

Lazy mm_cpumask maintenance leaves CPU bits set after switching to another
address space, with stale memberships removed by native flush callbacks.
Successful Hyper-V TLB flush hypercalls do not run those callbacks, so
historical memberships can persist and cause unnecessary remote flushes.
If the mask covers all present CPUs, the backend selects an all-processor
flush before reaching its per-CPU lazy-TLB checks.

This was found while investigating a regression between Linux 6.8 and 7.0
in SuperBench's eight-GPU PyTorch LSTM training on Azure MI300X VMs.
Recreating DataLoader workers each epoch caused host-to-GPU copy stalls
and timeouts. The reported bisection identified commit 209954cbc7d0
("x86/mm/tlb: Update mm_cpumask lazily"). This is distinct from lazy TLB
mode: a CPU actively running another address space need not be lazy.

Patches 1-3 prepare for target filtering in patch 4 while patch 5 adds
immediate cleanup.

Patch 1 rejects VP-set conversion failures that return zero, allowing
native fallback rather than issuing an empty-target extended hypercall.

Patch 2 makes the native target predicate reusable, retaining its
context-switch ordering and adding a clearly named callback wrapper.

Patch 3 uses native callbacks for requested mask trimming and global ASID
transitions. The latter need guest callbacks to switch CPUs still using
local ASIDs; a Hyper-V invalidation does not do that.

Patch 4 filters targets before selecting either hypercall format or the
all-processors shortcut. Page-table-freeing flushes remain unfiltered.

Patch 5 separately requests best-effort cleanup when no remote target
remains after filtering. Lazy memberships may survive this cleanup.
The cleanup policy remains open for discussion.

The suggested mask-weight > mm_users heuristic was tested as a replacement
for patch 5's approach on a 32-vCPU Hyper-V VM. With three remote readers,
mm_users was 4 while lazy memberships kept mask weights at 26-32. The
heuristic requested trimming for all 10,000 flushes, and each reader
received 10,000 remote callbacks. The scoped approach used Hyper-V
hypercalls instead. A doubled threshold or rate-limited policy has not
been tested.

Earlier testing of the monolithic patch reduced the 32-vCPU all-history
reproducer from 17.235 us to 1.622 us per iteration (two mprotect() calls
and a write). The reporter's application hit the 600-second timeout on the
unpatched 96-vCPU VM and completed in 424 and 436 seconds with the patch.

Changes since v1:
https://lore.kernel.org/all/20261029064234.362385-1-namjain@linux.microsoft.com/
* Split the change into five patches with separate explanations (Dave).
* Add the workload and regression context (Michael).
* Explain the ASID fallback separately from the reported regression (Dave).
* Keep related predicate/wrapper names and comment the definition rather
  than the header declaration (Dave).
* Explain target filtering, page-table freeing, and the no-remote-target
  cleanup condition. Document the const copy and lazy-membership limit
  (Dave).
* Test the mm_users heuristic and retain scoped cleanup as a separate
  policy discussion (Dave).
* Omit Fixes tags and stable requests (Dave).
* Rebase onto next-20261116.

Naman Jain (5):
  x86/hyperv: Reject unrepresentable TLB flush VP sets
  x86/tlb: Make the conditional flush predicate reusable
  x86/hyperv: Use native callbacks for trimming and ASID transitions
  x86/hyperv: Filter TLB targets before building hypercalls
  x86/hyperv: Request mask cleanup when no remote target remains

 arch/x86/hyperv/mmu.c           | 71 +++++++++++++++++++++++----------
 arch/x86/include/asm/tlbflush.h |  1 +
 arch/x86/mm/tlb.c               | 18 +++++++--
 3 files changed, 65 insertions(+), 25 deletions(-)


base-commit: 749a4de370409464cf8501ec5b2451df45c84eb4
-- 
2.43.0
