Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78DF3EE1D4;
	Tue,  1 Sep 2026 03:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788233578; cv=none; b=B9XpFaXV59710tpl9m+wEmsYiOdjqJd/VtETIgwMq3IjbpSPAsyLCm6NuErOxK4sK6rKBel/EXwNlKj8IH7fht3VweIvNyBLuBk6CcgoRbXIAv/K//W4SSNfdpVGZKNvMOD4ynYZAb5KWJ3q67PegSiLeRUirr97N44I7MJnqAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788233578; c=relaxed/simple;
	bh=HHnwIxMb509xaGyZBuKFY4im5E4B6xtw5Vgf2wj7Oms=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cyYdGLBl/9SY2lArjhumvVeDFm47hOLE5Vp7IkRcIkHIxiB8qSTTQsxPq7ChbzNOxoIppynUNpsMVh0SAxBpzQ0ktBJ+rZsCpOm2Q72yq7kJzkwD9HfyhF6vZrXuQdqL+hkyITjbeIO6bOuOYPna0K+i+HjWhcO7zxiLV8NjmvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: cd2d4f12a5b511f19a56ed5b684f684d-20260901
X-CTIC-Tags:
	HR_CC_COUNT, HR_CC_DOMAIN_COUNT, HR_CC_NAME, HR_CC_NO_NAME, HR_CTE_8B
	HR_CTT_MISS, HR_DATE_H, HR_DATE_WKD, HR_DATE_ZONE, HR_FROM_NAME
	HR_SJ_DIGIT_LEN, HR_SJ_LANG, HR_SJ_LEN, HR_SJ_LETTER, HR_SJ_NOR_SYM
	HR_SJ_PHRASE, HR_SJ_PHRASE_LEN, HR_SJ_WS, HR_TO_COUNT, HR_TO_DOMAIN_COUNT
	HR_TO_NO_NAME, IP_TRUSTED, SRC_TRUSTED, DN_TRUSTED, SA_TRUSTED
	SA_EXISTED, SN_TRUSTED, SN_EXISTED, SPF_NOPASS, DKIM_NOPASS
	DMARC_NOPASS, CIE_BAD, CIE_GOOD, CIE_GOOD_SPF, GTI_FG_BS
	GTI_RG_INFO, GTI_C_BU, AMN_GOOD, ABX_MISS_RDNS
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:a8a367bd-781c-48fe-a36b-53cedefa1865,IP:15,
	URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-10
X-CID-INFO: VERSION:1.3.19,REQID:a8a367bd-781c-48fe-a36b-53cedefa1865,IP:15,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-10
X-CID-META: VersionHash:7db8b62,CLOUDID:890a2db5c5d2b456cd70ad6411d84326,BulkI
	D:260901113251RJE2V1R8,BulkQuantity:0,SF:10|38|66|78|102|127|136|850|865|8
	98,TC:nil,Content:0|15|50,EDM:-3|-100,IP:-2,URL:0,File:nil,RT:nil,Bulk:nil
	,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:
	0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: cd2d4f12a5b511f19a56ed5b684f684d-20260901
X-User: yijiangshan@kylinos.cn
Received: from localhost.localdomain [(116.128.244.171)] by mailgw.kylinos.cn
	(envelope-from <yijiangshan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 308339226; Tue, 01 Sep 2026 11:32:47 +0800
From: Jiangshan Yi <yijiangshan@kylinos.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org
Cc: hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	13667453960@163.com,
	Jiangshan Yi <yijiangshan@kylinos.cn>
Subject: [PATCH] x86/hyperv: Fix stale comments after stimer message mode removal
Date: Tue,  1 Sep 2026 11:32:01 +0800
Message-Id: <20260901033201.167219-1-yijiangshan@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The removal of stimer message mode in commit be0cfab740e5 ("clocksource:
hyper-v: Remove support for stimer interrupts in message mode") left a
few comments out of date. hv_stimer_setup_percpu_clockev() picked up two
typos ("afters", "to allows"), and the hv_synic_suspend() comment still
references the deleted hv_stimer_legacy_cleanup(), the legacy non-Direct
Mode configuration, and clockevents_unbind_device(), which is no longer
on the cleanup path.

Update the typos and rewrite the hv_synic_suspend() comment to describe
the current Direct Mode path: non-boot CPU stimers are cleaned up via
the cpuhp teardown callback hv_stimer_cleanup(), and CPU0's stimer is
left alone because it is harmless (interrupts stay disabled across the
suspend/resume window) and is shut down later by the timekeeping code.

Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 arch/x86/hyperv/hv_init.c |  4 ++--
 drivers/hv/vmbus_drv.c    | 18 +++++++-----------
 2 files changed, 9 insertions(+), 13 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 0b4a1c0b0b16..690f95295ee4 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -426,7 +426,7 @@ static void __init hv_stimer_setup_percpu_clockev(void)
 	int ret;
 
 	/*
-	 * Continue afters errors in setting up stimer clockevents
+	 * Continue after errors in setting up stimer clockevents
 	 * as we can run with the LAPIC timer as a fallback.
 	 */
 	ret = hv_stimer_alloc(false);
@@ -434,7 +434,7 @@ static void __init hv_stimer_setup_percpu_clockev(void)
 		pr_warn("stimer setup failed with error %d\n", ret);
 
 	/*
-	 * Still register the LAPIC timer to allows users
+	 * Still register the LAPIC timer to allow users
 	 * to switch to LAPIC timer via /sys, if they want to.
 	 */
 	if (old_setup_percpu_clockev)
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 5ebdbe24b5a1..c1edc3a5b673 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2923,23 +2923,19 @@ static void hv_crash_handler(struct pt_regs *regs)
 static int hv_synic_suspend(void *data)
 {
 	/*
-	 * When we reach here, all the non-boot CPUs have been offlined.
-	 * If we're in a legacy configuration where stimer Direct Mode is
-	 * not enabled, the stimers on the non-boot CPUs have been unbound
-	 * in hv_synic_cleanup() -> hv_stimer_legacy_cleanup() ->
-	 * hv_stimer_cleanup() -> clockevents_unbind_device().
+	 * When we reach here, all the non-boot CPUs have been offlined,
+	 * and their stimers have been cleaned up by the cpuhp teardown
+	 * callback hv_stimer_cleanup().
 	 *
 	 * hv_synic_suspend() only runs on CPU0 with interrupts disabled.
-	 * Here we do not call hv_stimer_legacy_cleanup() on CPU0 because:
-	 * 1) it's unnecessary as interrupts remain disabled between
-	 * syscore_suspend() and syscore_resume(): see create_image() and
+	 * The stimer on CPU0 is not explicitly cleaned up here because:
+	 * 1) it's harmless as interrupts remain disabled between
+	 * syscore_suspend() and syscore_resume(), so the stimer cannot
+	 * fire during this window: see create_image() and
 	 * resume_target_kernel()
 	 * 2) the stimer on CPU0 is automatically disabled later by
 	 * syscore_suspend() -> timekeeping_suspend() -> tick_suspend() -> ...
 	 * -> clockevents_shutdown() -> ... -> hv_ce_shutdown()
-	 * 3) a warning would be triggered if we call
-	 * clockevents_unbind_device(), which may sleep, in an
-	 * interrupts-disabled context.
 	 */
 
 	hv_hyp_synic_disable_regs(0);
-- 
2.25.1

