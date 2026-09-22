Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4355C3E51C6;
	Tue, 22 Sep 2026 04:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790050262; cv=none; b=tAvcbDWbb5r4cU8SSrJonvXOZ0bq9++nGCLzKOnTe4V7ReEd/NP98A+vmZbKpfdakDmIGRrtEpXJuDYrWGAbFKQHC9Wgp4RRN5yeTjgKa5NR8ezudTSfbCmheCrVIkFxADG6jCFyHNBnbsS1u9Sl/8sgK01h3JszgrlX1c1fsIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790050262; c=relaxed/simple;
	bh=jSAgtcVmJxc/yhDb3yNpyoleuog2V6zndwyWvt6DqPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jAOnoHdl4pP5zyaSmuZO347++UYlizIqHKlKb6sJ5jE8OnVgbraCr+vXIyHxmkhpZFXd1uTO25WeGztVQL5Ji9gyFRVMEC5GvDhKKhUO7gR6BlTwFR7y4cqKjIvGw0E45lJyG6VvWib/rZbyGWiyPR+bdd3+V69EFVHz7T7kX+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oAIanj/E; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oAIanj/E"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id DE2FD20B7169;
	Mon, 21 Sep 2026 21:10:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DE2FD20B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1790050213;
	bh=MtV+bkoXaoVF8P8A2hn5t6K1Cz9hKyy8RhQeRZ9NhyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oAIanj/ER63s30IlulLxSKNIJLlKSnhJNZH654860RETQ6DVyk2zwIaSv/LwGmrSo
	 9tjzx6mTIHAn5S16SGPVkuGECQAI82gM2UsUZXnu+HOifQjgrUUsV19lhT6yZLO9U5
	 lSqApBZOQ1MFNAWX2UWQVhYO0XgjvGEo1XN4hYOY=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v7 9/9] mshv: set up own SynIC registers on a nested root partition
Date: Tue, 22 Sep 2026 04:10:26 +0000
Message-ID: <20260922041043.171543-10-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922041043.171543-1-weh@linux.microsoft.com>
References: <20260918115741.3791682-1-weh@linux.microsoft.com>
 <20260922041043.171543-1-weh@linux.microsoft.com>
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
 drivers/hv/mshv_synic.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 0fdbae1e053c..8470cf958f21 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -458,6 +458,25 @@ void mshv_isr(void)
 	}
 }
 
+static bool mshv_synic_vmbus_owns_registers(void)
+{
+	/* Nested VMBus programs nested MSRs, while MSHV uses non-nested MSRs. */
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
@@ -468,11 +487,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
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
@@ -484,8 +499,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 		simp.simp_enabled = true;
 		hv_set_non_nested_msr(HV_MSR_SIMP, simp.as_uint64);
 	}
-	msg_page = memremap(simp.base_simp_gpa << HV_HYP_PAGE_SHIFT,
-			    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	msg_page = mshv_synic_map_shared_page(simp.base_simp_gpa);
 	WRITE_ONCE(spages->hyp_synic_message_page, msg_page);
 
 	if (!msg_page)
@@ -500,8 +514,7 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 		siefp.siefp_enabled = true;
 		hv_set_non_nested_msr(HV_MSR_SIEFP, siefp.as_uint64);
 	}
-	event_flags_page = memremap(siefp.base_siefp_gpa << HV_HYP_PAGE_SHIFT,
-				    HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+	event_flags_page = mshv_synic_map_shared_page(siefp.base_siefp_gpa);
 	WRITE_ONCE(spages->synic_event_flags_page, event_flags_page);
 
 	if (!event_flags_page)
@@ -511,8 +524,8 @@ static int mshv_synic_cpu_init(unsigned int cpu)
 	sirbp.as_uint64 = hv_get_non_nested_msr(HV_MSR_SIRBP);
 
 	if (hv_root_partition()) {
-		event_ring_page = memremap(sirbp.base_sirbp_gpa << HV_HYP_PAGE_SHIFT,
-					   HV_HYP_PAGE_SIZE, MEMREMAP_WB);
+		event_ring_page =
+			mshv_synic_map_shared_page(sirbp.base_sirbp_gpa);
 
 		if (!event_ring_page)
 			goto cleanup_siefp;
@@ -595,8 +608,7 @@ static int mshv_synic_cpu_exit(unsigned int cpu)
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

