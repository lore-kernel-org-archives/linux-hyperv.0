Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794780246;
	b=BsoRy64keqMWGKZcMTDgXaFKBbItnZzNEF3PPfhXie/oJvjnyliYV2pc1tSRffF+GQso
	 JlaqIAc2zGYnCHqYjmKIHRUyMPy7r9LsJ3Vw9mDY2zye8V1OGVYBjyAlGMXtQyv3Ahg8n
	 T81pgboIGvF8Wdr9ImAroSNDKaiYyeC5ph/6zbuQ74noBp06L4zp2WuokphVGOyCfh5LA
	 MMepbUgTnIJweXRmLkhOgUiVJWvIswsruKAX1lfQ5inNCWJSrV6cO2QmrGJNLl4HmQVFk
	 0O5Pr4PkOolx7hnLMQmBNM1eiCKThqSz3KBz0BRlkQ7iYjMsKbDWBrS+zVjbuw5M2jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794780246;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HVYXL3yNpx4zA5BLK9F77/12lmXSg1UxJMTXvrQMJx0=;
	b=F1Ss5cMY8Dt1L6hT4uJcdW9MRCQ/YorwCGDTQ9YoxJRvPOx4EUVPBFko9mKE+hPsHEbb
	 kpLz1kV0PGDb+jtNSwGwlbTCVRoD13Dm6oF21MwLOHsh6ae/Z8kvjB0Y/QjkjYRAQ1gjG
	 RkfB8X6DmpzheuNFvtj1JlpWcT4z818x8FMuChDOr8KNxhhMn0BqoB8QBJ1KeeOU8JAXL
	 QfJ949E/b6yGq+gAeUcETuBxH7Rbk2vxLCUVyz1db4USVgWJHddR+b46YcjOekE55prWT
	 e+JXpkAaY1k0ACAromq/OLJTy5DkAFaWGwg31a9GX27f0Iz942I7dykf/mtVnSufnsQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXy78VaP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C5E2606A33A
	for <linux-hyperv@vger.kernel.org>; Sun, 15 Nov 2026 22:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EXy78VaP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E8511F000C7;
	Sun, 15 Nov 2026 22:04:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794780246;
	bh=HVYXL3yNpx4zA5BLK9F77/12lmXSg1UxJMTXvrQMJx0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=EXy78VaPls6ZJf3UdW8WLFEtUWoIlNrJE9x2z5AGwm+Tbj5s95jPv1a2eveakFiGJ
	 cyD8+9D4XhusYfCyejEVSlXbRoKyQUl14Tj7t/HPuzzRfHuGpkRpbCNJoAFnHBf5Wu
	 wz48WB2GEq4uoRqSqzFTId7ipuU8DOnqQ1KdyC4UkH19B6Sst86XUcskxivDCbS99i
	 KMCSn+8MkHYyfQaFWqw/FbNbtUbScl/7tCWkux4vpPG8M7UPiXFTyuP5EFN2zSuwbG
	 x09VhjvlSZFk1na0HkqrwWQKBJJXfYLYOpoxuEl3lYhH6fhBFB39DS47BOPqAeg7xU
	 xYmr5iPKr15Lg==
Message-ID: <sashiko-outbox-215875@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] hv_netvsc: fall back to one queue when a sub
 channel fails to open
Reply-To: sashiko-reviews@lists.linux.dev
To: "Julius Bairaktaris" <julius@bairaktaris.de>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261114220358.5429-1-julius@bairaktaris.de>
References: <20261114220358.5429-1-julius@bairaktaris.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 15 Nov 2026 22:04:05 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] hv_netvsc: UAF and primary-channel false match in
  rndis_subchannel_opened()
- [Medium] hv_netvsc: clamping max_chn to 1 on fallback blocks ethtool
  -L recovery
- [Medium] hv_netvsc: stale multi-queue rx_table after
  rndis_set_subchannel() fallback
It also noticed 1 related pre-existing issue this patch does not
introduce:
- [High] Drivers: hv: vmbus: skipped sub-channel callback in
  vmbus_add_channel_work() [1]
--

commit 616fd3140681fc7618c2c8a9fe6e8fd4a476a8d1
Author: Julius Bairaktaris <julius@bairaktaris.de>

hv_netvsc: fall back to one queue when a sub channel fails to open

This commit checks whether all VMBus sub-channels opened during
rndis_set_subchannel() and falls back to a single queue, disabling and
deleting sub-channel NAPIs, if any sub-channel failed to open.

Link: https://github.com/microsoft/WSL/issues/41622

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_=
drv.c
> index 1d43c73fd73f1..ffa5999dc576c 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c
> @@ -1023,7 +1023,7 @@ static int netvsc_attach(struct net_device *ndev,
>  	struct netvsc_device *nvdev;
>  	struct rndis_device *rdev;
>  	struct bpf_prog *prog;
> -	int ret =3D 0;
> +	int i, ret =3D 0;
> =20
>  	nvdev =3D rndis_filter_device_add(hdev, dev_info);
>  	if (IS_ERR(nvdev))
> @@ -1034,8 +1034,13 @@ static int netvsc_attach(struct net_device *ndev,
> =20
>  		/* if unavailable, just proceed with one queue */
>  		if (ret) {
> +			for (i =3D 1; i < nvdev->num_chn; i++)
> +				netif_napi_del(&nvdev->chan_table[i].napi);
> +
>  			nvdev->max_chn =3D 1;
>  			nvdev->num_chn =3D 1;
> +			netif_set_real_num_tx_queues(ndev, 1);
> +			netif_set_real_num_rx_queues(ndev, 1);
>  		}
>  	}

[Severity: Medium]
Does keeping nvdev->max_chn =3D 1 here and in netvsc_subchan_work() prevent
raising the channel count back above 1 with ethtool -L after a fallback,
contrary to the commit message?

netvsc_get_channels() reports nvdev->max_chn as channel->max_combined, and
both ethnl_set_channels() and netvsc_set_channels() reject any requested
channel count greater than max_chn with -EINVAL unless another full
reattach (such as an MTU change) happens first to recompute max_chn in
rndis_filter_device_add().

> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis=
_filter.c
> index 9622513275069..fe5acce0bb06b 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1278,6 +1278,31 @@ static void netvsc_sc_open(struct vmbus_channel *n=
ew_sc)
>  		wake_up(&nvscdev->subchan_open);
>  }
> =20
> +static bool rndis_subchannel_opened(struct netvsc_device *nvdev, int i)
> +{
> +	struct vmbus_channel *chn =3D nvdev->chan_table[i].channel;
> +
> +	return chn && chn->state =3D=3D CHANNEL_OPENED_STATE;
> +}

[Severity: High]
Can rndis_subchannel_opened() dereference a freed vmbus_channel or falsely
match the primary channel?

netvsc_sc_open() assigns nvchan->channel =3D new_sc before calling
vmbus_open(), and leaves it set if vmbus_open() fails (leaving new_sc in
CHANNEL_OPEN_STATE).  If that sub-channel is rescinded,
vmbus_onoffer_rescind() sees CHANNEL_OPEN_STATE and immediately frees the
channel once probe_done is set:

CPU0                                  CPU1
rndis_set_subchannel()                vmbus_add_channel_work()
  wait_event(nvdev->subchan_open, ...)  netvsc_sc_open()
                                          nvchan->channel =3D new_sc
                                          vmbus_open(new_sc) -> fails
                                          atomic_inc_return(&open_chn)
                                        newchannel->probe_done =3D true
                                      vmbus_onoffer_rescind()
                                        hv_process_channel_removal()
                                          ...
                                            kfree_rcu(channel, rcu)
  rndis_subchannel_opened()
    chn->state                        <-- use-after-free

In addition, netvsc_device_add() initializes every
nvdev->chan_table[i].channel slot to the primary channel (device->channel),
which is in CHANNEL_OPENED_STATE.  If any slot was not overwritten by
netvsc_sc_open(), rndis_subchannel_opened() returns true for the primary
channel and rndis_disable_subchannels() hangs in napi_disable() on a
sub-channel NAPI that was never enabled.

Clearing nvchan->channel =3D NULL when vmbus_open() fails in
netvsc_sc_open() and checking is_sub_channel(chn) would avoid both issues.

> +
> +/* Disable the NAPI of the sub channels that opened. netvsc_sc_open()
> + * already disabled it on the others.
> + */
> +static void rndis_disable_subchannels(struct net_device *ndev,
> +				      struct netvsc_device *nvdev)
> +{
> +	int i;
> +
> +	for (i =3D 1; i < nvdev->num_chn; i++) {
> +		if (!rndis_subchannel_opened(nvdev, i))
> +			continue;
> +
> +		netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> +		netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> +		napi_disable(&nvdev->chan_table[i].napi);
> +	}
> +}

[Severity: Medium]
When falling back to one queue here, does ndc->rx_table retain the
multi-queue indices populated earlier by rndis_filter_device_add()?

Because ndc->rx_table is not reset to queue 0 and the opened sub-channels
remain in CHANNEL_OPENED_STATE, ethtool -x reports nonexistent queue
indices, and updating the RSS hash key via ethtool -X (netvsc_set_rxfh()
with rxfh->indir =3D=3D NULL) sends that multi-queue indirection table to t=
he
host via rndis_filter_set_rss_param(), steering RX traffic onto
sub-channels whose NAPIs have been disabled and deleted.

> @@ -1329,6 +1354,19 @@ int rndis_set_subchannel(struct net_device *ndev,
>  	wait_event(nvdev->subchan_open,
>  		   atomic_read(&nvdev->open_chn) =3D=3D nvdev->num_chn);

[Severity: High]
This problem wasn't introduced by this patch, but can wait_event() on
nvdev->subchan_open hang forever under rtnl_lock if
vmbus_add_channel_kobj() fails in vmbus_add_channel_work() [1]?

drivers/hv/channel_mgmt.c:vmbus_add_channel_work() {
	if (primary_channel !=3D NULL) {
		/* newchannel is a sub-channel. */
		struct hv_device *dev =3D primary_channel->device_obj;

		if (vmbus_add_channel_kobj(dev, newchannel))
			goto err_deq_chan;

		if (primary_channel->sc_creation_callback !=3D NULL)
			primary_channel->sc_creation_callback(newchannel);
}

When vmbus_add_channel_kobj() fails for a sub-channel offer, jumping to
err_deq_chan skips sc_creation_callback (netvsc_sc_open()), so
nvdev->open_chn is never incremented to nvdev->num_chn and
rndis_set_subchannel() sleeps indefinitely while holding rtnl_lock.

[1] https://sashiko.dev/#/bug/linux-83f4f08e-02b2-4a16-8ce7-6803e9b794d6

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114220358.5429=
-1-julius@bairaktaris.de?part=3D1
