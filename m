Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E5F2F7478;
	Mon, 27 Apr 2026 21:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777325948; cv=none; b=sSEDC6K5TgpxEvoEkPyyj7m0ocxro2rcBiGF2KYdW9/BesOc2d2Ty7ahqolf99jfOy9V42fl7q9nwylp5TT+cmZz01Db3ffcOYAFZaJyyRuXM/yulD80UI4zkg3omsRUzNOrtdsrLtSJK7/8UJne1nZRXy6cB/1nZymr3a2fCSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777325948; c=relaxed/simple;
	bh=ny9woKp0lrLrSl+9ije4IknRSOGyFCaG5JEYVdszq6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d2UhkqoxPdXYj5rv/j6KaU4Gxr8kDxbgfqxWdgINqCZG60Yy3xi7itGZjIlH8jKXdXkDGWGWOxvZJlZzyQw0J0Z3e40n9J7uCHJWixyeS51Fg91tSRX9oa/KcrtaAEWlRW5V7HIA18xdISMxds+WKazZphTDe1C6SCytRS80akU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=rgyKgl2z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rgyKgl2z"
Received: by linux.microsoft.com (Postfix, from userid 1241)
	id 14BB820B716E; Mon, 27 Apr 2026 14:39:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14BB820B716E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777325948;
	bh=WjbsyPcbkPWlgcmtLEdRlz2v/bWtPzITPGiPjIFt4sg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rgyKgl2zQHwHB+D7Ss5CyFAdAZOkE8iCWveSN5j+5QZFNxXxwElw88+5xChY0j7Dh
	 my6R2dUVFmbkAXYEgVDNvschHxRYWDN6fPcqN4S8W7mp5Y3+iZe0w+pdV8bHu3bC5G
	 h9fbCndN5shlO5Sg60P6h0EReQPuUQ8XEGyPwnu8=
From: Jork Loeser <jloeser@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: x86@kernel.org,
	"K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Michael Kelley <mhklinux@outlook.com>,
	Anirudh Rayabharam <anirudh@anirudhrb.com>,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	Jork Loeser <jloeser@linux.microsoft.com>
Subject: [PATCH v4 3/3] mshv: unmap debugfs stats pages on kexec
Date: Mon, 27 Apr 2026 14:38:54 -0700
Message-ID: <20260427213855.1675044-4-jloeser@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
References: <20260427213855.1675044-1-jloeser@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On L1VH, debugfs stats pages are overlay pages: the kernel allocates
them and registers the GPAs with the hypervisor via
HVCALL_MAP_STATS_PAGE2. These overlay mappings persist in the
hypervisor across kexec. If the kexec'd kernel reuses those physical
pages, the hypervisor's overlay semantics cause a machine check
exception.

Fix this by calling mshv_debugfs_exit() from the reboot notifier,
which issues HVCALL_UNMAP_STATS_PAGE for each mapped stats page before
kexec. This releases the overlay bindings so the physical pages can be
safely reused. Guard mshv_debugfs_exit() against being called when
init failed.

Signed-off-by: Jork Loeser <jloeser@linux.microsoft.com>
---
 drivers/hv/mshv_debugfs.c | 7 ++++++-
 drivers/hv/mshv_synic.c   | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_debugfs.c b/drivers/hv/mshv_debugfs.c
index 418b6dc8f3c2..3c3e02237ae9 100644
--- a/drivers/hv/mshv_debugfs.c
+++ b/drivers/hv/mshv_debugfs.c
@@ -674,8 +674,10 @@ int __init mshv_debugfs_init(void)
 
 	mshv_debugfs = debugfs_create_dir("mshv", NULL);
 	if (IS_ERR(mshv_debugfs)) {
+		err = PTR_ERR(mshv_debugfs);
+		mshv_debugfs = NULL;
 		pr_err("%s: failed to create debugfs directory\n", __func__);
-		return PTR_ERR(mshv_debugfs);
+		return err;
 	}
 
 	if (hv_root_partition()) {
@@ -710,6 +712,9 @@ int __init mshv_debugfs_init(void)
 
 void mshv_debugfs_exit(void)
 {
+	if (!mshv_debugfs)
+		return;
+
 	mshv_debugfs_parent_partition_remove();
 
 	if (hv_root_partition()) {
diff --git a/drivers/hv/mshv_synic.c b/drivers/hv/mshv_synic.c
index 978a1cace341..88170ce6b83f 100644
--- a/drivers/hv/mshv_synic.c
+++ b/drivers/hv/mshv_synic.c
@@ -723,6 +723,7 @@ mshv_unregister_doorbell(u64 partition_id, int doorbell_portid)
 static int mshv_synic_reboot_notify(struct notifier_block *nb,
 			      unsigned long code, void *unused)
 {
+	mshv_debugfs_exit();
 	cpuhp_remove_state(synic_cpuhp_online);
 	return 0;
 }
-- 
2.43.0

