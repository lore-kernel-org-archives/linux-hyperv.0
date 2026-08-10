Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566393DBD48;
	Mon, 10 Aug 2026 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365991; cv=none; b=eT95VMwMGeqoxfhsN+MKz3hTQGl2jysjZLg9HjOfdK6vlX5gUNNNg4ITdZ6+VJTxbnYHGvNx80oXl1qr3yerf4AWpJKSBK13kcz9yWbZytnaDVaqJzwDrec5XpmtawimI4UnpQNQUY66ubB5ym45JGObrLl8eKq0P2vdjT6zAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365991; c=relaxed/simple;
	bh=VlXvCrU5xXp1MR5l1rxHjGNQ5R8YI9XL8rvB3SVGm2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XQRlrzKpR3Yw+jS6V0YfGRnuORupy++hTEBMoheZoK0abuqDF+VAiiNB/YsGWOjz8gfODKTgny7nwrj2TIS2aYBxyIMyHXLgV+l1xEIOVizcqVRQGKuzcV76FTxApy6YrmZzBsOA+sU7F7b7OozHbTtYKkgBudCb36o3izAoUeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=fr/im0LO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="fr/im0LO"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3FD3520B7167;
	Mon, 10 Aug 2026 05:46:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3FD3520B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365966;
	bh=MS6COCto6gFf+Ze8TiGIHPpH6gg6TsffiJN23fQ7rtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fr/im0LOEfIEHZLGNd1B4XgnVCZJch2bvNmhtvaxdMPvvdE473Uu7BuaWCfcXJehh
	 1ZZul4VYLDF1mt94tXcGzsoFuUpQthCwQPm+a5EZPH1+juvJtSDFgtmEnzrF1RbpuE
	 dn2RocaXh4LfPMZgtAXAhxNtHogVm4SO9mKZYEuU=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 07/13] mshv: default to safe partition CPU features
Date: Mon, 10 Aug 2026 12:45:01 +0000
Message-ID: <20260810124527.1409634-8-weh@linux.microsoft.com>
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

For legacy create-partition callers, disable all processor and xsave
features first, then enable only the default feature set known to be
supported. Passing an all-zero disabled feature mask can make SEV-SNP
partition creation fail on Hyper-V.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 99 ++++++++++++++++++++++++++++++++-----
 1 file changed, 88 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 712f45dcef60..ad2e708fd753 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2373,15 +2373,102 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
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
+
+	disabled_xsave->as_uint64 = U64_MAX;
+	disabled_xsave->xsave_support = 0;
+	disabled_xsave->xsaveopt_support = 0;
+	disabled_xsave->avx_support = 0;
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
@@ -2414,16 +2501,6 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
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
-- 
2.43.0

