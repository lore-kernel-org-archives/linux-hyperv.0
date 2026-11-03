Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793718493;
	b=kBK7ABXdbRqQBhohI5gY48P8K/VdGczE7FDyqb2NNrgrjiOXtOELiJ2aWF3VwT6KMTaw
	 KqK0iJ0m0BhY15I1HJ/mTikY4bdEoAg+235Mt5uIGyQDoxNMyyc3dyeqKhcwJysrYF1bY
	 eFAZZoxxWCJvXlSY1iRGS1lgQwZjV3GEBVPrp/axGfuxGtkem4ASRDpO/ZBXEvD0kqSDJ
	 6ZwFXBBk4FE5qETX5Y+ZVCwZHsTHLrGpGue3MrpDRFD2le1dWVR7vrbu9cMRscttdYOKe
	 eNmjDN46sIWic8crAspPk1OAUmJXcgP6KVeMeBaD+Jn0m8JVoxhLO/FL98xkElfog1w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793718493;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CJWkTRTUbBiT8jHcxjcF/lmpYuRyURbUPnGPT1HsQcc=;
	b=mPiyWt9lZ03UbfcJMLkA32R7yCPwiCuy4yObfIuP8USBsaFAwQ3kqgmAMX+xpz5ovGvL
	 qXwiBx49eS3m7h9UaoVafSzdSn6Sg/wOX0EatN8cyCHD7krxqkXTj5TXqVWhX3xdLKyIH
	 w9j3tWx+TXMHrXywOvIxdmypDzCWW7AficG/AEqbhUjjTBS0f8XqQ52jCLL6yKpJXtont
	 A67Focj9LjkQ6ASLb1AHVabWTgr11JE+3J47EuinG+bKMCgoJwNxqea6Qzik/9RWGtGQ8
	 wD6mD7k5UwHrCwepIZmgeAyjdBBawrpkBemKvu47QOEDBYlfs/2gR+R+pdZB3dhG3VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLoRCzKh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0409606A32F
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NLoRCzKh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 604371F000C1;
	Tue,  3 Nov 2026 15:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793718492;
	bh=CJWkTRTUbBiT8jHcxjcF/lmpYuRyURbUPnGPT1HsQcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NLoRCzKh8P4trEfvER32HD3JZ3FX+u0La2E/OawckIWSmhkvLeSnKLaMoqz74OZT1
	 8o89BfJleGPaCNYTZ3tQMEVzM6pax+Yo9afQrjFeywgkwti/O9DI3gkKBsqaYy0ciJ
	 YiCqfSpeZ6M7xgzPITPP2NA2kORec61Ar8yCyx04t90SZTyRIBWZdfYnNJa7cNvXym
	 J9K2VVE3prW1t1w4x+DzwhLvc6+EfoF8jYuf8jKWtm40hhMyR0+nRXZDFEPzM+Otf1
	 lCll1xth+2bsQ1HFUIRaB7EdJaFQqUVMZxw/a/4AAZaHfryH3SetunbzJapfgfOOqi
	 z94IPIk9XOBWQ==
Message-ID: <sashiko-outbox-195557@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] Drivers: hv: vmbus: Do not remove the channel
 when device registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuqiang Sun" <izaiahsun@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261103144006.69857-3-izaiahsun@gmail.com>
References: <20261103144006.69857-1-izaiahsun@gmail.com>
 <20261103144006.69857-3-izaiahsun@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 15:08:12 +0000
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
- [High] hv: vmbus: channel UAF and double removal on vmbus_add_channel_wor=
k() error
- [High] hv: vmbus: leaked CPU mask and suspend counter in vmbus_add_channe=
l_work()
--

commit 99d3a552529c5941e934071a1f2968acea94e54e
Author: Yuqiang Sun <izaiahsun@gmail.com>

Drivers: hv: vmbus: Do not remove the channel when device registration fails

This commit avoids calling hv_process_channel_removal() from
vmbus_device_release() when device_register() fails by clearing the
device's channel pointer and letting vmbus_add_channel_work() clean up
the channel. It also keeps the device registered if sysfs channel
setup fails after device_register() succeeds.

> diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
> index cb1d8d76928ff..1fa232e86fce2 100644
> --- a/drivers/hv/channel_mgmt.c
> +++ b/drivers/hv/channel_mgmt.c
> @@ -554,15 +554,16 @@ static void vmbus_add_channel_work(struct work_stru=
ct *work)
>  	 * method.
>  	 *
>  	 * If vmbus_device_register() fails, the 'device_obj' is freed in
> -	 * vmbus_device_release() as called by device_unregister() in the
> -	 * error path of vmbus_device_register(). In the outside error
> -	 * path, there's no need to free it.
> +	 * vmbus_device_release() as called by put_device() in the error
> +	 * path of vmbus_device_register(). In the outside error path,
> +	 * there's no need to free it, but the channel must not point to it.
>  	 */
>  	ret =3D vmbus_device_register(newchannel->device_obj);
> =20
>  	if (ret !=3D 0) {
>  		pr_err("unable to add child device object (relid %d)\n",
>  			newchannel->offermsg.child_relid);
> +		newchannel->device_obj =3D NULL;
>  		goto err_deq_chan;
>  	}

[Severity: High]
As reported by Sashiko on v2 [1], can jumping to err_deq_chan in
vmbus_add_channel_work() race with a concurrent vmbus_onoffer_rescind()
and cause a use-after-free on channel or a double channel removal?

In vmbus_process_offer(), newchannel is linked onto chn_list or sc_list,
mapped via vmbus_channel_map_relid(), and offer_in_progress is decremented
before vmbus_add_channel_work() is queued. If a rescind offer arrives
while vmbus_add_channel_work() is running, vmbus_onoffer_rescind() looks
up the channel, sets channel->rescind_ref =3D true and channel->rescind =3D=
 true,
and waits for probe_done without holding a kobject reference or an RCU
read lock:

drivers/hv/channel_mgmt.c:vmbus_onoffer_rescind() {
	...
	while (READ_ONCE(channel->probe_done) =3D=3D false) {
		msleep(1);
	}

	if (channel->device_obj) {
		...
	} else if (channel->primary_channel !=3D NULL) {
		mutex_lock(&vmbus_connection.channel_mutex);
		if (channel->state =3D=3D CHANNEL_OPEN_STATE) {
			hv_process_channel_removal(channel);
		}
		...
}

When vmbus_device_register() fails (or when vmbus_device_create() or
vmbus_add_channel_kobj() fails), err_deq_chan sets
newchannel->probe_done =3D true, unlinks and unmaps newchannel, and calls
free_channel(newchannel) -> kobject_put() -> vmbus_chan_release() ->
kfree_rcu(channel, rcu):

drivers/hv/channel_mgmt.c:vmbus_add_channel_work() {
	...
err_deq_chan:
	mutex_lock(&vmbus_connection.channel_mutex);
	newchannel->probe_done =3D true;

	if (primary_channel =3D=3D NULL)
		list_del(&newchannel->listentry);
	else
		list_del(&newchannel->sc_list);

	vmbus_channel_unmap_relid(newchannel);
	mutex_unlock(&vmbus_connection.channel_mutex);

	vmbus_release_relid(newchannel->offermsg.child_relid);
	free_channel(newchannel);
}

Because vmbus_onoffer_rescind() is sleeping in msleep(1), the RCU grace
period can finish before vmbus_onoffer_rescind() wakes up and dereferences
channel->probe_done, channel->device_obj, and channel->primary_channel.

In addition, on weakly ordered architectures, newchannel->device_obj =3D NU=
LL
and newchannel->probe_done =3D true are plain stores separated only by
mutex_lock(&vmbus_connection.channel_mutex) (an acquire barrier, not a
release barrier), while vmbus_onoffer_rescind() reads
READ_ONCE(channel->probe_done) and channel->device_obj without holding
channel_mutex or using load-acquire. Could vmbus_onoffer_rescind() observe
probe_done =3D=3D true while still seeing the stale non-NULL channel->devic=
e_obj
pointer to the freed hv_device?

Finally, for a sub-channel failing in vmbus_add_channel_kobj(),
newchannel->state was already set to CHANNEL_OPEN_STATE at the start of
vmbus_add_channel_work(). When vmbus_onoffer_rescind() wakes up and enters
the channel->primary_channel !=3D NULL branch, wouldn't it see
channel->state =3D=3D CHANNEL_OPEN_STATE and call
hv_process_channel_removal(channel) a second time after err_deq_chan has
already unlinked, unmapped, and freed it?

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index fc0f16f512669..b41ce24e200c8 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c

[ ... ]

> @@ -979,9 +994,15 @@ static void vmbus_device_release(struct device *devi=
ce)
> =20
>  	hv_debug_rm_dev_dir(hv_dev);
> =20
> -	mutex_lock(&vmbus_connection.channel_mutex);
> -	hv_process_channel_removal(channel);
> -	mutex_unlock(&vmbus_connection.channel_mutex);
> +	/*
> +	 * No channel if vmbus_device_register() failed: the channel was not
> +	 * rescinded, and vmbus_add_channel_work() cleans it up.
> +	 */
> +	if (channel) {
> +		mutex_lock(&vmbus_connection.channel_mutex);
> +		hv_process_channel_removal(channel);
> +		mutex_unlock(&vmbus_connection.channel_mutex);
> +	}
>  	kfree(hv_dev);
>  }

[Severity: High]
As reported by Sashiko on v2 [1], when vmbus_device_release() skips
hv_process_channel_removal() and leaves cleanup to err_deq_chan in
vmbus_add_channel_work(), does err_deq_chan leak the allocated CPU bit in
hv_numa_map and the nr_chan_close_on_suspend counter?

Before queuing vmbus_add_channel_work(), vmbus_process_offer() allocates
target_cpu and increments nr_chan_close_on_suspend:

drivers/hv/channel_mgmt.c:vmbus_process_offer() {
	...
	init_vp_index(newchannel);

	/* Remember the channels that should be cleaned up upon suspend. */
	if (is_hvsock_channel(newchannel) || is_sub_channel(newchannel))
		atomic_inc(&vmbus_connection.nr_chan_close_on_suspend);
	...
}

Unlike hv_process_channel_removal(), err_deq_chan in
vmbus_add_channel_work() does not call
hv_clear_allocated_cpu(newchannel->target_cpu) when
hv_is_perf_channel(newchannel) is true.

It also unmaps the channel's relid via vmbus_channel_unmap_relid(newchannel)
without decrementing vmbus_connection.nr_chan_close_on_suspend (via
check_ready_for_suspend_event()) when is_hvsock_channel(newchannel) or
is_sub_channel(newchannel) is true. Because the relid is unmapped, even a
later rescind from the host will see relid2channel() =3D=3D NULL in
vmbus_onoffer_rescind() and return early. Wouldn't that leave
nr_chan_close_on_suspend permanently elevated and cause a subsequent
vmbus_bus_suspend() to hang indefinitely in
wait_for_completion(&vmbus_connection.ready_for_suspend_event)?

[1] https://lore.kernel.org/r/20261103080347.90310-3-izaiahsun@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103144006.6985=
7-1-izaiahsun@gmail.com?part=3D2
