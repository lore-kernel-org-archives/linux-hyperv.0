Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32C61E5B9F;
	Tue, 25 Aug 2026 04:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787630741; cv=none; b=Af4JcaFba9Q8lKtCTkMHJ5XzsXCLsAkEa/59bu+3UGNlo3ELMBQlpA+NxkBjlU/IBaa3H/wTwt1flNJHyRDqiVyJo5zFLcy0UBmMm/+rAY3Yl7kMlLkP0Ou4uhR3V9HIXh6dWU0rcdm38yCf23jfCruyFXkJzxl9GIlKIf4WYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787630741; c=relaxed/simple;
	bh=padDV3Vhda4dd2DZoCB1WlXhw1QKB1Aj26lA9aOh7rM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvmBMyVCizgk7XIcLxznxBSsy+XKjW8S9Qv2QN6wSvmq6YleYcy8uYRvOye1vhv3IbjdYj5deqCsPPuxN5ok/zJ/LkC1Kiy9wp/cVzdgXKruPT8nQNu3xR89FmCOqfwCQ2Y0XN3KGiuHZQoZjHGgn/A2UCLEf3i0r3xJV8vJPVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YZQy/5OG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YZQy/5OG"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 80E2720B7166;
	Mon, 24 Aug 2026 21:05:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 80E2720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787630707;
	bh=0kEWTH1ufRiR/uwPF6334RBuyayMpnee9FvD37YiUhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YZQy/5OGUFvdNYGMU2Uhbo0wCApJD+YBG4yVry2XAlA1hBLhCV+6RyuTFIaymsF6T
	 HPNiYsWcD5lB8kHGXDNWKvVUWIGBc/28VTsVsAuvmkZDjJJUuMSdma3OBTUqkKGshx
	 73zcP7vPkddy+ne08DRwzKWQXufwwRygr1pdX4RA=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v3 5/7] mshv: detect and report SEV-SNP support at init
Date: Tue, 25 Aug 2026 04:04:37 +0000
Message-ID: <20260825040505.826600-6-weh@linux.microsoft.com>
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

From: Wei Liu <wei.liu@kernel.org>

Query MSHV dynamic processor features during parent initialization and
report SEV-SNP availability and the maximum number of encrypted
partitions.

L1VH parents reject the SNP property query, so treat query failures as
"not available" rather than failing MSHV initialization. Copy successful
results from the shared per-CPU output page before restoring local
interrupts.

The misc device is registered before parent initialization is complete.
Reject opens until the partition hash table and interrupt handling are
ready, and clear readiness before teardown starts.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 106 +++++++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index d946b4592d5b..59f55bd0e7c9 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -100,6 +100,8 @@ static const struct file_operations mshv_dev_fops = {
 	.llseek = noop_llseek,
 };
 
+static bool mshv_ready;
+
 static struct miscdevice mshv_dev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "mshv",
@@ -2757,7 +2759,7 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
 static int
 mshv_dev_open(struct inode *inode, struct file *filp)
 {
-	return 0;
+	return READ_ONCE(mshv_ready) ? 0 : -EAGAIN;
 }
 
 static int
@@ -2903,6 +2905,104 @@ static int mshv_root_scheduler_cleanup(unsigned int cpu)
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
+	u64 snp_partition_count = 0;
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
+	if (hv_result_success(status))
+		snp_partition_count = output->hv_processor_feature_value;
+	local_irq_restore(flags);
+	if (!hv_result_success(status)) {
+		dev_warn(dev, "Failed to get max SNP partitions: %s\n",
+			 hv_result_to_string(status));
+		return;
+	}
+
+	dev_info(dev, "Maximum supported SEV-SNP partitions are: %llu\n",
+		 snp_partition_count);
+}
+
+static void __init mshv_check_sev_snp_support(struct device *dev)
+{
+	struct hv_input_get_system_property *input;
+	struct hv_output_get_system_property *output;
+	unsigned long flags;
+	enum hv_snp_status snp_status = HV_SNP_STATUS_NONE;
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
+	if (hv_result_success(status))
+		snp_status = output->hv_processor_feature_value;
+	local_irq_restore(flags);
+	if (!hv_result_success(status)) {
+		/* L1VH parents reject this property query. */
+		dev_info(dev, "SEV-SNP support is not available\n");
+		return;
+	}
+
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
@@ -3006,6 +3106,8 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto synic_cleanup;
 
+	mshv_check_sev_snp_support(dev);
+
 	ret = root_scheduler_init(dev);
 	if (ret)
 		goto synic_cleanup;
@@ -3022,6 +3124,7 @@ static int __init mshv_parent_partition_init(void)
 	hash_init(mshv_root.pt_htable);
 
 	hv_setup_mshv_handler(mshv_isr);
+	WRITE_ONCE(mshv_ready, true);
 
 	return 0;
 
@@ -3038,6 +3141,7 @@ static int __init mshv_parent_partition_init(void)
 
 static void __exit mshv_parent_partition_exit(void)
 {
+	WRITE_ONCE(mshv_ready, false);
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
 	mshv_debugfs_exit();
-- 
2.43.0

