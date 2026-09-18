Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB15C4E9C1A;
	Fri, 18 Sep 2026 11:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789732679; cv=none; b=JeBd3UKghqIX93kOP2RI3Bb5Equr7TSkFuRJ+8xQNl+G+vDsmYeePQ0hfqAfWtHv2ESinWK+wq8xglXxQ9NGGtoUsA9gLvAX8FmIpUEq7AUCY+RIiet2Z8ncKU7zQC1mjtrPyYrXm0RnjcFxOCc1rVewzK3UR7oS+Jk+I8BcMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789732679; c=relaxed/simple;
	bh=IHa8hW6bg8MxN+DZvaHEVWbjDuAOjcNHEHVEiMItL/g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5wmjaE9QGNW4tbSt1yeoghOzH578GthYwfO92waT1q1zqXE6IBs2cNzuupG7X4bkIWXxAENMckPWzvjSYlCCPjpXMFXTCzQneQkKgYqg8A9OHoMYYpfnFPAdLnCDaPgOL1jddLIkWAJKJA9uLkkPpuDAweSkPS0Lf7TG4Y39dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FNFh2MqX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FNFh2MqX"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0932E20B716C;
	Fri, 18 Sep 2026 04:57:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0932E20B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1789732631;
	bh=IwUmgEf3Dw0fkYb5e9dRj14W+oWm3VcD63jiaORkACk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FNFh2MqXWqvPxix2IwJO+uArq1NTKDR2rBYuJfFQATzcFXKkriUUekrjE4fwNdVkn
	 3RAn/O5C7qV5wR8KP+FawsXRQxzwFv5cPNG9ctj9TON0QugsntwPkM32OSmb1h015a
	 rwbbe1M+cKwQpq6eoFjd1Q9QONHePLxLOT3LZ24E=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH v6 7/9] mshv: detect and report SEV-SNP support at init
Date: Fri, 18 Sep 2026 11:57:19 +0000
Message-ID: <20260918115741.3791682-8-weh@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918115741.3791682-1-weh@linux.microsoft.com>
References: <20260908121403.1160280-1-weh@linux.microsoft.com>
 <20260918115741.3791682-1-weh@linux.microsoft.com>
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

Use the kernel CONFIG_X86_64 symbol rather than a compiler architecture
macro for the x86-only SNP reporting code. The exported UAPI continues
to use the compiler target macro because CONFIG_* symbols may not leak
to userspace and the architecture-specific member names must remain.
There is no layout or behavior change.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/mshv_root_main.c | 108 +++++++++++++++++++++++++++++++++++-
 1 file changed, 107 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index cb090c380b97..12b9d410dde5 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -101,6 +101,8 @@ static const struct file_operations mshv_dev_fops = {
 	.llseek = noop_llseek,
 };
 
+static bool mshv_ready;
+
 static struct miscdevice mshv_dev = {
 	.minor = MISC_DYNAMIC_MINOR,
 	.name = "mshv",
@@ -3145,7 +3147,8 @@ static long mshv_dev_ioctl(struct file *filp, unsigned int ioctl,
 static int
 mshv_dev_open(struct inode *inode, struct file *filp)
 {
-	return 0;
+	/* Pairs with init's release after all device state is ready. */
+	return smp_load_acquire(&mshv_ready) ? 0 : -EAGAIN;
 }
 
 static int
@@ -3291,6 +3294,104 @@ static int mshv_root_scheduler_cleanup(unsigned int cpu)
 }
 
 /* Must be called after retrieving the scheduler type */
+#ifdef CONFIG_X86_64
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
@@ -3394,6 +3495,8 @@ static int __init mshv_parent_partition_init(void)
 	if (ret)
 		goto synic_cleanup;
 
+	mshv_check_sev_snp_support(dev);
+
 	ret = root_scheduler_init(dev);
 	if (ret)
 		goto synic_cleanup;
@@ -3410,6 +3513,8 @@ static int __init mshv_parent_partition_init(void)
 	hash_init(mshv_root.pt_htable);
 
 	hv_setup_mshv_handler(mshv_isr);
+	/* Publish all initialized state before accepting device opens. */
+	smp_store_release(&mshv_ready, true);
 
 	return 0;
 
@@ -3426,6 +3531,7 @@ static int __init mshv_parent_partition_init(void)
 
 static void __exit mshv_parent_partition_exit(void)
 {
+	WRITE_ONCE(mshv_ready, false);
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
 	mshv_debugfs_exit();
-- 
2.43.0

