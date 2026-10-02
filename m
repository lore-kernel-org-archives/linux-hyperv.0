Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7221347532;
	Fri,  2 Oct 2026 21:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790978335; cv=none; b=GGnp003pAEEsZEdB4KpdoPnVjAzFEGVihlULR+bydgPAXkgU1X2ebjnk4kwPMq9qp+gC+m5s/bSKhmdvgSVc7UypiQnxCKbGJiaIiBYSO0KKhmrr+jjjZ7vlBamcdAJYsspRhwKJYuQuQaBY/JJDSFMboZMj3yq9V/a1M16cgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790978335; c=relaxed/simple;
	bh=NcSm62QL2a7N38s/PkT6XVxHWnG1B77dTXCMjFS8c3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFv+8i4sJ/qO4M9Vv0G3T2Nrl/Ne7noWa2Lsh4snJqucxQ+FyGz3JYlY8O5O8Aj8WP0vmeVSbdGXUT0Y+oUypeTPUqXFs8a3E9wyWN9fsTl93UstIM96sZNCr2mpvKVAy6sld4sXGxUrvNbuDT5xL1q5P44LA37QTUCJvrS5yzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=L5cooXtF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="L5cooXtF"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 266CF20B7167;
	Fri,  2 Oct 2026 14:57:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 266CF20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790978279;
	bh=F0MO/r8a7BDsMhBk/mJgC+1OZlbLoLJX/Mq8zb5p8N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L5cooXtFHHEbx0Yq3pMULm2K0JV1BhknCj++bHbEg4W48WegjpitGnDYaVs1Y2YQ+
	 bXUZPdIkr+2+LSULNM/AU4UizUUtWDRmXdrC6VeteAmgsxxH+WgFsR0DK6Uuw28aGQ
	 0wgsrNiXoLw9IM7KbzyW+aEUswETZxugGtLnjKeg=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mark.rutland@arm.com,
	lpieralisi@kernel.org,
	sudeep.holla@kernel.org,
	arnd@arndb.de,
	thuth@redhat.com,
	linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: [PATCH v5 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Fri,  2 Oct 2026 14:57:20 -0700
Message-ID: <20261002215725.2015959-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct rsi_host_call to arm-smccc-rsi.h, which represents the host
call data structure used by the Realm Management Monitor (RMM) for the
RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
and 31 general-purpose register values, aligned to 256 bytes as required
by the CCA RMM specification.

Add rsi_host_call() static inline wrapper in arm-rsi-cmds.h that invokes
SMC_RSI_HOST_CALL with the physical address of the host call structure.
This will be used by Hyper-V guest code to route hypercalls through the
RSI interface when running inside an Arm CCA Realm.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 include/linux/arm-rsi-cmds.h  | 22 ++++++++++++++++++++++
 include/linux/arm-smccc-rsi.h |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/arm-rsi-cmds.h b/include/linux/arm-rsi-cmds.h
index 3f7a6a8..01d292e 100644
--- a/include/linux/arm-rsi-cmds.h
+++ b/include/linux/arm-rsi-cmds.h
@@ -236,4 +236,26 @@ static inline unsigned long rsi_attestation_token_continue(phys_addr_t granule,
 	return res.a0;
 }
 
+/**
+ * rsi_host_call - Make a Host call.
+ * @host_call_struct: IPA of host call structure
+ *
+ * This call will fail if the IPA of the host call structure:
+ * * is not aligned to 256 bytes,
+ * * is not protected / encrypted,
+ * * is RIPAS_EMPTY
+ *
+ * Returns:
+ *  On success, returns RSI_SUCCESS.
+ *  Otherwise, returns an error code.
+ */
+static inline unsigned long rsi_host_call(phys_addr_t host_call_struct)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(SMC_RSI_HOST_CALL, host_call_struct, 0, 0, 0, 0, 0, 0,
+		      &res);
+	return res.a0;
+}
+
 #endif /* __LINUX_ARM_RSI_CMDS_H_ */
diff --git a/include/linux/arm-smccc-rsi.h b/include/linux/arm-smccc-rsi.h
index fddb779..4c8530b 100644
--- a/include/linux/arm-smccc-rsi.h
+++ b/include/linux/arm-smccc-rsi.h
@@ -142,6 +142,13 @@ struct realm_config {
 	 */
 } __aligned(0x1000);
 
+struct rsi_host_call {
+	u16 immediate;
+	u8 _padding[6];
+	u64 gprs[31];
+} __aligned(256);
+static_assert(sizeof(struct rsi_host_call) == 256);
+
 #endif /* __ASSEMBLER__ */
 
 /*
-- 
2.45.4

