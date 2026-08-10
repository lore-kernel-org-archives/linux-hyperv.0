Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F423DA7EE;
	Mon, 10 Aug 2026 12:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786365989; cv=none; b=a4YkEZKXOePOssA/G3Mo9KKzsmvPCM9Ms4ufuijEs857Po78Fq0kV3jQ1yTjr3EWjTx/zkLxr+Ju1YOmQvTDZV2Qf3pJ2h2PvyNDMgLOL4+ESGnVqqrRwZAi6/y62b+hlO0L7L7zHAnKG5+fNIIrXwlf1loJmoJep3PVp0IQYc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786365989; c=relaxed/simple;
	bh=EfiFp7ToR3xzPLC3QsTzE6oK1abIn8WnOSrrKglg4So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WqjIN3PYmZt6k+CSCNeY6x0vAiaU2eSx/+gJs6pyDPwpOonqKT/pfL9Hpq/n0VX09jYhS7+m9sFU7DkoAHiyIWs59tR7UMp9Rl3NdLcCdAULleanItmDghVUpif4Ub9apYwc0HGOqEdV30SofuGwcVCjS6veBdHXM0Y684z54bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KTsMMgfi; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KTsMMgfi"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id E6FB720B7166;
	Mon, 10 Aug 2026 05:46:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6FB720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365964;
	bh=pfvLJd718hof9eXx4rhBXX2zG65sdwT3GsmiqMZvv78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTsMMgfiq/lvbjwl3hWo35vmDPkUchzJEQVdih8ACb6Fxg4xdgoiO+ddT6NvQm6LE
	 Hs7NR7/5+ez0Dfn8jtLEhRUd6/0aEb1wL5YOvo3DQglKuULYcpuMBzzxWnHw+5Hh65
	 +6q02PKOuUZhd0JdlvuXtm2szBbaD4kUStizxSVs=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v2 06/13] mshv: detect and report SEV-SNP support at init
Date: Mon, 10 Aug 2026 12:45:00 +0000
Message-ID: <20260810124527.1409634-7-weh@linux.microsoft.com>
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

From: Wei Liu <wei.liu@kernel.org>

Query Hyper-V dynamic processor features during mshv initialization to
determine SEV-SNP availability, and report the result: on success log the
maximum number of encrypted partitions, otherwise log the decoded SNP
status string so misconfigurations are diagnosable. Cloud Hypervisor
expects the root driver to perform this capability check before SEV-SNP
child partition setup.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 96 +++++++++++++++++++++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 8c87dd8e0378..712f45dcef60 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2705,6 +2705,100 @@ static int mshv_root_scheduler_cleanup(unsigned int cpu)
 }
 
 /* Must be called after retrieving the scheduler type */
+#if defined(__x86_64__)
+static const char *hv_snp_status_to_string(enum hv_snp_status status)
+{
+	switch (status) {
+	case HV_SNP_STATUS_NONE:
+		return "not available";
+	case HV_SNP_STATUS_AVAILABLE:
+		return "available";
+	case HV_SNP_STATUS_INCOMPATIBLE:
+		return "incompatible";
+	case HV_SNP_STATUS_PSP_UNAVAILABLE:
+		return "PSP unavailable";
+	case HV_SNP_STATUS_PSP_INIT_FAILED:
+		return "PSP init failed";
+	case HV_SNP_STATUS_PSP_BAD_FW_VERSION:
+		return "bad PSP firmware version";
+	case HV_SNP_STATUS_BAD_CONFIGURATION:
+		return "bad configuration";
+	case HV_SNP_STATUS_PSP_FW_UPDATE_IN_PROGRESS:
+		return "PSP firmware update in progress";
+	case HV_SNP_STATUS_PSP_RB_INIT_FAILED:
+		return "PSP ring buffer init failed";
+	case HV_SNP_STATUS_PSP_PLATFORM_STATUS_FAILED:
+		return "PSP platform status failed";
+	case HV_SNP_STATUS_PSP_INIT_LATE_FAILED:
+		return "PSP late init failed";
+	default:
+		return "unknown";
+	}
+}
+
+static void mshv_print_max_sev_snp_partitions(struct device *dev)
+{
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->property_id = HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY;
+	input->hv_processor_feature =
+		HV_X64_DYNAMIC_PROCESSOR_FEATURE_MAX_ENCRYPTED_PARTITIONS;
+
+	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
+	local_irq_restore(flags);
+	if (!hv_result_success(status)) {
+		dev_warn(dev, "Failed to get max SNP partitions: %s\n",
+			 hv_result_to_string(status));
+		return;
+	}
+
+	dev_info(dev, "Maximum supported SEV-SNP partitions are: %llu\n",
+		 output->hv_processor_feature_value);
+}
+
+static void __init mshv_check_sev_snp_support(struct device *dev)
+{
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	enum hv_snp_status snp_status;
+	u64 status;
+
+	local_irq_save(flags);
+	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+	memset(input, 0, sizeof(*input));
+	input->property_id = HV_DYNAMIC_PROCESSOR_FEATURE_PROPERTY;
+	input->hv_processor_feature = HV_X64_DYNAMIC_PROCESSOR_FEATURE_SNP_STATUS;
+
+	status = hv_do_hypercall(HVCALL_GET_SYSTEM_PROPERTY, input, output);
+	local_irq_restore(flags);
+	if (!hv_result_success(status)) {
+		dev_warn(dev, "Failed to get SNP support: %s\n",
+			 hv_result_to_string(status));
+		return;
+	}
+
+	snp_status = output->hv_processor_feature_value;
+	dev_info(dev, "SEV-SNP support status: %s (%u)\n",
+		 hv_snp_status_to_string(snp_status), snp_status);
+
+	if (snp_status == HV_SNP_STATUS_AVAILABLE)
+		mshv_print_max_sev_snp_partitions(dev);
+}
+#else
+static void __init mshv_check_sev_snp_support(struct device *dev) {}
+#endif
+
 static int
 root_scheduler_init(struct device *dev)
 {
@@ -2808,6 +2902,8 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto synic_cleanup;
 
+	mshv_check_sev_snp_support(dev);
+
 	ret = root_scheduler_init(dev);
 	if (ret)
 		goto synic_cleanup;
-- 
2.43.0

