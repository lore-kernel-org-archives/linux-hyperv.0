Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794363645;
	b=dKFGru+SB/hdPpy1F1Jenaq6K3QmjYCDM8+T9KUVF/owrw3rgdD2pnxJ7skJRDPvAwHx
	 jaMZz8+WnBG7OBDjFUU61pFtN8+dBNCmDQz9TutZVtaAx++zinZYJoimASgBUaavnUPFk
	 HDSvnGF1GHnPk3i3Ufj9295h/VC2aQHH2rKN5QFn38PVIGKnFwj6Jx2gBgfCXWLJ1EOGn
	 KwpqQKXLKagwvXaO6LlPFHLFcDUUXSPxw++DaPP9rJ5PG58vUWIuQT7JIXm00g9BvO5KO
	 fNf1MN/lHwqwNIxfRmrAX25/oMcXcnnQ2F2VLuulHewaFOdb0IT1eX58zjGyZdtj1Ow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794363645;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=6nnQmo5AxugP7HvO/qkyqQx8AvDB2MGczfH52EDmEG8=;
	b=hXHNh/bt7U/x62JXCz24Z+mqLIVsS6hKULlNrhKw9+uUGkCjzzT1Y8ChaK1+OAQJnmqq
	 DR2npPj+hsD82zNvSbiuN+y77ynZOK4VlNPzHqQVjXQHP5jl6ASn2yrsBYdp0C26fFEwT
	 iCm6FvCGIlKo+TwR8DqP6Vk5m35wtvbnMWJjzvPciFEsz8clHHsqAaCBxnfPpppydoshG
	 hVIoDDenRkrN57i9L2JL7rwFaa0vtWNiBe2pGKUHii6AFeN2crpKtRu5tAosLLvXK72C1
	 ZxWzVoJ4I5cu20mBCHHtNac+Dx+TU2btQXdVHh1TYj4/9XwoGQl449tBNlr/UH8tAbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="GdZXfc/p";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EAC606A320;
	Wed, 11 Nov 2026 02:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10EAC606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=GdZXfc/p
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id B6C0720B7169;
	Tue, 10 Nov 2026 18:20:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B6C0720B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794363641;
	bh=6nnQmo5AxugP7HvO/qkyqQx8AvDB2MGczfH52EDmEG8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdZXfc/pZnzTdAps2lYemnnjOQWi08iSnl/6RtJ990ZDJTzRQDy8sJWbuAUY5VrQl
	 tNmb3zGrNHMquPq6lGRnSY9s0ZvJH52b9EoOm5IcHiWM4GItSNk48C0amF8IUguHDj
	 ROL4ncwtzcU/bvRov7Igs29u1aH09mGMVnFeNy8k=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH V0 1/2] Drivers: hv: Add new function hv_isolation_hw_cvm()
Date: Tue, 10 Nov 2026 18:20:35 -0800
Message-ID: <20261111022036.351231-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20261111022036.351231-1-mrathor@linux.microsoft.com>
References: <20261111022036.351231-1-mrathor@linux.microsoft.com>
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

Add a new function hv_isolation_hw_cvm() for convenient check
if a VM is running in HW confidential mode, ie, TDX or SNP.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/ivm.c          | 5 +++++
 drivers/hv/hv_common.c         | 9 +++++++--
 include/asm-generic/mshyperv.h | 7 +++++++
 3 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 2ce4dfe53472..b3340be0c43a 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -944,3 +944,8 @@ bool hv_isolation_type_tdx(void)
 {
 	return static_branch_unlikely(&isolation_type_tdx);
 }
+
+bool hv_isolation_hw_cvm(void)
+{
+	return hv_isolation_type_snp() || hv_isolation_type_tdx();
+}
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 27b9b79d4f4c..62b52855ae69 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -528,8 +528,7 @@ int hv_common_cpu_init(unsigned int cpu)
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
 
-		if (!ms_hyperv.paravisor_present &&
-		    (hv_isolation_type_snp() || hv_isolation_type_tdx())) {
+		if (!ms_hyperv.paravisor_present && hv_isolation_hw_cvm()) {
 			ret = set_memory_decrypted((unsigned long)mem, pgcount);
 			if (ret) {
 				/* It may be unsafe to free 'mem' */
@@ -696,6 +695,12 @@ bool __weak hv_isolation_type_tdx(void)
 }
 EXPORT_SYMBOL_GPL(hv_isolation_type_tdx);
 
+bool __weak hv_isolation_hw_cvm(void)
+{
+	return false;
+}
+EXPORT_SYMBOL_GPL(hv_isolation_hw_cvm);
+
 void __weak hv_setup_vmbus_handler(void (*handler)(void))
 {
 }
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index a3d497d99b0b..440c599784eb 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -87,6 +87,13 @@ u64 hv_do_fast_hypercall16(u16 control, u64 input1, u64 input2);
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
+/* This needs to be before hv_do_rep_hypercall() below */
+#if IS_ENABLED(CONFIG_HYPERV)
+bool hv_isolation_hw_cvm(void);
+#else
+static inline bool hv_isolation_hw_cvm(void) { return false; }
+#endif
+
 /*
  * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
  * it doesn't provide a recommendation flag and AEOI must be disabled.
-- 
2.51.2.vfs.0.1

