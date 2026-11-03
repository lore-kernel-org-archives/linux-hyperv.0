Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793695038;
	b=d0IY5dXfdeMZcs23KXs0Dd+RZkQLcTTND3Ub3wy+hAiJGFZQVzPEaiXO/S74/XQ72AEu
	 fxJPg4UJfE51WFZW0RVcRGV07wnMcPU87zJg+X3IIATPDZhO54kwdWR6+1Mf6EfHzI+jH
	 C+hA7TBksPqdcf0UHCZpM6mU662xO1ssyTHEpiaycjLP2sdMmCskMxNlpCn98EEuQ6aQi
	 yB99fI/e0DCANDuZf3LSHrnsOeZOaQb192h0JwS1j6ebBuGbOaIRkBo3ftW4j7NI/u7u+
	 NDfK2g9tE8VYaALlFRMlSuhKXCLxRg+ZdDOi1LJhultNUlsE0Ylk8UBQvESBEswZ6Fg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793695038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=n9WTYU338IezZqzy03h15q5mRFjYcqzBe1vRNkisTDU=;
	b=3nA9UPWn4kvOAuwIJ22l1+5e+9h2AN7JkxJi62tx55LMwgRWkrAJVjsM8qgcIt1KvIA9
	 1Lv1RlCAIRZeDE/Vhpxw0fsQwB0ymKp0/ixI8a81izBYb5G/Ux1zDXf0XC10jnguEmWf1
	 lpaOSKWYh7lA2bZ6sielOF/+iEZlzWGPpDnnPLMqepN2ry8hTqdbfPKcvazy6vAtcYOsl
	 MXYJHsgQloPsGMRe9UAtwoBRBQlGCbbFFuHHnPkH+fXN0dqZyTMxwGC03YloT9C/GUe6i
	 GB3riQnhH0KOXx3M57tCMm6my8hYPbbx/NJtqsSBHnYcg0L2GvLfeAP4VlED2Ikivtg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lz81gsyf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7E5606A336
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 08:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lz81gsyf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBBB1F000C1;
	Tue,  3 Nov 2026 08:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793695038;
	bh=n9WTYU338IezZqzy03h15q5mRFjYcqzBe1vRNkisTDU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lz81gsyf8F7F1wQrl1mqAPWRYZwU8jWnPU7WkVns7NCa38NqU0SpuU1f0PSexHhVW
	 qJqgZGZxWX05/zDALXstpO8fmSMDVr/heWQrG+Q909WJxI9pD69zAYHx/epM4WVQjW
	 L+dhLzxrQQ6c6aZB2v8fCuCwjtG1js66NHJAXWSQL4d+QMFb1qhhF4g1Jtlcc/byl2
	 nS4b+Xu9tKVvhfXipEtsgaBXmDtxbwvLev4XZ3lBKhE2gvJrMc62P9cFwgCsmr/Pd4
	 6x/0keSFnofOsn7h1qQfN070Tp3HQ0hrkMMvzNTz96UUU9NM8Eux3re7r8EA2zNtpn
	 /3tJSafEFl32w==
Message-ID: <sashiko-outbox-194840@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] Drivers: hv: vmbus: Do not remove the channel
 when device registration fails
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yuqiang Sun" <izaiahsun@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261103080347.90310-3-izaiahsun@gmail.com>
References: <20261103080347.90310-1-izaiahsun@gmail.com>
 <20261103080347.90310-3-izaiahsun@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 08:37:17 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] hv: vmbus: dangling channel->device_obj on vmbus_device_regist=
er() failure
- [High] hv: vmbus: sub-channel refusal in vmbus_add_channel_kobj() causes =
deadlock
- [High] hv: vmbus: unlocked channel dereference in vmbus_match() without R=
CU
- [Medium] hv: vmbus: leaked sysfs state when primary vmbus_add_channel_kob=
j() fails
--

commit 1c2eec91c8b747f69eceb0c4ce1f5ab28e5429b8
Author: Yuqiang Sun <izaiahsun@gmail.com>

Drivers: hv: vmbus: Do not remove the channel when device registration fails

This commit avoids calling hv_process_channel_removal() in
vmbus_device_release() when device_register() fails by clearing the
device's channel pointer beforehand, and keeps the device registered if
creating the channels kset or primary channel kobject fails.

> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index fc0f16f512669..1b9bc82bebd06 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -840,9 +840,14 @@ static int vmbus_match(struct device *device, const =
struct device_driver *driver
>  {
>  	const struct hv_driver *drv =3D drv_to_hv_drv(driver);
>  	struct hv_device *hv_dev =3D device_to_hv_device(device);
> +	struct vmbus_channel *channel =3D READ_ONCE(hv_dev->channel);
> +
> +	/* None if vmbus_device_register() failed */
> +	if (!channel)
> +		return 0;
> =20
>  	/* The hv_sock driver handles all hv_sock offers. */
> -	if (is_hvsock_channel(hv_dev->channel))
> +	if (is_hvsock_channel(channel))
>  		return drv->hvsock;

[Severity: High]
As reported by Sashiko on v1 [1], can channel be freed before
is_hvsock_channel(channel) dereferences it here?

During device_register() -> device_add(), bus_add_device() links the
device onto the bus klist_devices before later steps in device_add()
(such as dpm_sysfs_add()) can fail. On failure, bus_remove_device() calls
klist_del(), which does not wait for a concurrent __driver_attach() (for
example via vmbus_add_dynid()) that already took a device reference in
bus_for_each_dev() and runs driver_match_device() -> vmbus_match() before
acquiring device_lock(dev).

If vmbus_match() loads hv_dev->channel with READ_ONCE() just before
vmbus_device_register() clears child_device_obj->channel to NULL, the
registering thread returns to vmbus_add_channel_work(), which runs
err_deq_chan and calls free_channel() -> kobject_put() ->
vmbus_chan_release() -> kfree_rcu(channel, rcu).

Because vmbus_match() runs in preemptible process context without
rcu_read_lock(), if the matching thread is preempted after loading
channel, could the RCU grace period complete and free channel before
is_hvsock_channel(channel) reads channel->offermsg.offer.chn_flags?

[ ... ]

> @@ -2103,6 +2114,10 @@ int vmbus_add_channel_kobj(struct hv_device *dev, =
struct vmbus_channel *channel)
>  	u32 relid =3D channel->offermsg.child_relid;
>  	int ret;
> =20
> +	/* The device has no channels directory if creating it failed */
> +	if (!dev->channels_kset)
> +		return -ENOENT;
> +
>  	/*
>  	 * On failure the kobject keeps its reference: the callers' error
>  	 * paths drop it in free_channel(), which also frees the channel.

[Severity: High]
Does returning -ENOENT when !dev->channels_kset cause sub-channel setup
to deadlock or hang system suspend?

In vmbus_device_register(), device_register() runs before
kset_create_and_add("channels", ...) assigns child_device_obj->channels_kse=
t,
and if kset_create_and_add() fails, the device now stays registered and
bound to its driver with channels_kset =3D=3D NULL.

During device_register() -> device_add() -> bus_probe_device(), drivers
such as hv_storvsc and hv_netvsc request sub-channels from Hyper-V before
device_register() returns. Because vmbus_process_offer() queues
sub-channel work onto handle_sub_chan_wq concurrently with
handle_primary_chan_wq, vmbus_add_channel_work() for an offered
sub-channel can call vmbus_add_channel_kobj() either before
kset_create_and_add() sets dev->channels_kset or after
kset_create_and_add() fails:

drivers/hv/channel_mgmt.c:vmbus_add_channel_work() {
    ...
		if (vmbus_add_channel_kobj(dev, newchannel))
			goto err_deq_chan;

		if (primary_channel->sc_creation_callback !=3D NULL)
			primary_channel->sc_creation_callback(newchannel);
    ...
}

When vmbus_add_channel_kobj() fails and jumps to err_deq_chan,
sc_creation_callback is skipped. In hv_netvsc, netvsc_subchan_work() ->
rndis_set_subchannel() holds rtnl_lock() and waits uninterruptibly for
netvsc_sc_open() to increment nvdev->open_chn for each requested
sub-channel:

drivers/net/hyperv/rndis_filter.c:rndis_set_subchannel() {
    ...
	/* wait for all sub channels to open */
	wait_event(nvdev->subchan_open,
		   atomic_read(&nvdev->open_chn) =3D=3D nvdev->num_chn);
}

In addition, vmbus_process_offer() increments
vmbus_connection.nr_chan_close_on_suspend for every sub-channel and
allocates a target CPU in init_vp_index(), but err_deq_chan in
vmbus_add_channel_work() frees newchannel without decrementing
nr_chan_close_on_suspend or calling hv_clear_allocated_cpu(). Wouldn't
this leave rndis_set_subchannel() deadlocked holding rtnl_lock(), and
cause vmbus_bus_suspend() to hang forever in
wait_for_completion(&vmbus_connection.ready_for_suspend_event)?

> @@ -2189,6 +2204,7 @@ int vmbus_device_register(struct hv_device *child_d=
evice_obj)
>  	ret =3D device_register(&child_device_obj->device);
>  	if (ret) {
>  		pr_err("Unable to register child device\n");
> +		WRITE_ONCE(child_device_obj->channel, NULL);
>  		put_device(&child_device_obj->device);
>  		return ret;
>  	}

[Severity: Critical]
When device_register() fails here and put_device() frees
child_device_obj via vmbus_device_release(), does newchannel->device_obj
remain a dangling pointer to the freed struct hv_device?

In vmbus_add_channel_work(), newchannel->device_obj is assigned before
calling vmbus_device_register(newchannel->device_obj), and on failure it
jumps to err_deq_chan without clearing newchannel->device_obj:

drivers/hv/channel_mgmt.c:vmbus_add_channel_work() {
    ...
	ret =3D vmbus_device_register(newchannel->device_obj);

	if (ret !=3D 0) {
		pr_err("unable to add child device object (relid %d)\n",
			newchannel->offermsg.child_relid);
		goto err_deq_chan;
	}
    ...
err_deq_chan:
	mutex_lock(&vmbus_connection.channel_mutex);
    ...
	WRITE_ONCE(newchannel->probe_done, true);
}

If the host rescinds the channel before err_deq_chan unmaps the relid,
vmbus_onoffer_rescind() looks up the channel via relid2channel(), waits
for channel->probe_done to become true, and then checks
channel->device_obj:

drivers/hv/channel_mgmt.c:vmbus_onoffer_rescind() {
    ...
	if (channel->device_obj) {
		if (channel->chn_rescind_callback) {
			channel->chn_rescind_callback(channel);
            ...
			return;
		}
		dev =3D get_device(&channel->device_obj->device);
		if (dev) {
			vmbus_device_unregister(channel->device_obj);
			put_device(dev);
		}
	}
}

Once err_deq_chan sets probe_done =3D true and frees newchannel, wouldn't
vmbus_onoffer_rescind() dereference the already-freed
channel->device_obj (and access channel while err_deq_chan is freeing
it)?

> @@ -2205,31 +2221,17 @@ int vmbus_device_register(struct hv_device *child=
_device_obj)
>  	 * here. The race can't result in a kernel failure, but the user space
>  	 * program may get an error in accessing "channels" or its
>  	 * subdirectories. See also comments with vmbus_add_dynid() about a
> -	 * related race condition.
> +	 * related race condition. For the same reason, the device stays
> +	 * registered if its channel cannot be shown in sysfs.
>  	 */
>  	child_device_obj->channels_kset =3D kset_create_and_add("channels",
>  							      NULL, kobj);
> -	if (!child_device_obj->channels_kset) {
> -		ret =3D -ENOMEM;
> -		goto err_dev_unregister;
> -	}
> -
> -	ret =3D vmbus_add_channel_kobj(child_device_obj,
> -				     child_device_obj->channel);
> -	if (ret) {
> +	if (!child_device_obj->channels_kset ||
> +	    vmbus_add_channel_kobj(child_device_obj, child_device_obj->channel))
>  		pr_err("Unable to register primary channel\n");

[Severity: Medium]
What happens to child_device_obj->channel->kobj and
child_device_obj->channels_kset if kset_create_and_add() succeeds,
kobject_add() inside vmbus_add_channel_kobj() succeeds, and then
sysfs_create_group() fails?

In vmbus_add_channel_kobj(), if sysfs_create_group() fails, kobj is not
removed from sysfs because the function relies on the caller's error
path to clean up the channel:

drivers/hv/vmbus_drv.c:vmbus_add_channel_kobj() {
    ...
	kobj->kset =3D dev->channels_kset;
	ret =3D kobject_add(kobj, NULL, "%u", relid);
	if (ret)
		return ret;

	ret =3D sysfs_create_group(kobj, &vmbus_chan_group);

	if (ret) {
		/*
		 * The calling functions' error handling paths will cleanup the
		 * empty channel directory.
		 */
		dev_err(device, "Unable to set up channel sysfs files\n");
		return ret;
	}
    ...
}

Because vmbus_device_register() no longer unwinds on
vmbus_add_channel_kobj() failure, doesn't this leave an empty
/sys/bus/vmbus/devices/<dev>/channels/<relid> directory in sysfs with
kobj->state_in_sysfs =3D=3D 1 (causing vmbus_remove_channel_attr_group() to
later call sysfs_remove_group() on a group that failed creation), while
also leaving child_device_obj->channels_kset non-NULL so sub-channels
are not refused as described in the commit message?

[1] https://lore.kernel.org/r/20261102094719.35760-3-izaiahsun@gmail.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103080347.9031=
0-1-izaiahsun@gmail.com?part=3D2
