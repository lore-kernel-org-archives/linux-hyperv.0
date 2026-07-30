Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E837175A97;
	Thu, 30 Jul 2026 00:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372623; cv=none; b=jKxGtkubgqbAnFQH/JrOMd3NFAPwH6ZvSrNgaJxMh3PclehRHDkH6Ql6pKZcXgKAyK0r1zA0WHccoXddd/rO0Fjtu5ldLkS7XVWGbfTO7yskPRYsQLx/BJwgkLaBFw/3twBhURNmNKF1UeWpgkUJNz9yrggwMBNDnhq+yMIMtmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372623; c=relaxed/simple;
	bh=g8YSBeduLEzr6nK7r+X0m6rgO72ZhISOEpFd6B8qygc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KsKUMvwdFaOfnvsWOMkC8H8kBy/ZBqKmZAAC6hD7huLqJe3oLuVsCATc6SvSvHcrujcGyGwXaFCwqe7UwEMtPtP6BrF9UEs8pmypsHmfbNHGmJH6ovlP3UXHPVCOUycfXIcAZZX4/4+c/64PXxmy7U/s1X1F/aG2fnk2I4sxHi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrR8uRYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrR8uRYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00BC11F000E9;
	Thu, 30 Jul 2026 00:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785372622;
	bh=gv43lhr+yt/Pc2AenG9VojA3Gr2ZV8NWHt3DR3uhemE=;
	h=From:To:Cc:Subject:Date;
	b=WrR8uRYrwmoHPWYi4ah4TD4sdpwfOYYiDEY51AdH7NaNsKeD7DDTy6v2rySUEwolD
	 lAfvBdbnQ4lZs7CEWvotZStw6s3o3Yz4jKcnQXT4aJ5tcL5omHh6l5NIaGni6bRWW8
	 QrOPqrRC2Om9qeQLl9r/5Z/H9eCMZLWVivCDnT+L/KlXnWRlAj1TsZnNtuYXtZvcxB
	 4RPNR/vL6YtycnPHdqe90dsKJB1XW6GUt879ldQ08mpp+AkRFt+0TrJlGdhA5G+W2h
	 m+A2mAvrnLw/80TsnCe0+cu1xqrmsA1Yo4G6JlKbxZqap87426mJO0Eh2bfnN+jJzS
	 MDTdxmLG3F7jg==
From: wei.liu@kernel.org
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com,
	Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT))
Subject: [PATCH] x86/hyperv: reserve more vectors
Date: Wed, 29 Jul 2026 17:50:19 -0700
Message-ID: <20260730005020.2181875-1-wei.liu@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Liu <wei.liu@kernel.org>

Microsoft Hypervisor delivers three vectors to the NT HAL running in the
root partition and refuses to map a device interrupt to any of them when
interrupt remapping is not available in the system. As of writing, the
nested MSHV setup has no interrupt remapping capability.

The three vectors are:

  HAL_NT_APC_VECTOR		0x1F
  HAL_NT_DPC_VECTOR		0x2F
  HAL_NT_CLOCK_IPI_VECTOR	0xD2

0x1F is below FIRST_EXTERNAL_VECTOR so the vector allocator never hands
it out, but 0x2F and 0xD2 are both inside the allocatable range and are
handed out once enough vectors are in use. Mapping such an interrupt
then fails with HV_STATUS_INVALID_PARAMETER, and the interrupt is never
delivered.

Reserve all three next to the hypervisor debug vectors that are already
kept out of the allocator's hands.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/kernel/cpu/mshyperv.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 185d4f677ec0..229c7377a980 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -502,17 +502,32 @@ static void hv_reserve_irq_vectors(void)
 	#define HYPERV_DBG_ASSERT_VECTOR	0x2C
 	#define HYPERV_DBG_SERVICE_VECTOR	0x2D
 
+	/*
+	 * The hypervisor delivers these three to the NT HAL and refuses to
+	 * map a device interrupt to any of them.
+	 *
+	 * The hypervisor will provide a hint in the future when these
+	 * vectors become available to use.
+	 */
+	#define HAL_NT_APC_VECTOR		0x1F
+	#define HAL_NT_DPC_VECTOR		0x2F
+	#define HAL_NT_CLOCK_IPI_VECTOR		0xD2
+
 	if (cpu_feature_enabled(X86_FEATURE_FRED))
 		return;
 
 	if (test_and_set_bit(HYPERV_DBG_ASSERT_VECTOR, system_vectors) ||
 	    test_and_set_bit(HYPERV_DBG_SERVICE_VECTOR, system_vectors) ||
-	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors))
+	    test_and_set_bit(HYPERV_DBG_FASTFAIL_VECTOR, system_vectors) ||
+	    test_and_set_bit(HAL_NT_APC_VECTOR, system_vectors) ||
+	    test_and_set_bit(HAL_NT_DPC_VECTOR, system_vectors) ||
+	    test_and_set_bit(HAL_NT_CLOCK_IPI_VECTOR, system_vectors))
 		BUG();
 
-	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x\n",
+	pr_info("Hyper-V: reserve vectors: 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
 		HYPERV_DBG_ASSERT_VECTOR, HYPERV_DBG_SERVICE_VECTOR,
-		HYPERV_DBG_FASTFAIL_VECTOR);
+		HYPERV_DBG_FASTFAIL_VECTOR, HAL_NT_APC_VECTOR,
+		HAL_NT_DPC_VECTOR, HAL_NT_CLOCK_IPI_VECTOR);
 }
 
 static void __init ms_hyperv_init_platform(void)
-- 
2.53.0

