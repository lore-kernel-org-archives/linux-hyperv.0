Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B52236A34F
	for <linux-hyperv@vger.kernel.org>; Thu,  8 Oct 2026 19:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791486579; cv=none; b=SS82h0oHmhzatkgRfCdJCQORUahzsOu1KI53HhNsbd0JQG7rbZZ2791WMKRVALLJUa+oVpVP4UlZA1BNvfhiCuYytS+PiLLtVFhJDHqhjBzYHbfo7oY24E+ia4jE6AXLA/L/XI5sp3wEOSdbTUot4Q/QFHTR+s7T860uvqSJCsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791486579; c=relaxed/simple;
	bh=WYkdUN+AIlCj6gdNGKdc5juDgyb95GJPfZ8HVfUCeaQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=l+5nX3Za8FEcgRq0rNobuvuy+YfG8M/Zd8VP3AIJxoGoWD1+B/dfNU9UCdvMOsUJ+yDV/9dQXRF/2DSA4NLoJRZJ2XpCaL3le29u8PjIZstQWNkpFYuU1ddOKGu42SpAZPOIbpz5VEzDImqEFmTDbUEpSq7vJ7/GE9Y+bSGNxGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KB0rObPR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KB0rObPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C77391F000FF;
	Thu,  8 Oct 2026 19:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791486577;
	bh=2L3hg+R1qjuJgTPlUBb6LAh1p8dFAxAVlD8eCBKn63o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KB0rObPRAicXNEH4JcvKzXqtEY2XKSyTkh4SJCeQDvDtwGqliMCkusvwY0KSMdoIj
	 51WRbD8LoTzD6KaMGoIP12B27dJYYrtpRJe+c9RjOQdEFs4ock930osCC847GxbCkZ
	 AmRLttr0DqeT6DT69WQBw9lOHUUyNmnf3cMnl0k2und28/vsfaVCp67h7+P8sEkUEd
	 JU644so7etPoe802aAi5LIMIQOR2t9XXBjjkD/gDxrF4Xy+5qHiSfsxIGQVBI/cmE1
	 YmleRB3kU7434UHSXJIZbWGDrlY1KeXowg9bk8jgpaFPra2ct3kPY+clU39+rO0gvV
	 a8JlALsTjCSZg==
Message-ID: <sashiko-outbox-164501@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/14] hv: vmbus: pin buffer pages across UIO mmap to
 close the reclaim race
Reply-To: sashiko-reviews@lists.linux.dev
To: "Emerson Busson" <emersonbusson@gmail.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20261007190752.336426-11-emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <20261007190752.336426-11-emersonbusson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 19:09:37 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hv: vmbus_buffer_pin_pages UAF race on subchannel ringbuffers
--

commit 69d0c6246e4ab3d36e972718b31a04ff08d2eee9
Author: Emerson Busson <emersonbusson@gmail.com>
Subject: hv: vmbus: pin buffer pages across UIO mmap to close the reclaim r=
ace

This commit pins buffer pages across UIO mmap to prevent a race condition=20
with the reclaim worker. It adds vmbus_buffer_pin_pages() and=20
vmbus_buffer_unpin_pages() to safely take references on the pages. The sysf=
s=20
ring mmap wrapper is adjusted to handle the new pin lifecycle.

> diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
> index 7eb9ea814ef45..2793ca1b7f320 100644
> --- a/drivers/hv/channel.c
> +++ b/drivers/hv/channel.c
[ ... ]
> @@ -1145,6 +1145,98 @@ void vmbus_release_buffer(struct vmbus_buffer *buf=
fer)
>  }
>  EXPORT_SYMBOL_GPL(vmbus_release_buffer);
> =20
> +/**
> + * vmbus_buffer_pin_pages - snapshot a buffer's pages and hold references
[ ... ]
> +int vmbus_buffer_pin_pages(struct vmbus_buffer *buffer,
> +			   struct vmbus_buffer_pin *pin)
> +{
> +	struct vmbus_buffer_retained *owner;
> +	u32 i;
> +
> +	/*
> +	 * The owner and page array are published and cleared under
> +	 * vmbus_buffer_owners_lock (see vmbus_release_buffer()). Reading
> +	 * either outside that lock lets a concurrent release free the array
> +	 * while this loop still walks it.
> +	 */
> +	mutex_lock(&vmbus_buffer_owners_lock);

[Severity: High]
Does this code still have a use-after-free race for subchannel ringbuffers?

In vmbus_release_buffer(), if buffer->owner is NULL, the buffer is freed=20
and zeroed without acquiring vmbus_buffer_owners_lock. Subchannel=20
ringbuffers do not have an owner, so their release bypasses this lock.

If a concurrent mmap() is called on a subchannel's sysfs ring file during=20
device removal, this function will acquire the lock and start walking=20
buffer->pages while vmbus_release_buffer() concurrently zeroes and frees=20
it without the lock, causing a crash.

> +	owner =3D buffer->owner;
> +	if (!buffer->pages || !buffer->page_cnt) {
> +		mutex_unlock(&vmbus_buffer_owners_lock);
> +		return -ENODEV;
> +	}
[ ... ]
> diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
> index b40e80e19c6c6..91cb25d019be9 100644
> --- a/drivers/uio/uio_hv_generic.c
> +++ b/drivers/uio/uio_hv_generic.c
[ ... ]
> @@ -372,12 +637,20 @@ static void
>  hv_uio_remove(struct hv_device *dev)
>  {
>  	struct hv_uio_private_data *pdata =3D hv_get_drvdata(dev);
> +	int ret;
> =20
>  	if (!pdata)
>  		return;
> =20
>  	hv_remove_ring_sysfs(dev->channel);

[Severity: High]
Does this code leave subchannel sysfs files active and mapped?

hv_remove_ring_sysfs() is only called on the primary channel, which leaves=
=20
any subchannel ring sysfs files active.=20

> +	/* Keep event notification alive until channel callbacks are stopped. */
> +	get_device(&pdata->info.uio_dev->dev);
>  	uio_unregister_device(&pdata->info);
> +	/* unregister prevents the eventual fd close from calling .release. */
> +	ret =3D hv_uio_disconnect_if_open(dev->channel, vmbus_disconnect_ring);

vmbus_disconnect_ring() iterates over the subchannels and frees their=20
ringbuffers directly. Because the subchannel sysfs ring files are still=20
active, userspace can call mmap() concurrently on them. This triggers the=20
lockless vmbus_release_buffer() vs vmbus_buffer_pin_pages() race described=
=20
above.

Could hv_remove_ring_sysfs() be invoked on all subchannels before their=20
ringbuffers are freed?

> +	if (ret)
> +		dev_err(&dev->device, "channel disconnect failed: %d\n", ret);
> +	put_device(&pdata->info.uio_dev->dev);
>  	hv_uio_cleanup(dev, pdata);
> =20
>  	vmbus_free_ring(dev->channel);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261007190752.3364=
26-1-emersonbusson@gmail.com?part=3D10
