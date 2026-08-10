Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAEF03E3159;
	Mon, 10 Aug 2026 12:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365996; cv=none; b=jvGeN4IWIwW4A6dicZV9jfQxzx82MVJ+x/Jc2rHL5JkJa/9UXTcf4o0325DoEa878A7HPU7gORPE0hjWAKJ53s9YBvoD3WExAsnNeke7jkdkbkx2JFM/SJpscdI9Aw726rXUtJ3YhWKtT8aMMzpW+neLa1pgvJiWNGPiBzgO6sU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365996; c=relaxed/simple;
	bh=Fj4lgsx3+H+mFNG54emLfVY91uoq6KZAFFL/XqZB8pw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U32zQuYqsZwijkzPxg3Q/6uu8l4wEaWTA/Mq2TOOfPgXa3Qd1kVwZZAdjoHbSNttXccskaTOzgy0uoWXcBmuElALtlmITZ7P44RlFHggF2FiuWLZJE/T0FBsmAbndXexHYGYhMcuJHoB/hWfTQaIBqJqPkHSTs3pWsx+a4MBTXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=D2AKO+M1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="D2AKO+M1"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C535220B7166;
	Mon, 10 Aug 2026 05:46:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C535220B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365971;
	bh=zqrNqTs1+eAqb2sgsUe1q0PMATqHwR087hP9WLDwpI4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D2AKO+M1Ud8s6oxTn4/WvNHjxjGIuBgq5OMojvdQkIuTTlk2Ggyc9m60tLvRzFtRs
	 B9uMG4E01UwagWjQHqivquEQvVsN6qJuL1xyZotX0vIL5706ndA0P7q6EyMXUcua/t
	 8n/hBVLBs0b+ZSlO198nGWMsGSFj7fsgQEKyR3NI=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 09/13] mshv: define full processor and xsave feature masks
Date: Mon, 10 Aug 2026 12:45:03 +0000
Message-ID: <20260810124527.1409634-10-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810124527.1409634-1-weh@linux.microsoft.com>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
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
index 6b19cb66b0a1..c32d3375af8c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2451,11 +2451,21 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
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
-- 
2.43.0

