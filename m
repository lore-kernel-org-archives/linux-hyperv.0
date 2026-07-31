Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C281F3D56;
	Fri, 31 Jul 2026 22:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537284; cv=none; b=E+HwTTyTbPkYEQl6HMuO2P+HecPiIJhRDcclChNJxU8c9rxzSZdDT6JH+1kgVuTbscAf9B4FeyK/lWrrb8+F+PMX3HyzzHuoAk9XJ5JPjrtBzbmcXquSNAJkQdZwBeOXcZ/sXm0meeZOnoGTKkZR1RmHdyxepNk8y6rp0rP0t0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537284; c=relaxed/simple;
	bh=fzYWD/5EjIpdW4T9Oj21t8GeOhnvEr9ihsD6e99T1HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QUhVOs1dx1m0VBsfQrn9T9+pRLUNZeiULt/f78QY0oIISQxthadziwu/krUjiEzFaifLoEQysWcSRD0th6XsiH3cPc9YO52QxaBEwjXzxmOSX+n8OBJulo2Bca1XRc+6Id1uTyRiTgOlqmUQa374yCLNZjCFawK7oTauDcDrM3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pgeFtPQH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pgeFtPQH"
Received: from mrdev.corp.microsoft.com (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98ADC20B7168;
	Fri, 31 Jul 2026 15:34:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98ADC20B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1785537264;
	bh=BobBuqAROcxxevptx/deKiHfAZetNhv7W+I7wmcGHEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pgeFtPQH9RMzW3YwXGu/gk3YWRqUzHrKgp5c8Atj/4w4fosnSh53ACikc6zOvVxmS
	 nWZqwGdFAtHlOLggex+wde/Xymg4e1nrHzHlvGC2hMuvC+HJF5TIQwkCJtMmVa3tQb
	 bTb+4UB5TwT1rxigk10oIzYZuNV+yHY+kZ2oYvNs=
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
Subject: [PATCH v5 2/9] mshv: Add declarations and definitions for VFIO-MSHV bridge device
Date: Fri, 31 Jul 2026 15:34:20 -0700
Message-ID: <20260731223427.2554388-3-mrathor@linux.microsoft.com>
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

Add data structs needed by the subsequent patch that introduces a new
module to implement VFIO-MSHV pseudo device.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
---
 drivers/hv/mshv_root.h    | 19 +++++++++++++++++++
 include/uapi/linux/mshv.h | 30 ++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index a85c24dcc701..43114df3cbf0 100644
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
+extern const struct mshv_device_ops mshv_vfio_device_ops;
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

