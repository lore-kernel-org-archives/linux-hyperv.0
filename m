Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F349D33A00C;
	Fri, 14 Aug 2026 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699942; cv=none; b=H70mIAjRWQ2Dd1bvDSiXLbmTaQFXiAtxXTBIQ3kBhFdgieu2/voa8uAGsdzDUf4C8qhRfcyA6crhwM54uB3MSJx9MChAd2fpZz8vPAEw2qN2YhpSNIB4AO7Ck5G0xRZaoii9pqf4bOlQMAbVmxLgOnP4EBzJuFyz/dj5Fz3/fMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699942; c=relaxed/simple;
	bh=YEASF6dVgdzFuCG8XUbb2m5W8uja1vKdesKMNwL8EeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PLNt0I0dzXSwUWBMqWj94NBkGysvZOp2U3Z5TS+yiB2tlBcVDk2kM1JS/oTtvKUDFQRJkPoOrn7L05+Vri8jWZPRCom5666e5+basjM047aJtfjsfy7b8K6lrod40Shc3By2wZ7EOjdZyYdEw0c+4Qvhsm0vKVAh6kCTO3E5iDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Jkd6+r2k; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Jkd6+r2k"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 57D5B20B7168; Fri, 14 Aug 2026 02:31:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 57D5B20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786699915;
	bh=No/zDZeaE888y2RYsuLS6yyL8hMk8BBFN1bhFZYlYUI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jkd6+r2klqHCSVds0fZKKCNznzXD03Z4C3nryTpGmTGn7Nm6R3PyGKEF00J/rEvs5
	 Elig570zbLCGrSgpgVUV4TZgaJ25EAqJ4zBKbm1r4z9WTBp76ea/IP+afj8zXvf3tD
	 zOWistMRgmTAITANSHJYYcBXwD9CdEPhFoXdS8o4=
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
Subject: [RFC PATCH 1/2] arm64: Add pre-shutdown hook to machine_shutdown()
Date: Fri, 14 Aug 2026 02:31:50 -0700
Message-ID: <20260814093154.3191311-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
References: <20260814093133.3191250-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a function pointer hook (arm64_pre_smp_shutdown_hook) that is invoked
from machine_shutdown() before smp_shutdown_nonboot_cpus(). This allows
platform code (e.g., hypervisors) to perform cleanup that must happen
after device_shutdown() but before secondary CPUs go offline.

In the kexec path, the call sequence is:
  kernel_kexec()
    kernel_restart_prepare()
      device_shutdown()         // drivers shut down here
    migrate_to_reboot_cpu()
    cpu_hotplug_enable()
    machine_shutdown()
      arm64_pre_smp_shutdown_hook()  // new: platform cleanup
      smp_shutdown_nonboot_cpus()    // CPUs go offline

x86 achieves this via machine_ops.shutdown; ARM64 currently has no
equivalent mechanism. Rather than introducing the full machine_ops
structure, add a targeted hook for the shutdown path.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 arch/arm64/include/asm/system_misc.h |  2 ++
 arch/arm64/kernel/process.c          | 13 +++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/include/asm/system_misc.h b/arch/arm64/include/asm/system_misc.h
index d316a804eb38..7c37b9f33e96 100644
--- a/arch/arm64/include/asm/system_misc.h
+++ b/arch/arm64/include/asm/system_misc.h
@@ -28,6 +28,8 @@ void arm64_notify_die(const char *str, struct pt_regs *regs,
 struct mm_struct;
 extern void __show_regs(struct pt_regs *);
 
+extern void (*arm64_pre_smp_shutdown_hook)(void);
+
 #endif	/* __ASSEMBLER__ */
 
 #endif	/* __ASM_SYSTEM_MISC_H */
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 581f80e9b9b7..41c0e9840913 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -88,8 +88,21 @@ void __noreturn arch_cpu_idle_dead(void)
  * avoid any code or data used by any SW CPU pin loop. The CPU hotplug
  * functionality embodied in smpt_shutdown_nonboot_cpus() to achieve this.
  */
+
+/*
+ * Hook for platform code to perform cleanup after device_shutdown()
+ * but before secondary CPUs are offlined. This runs in the kexec path
+ * from kernel_kexec() after device_shutdown() and cpu_hotplug_enable()
+ * have been called, matching the point at which x86 invokes
+ * machine_ops.shutdown.
+ */
+void (*arm64_pre_smp_shutdown_hook)(void);
+
 void machine_shutdown(void)
 {
+	if (arm64_pre_smp_shutdown_hook)
+		arm64_pre_smp_shutdown_hook();
+
 	smp_shutdown_nonboot_cpus(reboot_cpu);
 }
 
-- 
2.43.0

