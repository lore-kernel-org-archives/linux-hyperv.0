Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779EE1A704B;
	Thu, 28 May 2026 00:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928942; cv=none; b=o1th27L/rq7wfihSv2KBxPwQWCK1ayQG8a8PBbRSoc2jF+Sfr4wZkGiKWbOWpIuMRAsI6QBkcI8ydyn73b0zz92IObXeTlmj0XqDePK8luJvzdKRO6w83asnDhsbD9IuQhp2/5/znhd3O0ujkODlbMjtbeNvXUvHN5iy5S5x6CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928942; c=relaxed/simple;
	bh=SGn+//tF2d2aqZGH68ri71yEIDUNaGdt3ZXS4r+7TCU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnblCowDt1re8YFIvjmED5S57aEft0VqWT6DxM5Z+1MrSdi1fiPGfhYs1g4KcEYAUFbKXXJpYTjvarmFbAEPSfSh944kQQkHaYJugaeiLHuLyt3uCDr83Su6/sja66vhyPtZGvmIzplu70TOn3FwLHJVMxS3yF7VqFnYG1p3eMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZN1P3v+l; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZN1P3v+l"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id B1F4120B7168; Wed, 27 May 2026 17:42:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1F4120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779928930;
	bh=LKAx22lWxLJue3lv4E7ReRPFqkYia7qQaQqFWyZIB0M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZN1P3v+l0l+8H7iUXRv97ioZfzLcRX5n2BYCalc4XdQfTzJzKsHBTrAS0twFrefA8
	 y3xxufxwz7rIT/66eIP31Y9hKq1h/ZzHxFhA8MhuvEc8jD494fnLG7T2/fZ4LRe2Zo
	 aXK3PrcOYS79OZiEXyZiptW3VLQOYjZTY7wCjKnc=
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
Subject: [RFC PATCH 02/20] kho: store incoming radix tree in kho_in
Date: Wed, 27 May 2026 17:41:44 -0700
Message-ID: <20260528004204.1484584-3-jloeser@linux.microsoft.com>
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

This allows other functions to also use the radix tree. While at it,
also use kho_get_mem_map_phys() instead of duplicating the code to get
the radix tree root from the FDT.

Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 kernel/liveupdate/kexec_handover.c | 27 ++++++++-------------------
 1 file changed, 8 insertions(+), 19 deletions(-)

diff --git a/kernel/liveupdate/kexec_handover.c b/kernel/liveupdate/kexec_handover.c
index 05a6eb56e176..afc986845839 100644
--- a/kernel/liveupdate/kexec_handover.c
+++ b/kernel/liveupdate/kexec_handover.c
@@ -1316,6 +1316,7 @@ struct kho_in {
 	char previous_release[__NEW_UTS_LEN + 1];
 	u32 kexec_count;
 	struct kho_debugfs dbg;
+	struct kho_radix_tree radix_tree;
 };
 
 static struct kho_in kho_in = {
@@ -1395,24 +1396,10 @@ EXPORT_SYMBOL_GPL(kho_retrieve_subtree);
 
 static int __init kho_mem_retrieve(const void *fdt)
 {
-	struct kho_radix_tree tree;
-	const phys_addr_t *mem;
-	int len;
-
-	/* Retrieve the KHO radix tree from passed-in FDT. */
-	mem = fdt_getprop(fdt, 0, KHO_FDT_MEMORY_MAP_PROP_NAME, &len);
-
-	if (!mem || len != sizeof(*mem)) {
-		pr_err("failed to get preserved KHO memory tree\n");
-		return -ENOENT;
-	}
-
-	if (!*mem)
-		return -EINVAL;
-
-	tree.root = phys_to_virt(*mem);
-	mutex_init(&tree.lock);
-	return kho_radix_walk_tree(&tree, kho_preserved_memory_reserve);
+	kho_in.radix_tree.root = phys_to_virt(kho_get_mem_map_phys(fdt));
+	mutex_init(&kho_in.radix_tree.lock);
+	return kho_radix_walk_tree(&kho_in.radix_tree,
+				   kho_preserved_memory_reserve);
 }
 
 static __init int kho_out_fdt_setup(void)
@@ -1619,8 +1606,10 @@ void __init kho_memory_init(void)
 	if (kho_in.scratch_phys) {
 		kho_scratch = phys_to_virt(kho_in.scratch_phys);
 
-		if (kho_mem_retrieve(kho_get_fdt()))
+		if (kho_mem_retrieve(kho_get_fdt())) {
 			kho_in.fdt_phys = 0;
+			kho_in.radix_tree.root = NULL;
+		}
 	} else {
 		kho_reserve_scratch();
 	}
-- 
2.43.0

