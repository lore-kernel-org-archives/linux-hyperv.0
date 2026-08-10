Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F163E317B;
	Mon, 10 Aug 2026 12:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786366003; cv=none; b=Qrz3BTwWeBin8o7n8rRBUfE8x9TftUnALaryT/ZyutI8Fthm3aLx5chvphBFBM8f1II95+kxcL9s/YkHDX/8guHzhWizBsbhtjZ4ZnJLvOglO7GoO1ndv50kgzd4Sh+6hQPx/r5QFTbtimHeS0JSMssNXx8/NUP5rMSlyMuNJsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786366003; c=relaxed/simple;
	bh=N34EW6Ad3+QXgYxwsxPEFvZhMPUTeVjYvlxGBitu+Nc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftzlYslWH867tcF2TzGFHfc2FXHUVjh0nghQA92OBFhJMenDa3mp99bmIzmq9frvz6NUF0ibGHU4e88/e+5E/IBKpJaJHK6To7BrF+jXIFzqEKWJvKTu//jtIb17xzp1kzD6iUqXTTJlPToc+YiOxB0JRwd9dPQ7S/JPdV+wqAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=NCz1T2ij; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="NCz1T2ij"
Received: from weh-cvm-dev-vm.y50bckvjo0hefgfnzfztsfttff.phxx.internal.cloudapp.net (unknown [20.169.55.37])
	by linux.microsoft.com (Postfix) with ESMTPSA id 822E720B7166;
	Mon, 10 Aug 2026 05:46:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 822E720B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1786365978;
	bh=Zfo1/Rm+QRETO2FVt/sg4AGLOV6JC3vJfZqlXr9c6Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCz1T2ijmH7IBVnf61Qgw48/ycGXinPtiq+doH9inG/OAwFzYz9dB6KAkw1fMDH2C
	 DAqcU3ft5vnhMpVA6EhOfIYNdnOli3alBwC2iK0wiblgqvnDmqfrqsECBdWo1LNwjc
	 YE5OAtgo3BfclChZy/7NRO/slcMv3qJ9zU+OtHp8=
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
Subject: [PATCH v2 11/13] mshv: unlock SNP pages on panic for crashdump collection
Date: Mon, 10 Aug 2026 12:45:05 +0000
Message-ID: <20260810124527.1409634-12-weh@linux.microsoft.com>
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
 drivers/hv/mshv_root_main.c     | 78 +++++++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+)

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
index 0dbf509351bb..6b38a45ad43c 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2941,6 +2941,81 @@ static int __init mshv_init_vmm_caps(struct device *dev)
 	return 0;
 }
 
+#if defined(CONFIG_X86_64) && IS_ENABLED(CONFIG_CRASH_DUMP)
+static void mshv_panic_unlock_snp(struct mshv_partition *vm)
+{
+	struct mshv_mem_region *memreg;
+	int ret;
+
+	if (!spin_trylock(&vm->pt_mem_regions_lock)) {
+		pt_err(vm, "Cannot lock SNP memory regions during panic\n");
+		return;
+	}
+
+	hlist_for_each_entry(memreg, &vm->pt_mem_regions, hnode) {
+		mshv_region_unmap(memreg);
+		ret = mshv_region_share(memreg);
+		if (ret)
+			pt_err(vm, "Unlock snp failed. ret:0x%x gfn:%llx numpfns:%lld\n",
+			       ret, memreg->start_gfn, memreg->nr_pages);
+	}
+
+	spin_unlock(&vm->pt_mem_regions_lock);
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
@@ -2998,6 +3073,8 @@ static int __init mshv_parent_partition_init(void)
 
 	hv_setup_mshv_handler(mshv_isr);
 
+	mshv_crashdump_init();
+
 	return 0;
 
 exit_debugfs:
@@ -3013,6 +3090,7 @@ static int __init mshv_parent_partition_init(void)
 
 static void __exit mshv_parent_partition_exit(void)
 {
+	mshv_crashdump_deinit();
 	hv_setup_mshv_handler(NULL);
 	mshv_port_table_fini();
 	mshv_debugfs_exit();
-- 
2.43.0

