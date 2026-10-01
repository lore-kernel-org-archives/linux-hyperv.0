Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB80235C1AD;
	Thu,  1 Oct 2026 22:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790892421; cv=none; b=bRWsX2OBw1id6ZoOrqldQkoVFrZMRX3SS0bmS6n5FzWp29cbPrNaNCsh0sm3igM0w8RJXWQTA90k/WuyL2Z/ik7LNiV4oRx5r2u5jIWl1R6YUARfaNrCOyUCGYRWm06KvlKZ8Bo8FC7sZhCMuBidqVIdVJmH0HQ8Scodqi8+KNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790892421; c=relaxed/simple;
	bh=GlyaLfwWUGZBUwEeljMADPmP9a1ve84J9uHgy+erYCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j4djOQr904D9THmSX/csZ/7ywskCBPFFZw0RCn8xfGOnETMnaSelF00fHUm+ydq+U+NAzqeZqUwWVaIqNos9O1AQZEJSXaSRTmH5hy/CfLnjngSDN5QIFcbJ2EqKAxHIJxDVZVx1XELzsh2Um0g9IGp/Lh1oyC2kx0zeE5+Qp0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ChqNBTlT; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ChqNBTlT"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3895420B7167;
	Thu,  1 Oct 2026 15:06:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3895420B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790892366;
	bh=kounR2NvS1pQIrMzyt0I8Qr2BJw+HYNfAJfuEFrUQ4k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ChqNBTlTncCwcbbdyyrVHLxoSK4INeVRFAe5fmtVskdpsRthSP4TSc89kB7gb+JE8
	 uyxMg6ac3a2HzeNBgv3Pg7JLErASCqzjfwnwvAz5kWCuYnoFLaxRNho2Fp1HdKCNxv
	 /zJLKTM3dHCBeXyPXgA2zIyF1zS5trAGk9cbzOtQ=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
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
Subject: [PATCH v4 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Thu,  1 Oct 2026 15:05:47 -0700
Message-ID: <20261001220552.1793471-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
References: <20261001220552.1793471-1-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add struct rsi_host_call to rsi_smc.h, which represents the host call
data structure used by the Realm Management Monitor (RMM) for the
RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
and 31 general-purpose register values, aligned to 256 bytes as required
by the CCA RMM specification.

Add rsi_host_call() static inline wrapper in rsi_cmds.h that invokes
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

