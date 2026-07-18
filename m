Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2523ABBE;
	Sat, 18 Jul 2026 02:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341872; cv=none; b=KnhYiGAwd1Qf5WaGyj/d08PIfU2ih29NrFERVaAKs3cbdqjEXpwkLLP2/5ZvXW7jkv/4XO8hRdE8Mp9yYv75KSTfBD4+k6N1Fp1o/5/7eLRJTVbYclyTjBEN9EgSMrQxuveS7OWos1jtmGQnc0KcvYRQArJ+E4u3WS91GU8nMio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341872; c=relaxed/simple;
	bh=Lw6sn4UpxOxgkIlQahHWaWKwSQwaST8pZtwBZWgmisM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CnzOH9mPGw+VIV9a6crTZl1zxtLY85uDcPiHvwie5q51zNzJRKEPrZS9VREWeTqCweO/0BmCm/8bGeS8EMS3MBLUzaL19JqvfIYDP6gexGH52nGnJpp3mbvCHY3fj1FREDm49ulqg+KD3aYXEXtC2H5SffXOi+sCPGvhzrJHtug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FAXXmTXG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FAXXmTXG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E421F000E9;
	Sat, 18 Jul 2026 02:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784341870;
	bh=OBLFhEeAaG5AWBfCSv8ZfI2y04DebpkodcMx2qWMgEs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FAXXmTXG/CYQtIdrfa1dZayUJAp0APuVhXkeUf6gs9Kk0lfuRVU14Cra7woK1lRQg
	 VD9FAdGbjo7FgkUrcsrLxhEiDOI+P9Anle829qUN/wDI2DqFyRn20oDXzWZQIY/5Hn
	 8sFcslzNcS8sNXn4tVqkQP5/Q0wXO+6r/p3TmuREi9sgoIRPPmmLDzu1IQLRVBHL2A
	 P57GtRa8MsxeiVYRD10B/2flP+Yx/NL963M9feynFJNptti3Z11ctldarwp8CHDxrk
	 SRbrz8TTtoN4p0PkeC057gy1WCdD9J7g/tuIB8HcELmx26Ij3n6Tre+jryTZ0trWrj
	 aa3PoBT+wgq+A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 2/9] mshv: Add declarations and definitions for
 VFIO-MSHV bridge device
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-3-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:31:09 +0000
Message-Id: <20260718023109.C6E421F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The UAPI ioctl command macro for MSHV_CREATE_DEVICE is missing.
- [Medium] The ops structure mshv_vfio_device_ops is not declared as const.
--

--- Patch [2]: [PATCH V4 2/9] mshv: Add declarations and definitions for VF=
IO-MSHV bridge device ---
commit dbad27877cef927b38632a1b77ab492ceeebae34
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Add declarations and definitions for VFIO-MSHV bridge device
   =20
Add data structs needed by the subsequent patch that introduces a new
module to implement VFIO-MSHV pseudo device.

> diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
> index a85c24dcc701a..b9880d0bdc4df 100644
> --- a/drivers/hv/mshv_root.h
> +++ b/drivers/hv/mshv_root.h

[ ... ]

> +struct mshv_device_ops {
> +	const char *device_name;
> +	long (*device_create)(struct mshv_device *dev);
> +	void (*device_release)(struct mshv_device *dev);
> +	long (*device_set_attr)(struct mshv_device *dev,
> +				struct mshv_device_attr *attr);
> +	long (*device_has_attr)(struct mshv_device *dev,
> +				struct mshv_device_attr *attr);
> +};
> +
> +extern struct mshv_device_ops mshv_vfio_device_ops;

[Severity: Medium]
Should mshv_vfio_device_ops be declared as const?=20

Operations structures containing function pointers are typically placed in
read-only memory as a security hardening measure. Missing the const keyword=
 on
the extern declaration prevents the future definition from being const with=
out
triggering compilation errors.

> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 32ff92b6342b2..be6fe3ee87078 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h

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

[Severity: High]
Is the UAPI ioctl command macro for MSHV_CREATE_DEVICE missing from this
header?

The struct mshv_create_device is defined for the ioctl payload, and the
comments reference MSHV_CREATE_DEVICE, but the actual ioctl command macro
appears to be absent. Without this definition, userspace cannot compile or
invoke the ioctl to create a device.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D2
