Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994E93ED113;
	Thu, 25 Jun 2026 17:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408909; cv=none; b=upH1CHhIvWn4JIGswNce1XP1sRidqO2J4qxZAeJoNQCTuLaVZRaQXDH4WToJO7YOWDbY5wPVn8FzVEh9lTMTlOxI0BLOKzK2AT9enzuYNtkb/ajycrhPIgnhxPIzQv6/EWC7zI6FX/fC8B3rl09OLaaoVIonRoW2Ngrvdh+5oRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408909; c=relaxed/simple;
	bh=SUzt8dgUTCtPXTMD+YgqT1N0/j2pm3vbJoXbzFrXbgY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bO9KpDo5d2Mag360/QvoBHa37rZrVmwQ7zI+9s3MTmDGJtQwgvK7x8l/SRNE2CJ1NUeNzKitM/iTgxJ1rNa/d74zoaGzpLywQlvq1G8XDxuVn4LTPCsaC4CmEnBjUYXxDJQwN3Ox9kiXn24W0twOKUtUnAh7MCCagn2NsWn3wb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BxeUDTGD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BxeUDTGD"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60D8020B716C;
	Thu, 25 Jun 2026 10:35:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60D8020B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408902;
	bh=FIwLNRMcbK47n5JRe68/3ADojvTQP3LI5biOeKQVxxY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BxeUDTGDEMjk9ZPLPCQD70jO3diGmtduNv+UAXBdlCqBEVfEsnieqMmQdVTmIqSBZ
	 x3dop4ZNmMqmsfhLtR79moORjaD2Ruri7sS9+JW8Ukni+VV/dIhf6WD+x0hCMW7+lf
	 rGFFGeke/rzAbn/aHJjIFr4T+lEg4IeI9ItBGqGk=
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
Subject: [PATCH v2 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Thu, 25 Jun 2026 10:34:58 -0700
Message-ID: <20260625173500.1995481-5-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
to be marked as decrypted (shared) for confidential VM isolation types.
This is already done for SNP and TDX isolation; extend the same handling
to Arm CCA Realm guests so that the host hypervisor can access the
shared hypercall buffers.

We need to round up the memory allocated for the input/output pages to
the nearest PAGE_SIZE, since set_memory_decrypted() requires the size to
be a multiple of PAGE_SIZE. This only has an effect on ARM VMs that are
using PAGE_SIZE larger than 4K.

is_realm_world() is only declared in arch/arm64/include/asm/rsi.h, so
using it directly in the arch-neutral drivers/hv/hv_common.c would
break the x86 build. Introduce a Hyper-V-specific helper following the
established hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.

On architectures other than arm64 the weak default keeps the existing
behaviour.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c   |  5 +++++
 drivers/hv/hv_common.c         | 17 +++++++++++++----
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 7d536d7fb557e..8e8148b723d9c 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -164,3 +164,8 @@ bool hv_is_hyperv_initialized(void)
 	return hyperv_initialized;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_isolation_type_cca(void)
+{
+	return is_realm_world();
+}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6b67ac6167891..17048a0a18729 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -476,6 +476,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	u64 msr_vp_index;
 	gfp_t flags;
 	const int pgcount = hv_output_page_exists() ? 2 : 1;
+	const size_t alloc_size = ALIGN((size_t)pgcount * HV_HYP_PAGE_SIZE, PAGE_SIZE);
 	void *mem;
 	int ret = 0;
 
@@ -489,7 +490,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	 * online and then taken offline
 	 */
 	if (!*inputarg) {
-		mem = kmalloc_array(pgcount, HV_HYP_PAGE_SIZE, flags);
+		mem = kmalloc(alloc_size, flags);
 		if (!mem)
 			return -ENOMEM;
 
@@ -499,14 +500,16 @@ int hv_common_cpu_init(unsigned int cpu)
 		}
 
 		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
-			ret = set_memory_decrypted((unsigned long)mem, pgcount);
+		    (hv_isolation_type_snp() || hv_isolation_type_tdx() ||
+		     hv_isolation_type_cca())) {
+			ret = set_memory_decrypted((unsigned long)kasan_reset_tag(mem),
+				alloc_size >> PAGE_SHIFT);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
 				return ret;
 			}
 
-			memset(mem, 0x00, pgcount * HV_HYP_PAGE_SIZE);
+			memset(mem, 0x00, alloc_size);
 		}
 
 		/*
@@ -666,6 +669,12 @@ bool __weak hv_isolation_type_tdx(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
 
+bool __weak hv_isolation_type_cca(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_cca);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb9..1fa79abce743c 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -79,6 +79,7 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
 
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
+bool hv_isolation_type_cca(void);
 
 /*
  * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
-- 
2.45.4

