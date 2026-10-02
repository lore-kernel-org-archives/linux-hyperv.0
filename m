Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14BB1468C39;
	Fri,  2 Oct 2026 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978337; cv=none; b=uvIMxbBx6eVmQurqIJB1LBYLTv1gAuzc9m4lpUq2aMsZ0h6iXpbQWNgqEIGcuCga09k8PWF8FnKgqjjRdGp1MUIkt2SUSkdREp7vCbRp8Fa+/fTEMv3raplZxcHqK8Jyl9dXbfciIfFJulQqv9kAmdfYKN80MNRKrMjZ63lQK/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978337; c=relaxed/simple;
	bh=Q/eBSYKHoTI/khO8eJCH1zEAGI5QnfUspyLuNSf8RXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o4xGd/Geu99TKXeCSbdRm+tbjSn4FB0r1vcK8/xyfXQGXWhpynqj5cSWiYbP4PAS0DMj6tx0IlRmqAQliI/dcI9vHqrWCdEMrG8PvdiK7zJiWan4Dn69RjkuMujg4upoEFbI7aULR5woSWDBpVl/NTLDDn6eDwO29vAZV1L/8Ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FbIxTxN0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FbIxTxN0"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 00CAE20B716F;
	Fri,  2 Oct 2026 14:58:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 00CAE20B716F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790978282;
	bh=M+4fYoulF6eg59OIPkhRsd27IfbPeLczkS7f4QV9AjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FbIxTxN0GNi4C+Z5ccXfQZ01+sMzvVtyW08R5aCeXXAVVfyV8j0/w1fDzv5l0bH8I
	 G8vmhLOgigjHAMYZK+mfdXvPUIMonW4NgE9eqJ3LOo+Q/tCD3tZ0LxiWETtAJHfXI9
	 qSseXv9vmvEI7aoUtW343s8r5nKXxaIPCo6ALuWQ=
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
Subject: [PATCH v5 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Fri,  2 Oct 2026 14:57:23 -0700
Message-ID: <20261002215725.2015959-5-kameroncarr@linux.microsoft.com>
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

In hv_common_cpu_init(), the per-CPU hypercall input/output pages need
to be marked as decrypted (shared) for confidential VM isolation types.
This is already done for SNP and TDX isolation; extend the same handling
to Arm CCA Realm guests so that the host hypervisor can access the
shared hypercall buffers.

is_realm_world() is declared in include/linux/arm-rsi-cmds.h which only
builds on arm64 (it includes <asm/memory.h>), so using it directly in
the arch-neutral drivers/hv/hv_common.c would break the x86 build.
Introduce a Hyper-V-specific helper following the established
hv_isolation_type_snp() / hv_isolation_type_tdx() pattern.

On architectures other than arm64 the weak default keeps the existing
behaviour.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c   |  5 +++++
 drivers/hv/hv_common.c         | 17 +++++++++++++----
 include/asm-generic/mshyperv.h |  1 +
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index b1657cf..45ca8e2 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -158,3 +158,8 @@ bool hv_is_hyperv_initialized(void)
 	return hyperv_initialized;
 }
 EXPORT_SYMBOL_GPL(hv_is_hyperv_initialized);
+
+bool hv_isolation_type_cca(void)
+{
+	return is_realm_world();
+}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 31256cb..a60c92c 100644
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
+			ret = set_memory_decrypted((unsigned long)mem,
+						   alloc_size >> PAGE_SHIFT);
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
index bf601d6..1fa79ab 100644
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

