Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405679;
	b=0RGWCHfyQV04NIY4TKbaILpddE5VdlOncRLPUR868JRsHDFaNFwve3tHDlYrDcRsv1w7
	 CGsPW/CGSxjFI+xSuNT0zvhy8OPvuU124Cdx5Z34GUu1uQIrMpvtj8yaU7rQk7FuwS1Jb
	 eHAn1/moMAbQycFwfNRa8rlSJ8kKkQHjuWOjkQSoUSnNLSXWChUpenKIyQYyrLMANW4u7
	 RhwJ/oMQDbuh/piu3tYVQVyZ7bhxunSXOrLwneOiyfQ8tb3ooDHiCiL6ImzyBgD571AJX
	 Ria09bptyBDTtM1DsUDNN80+Sq4Qo2BReIC77fLucy05Y7EgMuUmkLbMgzqODdmZ41Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405679;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=tUThciFj1hcYiyxnI7ab6umz9s0IGMVjpLBFXnmrmss=;
	b=MSATrIz+m+weNNOq4CwpN6nV7NGMk0Cfk8IVUd+PX3v8nKenhZUlLUkoJjBJFT+h8lqX
	 mNyC13rVhnJjBRCya1efUNL+Vtue4UWUCBzhMsk6F7E9tNAH4JU9MhFWwSmsZGnWstzyn
	 4FyGyfDBPf7WKFDQbxCGneFVMTRKbjbsjxeUbwAixFhuu9+7E0f5esXty4sF+we+HdHwC
	 CTybuitvhhUcNPuZ+vK+1vE7vJP64K0l7EXpjHrfNdT99WLV3BneSPDkqX0jQLEC4/jBr
	 xGUZpOMYbvuzA1VUCakQejUe5FqqOKSX0T7w8c8qymaXarLb/gQv2luNhhcTtXycnGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=mqg375vX;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 674A6606A325;
	Sat, 31 Oct 2026 00:14:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 674A6606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=mqg375vX
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1CDE520B7168;
	Fri, 30 Oct 2026 17:14:26 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1CDE520B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793405666;
	bh=tUThciFj1hcYiyxnI7ab6umz9s0IGMVjpLBFXnmrmss=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqg375vX3IJlCOziW+G034ttHD7R5dtkprHPbFY5DETsGWrdOYytSTJVAsaO+ORC5
	 iPcmO84T650JE0Gm+5exMf/aHY4c7WsW1wYkh624gEdtrxL2ELvoW06jKggWMJ8X+q
	 g+6NShY/nKMpBFhCXOVG4ajAC4aHZC7BcGxmth7E=
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
Subject: [PATCH v6 2/6] arm64: hyperv: Detect Hyper-V via RSI host call in CCA Realms
Date: Fri, 30 Oct 2026 17:14:08 -0700
Message-ID: <20261031001412.4150488-3-kameroncarr@linux.microsoft.com>
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

When booting without ACPI, hyperv_detect_via_smccc() detects Hyper-V by
querying the SMCCC vendor hypervisor UID. In an Arm CCA Realm the SMCCC
call is handled by the RMM rather than by the hypervisor, so the
query never reaches Hyper-V and detection fails.

When running in a Realm, forward ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
to the host with RSI_HOST_CALL instead, which is how Hyper-V hypercalls
are issued from a Realm.

This is done in the Hyper-V code rather than in the generic
arm_smccc_hypervisor_has_uuid() because the other users expect different
behavior.

hyperv_init() is an early_initcall and runs before the secondary CPUs
are brought up, so a single __initdata host call structure is used
without locking.

ACPI-based detection and non-Realm guests are unaffected.

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/hyperv/mshyperv.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index 4fdc26a..82572c5 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -11,6 +11,7 @@
 
 #include <linux/types.h>
 #include <linux/acpi.h>
+#include <linux/arm-rsi-cmds.h>
 #include <linux/export.h>
 #include <linux/errno.h>
 #include <linux/version.h>
@@ -60,6 +61,27 @@ static bool __init hyperv_detect_via_acpi(void)
 
 #endif
 
+/*
+ * In a Realm, the SMCCC call is handled by the RMM rather than by
+ * Hyper-V, so the vendor hypervisor UID query must be forwarded to the
+ * host with RSI_HOST_CALL, in the same way as hypercalls.
+ */
+static bool __init hyperv_realm_has_uuid(const uuid_t *hyperv_uuid)
+{
+	static struct rsi_host_call hc __initdata;
+	uuid_t uuid;
+
+	hc.gprs[0] = ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID;
+
+	if (rsi_host_call(__pa_symbol(&hc)) != RSI_SUCCESS ||
+	    hc.gprs[0] == SMCCC_RET_NOT_SUPPORTED)
+		return false;
+
+	uuid = smccc_res_to_uuid(hc.gprs[0], hc.gprs[1], hc.gprs[2],
+				 hc.gprs[3]);
+	return uuid_equal(&uuid, hyperv_uuid);
+}
+
 static bool __init hyperv_detect_via_smccc(void)
 {
 	uuid_t hyperv_uuid = UUID_INIT(
@@ -67,6 +89,9 @@ static bool __init hyperv_detect_via_smccc(void)
 		0x75, 0x6c, 0xef, 0x8e,
 		0x24, 0x70, 0x59, 0x16);
 
+	if (is_realm_world())
+		return hyperv_realm_has_uuid(&hyperv_uuid);
+
 	return arm_smccc_hypervisor_has_uuid(&hyperv_uuid);
 }
 
-- 
2.45.4

