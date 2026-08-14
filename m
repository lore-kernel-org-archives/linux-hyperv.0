Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F6E53403E1;
	Fri, 14 Aug 2026 09:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699936; cv=none; b=TyO/NLsiJemvnfRKT5+1SaDOck7qfK3KY61KmmFnxvhb6O0IgqMSprlUAD8ZQwIfQQl5X/sg6j2tAh+ivp0To1RKT7ZCRQ4z2efCLvHWXx7kSxeULhqe8DiPOe9ICdwGKZsSXRMurKTUdwIbTzHOnMBlo/IYCJJduKPTUwdwW9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699936; c=relaxed/simple;
	bh=XVIa39kEBZy1m4tD2cbmh7QicRxGJ219J8UiVV9JRrc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VC2Cm/KNdlYyOY1Ty6BHSnGrxSocfjmEGUWlOgKrPepKKGxsvJfXRtSvRY4Vmz6SE6HaMqH49DBdOKXHx6L2gO0ipXsCR/nHrDveNb9DmL7qMNau8u2gk0U6D/iKtpSe7KjG5S7N0pXmzzTn+fz7aybVZ5zsm02A0dj+G/U4LWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=V52fu+Q7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="V52fu+Q7"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id AC4A620B7168; Fri, 14 Aug 2026 02:31:42 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AC4A620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786699902;
	bh=LGikjDL90B601+oxWQxAwcIjr4mTtMim1u9PxK6sLPk=;
	h=From:To:Cc:Subject:Date:From;
	b=V52fu+Q7YwHWX9W2/wZbpu6Cw7VpwyngkD+kMRAP7yZF3d2G77nY3ySEgO8vexhQn
	 FdaNUrJya/ip3BiPvpLwgCoanNrBRsqTAh8Fac8n48JqWoR9aVjtre3AiQMgsfajX0
	 ZSbYN/s1WJ3wuQGawPlLLPVZiux6QHIF8fRi5n1M=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Marc Zyngier <maz@kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: [RFC PATCH 0/2] arm64/hyperv: Enable kexec reboot support
Date: Fri, 14 Aug 2026 02:31:28 -0700
Message-ID: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Kexec reboot consistently fails on ARM64 Hyper-V guests (Azure VMs).
During the kexec shutdown path, VMBus channels are never cleaned up,
so in the fresh kexec kernel startup hv_acpi_init() blocks because
the hypervisor still holds the old kernel's VMBus session open.

This is because ARM64 lacks the VMBus teardown that x86 performs during
kexec via hv_machine_shutdown(). On x86, machine_ops.shutdown is
overridden to send CHANNELMSG_UNLOAD and disable SynIC before CPUs
go offline. ARM64 has no equivalent mechanism.

Why existing notification mechanisms don't work:

- Reboot notifiers: Fire too early - they run inside
  kernel_restart_prepare(), BEFORE device_shutdown(). VMBus UNLOAD
  must happen AFTER device_shutdown() so that PCI drivers can clean
  up interrupt mappings (PCI_DELETE_INTERRUPT_MESSAGE) before UNLOAD
  force-closes channels. Sending UNLOAD first causes interrupt
  mapping leaks because the mappings aren't released on channel
  close.

- Device .shutdown callbacks: Too narrow - these handle per-device
  cleanup (e.g., individual VMBus channel teardown), but cannot
  perform bus-level operations like sending the global VMBus UNLOAD
  message or removing the SynIC CPU hotplug state via
  cpuhp_remove_state().

- VMBus parent device .shutdown callback: Also insufficient -
  cpuhp_remove_state() for SynIC teardown must run after all device
  shutdown completes, not during it. A parent .shutdown callback
  still executes within device_shutdown().

- The required window is: after device_shutdown() completes, after
  cpu_hotplug_enable(), but before smp_shutdown_nonboot_cpus(). That
  window exists inside machine_shutdown(), which currently has no hook.

The need for an ARM64 shutdown hook was previously discussed in [1]
but lacked a concrete failure case at the time. We now have one.

[1] https://lore.kernel.org/linux-arm-kernel/427a8277-49f0-4317-d6c3-4a15d7070e55@igalia.com/

This RFC proposes fixing kexec on ARM64 Hyper-V guests with:

Patch 1: A platform hook (arm64_pre_smp_shutdown_hook) in ARM64's
  machine_shutdown(), analogous to x86's machine_ops.shutdown. This
  runs after device_shutdown() and cpu_hotplug_enable(), allowing
  platform code to inject pre-shutdown logic at the right point in
  the kexec path.

  Design choices I'd like feedback on:
  - Single function pointer vs full machine_ops struct: ARM64 uses
    kernel-wide APIs (register_restart_handler, register_platform_power_off)
    for restart/poweroff rather than x86's monolithic machine_ops, so
    a targeted hook seemed more consistent with the ARM64 pattern.
  - On ARM64, machine_shutdown() is only called from kernel_kexec(),
    unlike x86/powerpc where it's also called from restart/halt/poweroff.

Patch 2: Uses this hook to call hv_kexec_handler() which performs:
  - vmbus_initiate_unload(): sends CHANNELMSG_UNLOAD to host
  - cpuhp_remove_state(): disables SynIC (SIMP, SIEFP, SINT) on
    all CPUs, ensuring the kexec'd kernel starts with clean state

Tested on ARM64 Azure VMs (Ubuntu 22.04, multiple vCPU configs):
- kexec reboot succeeds, VM comes back online with SSH
- Normal reboot/poweroff unaffected
- Multiple consecutive kexec cycles pass

Looking for feedback on:
1. Is the single function pointer hook acceptable for ARM64, or would
   the ARM64 maintainers prefer a registration API or __weak function?
2. Should this be arm64-specific or generic kexec infrastructure?

Shradha Gupta (2):
  arm64: Add pre-shutdown hook to machine_shutdown()
  arm64/hyperv: Add kexec handler using machine_shutdown hook

 arch/arm64/hyperv/mshyperv.c         | 37 ++++++++++++++++++++++++++++
 arch/arm64/include/asm/system_misc.h |  2 ++
 arch/arm64/kernel/process.c          | 13 ++++++++++
 3 files changed, 52 insertions(+)

-- 
2.43.0

