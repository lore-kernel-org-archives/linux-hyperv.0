Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C3726738B;
	Sat, 18 Jul 2026 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341209; cv=none; b=hRLfaAYaIxGT8AokA3QKY8QNqlKnbLyRbwx5ZlUQQ/P3o84uMds4Ynrlq0L7GlfaoWWgq/dQJpo/suKGppjdgz+3fjD4PEUSSHYcXIZU3cGxxN6slgWxXz+2C/3g7DtGqxCFtGzvb8WhuTWMT/NTVzaeCCNub6jle/Vvcw4XOFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341209; c=relaxed/simple;
	bh=oC/nH3zlnc2lJLesQHkusb5kQ9EczOdzvgZC/7Ouoic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KURnBnnh4KqAmgPZUzBUMvmIPrAv0DShHN4TijRwX/Id4aYh7S2wB95lVyGvfgzXnSdC08BoNJAamNLJFlf0465Bw5/NomNkmw3t0y9o0keSVK/NihNYDuVnpxo8c/7dVR+HtqQw8YBXpva1qnkeCmw43XuxFqhAHdWi0gzI38w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CDQ3oyKM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CDQ3oyKM"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 68B5F20B716B;
	Fri, 17 Jul 2026 19:19:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 68B5F20B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784341197;
	bh=50+2NaZG8RZczIOZNFqtKzTKNUyFb8ZRF1YOIrM0NEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CDQ3oyKM04I6dJdXfVuQ6KBLl44l/td5QiV2YWw0ICOI3iO5fqLpo9sJyCrWAGAHw
	 jHc2OPr6EgBHGioumOgZ8PNFBynJzxnxQJQN+IZHX4IG7zxiXZyOtBh+qamygkpjmC
	 WxADt2PTlHisqU+C3Qks2rrb08nKTfqV+MqgynkI=
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
Cc: kys@microsoft.com,
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
Subject: [PATCH V4 2/9] mshv: Add declarations and definitions for VFIO-MSHV bridge device
Date: Fri, 17 Jul 2026 19:19:42 -0700
Message-ID: <20260718021949.926306-3-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
In-Reply-To: <20260718021949.926306-1-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add data structs needed by the subsequent patch that introduces a new
module to implement VFIO-MSHV pseudo device.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 drivers/hv/mshv_root.h    | 19 +++++++++++++++++++
 include/uapi/linux/mshv.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index a85c24dcc701..b9880d0bdc4d 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -227,6 +227,25 @@ struct port_table_info {
 	};
 };
 
+struct mshv_device {
+	const struct mshv_device_ops *device_ops;
+	struct mshv_partition *device_pt;
+	void *device_private;
+	struct hlist_node device_ptnode;
+};
+
+struct mshv_device_ops {
+	const char *device_name;
+	long (*device_create)(struct mshv_device *dev);
+	void (*device_release)(struct mshv_device *dev);
+	long (*device_set_attr)(struct mshv_device *dev,
+				struct mshv_device_attr *attr);
+	long (*device_has_attr)(struct mshv_device *dev,
+				struct mshv_device_attr *attr);
+};
+
+extern struct mshv_device_ops mshv_vfio_device_ops;
+
 int mshv_update_routing_table(struct mshv_partition *partition,
 			      const struct mshv_user_irq_entry *entries,
 			      unsigned int numents);
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 32ff92b6342b..be6fe3ee8707 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -404,4 +404,34 @@ struct mshv_sint_mask {
 /* hv_hvcall device */
 #define MSHV_HVCALL_SETUP        _IOW(MSHV_IOCTL, 0x1E, struct mshv_vtl_hvcall_setup)
 #define MSHV_HVCALL              _IOWR(MSHV_IOCTL, 0x1F, struct mshv_vtl_hvcall)
+
+/* Device passhthru */
+#define MSHV_CREATE_DEVICE_TEST		1
+
+enum {
+	MSHV_DEV_TYPE_VFIO,
+	MSHV_DEV_TYPE_MAX,
+};
+
+struct mshv_create_device {
+	__u32	type;	     /* in: MSHV_DEV_TYPE_xxx */
+	__u32	fd;	     /* out: device handle */
+	__u32	flags;	     /* in: MSHV_CREATE_DEVICE_xxx */
+};
+
+#define MSHV_DEV_VFIO_FILE      1
+#define MSHV_DEV_VFIO_FILE_ADD	1
+#define MSHV_DEV_VFIO_FILE_DEL	2
+
+struct mshv_device_attr {
+	__u32	flags;		/* no flags currently defined */
+	__u32	group;		/* device-defined */
+	__u64	attr;		/* group-defined */
+	__u64	addr;		/* userspace address of attr data */
+};
+
+/* Device fds created with MSHV_CREATE_DEVICE */
+#define MSHV_SET_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x00, struct mshv_device_attr)
+#define MSHV_HAS_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x01, struct mshv_device_attr)
+
 #endif
-- 
2.51.2.vfs.0.1

