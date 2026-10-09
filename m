Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226CA41A575;
	Fri,  9 Oct 2026 10:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541374; cv=none; b=hdfvcePYZTBveKsyMVWtmNH3EBz/meGD7IbVDdKRxjgI4SMjKToicdn1gW4B51as9slIZp3g5ZJ5CuUeZcN8lV1PXRtK+DvRBXBU+vwYg8zMdzkYL75uFmxGaPgOpXckX496WT4WU8q4pYDORQhpw8m5rEY47v9gj0KU/ROHcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541374; c=relaxed/simple;
	bh=wGvibCOV47qWg9HtiAJhBm3hcozdjO+GvxVOH5AJPAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNHqUgrj6Qa7MqS2NAXeiRgTLtjAYwylUQupYg7L0wuAAxU9LrjCnVYxdTqnMmilwQtqtGmyrDY4aftOCApgEsg//zYwiurK9fF6IB6AiP4gt8uo8ovJc0SDEifTPxx2PHzS1wCwNLM+ga+y/e3qYqPonTEtBYmbmk9t40XvM+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=hHVT1GJO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="hHVT1GJO"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 09D2220B7168; Fri,  9 Oct 2026 03:22:52 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 09D2220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791541372;
	bh=lokOhgtAJ6SrRh5Dg1NPLtdc6CHW4SZ5xXErkdqKdvw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hHVT1GJOLXa8MfNTxIpPTJiHQIJciCCOX26iLcRpPw48Mo957k5UFQDhF/1mowQDb
	 rNextEUqQBf1u9YtBJ9YYfKBWHKEWWfj/Ufdq/9HIMENiQF2bKUuRyxBthebGsG3TP
	 e57wZSx7hQsNKvETygl4aITgxRDrsiK0e49CFDwI=
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
Subject: [PATCH v4 2/2] Drivers: hv: Run VMBus kexec cleanup from syscore shutdown
Date: Fri,  9 Oct 2026 03:22:46 -0700
Message-ID: <20261009102250.3361076-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ARM64 Hyper-V guests do not run the VMBus kexec cleanup before
secondary CPUs are stopped. Consequently, the old VMBus connection
and SynIC state remain active when the kexec kernel starts.

Run the VMBus kexec handler from the existing VMBus syscore shutdown
callback. syscore_shutdown() runs after device shutdown and before
machine shutdown, while all CPUs needed by the SynIC CPU hotplug
teardown are still available. Guard the callback with
kexec_is_in_progress() so normal restart, halt, and poweroff paths are
unchanged.

Use the same path on x86 and remove the architecture-specific handler
pointer and the weak setup/remove interfaces. VMBus teardown now
precedes hv_stimer_global_cleanup() on x86.

The new x86 ordering relies on commit be0cfab740e5 ("clocksource:
hyper-v: Remove support for stimer interrupts in message mode"), which
removed the synthetic timer's dependency on VMBus message delivery.
Older kernels that retain message-mode stimer interrupts must preserve
the existing x86 ordering and therefore require an ARM64-specific
backport.

Document the VMBus cleanup path and its position in shutdown ordering.

Fixes: 9bbb888824e3 ("arm64: hyperv: Initialize hypervisor on boot")
Link: https://lore.kernel.org/all/20260814093133.3191250-1-shradhagupta@linux.microsoft.com/
Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
---
 Documentation/virt/hyperv/overview.rst | 12 +++++++-----
 arch/x86/kernel/cpu/mshyperv.c         | 27 ++++++---------------------
 drivers/hv/hv_common.c                 | 10 ----------
 drivers/hv/vmbus_drv.c                 | 22 ++++++++++++++--------
 include/asm-generic/mshyperv.h         |  2 --
 5 files changed, 27 insertions(+), 46 deletions(-)

diff --git a/Documentation/virt/hyperv/overview.rst b/Documentation/virt/hyperv/overview.rst
index 77408a89d1a4..34a53ba7a122 100644
--- a/Documentation/virt/hyperv/overview.rst
+++ b/Documentation/virt/hyperv/overview.rst
@@ -114,11 +114,13 @@ a shared page or remove an overlay page after the new kernel is
 using the page for a different purpose, corrupting the new kernel.
 Hyper-V does not provide a single "set everything" operation to
 guest VMs, so Linux code must individually revoke all sharing before
-doing kexec.   See hv_kexec_handler() and hv_crash_handler().  But
-the crash/panic path still has holes in cleanup because some shared
-pages are set using per-CPU synthetic registers and there's no
-mechanism to revoke the shared pages for CPUs other than the CPU
-running the panic path.
+doing kexec.  For a normal kexec reboot, the VMBus driver calls
+hv_kexec_handler() from its syscore shutdown callback, after device
+shutdown and before the architecture-specific machine shutdown.  The
+crash/panic path uses hv_crash_handler(), but still has holes in
+cleanup because some shared pages are set using per-CPU synthetic
+registers and there is no mechanism to revoke the shared pages for
+CPUs other than the CPU running the panic path.
 
 CPU Management
 --------------
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index b4af7c0a70ac..fec1c37dafbf 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -148,7 +148,6 @@ EXPORT_SYMBOL_GPL(hv_set_msr);
 static void (*mshv_handler)(void);
 static void (*vmbus_handler)(void);
 static void (*hv_stimer0_handler)(void);
-static void (*hv_kexec_handler)(void);
 static void (*hv_crash_handler)(struct pt_regs *regs);
 
 DEFINE_IDTENTRY_SYSVEC(sysvec_hyperv_callback)
@@ -215,16 +214,6 @@ void hv_remove_stimer0_handler(void)
 	hv_stimer0_handler = NULL;
 }
 
-void hv_setup_kexec_handler(void (*handler)(void))
-{
-	hv_kexec_handler = handler;
-}
-
-void hv_remove_kexec_handler(void)
-{
-	hv_kexec_handler = NULL;
-}
-
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
 {
 	hv_crash_handler = handler;
@@ -240,17 +229,13 @@ static void hv_machine_shutdown(void)
 {
 	if (kexec_in_progress) {
 		hv_stimer_global_cleanup();
-
-		if (hv_kexec_handler)
-			hv_kexec_handler();
-	}
-
-	/*
-	 * Call hv_cpu_die() on all the CPUs, otherwise later the hypervisor
-	 * corrupts the old VP Assist Pages and can crash the kexec kernel.
-	 */
-	if (kexec_in_progress)
+		/*
+		 * Call hv_cpu_die() on all the CPUs, otherwise later the
+		 * hypervisor corrupts the old VP Assist Pages and can crash
+		 * the kexec kernel.
+		 */
 		cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
+	}
 
 	/* The function calls stop_other_cpus(). */
 	native_machine_shutdown();
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 31256cb22b39..bb290a5eaf1d 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -681,16 +681,6 @@ void __weak hv_setup_mshv_handler(void (*handler)(void))
 }
 EXPORT_SYMBOL_GPL(hv_setup_mshv_handler);
 
-void __weak hv_setup_kexec_handler(void (*handler)(void))
-{
-}
-EXPORT_SYMBOL_GPL(hv_setup_kexec_handler);
-
-void __weak hv_remove_kexec_handler(void)
-{
-}
-EXPORT_SYMBOL_GPL(hv_remove_kexec_handler);
-
 void __weak hv_setup_crash_handler(void (*handler)(struct pt_regs *regs))
 {
 }
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5ebdbe24b5a1..3532ea779d34 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -33,6 +33,7 @@
 #include <linux/sysfb.h>
 #include <linux/efi.h>
 #include <linux/kernel.h>
+#include <linux/kexec.h>
 #include <linux/syscore_ops.h>
 #include <linux/dma-map-ops.h>
 #include <linux/pci.h>
@@ -2904,6 +2905,12 @@ static void hv_kexec_handler(void)
 	cpuhp_remove_state(hyperv_cpuhp_online);
 };
 
+static void hv_vmbus_syscore_shutdown(void *data)
+{
+	if (kexec_is_in_progress())
+		hv_kexec_handler();
+}
+
 static void hv_crash_handler(struct pt_regs *regs)
 {
 	int cpu;
@@ -2958,14 +2965,15 @@ static void hv_synic_resume(void *data)
 	 */
 }
 
-/* The callbacks run only on CPU0, with irqs_disabled. */
-static const struct syscore_ops hv_synic_syscore_ops = {
+/* The suspend and resume callbacks run only on CPU0, with irqs_disabled. */
+static const struct syscore_ops hv_vmbus_syscore_ops = {
 	.suspend = hv_synic_suspend,
 	.resume = hv_synic_resume,
+	.shutdown = hv_vmbus_syscore_shutdown,
 };
 
-static struct syscore hv_synic_syscore = {
-	.ops = &hv_synic_syscore_ops,
+static struct syscore hv_vmbus_syscore = {
+	.ops = &hv_vmbus_syscore_ops,
 };
 
 static int __init hv_acpi_init(void)
@@ -3014,10 +3022,9 @@ static int __init hv_acpi_init(void)
 	if (ret)
 		goto cleanup;
 
-	hv_setup_kexec_handler(hv_kexec_handler);
 	hv_setup_crash_handler(hv_crash_handler);
 
-	register_syscore(&hv_synic_syscore);
+	register_syscore(&hv_vmbus_syscore);
 
 	return 0;
 
@@ -3039,9 +3046,8 @@ static void __exit vmbus_exit(void)
 		 */
 		return;
 
-	unregister_syscore(&hv_synic_syscore);
+	unregister_syscore(&hv_vmbus_syscore);
 
-	hv_remove_kexec_handler();
 	hv_remove_crash_handler();
 	vmbus_connection.conn_state = DISCONNECTED;
 	hv_stimer_global_cleanup();
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..98fe5c0f54ea 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -183,8 +183,6 @@ void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
 void hv_remove_stimer0_handler(void);
 
-void hv_setup_kexec_handler(void (*handler)(void));
-void hv_remove_kexec_handler(void);
 void hv_setup_crash_handler(void (*handler)(struct pt_regs *regs));
 void hv_remove_crash_handler(void);
 void hv_setup_mshv_handler(void (*handler)(void));
-- 
2.43.0
