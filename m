Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F30748AE0E;
	Tue,  9 Jun 2026 18:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781028651; cv=none; b=PA+VNH06P5VdufvIc1ffAoZ57+Au+dS7G7veuN6aD4UBnQtzQRoxFtBVULMGi5H1JXO6UGzbpYof/ZlACbukFzokH7nR2IswujhVebS3zPDBbtZ8X3Fqg0qmH9sgLutOUouo7GPtT+sE9Sf4D+YRbGc+6Emubj+FP8atRQBllfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781028651; c=relaxed/simple;
	bh=khPsvoRvauWx1pHktc4x5QWtXHCj9HfHNHuWQYzXKzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nIq/fVluQrQgm/1w/dRRRh6KgXc+vTTBgq1jzswbTv8UYihVPOQGjvS4b3hy8Cc+wjj3eJZeP6mIgGb0U+zLkKkqtpajM4oLKHv0hJGVUdkgihhzDJA9KOwB8tXkQ8MgG6j+qWP9nGLKFYHuQdJt7fHXGJP0sRg37ltvkU79llQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e5J64Wa6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e5J64Wa6"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7BEEE20B7168;
	Tue,  9 Jun 2026 11:10:32 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7BEEE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1781028632;
	bh=KI069RBnL/iLpjQNmwGOrF7XUz9O+JaN3/9K4v8CLNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e5J64Wa6hJ9DNZkCEcNuQZvMgRlsTx4zQmbL1+pODyn2Q9XkM8CSdCKEGJdQDw+IL
	 1amN2VZTQFRryC50weiL0IGCdkNA76FPN7KMD/6ppQLxwZcZn9j89edEjOWG8DTF/9
	 HalUfEy5ORrlehvRhwVM2WRtUEMEqr+usyt8QfwQ=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
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
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [RFC PATCH 3/6] arm64: hyperv: Add per-CPU RSI host call infrastructure for CCA Realms
Date: Tue,  9 Jun 2026 11:10:27 -0700
Message-ID: <20260609181030.2378391-4-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
References: <20260609181030.2378391-1-kameroncarr@linux.microsoft.com>
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

Add hyperv_pcpu_hostcall_struct as a per-CPU pointer to that buffer and
allocate it for the boot CPU during hyperv_init() and for each secondary
CPU in hv_cpu_init(). The allocation is gated on is_realm_world() so
non-Realm arm64 Hyper-V guests pay no memory cost.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c      | 78 ++++++++++++++++++++++++++++++-
 arch/arm64/include/asm/mshyperv.h |  3 ++
 2 files changed, 79 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26ade1d74..08fec82691683 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -15,10 +15,16 @@
 #include <linux/errno.h>
 #include <linux/version.h>
 #include <linux/cpuhotplug.h>
+#include <linux/slab.h>
+#include <linux/percpu.h>
 #include <asm/mshyperv.h>
+#include <asm/rsi.h>
 
 static bool hyperv_initialized;
 
+void * __percpu *hyperv_pcpu_hostcall_struct;
+EXPORT_SYMBOL_GPL(hyperv_pcpu_hostcall_struct);
+
 int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
 {
 	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
@@ -60,6 +66,46 @@ static bool __init hyperv_detect_via_acpi(void)
 
 #endif
 
+static void hv_hostcall_free(void)
+{
+	int cpu;
+
+	if (!hyperv_pcpu_hostcall_struct)
+		return;
+
+	for_each_possible_cpu(cpu)
+		kfree(*per_cpu_ptr(hyperv_pcpu_hostcall_struct, cpu));
+	free_percpu(hyperv_pcpu_hostcall_struct);
+	hyperv_pcpu_hostcall_struct = NULL;
+}
+
+static int hv_cpu_init(unsigned int cpu)
+{
+	void **hostcall_struct;
+	gfp_t flags;
+	void *mem;
+
+	if (hyperv_pcpu_hostcall_struct) {
+		/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
+		flags = irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL;
+
+		hostcall_struct = (void **)this_cpu_ptr(hyperv_pcpu_hostcall_struct);
+		/*
+		 * The hostcall_struct memory is not freed when the CPU
+		 * goes offline. If a previously offlined CPU is brought
+		 * back online, the memory is reused here.
+		 */
+		if (!*hostcall_struct) {
+			mem = kzalloc_obj(struct rsi_host_call, flags);
+			if (!mem)
+				return -ENOMEM;
+			*hostcall_struct = mem;
+		}
+	}
+
+	return hv_common_cpu_init(cpu);
+}
+
 static bool __init hyperv_detect_via_smccc(void)
 {
 	uuid_t hyperv_uuid = UUID_INIT(
@@ -73,6 +119,8 @@ static bool __init hyperv_detect_via_smccc(void)
 static int __init hyperv_init(void)
 {
 	struct hv_get_vp_registers_output	result;
+	void **hostcall_struct;
+	void *mem;
 	u64	guest_id;
 	int	ret;
 
@@ -85,6 +133,27 @@ static int __init hyperv_init(void)
 	if (!hyperv_detect_via_acpi() && !hyperv_detect_via_smccc())
 		return 0;
 
+	/*
+	 * The RSI host-call buffer is only ever used when
+	 * is_realm_world() is true. Skip the per-CPU allocation on
+	 * non-Realm guests.
+	 */
+	if (is_realm_world()) {
+		hyperv_pcpu_hostcall_struct = alloc_percpu(void *);
+		if (!hyperv_pcpu_hostcall_struct)
+			return -ENOMEM;
+
+		hostcall_struct = (void **)this_cpu_ptr(hyperv_pcpu_hostcall_struct);
+		if (!*hostcall_struct) {
+			mem = kzalloc_obj(struct rsi_host_call);
+			if (!mem) {
+				ret = -ENOMEM;
+				goto free_hostcall_mem;
+			}
+			*hostcall_struct = mem;
+		}
+	}
+
 	/* Setup the guest ID */
 	guest_id = hv_generate_guest_id(LINUX_VERSION_CODE);
 	hv_set_vpreg(HV_REGISTER_GUEST_OS_ID, guest_id);
@@ -106,12 +175,13 @@ static int __init hyperv_init(void)
 
 	ret = hv_common_init();
 	if (ret)
-		return ret;
+		goto free_hostcall_mem;
 
 	ret = cpuhp_setup_state(CPUHP_AP_HYPERV_ONLINE, "arm64/hyperv_init:online",
-				hv_common_cpu_init, hv_common_cpu_die);
+				hv_cpu_init, hv_common_cpu_die);
 	if (ret < 0) {
 		hv_common_free();
+		hv_hostcall_free();
 		return ret;
 	}
 
@@ -125,6 +195,10 @@ static int __init hyperv_init(void)
 
 	hyperv_initialized = true;
 	return 0;
+
+free_hostcall_mem:
+	hv_hostcall_free();
+	return ret;
 }
 
 early_initcall(hyperv_init);
diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index b721d3134ab66..65a00bd14c6cb 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -63,4 +63,7 @@ static inline u64 hv_get_non_nested_msr(unsigned int reg)
 
 #include <asm-generic/mshyperv.h>
 
+/* Per-CPU RSI host call structure for CCA Realms */
+extern void *__percpu *hyperv_pcpu_hostcall_struct;
+
 #endif
-- 
2.45.4

