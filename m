Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A73E2754;
	Mon, 10 Aug 2026 12:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365993; cv=none; b=id5CsW6cnXG/+EmHftcm1SmUVZuOdxGcoQgpnvxuWNBoM5x1BIpjQse9LYurEFL/bG7LvwMQvRL5fQe7xvzlPIBkZdk5+MRjP1WSHTVlnfPBCxAwLpBt/r0tVK0tijqArtjxLRRy4h+bBXgJTINAqwznTXxVNRIi+T+ksFQhll0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365993; c=relaxed/simple;
	bh=QgOYcwciW8Gsn1hM1aHkKpIXEjb0U1jQSBk6/eAGQjg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JBPMZB5YIjFmMHAFJ3la8wgczv+35hDuyj7YvZJCbZwCRwGO+uvAswvJKA+k8j2cUoER4iMgpfAihv/GG3/PzmP7wXnZPynsxdmSqEu9L1Jslr8j7nytSm6/+mYbqmzsHOqc1NFE3NsEUBAq3fBFTe1xixiT8W7Se0SF5w2iRNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qGfWVUtO; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qGfWVUtO"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 87F1F20B7166;
	Mon, 10 Aug 2026 05:46:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87F1F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365968;
	bh=xwWU8C726oKxRIwJcGQojGBKeu+EWeXPX4l6vn6Cpvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGfWVUtOlVB1efDwQSWYKlZmmwEsnKz8dNOmSrrnq8dBQ9IIbQLpqKRtwOYvWhL5F
	 ZpeUNPyWFvBiHisuoxVYvY4sPgNzLDILX4hF8ayuKdX/3TT1eDSl80/0AOXRMIQqZn
	 CJSk1nyDy620zQ2sbN4cF4S0SWp3gL8t7IlSD5KY=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 08/13] mshv: accept partial CPU feature banks
Date: Mon, 10 Aug 2026 12:45:02 +0000
Message-ID: <20260810124527.1409634-9-weh@linux.microsoft.com>
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
index ad2e708fd753..6b19cb66b0a1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2473,20 +2473,12 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
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
index fc89f6c9a968..452297b88484 100644
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

