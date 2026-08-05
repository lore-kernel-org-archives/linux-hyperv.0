Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9646D3D301A
	for <linux-hyperv@vger.kernel.org>; Wed,  5 Aug 2026 21:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785963675; cv=none; b=eTLGZ2rbx4xBPRvCP5t/imRbZVlcH7QDYJWBth0t+k6SiHPy4EpqvLu+43Pqq/uNAvUsjyxFxyw1W8CPTPbDIKMtUHLjbOPEpBAqb4VtTQm6ObDCKpjueuezdR8YUpI+8eqOufrDKCRXDnjuo/nbmcNN3957gJipp1GHNjCQuP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785963675; c=relaxed/simple;
	bh=B+sN2DhnmjwJz9RrRf6W1Y1sZtCk8glf/ZtdGgWV4gA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G/jBQD6SeoYwigGPGhb7i0ZLShv3wayxIeQ9Yo+H0zsQk1Hxeh6ZtWC64vXYcfaC7Q9cE/MAxT9fk0m4GbydRutNHjHrI+dautKgCJcNj5ehrsze/8sz5UapUjfs4Cx96vB3IDoi6o0ib1ZwG97ic5gsOba9DY2mTOLN9Ot3V/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQLlL0IQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQLlL0IQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5985C1F000E9;
	Wed,  5 Aug 2026 21:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785963674;
	bh=t+V6o8OzqlZ1cNeMlVZ/+HJxZDU/v1uiok5mc3lZBiI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DQLlL0IQnVRJAo7KlrrerpizZceUy8LiG3sF6myKbMsc8plA8O+NEL5ul82jlSiMM
	 t0SXPnTRxjImb117hbF9s8tJEsI+zm4R6I++xbpm1LET01bfuZVXZEfApQCGzRLzjs
	 Almc+3nLS2sqd6ufHlTJqx07HyXgV9vV48Zp/SsmOC5WNui7Iak2dd+jVyy1ymCAsR
	 /sGKhBgIxrXc0sZdtROYCBn5Uy4MVQ8hlEJTScoWIgxIpuqv9B8gfMR1ZKCVlUErCr
	 f20hDBeeJBnk8nqV1GRSo0RLujfLjReoCeSiM+QM4Kud2q9nHtJCm+aLNF5YGUh7vj
	 LfQQUh8T88vww==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] hv_netvsc: Remove GPADL teardown special case
 for old Hyper-V hosts
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michael Kelley" <mhkelley58@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805203751.2678-4-mhklinux@outlook.com>
References: <20260805203751.2678-1-mhklinux@outlook.com>
 <20260805203751.2678-4-mhklinux@outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 21:01:13 +0000
Message-Id: <20260805210114.5985C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] vmbus_teardown_gpadl masks vmbus_post_msg failures, leading to=
 Use-After-Free/Memory Corruption in guest.
- [High] Missing synchronization between `netvsc_device_remove` and concurr=
ent TX path, leading to use-after-free or NULL pointer dereference in the V=
MBus ring buffer.
--

--- Patch [3]: [PATCH v2 3/6] hv_netvsc: Remove GPADL teardown special case=
 for old Hyper-V hosts ---
commit 25bcea31eec6bb56b8730b7c31834e06d41d6a61
Author: Michael Kelley <mhkelley58@gmail.com>

hv_netvsc: Remove GPADL teardown special case for old Hyper-V hosts

This commit removes the special case handling of GPADL teardown for
Hyper-V hosts earlier than Windows Server 2016 and Windows 10. The
receive and send GPADL teardowns are now always performed after the
VMBus channel is closed.

> diff --git a/drivers/net/hyperv/netvsc.c b/drivers/net/hyperv/netvsc.c
> index 4d319c50955ed..4295b96b43127 100644
> --- a/drivers/net/hyperv/netvsc.c
> +++ b/drivers/net/hyperv/netvsc.c
> @@ -695,17 +695,8 @@ void netvsc_device_remove(struct hv_device *device)
>  		=3D rtnl_dereference(net_device_ctx->nvdev);
>  	int i;
> =20
> -	/*
> -	 * Revoke receive buffer. If host is pre-Win2016 then tear down
> -	 * receive buffer GPADL. Do the same for send buffer.
> -	 */
>  	netvsc_revoke_recv_buf(device, net_device, ndev);
> -	if (vmbus_proto_version < VERSION_WIN10)
> -		netvsc_teardown_recv_gpadl(device, net_device, ndev);
> -
>  	netvsc_revoke_send_buf(device, net_device, ndev);
> -	if (vmbus_proto_version < VERSION_WIN10)
> -		netvsc_teardown_send_gpadl(device, net_device, ndev);
> =20
>  	RCU_INIT_POINTER(net_device_ctx->nvdev, NULL);
> =20

[ ... ]

> @@ -733,14 +724,9 @@ void netvsc_device_remove(struct hv_device *device)
>  	/* Now, we can close the channel safely */
>  	vmbus_close(device->channel);

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for a=20
concurrent TX path to race here and cause a use-after-free or NULL=20
pointer dereference?

In drivers/net/hyperv/netvsc_drv.c:netvsc_remove(),=20
rndis_filter_device_remove() is called before unregister_netdevice(),
which stops the TX queues:

netvsc_remove() {
	if (nvdev)
		rndis_filter_device_remove(dev, nvdev);
=09
	unregister_netdevice(net);
}

When netvsc_device_remove() (called from rndis_filter_device_remove)=20
clears the net_device_ctx->nvdev pointer and immediately calls=20
vmbus_close(), it doesn't wait for concurrent RCU readers like=20
netvsc_start_xmit() to finish.

If a concurrent TX thread has already read the pointer, couldn't it
proceed to write to the VMBus ring buffer, which has just been freed
and unmapped by vmbus_close()?

> -	/*
> -	 * If host is Win2016 or higher then we do the GPADL tear down
> -	 * here after VMBus is closed.
> -	*/
> -	if (vmbus_proto_version >=3D VERSION_WIN10) {
> -		netvsc_teardown_recv_gpadl(device, net_device, ndev);
> -		netvsc_teardown_send_gpadl(device, net_device, ndev);
> -	}
> +	/* Must do the GPADL teardown after channel is closed */
> +	netvsc_teardown_recv_gpadl(device, net_device, ndev);

[Severity: Critical]
This is a pre-existing issue, but does this teardown sequence handle=20
vmbus_post_msg() failures correctly?

Looking at drivers/hv/channel.c:vmbus_teardown_gpadl(), it appears to
mask the failure code for non-confidential VMs:

vmbus_teardown_gpadl() {
post_msg_err:
	/* ... */
	if (gpadl->decrypted)
		ret =3D set_memory_encrypted((unsigned long)gpadl->buffer,
					PFN_UP(gpadl->size));
	else
		ret =3D 0;
}

If vmbus_post_msg() fails (e.g., returning -ENOBUFS), this overwrites=20
the error with 0. The caller, netvsc_teardown_recv_gpadl(), assumes=20
a return value of 0 means the host successfully tore down the GPADL:

netvsc_teardown_recv_gpadl() {
	if (net_device->recv_buf_gpadl_handle.gpadl_handle) {
		ret =3D vmbus_teardown_gpadl(device->channel,
					   &net_device->recv_buf_gpadl_handle);
		/* If we failed here, we might as well return and have a leak
		 * rather than continue and a bugchk
		 */
		if (ret !=3D 0) { ... }
	}
}

Since vmbus_teardown_gpadl() silently returns 0 on failure, the network
driver will proceed to free the receive/send buffers.

Could the host still consider these buffers active and overwrite the newly
freed memory with incoming network packets, leading to guest memory=20
corruption?

> +	netvsc_teardown_send_gpadl(device, net_device, ndev);
> =20
>  	/* Release all resources */
>  	free_netvsc_device_rcu(net_device);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805203751.2678=
-1-mhklinux@outlook.com?part=3D3
