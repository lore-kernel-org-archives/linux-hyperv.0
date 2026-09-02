Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9330238A736;
	Wed,  2 Sep 2026 18:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788373149; cv=none; b=LWTlz0G7Og+h0Qcjf6ENoTtlIhdtzm27TmDHiUEhhOg+rw/dXRkDrlEltGjxnTNspkysSA4PV3ovxJ/oS1vCzwqWPTk65Upw2azZlKHqF7AqFliSIQONnSXpZbwtA/7cl9iDBl2rJxjJHU1BLAhFcsDKobw2+69/lQi1pzH7zSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788373149; c=relaxed/simple;
	bh=hbgQzV4TsDAypUVt+pVQPQwNL/J0nnyascedAv8GyCE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qKrz6RtjwbNVrdRIIzUxXVP/ySt9XXF6cwBCKHKyWqllBb+nwl93klepTTnwhnMrLspzZcTli8y2wHb6cd3xQsXS5aa5XJjVTBbafD4oCMPLHWz4aVRRcChS7LLnLq4bXDCLp5oJ/vzf+18IUXL4U0g8pOl/h+n/OXliX8X5px4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MRvP+jmb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MRvP+jmb"
Received: from localhost (unknown [20.236.11.69])
	by linux.microsoft.com (Postfix) with ESMTPSA id 788CA20B7129;
	Wed,  2 Sep 2026 11:18:29 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 788CA20B7129
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1788373110;
	bh=+S/srMXP148DJ3iow1AbhMmsg6NLcnBjUJW+9hsDjsM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MRvP+jmbcxjA1akLb6PZdjxYAno+m1CEsNlvjaABGK4UkOXZ3Uq4KcDSP4M4D0Sxs
	 5qxACRfR2y1RFd89YdjcR6EEDDTyQ42NT8JOZ6pdrnBVg+Xj7TQBjXk3shjikZ2zcE
	 tE5RGLu+9W1vsUNGJKTtWaIbxkR7ZpI/VXYDHc9I=
Date: Wed, 2 Sep 2026 11:19:05 -0700
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Mukesh R <mrathor@linux.microsoft.com>, Alex Williamson
 <alex@shazbot.org>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org,
 wei.liu@kernel.org, mhklinux@outlook.com, muislam@microsoft.com,
 namjain@linux.microsoft.com, magnuskulke@linux.microsoft.com,
 anbelski@linux.microsoft.com, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, iommu@lists.linux.dev,
 linux-pci@vger.kernel.org, linux-arch@vger.kernel.org, jgg@nvidia.com,
 kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
 longli@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, joro@8bytes.org,
 will@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
 bhelgaas@google.com, arnd@arndb.de, jacob.pan@linux.microsoft.com
Subject: Re: [PATCH v5 3/9] mshv: Introduce basic mshv bridge device for
 VFIO to build upon
Message-ID: <20260902111905.000079d4@linux.microsoft.com>
In-Reply-To: <20260731223427.2554388-4-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
	<20260731223427.2554388-4-mrathor@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 3.21.0 (GTK+ 2.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mukesh,

On Fri, 31 Jul 2026 15:34:21 -0700
Mukesh R <mrathor@linux.microsoft.com> wrote:

> Add a new file to implement basic VFIO-MSHV bridge pseudo device.
> These functions are called in the VFIO framework, and credits to
> kvm/vfio.c as this file was adapted from it. This is a basic version
> to build upon.
> 
> Co-developed-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> ---
>  drivers/hv/Makefile       |   3 +-
>  drivers/hv/mshv_vfio.c    | 211
> ++++++++++++++++++++++++++++++++++++++ include/uapi/linux/mshv.h |
> 1 + 3 files changed, 214 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/hv/mshv_vfio.c
> 
> diff --git a/drivers/hv/Makefile b/drivers/hv/Makefile
> index 888a748cc7cb..9ab6fc254c38 100644
> --- a/drivers/hv/Makefile
> +++ b/drivers/hv/Makefile
> @@ -14,7 +14,8 @@ hv_vmbus-y := vmbus_drv.o \
>  hv_vmbus-$(CONFIG_HYPERV_TESTING)	+= hv_debugfs.o
>  hv_utils-y := hv_util.o hv_kvp.o hv_snapshot.o hv_utils_transport.o
>  mshv_root-y := mshv_root_main.o mshv_synic.o mshv_eventfd.o
> mshv_irq.o \
> -	       mshv_root_hv_call.o mshv_portid_table.o mshv_regions.o
> +	       mshv_root_hv_call.o mshv_portid_table.o
> mshv_regions.o  \
> +               mshv_vfio.o
>  mshv_root-$(CONFIG_DEBUG_FS) += mshv_debugfs.o
>  mshv_root-$(CONFIG_TRACEPOINTS) += mshv_trace.o
>  mshv_vtl-y := mshv_vtl_main.o
> diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
> new file mode 100644
> index 000000000000..92cfbaef0328
> --- /dev/null
> +++ b/drivers/hv/mshv_vfio.c
> @@ -0,0 +1,211 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * VFIO-MSHV bridge pseudo device
> + *
> + * Heavily inspired by the VFIO-KVM bridge pseudo device.
> + */
> +#include <linux/errno.h>
> +#include <linux/file.h>
> +#include <linux/list.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/slab.h>
> +#include <linux/vfio.h>
> +#include <asm/mshyperv.h>
> +
> +#include "mshv.h"
> +#include "mshv_root.h"
> +
> +struct mshv_vfio_file {
> +	struct list_head node;
> +	struct file *file;	/* list of struct mshv_vfio_file */
> +};
> +
> +struct mshv_vfio {
> +	struct list_head file_list;
> +	struct mutex lock;
> +};
> +
> +static bool mshv_vfio_file_is_valid(struct file *file)
> +{
> +	bool (*fn)(struct file *file);
> +	bool ret;
> +
> +	fn = symbol_get(vfio_file_is_valid);
> +	if (!fn)
> +		return false;
> +
> +	ret = fn(file);
> +
> +	symbol_put(vfio_file_is_valid);
> +
> +	return ret;
> +}
> +
> +static long mshv_vfio_file_add(struct mshv_device *mshvdev, unsigned
> int fd) +{
> +	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf;
> +	struct file *filp;
> +	long ret = 0;
> +
> +	filp = fget(fd);
> +	if (!filp)
> +		return -EBADF;
> +
> +	/* Ensure the FD is a vfio FD. */
> +	if (!mshv_vfio_file_is_valid(filp)) {
> +		ret = -EINVAL;
> +		goto out_fput;
> +	}
> +
> +	mutex_lock(&mshv_vfio->lock);
> +
> +	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
> +		if (mvf->file == filp) {
> +			ret = -EEXIST;
> +			goto out_unlock;
> +		}
> +	}
> +
> +	mvf = kzalloc(sizeof(*mvf), GFP_KERNEL_ACCOUNT);
> +	if (!mvf) {
> +		ret = -ENOMEM;
> +		goto out_unlock;
> +	}
> +
> +	mvf->file = get_file(filp);
> +	list_add_tail(&mvf->node, &mshv_vfio->file_list);
> +
Why there is no vfio_device_file_set_kvm equivalent for mshv? since VFIO
device open/bind path will do vfio_device/group_get_kvm_safe() to ensure
lifetime alignment. Otherwise, vfio group/device can outlive mshv
partition.

If we do want to support this kvm-vfio bridge semantics beyond kvm,
maybe this should be abstracted as a generic VFIO "hypervisor
partition" association, with hypervisor-specific get/put callbacks,
rather than adding an MSHV-only copy of the KVM hook.
+Alex

> +out_unlock:
> +	mutex_unlock(&mshv_vfio->lock);
> +out_fput:
> +	fput(filp);
> +	return ret;
> +}
> +
> +static long mshv_vfio_file_del(struct mshv_device *mshvdev, unsigned
> int fd) +{
> +	struct mshv_vfio *mshv_vfio = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf;
> +	long ret;
> +
> +	CLASS(fd, f)(fd);
> +
> +	if (fd_empty(f))
> +		return -EBADF;
> +
> +	ret = -ENOENT;
> +	mutex_lock(&mshv_vfio->lock);
> +
> +	list_for_each_entry(mvf, &mshv_vfio->file_list, node) {
> +		if (mvf->file != fd_file(f))
> +			continue;
> +
> +		list_del(&mvf->node);
> +		fput(mvf->file);
> +		kfree(mvf);
> +		ret = 0;
> +		break;
> +	}
> +
> +	mutex_unlock(&mshv_vfio->lock);
> +	return ret;
> +}
> +
> +static long mshv_vfio_set_file(struct mshv_device *mshvdev, long
> attr,
> +			      void __user *arg)
> +{
> +	int32_t __user *argp = arg;
> +	int32_t fd;
> +
> +	switch (attr) {
> +	case MSHV_DEV_VFIO_FILE_ADD:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +		return mshv_vfio_file_add(mshvdev, fd);
> +
> +	case MSHV_DEV_VFIO_FILE_DEL:
> +		if (get_user(fd, argp))
> +			return -EFAULT;
> +		return mshv_vfio_file_del(mshvdev, fd);
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_set_attr(struct mshv_device *mshvdev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_FILE:
> +		return mshv_vfio_set_file(mshvdev, attr->attr,
> +
> u64_to_user_ptr(attr->addr));
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_has_attr(struct mshv_device *mshvdev,
> +			      struct mshv_device_attr *attr)
> +{
> +	switch (attr->group) {
> +	case MSHV_DEV_VFIO_FILE:
> +		switch (attr->attr) {
> +		case MSHV_DEV_VFIO_FILE_ADD:
> +		case MSHV_DEV_VFIO_FILE_DEL:
> +			return 0;
> +		}
> +
> +		break;
> +	}
> +
> +	return -ENXIO;
> +}
> +
> +static long mshv_vfio_create_device(struct mshv_device *mshvdev)
> +{
> +	struct mshv_device *tmp;
> +	struct mshv_vfio *mshv_vfio;
> +
> +	/* Only one VFIO "device" per VM */
> +	hlist_for_each_entry(tmp, &mshvdev->device_pt->pt_devices,
> +			     device_ptnode)
> +		if (tmp->device_ops == &mshv_vfio_device_ops)
> +			return -EBUSY;
> +
> +	mshv_vfio = kzalloc_obj(*mshv_vfio);
> +	if (mshv_vfio == NULL)
> +		return -ENOMEM;
> +
> +	INIT_LIST_HEAD(&mshv_vfio->file_list);
> +	mutex_init(&mshv_vfio->lock);
> +
> +	mshvdev->device_private = mshv_vfio;
> +
> +	return 0;
> +}
> +
> +/* This is called from mshv_device_fop_release() */
> +static void mshv_vfio_release_device(struct mshv_device *mshvdev)
> +{
> +	struct mshv_vfio *mv = mshvdev->device_private;
> +	struct mshv_vfio_file *mvf, *tmp;
> +
> +	list_for_each_entry_safe(mvf, tmp, &mv->file_list, node) {
> +		fput(mvf->file);
> +		list_del(&mvf->node);
> +		kfree(mvf);
> +	}
> +
> +	kfree(mv);
> +	kfree(mshvdev);
> +}
> +
> +const struct mshv_device_ops mshv_vfio_device_ops = {
> +	.device_name = "mshv-vfio",
> +	.device_create = mshv_vfio_create_device,
> +	.device_release = mshv_vfio_release_device,
> +	.device_set_attr = mshv_vfio_set_attr,
> +	.device_has_attr = mshv_vfio_has_attr,
> +};
> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index be6fe3ee8707..b038a79786d2 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -254,6 +254,7 @@ struct mshv_root_hvcall {
>  #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06,
> struct mshv_gpap_access_bitmap) /* Generic hypercall */
>  #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07,
> struct mshv_root_hvcall) +#define MSHV_CREATE_DEVICE
> _IOWR(MSHV_IOCTL, 0x08, struct mshv_create_device) 
>  /*
>   ********************************

