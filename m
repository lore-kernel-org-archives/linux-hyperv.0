Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB77125B0AD;
	Sat, 18 Jul 2026 02:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784342188; cv=none; b=YrMxQ3vGtgz/qNR9wfyjVAzQPGH6TxzC3mcHWA88rAhhkEvKSW/5Krjd7RFrOatd4nTqE24a1eq+iS9IC+LRlmybYMh+KkOK//uU89c9jSzPzGeHx++aCd2qCHkOSw26gSI1hiEtSxTSG2wcj+Cw8elYc38SD0Jx9aQzmLwn7n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784342188; c=relaxed/simple;
	bh=xN7HpgCIu81R4FL0VUGtgjaK225J7hDtF6xJ38MCfiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Is3/4hEJzdcPYbEv1fQiz5xSr0W5dHBD5JpLqMZsbDuHA8jDpTo4E2pvs7/Fhb98EbmqCWNjV8K7WVOQjv13/pxRE/IBYQpoQ3rHZYWB4BcpFpXqPRXm+LbT57THywcABKPFy2pIHhhYwXpq+V0zu7lYCq1KY1w0HzP8JTbPAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kjD5GZpV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kjD5GZpV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453231F000E9;
	Sat, 18 Jul 2026 02:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784342186;
	bh=JZCJOmW5TpvPshUaOFdeZhi+dEtdO3e5Im7yT5W3zUw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kjD5GZpVr/7vM2BgR62oLxy1fJRiytM3nybg/YwO2mvqk4mBw8qH0I8k+DyUJcMfR
	 b2UaIcy4xYwUf25omyh0Ju0OVmlNDfgyaliWD7di7r3y+tyYoCoxwg93oVhJnpEmMd
	 9lzRyQQq2e8PnCysR9NJk00gW1Ft//XiblbvoJWr/TUumRHOLGa/BVuAzHkZ5+jDIa
	 Xn/rVHcVypUaI+Yxe1JesionOSHzdB5Ao52VK1scQrTdN7hhIvoJrwLRygZpA1NsF5
	 wCmkKtN2lBKB/+UcJYzGGzNN4jixi8mJp2VxMr9YTep9KBbZx6eqec5u8gJyQpuZLz
	 Q8uly02o759NA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 3/9] mshv: Introduce basic mshv bridge device for
 VFIO to build upon
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260718021949.926306-4-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:36:25 +0000
Message-Id: <20260718023626.453231F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The MSHV_CREATE_DEVICE ioctl handler is missing in the core MSHV=
 framework, rendering the VFIO-MSHV bridge device completely unreachable.
--

--- Patch [3]: [PATCH V4 3/9] mshv: Introduce basic mshv bridge device for =
VFIO to build upon ---
commit 58c1a16396f01cf3f0ff1eb2d7b11c08f90ca678
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Introduce basic mshv bridge device for VFIO to build upon

This commit introduces a basic VFIO-MSHV bridge pseudo device based on the
VFIO-KVM bridge. It adds the mshv_vfio.c implementation and a new UAPI ioctl
MSHV_CREATE_DEVICE.

> diff --git a/drivers/hv/mshv_vfio.c b/drivers/hv/mshv_vfio.c
> new file mode 100644
> index 0000000000000..a770b508f0800
> --- /dev/null
> +++ b/drivers/hv/mshv_vfio.c

[ ... ]

> +struct mshv_device_ops mshv_vfio_device_ops =3D {
> +	.device_name =3D "mshv-vfio",
> +	.device_create =3D mshv_vfio_create_device,
> +	.device_release =3D mshv_vfio_release_device,
> +	.device_set_attr =3D mshv_vfio_set_attr,
> +	.device_has_attr =3D mshv_vfio_has_attr,
> +};

[Severity: Medium]
Since the ioctl to create this device is missing from the core ioctl=20
handlers, does this device operations struct and the rest of the VFIO-MSHV=
=20
bridge implementation become unreachable dead code?

> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index be6fe3ee87078..b038a79786d2d 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
> @@ -254,6 +254,7 @@ struct mshv_root_hvcall {
>  #define MSHV_GET_GPAP_ACCESS_BITMAP	_IOWR(MSHV_IOCTL, 0x06, struct mshv_=
gpap_access_bitmap)
>  /* Generic hypercall */
>  #define MSHV_ROOT_HVCALL		_IOWR(MSHV_IOCTL, 0x07, struct mshv_root_hvcal=
l)
> +#define MSHV_CREATE_DEVICE             _IOWR(MSHV_IOCTL, 0x08, struct ms=
hv_create_device)

[Severity: Medium]
Is this ioctl actually wired up anywhere in the core MSHV framework?=20

I can't find an implementation for MSHV_CREATE_DEVICE in any ioctl=20
dispatcher (like mshv_partition_ioctl()). Will userspace simply receive=20
-ENOTTY when attempting to use this command?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D3
