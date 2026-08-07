Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC37383993;
	Fri,  7 Aug 2026 13:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110767; cv=none; b=q+a9Y96fvnIvuceKq6F366XjWKRGAjAj/3bq0hgj/k3gOutScvcj0tDvEhjYOA4VnP+SolX73NJD31w18pipz7PszgBJEW/S/onDs6nitNXWdpYby6i918qhVqy43Yu9Fl4EPeleuNuayHV5elKbGXkAXoUVNsiyzSV7SPMCPv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110767; c=relaxed/simple;
	bh=CvR3+VBY1oFbfU/EabdJiumfXnNtIqDSA+8ryR2MlXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dFNOKmp6JAUIcNLtjBrVSu4tnAVokAmv2BJdWT52MjuBwbfbdfTb81K6k+ZrzATWq6NG8LCT3d+SjBE8LZn+UtOWxPDcathZxvkdsR78chY2InjZfpv0dmtuf9uByrkSASfB5/NhzNkEzJsVIgK3Ust9wS74dc0fmqwpiolBecs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=IahHpvBI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="IahHpvBI"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1C92720B7135;
	Fri,  7 Aug 2026 06:52:12 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1C92720B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786110732;
	bh=GZh9tzMrtI4AZuB23eu+L+zDaDDRvLybIV7SJSMRbrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IahHpvBIqZobDLLFduCMiUhxQM58Y6+gfRxPHBcbJ6yXcLmow16s28VKneSlD5Qh3
	 42XKgmMfY6pEk8v5/83jKOuVKETOYZX30ULu8dRG8WeA0AN6HQha2PqBCBZ2D/wxu6
	 6JvxQb/BBgoDrl3r2YVtNCB6BiZSq5i+k9YHyarE=
From: Wei Hu <weh@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v1 11/13] mshv: unlock SNP pages on panic for crashdump collection
Date: Fri,  7 Aug 2026 13:51:17 +0000
Message-ID: <20260807135134.303943-12-weh@linux.microsoft.com>
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

From: Wei Hu <weh@microsoft.com>

Add an SNP panic-path page-unlock feature so a root partition running
confidential (SEV-SNP) guests can still collect a Linux root vmcore via
kexec after a crash. On panic, guest pages of every encrypted partition
are unmapped and shared back to the host so kexec can read them.

Register a panic notifier that walks mshv_root.pt_htable and, for each
encrypted partition, unmaps each memory region and marks it shared again.
The notifier is only registered when the hypervisor's own crash path is
not active (hv_crash_enabled) and only built when CONFIG_CRASH_DUMP is
enabled. Declare hv_crash_enabled in asm/mshyperv.h alongside the other
MSHV crashdump symbols.

Tested on a SEV-SNP Dom0: the notifier only runs in its intended fallback
path, i.e. when the hypervisor's own kdump support is inactive
(hv_crash_enabled == false); when it is active the hypervisor stops the
CPUs and kexecs before the Linux panic_notifier_list runs. To exercise the
ported code that fallback was reproduced on a test kernel (hypervisor crash
init disabled so hv_crash_enabled == false). With a confidential guest
running, an intentional Dom0 panic showed the notifier fire, find the
encrypted partition, and unlock its regions with no errors ("SNP pages are
unlocked for panic", no "Unlock snp failed"), after which kdump collected a
valid, readable vmcore. The default active-hypervisor path was also
confirmed to boot cleanly with the notifier correctly not registered.

Signed-off-by: Wei Hu <weh@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h |  1 +
 drivers/hv/mshv_root_main.c     | 71 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f64393e853ee..052cc44ae1f0 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -240,6 +240,7 @@ static __always_inline u64 hv_raw_get_msr(unsigned int reg)
 int hv_apicid_to_vp_index(u32 apic_id);
 
 #if IS_ENABLED(CONFIG_MSHV_ROOT) && IS_ENABLED(CONFIG_CRASH_DUMP)
+extern bool hv_crash_enabled;
 void hv_root_crash_init(void);
 void hv_crash_asm32(void);
 void hv_crash_asm64(void);
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 0fbd2158968d..4d08d547704e 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2898,6 +2898,74 @@ static int __init mshv_init_vmm_caps(struct device *dev)
 	return 0;
 }
 
+#if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_CRASH_DUMP)
+static void mshv_panic_unlock_snp(struct mshv_partition *vm)
+{
+	struct mshv_mem_region *memreg;
+	int ret;
+
+	hlist_for_each_entry(memreg, &vm->pt_mem_regions, hnode) {
+		mshv_region_unmap(memreg);
+		ret = mshv_region_share(memreg);
+		if (ret)
+			pt_err(vm, "Unlock snp failed. ret:0x%x gfn:%llx numpfns:%lld\n",
+			       ret, memreg->start_gfn, memreg->nr_pages);
+	}
+}
+
+static int mshv_root_panic_cb(struct notifier_block *this, unsigned long event,
+			      void *ptr)
+{
+	int i, done = 0;
+	struct mshv_partition *pt;
+	struct device *dev = NULL;
+
+	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
+		if (!mshv_partition_encrypted(pt))
+			continue;
+
+		done = 1;
+		mshv_panic_unlock_snp(pt);
+		dev = pt->pt_module_dev;
+	}
+	if (done && dev)
+		dev_info(dev, "SNP pages are unlocked for panic\n");
+
+	return NOTIFY_DONE;
+}
+
+static struct notifier_block mshv_root_panic_blk = {
+	.notifier_call = mshv_root_panic_cb,
+};
+
+/*
+ * If mshv devirt setup failed during boot, or the feature itself is not
+ * available, allow the system to at least collect linux root vmcore. For
+ * that, snp guest pages must be made readable in the panic path so kexec can
+ * collect them.
+ */
+static void mshv_crashdump_init(void)
+{
+	if (hv_crash_enabled)
+		return;
+
+	atomic_notifier_chain_register(&panic_notifier_list,
+				       &mshv_root_panic_blk);
+}
+
+static void mshv_crashdump_deinit(void)
+{
+	if (hv_crash_enabled)
+		return;
+
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &mshv_root_panic_blk);
+}
+#else
+static void mshv_crashdump_init(void) {}
+static void mshv_crashdump_deinit(void) {}
+#endif
+
 static int __init mshv_parent_partition_init(void)
 {
 	int ret;
@@ -2957,6 +3025,8 @@ static int __init mshv_parent_partition_init(void)
 
 	hv_setup_mshv_handler(mshv_isr);
 
+	mshv_crashdump_init();
+
 	return 0;
 
 exit_debugfs:
@@ -2972,6 +3042,7 @@ static int __init mshv_parent_partition_init(void)
 
 static void __exit mshv_parent_partition_exit(void)
 {
+	mshv_crashdump_deinit();
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
 	mshv_debugfs_exit();
-- 
2.43.0

