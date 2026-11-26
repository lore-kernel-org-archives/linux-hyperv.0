Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795676209;
	b=btR5JG2hsH3yciltfvfJCxozKmq5ln6tpwpvjSzEVuKx/nQCsDAmWdei+Oe6VrlkTvIk
	 Y0X1Ovuw6jjS1MGvpLbqfIdQkDBwdYhsBab4tyA0wE/Y1jgaWRqsnNk5SUDwpJyKsjZ+S
	 da7Py199bxFvOyyuWF3MI1bSmJ1rz+tT7qtPNufK40HECnNSr//TNxeiRaR5JJeSZPGHh
	 Imtu3JtcHkHtrqw0zCuZnGwa4FhMcrcqKlPEktIi56HD7RrFd21j4ejtpCky0M827IcOt
	 bGwz1i733UnfZCCa+OrC4kLh47ZMF4W9MnptFGPe9xDYJwX/gREeFJ3jHoTF1A/EH9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795676209;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=lkeTqdQLQD0fpoKI3L8ZCXF8MBS1Cq1dSw0Ks9BuoyE=;
	b=Ds9W2nb27zrr9FxtwLMFE6GQV505xLop49/6s5PEjq7NMIQs1b7kSNw/ZLgAHatj9ZMl
	 kWoHfdOeGu73+zzGbMzU9j6cVMAX5cnGKa7RCGYpoRJlPkQSx3y1oo6oM7fnwVkEHWLsH
	 iZZKcRdd0REUNq0OD3i8d1FZ2Y4L4mDk/2hiALqbbh6JO9pMQWunch3f09LVThLaOGvre
	 933jjYSWiZT/mMEVKTYAILpnIDskbzU5wIHDysdJIBsLxYF6JSY1ErsO6e9JzxKXFtnGC
	 wYme9Nchybz3Rxd7CSvWHRMSciDo8fCIlqtQVkFYlezQj/gcjVN9dOFt6cyi5SjmSvg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwE8kxPM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A55B606A31C
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Nov 2026 06:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hwE8kxPM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6EB91F000C6;
	Thu, 26 Nov 2026 06:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795676208;
	bh=lkeTqdQLQD0fpoKI3L8ZCXF8MBS1Cq1dSw0Ks9BuoyE=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=hwE8kxPMexYXsdIeXDqZgvqVC+99c7UM2T7ZqAOwPqLOUhXK5L97f6UXc3qjq2851
	 zDaPu4D5D3cgPUq6RFgvd1Tr3BzW8RlNOoZJsAHi0z3FKjjsAMhI+haGV51bBVimPF
	 sW673jWmQbYE24WbbB1iALQSQr7hazqqG9mzy1f2Z3yuBqQDwZ9RBiW60f9pIQMUWk
	 CG/qdqPyyekoMvlkGOq3W3iOsAW5EXlRhhEh5/5O+XCClkoZ67S5tKOvKrEztNhpXn
	 KTacmm6D3PASAx9GPdF8G8wUNPcvnu7+pZssLl3STsD+5OMCoca3WXa0xYKuIX3i+w
	 cCc8ABQZaMijA==
Message-ID: <sashiko-outbox-234917@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: hv_netvsc: Preserve RSS indirection table
 across device recreation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261125065620.1604647-1-gargaditya@linux.microsoft.com>
References: <20261125065620.1604647-1-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 06:56:48 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] net: hv_netvsc: zeroing rss_key and rx_table in
  netvsc_attach() breaks RSS
--

commit a79f79b300587b1f53e9f4a583c55f0d45f71328
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: hv_netvsc: Preserve RSS indirection table across device recreation

This commit saves and restores a user-configured RSS indirection table
and cached RSS hash key across RNDIS device recreation, and notifies
ethtool if the custom table cannot be restored.

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index 1d43c73fd73f1..f51e7b349d7f7 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c

[ ... ]

> @@ -1036,6 +1054,19 @@ static int netvsc_attach(struct net_device *ndev,
>  		if (ret) {
>  			nvdev->max_chn =3D 1;
>  			nvdev->num_chn =3D 1;
> +		} else {
> +			ret =3D rndis_filter_set_rss_param(nvdev->extension, dev_info->rss_ke=
y);
> +		}
> +
> +		if (ret) {
> +			netdev_err(ndev,
> +				   "unable to restore RSS parameters (ret %d).\n",
> +				   ret);
> +			/* Do not report the saved parameters as restored. */
> +			memset(ndev_ctx->rx_table, 0,
> +			       ndev_ctx->rx_table_sz * sizeof(*ndev_ctx->rx_table));
> +			memset(nvdev->extension->rss_key, 0, NETVSC_HASH_KEYLEN);
> +			rss_failed =3D true;
>  		}
>  	}

[Severity: Medium]
Does zeroing nvdev->extension->rss_key and ndev_ctx->rx_table here break
later RSS updates and re-attachments?

rndis_set_rss_param_msg() always sends both ndc->rx_table and the 40-byte
hash key to the host together, and netvsc_set_rxfh() uses the cached
values whenever userspace updates only one of them:

drivers/net/hyperv/netvsc_drv.c:netvsc_set_rxfh() {
    ...
	if (rxfh->indir) {
		for (i =3D 0; i < ndc->rx_table_sz; i++)
			if (rxfh->indir[i] >=3D ndev->num_chn)
				return -EINVAL;

		for (i =3D 0; i < ndc->rx_table_sz; i++)
			ndc->rx_table[i] =3D rxfh->indir[i];
	}

	if (!key) {
		if (!rxfh->indir)
			return 0;

		key =3D rndis_dev->rss_key;
	}

	return rndis_filter_set_rss_param(rndis_dev, key);
}

If userspace responds to ethtool_rxfh_indir_lost() by setting or
resetting only the indirection table, netvsc_set_rxfh() falls back to
rndis_dev->rss_key and programs an all-zero Toeplitz key into the host,
hashing all RX traffic to queue 0; future re-attachments via
netvsc_devinfo_get() also save and program that zeroed key.  Similarly,
if rndis_set_subchannel() succeeded with multiple channels but
rndis_filter_set_rss_param() failed, updating only the hash key sends the
zeroed ndev_ctx->rx_table instead of the default round-robin table.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261125065620.1604=
647-1-gargaditya@linux.microsoft.com?part=3D1
