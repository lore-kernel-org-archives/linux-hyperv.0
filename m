Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405680;
	b=5TCHaOBqt7ur8ExVX29U+a/JAIxEF3HolXB6G594N59qI4h2VftSkwU167QgKfvSRTbd
	 n0huQHDHFJbutFswmChc4QRD9iZxqTqWHyq8tDS8QHi3q+Ojwr8Nov6DKNMibrBN5Y7DI
	 07z3qK+cXwJ20vCOZWHGye8H6eYlb7MX6ww+fc6yxm69PvTbibsSbNC5XuP1Vzv10YSAq
	 oju4sFnQNP030q8ijKwP0d92DD1cVUqTRE4ejuOxC90yL53yD/U6RwFdfDSUelRxHefHe
	 cv+PPHq+TmGK+0CSmpyr9DQw354kbx62G4YNwDfT2WUUYFvt2tB4GTMIJvugevMcsJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405680;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=kQ5/8xbFXcvnPBvtpcGqH1Rld8p6e60w+RwWV7HqUUY=;
	b=Gf9r5RhWc5qtCHm5rdDVgVpyL1MynBqSa+kII8NqphPoMd5Zq/50w13bhhLv9LpWRC80
	 helxH+cf3YBw059EuAZKZ5KRQagLnHCYIS+BEEL3odJ52LqhLFDKx5+SOmRoNMftxW8AZ
	 63dBQqyw5ikwRmaWrBB9sviHTKjljyifZbU97tIKCtMkr/04WflBGmHHHU2Jko1A9fAaW
	 3Hi5KNkNP0L20gqjcDdx5r7Q2B2NGZLW0sP5LKjSdraO6fclWxpsQabnmrhiW9dSsqC2t
	 qdSyOvDw832zCgPUyEX01Esm6eiELcRcD5cCueHFTkhBkdFBQ6wylLrEY6g/kkvZvFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="P+ekTsJ/";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84631606A337;
	Sat, 31 Oct 2026 00:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84631606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=P+ekTsJ/
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 013DB20B716E;
	Fri, 30 Oct 2026 17:14:27 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 013DB20B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793405667;
	bh=kQ5/8xbFXcvnPBvtpcGqH1Rld8p6e60w+RwWV7HqUUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P+ekTsJ/opLRlBEuR94J9UjkhCsMFfvbJjvtZq0w5TiN+3cUChC2aO680+dVW09+I
	 2hdyQHwno/0Pb+ZYwbxTcIKDd4brQJqsI//6Z7wH7IH4z3rTgNTJPrI02KpISZtYwH
	 20LERihtY+OHRaORU8w9VUVm+0X4/W2rHEUtg4v8=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	mhklinux@outlook.com,
	wei.liu@kernel.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	sudeep.holla@kernel.org,
	thuth@redhat.com,
	will@kernel.org
Subject: [PATCH v6 4/6] Drivers: hv: Mark shared memory as decrypted for CCA Realms
Date: Fri, 30 Oct 2026 17:14:10 -0700
Message-ID: <20261031001412.4150488-5-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
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
index 46ab2da..da6c3aa0 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -182,3 +182,8 @@ bool hv_is_hyperv_initialized(void)
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

