Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794624799;
	b=2BSDkmHr5nRva6yQnxiMtLo1Pd8SRaS+Td3U9qG2F54RSe1M0Ve6XPAV1PtJj9cBtFgB
	 yfced6Cmf6bYs7YyPxGk5RY+dMFEpWvXH/Rqs+IcYY+L9MeePV55DReuXeAg13i6BCz51
	 uyw9/hatBQLp3pURopTPuuNwDYDUag49XMEqUyAx62U9aL+Q7anpe2yzdCcA4lAtvLe64
	 j6gLACHwA63vfVlMeAMJePdqkL+KyQ6IFhmbfAaO826MgRY3oqlPfTe22FEFBXljqlAZI
	 aZ45/OWpJWfQ4Zq8TRrBI1UQLRfMnPKk3a74cGuSMRszbDjRUIet1ozFVn/q2+IRRow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794624799;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=hV36Y+azplbaXTUBqR29nhOhm4MXiHGNJvyhVmF2NiE=;
	b=PmmMw1gViKm+NQTHunrqgAMd9SvMlPRRRRZ046WfO5ECsqsXVh+18UPw97j8dcgWqg6i
	 8Dmiu5VBTntWnZU9SWkbItJMhAIyTovWnTOGwKPOIX1HZV1RzTJ9phrNeCDdShnv6slP5
	 g/3HHRFATwqSmQTwHklpoUI/rp3BP/gv96FGznxedP9DNFI8UiiJtCiUh0GF8NVSw8Q13
	 Fb4tyItGsD1HeLzxQki6pg8dR5pZLyVDrTNnKDhiXF9YLDxN0IdhJ32CUo0yiZS+G0WXH
	 a9i7GGaah8NyxGlj32dOesxtScKD545NS6lQv+Nr5X/oUstNr8rhlyw/Fu5lnsB7unQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PLkTgGxk;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF73606A333;
	Sat, 14 Nov 2026 02:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF73606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=PLkTgGxk
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id D3AAB20B7168;
	Fri, 13 Nov 2026 18:53:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3AAB20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1794624793;
	bh=hV36Y+azplbaXTUBqR29nhOhm4MXiHGNJvyhVmF2NiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLkTgGxk1uExq8Dwow2eLCtj7lgSOPWXQthI75g61jKh2KKxQYj0KlfZM+fNlr55i
	 fnKLJTDoKUyvgcMxuUq4cr6+vMjz+XIZTqn230nfIVl5bC6I16xrjAIdLyhjxlxLpG
	 dUc+rbbXMzZHuN8dvyOuVOotrvSSvP2jvbVfRhac=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhkelley58@gmail.com,
	kameroncarr@linux.microsoft.com
Subject: [PATCH V1 2/2] Drivers: hv: Fix bugs and issues around repeat hypercall
Date: Fri, 13 Nov 2026 18:53:13 -0800
Message-ID: <20261114025313.1257042-3-mrathor@linux.microsoft.com>
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

There are few issues/bugs around repeat hypercall:
 o If the hypercall fails, it could still have processed some entries.
   Fix places where it assumes none of the entries were processed and will
   try to undo entries already processed or print incorrect completions.

 o Hypercall returns back with timeouts only for HW confidential VMs. In
   that case it should be retried instead of returning back. Returning back
   results in error conditions and take down of VMs in most cases.

 o For non confidential VMs, the hypercall could be streamlined as it will
   never return back with timeouts.

 o Rename HV_STATUS_TIME_OUT to HV_STATUS_TIMEOUT to match hypervisor
   public header file. There is no reason for it to be different.

 o Minor formatting fix for checkpatch. Error printing missing in couple
   places when rep hypercall fails.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/ivm.c          |  2 +-
 drivers/hv/hv_common.c         |  2 +-
 drivers/hv/mshv_common.c       | 19 +++++++----
 drivers/hv/mshv_root_hv_call.c | 21 +++++++-----
 drivers/hv/mshv_root_main.c    |  6 ++--
 include/asm-generic/mshyperv.h | 60 ++++++++++++++++++++++++----------
 include/hyperv/hvgdk_mini.h    |  2 +-
 7 files changed, 75 insertions(+), 37 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 26e570cf77be..742f6399ecf6 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -365,7 +365,7 @@ int hv_snp_boot_ap(u32 apic_id, unsigned long start_ip, unsigned int cpu)
 	do {
 		ret = hv_do_hypercall(HVCALL_START_VP,
 				      start_vp_input, NULL);
-	} while (hv_result(ret) == HV_STATUS_TIME_OUT && retry--);
+	} while (hv_result(ret) == HV_STATUS_TIMEOUT && retry--);
 
 	local_irq_restore(flags);
 
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index b537cafdc2a2..db3c0c571e9e 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -835,7 +835,7 @@ static const struct hv_status_info hv_status_infos[] = {
 	_STATUS_INFO(HV_STATUS_INVALID_REGISTER_VALUE,		-EINVAL),
 	_STATUS_INFO(HV_STATUS_DEVICE_ALREADY_IN_DOMAIN,	-EEXIST),
 	_STATUS_INFO(HV_STATUS_OPERATION_FAILED,		-EIO),
-	_STATUS_INFO(HV_STATUS_TIME_OUT,			-EIO),
+	_STATUS_INFO(HV_STATUS_TIMEOUT,				-EIO),
 	_STATUS_INFO(HV_STATUS_CALL_PENDING,			-EIO),
 	_STATUS_INFO(HV_STATUS_VTL_ALREADY_ENABLED,		-EIO),
 #undef _STATUS_INFO
diff --git a/drivers/hv/mshv_common.c b/drivers/hv/mshv_common.c
index 63f09bb5136e..606f86673d51 100644
--- a/drivers/hv/mshv_common.c
+++ b/drivers/hv/mshv_common.c
@@ -56,16 +56,20 @@ int hv_call_get_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 
 		status = hv_do_rep_hypercall(HVCALL_GET_VP_REGISTERS, rep_count,
 					     0, input_page, output_page);
-		if (!hv_result_success(status))
-			break;
-
 		completed = hv_repcomp(status);
 		for (i = 0; i < completed; ++i)
 			registers[i].value = output_page[i];
 
 		registers += completed;
 		remaining -= completed;
+
+		if (!hv_result_success(status)) {
+			pr_err("%s: count:%d comp:%d st:0x%llx\n", __func__,
+			       count, completed, status);
+			break;
+		}
 	}
+
 	local_irq_restore(flags);
 
 	return hv_result_to_errno(status);
@@ -99,12 +103,15 @@ int hv_call_set_vp_registers(u32 vp_index, u64 partition_id, u16 count,
 
 		status = hv_do_rep_hypercall(HVCALL_SET_VP_REGISTERS, rep_count,
 					     0, input_page, NULL);
-		if (!hv_result_success(status))
-			break;
-
 		completed = hv_repcomp(status);
 		registers += completed;
 		remaining -= completed;
+
+		if (!hv_result_success(status)) {
+			pr_err("%s: count:%d comp:%d st:0x%llx\n", __func__,
+			       count, completed, status);
+			break;
+		}
 	}
 
 	local_irq_restore(flags);
diff --git a/drivers/hv/mshv_root_hv_call.c b/drivers/hv/mshv_root_hv_call.c
index e761addda50e..010b5060b272 100644
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
@@ -356,20 +359,22 @@ int hv_call_get_gpa_access_states(u64 partition_id, u32 count, u64 gpa_base_pfn,
 		input_page->flags = state_flags;
 		rep_count = min(remaining, HV_GET_GPA_ACCESS_STATES_BATCH_SIZE);
 
-		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES, rep_count,
-					     0, input_page, output_page);
-		if (!hv_result_success(status)) {
-			local_irq_restore(flags);
-			break;
-		}
+		status = hv_do_rep_hypercall(HVCALL_GET_GPA_PAGES_ACCESS_STATES,
+					     rep_count, 0, input_page,
+					     output_page);
+
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
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cc2cfce2aefd..dfb24599c257 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -231,9 +231,9 @@ static int mshv_ioctl_passthru_hvcall(struct mshv_partition *partition,
 	reps_completed = 0;
 	do {
 		if (args.reps) {
-			status = hv_do_rep_hypercall_ex(args.code, args.reps,
-							0, reps_completed,
-							input_pg, output_pg);
+			status = hv_do_rep_hypercall_reg(args.code, args.reps,
+							 0, reps_completed,
+							 input_pg, output_pg);
 			reps_completed = hv_repcomp(status);
 		} else {
 			status = hv_do_hypercall(args.code, input_pg, output_pg);
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 396bcb3db0bc..87c784b9daa6 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -28,6 +28,9 @@
 
 #define VTPM_BASE_ADDRESS 0xfed40000
 
+#define HV_REP_COUNT_MAX	\
+	(HV_HYPERCALL_REP_COMP_MASK >> HV_HYPERCALL_REP_COMP_OFFSET)
+
 enum hv_partition_type {
 	HV_PARTITION_TYPE_GUEST,
 	HV_PARTITION_TYPE_ROOT,
@@ -128,6 +131,11 @@ static inline bool hv_result_success(u64 status)
 	return hv_result(status) == HV_STATUS_SUCCESS;
 }
 
+static inline bool hv_result_timeout(u64 status)
+{
+	return hv_result(status) == HV_STATUS_TIMEOUT;
+}
+
 static inline unsigned int hv_repcomp(u64 status)
 {
 	/* Bits [43:32] of status have 'Reps completed' data. */
@@ -135,45 +143,63 @@ static inline unsigned int hv_repcomp(u64 status)
 			 HV_HYPERCALL_REP_COMP_OFFSET;
 }
 
-/*
- * Rep hypercalls. Callers of this functions are supposed to ensure that
- * rep_count, varhead_size, and rep_start comply with Hyper-V hypercall
- * definition.
- */
-static inline u64 hv_do_rep_hypercall_ex(u16 code, u16 rep_count,
-					 u16 varhead_size, u16 rep_start,
-					 void *input, void *output)
+static inline u64 hv_do_rep_hypercall_reg(u16 code, u16 rep_count,
+					  u16 varhead_size, u16 rep_start,
+					  void *input, void *output)
 {
 	u64 control = code;
-	u64 status;
-	u16 rep_comp;
 
 	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
 	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
 	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
 
-	do {
+	return hv_do_hypercall(control, input, output);
+}
+
+static inline u64 hv_do_rep_hypercall_cvm(u16 code, u16 rep_count,
+					  u16 varhead_size, u16 rep_start,
+					  void *input, void *output)
+{
+	u64 status, control = code;
+	u16 rep_comp = 0;
+
+	control |= (u64)varhead_size << HV_HYPERCALL_VARHEAD_OFFSET;
+	control |= (u64)rep_count << HV_HYPERCALL_REP_COMP_OFFSET;
+	control |= (u64)rep_start << HV_HYPERCALL_REP_START_OFFSET;
+
+	for (;;) {
 		status = hv_do_hypercall(control, input, output);
-		if (!hv_result_success(status))
+
+		if (!hv_result_timeout(status))
 			return status;
 
 		rep_comp = hv_repcomp(status);
-
 		control &= ~HV_HYPERCALL_REP_START_MASK;
 		control |= (u64)rep_comp << HV_HYPERCALL_REP_START_OFFSET;
 
 		touch_nmi_watchdog();
-	} while (rep_comp < rep_count);
+	}
 
 	return status;
 }
 
-/* For the typical case where rep_start is 0 */
+/*
+ * Rep hypercalls for HW confidential VMs return back when timeouts occur,
+ * whereas for regular VMs they return only on success or failure. In case
+ * of successful completion, entire rep_count is done. But a hypercall could
+ * fail with partial completions, hence callers must always check that
+ * in case of failure. Lastly, a rep_count value of 0 is allowed for some
+ * hypercalls.
+ */
 static inline u64 hv_do_rep_hypercall(u16 code, u16 rep_count, u16 varhead_size,
 				      void *input, void *output)
 {
-	return hv_do_rep_hypercall_ex(code, rep_count, varhead_size, 0,
-				      input, output);
+	if (hv_isolation_type_hw())
+		return hv_do_rep_hypercall_cvm(code, rep_count, varhead_size, 0,
+					       input, output);
+	else
+		return hv_do_rep_hypercall_reg(code, rep_count, varhead_size, 0,
+					       input, output);
 }
 
 /* Generate the guest OS identifier as described in the Hyper-V TLFS */
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index 966945f0504f..bec4e633e381 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -41,7 +41,7 @@ struct hv_u128 {
 #define HV_STATUS_OPERATION_FAILED			0x71
 #define HV_STATUS_INSUFFICIENT_ROOT_MEMORY		0x73
 #define HV_STATUS_INSUFFICIENT_CONTIGUOUS_MEMORY	0x75
-#define HV_STATUS_TIME_OUT				0x78
+#define HV_STATUS_TIMEOUT				0x78
 #define HV_STATUS_CALL_PENDING				0x79
 #define HV_STATUS_INSUFFICIENT_CONTIGUOUS_ROOT_MEMORY	0x83
 #define HV_STATUS_VTL_ALREADY_ENABLED			0x86
-- 
2.51.2.vfs.0.1

