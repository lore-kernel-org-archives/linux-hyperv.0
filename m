Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DACB33EE1C7;
	Thu, 25 Jun 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408908; cv=none; b=Z1bpDLxl9B1CIhb9RLfwdRQvjQjuHOP/XE5iTRvWuEWst9fuvlXIkEShISZeY+ohhipxc5wTxK/qZYVir796deYuh2eXZFZEES1GmLEdM+zIoI/TiOA6nsZOsdUbq+YFBpVrIBAUIbkQyVjh5M0qpGN4Yh9m91/iD6cOpFbU7fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408908; c=relaxed/simple;
	bh=kTuJntn4d9d0VGuQeorErJTBpqNewh53BBll6mgZMLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyxouRDR3EgNIUtYaJQUbsmQ3ek32QXvS2XKwY5Gi0fCUijx/rwI1bPYvRx2LrbHwd4a+Q8es8SEEu+whvUOTRABAEcHcJJgXFLmYVHzS5o1IJU5APTUTzrk2EgpmuaG5ZfLh/NZT6ufYrtWNyPIFWo1lU/xopPg+fHnGNvhzws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BICiPGL9; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BICiPGL9"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9C38320B716A;
	Thu, 25 Jun 2026 10:35:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9C38320B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408901;
	bh=pCGLDie0xV9RJpzuDsm4ooq0RYqsnGfSauPh4xAqSiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BICiPGL9/pP6WwXAXBdcA7yNVbztfOWWxG0mxTLYY/WH6WLeJxZUdTqL20mGEs8eP
	 oYNR8q1OtbM15vKJ1CddYV5UIbjZr32P7hlajorvYpHQLCBDTESkSEzdTw4fwqYvvm
	 QnryAzB1nJW/H57R9kgjuQyolQawY3F/akuCQCKc=
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
Subject: [PATCH v2 2/6] firmware: smccc: Detect hypervisor via RSI host call in CCA Realms
Date: Thu, 25 Jun 2026 10:34:56 -0700
Message-ID: <20260625173500.1995481-3-kameroncarr@linux.microsoft.com>
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

Modify arm_smccc_hypervisor_has_uuid() to check is_realm_world() and
use rsi_host_call() to query the hypervisor vendor UUID when inside a
Realm. The realm path is factored into a helper,
arm_smccc_realm_get_hypervisor_uuid(), that owns a file-static
rsi_host_call buffer (uuid_hc) serialized by a spinlock.

The RSI-specific includes, file-static state and helper are guarded
with CONFIG_ARM64 because <asm/rsi.h> does not exist on 32-bit ARM.

For non-Realm environments, the existing arm_smccc_1_1_invoke() path
is unchanged.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 drivers/firmware/smccc/smccc.c | 41 +++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/firmware/smccc/smccc.c b/drivers/firmware/smccc/smccc.c
index bdee057db2fd3..a876b7aa2dc99 100644
--- a/drivers/firmware/smccc/smccc.c
+++ b/drivers/firmware/smccc/smccc.c
@@ -12,6 +12,12 @@
 #include <linux/platform_device.h>
 #include <asm/archrandom.h>
 
+#ifdef CONFIG_ARM64
+#include <linux/cleanup.h>
+#include <linux/spinlock.h>
+#include <asm/rsi.h>
+#endif
+
 static u32 smccc_version = ARM_SMCCC_VERSION_1_0;
 static enum arm_smccc_conduit smccc_conduit = SMCCC_CONDUIT_NONE;
 
@@ -67,12 +73,45 @@ s32 arm_smccc_get_soc_id_revision(void)
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

