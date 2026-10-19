Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC93647DD44;
	Mon, 19 Oct 2026 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792400198; cv=none; b=fF1bxtibCKyffgdAcPRAWtVV/RVi/7bAM8YrIVYwoSwjw3G/y5Emg3zvyGuJcTAYknYS1lKE8iMLVleNLzE5MaHEMsyUt06FTr1n/qAPVrYw1J0V29ftPr1Xd0Ow4gmzIlObAlBqXq2YGoT2ib+WtrK45HHRPJB9W3IkfKv9ELw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792400198; c=relaxed/simple;
	bh=rKpOMQQEd6Z7bgm3CSZSc0+K1Fh8KPupoldpLpN08xE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jLjqiH/KMPlOLHclOMz83DOS0+PmaoEuNjlM/nurweSSobniUgkMpgfdB746QovcZ1S98ncfBPJzlmzjkcRzkEEzw/DSDBfcaNuyJlEK4VORcI2xK+3Q0ruXGp2Kn2CvG8GybLltE6EHnXlTwyHvAmmJcjZ6BCQIxuCM1N+pybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=H35eLjLv; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="H35eLjLv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=CT
	Cb3+Em6nXC8TfZ/SV0B+Ls5l2wrjMmaByxM+oo4yc=; b=H35eLjLvyNl5TLiz/y
	20UJMWLlacG7xzM4ai81GzV+Y083RFzTzS9s+n5FtbzTKbtny5m3K2SjVGJ29pNq
	os0C95HVv/rZBsOG3nZO3D5Y2M+s8vbG+roL0yz7i+vVPjIHSDh3QiHouxW3iWWl
	WxF12IamlG9X0d3SlF3gdwrz0=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wD3X7AS29VqSrmRAw--.58066S2;
	Mon, 19 Oct 2026 16:55:47 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH] hv/vmbus: copy dynamic IDs before dropping the lock
Date: Mon, 19 Oct 2026 16:55:44 +0800
Message-Id: <20261019085544.1834700-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3X7AS29VqSrmRAw--.58066S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxuF17uw1kXrWUtrW7Aw4rAFb_yoWrJry3pa
	1UZFWayrW7tF13W3s3Zry8AFyY9wnFqa4Y9rn5C3ZIgFyqyry5Xay8JFWjva4FyrWUG3W2
	kr1Utr1rAFWDZr7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0pi_HU-UUUUU=
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BMLRWrV2xMD0gAA3L

remove_id_store() can free a matching dynamic ID while VMBus is
preparing to invoke a driver probe. Copy the ID while holding the
dynamic ID lock so probe never receives a pointer into a freed list
entry.

Fixes: fc76936d3ea5 ("vmbus: add support for dynamic device id's")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/hv/vmbus_drv.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4692687cdbf3..96ad0dfaa50b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -661,21 +661,22 @@ hv_vmbus_dev_match(const struct hv_vmbus_device_id *id, const guid_t *guid)
 }
 
 static const struct hv_vmbus_device_id *
-hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid)
+hv_vmbus_dynid_match(struct hv_driver *drv, const guid_t *guid,
+		     struct hv_vmbus_device_id *id_copy)
 {
-	const struct hv_vmbus_device_id *id = NULL;
 	struct vmbus_dynid *dynid;
 
 	spin_lock(&drv->dynids.lock);
 	list_for_each_entry(dynid, &drv->dynids.list, node) {
 		if (guid_equal(&dynid->id.guid, guid)) {
-			id = &dynid->id;
-			break;
+			*id_copy = dynid->id;
+			spin_unlock(&drv->dynids.lock);
+			return id_copy;
 		}
 	}
 	spin_unlock(&drv->dynids.lock);
 
-	return id;
+	return NULL;
 }
 
 static const struct hv_vmbus_device_id vmbus_device_null;
@@ -685,7 +686,8 @@ static const struct hv_vmbus_device_id vmbus_device_null;
  * If there is no match, return NULL.
  */
 static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *drv,
-							struct hv_device *dev)
+							struct hv_device *dev,
+							struct hv_vmbus_device_id *id_copy)
 {
 	const guid_t *guid = &dev->dev_type;
 	const struct hv_vmbus_device_id *id;
@@ -697,7 +699,7 @@ static const struct hv_vmbus_device_id *hv_vmbus_get_id(const struct hv_driver *
 		return NULL;
 
 	/* Look at the dynamic ids first, before the static ones */
-	id = hv_vmbus_dynid_match((struct hv_driver *)drv, guid);
+	id = hv_vmbus_dynid_match((struct hv_driver *)drv, guid, id_copy);
 	if (!id)
 		id = hv_vmbus_dev_match(drv->id_table, guid);
 
@@ -773,6 +775,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 			    size_t count)
 {
 	struct hv_driver *drv = drv_to_hv_drv(driver);
+	struct hv_vmbus_device_id id_copy;
 	guid_t guid;
 	ssize_t retval;
 
@@ -780,7 +783,7 @@ static ssize_t new_id_store(struct device_driver *driver, const char *buf,
 	if (retval)
 		return retval;
 
-	if (hv_vmbus_dynid_match(drv, &guid))
+	if (hv_vmbus_dynid_match(drv, &guid, &id_copy))
 		return -EEXIST;
 
 	retval = vmbus_add_dynid(drv, &guid);
@@ -840,12 +843,13 @@ static int vmbus_match(struct device *device, const struct device_driver *driver
 {
 	const struct hv_driver *drv = drv_to_hv_drv(driver);
 	struct hv_device *hv_dev = device_to_hv_device(device);
+	struct hv_vmbus_device_id id_copy;
 
 	/* The hv_sock driver handles all hv_sock offers. */
 	if (is_hvsock_channel(hv_dev->channel))
 		return drv->hvsock;
 
-	if (hv_vmbus_get_id(drv, hv_dev))
+	if (hv_vmbus_get_id(drv, hv_dev, &id_copy))
 		return 1;
 
 	return 0;
@@ -860,9 +864,10 @@ static int vmbus_probe(struct device *child_device)
 	struct hv_driver *drv =
 			drv_to_hv_drv(child_device->driver);
 	struct hv_device *dev = device_to_hv_device(child_device);
+	struct hv_vmbus_device_id dev_id_copy;
 	const struct hv_vmbus_device_id *dev_id;
 
-	dev_id = hv_vmbus_get_id(drv, dev);
+	dev_id = hv_vmbus_get_id(drv, dev, &dev_id_copy);
 	if (drv->probe) {
 		ret = drv->probe(dev, dev_id);
 		if (ret != 0)
-- 
2.34.1

