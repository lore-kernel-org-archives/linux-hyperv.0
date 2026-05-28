Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7D3196C7C;
	Thu, 28 May 2026 00:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928948; cv=none; b=sM77ze4xyaCrfB+oo3UHIn06+O9o1RWRYvaCNwYE1C+dg8bFOVqc1boByEBffNF4lf1SxQh5oXIpURrNm+Lbc0OtvHxnCJGUeoqlU6pO1R7jMPCk9AovXGizfM8/vPjVCiBlvYseIKeiT+OeXVDfwDhvRFeYdu1VIUAVqVg3O7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928948; c=relaxed/simple;
	bh=oLB/5Vzdh/9Wbb70DhXCyqrFo7zLDuIhMP/NXkSGDhs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tvchslt6f1X3ozrv8l528/hB1NjZk/xPQCZGayXTGfldKw1SXGP+mCRho9GpMYO4s81fbEtFcWX9eaYm3dkDalLlvsT3Ty94MhoCm+/E/v+aGNf0Yq2H0PAvORZQGpPJnwPtZvWAnIzwoCZFc2mllDG6UGPVv2PSGPX2cB4CvYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CZTqfsUm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CZTqfsUm"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id D9FB720B716A; Wed, 27 May 2026 17:42:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D9FB720B716A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928936;
	bh=UVWiM4xIUXWQ8VX4lQw/ZW4DJ6yNUs4CT4NEYGNtMTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZTqfsUmcLLXJT7YbU5UN7KLqaA6BUVha/oeK47UmZZXNYo/M9YmHZPL+JhzXFPDl
	 RWF8g92V93FnpwT+SmnnZeHh/vF+yOyFDUxwz1pmiBwtOYjGVvrjhDig9SvmrS9iOD
	 5izCOplWYR99E1vx1VZ1orE4q8bJcRWFlJ9ijylo=
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
Subject: [RFC PATCH 08/20] kho: add kho_radix_init_tree()
Date: Wed, 27 May 2026 17:41:50 -0700
Message-ID: <20260528004204.1484584-9-jloeser@linux.microsoft.com>
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

From: "Pratyush Yadav (Google)" <pratyush@kernel.org>

Move the initialization logic of the radix tree into
kho_radix_init_tree() instead of having users open-code it. Makes the
boundaries cleaner and reduces code duplication when a new user of the
radix tree will be added in a future commit.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 include/linux/kho_radix_tree.h     |  7 ++++++
 kernel/liveupdate/kexec_handover.c | 37 ++++++++++++++++++++++++++++--
 2 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/linux/kho_radix_tree.h b/include/linux/kho_radix_tree.h
index 617395a6647a..c0840ecb230c 100644
--- a/include/linux/kho_radix_tree.h
+++ b/include/linux/kho_radix_tree.h
@@ -54,6 +54,7 @@ int kho_radix_add_key(struct kho_radix_tree *tree, unsigned long key);
 void kho_radix_del_key(struct kho_radix_tree *tree, unsigned long key);
 int kho_radix_walk_tree(struct kho_radix_tree *tree,
 			const struct kho_radix_walk_cb *cb, void *data);
+int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root);
 void kho_radix_destroy_tree(struct kho_radix_tree *tree);
 
 #else  /* #ifdef CONFIG_KEXEC_HANDOVER */
@@ -72,6 +73,12 @@ static inline int kho_radix_walk_tree(struct kho_radix_tree *tree,
 	return -EOPNOTSUPP;
 }
 
+static inline int kho_radix_init_tree(struct kho_radix_tree *tree,
+				      struct kho_radix_node *root)
+{
+	return 0;
+}
+
 static inline void kho_radix_destroy_tree(struct kho_radix_tree *tree) { }
 
 #endif /* #ifdef CONFIG_KEXEC_HANDOVER */
diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 3f3ea71baa1a..b2d1572808eb 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -305,6 +305,34 @@ static void __kho_radix_destroy_tree(struct kho_radix_node *root,
 	kho_radix_free_node(root);
 }
 
+/**
+ * kho_radix_init_tree - initialize the radix tree.
+ * @tree:   the tree to initialize.
+ * @root:   root table of the radix tree.
+ *
+ * Initialize the radix tree with the given root node. If root is %NULL, an
+ * empty root table is allocated. If root is not %NULL, it is the caller's
+ * responsibility to make sure the root is valid and in the correct format.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+int kho_radix_init_tree(struct kho_radix_tree *tree, struct kho_radix_node *root)
+{
+	/* Already initialized. */
+	if (tree->root)
+		return 0;
+
+	if (!root)
+		root = kho_radix_alloc_node();
+	if (!root)
+		return -ENOMEM;
+
+	tree->root = root;
+	mutex_init(&tree->lock);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(kho_radix_init_tree);
+
 /**
  * kho_radix_destroy_tree - Destroy the radix tree
  * @tree: The radix tree to destroy
@@ -1467,9 +1495,14 @@ static int __init kho_mem_retrieve(const void *fdt)
 	const struct kho_radix_walk_cb cb = {
 		.key = kho_preserved_memory_reserve,
 	};
+	phys_addr_t mem_map_phys;
+	int err;
+
+	mem_map_phys = kho_get_mem_map_phys(fdt);
+	err = kho_radix_init_tree(&kho_in.radix_tree, phys_to_virt(mem_map_phys));
+	if (err)
+		return err;
 
-	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
-	mutex_init(&kho_in.radix_tree.lock);
 	return kho_radix_walk_tree(&kho_in.radix_tree, &cb, NULL);
 }
 
-- 
2.43.0

