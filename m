Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793614012;
	b=sQas1aGP4wSlreCwMPF0uJ1DpCWmpua1A/la0vLCw0Kvljh2Kd8kxyLNtWmM2aXPMgyL
	 AUwvWP4XQmUMdz98Q3rTX68hv8r+ZusZqp0yvFbor2uTRSylvHvu1DcBszdkDUPNEfxzM
	 KrnF+BSlubNsEXNIC2TfFdy1Pd7GS3fsyN+Tp5kT2inZyhmW75/GDN5ugti1FJuXu3jPl
	 OdDL/JI9leynVjGunlj4YcRi6BP63EKIIIOmBOrz0CdVHJPtPTPfYptoqHZ7cU1bLdhrL
	 QS0cq2fxCxntJQZ/sU6P43u0GuNWf0pFH/uMZedSDfUPP4KS+krW191sKx8GDmMI1tw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793614012;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=DnwQUn0NizH38YcALtR1dtCEgebPZ9psHaxumsb/QSw=;
	b=c2jQdlzQAJxk9d2RgUL3bjYAfauGrlrVeWcdqp5CfyfREqooQuVK37p3HpjEMk4tDp4q
	 z9CwlVObePzj1TzRgMsb8HO7YGLjxx7YOtvYUg/tRBIcc5wRzxQXX9y/Zt1kGFlE7GFO7
	 uxXZe/EptHW6j6yunVs1EmlyYTkdmpv3AJUHfh8UeDljBBeXA+UDo/Bmr0Afr0utbhIzv
	 8rl7mRnr6PUoGdeFVxDcBmi8O4ccVv6AW8guazgpBVF9Fgku78IdR5HbWlWuGnWhae6bR
	 L2+Nu/PWgfMBOx7lIl3o3LIuqA19t+rYV5hWLJHiTI8l5dvxN1/lwp9un4wyEumlF1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSo89aQz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CF606A332
	for <linux-hyperv@vger.kernel.org>; Mon,  2 Nov 2026 10:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dSo89aQz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44E641F0093A;
	Mon,  2 Nov 2026 10:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793614011;
	bh=DnwQUn0NizH38YcALtR1dtCEgebPZ9psHaxumsb/QSw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dSo89aQzDpOs3wIEN+Txng9XJni2pnZGX2kLOFofsFLVFBHt2ymb5TDGfg1Qy6tdX
	 zWFgi64S9Hgi4E0gurc3+VFHTyl1seLLZM8tqWhhciPfCrdY9wVCRAYQcojFFz3qyK
	 uuR1vQI7glQh8j6zibnccp176eGuCgBJ/I+1VOAON4tNamYFmLkg1ljeBsHF3o9tuo
	 ozt8ux+OL6mT0/1R19i662tDB7R6/DzMkDQl+rKIILgV2dAu4Kp0XE1vpaYWmdN/vt
	 vveEco/L4MB/w/8Rw0uJEX9LnkcXl5ynNlJlR1waP1RJNRGDAhvBsIS9/2NS5lWCgo
	 /Oo5Lf6jqx4Kg==
Message-ID: <sashiko-outbox-193234@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Do not remove the channel when
 device registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuqiang Sun" <izaiahsun@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261102094719.35760-3-izaiahsun@gmail.com>
References: <20261102094719.35760-1-izaiahsun@gmail.com>
 <20261102094719.35760-3-izaiahsun@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Nov 2026 10:06:50 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Critical] Drivers: hv: vmbus: channel UAF after device_del() in vmbus_de=
vice_register()
- [High] Drivers: hv: vmbus: NULL channel dereference in vmbus_match() on r=
eg failure
--

commit 1b8392611b72249068d7b640dddf153a43c0780f
Author: Yuqiang Sun <izaiahsun@gmail.com>

Drivers: hv: vmbus: Do not remove the channel when device registration fails

This commit clears child_device_obj->channel before dropping the device on
the error paths of vmbus_device_register(), and updates
vmbus_device_release() to only call hv_process_channel_removal() if the
channel pointer is non-NULL, leaving channel cleanup on registration failure
to vmbus_add_channel_work().

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index fc0f16f512669..e8fb0c4c4f5ea 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c

[ ... ]

> @@ -2189,6 +2195,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  	ret =3D device_register(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		child_device_obj->channel =3D NULL;
>  		put_device(&child_device_obj->device);
>  		return ret;
>  	}

[Severity: High]
Can clearing child_device_obj->channel here (and in err_dev_unregister belo=
w)
cause a NULL pointer dereference in vmbus_match() if a concurrent
driver_attach() is iterating over hv_bus?

Once device_register() -> device_add() -> bus_add_device() adds
child_device_obj->device.p->knode_bus to hv_bus's klist_devices, a concurre=
nt
driver_attach() (for example from __vmbus_driver_register() or userspace
writing to new_id_store() -> vmbus_add_dynid()) can iterate over
klist_devices via bus_for_each_dev() while holding an active klist node
reference on child_device_obj->device.

If device_add() subsequently fails at its DPMError label (or if
vmbus_device_register() fails later and calls device_del() at
err_dev_unregister), bus_remove_device() calls klist_del(&dev->p->knode_bus=
).
Unlike klist_remove(), klist_del() does not wait for active klist_iter
readers in bus_for_each_dev() to finish before vmbus_device_register() sets
child_device_obj->channel =3D NULL.

On the concurrent bus_for_each_dev() thread, __driver_attach() calls
driver_match_device() -> vmbus_match() before acquiring device_lock(dev) or
checking dev->p->dead:

drivers/hv/vmbus_drv.c:vmbus_match() {
	...
	/* The hv_sock driver handles all hv_sock offers. */
	if (is_hvsock_channel(hv_dev->channel))
		return drv->hvsock;
	...
}

Unlike the sysfs attribute callbacks in drivers/hv/vmbus_drv.c which check
for !hv_dev->channel, vmbus_match() unconditionally passes hv_dev->channel =
to
is_hvsock_channel(), dereferencing hv_dev->channel->offermsg when
hv_dev->channel is NULL.

> @@ -2228,7 +2235,10 @@ int vmbus_device_register(struct hv_device *child_=
device_obj)
>  	kset_unregister(child_device_obj->channels_kset);
> =20
>  err_dev_unregister:
> -	device_unregister(&child_device_obj->device);
> +	/* The driver's remove, if one was bound, still needs the channel */
> +	device_del(&child_device_obj->device);
> +	child_device_obj->channel =3D NULL;
> +	put_device(&child_device_obj->device);
>  	return ret;
>  }

[Severity: Critical]
When vmbus_device_register() fails after device_register() has already
probed and bound a driver, does device_del() followed by freeing newchannel
in vmbus_add_channel_work()'s err_deq_chan path leave dangling channel
pointers when the channel has not been rescinded?

There appear to be two cases where drv->remove() does not sever all
references created during drv->probe() unless the channel was rescinded:

1. For hv_sock channels, hvs_probe() -> hvs_open_connection() in
net/vmw_vsock/hyperv_transport.c sets hvs->chan =3D chan (or
hvs_new->chan =3D chan) on the vsock_sock, takes a socket reference via
sock_hold(), and inserts the socket into the vsock connected table and acce=
pt
queue. When device_del() invokes vmbus_remove() -> hvs_remove():

net/vmw_vsock/hyperv_transport.c:hvs_remove() {
	struct vmbus_channel *chan =3D hdev->channel;

	vmbus_close(chan);
}

hvs_remove() only closes the ring buffer because in normal operation it is
only called from hvs_destruct() -> vmbus_hvsock_device_unregister() after
hvs_close_connection() has already run on channel rescind. When
err_dev_unregister runs without a rescind, hvs_close_connection() is never
called, so the live vsock_sock retains hvs->chan pointing to newchannel
after vmbus_add_channel_work() frees it via free_channel(newchannel), leadi=
ng
to a use-after-free in socket operations or in hvs_destruct() ->
vmbus_hvsock_device_unregister(chan).

2. For multichannel drivers that open sub-channels during probe,
vmbus_process_offer() links offered sub-channels onto newchannel->sc_list
with sc->primary_channel =3D newchannel and queues vmbus_add_channel_work()
onto handle_sub_chan_wq. When device_del() runs drv->remove() ->
vmbus_close() -> vmbus_disconnect_ring():

drivers/hv/channel.c:vmbus_disconnect_ring() {
	...
	list_for_each_entry_safe(cur_channel, tmp, &channel->sc_list, sc_list) {
		if (cur_channel->rescind)
			wait_for_completion(&cur_channel->rescind_event);

		mutex_lock(&vmbus_connection.channel_mutex);
		if (vmbus_close_internal(cur_channel) =3D=3D 0) {
			vmbus_free_ring(cur_channel);

			if (cur_channel->rescind)
				hv_process_channel_removal(cur_channel);
		}
		mutex_unlock(&vmbus_connection.channel_mutex);
	}
	...
}

vmbus_disconnect_ring() only removes cur_channel if cur_channel->rescind is
true, leaving non-rescinded sub-channels on sc_list and handle_sub_chan_wq
referencing the freed primary channel.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261102094719.3576=
0-1-izaiahsun@gmail.com?part=3D2
