Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E1DD23393D;
	Sat, 18 Jul 2026 02:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341217; cv=none; b=XPC65Nmy/f2VHIUFpdrGfOJmbiQeW7Coaj7N2Zhv2zj2+c6gEailk01HtvPPiRYHJffQVgp+FtQnPbLwRm9WqsCxeT4QoQ3/qIG3f/Gj4CrCi+R/aD2bUERul6Uy9ERDlQkB8tnBegm7nA6R0GUoCbY0WUorpld39JKFrte3JhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341217; c=relaxed/simple;
	bh=zJ3pn3bxME5JwSB5aK1OrtBWQvH5JhVENL3qlc66ejE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IlND+YW8AFOVgcwjqFL21kfb8uJbF7HPaGdVq1MbnF5fnc7zJKojwrCPOnzKJqXECMx7G4RYj0Gmd3Prit6FnIgD+G4izpehaGMihbCHbrTq88ufnnwe1icGWlvrJDaBDz2n5XQku1FySjd8yAINhIwMFkElmdk1HXwKYFtGNmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=e7OO4xiF; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="e7OO4xiF"
Received: from mrdev.corp.microsoft.com (unknown [40.86.181.13])
	by linux.microsoft.com (Postfix) with ESMTPSA id 96FA020B716D;
	Fri, 17 Jul 2026 19:20:00 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 96FA020B716D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1784341201;
	bh=O5TgxXPIGID/9HT6Lm1wyXVi3Vi9JkEyO50J+jeuGzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7OO4xiFSi66/p/LIxGbMhjR3iRBU2tHCRC1MgSKiMRAzzjfc3RnBOKvpo9DcnW/c
	 UdBz0xMz4/FcS5BUMF9VVyYYPYFStQr3DtEhVdZFIfcdZnJ60RbQzunuN0oSE5Fcjt
	 zr/Rz2+B5HbgV3p2zNSibpnyLHEuBUQzbxXQeTkw=
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
Subject: [PATCH V4 4/9] mshv: Add ioctl support for MSHV-VFIO bridge device
Date: Fri, 17 Jul 2026 19:19:44 -0700
Message-ID: <20260718021949.926306-5-mrathor@linux.microsoft.com>
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

Add ioctl support for MSHV devices for a partition. At present only VFIO
device types are supported, but more could be added. At a high level, a
partition ioctl to create device verifies it is of type VFIO and does some
setup for bridge code in mshv_vfio.c.  Adapted from KVM device ioctls.

Co-developed-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 119 ++++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 02c107458be9..a36e54bfa064 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1625,6 +1625,122 @@ mshv_partition_ioctl_initialize(struct mshv_partition *partition)
 	return ret;
 }
 
+static long mshv_device_attr_ioctl(struct mshv_device *mshv_dev, int cmd,
+				   ulong uarg)
+{
+	struct mshv_device_attr attr;
+	const struct mshv_device_ops *devops = mshv_dev->device_ops;
+
+	if (copy_from_user(&attr, (void __user *)uarg, sizeof(attr)))
+		return -EFAULT;
+
+	switch (cmd) {
+	case MSHV_SET_DEVICE_ATTR:
+		if (devops->device_set_attr)
+			return devops->device_set_attr(mshv_dev, &attr);
+		break;
+	case MSHV_HAS_DEVICE_ATTR:
+		if (devops->device_has_attr)
+			return devops->device_has_attr(mshv_dev, &attr);
+		break;
+	}
+
+	return -EPERM;
+}
+
+static long mshv_device_fop_ioctl(struct file *filp, unsigned int cmd,
+				  ulong uarg)
+{
+	struct mshv_device *mshv_dev = filp->private_data;
+
+	switch (cmd) {
+	case MSHV_SET_DEVICE_ATTR:
+	case MSHV_HAS_DEVICE_ATTR:
+		return mshv_device_attr_ioctl(mshv_dev, cmd, uarg);
+	}
+
+	return -ENOTTY;
+}
+
+static int mshv_device_fop_release(struct inode *inode, struct file *filp)
+{
+	struct mshv_device *mshv_dev = filp->private_data;
+	struct mshv_partition *partition = mshv_dev->device_pt;
+
+	if (mshv_dev->device_ops->device_release) {
+		mutex_lock(&partition->pt_mutex);
+		hlist_del(&mshv_dev->device_ptnode);
+		mshv_dev->device_ops->device_release(mshv_dev);
+		mutex_unlock(&partition->pt_mutex);
+	}
+
+	mshv_partition_put(partition);
+	return 0;
+}
+
+static const struct file_operations mshv_device_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = mshv_device_fop_ioctl,
+	.release = mshv_device_fop_release,
+};
+
+static long mshv_partition_ioctl_create_device(struct mshv_partition *partition,
+					       void __user *uarg)
+{
+	long rc;
+	struct mshv_create_device devargk;
+	struct mshv_device *mshv_dev;
+	const struct mshv_device_ops *vfio_ops;
+
+	if (copy_from_user(&devargk, uarg, sizeof(devargk)))
+		return -EFAULT;
+
+	/* At present, only VFIO is supported */
+	if (devargk.type != MSHV_DEV_TYPE_VFIO)
+		return -ENODEV;
+
+	if (devargk.flags & MSHV_CREATE_DEVICE_TEST)
+		return 0;
+
+	if (devargk.flags)	/* currently, only MSHV_CREATE_DEVICE_TEST */
+		return -EINVAL;
+
+	/* This is freed later by mshv_vfio_release_device() */
+	mshv_dev = kzalloc_obj(*mshv_dev);
+	if (mshv_dev == NULL)
+		return -ENOMEM;
+
+	vfio_ops = &mshv_vfio_device_ops;
+	mshv_dev->device_ops = vfio_ops;
+	mshv_dev->device_pt = partition;
+
+	rc = vfio_ops->device_create(mshv_dev);
+	if (rc < 0) {
+		kfree(mshv_dev);
+		return rc;
+	}
+
+	hlist_add_head(&mshv_dev->device_ptnode, &partition->pt_devices);
+
+	mshv_partition_get(partition);
+	rc = anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
+			      mshv_dev, O_RDWR | O_CLOEXEC);
+	if (rc < 0)
+		goto undo_out;
+
+	devargk.fd = rc;
+	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
+		return -EFAULT;    /* cleanup in mshv_device_fop_release() */
+
+	return 0;
+
+undo_out:
+	hlist_del(&mshv_dev->device_ptnode);
+	vfio_ops->device_release(mshv_dev);    /* will kfree(mshv_dev) */
+	mshv_partition_put(partition);
+	return rc;
+}
+
 static long
 mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 {
@@ -1661,6 +1777,9 @@ mshv_partition_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
 	case MSHV_ROOT_HVCALL:
 		ret = mshv_ioctl_passthru_hvcall(partition, true, uarg);
 		break;
+	case MSHV_CREATE_DEVICE:
+		ret = mshv_partition_ioctl_create_device(partition, uarg);
+		break;
 	default:
 		ret = -ENOTTY;
 	}
-- 
2.51.2.vfs.0.1

