Received: from mail.ilvokhin.com (mail.ilvokhin.com [178.62.254.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BCA9426416;
	Tue,  4 Aug 2026 07:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.62.254.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785827778; cv=none; b=oXc2DYC27LKn8wRCjDEqp8gORq7l6yV2Ip0RjfXPVo/x/jDep6/phxGuVYBALao3FIw08a3xD8ocK/yZQnshB9X0slDwV9lzZ/BPn/NElsaVHsJ5wBIfmxvLMFJiQYVfpXdUVBj+6ygvAFsoAJJo8LPSYYowBR2x89fT0tzB4Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785827778; c=relaxed/simple;
	bh=nhdXXrarZjM7sUZmIrtvSXcFaOGMaM4FbU85rOdUqv8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GHAcbh+OHbLlbwBlsE0e3ipeNSDRJ3EAxyWvNbcfG2iuEh+ogMDtiS9s8eQn3t/AdiolTmo1yRqmSl6yiUutoyW2WDfzF+UDe+LP4y1DzcfZJEiWh6GMUzH8g8YjxKS04wURScZWCspRdCtaFUh2AyKwx1bauDw5FLcW9KdFPq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com; spf=pass smtp.mailfrom=ilvokhin.com; dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b=zuuQlk9H; arc=none smtp.client-ip=178.62.254.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ilvokhin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ilvokhin.com header.i=@ilvokhin.com header.b="zuuQlk9H"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ilvokhin.com;
	s=mail; t=1785827768;
	bh=C36dNKMErd6fEDuyOzYmXnXLzsDFA2rEQeKm0PrIEwU=;
	h=From:To:Cc:Subject:Date;
	b=zuuQlk9HFx1s4aMIaXtgkNF/m3YJ86B2QbZ83bIHeVzXGJfBm3WQ9v5qi06ycUsSA
	 y8MsnTc4o0Lw3f7cazZ6t3ZC6FpEzOcBi4/n2bvgLJMepXG/4Pg6/7hQIy/DJBPKo1
	 3AcjhlumYX+Odef7Y8fxkp0G8LLBWqmj0Tg/agbQ=
Received: from localhost.localdomain (shell.ilvokhin.com [138.68.190.75])
	(Authenticated sender: d@ilvokhin.com)
	by mail.ilvokhin.com (Postfix) with ESMTPSA id 48833E16CF;
	Tue, 04 Aug 2026 07:16:08 +0000 (UTC)
From: Dmitry Ilvokhin <d@ilvokhin.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Juergen Gross <jgross@suse.com>,
	Ajay Kaher <ajay.kaher@broadcom.com>,
	Alexey Makhalov <alexey.makhalov@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Alice Ryhl <aliceryhl@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-arch@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	kernel-team@meta.com,
	Dmitry Ilvokhin <d@ilvokhin.com>
Subject: [PATCH 0/5] locking/qspinlock: Add contended_release tracepoint
Date: Tue,  4 Aug 2026 07:15:40 +0000
Message-ID: <cover.1785778551.git.d@ilvokhin.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The contended_release tracepoint landed in v7.2-rc2 for sleeping locks
(4f070ccb4dc4 "locking: Add contended_release tracepoint to sleepable
locks"). Spinlock support was dropped from that series. This one adds it
for queued spinlocks.

The existing contention_begin/contention_end tracepoints fire on the
waiter side. The holder's identity and stack can be captured at
contention_begin time (e.g. perf lock contention --lock-owner), but only
for locks with an owner field to read: mutex and rwsem. qspinlock has
none, so a contended spinlock cannot be attributed to its holder at all.
Even where the owner can be read, it reflects the holder's state when a
waiter arrives, not when the lock is released.

This series adds a contended_release tracepoint to qspinlock that fires
on the holder side when a lock with waiters is released. This provides:

- Hold time estimation: when the holder's own acquisition was
  contended, its contention_end (acquisition) and contended_release
  can be correlated to measure how long the lock was held under
  contention.

- The holder's stack at release time, which for spinlocks is not
  available by any other means.

The unlock path might be quite hot, so the tracepoint is made as cheap
as possible, to keep it usable in production:

- x86 with PARAVIRT_SPINLOCKS=y, which is what distributions ship, swaps
  the unlock implementation via static_call() when the tracepoint is
  enabled. The disabled path is byte-identical to today's: the same
  inline movb, no NOP and no call.

- Everywhere else a static-branch check is compiled into
  queued_spin_unlock(). On x86_64 that is a single NOP on the executed
  path, with the call to the traced helper emitted out of line and
  unreachable while the tracepoint is off. On other architectures a few
  more instructions to manage a stack frame land on the executed path
  too, so the generic path sits behind
  CONFIG_QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE (default n).

Costs and measurements are in the individual changelogs. Briefly, no
throughput or latency change is measurable on either x86_64 or arm64
with QUEUED_SPINLOCKS_TRACE_CONTENDED_RELEASE=y.

Tested: x86_64 with PARAVIRT_SPINLOCKS=y and =n, arm64, tracepoint on
and off, disassembly checked in both states, locktorture with tracepoint
on and off.

Not covered: qrwlock, and architectures with fully custom qspinlock
implementations (e.g. PowerPC). The stack frame managing instructions on
arm64 should be avoidable, but that is not done in this patchset.

Patch 1 is Peter's draft from [1] and is missing his Signed-off-by.
Peter, please add it if you are happy with the patch.

[1]: https://lore.kernel.org/all/20260603120811.GW3493090@noisy.programming.kicks-ass.net/

Dmitry Ilvokhin (4):
  locking: Factor out queued_spin_release()
  locking/qspinlock: Add contended_release tracepoint
  tracing/lock: Use TRACE_EVENT_FN() for contended_release
  x86/paravirt: Trace contended_release on unlock

Peter Zijlstra (1):
  x86/paravirt: Use static_call() for the paravirt spinlock ops

 arch/mips/include/asm/spinlock.h         |  6 +--
 arch/x86/hyperv/hv_spinlock.c            |  4 +-
 arch/x86/include/asm/cpufeatures.h       |  1 -
 arch/x86/include/asm/paravirt-spinlock.h | 21 +++++---
 arch/x86/kernel/kvm.c                    |  5 +-
 arch/x86/kernel/paravirt-spinlocks.c     | 63 +++++++++++++++++++++---
 arch/x86/kernel/static_call.c            | 27 ++++++++++
 arch/x86/xen/spinlock.c                  |  5 +-
 include/asm-generic/qspinlock.h          | 38 ++++++++++++--
 include/trace/events/lock.h              | 10 +++-
 kernel/Kconfig.locks                     | 20 ++++++++
 kernel/locking/mutex.c                   |  4 ++
 kernel/locking/qspinlock.c               | 22 +++++++++
 tools/arch/x86/include/asm/cpufeatures.h |  1 -
 14 files changed, 195 insertions(+), 32 deletions(-)


base-commit: 5e601ab3615c86be7c4068ce992f94654693a032
-- 
2.53.0-Meta

