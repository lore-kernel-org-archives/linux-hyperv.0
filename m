Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBAE448B9B;
	Thu,  1 Oct 2026 13:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790860952; cv=none; b=Snh+v32cxHrE2P6AwJk7/nnVAYGwnSsXEnyulqbS/Yb2k2Kh5zKY0wsdyQsNPb2hEY79jR/VRaDl374u48eKQuqi5+iniG0jflmSv/b5oo/NL2pqvomPbD3/yZ2aGZWZ30b0sBmbExOI6pnTRqoYSJBdyskNmu+NunH72u4nrU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790860952; c=relaxed/simple;
	bh=KaScK6HZ++/LOz2Gmmuj6RJvMoW430IBJLE7+9YkYGc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MIjMrgmcuBY6z4MtOsm0m5QjK2JHQwb0ZCP4AoA2h0CI2Mj5h4zDVH7E7TQGc/bsvijJ2HjIkZ6bAUWi4TpNaPmUNi9btivOX4ppCQBkRHISq50cuC64y98YWBPH/LsVwzYrJ02UFBZJ9Xej33NKWVbPLNEQtwmGKTYanKOd5DI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jBPcGxp4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jBPcGxp4"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 2A36720B7167; Thu,  1 Oct 2026 06:21:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2A36720B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790860898;
	bh=EjlOJ/OcDiSNWbB30Bul6Eomt2gGaGyv7txR7jxF0iQ=;
	h=From:To:Cc:Subject:Date:From;
	b=jBPcGxp4n4AL4jR6mv2YVvUBaMT7eoAQ0cdBGb+WIR1kTvSM1AjhvPMauIMe5sdfJ
	 Lm8uF823+SCZWFRggYrIXfBNUUbR2XS6f6sGK/1G+/P3O/Rtr5WZp9Yd6fFYI2t/Rc
	 mJOThD2cSzQLTihor/xm3aUC3QH7UyXxKZzNZdmE=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>,
	Wei Liu <wei.liu@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Baoquan He <baoquan.he@linux.dev>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Will Deacon <will@kernel.org>,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v3 0/2] hyperv: Run VMBus kexec cleanup from syscore shutdown
Date: Thu,  1 Oct 2026 06:21:25 -0700
Message-ID: <20261001132128.1703511-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kexec reboot fails on ARM64 Hyper-V guests because the VMBus
connection and SynIC CPU hotplug state are not torn down before the
secondary CPUs are stopped. The kexec kernel consequently starts with
the previous kernel's VMBus state still active.

The previous version added an ARM64-specific syscore shutdown
implementation. This version follows Michael Kelley's review and moves
the cleanup into the existing architecture-independent VMBus syscore
operations. This removes the separate x86 handler dispatch and gives
x86 and ARM64 the same ordering:

  device_shutdown()
  syscore_shutdown()
    VMBus UNLOAD and SynIC CPU hotplug teardown
  machine_shutdown()

On x86, VMBus teardown now runs before hv_stimer_global_cleanup().
This ordering is safe after commit be0cfab740e5 ("clocksource: hyper-v:
Remove support for stimer interrupts in message mode") removed the
VMBus dependency from synthetic timer handling.

Patch 1 adds a read-only helper that reports whether a kexec reboot is
in progress. The helper is exported because HYPERV_VMBUS is tristate
and the common syscore callback must also link when VMBus is a module.
Patch 2 moves the cleanup into the common callback and removes the
obsolete architecture-specific setup/remove interface.

For stable kernels that still support message-mode stimers, an
ARM64-specific backport will be needed to preserve the existing x86
ordering.

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

 arch/x86/kernel/cpu/mshyperv.c | 17 +----------------
 drivers/hv/hv_common.c         | 10 ----------
 drivers/hv/vmbus_drv.c         | 22 ++++++++++++++--------
 include/asm-generic/mshyperv.h |  2 --
 include/linux/kexec.h          |  2 ++
 kernel/kexec_core.c            |  7 +++++++
 6 files changed, 24 insertions(+), 36 deletions(-)


base-commit: be0cfab740e58b70047ef6e7e3d578f00ed5d258
-- 
2.43.0
