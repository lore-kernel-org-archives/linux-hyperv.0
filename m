Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDCAA367B6E;
	Thu,  1 Oct 2026 22:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892422; cv=none; b=rl8zlHCgk3BcYkYNos3jh3PwCMpE0HPGmMmDcJRiMe2j7yt3CrwaS7qQvhHDilVUltUjS5+ov7oj5vDZB5+mnflpoMDDAwtG3MG9OcFIGpl2ixadA1XA/+VzC7wv/UMaxsUp5NpBNy7NWe9fPxtloUdkjUBk1PdgETaCFfP5gD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892422; c=relaxed/simple;
	bh=0piWK77N9+m/WJHjK9akSa6UHWiYmh8Xj5fcKHJ/dac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3W1jMK7gFCCUzljMe7No5/XSvE7b2UYL8rJ/FshWZW0QlKxMTRFNXTofjBNho9bkh8VOQCEmFv6fR9gt0rR4ZC1/0km94jjFMZpv38emDWGKupFkr3mVBbOmzdOakHJXobIrWxZMkwWYmABSAVntV2iCJKB5HWuEjGKblg/qbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=GsI7nSMy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="GsI7nSMy"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D727420B7168;
	Thu,  1 Oct 2026 15:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D727420B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892366;
	bh=yt0d7f0K7RTpFyUxmS5k853unes0VcTfu1z72WXMx1g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GsI7nSMyUm9bkvwFV59pXbAzRZ1rtG+7DY7ghLfWUrh3Sw+ODLhNkYrcHrCNhDaz4
	 6f7RekhhHZ6erFXPQd+wY+Uu3gHrGfN1Ox0jhBEJPuNcuUW2xljC5TEQEXBf63ffn3
	 0IpNNNkuFMLcabLHq7wPHJn0iNDC+tgJfyUrmbkk=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
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
Subject: [PATCH v4 2/6] firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
Date: Thu,  1 Oct 2026 15:05:48 -0700
Message-ID: <20261001220552.1793471-3-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Modify arm_smccc_hypervisor_has_uuid() to check is_realm_world() and
use rsi_host_call() to query the hypervisor vendor UUID when inside a
Realm. The realm path is factored into a helper,
arm_smccc_realm_get_hypervisor_uuid(), that owns a file-static
rsi_host_call buffer (uuid_hc) serialized by a spinlock.

The RSI-specific includes, file-static state and helper are guarded
with CONFIG_ARM64 because <asm/rsi.h> does not exist on 32-bit ARM.

For non-Realm environments, the existing arm_smccc_1_1_invoke() path
is unchanged.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/firmware/smccc/smccc.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index afc2e4d..7e77170 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -14,6 +14,12 @@
 
 #include <asm/archrandom.h>
 
+#ifdef CONFIG_ARM64
+#include <linux/arm-rsi-cmds.h>
+#include <linux/cleanup.h>
+#include <linux/spinlock.h>
+#endif
+
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
 static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
@@ -69,12 +75,45 @@ s32 arm_smccc_get_soc_id_revision(void)
 }
 EXPORT_SYMBOL_GPL(arm_smccc_get_soc_id_revision);
 
+#ifdef CONFIG_ARM64
+static struct rsi_host_call uuid_hc;
+static DEFINE_SPINLOCK(uuid_hc_lock);
+
+/*
+ * Helper function to get the hypervisor UUID via an RsiHostCall.
+ */
+static void arm_smccc_realm_get_hypervisor_uuid(struct arm_smccc_res *res)
+{
+	guard(spinlock_irqsave)(&uuid_hc_lock);
+
+	memset(&uuid_hc, 0, sizeof(uuid_hc));
+	uuid_hc.gprs[0] = ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
+
+	if (rsi_host_call(__pa_symbol(&uuid_hc)) != RSI_SUCCESS) {
+		res->a0 = SMCCC_RET_NOT_SUPPORTED;
+		return;
+	}
+
+	res->a0 = uuid_hc.gprs[0];
+	res->a1 = uuid_hc.gprs[1];
+	res->a2 = uuid_hc.gprs[2];
+	res->a3 = uuid_hc.gprs[3];
+}
+#endif
+
 bool arm_smccc_hypervisor_has_uuid(const uuid_t *hyp_uuid)
 {
 	struct arm_smccc_res res = {};
 	uuid_t uuid;
 
-	arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID, &res);
+#ifdef CONFIG_ARM64
+	if (is_realm_world())
+		arm_smccc_realm_get_hypervisor_uuid(&res);
+	else
+#endif
+		arm_smccc_1_1_invoke(ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID,
+				     &res);
+
 	if (res.a0 == SMCCC_RET_NOT_SUPPORTED)
 		return false;
 
-- 
2.45.4

