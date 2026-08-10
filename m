Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E1A3A8722;
	Mon, 10 Aug 2026 12:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366011; cv=none; b=IwbyoRfX/pdvYpQ/wuJbP/B/6QIJJo9fMIXlrSdildTExDtfHtG46/NXxdCpIbD3T+Z1T1oGzhWGrd7+Q5Vgu0UaeZ3Ea7svQXfSQsG1Y9WD9pFzOrDEelgzpaXrXS4Ft9K4eKTOY8Ho7rAUkG3zRSMhQ7mnAJ/DhwS7ckj+eFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366011; c=relaxed/simple;
	bh=m2bLUYVTEB3YJAkD+xC5GMAHYEv4B7FVZZOmucpRDjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+z+Vr2+rTWbOuIoX7ncMTLNTinkahjlAGL4Vlm3lt9/g2lJ3sYpa/BDrL5nwc/uMVXrrgTsWH31qkl5rawaWsjaUIH0THZbkkFwJrCbvks2HRpY+HgPHD3GJdwiDjPaXosD1/Xqi/jkHZ3jI4nfnPeXr25jW8TdYvsjpAth3cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=EjjR71aL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="EjjR71aL"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id A5FF620B7168;
	Mon, 10 Aug 2026 05:46:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A5FF620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365986;
	bh=L44M7OPo4VJC4v3Tmn6RpOW+nljlGoEHBjwlchUWzGs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EjjR71aLYoCTO/LbM62mAGAb20wJeoXVJQq3TQkiPzmgNTBnNVdvwMVfwBE19+ciR
	 aaPfeQe4RpTEbG+KUVD++OYAMmxn7OFBW89qfBFqlbXS+t98UzH6nQAqUm/rFGpY5J
	 MqtELHBPhlC8XX2rNLIluzCXbZAWhUIEessAaulw=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v2 13/13] mshv: set up own SynIC registers on a nested root partition
Date: Mon, 10 Aug 2026 12:45:07 +0000
Message-ID: <20260810124527.1409634-14-weh@linux.microsoft.com>
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

From: Wei Hu <weh@microsoft.com>

Upstream mshv_synic_cpu_init()/_exit() skip programming the SynIC
SIMP/SIEFP/SCONTROL registers when VMBus is active (hv_vmbus_exists()),
assuming VMBus's hv_hyp_synic_enable_regs() already provisioned them.

That assumption is wrong for a *nested* root partition. There, VMBus
programs the *nested* SynIC MSRs (HV_X64_MSR_NESTED_SIMP, ...) via
hv_set_msr()'s nested remap, while mshv_synic reads/writes the
*non-nested* SynIC MSRs (hv_get/set_non_nested_msr). As a result mshv
maps the wrong message page, never receives the SYNIC intercept message
that carries the async hypercall completion, and mshv_async_hvcall_handler
blocks forever -- hanging SEV-SNP guest creation from user space.

Gate the "VMBus owns the SynIC registers" optimization on !hv_nested so
that a nested root partition programs its own non-nested SynIC registers,
restoring correct intercept/async-hypercall delivery. No change for a
non-nested (bare-metal) root.

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

