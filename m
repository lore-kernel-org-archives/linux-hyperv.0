Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1910432939C;
	Fri,  7 Aug 2026 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110761; cv=none; b=UjN2pdqyVewFqt6FykGh3hke8qSf0oEx+rs8UO7/b1vuAVxU/uFC3AQqjDE6jEYXhRrRRDUcnI0vG+ab0cgS6HRj1RKnxX09jK+eLRwhglFtfYIJGrVPO6hrpkbFjE3Mj9S5lqcaw5JOY3uveVDsUJMShMXYFY8jGUZnnAGzkH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110761; c=relaxed/simple;
	bh=v4KFckFBBPYfL51s8LkO2ZShnraIJEbTVORl/VPRGno=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wh3E8rg283FjJNT9MQJhu7UKd3x98GG7elhBzN3jljMpbE30Xu+TVl4B2uXlhv2e5eHadrBK5AWzOAdjEZmG4xVLqNrI9L0S76oRoDrqmFyFMYIt1P3NkjGPoJdD3vESwpQ8K01BLtFEqNuKXoHNIZjdI002lcujb3hS3neHSv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G3eBYOet; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G3eBYOet"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6B19720B712D;
	Fri,  7 Aug 2026 06:52:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B19720B712D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110727;
	bh=bDSrWqRq3L/ET1o4qoG5zJ5wg05PvC6Bl7EIlf8Vx+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=G3eBYOetvWvZScrCEV7LXR58OQZlCKf3FToRbSyl31h5InM6aeE5sGyXD0noQGhEt
	 WEEDzziKL1NlIkVWYWW5LcEK1osb2vLJQN7UpYonOj5pqJIVuCC2ss8d3bf8XCB4GV
	 DaPAbJ2UZeZMuLaz6erQHvVIkMRDp/q2kT/7nY5A=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v1 09/13] mshv: define full processor and xsave feature masks
Date: Fri,  7 Aug 2026 13:51:15 +0000
Message-ID: <20260807135134.303943-10-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807135134.303943-1-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Add the missing processor and xsave feature bit definitions and use
them when constructing the default disabled-feature mask, so legacy
SNP partition creation applies a complete, well-defined feature mask.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 10 +++++
 include/hyperv/hvhdk.h      | 79 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 729916e1eacf..c81a8d0493c1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2406,11 +2406,21 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 	disabled_procs->cet_ss_support = 0;
 	disabled_procs->cet_ibt_support = 0;
 	disabled_procs->vmx_exception_inject_support = 0;
+	disabled_procs->fb_clear_support = 0;
+	disabled_procs->gds_no_support = 0;
+	disabled_procs->bhi_no_support = 0;
+	disabled_procs->bhi_dis_support = 0;
+	disabled_procs->btc_no_support = 0;
+	disabled_procs->mitigation_ctrl_support = 0;
+	disabled_procs->rfds_no_support = 0;
+	disabled_procs->rfds_clear_support = 0;
 
 	disabled_xsave->as_uint64 = U64_MAX;
 	disabled_xsave->xsave_support = 0;
 	disabled_xsave->xsaveopt_support = 0;
 	disabled_xsave->avx_support = 0;
+	disabled_xsave->xsave_comp_support = 0;
+	disabled_xsave->xsave_supervisor_support = 0;
 #endif
 
 	/* Check if user provided newer struct with feature fields */
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 691ac495a095..54b0e671a028 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -231,7 +231,47 @@ union hv_partition_processor_features {
 		u64 fzlrep_movsb : 1;
 		u64 fsrep_stosb : 1;
 		u64 fsrep_cmpsb : 1;
-		u64 reserved_bank1 : 42;
+		u64 tsx_ld_trk_support : 1;
+		u64 vmx_ins_outs_exit_info_support : 1;
+		u64 hlat_support : 1;
+		u64 sbdr_ssdp_no_support : 1;
+		u64 fbsdp_no_support : 1;
+		u64 psdp_no_support : 1;
+		u64 fb_clear_support : 1;
+		u64 btc_no_support : 1;
+		u64 ibpb_rsb_flush_support : 1;
+		u64 stibp_always_on_support : 1;
+		u64 perf_global_ctrl_support : 1;
+		u64 npt_execute_only_support : 1;
+		u64 npt_ad_flags_support : 1;
+		u64 npt1_gb_page_support : 1;
+		u64 amd_processor_topology_node_id_support : 1;
+		u64 local_machine_check_support : 1;
+		u64 extended_topology_leaf_fp256_amd_support : 1;
+		u64 gds_no_support : 1;
+		u64 cmpccxadd_support : 1;
+		u64 tsc_aux_virtualization_support : 1;
+		u64 rmp_query_support : 1;
+		u64 bhi_no_support : 1;
+		u64 bhi_dis_support : 1;
+		u64 prefetch_i_support : 1;
+		u64 sha512_support : 1;
+		u64 mitigation_ctrl_support : 1;
+		u64 rfds_no_support : 1;
+		u64 rfds_clear_support : 1;
+		u64 sm3_support : 1;
+		u64 sm4_support : 1;
+		u64 secure_avic_support : 1;
+		u64 guest_intercept_ctrl_support : 1;
+		u64 sbpb_supported : 1;
+		u64 ibpb_br_type_supported : 1;
+		u64 srso_no_supported : 1;
+		u64 srso_user_kernel_no_supported : 1;
+		u64 vrew_clear_supported : 1;
+		u64 tsa_l1_no_supported : 1;
+		u64 tsa_sq_no_supported : 1;
+		u64 lass_support : 1;
+		u64 reserved_bank1 : 2;
 	} __packed;
 };
 
@@ -240,7 +280,42 @@ union hv_partition_processor_xsave_features {
 		u64 xsave_support : 1;
 		u64 xsaveopt_support : 1;
 		u64 avx_support : 1;
-		u64 reserved1 : 61;
+		u64 avx2_support : 1;
+		u64 fma_support : 1;
+		u64 mpx_support : 1;
+		u64 avx512_support : 1;
+		u64 avx512_dq_support : 1;
+		u64 avx512_cd_support : 1;
+		u64 avx512_bw_support : 1;
+		u64 avx512_vl_support : 1;
+		u64 xsave_comp_support : 1;
+		u64 xsave_supervisor_support : 1;
+		u64 xcr1_support : 1;
+		u64 avx512_bitalg_support : 1;
+		u64 avx512_i_fma_support : 1;
+		u64 avx512_v_bmi_support : 1;
+		u64 avx512_v_bmi2_support : 1;
+		u64 avx512_vnni_support : 1;
+		u64 gfni_support : 1;
+		u64 vaes_support : 1;
+		u64 avx512_v_popcntdq_support : 1;
+		u64 vpclmulqdq_support : 1;
+		u64 avx512_bf16_support : 1;
+		u64 avx512_vp2_intersect_support : 1;
+		u64 avx512_fp16_support : 1;
+		u64 xfd_support : 1;
+		u64 amx_tile_support : 1;
+		u64 amx_bf16_support : 1;
+		u64 amx_int8_support : 1;
+		u64 avx_vnni_support : 1;
+		u64 avx_ifma_support : 1;
+		u64 avx_ne_convert_support : 1;
+		u64 avx_vnni_int8_support : 1;
+		u64 avx_vnni_int16_support : 1;
+		u64 avx10_1_256_support : 1;
+		u64 avx10_1_512_support : 1;
+		u64 amx_fp16_support : 1;
+		u64 reserved1 : 26;
 	} __packed;
 	u64 as_uint64;
 };
-- 
2.43.0

