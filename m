Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943A1347DD;
	Sat, 18 Jul 2026 02:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342059; cv=none; b=RkMm7PlOOAxHGRx2h2X9OGwY/c4jfUJ1dJhBlB3k+5RnbyaINUyainTzjJed4PjiiTtQWpCxhmH5TmXnNZYrqaAczJVd1vNNPi7hLhRRs39c6tlu+Cct/GRX75xq/AE+7KuPbZLtNzvMXh+jppWO4T195ckogm+oYzHIhqPhSDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342059; c=relaxed/simple;
	bh=5fLcj17oU5qqcr8cjDdKG3Bu3YRMlJPNbMNHANrAGCw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LF8hzSzyedEw6w6umdZJL2AhIjvCIDCUN3wL/1MSW5lUX2fpYbOipLheCUXHWoB3UcVes4jrSq1T8LYfDSgA+wTuOtwlSZ8VDe0QcwVZXVowRANJiag5uaeDVKhoci/osURHm9H5v1R2hntVdJ2D+oP25y4Zi/+FnZIWxC0PgU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KTeUQCq8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KTeUQCq8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EAF1F000E9;
	Sat, 18 Jul 2026 02:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784342058;
	bh=+Jol933793xv0yPMLaT+GsmoNVLX8vHoD3mXB2Idb3Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KTeUQCq80V31I3TeML63PgC5zOtLbqBxP48eBizOEE3ZA/t9t8jv+GfGPtXCBzrMw
	 fyN+buQVuzrDdCCOdd7dDA7XyvD/RTcCJ07CzGh+Eg6U09vGGHRM/+kU9A4IurNN/f
	 VgGo/Wq5DIFRfWUzGCnBwsSlssGknrZYNLkh09SC3CNCRMHgt8KQ17E3miwu7KqwcR
	 +3Ef1yzpFTA7dT7COQamVh/oZ8qpicbbt43PkYsb+W6r3gczLoD5v9CcST+7v1gbcr
	 IQYOj4pLdEn5O38SitW8PVxCkKN6xtxzkDmIzUZNbB4AujyG2eGV1lTTGlOnB4zlkA
	 h6cb6dmhrfc2w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 4/9] mshv: Add ioctl support for MSHV-VFIO bridge
 device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-5-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:34:17 +0000
Message-Id: <20260718023417.E8EAF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] File descriptor and associated kernel resources leak on `copy_to_u=
ser` error path.
- [Medium] The MSHV_CREATE_DEVICE_TEST flag check completely ignores other =
unknown flags, breaking forward compatibility.
--

--- Patch [4]: [PATCH V4 4/9] mshv: Add ioctl support for MSHV-VFIO bridge =
device ---
commit 4db495dcb20f06e9a8bed00e54250347faa9f23f
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Add ioctl support for MSHV-VFIO bridge device

This commit adds ioctl support for creating MSHV devices for a partition. It
currently supports VFIO device types and performs initialization for the
bridge code. The implementation includes file operations and partition ioctl
handlers.

> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index f1ff45a77b42c..56422f801ee2f 100644
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
Does this logic break forward compatibility by ignoring unknown flags when =
the
test bit is set?

If userspace queries support for a future flag by passing:
devargk.flags =3D MSHV_CREATE_DEVICE_TEST | FUTURE_FLAG

The kernel will immediately return 0. This could mislead userspace into
believing the flag is supported. However, when userspace attempts to use the
flag without the test bit, the kernel will reject it.

Would it be better to check for unknown flags before checking the test flag?

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
Can this leak the file descriptor and associated resources if copy_to_user
fails?

The file descriptor is installed into the process fd table via
anon_inode_getfd(). If the subsequent copy_to_user() fails, the kernel retu=
rns
-EFAULT, but userspace does not receive the allocated fd number and cannot
close it.

Should this approach use get_unused_fd_flags() and anon_inode_getfile(),
delaying fd_install() until after copy_to_user() succeeds?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D4
