Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 107A7393DEE;
	Fri,  9 Oct 2026 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541343; cv=none; b=WnJp7a3AcPwjg0FdPpzsQi5xMGslFe/D6ffUlbvRK/ulbLaKEX2DXyd8asR6EJb0O0yz8beoqQ1XTw5p99+VxusWiAXy8iWHzBHP8gLitBHK7jrWQom0xtDAwHHb74b8Z7jHj7cXDGuJ0kRB2pSbFL0wNGgOL7xWAaLB7Wm+jbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541343; c=relaxed/simple;
	bh=BN5IrnlIk4BYG3Sh3ZfXgcUB8a/TcrCNHRQZbf57O6g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rJVQuNzhh/R+wzU/hauqOuqM+SBfbtgf10mNW9MHPj6T8pUvL/5jwdf2kED0vK6IKvQcZwEFbAyFqcMLLmw6TkYUw8SNfE1ab+PuRR3G5FQnLR2djuYpMcZOFCTCIgZ59b7/06RQeYvfXfI7fcukRgtdPZwcgkcMBM5HmgCQQko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mh2OU+6A; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mh2OU+6A"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id D541220B7168; Fri,  9 Oct 2026 03:22:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D541220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791541340;
	bh=NOj5jSg6BZkty3fNnyt95RQ9QyKG5uzyWU+uBTR7sow=;
	h=From:To:Cc:Subject:Date:From;
	b=mh2OU+6AsjHk53hHfbsWGhQ/NAG5hBOsTXMZEzJKUwZe53ZSWkCRmlJE6NxtQAhYH
	 ldzg0ic6X6iqcAVg5h1v41oj1AqsStS4eE/qkSQ53Vn//M6rAWtNp4jx5O/pSXsOvO
	 gf/KxrtySEf5tIzXZbaAGOIDPtNVt0liKaBCT1hs=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: mhklinux@outlook.com,
	wei.liu@kernel.org,
	catalin.marinas@arm.com,
	baoquan.he@linux.dev
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	will@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	arnd@arndb.de,
	hpa@zytor.com,
	maz@kernel.org,
	mark.rutland@arm.com,
	linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	broonie@kernel.org,
	kees@kernel.org,
	brads@mainlining.org,
	namjain@linux.microsoft.com
Subject: [PATCH v4 0/2] hyperv: Run VMBus kexec cleanup from syscore shutdown
Date: Fri,  9 Oct 2026 03:22:11 -0700
Message-ID: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kexec reboot fails on ARM64 Hyper-V guests because the VMBus connection
and SynIC CPU hotplug state are not torn down before the secondary CPUs
are stopped. Move this cleanup into the VMBus syscore shutdown callback,
which runs after device shutdown and before architecture-specific machine
shutdown.

Patch 1 adds an exported helper for checking whether a normal kexec reboot
is in progress. Patch 2 runs the VMBus cleanup from the common syscore
shutdown path on x86 and ARM64, removes the old x86 handler interface, and
documents the shutdown ordering.

On x86, VMBus teardown now precedes hv_stimer_global_cleanup(). This relies
on commit be0cfab740e5 ("clocksource: hyper-v: Remove support for stimer
interrupts in message mode"). Older kernels that retain message-mode
stimer interrupts need an ARM64-specific backport to preserve the existing
x86 ordering.

Changes in v4:
  - Document the VMBus kexec cleanup path in the Hyper-V overview.
  - Combine adjacent kexec_in_progress checks in the x86 shutdown path.

Changes in v3:
  - Use the existing common VMBus syscore operations on all
    architectures, as suggested by Michael.
  - Remove the x86 handler pointer and the weak setup/remove interface.
  - Add an exported read-only helper for modular VMBus builds.
  - Correct the Fixes tag to the commit that enabled Hyper-V on ARM64.

Changes in v2:
  - Use syscore shutdown instead of an ARM64 machine_shutdown() hook, as
    suggested by Catalin.

Shradha Gupta (2):
  kexec: Add helper to report an active kexec reboot
  Drivers: hv: Run VMBus kexec cleanup from syscore shutdown

 Documentation/virt/hyperv/overview.rst | 12 +++++++-----
 arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
 drivers/hv/hv_common.c                 | 10 ----------
 drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
 include/asm-generic/mshyperv.h         |  2 --
 include/linux/kexec.h                  |  2 ++
 kernel/kexec_core.c                    |  7 +++++++
 7 files changed, 36 insertions(+), 46 deletions(-)

base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0
