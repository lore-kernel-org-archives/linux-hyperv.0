Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D578D37CD54;
	Wed, 22 Apr 2026 02:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776825230; cv=none; b=c0NV1G5mhRAiXPuDG66LV/JjfQ2/Z1D2SjmK9yZ+aUbCNoJT97YlsFwgjpYy2NNEzp36g4kDwLjwk6xIJLf4AfXtoRfyG90nb6WF7nfP1H2HM1ibxKk/RwkCh7dSfhEWhEOpXm2zzUUhNlJvvb0EMBGVjjRirQQQZgN6jC0gNA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776825230; c=relaxed/simple;
	bh=Z3Tt+i4ryjnf6ysGYVY1XRQ8YBFCce5JBQ1Bz2twCCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKKAy9n35dTs2v+NqsyquEkpoMWQa00CJTcvRBycrcL+XzTZ3rmZLGSQD0tw8eOUnx1DT9HGoZr1UH4hRhDVgIV772LW0p9Vz+R3FJ69WWW8yqEJqo4y51RqXaRsbcevrYxERueJyb77n/9rNPvCPldK2UhuC8CloEXaTyxYY2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UtQVZhp7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UtQVZhp7"
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8A90C20B6F12;
	Tue, 21 Apr 2026 19:33:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8A90C20B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776825221;
	bh=ONiMZWsb8/8IhaBjkgi5kkshWDnWtbTkSXDdbFle5ZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtQVZhp7fv0i6HpN1CrtxqNecqOwBHsibTl5ydNBUd1KFghrBaPB7lDZCCY55sv9D
	 oNNyybQ/srUjUncnRi/0WZ0w8/XwbirBCbC+9DwEvhFb8zKCNNLrnZAmAZxGSUJVWV
	 WQLsQ0zLRlycUT/HH1rx3r4W0SE6E7e4zex1aM5Q=
From: Mukesh R <mrathor@linux.microsoft.com>
To: hpa@zytor.com,
	robin.murphy@arm.com,
	robh@kernel.org,
	wei.liu@kernel.org,
	mrathor@linux.microsoft.com,
	mhklinux@outlook.com,
	muislam@microsoft.com,
	namjain@linux.microsoft.com,
	magnuskulke@linux.microsoft.com,
	anbelski@linux.microsoft.com,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	joro@8bytes.org,
	will@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	bhelgaas@google.com,
	arnd@arndb.de
Subject: [PATCH V1 03/13] x86/hyperv: add insufficient memory support in irqdomain.c
Date: Tue, 21 Apr 2026 19:32:29 -0700
Message-ID: <20260422023239.1171963-4-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
References: <20260422023239.1171963-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Intermittent insufficient memory hypercall failure have been observed in
the current map device interrupt hypercall. In case of such a failure,
we must deposit more memory and redo the hypercall. Add support for
that. Deposit memory needs partition id, make that a parameter to the
map interrupt function.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/irqdomain.c | 38 +++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
index b3ad50a874dc..229f986e08ea 100644
--- a/arch/x86/hyperv/irqdomain.c
+++ b/arch/x86/hyperv/irqdomain.c
@@ -13,8 +13,9 @@
 #include <linux/irqchip/irq-msi-lib.h>
 #include <asm/mshyperv.h>
 
-static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
-		int cpu, int vector, struct hv_interrupt_entry *ret_entry)
+static u64 hv_map_interrupt_hcall(u64 ptid, union hv_device_id hv_devid,
+				  bool level, int cpu, int vector,
+				  struct hv_interrupt_entry *ret_entry)
 {
 	struct hv_input_map_device_interrupt *input;
 	struct hv_output_map_device_interrupt *output;
@@ -30,8 +31,10 @@ static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
 
 	intr_desc = &input->interrupt_descriptor;
 	memset(input, 0, sizeof(*input));
-	input->partition_id = hv_current_partition_id;
+
+	input->partition_id = ptid;
 	input->device_id = hv_devid.as_uint64;
+
 	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
 	intr_desc->vector_count = 1;
 	intr_desc->target.vector = vector;
@@ -64,6 +67,28 @@ static int hv_map_interrupt(union hv_device_id hv_devid, bool level,
 
 	local_irq_restore(flags);
 
+	return status;
+}
+
+static int hv_map_interrupt(u64 ptid, union hv_device_id device_id, bool level,
+			    int cpu, int vector,
+			    struct hv_interrupt_entry *ret_entry)
+{
+	u64 status;
+	int rc, deposit_pgs = 16;		/* don't loop forever */
+
+	while (deposit_pgs--) {
+		status = hv_map_interrupt_hcall(ptid, device_id, level, cpu,
+						vector, ret_entry);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY)
+			break;
+
+		rc = hv_call_deposit_pages(NUMA_NO_NODE, ptid, 1);
+		if (rc)
+			break;
+	}
+
 	if (!hv_result_success(status))
 		hv_status_err(status, "\n");
 
@@ -199,8 +224,8 @@ int hv_map_msi_interrupt(struct irq_data *data,
 	hv_devid = hv_build_devid_type_pci(pdev);
 	cpu = cpumask_first(irq_data_get_effective_affinity_mask(data));
 
-	return hv_map_interrupt(hv_devid, false, cpu, cfg->vector,
-				out_entry ? out_entry : &dummy);
+	return hv_map_interrupt(hv_current_partition_id, hv_devid, false, cpu,
+				cfg->vector, out_entry ? out_entry : &dummy);
 }
 EXPORT_SYMBOL_GPL(hv_map_msi_interrupt);
 
@@ -423,6 +448,7 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int cpu, int vector,
 	hv_devid.device_type = HV_DEVICE_TYPE_IOAPIC;
 	hv_devid.ioapic.ioapic_id = (u8)ioapic_id;
 
-	return hv_map_interrupt(hv_devid, level, cpu, vector, entry);
+	return hv_map_interrupt(hv_current_partition_id, hv_devid, level, cpu,
+				vector, entry);
 }
 EXPORT_SYMBOL_GPL(hv_map_ioapic_interrupt);
-- 
2.51.2.vfs.0.1

