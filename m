Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F815448A0
	for <linux-hyperv@vger.kernel.org>; Tue,  8 Sep 2026 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788904171; cv=none; b=AvwBtEsiOL9aX9iZtFgsPS6jPF9PnXiAkt5skoH/ARa8JAe7Uav2Kj4XHe/DrhBipbb0YIzYNrLO9E3lLIeOCeqMcokjFJgB8VN2+OcFRjd7ZSBLyKX6tA/7o1yzwommjIreh3Z7AuD70L21JhYQU86DdyzdFP+PAhVBotoJf6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788904171; c=relaxed/simple;
	bh=MtypcjXgdlaUXb7tiH/Q2KjUfmMnvDUxcHwpmQxEJP4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tb0UPYR2kuv96UUwHtgVSilnzQx7f6QQzZiSrP6IuWXjZX5zrlJ2a+iywXYgbNjGbzVhBlIsLsvyQxmGiJrtL6ZKw0ty0PFmm3YiMCK0Q5EwQGNOgr1ulWZGDg2rxO8HHaC3Ps5jIhrnFU2DMNR8q9QOO2sQv2WgrrjQHZi5LDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOgXwNtU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOgXwNtU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5801F00A3A;
	Tue,  8 Sep 2026 21:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788904169;
	bh=N4bBK0AQ+RPMF8ViVIYm5kUocrS0CWBuCF4dHrlpedk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VOgXwNtUY9C51MaNYPDXGNUGlLdaxIbCox7zfLiAH2fDTSQUYcbgSXJ7hGwxRs2Gu
	 uFcn0GONgLYG+NQD0zHcG1Z1sFbXu+glRFnVaKolftpyI1+xBN4U0Xh2jg0mrNpbuY
	 xDXr2PrRg5RJslM1MlXRzFaVBJhVxqAem/PnJvrOIiTS4WDw11pIPFo9Yt9AlITgCq
	 dC6EBRa7j4zJ+qpGuur4uMvUmORw6Xfe9xUHwLxSq76WtD0/lB/mIO4f450b/gtU98
	 T2q/7UH2/WP6JKDt7OJgH8+dHzx4F1UVu9QteuRZyux93acbDaLZ/T9wuDWDTIYH2C
	 7elGK1+ov8l4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] hv_netvsc: Leak send/recv buffers if GPADL
 teardown fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260907214902.9046-4-mhklinux@outlook.com>
References: <20260907214902.9046-1-mhklinux@outlook.com>
 <20260907214902.9046-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 21:49:28 +0000
Message-Id: <20260908214929.5E5801F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] vmbus_leak_buffer() sets net_device->recv_buf to NULL on GPADL tea=
rdown failure, but NAPI can concurrently execute netvsc_receive() and deref=
erence the NULL pointer.
--

commit b7bdfecb181c55de06655f1fafcb80eb2c61ea1f
Author: Michael Kelley <mhkelley58@gmail.com>

hv_netvsc: Leak send/recv buffers if GPADL teardown fails

This commit addresses a bug where send/recv buffers were improperly freed if
GPADL teardown failed. It introduces calls to vmbus_leak_buffer() to safely
leak the buffers instead of freeing them when they might still be accessed =
by
the host.

Closes: https://lore.kernel.org/linux-hyperv/20260731201210.3653C1F00AC4@sm=
tp.kernel.org/

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 5cd084e5696cd..e9292c3fac925 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -316,9 +316,11 @@ static void netvsc_teardown_recv_gpadl(struct hv_dev=
ice *device,
>  		 * rather than continue and a bugchk
>  		 */
>  		if (ret !=3D 0) {
> +			vmbus_leak_buffer(&net_device->recv_buf,
> +					  &net_device->recv_buf_chunks,
> +					  &net_device->recv_buf_chunk_cnt);

[Severity: High]
Could this lead to a NULL pointer dereference if NAPI is still polling
concurrently?

In netvsc_device_add(), NAPI is enabled and the VMBus channel is opened. If=
 a
subsequent initialization step fails (like send_buf setup), the error path
calls netvsc_teardown_recv_gpadl().

If the GPADL teardown fails, vmbus_leak_buffer() will set
net_device->recv_buf to NULL. Because NAPI is not synchronized with this
teardown and is disabled later in the error path, a concurrent softirq could
execute this path in netvsc_receive():

    char *recv_buf =3D net_device->recv_buf;
    ...
    data =3D recv_buf + offset;
    ...
    ret =3D rndis_filter_receive(ndev, net_device, nvchan, data, buflen);

Since the code does not check for NULL, it passes the faulty data pointer
(NULL + offset) to rndis_filter_receive().

This would result in a kernel panic when trying to read from the pointer:

    memcpy(rndis_msg, data, RNDIS_HEADER_SIZE);

Is there a way to defer setting recv_buf to NULL until after NAPI has been
disabled?

>  			netdev_err(ndev,
>  				   "unable to teardown receive buffer's gpadl\n");
> -			return;
>  		}
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907214902.9046=
-1-mhklinux@outlook.com?part=3D3
