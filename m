Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC8C3EE1C0;
	Thu, 25 Jun 2026 17:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782408907; cv=none; b=nLImnil1lejCl6l4Fxcl6JNREDqXSV3exWiKN2OP+Cuv4S1lEM3m188dKs03s/kUEDv1u3yAXwP9UDsZDJRWPglWWGxq2n4ELpUyowJxB4t1MnPm9jZt1Y7Jlb7vaJVyv7DBPuJK7jGki+ZW0sLQCvNvB9XbKVQNJ3REqkg2JkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782408907; c=relaxed/simple;
	bh=fUUKFmrbIiUef74AOCNqccPziLzJSdWvp3e05UVA26M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsKPFCvY+XZ/nrLak8h+wwdNYpgzWci+duYG5FJruAssni8F7dHmz5vlk6/4iSm4chCL1zRIE05lI40pmvxT7sleLjWj9bL0pFJhN+pKxhAokqF4uQwy++kJFq9L3RHLUMkE1taAmqAwdzO4hQmFTFF/58A7xjaZn9SrKKcy8g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YyT1mLLb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YyT1mLLb"
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C48220B7169;
	Thu, 25 Jun 2026 10:35:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C48220B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782408901;
	bh=NzRxQvPwzEBTlATkVCaj62V6KcKKHvmr0KtL0Tzs39U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyT1mLLbG0yDsWb+ub3RqfqfkOHlZeXiolq/hbqF4YXDOeLmdiv93ZqnEhoqm8oOP
	 XS+ZvAjiK7CZ5GDZPChpxbpbNigkPBEjcAxUtCiu7/RZxgVPYgUuSrUkeESXy1U/JM
	 z4XaicX08QbR1i7BFUkeqYb2msShZhvkDonjy6jk=
From: Kameron Carr <kameroncarr@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
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
	linux-arch@vger.kernel.org,
	mhklinux@outlook.com
Subject: [PATCH v2 1/6] arm64: rsi: Add RSI host call structure and helper function
Date: Thu, 25 Jun 2026 10:34:55 -0700
Message-ID: <20260625173500.1995481-2-kameroncarr@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
References: <20260625173500.1995481-1-kameroncarr@linux.microsoft.com>
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

Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
---
 arch/arm64/include/asm/rsi_cmds.h | 22 ++++++++++++++++++++++
 arch/arm64/include/asm/rsi_smc.h  |  7 +++++++
 2 files changed, 29 insertions(+)

diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
index 2c8763876dfb7..9daf8008e5da2 100644
--- a/arch/arm64/include/asm/rsi_cmds.h
+++ b/arch/arm64/include/asm/rsi_cmds.h
@@ -88,6 +88,28 @@ static inline long rsi_set_addr_range_state(phys_addr_t start,
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
 /**
  * rsi_attestation_token_init - Initialise the operation to retrieve an
  * attestation token.
diff --git a/arch/arm64/include/asm/rsi_smc.h b/arch/arm64/include/asm/rsi_smc.h
index e19253f96c940..9cc57b5be0c02 100644
--- a/arch/arm64/include/asm/rsi_smc.h
+++ b/arch/arm64/include/asm/rsi_smc.h
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

