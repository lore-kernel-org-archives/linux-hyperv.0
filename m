Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793024131;
	b=f4Byjo8k6i183HPtvcKJYTAZcW4LjFYBxelDXvaWXRqlvQRy2SrXDwjBTdoa7NrnzdX2
	 YS5M8z7ydsdAtgus6jzicuo067S1EQtS73PYOwza7HMBQmEM2f5iO8NWJjg9P2ZJyDTkQ
	 ObdwM4+ENZvGXDVVAZrqvVVxZHmJ5TU9+yTRsR2aPHUm9Kbzw5BdSII+nCPxAfVX7BuhL
	 PwhPje3O6xRSVQ8ZM6AKjdTgSLsuzEHnhMLDt2EPqFtg5Yri4AcU2uxjoFYUTDpRdxhll
	 J3iRYoaA4XiHPePfziobMIEHgVZHPGbCig63ZA7GU1OHJqzY4FBqZechZ8SKQRBaGxA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793024131;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Spam-Status:X-Spam-Checker-Version;
	bh=sCip3hofAAP42Q0Wm5DgfTWDFW8sAnzLDl2a/CT8Fu4=;
	b=yRUE9cPFLbYNyjg+VQrLyYm4+4QztA9Q4qFRf3rwi7tZtRTBfIEw2Z5Q9qDNzVMw8cXC
	 UXpu1PHT0RpxmbuHrbEWu+u58DFkrgxyJ5bg914nJs+o+oKDNYhwSI5YbYTMmAUIOV6rP
	 50sm346rYn1woUSzAUlBsKSOzSYI6w7Wpd8pBx2LzTLmf2GGTpn6jx0rQ5FO016cR5+rD
	 FhyPgoNfRdKZLdCAafZzb4J1Qu87IWJf9r/2iWZMhVjV4TNgrCjQ5mGd3G4d2RVngwG/1
	 FuJVp5AMVrgTQjzfiYfE5nq84ZLlx8wsKMqp0g5FSEfK1fWInrlih4ezZ+vX0pp0pFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TBZi61mK;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EBE460A2604;
	Mon, 26 Oct 2026 14:15:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5EBE460A2604
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TBZi61mK
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 67EC120B7167;
	Mon, 26 Oct 2026 07:15:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 67EC120B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793024120;
	bh=sCip3hofAAP42Q0Wm5DgfTWDFW8sAnzLDl2a/CT8Fu4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TBZi61mKbaTCwQWstYQ1vxxghYdHVH6T3jXZ9TpIi+KM35Is2WjihHvZ3cgRlASHS
	 nRmJbo9Lh/cFd7yyULgyaAJWTij2qKbfrGPzySxXjNCv6SAITSN0faEMLqbr6VGewu
	 pfzzKJBWjq8OHMRCJuEuk+Kzp3/IokSbCFwJUPuc=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	weh@microsoft.com,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>
Subject: [PATCH v8 9/9] mshv: set up own SynIC registers on a nested root partition
Date: Mon, 26 Oct 2026 14:14:56 +0000
Message-ID: <20261026141512.2987985-10-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026141512.2987985-1-weh@linux.microsoft.com>
References: <20260922041043.171543-1-weh@linux.microsoft.com>
 <20261026141512.2987985-1-weh@linux.microsoft.com>
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

From: Wei Hu <weh@microsoft.com>

Upstream mshv_synic_cpu_init()/_exit() skip programming the SynIC
SIMP/SIEFP/SCONTROL registers when VMBus is active (hv_vmbus_exists()),
assuming VMBus's hv_hyp_synic_enable_regs() already provisioned them.

That assumption is wrong for a nested root partition. There, VMBus
programs the nested SynIC MSRs (HV_X64_MSR_NESTED_SIMP, ...) through
hv_set_msr()'s nested remap, while mshv_synic reads and writes the
non-nested SynIC MSRs. As a result MSHV maps the wrong message page and
never receives the async hypercall completion, hanging guest creation.

Gate the "VMBus owns the SynIC registers" optimization on !hv_nested so
a nested root partition programs its own non-nested SynIC registers.
There is no behavior change for a non-nested root.

Map hypervisor-provided SIMP, SIEFP, and root SIRBP pages with the shared
GPA boundary removed and MEMREMAP_DEC, matching drivers/hv/hv.c for
confidential hosts. The L1VH SIRBP remains locally allocated.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 drivers/hv/mshv_synic.c | 39 ++++++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index da842c21156a..c7467d301623 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -458,6 +458,27 @@ void mshv_isr(void)
 	}
 }
 
+static bool mshv_synic_vmbus_owns_registers(void)
+{
+	/*
+	 * Nested VMBus programs nested MSRs, while MSHV uses non-nested MSRs.
+	 */
+	return hv_vmbus_exists() && !hv_nested;
+}
+
+static void *mshv_synic_map_shared_page(u64 pfn)
+{
+	u64 base;
+
+	if (!pfn)
+		return NULL;
+
+	/* Match Hyper-V's established confidential SynIC mapping convention. */
+	base = (pfn << HV_HYP_PAGE_SHIFT) &
+		~ms_hyperv.shared_gpa_boundary;
+	return memremap(base, HV_HYP_PAGE_SIZE, MEMREMAP_WB | MEMREMAP_DEC);
+}
+
 static int mshv_synic_cpu_init(unsigned int cpu)
 {
 	union hv_synic_simp simp;
@@ -468,11 +489,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	struct hv_message_page *msg_page;
 	struct hv_synic_event_flags_page *event_flags_page;
 	struct hv_synic_event_ring_page *event_ring_page;
-	/*
-	 * VMBus owns SIMP/SIEFP/SCONTROL when it is active.
-	 * See hv_hyp_synic_enable_regs() for that initialization.
-	 */
-	bool vmbus_active = hv_vmbus_exists();
+	bool vmbus_active = mshv_synic_vmbus_owns_registers();
 
 	/*
 	 * Map the SYNIC message page. When VMBus is not active the
@@ -484,8 +501,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 		simp.simp_enabled = true;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
 	}
-	msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
-			    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	msg_page = mshv_synic_map_shared_page(simp.base_simp_gpa);
 	WRITE_ONCE(spages->hyp_synic_message_page, msg_page);
 
 	if (!msg_page)
@@ -500,8 +516,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 		siefp.siefp_enabled = true;
 		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
 	}
-	event_flags_page = memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
-				    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	event_flags_page = mshv_synic_map_shared_page(siefp.base_siefp_gpa);
 	WRITE_ONCE(spages->synic_event_flags_page, event_flags_page);
 
 	if (!event_flags_page)
@@ -512,8 +527,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 
 	if (hv_root_partition()) {
 		event_ring_page =
-			memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
-				 HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+			mshv_synic_map_shared_page(sirbp.base_sirbp_gpa);
 
 		if (!event_ring_page)
 			goto cleanup_siefp;
@@ -596,8 +610,7 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
 	struct hv_message_page *msg_page;
 	struct hv_synic_event_flags_page *event_flags_page;
 	struct hv_synic_event_ring_page *event_ring_page;
-	/* VMBus owns SIMP/SIEFP/SCONTROL when it is active */
-	bool vmbus_active = hv_vmbus_exists();
+	bool vmbus_active = mshv_synic_vmbus_owns_registers();
 
 	msg_page = READ_ONCE(spages->hyp_synic_message_page);
 	event_flags_page = READ_ONCE(spages->synic_event_flags_page);
-- 
2.43.0

