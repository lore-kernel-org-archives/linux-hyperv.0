Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4349B34E74B;
	Fri, 14 Aug 2026 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786699956; cv=none; b=sPonTChDfKhzQQEax9ZXSYIjLowE3R4U6PhFTFdeL2ZSzZ8FVf2WMeqS3yQ7pAeCcPLf1XaYdT+vhMWD6KyCKz2ks2PJGLmIKZ684m5kwSFIzoQ1hM0zZFk/wpmxfojkWDb0w4n+vQYKCpG7JB4JkWdCa10CJSdY4tFBDZ3c5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786699956; c=relaxed/simple;
	bh=dqQTdheRuybyKRZaKBL1/fbQA0uKD5E06HOwSa6wSPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCyYJvt3gqszpGbU7cKBpGFcXJF8ObUdP4p0EExa9ZgH5hVZkQN8UkTLFK+4+QEu0mApXK9OuJRLnKmjIh9YYvoAAkn470uXpMZKNv/0G547ews92uZtzqCWOPlO7XgdCKqRqbWri8kwHVobcKDEs3CoF+/Re8Jwp0thhU/uVXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OqdV6scu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OqdV6scu"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 9645220B7168; Fri, 14 Aug 2026 02:32:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9645220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786699929;
	bh=80IQwiIl4V2/MToMGOoJ8SmIIRKchxWe3CjM7ZCCf3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OqdV6scuCBvLC5c5cAaRDU0HUkewp2NIQQoO1cvw+vidvjyZvO6LOcmdwbrIU0Unf
	 CanjPAeanUjR+wtYTm6EWtpjRyq9yMmb2/6uFoWR2/0ETsoVGazrV6zxHJpI5NNZMD
	 qIkvYhmSJXo/zMKD/I50/zfWdbIcRcl8h+ru4VWA=
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
Subject: [RFC PATCH 2/2] arm64/hyperv: Add kexec handler using machine_shutdown hook
Date: Fri, 14 Aug 2026 02:32:03 -0700
Message-ID: <20260814093208.3191430-1-shradhagupta@linux.microsoft.com>
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

ARM64 Hyper-V guests currently lack the VMBus teardown that x86 performs
during kexec via hv_machine_shutdown(). Without this, kexec fails because:

1. The kexec'd kernel's vmbus_connect() hangs because the hypervisor
   still has the old VMBus connection active.
2. Stale SynIC state (message pending flags, event flags) causes
   message delivery failures or NULL pointer dereferences in the
   kexec'd kernel.

The VMBus driver already provides a kexec cleanup callback via the
existing hv_setup_kexec_handler() / hv_remove_kexec_handler() API
(drivers/hv/vmbus_drv.c). These call into arch-specific overrides;
on x86, the override is in mshyperv.c, while ARM64 currently uses
the __weak no-op stubs from hv_common.c.

This patch provides the ARM64 override of hv_setup_kexec_handler()
and hv_remove_kexec_handler(), wiring the registered hv_kexec_handler
to the new arm64_pre_smp_shutdown_hook so that it is invoked during
machine_shutdown(). This matches x86's ordering: the handler runs
AFTER device_shutdown() (so PCI drivers can clean up interrupt
mappings via PCI_DELETE_INTERRUPT_MESSAGE before VMBus UNLOAD
force-closes channels) and AFTER cpu_hotplug_enable() (so
cpuhp_remove_state() can disable SynIC on all CPUs).

hv_kexec_handler() (registered by vmbus_drv.c via
hv_setup_kexec_handler()) performs:
  - vmbus_initiate_unload(false): sends CHANNELMSG_UNLOAD to host
  - cpuhp_remove_state(): disables SynIC (SIMP, SIEFP, SINT) on all
    CPUs, ensuring the kexec'd kernel starts with clean SynIC state

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26ade1d7..4176175060d3 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -15,10 +15,47 @@
 #include <linux/errno.h>
 #include <linux/version.h>
 #include <linux/cpuhotplug.h>
+#include <linux/kexec.h>
 #include <asm/mshyperv.h>
+#include <asm/system_misc.h>
 
 static bool hyperv_initialized;
 
+/*
+ * Kexec/shutdown handler for ARM64 Hyper-V guests.
+ *
+ * On x86, hv_machine_shutdown() overrides machine_ops.shutdown and
+ * runs after device_shutdown() and cpu_hotplug_enable(). ARM64 uses
+ * the arm64_pre_smp_shutdown_hook to achieve the same ordering.
+ *
+ * hv_kexec_handler() (set by vmbus_drv.c) performs:
+ *   1. vmbus_initiate_unload(false) - sends CHANNELMSG_UNLOAD
+ *   2. cpuhp_remove_state(hyperv_cpuhp_online) - disables SynIC per CPU
+ *
+ * By running after device_shutdown(), PCI drivers (NVMe, MANA) can
+ * send PCI_DELETE_INTERRUPT_MESSAGE and clean up MMIO/interrupt
+ * mappings before VMBus channels are force-closed by UNLOAD.
+ */
+static void (*hv_kexec_handler)(void);
+
+static void hv_machine_shutdown(void)
+{
+	if (kexec_in_progress && hv_kexec_handler)
+		hv_kexec_handler();
+}
+
+void hv_setup_kexec_handler(void (*handler)(void))
+{
+	hv_kexec_handler = handler;
+	arm64_pre_smp_shutdown_hook = hv_machine_shutdown;
+}
+
+void hv_remove_kexec_handler(void)
+{
+	arm64_pre_smp_shutdown_hook = NULL;
+	hv_kexec_handler = NULL;
+}
+
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 {
 	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
-- 
2.43.0

