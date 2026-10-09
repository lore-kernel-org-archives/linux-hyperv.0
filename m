Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7FE444C65B;
	Fri,  9 Oct 2026 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791541360; cv=none; b=kkZmCw7Z4rYjlTgWJWFBhuc7PuEGcM1ufvFG7zAC4VlFVtIbi3QoP5/BRWxi6qV3EGsy5WSbr9K4g2wYD8F71+mE0LXW0lIbFP+Zt042KZQ/UvoiBlPwIG4yXbvqFQIHCgLu3yQoin7uJ/8knpnTI0qQb53iXsMrKhrpW7SH5xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791541360; c=relaxed/simple;
	bh=o4DLyYDU/HDsMjgvFIBUiG2/yY0Jx58vWPTOnXe8fqs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pQ38uyl3V/ZEKlScDIb59sheS4WHgfpahQFk1qCZ0BKFwcV1MmAbA2vPRfn8twqjF3gtSAINkPZvqCkujh+ip0CA5X3rioZ62kocfv1RBz56tt98uOEWAhiboS4Ts0qGbWeK9GDO9dnBDHtE6LGXldrt3cdCofKY8E9civMFAf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ZW30kdqy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ZW30kdqy"
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id CA3CE20B7168; Fri,  9 Oct 2026 03:22:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA3CE20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791541357;
	bh=/u+W/q014IW8dyqef7naigWPTxu03SqdYawuKAyTR1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZW30kdqyNSg9txUY4QT7DBVcH3KLfEi7h8/n/Bzrx+VxqpUTiFhvz5WNuQzEZ1RhK
	 K5/VETnOFunvBPUSTU4oUF16tspipb/qY1X9/IdDDpDLlBaWzwxgulu4LSidCFVUmy
	 PNdLvam8OuH3YHyfOnx7U459RQJYIvnoS3TGhp0g=
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: mhklinux@outlook.com,
	wei.liu@kernel.org,
	catalin.marinas@arm.com,
	baoquan.he@linux.dev
Cc: Shradha Gupta <shradhagupta@linux.microsoft.com>,
	will@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	longli@microsoft.com,
	akpm@linux-foundation.org,
	rppt@kernel.org,
	pasha.tatashin@soleen.com,
	pratyush@kernel.org,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	arnd@arndb.de,
	hpa@zytor.com,
	maz@kernel.org,
	mark.rutland@arm.com,
	linux-hyperv@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org,
	broonie@kernel.org,
	kees@kernel.org,
	brads@mainlining.org,
	namjain@linux.microsoft.com
Subject: [PATCH v4 1/2] kexec: Add helper to report an active kexec reboot
Date: Fri,  9 Oct 2026 03:22:32 -0700
Message-ID: <20261009102236.3361019-1-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
References: <20261009102215.3360863-1-shradhagupta@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A shutdown callback in a loadable module may need to distinguish a
kexec reboot from a normal restart, halt, or poweroff. The Hyper-V
VMBus driver needs this distinction when moving its kexec cleanup into
a common syscore shutdown callback.

Add kexec_is_in_progress() and export it to GPL modules so the callback
can remain guarded when VMBus is built as a module. Provide a false
inline implementation when CONFIG_KEXEC_CORE is disabled.

The helper reports only the normal kexec reboot path. Crash kexec and
preserve-context kexec do not set this state.

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Bradley Morgan <brads@mainlining.org>
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
---
 include/linux/kexec.h | 2 ++
 kernel/kexec_core.c   | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/include/linux/kexec.h b/include/linux/kexec.h
index 8a22bc9b8c6c..827a5311d97a 100644
--- a/include/linux/kexec.h
+++ b/include/linux/kexec.h
@@ -468,6 +468,7 @@ bool kexec_load_permitted(int kexec_image_type);
 
 /* flag to track if kexec reboot is in progress */
 extern bool kexec_in_progress;
+bool kexec_is_in_progress(void);
 
 #ifndef page_to_boot_pfn
 static inline unsigned long page_to_boot_pfn(struct page *page)
@@ -544,6 +545,7 @@ static inline void *kimage_map_segment(struct kimage *image, int idx)
 { return NULL; }
 static inline void kimage_unmap_segment(void *buffer) { }
 #define kexec_in_progress false
+static inline bool kexec_is_in_progress(void) { return false; }
 #endif /* CONFIG_KEXEC_CORE */
 
 #ifdef CONFIG_KEXEC_SIG
diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index dc770b9a6d05..282c7b3c6c35 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -23,6 +23,7 @@
 #include <linux/hardirq.h>
 #include <linux/elf.h>
 #include <linux/elfcore.h>
+#include <linux/export.h>
 #include <linux/utsname.h>
 #include <linux/numa.h>
 #include <linux/suspend.h>
@@ -54,6 +55,12 @@ atomic_t __kexec_lock = ATOMIC_INIT(0);
 /* Flag to indicate we are going to kexec a new kernel */
 bool kexec_in_progress = false;
 
+bool kexec_is_in_progress(void)
+{
+	return kexec_in_progress;
+}
+EXPORT_SYMBOL_GPL(kexec_is_in_progress);
+
 bool kexec_file_dbg_print;
 
 /*
-- 
2.43.0
