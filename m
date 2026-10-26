Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024130;
	b=c+ZCFdrObcdiamVHMN1FM8gCL3XAK5qVG8N6Uc8m6UEGsFqjTdRVEXj128sjBEGNTV4R
	 ZzcnGwq0GrvDSD2wJ7Khw1CukGycYqGbrY6yMQHbNbqmFRKFq7a/HnaXGRK4NxfMxswt+
	 KgKfHJnRvzTb1cGrYYfKaYyRagTAEUwIBfiS5rMGnciPwa7urJLSdqis+A4Nyc4JUskps
	 SLmDlp+H9iuN52i10Y+FmEdySV4m29qVSCTTmY+cqRSLnD4ac1eIl+aS/HpQnBd1LuDMn
	 UvNlU8UokX/mlO+vmjzpErhSS5CFAVHy6ntrDNqJqBoUpyzVwDfAnprivp4bLxhNNig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024130;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=cW4LsUrPIToIGhubGLm2kj60ZqrcFbjczsanGf+HKRE=;
	b=gHVHRbkbtriEBHFMGSAqfxawWWPd4lxRPa6S5jpaatb292bMZkixboMLG18o1tUl4+TZ
	 a2rD070WX5/wKSXUJS5PDU1GbiCG/RHirePWD/yulDzX5rSaMUHB/5v4SL2dF4hdx/1g4
	 aRmC+T14Shx5VLxNXMk3AMvahjDgCwbB+aL0ovJTAGCopZetBQSVobx+ZjOa/IePNN37p
	 oWNH+3g8xmq9w8MYp6iiCKjs0FBnNwpZMClC9Yf5FTzTEv9D/UeFwMYwfDb4gE0sGrWQW
	 F3Tk4VP7G/k6qil+FmmdZp1QR+4Bw/5m8fOcHlrk6VZyfMyzge5jmgC3Fb6lnt8zvvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b="TutsEO/w";
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AF9606A32A;
	Mon, 26 Oct 2026 14:15:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74AF9606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TutsEO/w
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2F12920B716D;
	Mon, 26 Oct 2026 07:15:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2F12920B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793024118;
	bh=cW4LsUrPIToIGhubGLm2kj60ZqrcFbjczsanGf+HKRE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TutsEO/wG3ZQClf4ASpd7J2btlBlH4/5/mxW/fcQaxTdiAu9CzXmo8ZLp8qP/DYnS
	 jcBqdepfMCWR5ZR7vKPXyQEDpsv1wa6upc0nvMjN8Q478fRvE5Ih4kq/oMRaOIu24B
	 kDkuu0+YXhGgU+E8M9o+eM5szwyLHNYCS8g1BzOM=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	weh@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v8 8/9] mshv: use safe partition CPU feature defaults
Date: Mon, 26 Oct 2026 14:14:55 +0000
Message-ID: <20261026141512.2987985-9-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026141512.2987985-1-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
 <20261026141512.2987985-1-weh@linux.microsoft.com>
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

From: Wei Liu <wei.liu@kernel.org>

Initialize the complete partition creation properties and build a
conservative x86 disabled-feature mask for legacy callers. Enable only
the default processor and XSAVE features known to be supported, while
preserving nested virtualization when the caller requests it.

Allow extended callers to provide a partial set of processor-feature
banks and retain safe defaults for omitted banks. Define the full
processor and XSAVE feature masks used by the defaults.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 123 ++++++++++++++++++++++++++++++------
 include/hyperv/hvhdk.h      |  79 ++++++++++++++++++++++-
 include/uapi/linux/mshv.h   |   3 +-
 3 files changed, 181 insertions(+), 24 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 4678fa4eeef2..170104af28c1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2973,33 +2973,124 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 	    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 		return -EINVAL;
 
+	memset(cr_props, 0, sizeof(*cr_props));
+	memset(isol_props, 0, sizeof(*isol_props));
 	disabled_procs = &cr_props->disabled_processor_features;
 	disabled_xsave = &cr_props->disabled_processor_xsave_features;
 
+#if IS_ENABLED(CONFIG_X86_64)
+	/* Disable all processor features first. */
+	for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
+		disabled_procs->as_uint64[i] = U64_MAX;
+
+	/* Enable default features that are known to be supported. */
+	disabled_procs->sse3_support = 0;
+	disabled_procs->lahf_sahf_support = 0;
+	disabled_procs->ssse3_support = 0;
+	disabled_procs->sse4_1_support = 0;
+	disabled_procs->sse4_2_support = 0;
+	disabled_procs->sse4a_support = 0;
+	disabled_procs->xop_support = 0;
+	disabled_procs->pop_cnt_support = 0;
+	disabled_procs->cmpxchg16b_support = 0;
+	disabled_procs->altmovcr8_support = 0;
+	disabled_procs->lzcnt_support = 0;
+	disabled_procs->mis_align_sse_support = 0;
+	disabled_procs->mmx_ext_support = 0;
+	disabled_procs->amd3dnow_support = 0;
+	disabled_procs->extended_amd3dnow_support = 0;
+	disabled_procs->page_1gb_support = 0;
+	disabled_procs->aes_support = 0;
+	disabled_procs->pclmulqdq_support = 0;
+	disabled_procs->pcid_support = 0;
+	disabled_procs->fma4_support = 0;
+	disabled_procs->f16c_support = 0;
+	disabled_procs->rd_rand_support = 0;
+	disabled_procs->rd_wr_fs_gs_support = 0;
+	disabled_procs->smep_support = 0;
+	disabled_procs->enhanced_fast_string_support = 0;
+	disabled_procs->bmi1_support = 0;
+	disabled_procs->bmi2_support = 0;
+	disabled_procs->hle_support_deprecated = 0;
+	disabled_procs->rtm_support_deprecated = 0;
+	disabled_procs->movbe_support = 0;
+	disabled_procs->npiep1_support = 0;
+	disabled_procs->dep_x87_fpu_save_support = 0;
+	disabled_procs->rd_seed_support = 0;
+	disabled_procs->adx_support = 0;
+	disabled_procs->intel_prefetch_support = 0;
+	disabled_procs->smap_support = 0;
+	disabled_procs->hle_support = 0;
+	disabled_procs->rtm_support = 0;
+	disabled_procs->rdtscp_support = 0;
+	disabled_procs->clflushopt_support = 0;
+	disabled_procs->invpcid_support = 0;
+	disabled_procs->ibrs_support = 0;
+	disabled_procs->stibp_support = 0;
+	disabled_procs->ibpb_support = 0;
+	disabled_procs->unrestricted_guest_support = 0;
+	disabled_procs->mdd_support = 0;
+	disabled_procs->fast_short_rep_mov_support = 0;
+	disabled_procs->l1dcache_flush_support = 0;
+	disabled_procs->rdcl_no_support = 0;
+	disabled_procs->ibrs_all_support = 0;
+	disabled_procs->skip_l1df_support = 0;
+	disabled_procs->ssb_no_support = 0;
+	disabled_procs->rsb_a_no_support = 0;
+	disabled_procs->virt_spec_ctrl_support = 0;
+	disabled_procs->rd_pid_support = 0;
+	disabled_procs->umip_support = 0;
+	disabled_procs->mbs_no_support = 0;
+	disabled_procs->mb_clear_support = 0;
+	disabled_procs->taa_no_support = 0;
+	disabled_procs->tsx_ctrl_support = 0;
+	disabled_procs->tsc_invariant_support = 0;
+	disabled_procs->rdpru_support = 0;
+	disabled_procs->mbec_support = 0;
+	disabled_procs->psfd_support = 0;
+	disabled_procs->cet_ss_support = 0;
+	disabled_procs->cet_ibt_support = 0;
+	disabled_procs->vmx_exception_inject_support = 0;
+	if (args.pt_flags & BIT(MSHV_PT_BIT_NESTED_VIRTUALIZATION))
+		disabled_procs->nested_virt_support = 0;
+	disabled_procs->fb_clear_support = 0;
+	disabled_procs->gds_no_support = 0;
+	disabled_procs->bhi_no_support = 0;
+	disabled_procs->bhi_dis_support = 0;
+	disabled_procs->btc_no_support = 0;
+	disabled_procs->mitigation_ctrl_support = 0;
+	disabled_procs->rfds_no_support = 0;
+	disabled_procs->rfds_clear_support = 0;
+
+	disabled_xsave->as_uint64 = U64_MAX;
+	disabled_xsave->xsave_support = 0;
+	disabled_xsave->xsaveopt_support = 0;
+	disabled_xsave->avx_support = 0;
+	disabled_xsave->xsave_comp_support = 0;
+	disabled_xsave->xsave_supervisor_support = 0;
+#endif
+
 	/* Check if user provided newer struct with feature fields */
 	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES)) {
+		u64 pt_flags = args.pt_flags;
+		u64 pt_isolation = args.pt_isolation;
+
 		if (copy_from_user(&args, user_arg, sizeof(args)))
 			return -EFAULT;
 
-		/* Re-validate v1 fields after second copy_from_user() */
+		if (args.pt_flags != pt_flags ||
+		    args.pt_isolation != pt_isolation)
+			return -EAGAIN;
 		if ((args.pt_flags & ~MSHV_PT_FLAGS_MASK) ||
 		    args.pt_isolation >= MSHV_PT_ISOLATION_COUNT)
 			return -EINVAL;
 
-		if (args.pt_num_cpu_fbanks != MSHV_NUM_CPU_FEATURES_BANKS ||
+		if (args.pt_num_cpu_fbanks > MSHV_NUM_CPU_FEATURES_BANKS ||
 		    mshv_field_nonzero(args, pt_rsvd) ||
 		    mshv_field_nonzero(args, pt_rsvd1))
 			return -EINVAL;
 
-		/*
-		 * Note this assumes MSHV_NUM_CPU_FEATURES_BANKS will never
-		 * change and equals HV_PARTITION_PROCESSOR_FEATURES_BANKS
-		 * (i.e. 2).
-		 *
-		 * Further banks (index >= 2) will be modifiable as 'early'
-		 * properties via the set partition property hypercall.
-		 */
-		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
+		for (i = 0; i < args.pt_num_cpu_fbanks; i++)
 			disabled_procs->as_uint64[i] = args.pt_cpu_fbanks[i];
 
 #if IS_ENABLED(CONFIG_X86_64)
@@ -3014,16 +3105,6 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 		if (mshv_field_nonzero(args, pt_rsvd2))
 			return -EINVAL;
 #endif
-	} else {
-		/*
-		 * v1 behavior: try to enable everything. The hypervisor will
-		 * disable features that are not supported. The banks can be
-		 * queried via the get partition property hypercall.
-		 */
-		for (i = 0; i < HV_PARTITION_PROCESSOR_FEATURES_BANKS; i++)
-			disabled_procs->as_uint64[i] = 0;
-
-		disabled_xsave->as_uint64 = 0;
 	}
 
 	/* Only support EXO partitions */
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 691ac495a095..c8c0aca48f4e 100644
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
+		u64 verw_clear_supported : 1;
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
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 6ae2ea3e2624..4136399d318e 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -66,7 +66,8 @@ struct mshv_create_partition {
  * This is extended version of the above initial MSHV_CREATE_PARTITION
  * ioctl and allows for following additional parameters:
  *
- * @pt_num_cpu_fbanks: Must be set to MSHV_NUM_CPU_FEATURES_BANKS.
+ * @pt_num_cpu_fbanks: Number of processor feature banks provided. Must not
+ *                     exceed MSHV_NUM_CPU_FEATURES_BANKS.
  * @pt_cpu_fbanks: Disabled processor feature banks array.
  * @pt_disabled_xsave: Disabled xsave feature bits.
  *
-- 
2.43.0

