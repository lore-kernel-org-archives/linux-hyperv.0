Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08FD13557F3;
	Fri, 31 Jul 2026 22:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538164; cv=none; b=m7GOSW7RcMC91p5h6Co+Y7K08aeZZql0NbAa829McdEFVCU2o0dCVFQrdYUSYjYLqFtGfWrANPZclOjPvNhaUBBBpUlETl1js5+g0CkZA0BfDpLdFYLWJOvnlI8/XUPMRufbVudJp8oSHF5fR4tsaObv1fKizaA/s0OTQmjE4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538164; c=relaxed/simple;
	bh=ggR+uNQaC+AiG0y5j/Vs2Svrd6R0GFfG9Y3B3j8mCeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=b7pgX6lI1tG1j0RLUdOxoTA4Qcs2yQAJWB+HKUCY1JBatPTuUE+/5AWKcsjdPJiftlOaOGhhz01gD3GVtBh8vk+K5ta7AF+CfYhAPECIPCWmSPLdhZsCy/3BcNmag8GauXw5efiBhb8NvVI9uXiE3QtQrdNgpzWFKnQnow2opF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxFoWGwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxFoWGwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7931F00AC4;
	Fri, 31 Jul 2026 22:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538162;
	bh=O37TKiPccRD9ElPAY0oeiKwu+JFrqC3y1TCWVxUyKRE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bxFoWGwb/5lLPA961gzvsf+xVklo6Aq8cjBWlxjSwoI1SaAWJaML7H0ImuxIYO17p
	 KpdqpPFG1FwCXa5aWN/9uYzqEz0z7Kk8NVh2DTbVE6Jw79o7fDhJHBo8dOgnTwfISK
	 6+s3u7AMwDcDPVrB+oa0MCk30GcCUfB7hAN6Hzl8//MYlS61UPC4O6mQRJ533EiYi7
	 yG65wZ8DYI8d5e9oKusupn7iS0WA5Uwj/Q8yZPcVgpAY/R93UEiqoNc9Y8Qtn9zdeP
	 WZDRP5TcSWu1QEleVDKgGwXlnVVbaGOlVvMUhqIPLRS6pJhwTHQx2GpE6KUu40dldH
	 wCwtuTCLHlmrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/9] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260731223427.2554388-5-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:49:22 +0000
Message-Id: <20260731224922.8E7931F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Failing copy_to_user after anon_inode_getfd causes a file descript=
or leak and leaves partition state inconsistent.
- [Medium] The MSHV_CREATE_DEVICE_TEST flag ignores all other flags, render=
ing capability checks broken.
--

--- Patch [4]: [PATCH v5 4/9] mshv: Add ioctl support for MSHV-VFIO bridge =
device ---
commit a96aa99c275e6a51436ce19dce86ac7d1a20b10d
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Add ioctl support for MSHV-VFIO bridge device

This commit adds ioctl support for creating MSHV VFIO bridge devices in a
partition. It introduces a partition ioctl to verify the VFIO type and sets
up the bridge code.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index 39e9ef3674f29..fc08e994ecdf5 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -1625,6 +1625,122 @@ mshv_partition_ioctl_initialize(struct mshv_parti=
tion *partition)
[ ... ]
> +static long mshv_partition_ioctl_create_device(struct mshv_partition *pa=
rtition,
> +					       void __user *uarg)
> +{
> +	long rc;
> +	struct mshv_create_device devargk;
> +	struct mshv_device *mshv_dev;
> +	const struct mshv_device_ops *vfio_ops;
> +
> +	if (copy_from_user(&devargk, uarg, sizeof(devargk)))
> +		return -EFAULT;
> +
> +	/* At present, only VFIO is supported */
> +	if (devargk.type !=3D MSHV_DEV_TYPE_VFIO)
> +		return -ENODEV;
> +
> +	if (devargk.flags & MSHV_CREATE_DEVICE_TEST)
> +		return 0;
> +
> +	if (devargk.flags)	/* currently, only MSHV_CREATE_DEVICE_TEST */
> +		return -EINVAL;

[Severity: Medium]
If userspace calls this with MSHV_CREATE_DEVICE_TEST combined with an
unknown flag, won't this unconditionally return 0 and bypass the check for
unsupported flags?

Could this mislead userspace into thinking a new flag is supported when
probing capabilities on older kernels?

[ ... ]
> +	mshv_partition_get(partition);
> +	rc =3D anon_inode_getfd(vfio_ops->device_name, &mshv_device_fops,
> +			      mshv_dev, O_RDWR | O_CLOEXEC);
> +	if (rc < 0)
> +		goto undo_out;
> +
> +	devargk.fd =3D rc;
> +	if (copy_to_user(uarg, &devargk, sizeof(devargk)))
> +		return -EFAULT;    /* cleanup in mshv_device_fop_release() */

[Severity: High]
Does this leak the file descriptor and the associated mshv_dev kernel
structures if copy_to_user() fails?

Since anon_inode_getfd() immediately installs the new file descriptor into
the task's fdtable, returning -EFAULT here leaves the fd permanently open
until the process exits.

Also, because the fd is installed before copy_to_user() is called, could
another thread guess the fd and start using it while the calling thread
receives -EFAULT and assumes device creation failed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D4
