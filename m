Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0273C9EC8;
	Wed, 25 Mar 2026 18:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774461869; cv=none; b=E/t0qd5LUV80D+LA02N2xnNFYijexIvL33ZL/FPoPJ+DkvZSxdsTd4KgEp63swOwiL3acQm4d0qsUJcEOIvJZ6PWCac540s3OH+uHEGGO5PWERiIb6xD994Td3Lyu/f6aI1wYF6zoz30JyyojihLuI7Zzg1SUzikMwlNhjHm0Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774461869; c=relaxed/simple;
	bh=4NryRub/aZuAYuASNGHsHJp6QEyUdN2AnoHLj6XBEXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oi5OdhXZeEwA6Sf1ng1ti5XYbOMMYTMLdB6K4k+2pm1K9bW/BZ5TFw1rzMR6cEjUwbbfKmsn1LxWE25lrnaRhEIVrxrxwo/4w96FrFjvuco1DbZ27wKUAAEmZPlLhQFuSCuiGKIDAWlp1pdrhKAX7Uzs4mIXvIZmEgF+SFG3/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WKWiqFtu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WKWiqFtu"
Received: by linux.microsoft.com (Postfix, from userid 1173)
	id EECAF20B710C; Wed, 25 Mar 2026 11:04:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EECAF20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774461865;
	bh=Lc5SaWE0tmjAzgFWfpckaHzaU7rMTfjxxc9loX244wg=;
	h=From:To:Cc:Subject:Date:From;
	b=WKWiqFtuRN2JhrT2y8HATXS6Uz1TlZ6SZwz7Cqt/Y+OQvnEHzBxj9pb9zI2qudRe6
	 0dyWs1a9lnU1eI18UocXrz7jaJufHIn8wZxA4hp2c89cbnF3TARrVgQE8iBT+NOd5a
	 v1sUqJX89pzbz0IJPJvVDZseRQldbA4YgBIcCMa0=
From: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shradhagupta@linux.microsoft.com,
	kotaranov@microsoft.com,
	dipayanroy@linux.microsoft.com,
	yury.norov@gmail.com,
	kees@kernel.org,
	linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Subject: [PATCH net-next v2] net: mana: Use at least SZ_4K in doorbell ID range check
Date: Wed, 25 Mar 2026 11:04:17 -0700
Message-ID: <20260325180423.1923060-1-ernis@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mana_gd_ring_doorbell() accesses offsets up to DOORBELL_OFFSET_EQ
(0xFF8) + 8 bytes = 4KB within each doorbell page. A db_page_size
smaller than SZ_4K is fundamentally incompatible with the driver:
doorbell pages would overlap and the device cannot function correctly.

Validate db_page_size at the source and fail the
probe early if the value is below SZ_4K. This ensures the doorbell ID
range check in mana_gd_register_device() can rely on db_page_size
being valid.

Fixes: 89fe91c65992 ("net: mana: hardening: Validate doorbell ID from GDMA_REGISTER_DEVICE response")
Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
---
Changes in v2:
* Remove "db_page_sz = max_t(u64, SZ_4K, gc->db_page_size)" in
  mana_gd_register_device and validate db_page_sz at the source
  mana_gf_init_pf_regs and mana_gd_init_vf_regs.
* Update commit message.
---
 .../net/ethernet/microsoft/mana/gdma_main.c   | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/net/ethernet/microsoft/mana/gdma_main.c
index 2ba1fa3336f9..43741cd35af8 100644
--- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
+++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
@@ -4,6 +4,7 @@
 #include <linux/debugfs.h>
 #include <linux/module.h>
 #include <linux/pci.h>
+#include <linux/sizes.h>
 #include <linux/utsname.h>
 #include <linux/version.h>
 #include <linux/msi.h>
@@ -46,6 +47,18 @@ static int mana_gd_init_pf_regs(struct pci_dev *pdev)
 	u64 sriov_base_off;
 
 	gc->db_page_size = mana_gd_r32(gc, GDMA_PF_REG_DB_PAGE_SIZE) & 0xFFFF;
+
+	/* mana_gd_ring_doorbell() accesses offsets up to DOORBELL_OFFSET_EQ
+	 * (0xFF8) + 8 bytes = 4KB within each doorbell page, so the page
+	 * size must be at least SZ_4K.
+	 */
+	if (gc->db_page_size < SZ_4K) {
+		dev_err(gc->dev,
+			"Doorbell page size %llu too small (min %u)\n",
+			gc->db_page_size, SZ_4K);
+		return -EPROTO;
+	}
+
 	gc->db_page_off = mana_gd_r64(gc, GDMA_PF_REG_DB_PAGE_OFF);
 
 	/* Validate doorbell offset is within BAR0 */
@@ -73,6 +86,18 @@ static int mana_gd_init_vf_regs(struct pci_dev *pdev)
 	struct gdma_context *gc = pci_get_drvdata(pdev);
 
 	gc->db_page_size = mana_gd_r32(gc, GDMA_REG_DB_PAGE_SIZE) & 0xFFFF;
+
+	/* mana_gd_ring_doorbell() accesses offsets up to DOORBELL_OFFSET_EQ
+	 * (0xFF8) + 8 bytes = 4KB within each doorbell page, so the page
+	 * size must be at least SZ_4K.
+	 */
+	if (gc->db_page_size < SZ_4K) {
+		dev_err(gc->dev,
+			"Doorbell page size %llu too small (min %u)\n",
+			gc->db_page_size, SZ_4K);
+		return -EPROTO;
+	}
+
 	gc->db_page_off = mana_gd_r64(gc, GDMA_REG_DB_PAGE_OFFSET);
 
 	/* Validate doorbell offset is within BAR0 */
-- 
2.34.1

