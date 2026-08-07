Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F5AC30BF6B;
	Fri,  7 Aug 2026 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110761; cv=none; b=rHd6Rn3AxzAkKlu5YGjjTn3tsiWSRzWeeSY+2D74Dv13fH0Z7r3tY++9QsDZwl47KGwMiUjStDQ9/Q+2j4waUiJYNz0mcIqt1b8zchwGsi7P+D0/JW74q7JX6FRvrvZzOdzYjsvPD/g0/+dev98ui/WyYYT11xeiv8Y6J/9ieMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110761; c=relaxed/simple;
	bh=8R4pesSE1lgiMwue3mT89hMhiNPJi+IVTJvW47Zasok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hds6Uq8un3qPe9oZ6ruHBwmgPuPTrUTF8qs45jrvzze6MmyIX7ZHBWGPP54fyCF8KuIJyXUij8wrDTvwWvhKVp2jmCtrdFcixm79bjwPEJSeTO1KWTMQgAcqlEb8Sg04eqC8ZTufiScQgFMY14VnlHx/tTJMkKz2jSJKfuwdwcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=jfXkaI5I; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="jfXkaI5I"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C0DB20B7128;
	Fri,  7 Aug 2026 06:51:59 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C0DB20B7128
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110719;
	bh=ttIR1bVheMD8GZJQTJdvN7lnxu5qgD6qQ0cUxY5eXP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jfXkaI5IDv4OL2a9A76kgGWVCSd4YGqhmnqxaVjKS3bYtwE4AllDut1UEIVHCqx0F
	 a/LRxFP2ohc7QnvKvwhQwQuDm2GB6FiWrsgW4qtqr3Nflbrb8g8BuFpx8oie9oSm2B
	 8uJjwJHbQhONvQ8XlZ48/ENVvLR5C6qRFCUoH3Hs=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v1 06/13] mshv: detect and report SEV-SNP support at init
Date: Fri,  7 Aug 2026 13:51:12 +0000
Message-ID: <20260807135134.303943-7-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807135134.303943-1-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
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
 drivers/hv/mshv_root_main.c | 107 ++++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 3590a8ea24b5..cc38507570ac 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2660,6 +2660,109 @@ static int mshv_root_scheduler_cleanup(unsigned int cpu)
 }
 
 /* Must be called after retrieving the scheduler type */
+#if defined(__x86_64__)
+static int mshv_print_max_sev_snp_partitions(struct device *dev)
+{
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	u64 status;
+	__u64 snp_partition_count;
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
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		dev_err(dev, "Failed to get max SNP partitions: %s\n",
+			hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	snp_partition_count = output->hv_processor_feature_value;
+	local_irq_restore(flags);
+
+	dev_info(dev, "Maximum supported SEV-SNP partitions are: %llu\n",
+		 snp_partition_count);
+	return 0;
+}
+#endif
+
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
+static int __init mshv_check_sev_snp_support(struct device *dev)
+{
+#if defined(__x86_64__)
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	u64 status;
+	enum hv_snp_status snp_status;
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
+	if (!hv_result_success(status)) {
+		local_irq_restore(flags);
+		dev_err(dev, "Failed to get SNP support: %s\n",
+			hv_result_to_string(status));
+		return hv_result_to_errno(status);
+	}
+
+	snp_status = output->hv_processor_feature_value;
+	local_irq_restore(flags);
+
+	dev_info(dev, "SEV-SNP support status: %s (%u)\n",
+		 hv_snp_status_to_string(snp_status), snp_status);
+
+	if (snp_status == HV_SNP_STATUS_AVAILABLE)
+		return mshv_print_max_sev_snp_partitions(dev);
+#endif
+
+	return 0;
+}
+
 static int
 root_scheduler_init(struct device *dev)
 {
@@ -2763,6 +2866,10 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto synic_cleanup;
 
+	ret = mshv_check_sev_snp_support(dev);
+	if (ret)
+		goto synic_cleanup;
+
 	ret = root_scheduler_init(dev);
 	if (ret)
 		goto synic_cleanup;
-- 
2.43.0

