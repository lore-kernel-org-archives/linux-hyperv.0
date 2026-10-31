Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793405679;
	b=HkOYCwx+2aR5W+FKsUd+gVAwm6CNl3omvk1UrauD3+Q2B1DW/viwt/1g/NB7dIXmFNO9
	 4KhpQqAT9ukYY1jukmwIxaiQgqByfGGQbc/o0VIBishsREvTaNo31b/46+zOX1PElRkLS
	 BaEt/yOiEHZ7WoOfUN3hO6LJVxwEhcPtcPeJfcUv2DIYuubIbxlBqcTvW3lxmKD3/gwgv
	 cVn3g3zqg6kSPezC+IRn1wj4dSra2YaeigswErEJvmUCU0F99i6VuhjK3/Hx2B+Pm9Npw
	 D0Wq3O4+kAoZ0LhAoF1fYEs8ZKX4HHZS7MnYiOx5i684716uZIy9IrxWChfaBSPD14g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793405679;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=F0MO/r8a7BDsMhBk/mJgC+1OZlbLoLJX/Mq8zb5p8N0=;
	b=HLD1aIN+qd5cXRKfQLUv2Q9pjOOWYkmCz9oOYudKfFuvU65TwnmCCg6ZClrE5OlaUbfv
	 Vrg47miRcA1d/H2Aas7i8cyaGRa5UaasClnRWL61yv2cBLSdcgmCI74qYBixxe0/9O5zt
	 d4MZB6mUNGbbaD45mOCf8C6ex4fMBbdoKuqxLT3oJm7GGk47B5idwfYS35eR2Oc85jVOB
	 GnR5Jh6B8E+b64gGNa1F5mEdStxwshmeOThCuoKorcvAAECfrWtkTwY04ZUHQbyA2Gdo5
	 QpJZex9Q1W2wkKDinfDhgOo6Il2h0NlrkpR3PTrQbv12vgFacHKVEc4PlXUL9VBYQQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Qkjkp2nz;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57F4606A31F;
	Sat, 31 Oct 2026 00:14:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D57F4606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Qkjkp2nz
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3635020B7167;
	Fri, 30 Oct 2026 17:14:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3635020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793405665;
	bh=F0MO/r8a7BDsMhBk/mJgC+1OZlbLoLJX/Mq8zb5p8N0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Qkjkp2nzb58p4oICzVWbFicUYCtdPx1YoR/WfLfHUOpuM+/o0d/ETLxeajUlc+u5Q
	 7WrNZk+P0DwLzDM2SBEMCzuX0Le8FXPmLzmesXQ83lZjAT+95/GwGM1fhlOvRfpSuN
	 6TaOsDYmhwaEYoDuTEzQ9JwcdahwNE5A8W87XJC8=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: decui@microsoft.com,
	haiyangz@microsoft.com,
	mhklinux@outlook.com,
	wei.liu@kernel.org
Cc: arnd@arndb.de,
	catalin.marinas@arm.com,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lpieralisi@kernel.org,
	mark.rutland@arm.com,
	sudeep.holla@kernel.org,
	thuth@redhat.com,
	will@kernel.org
Subject: [PATCH v6 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Fri, 30 Oct 2026 17:14:07 -0700
Message-ID: <20261031001412.4150488-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
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

