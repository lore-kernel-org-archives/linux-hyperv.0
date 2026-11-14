Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624797;
	b=Xxn9udaAMRI8/xqnu95708qOXmJq9qiErISDp/zBTEmHjAV+Afe+X3Nk2xnqz3H7hnGy
	 JVLsoOZ9YdNCspC9HKMTD1K4syCfTCyyQgeqZXhUSRGHlUpJfqrnDqGkfP0aKjX35Cjth
	 zVxw71ZshuuCkrFiwW/Udy0MPDCahkF/dOcVZ5pwl2ldsOy/cM9mN+NLYA7J2wPpcvUhH
	 VgBBAjuQ8SFBTnad84zy5+mJzK+ZKd9d06sVw+LvA5nB3noiWw20dZPpWmUbbUKlBXqun
	 xJ62n2RGyqaH0sFIRDCnLgB4USlPsHd1EqhUJTYooGPtoZQkDnY2cnrQsFrEOBVBv0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624797;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=hJUbW+K1fcr8l7xqrMT7OFKYdnbxBKAwFFiYblGqd9s=;
	b=QoUN7/wtLOqNUis0KXBjYHZob3W3DoWLJdl61JC5HkF3Sslfg6hJITgRLwDOyEV0Bpu8
	 hmADoCWOurZmsiVywX5DHVq054K/gPbmTgOCBiEmzjsZI4/xPUMoLHhZIXxlNPw9qbO+G
	 5qYdcxVhQ0hQjx/atRSDsAxciiF17flIwhGP5Z+IQtENvmrsEgNHrtYdBZ56pcECuRKuu
	 waZBaHlXSmrdcOfpnr7cULEQtkqhVLR0kIuEcA+0CxPVlEUiiwjJt5Rh2CNBTcvr1vd1C
	 PDU1qAsVdQaHX7zkgN6ZdWxdjzXec/nAE78TVFfcNTTlC9X0aj/uPVvPfvsAOy/S0SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ofGnV0LC;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5A7606A329;
	Sat, 14 Nov 2026 02:53:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A5A7606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=ofGnV0LC
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3971C20B7167;
	Fri, 13 Nov 2026 18:53:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3971C20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794624792;
	bh=hJUbW+K1fcr8l7xqrMT7OFKYdnbxBKAwFFiYblGqd9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ofGnV0LCsYrDJkSNpxy/N40I9U3fJbufuXQqabDz6V19p0BUo5fDwdGLezPsE78U9
	 m+m/DsbN3OnotVuH4ao6oB1dMdQor0NCnyZQcAmyUc5M463JSpvLuGKPwdjEDks4yA
	 rqqky1x1T0i4gLn+2NU1ZgRJaVzo8ka5atqhdbhQ=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com,
	kameroncarr@linux.microsoft.com
Subject: [PATCH V1 1/2] Drivers: hv: Add new function hv_isolation_type_hw()
Date: Fri, 13 Nov 2026 18:53:12 -0800
Message-ID: <20261114025313.1257042-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
References: <20261114025313.1257042-1-mrathor@linux.microsoft.com>
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

Add a new function hv_isolation_type_hw() for convenient check of
whether a VM is running in HW confidential mode, ie, TDX or SNP on x86
or RME on ARM.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/ivm.c          | 5 +++++
 drivers/hv/hv_common.c         | 9 +++++++--
 include/asm-generic/mshyperv.h | 7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..26e570cf77be 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -944,3 +944,8 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
+
+bool hv_isolation_type_hw(void)
+{
+	return hv_isolation_type_snp() || hv_isolation_type_tdx();
+}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 27b9b79d4f4c..b537cafdc2a2 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -528,8 +528,7 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
-		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
+		if (!ms_hyperv.paravisor_present && hv_isolation_type_hw()) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
@@ -696,6 +695,12 @@ bool __weak hv_isolation_type_tdx(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
 
+bool __weak hv_isolation_type_hw(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_type_hw);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 4c9f3353074a..396bcb3db0bc 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -84,6 +84,13 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
+/* This needs to be before hv_do_rep_hypercall() below */
+#if IS_ENABLED(CONFIG_HYPERV)
+bool hv_isolation_type_hw(void);
+#else
+static inline bool hv_isolation_type_hw(void) { return false; }
+#endif
+
 /*
  * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
  * it doesn't provide a recommendation flag and AEOI must be disabled.
-- 
2.51.2.vfs.0.1

