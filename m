Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE8333E1CE8;
	Mon, 31 Aug 2026 11:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788175669; cv=none; b=UyeU62n8KuSkt3RkYGHxvVy/z66A6fKyZ1LCxM/Bjq27SBf684SDjq3A9PhNSc01R+Wyhbz0dj15cil1q99OTIFtUh6bXcCTyQJmSgh/Z+86TDCPXgXAfSPv25M0SGaFuiWdsU43F/ehhDdtTlmO66svjpci7ND5L5y3sOGMNIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788175669; c=relaxed/simple;
	bh=jSAgtcVmJxc/yhDb3yNpyoleuog2V6zndwyWvt6DqPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TL72ICEO3892xTLd4ngkTYMatOLZZiLVQ1wnUNaYIoQ7eUA3hwb5C+ZuEq4P1/7OVvLGtqJH5gw1uVq2RWA3qmBcTzfZ0UqaoqsH0RdEj6JygHs8GqAKq6g26BG8OR5KoLxaCoCz2KIBTZlazOZg+MuzMLDwZUU63lEdR+rkftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=S4A1SjxK; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="S4A1SjxK"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id A622A20B7128;
	Mon, 31 Aug 2026 04:27:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A622A20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788175632;
	bh=MtV+bkoXaoVF8P8A2hn5t6K1Cz9hKyy8RhQeRZ9NhyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S4A1SjxKUVDRfQ3xnZvmkTHogWjMJMcCrBsK2rtUBcCS5BRYFrNskTtQzL9AYWdxv
	 GD3VidbJl+p5wnb9H7jfl1Oz3+4Z3oOfEL245Xe4iGgAB4MzTjC+cX85Zs1chM7uJh
	 Fx+YeW6cqz6TtKpyVWcHYL1ioMidgY1iKF5TA5+U=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>
Subject: [PATCH v4 9/9] mshv: set up own SynIC registers on a nested root partition
Date: Mon, 31 Aug 2026 11:26:47 +0000
Message-ID: <20260831112704.2851147-10-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260831112704.2851147-1-weh@linux.microsoft.com>
References: <20260825040505.826600-1-weh@linux.microsoft.com>
 <20260831112704.2851147-1-weh@linux.microsoft.com>
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

