Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6649E489896;
	Fri, 31 Jul 2026 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785537765; cv=none; b=T90m5/7zwokfAYVW8TM+dM7ZmhNVSiaqJqFT2VcDOQywa/STEcpcwl84DRD5Bpg2nWUr18F0phg/q/9Ph4cxjdPIhZO1DEMIuc1Y2npiXQ/EWhTV3V/d3Zxp+HByKVJkiofSE8UT+R6/ZOgircD5yAKVSHY3e17dPZqB987ebkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785537765; c=relaxed/simple;
	bh=HxSWgtq7LT12FCiXSng2fS5kNwgz20SWgF3Qx7cFiCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GbqA6xdLZYabQ7PmAVLTJjCG9whsCELQruPy+IkZ0YFAQXeobSLa4SxVmS0cjsiko6WJgzPJU6FcpuHjpdCplpdclbpx1R/tsu5DCkxLQw+4XO270cpKBWMc6zQZc00KcuisFMk+EkoLgsKHTotfqWR2s9aJITdHvWCHKOBF+6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lC50cc/c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lC50cc/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74C391F00AC4;
	Fri, 31 Jul 2026 22:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785537764;
	bh=urflv5L2a1xzs2/9k9RX1UVjApVtFPoR8HwbrBOos1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lC50cc/ce2iyFZ5XSxXG8qDVHvjEEfvYCMRuVjEHSQOVZV/mU30Uiwn4LdmiiUzoG
	 Btx677kj+WGUeIvzqQ+pz0uml0nZFPJsrIWcnDthUR9TQUIib+zRJFQzdnqgsMK4vs
	 NR5Nl2wi8/7+iRG2sHLb+b44loU1OX70kdvC9WhmzfZRRIv96XyYUaxU0J74AXQlug
	 iaRUf+1x9hIOdS61YEd7otEHtEvqWkJacDKtnQsWggUvLXA105+7tr2o0vyAIDjUqF
	 6MGe1t/GeP90eRsPVUqiWpvMH/tmvsK/B6DjltjRuQINhWanQ/4Oc+pR/IONH1zVgu
	 PPT5sGjDW+Qow==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/9] mshv: Add declarations and definitions for
 VFIO-MSHV bridge device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260731223427.2554388-3-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:42:42 +0000
Message-Id: <20260731224243.74C391F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The `MSHV_CREATE_DEVICE` ioctl command definition is completely =
missing from the UAPI header.
--

--- Patch [2]: [PATCH v5 2/9] mshv: Add declarations and definitions for VF=
IO-MSHV bridge device ---
commit e1e53f07045678558c5d600cce2f941f492fd69b
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Add declarations and definitions for VFIO-MSHV bridge device

Add data structs needed by the subsequent patch that introduces a new
module to implement VFIO-MSHV pseudo device.

> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 32ff92b6342b2..be6fe3ee87078 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -404,4 +404,34 @@ struct mshv_sint_mask {

[ ... ]

> +/* Device passhthru */
> +#define MSHV_CREATE_DEVICE_TEST		1
> +
> +enum {
> +	MSHV_DEV_TYPE_VFIO,
> +	MSHV_DEV_TYPE_MAX,
> +};
> +
> +struct mshv_create_device {
> +	__u32	type;	     /* in: MSHV_DEV_TYPE_xxx */
> +	__u32	fd;	     /* out: device handle */
> +	__u32	flags;	     /* in: MSHV_CREATE_DEVICE_xxx */
> +};
> +
> +#define MSHV_DEV_VFIO_FILE      1
> +#define MSHV_DEV_VFIO_FILE_ADD	1
> +#define MSHV_DEV_VFIO_FILE_DEL	2
> +
> +struct mshv_device_attr {
> +	__u32	flags;		/* no flags currently defined */
> +	__u32	group;		/* device-defined */
> +	__u64	attr;		/* group-defined */
> +	__u64	addr;		/* userspace address of attr data */
> +};
> +
> +/* Device fds created with MSHV_CREATE_DEVICE */
> +#define MSHV_SET_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x00, struct mshv_device_a=
ttr)
> +#define MSHV_HAS_DEVICE_ATTR	_IOW(MSHV_IOCTL, 0x01, struct mshv_device_a=
ttr)

[Severity: Medium]
Is the definition for the MSHV_CREATE_DEVICE ioctl missing here?

The comment right above mentions device fds created with MSHV_CREATE_DEVICE,
and the patch adds struct mshv_create_device, but the actual ioctl macro
is never defined. Would this prevent userspace from compiling against the
header to use the device passthrough feature?

> +
>  #endif

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D2
