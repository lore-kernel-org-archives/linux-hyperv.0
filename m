Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC3A92DA775;
	Fri, 31 Jul 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537283; cv=none; b=fuKRtKpooGFZQVKghcLFqNdJULCkcHQagsFgiUqf0sur1EiOtirKfUCHgCuW8j/d0sx0otmzrUib1ZCpoloV4OhuQcx3iVnrshymaFCk4aZ1CSufCIO0Wal9MJ5v5kz1vnsgTMzKFjTc82+jOM4fWAMkU5/+ZcvJ8U3spdFSaiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537283; c=relaxed/simple;
	bh=KjVPu7k1wG9ON+Ir0iYBC5FJbGlX1jAOmPoQVQkbxC8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QWyxv5F1tAjmD4OcshQdcvG5NyQG3iaYbcHjZJGD/ADnQaDb+d5sdjAxzOg7UxMn982yrCktAn8jdWSsKcGyfrApJuXOo7ozlM9ECjTIFZ5nBtSr9JSFYuH/mns0/3QdpeSzhqkNyUc710YbVOToWpVS8TzhrH0+E1QCb/1uSyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=b06P09Qz; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="b06P09Qz"
Received: from mrdev.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1A0AD20B7167;
	Fri, 31 Jul 2026 15:34:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1A0AD20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785537263;
	bh=ycf9VUTo/32xlHMj/ywsMQ/7USDdHeNJ8vtQ7QnKgfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b06P09QzL3iLr5g5+untbg75Myxv8hI+zUeBE1uzB7TswPjaUafBj/nlczWCaKptE
	 l8yk18DO254TmZjT+F+f2qufvtOCPlEWHckSA7neFt7OcOuFFlsN2rRzlexVFlj5Qh
	 VzrTmsapLoFJlxgnTQIKlAWZsaD3zRUu4h0llsCc=
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
Cc: jgg@nvidia.com,
	kys@microsoft.com,
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
	arnd@arndb.de,
	jacob.pan@linux.microsoft.com
Subject: [PATCH v5 1/9] mshv: Provide a way to get partition ID if running in a VMM process
Date: Fri, 31 Jul 2026 15:34:19 -0700
Message-ID: <20260731223427.2554388-2-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Many PCI passthru related hypercalls require partition ID of the target
guest. Guests are actually managed by MSHV driver and the partition ID
is only maintained there. Add a field in the partition struct in MSHV
driver to save the tgid of the VMM process creating the partition, and
add a function there to retrieve partition ID if the current process is
a VMM process. Furthermore, enforce one partition per VMM instance.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 drivers/hv/mshv_root.h         |  1 +
 drivers/hv/mshv_root_main.c    | 33 ++++++++++++++++++++++++++++++++-
 include/asm-generic/mshyperv.h |  5 +++++
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 1f086dcb7aa1..a85c24dcc701 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -138,6 +138,7 @@ struct mshv_partition {
 
 	struct mshv_girq_routing_table __rcu *pt_girq_tbl;
 	u64 isolation_type;
+	pid_t pt_vmm_tgid;
 	bool import_completed;
 	bool pt_initialized;
 #if IS_ENABLED(CONFIG_DEBUG_FS)
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bd1359eb58dd..9b53c476bd83 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1908,17 +1908,48 @@ mshv_partition_release(struct inode *inode, struct file *filp)
 	return 0;
 }
 
+/* Given a process tgid, return partition id if it is a VMM process */
+u64 mshv_current_partid(void)
+{
+	struct mshv_partition *pt;
+	int i;
+	u64 ret_ptid = HV_PARTITION_ID_INVALID;
+
+	rcu_read_lock();
+
+	hash_for_each_rcu(mshv_root.pt_htable, i, pt, pt_hnode) {
+		if (pt->pt_vmm_tgid == current->tgid) {
+			ret_ptid = pt->pt_id;
+			break;
+		}
+	}
+
+	rcu_read_unlock();
+	return ret_ptid;
+}
+EXPORT_SYMBOL_GPL(mshv_current_partid);
+
+/* At present, we only allow one partition per VMM instance */
 static int
 add_partition(struct mshv_partition *partition)
 {
+	int rc = 0;
+
 	spin_lock(&mshv_root.pt_ht_lock);
 
+	if (mshv_current_partid() != HV_PARTITION_ID_INVALID) {
+		rc = -EEXIST;
+		goto out;
+	}
+
+	partition->pt_vmm_tgid = current->tgid;
 	hash_add_rcu(mshv_root.pt_htable, &partition->pt_hnode,
 		     partition->pt_id);
 
+out:
 	spin_unlock(&mshv_root.pt_ht_lock);
 
-	return 0;
+	return rc;
 }
 
 static_assert(MSHV_NUM_CPU_FEATURES_BANKS ==
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bf601d67cecb..e8cbc4e3f7ad 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -350,6 +350,7 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
 int hv_call_notify_all_processors_started(void);
 bool hv_lp_exists(u32 lp_index);
 int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
+u64 mshv_current_partid(void);
 
 #else /* CONFIG_MSHV_ROOT */
 static inline bool hv_root_partition(void) { return false; }
@@ -380,6 +381,10 @@ static inline int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u3
 {
 	return -EOPNOTSUPP;
 }
+static inline u64 mshv_current_partid(void)
+{
+	return HV_PARTITION_ID_INVALID;
+}
 #endif /* CONFIG_MSHV_ROOT */
 
 static inline int hv_deposit_memory(u64 partition_id, u64 status)
-- 
2.51.2.vfs.0.1

