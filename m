Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 728092253EB;
	Thu, 28 May 2026 00:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928959; cv=none; b=F3koM5tbfrsX95XWkImnum+S3XUjh5cUKnP08h2s4WZd5WrG+SIjSenHbZ94r/7EqHJnTkAWT8Mdwxk7TNbAoLwqXE6LRewqkY5bICCd8SLmflQ0A0vHuPbtwqo3tu9CS+xdhRTHTyqrOoSUGnBnxfVEl+/Io3NaayO07BpynEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928959; c=relaxed/simple;
	bh=ECFAphWZWIlRYq6BkTkPa7XGJy+w4xMBvXRyWy8df3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AHK8vA9ePwqBStyPAOT8HHx/IIJIm4Ze30/xND79xtHmDCZq4Ix0TcqGTNVWRMKR7IS0wozZY1fa5vbkDqGYennRMnViuZixJMky4HcqWHFpI5EqgO6YPDnK2rAUkGyyAZZgvkWeo2K5io57wh0RmAPFTC61EJgYKwNJg02iDqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=nT1WAQhY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="nT1WAQhY"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 34DCB20B7179; Wed, 27 May 2026 17:42:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 34DCB20B7179
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928941;
	bh=XmiM0zp4RpwFxnSgF35nU0/vhB3kyRAcJWx3icQ9ch4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nT1WAQhYVhGyQcrpwbh+CUuDn4l7hSwQ+9uxGmhB3nC0ccpLqDneLzA5HOAC4gcP0
	 XE/P6+XloPaQe44ldBRelsVosfdKGOxFV4YKTqHcQyjrMNZBuBDzpNthSEaExCfyPe
	 xuDZ/6yBo8hPaZmgKUYioRILvs5pkRdZegB9bmO0=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org,
	kexec@lists.infradead.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Alexander Graf <graf@amazon.com>,
	Jason Miu <jasonmiu@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Baoquan He <bhe@redhat.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Kees Cook <kees@kernel.org>,
	Ran Xiaokai <ran.xiaokai@zte.com.cn>,
	Justinien Bouron <jbouron@amazon.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Pingfan Liu <piliu@redhat.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Kelley <mhklinux@outlook.com>,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [RFC PATCH 13/20] kho: add radix tree freeze and del_key() error reporting
Date: Wed, 27 May 2026 17:41:55 -0700
Message-ID: <20260528004204.1484584-14-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
References: <20260528004204.1484584-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add kho_radix_tree_freeze() to prevent further modifications to a
KHO radix tree. After freezing, kho_radix_add_key() and
kho_radix_del_key() return -EBUSY. This is used by the MSHV page
preservation code to lock the tree before serializing it for kexec.

Also change kho_radix_del_key() from void to int so it can report
-EBUSY (frozen) and -ENOENT (key not present).

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/kho_radix_tree.h     | 24 ++++++++++----
 kernel/liveupdate/kexec_handover.c | 51 +++++++++++++++++++++++-------
 2 files changed, 57 insertions(+), 18 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index c0840ecb230c..4fe2238e1e30 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -21,10 +21,10 @@
  * scheme. Each key is an unsigned long that combines a page's physical
  * address and its order.
  *
- * Client code is responsible for allocating the root node of the tree,
- * initializing the mutex lock, and managing its lifecycle. It must use the
- * tree data structures defined in the KHO ABI,
- * `include/linux/kho/abi/kexec_handover.h`.
+ * Client code must initialize the tree using kho_radix_tree_init(). Pass
+ * a physical address to restore a tree preserved across kexec, or 0 to
+ * allocate a fresh empty tree. The tree uses data structures defined in
+ * the KHO ABI, `include/linux/kho/abi/kexec_handover.h`.
  */
 
 struct kho_radix_node;
@@ -32,6 +32,7 @@ struct kho_radix_node;
 struct kho_radix_tree {
 	struct kho_radix_node *root;
 	struct mutex lock; /* protects the tree's structure and root pointer */
+	bool frozen;
 };
 
 /**
@@ -51,11 +52,12 @@ struct kho_radix_walk_cb {
 #ifdef CONFIG_KEXEC_HANDOVER
 
 int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
-void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
+int kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
 			const struct kho_radix_walk_cb *cb, void *data);
 int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root);
 void kho_radix_destroy_tree(struct kho_radix_tree *tree);
+int kho_radix_tree_freeze(struct kho_radix_tree *tree);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
 
@@ -64,8 +66,11 @@ static inline int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long k
 	return -EOPNOTSUPP;
 }
 
-static inline void kho_radix_del_key(struct kho_radix_tree *tree,
-				     unsigned long key) { }
+static inline int kho_radix_del_key(struct kho_radix_tree *tree,
+				     unsigned long key)
+{
+	return -EOPNOTSUPP;
+}
 
 static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
 				      const struct kho_radix_walk_cb *cb, void *data)
@@ -81,6 +86,11 @@ static inline int kho_radix_init_tree(struct kho_radix_tree *tree,
 
 static inline void kho_radix_destroy_tree(struct kho_radix_tree *tree) { }
 
+static inline int kho_radix_tree_freeze(struct kho_radix_tree *tree)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
 
 #endif	/* _LINUX_KHO_RADIX_TREE_H */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 797ec285b698..2e2b4e73f00d 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -79,9 +79,6 @@ struct kho_out {
 
 static struct kho_out kho_out = {
 	.lock = __MUTEX_INITIALIZER(kho_out.lock),
-	.radix_tree = {
-		.lock = __MUTEX_INITIALIZER(kho_out.radix_tree.lock),
-	},
 };
 
 struct kho_in {
@@ -180,6 +177,28 @@ static void __ref kho_radix_free_node(struct kho_radix_node *node)
 		memblock_free(node, PAGE_SIZE);
 }
 
+/**
+ * kho_radix_tree_freeze - Freeze the tree, preventing further modifications.
+ * @tree: The KHO radix tree to freeze.
+ *
+ * After freezing, kho_radix_add_key() and kho_radix_del_key() will return
+ * -EBUSY. The check is performed under the tree's mutex, so there is no
+ * race between a concurrent add/del and the freeze.
+ *
+ * Return: 0 on success, -EBUSY if the tree is already frozen.
+ */
+int kho_radix_tree_freeze(struct kho_radix_tree *tree)
+{
+	guard(mutex)(&tree->lock);
+
+	if (tree->frozen)
+		return -EBUSY;
+
+	tree->frozen = true;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_radix_tree_freeze);
+
 /**
  * kho_radix_add_key - Add a key to the radix tree.
  * @tree: The KHO radix tree.
@@ -210,6 +229,9 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key)
 
 	guard(mutex)(&tree->lock);
 
+	if (tree->frozen)
+		return -EBUSY;
+
 	/* Go from high levels to low levels */
 	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
 		idx = kho_radix_get_table_index(key, i);
@@ -268,20 +290,26 @@ EXPORT_SYMBOL_GPL(kho_radix_add_key);
  * This function traverses the radix tree and clears the bit corresponding to
  * the key, effectively removing it from the tree. It does not free the tree's
  * intermediate nodes, even if they become empty.
+ *
+ * Return: 0 on success, -EINVAL if the tree is uninitialized, -EBUSY if
+ *         frozen, -ENOENT if the key was not present.
  */
-void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
+int kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 {
 	struct kho_radix_node *node = tree->root;
 	struct kho_radix_leaf *leaf;
 	unsigned int i, idx;
 
 	if (WARN_ON_ONCE(!tree->root))
-		return;
+		return -EINVAL;
 
 	might_sleep();
 
 	guard(mutex)(&tree->lock);
 
+	if (WARN_ON_ONCE(tree->frozen))
+		return -EBUSY;
+
 	/* Go from high levels to low levels */
 	for (i = KHO_TREE_MAX_DEPTH - 1; i > 0; i--) {
 		idx = kho_radix_get_table_index(key, i);
@@ -291,7 +319,7 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 		 * return with a warning.
 		 */
 		if (WARN_ON(!node->table[idx]))
-			return;
+			return -ENOENT;
 
 		node = phys_to_virt(node->table[idx]);
 	}
@@ -300,6 +328,8 @@ void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key)
 	leaf = (struct kho_radix_leaf *)node;
 	idx = kho_radix_get_bitmap_index(key);
 	__clear_bit(idx, leaf->bitmap);
+
+	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_radix_del_key);
 
@@ -346,6 +376,7 @@ int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root
 
 	tree->root = root;
 	mutex_init(&tree->lock);
+	tree->frozen = false;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(kho_radix_init_tree);
@@ -1746,11 +1777,9 @@ static __init int kho_init(void)
 	if (!kho_enable)
 		return 0;
 
-	tree->root = kzalloc(PAGE_SIZE, GFP_KERNEL);
-	if (!tree->root) {
-		err = -ENOMEM;
+	err = kho_radix_init_tree(tree, NULL);
+	if (err)
 		goto err_free_scratch;
-	}
 
 	kho_out.fdt = kho_alloc_preserve(PAGE_SIZE);
 	if (IS_ERR(kho_out.fdt)) {
@@ -1807,7 +1836,7 @@ static __init int kho_init(void)
 err_free_fdt:
 	kho_unpreserve_free(kho_out.fdt);
 err_free_kho_radix_tree_root:
-	kfree(tree->root);
+	free_page((unsigned long)tree->root);
 	tree->root = NULL;
 err_free_scratch:
 	kho_out.fdt = NULL;
-- 
2.43.0

