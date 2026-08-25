Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6494212542;
	Tue, 25 Aug 2026 04:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630749; cv=none; b=CMELgDKeRM2mgCHWFhCkZoHD397w8FfKxbnvjrRD1bdX2pSV9evHXzN6tn3DWEloAtJVzSJBQXXGG0Q7GjNaAGB23K6DiD86U7XPuNlj5Cx41I5Bb9VTXr8Ay5yqUR3gdtYRYV7clWa7U3rnS0l+T4cPaRop7+9bP1rUu3vE52g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630749; c=relaxed/simple;
	bh=hY6Zqjbp6ivpaT14Ky0kYnCHy9KFAFrBH/dmulP0FZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iTZO43JxWjWeO54ArjQo2wddwiYzaaoflyBJGyqogVbzW6IbOFdDR71DKPMsrxMRoq4e2JiW5FRBrD2m2Ll77aITpVnTMy2gHVjecdq2Iv1vFDq5haVw35B7zSMpdOPQtdMYiWIQo7yhh0NnxNOmndTlaM3D27vajemKsfOWHxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OEDEUhOS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OEDEUhOS"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id D40A520B6F01;
	Mon, 24 Aug 2026 21:05:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D40A520B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787630715;
	bh=SFVmphJGUgjGqagEnUY1UsHmAGjgir4rNYApD2dB5cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OEDEUhOS89FdKiu46nTdzeET4DGxXETFAy8VxkUTDw1Au6NlFd8CnIOCkkW5XgF2k
	 82h5me5XRHFZVzQqZy+nT1jYqW4YFPqf1LrZlZkZTKNI1kMXc0fn47ZKJOTcAeUF2X
	 YIJYSZlphYtlQZWi/X+zHvvtLZn58uL27Lnyc+fU=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v3 7/7] mshv: set up own SynIC registers on a nested root partition
Date: Tue, 25 Aug 2026 04:04:39 +0000
Message-ID: <20260825040505.826600-8-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260825040505.826600-1-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wei Hu <weh@microsoft.com>

Upstream mshv_synic_cpu_init()/_exit() skip programming the SynIC
SIMP/SIEFP/SCONTROL registers when VMBus is active (hv_vmbus_exists()),
assuming VMBus's hv_hyp_synic_enable_regs() already provisioned them.

That assumption is wrong for a *nested* root partition. There, VMBus
programs the *nested* SynIC MSRs (HV_X64_MSR_NESTED_SIMP, ...) via
hv_set_msr()'s nested remap, while mshv_synic reads/writes the
*non-nested* SynIC MSRs (hv_get/set_non_nested_msr). As a result mshv
maps the wrong message page, never receives the SYNIC intercept message
that carries the async hypercall completion, and
mshv_async_hvcall_handler blocks forever -- hanging SEV-SNP guest
creation from user space.

Gate the "VMBus owns the SynIC registers" optimization on !hv_nested so
that a nested root partition programs its own non-nested SynIC
registers, restoring correct intercept/async-hypercall delivery. No
change for a non-nested (bare-metal) root.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/hv/mshv_synic.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 7c168e5a740d..7d714ee5d226 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -472,7 +472,13 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
 	 * See hv_hyp_synic_enable_regs() for that initialization.
 	 */
-	bool vmbus_active = hv_vmbus_exists();
+	/*
+	 * On a nested root partition VMBus programs the *nested* SynIC MSRs
+	 * (SIMP/SIEFP/SCONTROL) via hv_set_msr()'s nested remap, whereas the
+	 * code below reads/writes the non-nested SynIC MSRs. So when nested,
+	 * do not defer SynIC setup to VMBus -- set up our own registers.
+	 */
+	bool vmbus_active = hv_vmbus_exists() && !hv_nested;
 
 	/*
 	 * Map the SYNIC message page. When VMBus is not active the
@@ -593,7 +599,13 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 	struct hv_synic_event_ring_page **event_ring_page =
 		&spages->synic_event_ring_page;
 	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
-	bool vmbus_active = hv_vmbus_exists();
+	/*
+	 * On a nested root partition VMBus programs the *nested* SynIC MSRs
+	 * (SIMP/SIEFP/SCONTROL) via hv_set_msr()'s nested remap, whereas the
+	 * code below reads/writes the non-nested SynIC MSRs. So when nested,
+	 * do not defer SynIC setup to VMBus -- set up our own registers.
+	 */
+	bool vmbus_active = hv_vmbus_exists() && !hv_nested;
 
 	/* Disable the interrupt */
 	sint.as_uint64 = hv_get_non_nested_msr(HV_MSR_SINT0 + HV_SYNIC_INTERCEPTION_SINT_INDEX);
-- 
2.43.0

