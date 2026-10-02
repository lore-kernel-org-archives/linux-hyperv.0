Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8179346C4DF;
	Fri,  2 Oct 2026 21:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978337; cv=none; b=geawhPgRtWl+Xc74EicrfAQ0w8ef9V6A+K+BvaaGY9J3lp0uao8xKIa6cYgm9yAUS+RifAu8eSWyHd55xOjrFflzu4c3gQ8MCbKgCi0QeTsCmXu6vB95d/QCEqqFhkvXKE5AXpfcy7DHB2zMTURSku0lN5sf65YpL7zMemLI7FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978337; c=relaxed/simple;
	bh=tza3pDjQaY+rxJTemxwjSWMFD36ykVq6n44oBhjSFz8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qLMvffRY8XXo+MXewYOLXW5F+oQRtrQizJ+qPgEedMNwHo4l1vux0+bFCMG9fpK79Qf+ChuIGlUcncwPGbtfGm12ndzEI5UZnuJDT57kbHvdCKnbnp1rXXBgbWcnNbU6I7y2eSGVQSsZp0hBZs+fVAC4cIJ++4fklaZjlvKb57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bY/eCuPt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bY/eCuPt"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2431820B7169;
	Fri,  2 Oct 2026 14:58:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2431820B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790978281;
	bh=b2GtJHBzDcmYlbHghwmtxMILKeFIMO+Ff8lGch7jV0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bY/eCuPtmV+/cl9lGxAHg9mVkeIqewu+FwiHuWbNU6TkRDLg0RCJPMYgsbXZb9yZp
	 4roTg0N7pVxP5vzT5OM13fXad3Pj7EXUahyzKsH3VP8hc1VmmzPBaK+5db670FZy4p
	 uPnx5WAkoFJIQIqLQPRQcDCGh4OYDFxdfbF01FHU=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v5 3/6] arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
Date: Fri,  2 Oct 2026 14:57:22 -0700
Message-ID: <20261002215725.2015959-4-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Arm CCA Realms cannot issue Hyper-V hypercalls via HVC; the guest must
route them through the RSI_HOST_CALL interface, which takes the IPA of a
per-CPU rsi_host_call structure as its argument.

Add hv_hostcall_array as a per-CPU struct array and allocate it during
hyperv_init(). The allocation is gated on is_realm_world() so non-Realm
arm64 Hyper-V guests pay no memory cost.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c      | 28 ++++++++++++++++++++++++++--
 arch/arm64/include/asm/mshyperv.h |  4 ++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26a..b1657cf 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -11,14 +11,19 @@
 
 #include <linux/types.h>
 #include <linux/acpi.h>
+#include <linux/arm-rsi-cmds.h>
 #include <linux/export.h>
 #include <linux/errno.h>
+#include <linux/slab.h>
 #include <linux/version.h>
 #include <linux/cpuhotplug.h>
 #include <asm/mshyperv.h>
 
 static bool hyperv_initialized;
 
+struct rsi_host_call *hv_hostcall_array;
+EXPORT_SYMBOL_GPL(hv_hostcall_array);
+
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 {
 	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
@@ -85,6 +90,20 @@ static int __init hyperv_init(void)
 	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
 		return 0;
 
+	/*
+	 * The RSI host-call buffers are only ever used when
+	 * is_realm_world() is true. Skip the allocation on non-Realm
+	 * guests. A single contiguous array of nr_cpu_ids entries is
+	 * allocated; each CPU indexes into it by its processor ID.
+	 */
+	if (is_realm_world()) {
+		hv_hostcall_array = kcalloc(nr_cpu_ids,
+					    sizeof(struct rsi_host_call),
+					    GFP_KERNEL);
+		if (!hv_hostcall_array)
+			return -ENOMEM;
+	}
+
 	/* Setup the guest ID */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
@@ -106,13 +125,13 @@ static int __init hyperv_init(void)
 
 	ret = hv_common_init();
 	if (ret)
-		return ret;
+		goto free_hostcall_mem;
 
 	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:online",
 				hv_common_cpu_init, hv_common_cpu_die);
 	if (ret < 0) {
 		hv_common_free();
-		return ret;
+		goto free_hostcall_mem;
 	}
 
 	if (ms_hyperv.priv_high & HV_ACCESS_PARTITION_ID)
@@ -125,6 +144,11 @@ static int __init hyperv_init(void)
 
 	hyperv_initialized = true;
 	return 0;
+
+free_hostcall_mem:
+	kfree(hv_hostcall_array);
+	hv_hostcall_array = NULL;
+	return ret;
 }
 
 early_initcall(hyperv_init);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b721d31..aed0aa5 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -61,6 +61,10 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 				ARM_SMCCC_OWNER_VENDOR_HYP,	\
 				HV_SMCCC_FUNC_NUMBER)
 
+/* Per-CPU-indexed RSI host call structures for CCA Realms */
+struct rsi_host_call;
+extern struct rsi_host_call *hv_hostcall_array;
+
 #include <asm-generic/mshyperv.h>
 
 #endif
-- 
2.45.4

