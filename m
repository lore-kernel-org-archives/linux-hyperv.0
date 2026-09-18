Received: from mail-qk2-f43.google.com (mail-qk2-f43.google.com [74.125.230.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E004538D6A8
	for <linux-hyperv@vger.kernel.org>; Fri, 18 Sep 2026 01:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695628; cv=none; b=VkoI+j1TkaCsOB8/fRetS0iuxfoeI2xCa9jKgOldZ/H2C2YKexDllnVr4PglNPLtUtrNlh8t5Zf06f4+Z0NHtDJyNRxe8asKvx/nojQJ5yXBiNiJCC9FBJ6M/NDuPdspy5eF30qilzLXTgZ02EIJuoKq8GyrRJtO8AHMmEyRcBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695628; c=relaxed/simple;
	bh=yTYDUqcwFkJ+mQb7ZSXeToQmp7rvyhF0lR3QiMuHDOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tq7DME+1Iqlw4oOxlMmKsAyuaFWJbBbrxmR1CuZDG2nGVHqrzcTRf8nbEuaTzbjMRbeGPuerMJFus/LKwH0Qbph7IOGePzhTqyUL5vXSBbuh/vDCDJ82DmGRISffeO5l/U5r54qSes2/fTjai5dbBgNrJj+JotEF6belrF4rCIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G3cKMRhH; arc=none smtp.client-ip=74.125.230.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G3cKMRhH"
Received: by mail-qk2-f43.google.com with SMTP id af79cd13be357-939eb3249c1so21594185a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 17 Sep 2026 18:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789695624; x=1790300424; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VokQt3PCInSeNOo/Tg+pYrBPXpRCo2iy3+S4MYEH2ts=;
        b=G3cKMRhHmK/SGKz0h0viXnysKeawPZSfE4NhKkKDoPDD0qJlZfBj0RnUSFuVigMOIx
         x2fOlu1UtX4SLyOykAdsVbaXxSlJ6Kx6KRYubvsLi48YKMkR9it0eAMtJjdS5+kuT0U2
         TN/fi5RIp6/5S4jgDjgpxy39/GhayU3LQe0q+e906uJuIa9KJn6no07zV/6eeevSqWY5
         4GEKGSAvYsXndGjU4PcluIs0/vpHXrncI22bivrIEPutREW9wHg72ASizTxRfJ+V+fsk
         AjH/0xTORnkqE8NB/WqLYYFzSTyOgkz3bAJN4x3tgWK4cKP5aUMDs0D2SeT46ZBciWSk
         XSdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789695624; x=1790300424;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VokQt3PCInSeNOo/Tg+pYrBPXpRCo2iy3+S4MYEH2ts=;
        b=e1niWKPSkVyi2zdkhTCdJOTobwO4VQKiUJUDX2s8G8DNTYlaY2tkK+sQMnonEV4hkE
         CazLhlWAKn+WggKrfWrkwTsOKpkPgImEYWAubgq6dv35tMSPaYfwSfBuarAu0uEvWrbI
         Hacp3IqUsGk8VJb1C6QPvuCWfTT8H/jYHBLsDO9YUP6pic/sEk6eIU0jZ/KnLsygHn3p
         wo0jocTT0q/j6taHSsdMvdrqrApY4OH/5Xq8uPPpGIxbrz420tVKhz7Bz5rkG/9lUQXc
         vuiUeTtTiPIkSrqYGJe8x/5eu6MfYZgxjzrcUzGEZJd8sPbMfT7m4RA5D4wDKhJ3mABc
         4OnQ==
X-Gm-Message-State: AFuF++lpps5rcUUz7/zMudUSy/6t687aiAAMqH47mBahcBZLCpU7Xi5Q
	h+Y/P2dsUvCEuwWG96dHs54GPVO08c32lfYEdmslin69o+zVi5GEpkXD/TnpPCsoDxU=
X-Gm-Gg: AYBFou1bOk5AZllRQxX9nmW4cISf9KwuoJrHe0+tfPbvwnrG8ZWpNTddqFWoxXKturO
	IP4Nf3BrqYx3+O4FDYqB25Hmu1pL2oS3IBq4NW+e7p4FPRWtGa2/1WMiCypF6H2cNQt8qvKRAML
	05fH2wQZMwW7yTwxqHYecVCqfZGWnMBOmpUvN9wQjSU7ZS8osoAm7JjW288KJhnoiqykmg/51Pf
	dJlVhcIrGITO6ViKJqpULdgP4lj+13ydHXZDpvaAxsnQvWUv3VBw7EX5OuQHY4bfeaIq220weqv
	EQZYoOIXIbQEzULwAxN9DHEBHvsdLvvxb10ev9K4a61uI0UkRWKuRZY0U1PVce7T7Inhzg4/H2v
	HUXNgZCfgQSt9sNmBHiDBYDscvh/z0Bsb/XVBYSL3CxZA9beQVxt87K83Tbc9KcaNqwzLv+TSwz
	6Y6ibR+1gaiROOMPARfG86TMOGqKAnXv1gf3GvLAZEQVQcWBJFhl4f5LxMcbxfDluMHBKq3oQds
	0MjqtYq4r55klAkxdYiyQ==
X-Received: by 2002:a05:620a:3187:b0:93b:cb6d:6d73 with SMTP id af79cd13be357-93bdc730deemr128890985a.32.1789695624426;
        Thu, 17 Sep 2026 18:40:24 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([148.222.209.140])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0e4f987sm13002285a.14.2026.09.17.18.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:40:23 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: linux-hyperv@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-kernel@vger.kernel.org,
	emersonbusson@gmail.com
Subject: [PATCH 1/2] hv: vmbus: prevent control-plane starvation and balloon thrash under memory pressure
Date: Thu, 17 Sep 2026 22:40:16 -0300
Message-ID: <20260918014017.2536753-2-emersonbusson@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918014017.2536753-1-emersonbusson@gmail.com>
References: <20260918014017.2536753-1-emersonbusson@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Under Microsoft WSL2 and Hyper-V guest environments, workloads
generating heavy memory allocation and rapid page dirtiness can drive
the guest kernel into aggressive direct reclaim. When guest available
memory drops below critical thresholds (~400-512 MB), atomic page
allocations (GFP_ATOMIC) for synthetic VMBus packet rings, virtual
networking (netvsc), and balloon management fail.

Because the guest is unable to allocate atomic buffers to service host
heartbeats, the Windows Host Compute System (HCS) and Hyper-V watchdog
infer that the guest kernel has hard-locked. This triggers an abrupt
virtual network switch teardown (Hyper-V-VmSwitch Event 102/291) and
forces a VM restart before the guest Linux OOM killer can intervene.

Furthermore, under such memory pressure, the host balloon driver may
simultaneously request balloon inflation, exacerbating memory
starvation.

This patch addresses the issue in two architecture-neutral ways:
1. Auto-calibrates `vm.min_free_kbytes` during `late_initcall` via
   `ms_hyperv_init_memory_headroom` in `drivers/hv/hv_common.c` to a
   dynamic floor scaled to total guest RAM (clamped between 64 MiB and
   512 MiB). Running as `late_initcall` ensures `totalram_pages()` is
   fully cataloged. This guarantees that physical pages remain
   permanently reserved for kernel atomic allocations and VMBus
   communication.
2. Introduces a memory pressure check in `drivers/hv/hv_balloon.c` to
   defer balloon inflation whenever available memory drops below the
   critical threshold (`totalram_pages() / 32`), avoiding competing
   with kswapd.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
 drivers/hv/hv_balloon.c | 12 ++++++++++++
 drivers/hv/hv_common.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index 2b4080e51..41cf97329 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -26,6 +26,7 @@
 #include <linux/percpu_counter.h>
 #include <linux/page_reporting.h>
 #include <linux/sizes.h>
+#include <linux/mm.h>
 
 #include <linux/hyperv.h>
 #include <hyperv/hvhdk.h>
@@ -1205,6 +1206,17 @@ static unsigned int alloc_balloon_pages(struct hv_dynmem_device *dm,
 	unsigned int i, j;
 	struct page *pg;
 
+	/*
+	 * Defer balloon inflation if guest is in critical reclaim zone.
+	 * Competing with kswapd under pressure starves VMBus channels.
+	 * Evaluates against 3.125% of total system RAM to avoid forbidden
+	 * out-of-core extern mutations while maintaining memory headroom.
+	 */
+	if (si_mem_available() < (totalram_pages() / 32)) {
+		pr_warn_ratelimited("hv_balloon: balloon inflation deferred; guest memory constrained\n");
+		return 0;
+	}
+
 	for (i = 0; i < num_pages / alloc_unit; i++) {
 		if (bl_resp->hdr.size + sizeof(union dm_mem_page_range) >
 			HV_HYP_PAGE_SIZE)
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 71fd3ea4f..8a7ee00b6 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -28,6 +28,8 @@
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <linux/set_memory.h>
+#include <linux/mm.h>
+#include <linux/init.h>
 #include <hyperv/hvhdk.h>
 #include <asm/mshyperv.h>
 
@@ -397,6 +399,36 @@ int __init hv_common_init(void)
 	return 0;
 }
 
+extern int min_free_kbytes;
+extern void setup_per_zone_wmarks(void);
+
+/*
+ * Ensure sufficient atomic page headroom for Hyper-V synthetic devices
+ * (vmbus, netvsc, balloon) to prevent host watchdog timeouts under pressure.
+ */
+static int __init ms_hyperv_init_memory_headroom(void)
+{
+	unsigned long total_ram_kb;
+	unsigned long min_headroom_kb;
+
+	if (!hv_is_hyperv_initialized())
+		return 0;
+
+	total_ram_kb = totalram_pages() * (PAGE_SIZE / 1024);
+	/* Scale headroom: 3.125% of RAM, clamped between 64MB and 512MB */
+	min_headroom_kb = clamp_t(unsigned long, total_ram_kb / 32, 64 * 1024, 512 * 1024);
+
+	if (min_free_kbytes < min_headroom_kb) {
+		pr_info("Hyper-V: Calibrating min_free_kbytes from %d kB to %lu kB for VMBus resilience\n",
+			min_free_kbytes, min_headroom_kb);
+		min_free_kbytes = min_headroom_kb;
+		setup_per_zone_wmarks();
+	}
+
+	return 0;
+}
+late_initcall(ms_hyperv_init_memory_headroom);
+
 void __init ms_hyperv_late_init(void)
 {
 	struct acpi_table_header *header;
-- 
2.43.0

