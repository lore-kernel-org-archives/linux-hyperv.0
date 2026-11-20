Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795140551;
	b=JqNsjRjNNmACXV4U9GisJpXGbP1eXduWRSw2FBF4uumKB2sNxVYsLVKR6FXymWkMdZJE
	 M6yZ5NJdhZWsbOJhXl42TyABHbXXOCTRSE+ohn7ZIcXRPmK3ntjJTNrsuPy6Iu2T7NOMf
	 xB+YfQfNmCW6CoP6OJMtAleXUxCZtAXlcBVpSHa8LpxE2wM35hZDT6rX09zeTWNfcJbZ8
	 Flx2kqWlOFWXUx/1WZ1hXMt3NC05kKNo5J8Cd3U1TinzdQ5nGBTo4+6AlP8IJ90eDlN2e
	 hB1+YEio8S0/zbYH6sTt5Wl3ZIKtH7e+azpu+J0LgYAZHQ3D35Rp7S6XwoV9vIbFkCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140551;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=IsznQ+W8USBqdSKWjTntNPMz3P8rM33hSjrj7RFAZmA=;
	b=ZxKvC23zcaNjlNzYRWq6YokskOPsOJakf0+KE5mUH92MgiYqRlFAHNbOqOs0hlaaOJwA
	 k5uFxFrEH5bKlVexV1PcRN04dQi9aNF6x5sfGUjRS/o/p7hZbkbo+PwzEkMpzGgS0bVeG
	 R111C++SQlrvpMnliy/w5BO+QMmPFX4Cu1jCpnthShlVD7UVuPzcRxsYDxua3wwfqgyS5
	 tnAPdGn7qA5OvKIQNF0VPfD3MXSLdcz60EKfAWlL0BISYDn0Hl4a1yNNwAFkpyyq+nfZH
	 3epLphQBvmWMQITImFOyVZjPnQT6SdNAy9OU/51MfBuHSII+KssNF+4wj2GPTOqtNWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="bos/bC4w";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2766606A320;
	Fri, 20 Nov 2026 02:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2766606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=bos/bC4w
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 29E3420B7166;
	Thu, 19 Nov 2026 18:09:08 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 29E3420B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795140548;
	bh=IsznQ+W8USBqdSKWjTntNPMz3P8rM33hSjrj7RFAZmA=;
	h=From:To:Cc:Subject:Date:From;
	b=bos/bC4wF4saSGQRJsyKl3PaF0Yoxz3ZJwZOwYNeJRg3U0yiWUj+X+0Jzq5IQYvNf
	 tQ7KdqomXyLTQMT8Dg9mqLftYl4Je07YpNhFaVp5mmMF5TceEmE4nNEdDo1mdvxQz5
	 xyFAWKwm8Oq3UZ7rOZXndFoVUHmitiAf6ZOfnd8c=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com
Subject: [PATCH] mshv: Handle completions on repeat hypercall failures
Date: Thu, 19 Nov 2026 18:08:58 -0800
Message-ID: <20261120020858.3597446-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
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

When a repeat hypercall fails, it could still have completed some of the
entries requested. Fix places where completions are not checked in case
of repeat hypercall failures. Also, add error prints in couple places
with correct partial completion counts when repeat hypercall fails.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_common.c       | 17 +++++++++++++----
 drivers/hv/mshv_root_hv_call.c | 15 +++++++++------
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 63f09bb5136e..580248a490ac 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -56,8 +56,6 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 
 		status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
 					     0, input_page, output_page);
-		if (!hv_result_success(status))
-			break;
 
 		completed = hv_repcomp(status);
 		for (i = 0; i < completed; ++i)
@@ -65,6 +63,13 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 
 		registers += completed;
 		remaining -= completed;
+
+		if (!hv_result_success(status)) {
+			pr_err("%s: count:%d comp:%d rem:%ld st:0x%llx\n",
+			       __func__, count, completed, remaining, status);
+			break;
+		}
+
 	}
 	local_irq_restore(flags);
 
@@ -99,12 +104,16 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 
 		status = hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
 					     0, input_page, NULL);
-		if (!hv_result_success(status))
-			break;
 
 		completed = hv_repcomp(status);
 		registers += completed;
 		remaining -= completed;
+
+		if (!hv_result_success(status)) {
+			pr_err("%s: count:%d comp:%d rem:%ld st:0x%llx\n",
+			       __func__, count, completed, remaining, status);
+			break;
+		}
 	}
 
 	local_irq_restore(flags);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index e761addda50e..6261686c3638 100644
--- a/drivers/hv/mshv_root_hv_call.c
+++ b/drivers/hv/mshv_root_hv_call.c
@@ -239,6 +239,7 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 		local_irq_restore(irq_flags);
 
 		completed = hv_repcomp(status);
+		done += completed;
 
 		if (hv_result_needs_memory(status)) {
 			ret = hv_deposit_memory(partition_id, status);
@@ -246,11 +247,13 @@ static int hv_do_map_gpa_hcall(u64 partition_id, u64 gfn, u64 page_struct_count,
 				break;
 
 		} else if (!hv_result_success(status)) {
+			pr_err("%s: failed to map pages at gfn %#llx: done %u/%llu, flags=%#x, status=%#llx (%s)\n",
+			       __func__, gfn, done, page_count, flags, status,
+			       hv_result_to_string(hv_result(status)));
+
 			ret = hv_result_to_errno(status);
 			break;
 		}
-
-		done += completed;
 	}
 
 	if (ret && done) {
@@ -358,18 +361,18 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 
 		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
 					     0, input_page, output_page);
-		if (!hv_result_success(status)) {
-			local_irq_restore(flags);
-			break;
-		}
 		completed = hv_repcomp(status);
 		for (i = 0; i < completed; ++i)
 			states[i].as_uint8 = output_page[i].as_uint8;
 
 		local_irq_restore(flags);
+
 		states += completed;
 		*written_total += completed;
 		remaining -= completed;
+
+		if (!hv_result_success(status))
+			break;
 	}
 
 	return hv_result_to_errno(status);
-- 
2.51.2.vfs.0.1

