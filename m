Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74DFF37EFFB;
	Fri,  7 Aug 2026 13:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110752; cv=none; b=KyQdqkzhrckFsHQ3+97A9D8n3EY0z69Gc3id2gZ4XNf2QrpyqUTxLOQKhvpEObjMD24wzjTbQQgpmDnAjTqG44g5L1oAApf9TIH6Vzj6wqHNx6yvIEpeecFHTsEKsU/FZ357+DVSr4SDANlO68JOlp9gSsgnPK8gZOAAq236zik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110752; c=relaxed/simple;
	bh=frllaI5tsxgfp+bUAFqL0v4ITYGScd38bnMkMuOa4VE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qzStNsmbIAwCSo1CODVs2Fmk1ctcvGLhpbnAit+cE66kPsWq+7m/9C1QWJk+GbuC7fxxGj0u1poAN+T+0BoFeGylhU0YFVPB91sF/kUogr7zjWzCVlCfUyHi+5x6vNQ0qp6IAqfIHelnfLFR/P0nvqVIq0M4F+p8jLYqrAWmqSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MPSL9Jpt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MPSL9Jpt"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id C4CE620B712B;
	Fri,  7 Aug 2026 06:52:04 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4CE620B712B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110725;
	bh=01mdhBVpJHKCXHrK95ywSkUJgVZwzJ8UGAuHPxA8gU8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MPSL9JptpzYyDrI+iftRxT3N0nLyLG9TqUUr1upYrr0AOuiG9cT80vt6URXjHHhX+
	 2Ie/xlYL+qpcfNtcvtUX7u6BJiEfZq44Y9Kp8ww0J4LgfnTMepcyV4sR3OVLCmX2OD
	 s7z8Wk8Q1c3di2Ay23XqdG9pMdLA6Fqmt92VoHrw=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v1 08/13] mshv: accept partial CPU feature banks
Date: Fri,  7 Aug 2026 13:51:14 +0000
Message-ID: <20260807135134.303943-9-weh@linux.microsoft.com>
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

Allow userspace to provide fewer than MSHV_NUM_CPU_FEATURES_BANKS banks
for the create-partition v2 ioctl. Preserve the default disabled-feature
mask for omitted banks instead of rejecting the ioctl or overwriting all
banks.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 12 ++----------
 include/uapi/linux/mshv.h   |  3 ++-
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 11d3c86050b4..729916e1eacf 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2423,20 +2423,12 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
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
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 4e7f3038f0c6..6d6e0fda63bd 100644
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

