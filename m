Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794795022;
	b=0pe6BrfXialJFq0fAqiJpG2LIlmF+rP89nBbmJsQlcSzHj8xmWIMdYwcBfNw4ddL+VMT
	 jD+gU2uVY8xNENm3fU6hf5vSYJ4/PL0ltN/quRjQ3TL8keIvm3upalSOxO3Ruo7OXfz5t
	 d4AnzPxLI9uW19tovwfAOeMJxzFmCKAjV7X6jNGr3nmh0Dx4jWnkBz9Xbsk3XBb1/AVJk
	 gjVxqzH0nHlany3ye7vbePmSRt0A9SiWiKnF+R7tUepfcT5IiviadB86uJhGTVBEaZl0I
	 w8CsaGXwbHNTuu0ptEV3wm1gy4PZx5Bs7CI4tIrPhiBDplR1/tkEAkkgQAktvG079Xw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794795022;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=FOQCOXYeXbucCUc6di4An4mzFdK/dc1J0LsVT48kVUc=;
	b=fPWDfF6u8JfxV3MB8pZjKSmRToPmLxlnKI0htOGZrvaJtCKl0vKDVn+zy30qr6Ycgj4n
	 TzWgWXkpSOOgTku8rCgChJmOn5k0e0cZfb8ra4qEQ8JqAjOsuaZc49mGygExtDdNRqYCq
	 Oo9RJQ0ANxtkYWRISMk3hGJDo3TnrMAY1X9JqC3IGrHZQwNGopE7XApzra1Xom/IxKWN5
	 ubyOV6DFtB7uqUx7kKpkzbuilYLB6YYCraQUjxl35v2yAXUihLOFRT1PyLj6R8wcoIaE7
	 BkB85RfbGiBRXb20i/4Y1gHkpA+W2mRxJxSV57YkyGwfvaVgBnDS7YM018OoIzEhM7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmSytaER;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4600F606A31C;
	Mon, 16 Nov 2026 02:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SmSytaER
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1A01F000C4;
	Mon, 16 Nov 2026 02:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794795021;
	bh=FOQCOXYeXbucCUc6di4An4mzFdK/dc1J0LsVT48kVUc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=SmSytaERJJZKAoScVToOmJHn7wIl/YH9Rzid+Hy7Y1M9+jH/ZJJeqbwqdzKNt1Qyq
	 M68fmOqECtoiZSbb4okoXJadOwtUt1K9Ok4Cfxn8CQvIvrD3Ns7IFwUy5aixGMfiW1
	 KIiX5pivzboSKSLnPe5rQgfRmN4qgxUMYLl+E1fZ5EeDjxyKy1E+mOKZuJTDHnOv7S
	 AmCGWTdqKcrkV3UBcYljHCSbObSYRaBNQvvZgY8nF/oY39j6TJ6JyQpY/PsGXOwapF
	 ZAV4khViwVxnUxlZ2Oy6Ud6RZEL26/myAGxF46TXLuuXn6izkLpXd27n7H7+GuReda
	 LRtyBq5h6aZ6A==
Subject: Re: [PATCH net] hv_netvsc: fall back to one queue when a sub channel
 fails to open
From: netdev-bot+sashiko@kernel.org
To: julius@bairaktaris.de
Cc: netdev@vger.kernel.org, linux-hyperv@vger.kernel.org,
 haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ernis@linux.microsoft.com, stephen@networkplumber.org,
 linux-kernel@vger.kernel.org
Date: Mon, 16 Nov 2026 02:10:20 +0000
Message-ID: <179479502052.3136.1055457822557870206@kernel.org>
In-Reply-To: <20261114220358.5429-1-julius@bairaktaris.de>
References: <20261114220358.5429-1-julius@bairaktaris.de>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 2 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new check calls rndis_subchannel_opened()
  (drivers/net/hyperv/rndis_filter.c:1281-1286), which reads…
- [High] rndis_set_subchannel() lowers nvdev->num_chn to 1 +
  num_subchannels from the host reply (rndis_filter.c:1350-1351).
- [Medium] The commit message says the device keeps one queue after the
  fallback 'until the channel count is raised with ethtool -L'.
- [Medium] The new fallback leaves the RSS indirection table
  (ndc->rx_table) as rndis_filter_device_add() filled it, for the…
- [Medium] On the new fallback path, the sub channels that did open stay
  in CHANNEL_OPENED_STATE with onchannel_callback = netvsc_channel_cb,…

--

hv_netvsc: fall back to one queue when a sub channel fails to open

After waiting for the sub channels, rndis_set_subchannel() now checks
that each one reached CHANNEL_OPENED_STATE. If any did not, it disables
the NAPI of the ones that opened and returns -EIO, so callers fall back
to the primary channel. The fallback in netvsc_attach() now also deletes
the sub channel NAPIs and sets the real tx/rx queue counts to 1.

Link: https://github.com/microsoft/WSL/issues/41622

> The device keeps one queue after the fallback, also across later
> reconfiguration, until the channel count is raised with ethtool -L.

[Severity: Medium]

Can the channel count be raised with ethtool -L right after the
fallback?

Both fallback paths, in netvsc_attach() and netvsc_subchan_work(), set
nvdev->max_chn = 1. netvsc_get_channels() then reports max_combined as
nvdev->max_chn, and netvsc_set_channels() rejects the request:

drivers/net/hyperv/netvsc_drv.c:netvsc_set_channels() {
    ...
	if (count > nvdev->max_chn)
		return -EINVAL;
    ...
}

So "ethtool -L ethX combined 16" would fail with -EINVAL.

max_chn is only recomputed from OID_GEN_RECEIVE_SCALE_CAPABILITIES in
rndis_filter_device_add(). That means an unrelated detach/attach cycle,
such as an MTU change, has to happen first. A plain down/up does not
recompute max_chn. The test below the cut did an MTU change before
ethtool -L, which may have hidden this.

Should the commit message say this, or should the fallback leave
max_chn at the value the host advertised?

> diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
> index 1d43c73fd73f1..ffa5999dc576c 100644
> --- a/drivers/net/hyperv/netvsc_drv.c
> +++ b/drivers/net/hyperv/netvsc_drv.c

[ ... ]

> @@ -1034,8 +1034,13 @@ static int netvsc_attach(struct net_device *ndev,
>  
>  		/* if unavailable, just proceed with one queue */
>  		if (ret) {
> +			for (i = 1; i < nvdev->num_chn; i++)
> +				netif_napi_del(&nvdev->chan_table[i].napi);
> +

[Severity: High]

Can this loop skip some of the NAPIs that rndis_filter_device_add()
added?

rndis_filter_device_add() calls netif_napi_add() for
chan_table[1..N0-1], where N0 is the requested num_chn. Before the new
-EIO return, rndis_set_subchannel() lowers num_chn to the count the
host granted:

	nvdev->num_chn = 1 +
		init_packet->msg.v5_msg.subchn_comp.num_subchannels;

The check before this only rejects a count larger than requested, so
the host can grant k < N0-1 sub channels. If one of those k then fails
vmbus_open(), this loop only deletes NAPIs 1..k. So does the same loop
in netvsc_subchan_work(). num_chn is then forced to 1, and
netvsc_device_remove() also only walks i < num_chn.

That leaves NAPIs k+1..N0-1 on ndev->napi_list after kfree(nvdev) frees
the netvsc_device that holds them. Could a later netif_napi_add(), a
netdev-genl NAPI dump or free_netdev() then walk freed memory?

The success path has had the same mismatch for a long time. However,
the commit message says this patch fixes the fallback not deleting the
sub channel NAPIs. The new -EIO return also turns what used to be a
hang into a free of nvdev with NAPIs still on the list.

Would it help to track the count that was actually passed to
netif_napi_add()?

>  			nvdev->max_chn = 1;
>  			nvdev->num_chn = 1;
> +			netif_set_real_num_tx_queues(ndev, 1);
> +			netif_set_real_num_rx_queues(ndev, 1);
>  		}
>  	}
>  
> diff --git a/drivers/net/hyperv/rndis_filter.c b/drivers/net/hyperv/rndis_filter.c
> index 9622513275069..fe5acce0bb06b 100644
> --- a/drivers/net/hyperv/rndis_filter.c
> +++ b/drivers/net/hyperv/rndis_filter.c
> @@ -1278,6 +1278,31 @@ static void netvsc_sc_open(struct vmbus_channel *new_sc)
>  		wake_up(&nvscdev->subchan_open);
>  }
>  
> +static bool rndis_subchannel_opened(struct netvsc_device *nvdev, int i)
> +{
> +	struct vmbus_channel *chn = nvdev->chan_table[i].channel;
> +
> +	return chn && chn->state == CHANNEL_OPENED_STATE;

[Severity: High]

Can chn already be freed by the time this reads chn->state?

netvsc_sc_open() sets nvchan->channel = new_sc before vmbus_open() and
leaves it set when the open fails. The netvsc driver holds no reference
on the channel. Here rndis_set_subchannel() holds only RTNL, not
vmbus_connection.channel_mutex or rcu_read_lock().

vmbus_open() can fail because the host rescinds the channel during the
open. In that case __vmbus_open() returns -ENODEV, and its error path
ends with:

	newchannel->state = CHANNEL_OPEN_STATE;
	return err;

After netvsc_sc_open() returns, probe_done is set, and
vmbus_onoffer_rescind() can take the sub channel branch:

drivers/hv/channel_mgmt.c:vmbus_onoffer_rescind() {
    ...
		mutex_lock(&vmbus_connection.channel_mutex);
		if (channel->state == CHANNEL_OPEN_STATE) {
			/*
			 * The channel is currently not open;
			 * it is safe for us to cleanup the channel.
			 */
			hv_process_channel_removal(channel);
    ...
}

This ends in:

hv_process_channel_removal()->free_channel()->kobject_put()->
    vmbus_chan_release()->kfree_rcu(channel)

open_chn has already been incremented for this channel. The waiter can
still be blocked on other sub channels, and each of their vmbus_open()
calls needs a host round trip. By the time this check runs, the channel
may already be freed.

The result then depends on what the freed memory holds. The failed
channel could be treated as opened, which brings back the original
hang. Or rndis_disable_subchannels() could call napi_disable() a second
time on a NAPI that netvsc_sc_open() already disabled. That call never
returns, and RTNL is held.

Would it be safer for netvsc_sc_open() to record the result of the open
in driver-owned state before atomic_inc_return()? For example, it could
clear nvchan->channel on failure or set a per-nvchan flag.

> +}
> +
> +/* Disable the NAPI of the sub channels that opened. netvsc_sc_open()
> + * already disabled it on the others.
> + */
> +static void rndis_disable_subchannels(struct net_device *ndev,
> +				      struct netvsc_device *nvdev)
> +{
> +	int i;
> +
> +	for (i = 1; i < nvdev->num_chn; i++) {
> +		if (!rndis_subchannel_opened(nvdev, i))
> +			continue;
> +
> +		netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_TX, NULL);
> +		netif_queue_set_napi(ndev, i, NETDEV_QUEUE_TYPE_RX, NULL);
> +		napi_disable(&nvdev->chan_table[i].napi);

[Severity: Medium]

What happens to the vmbus channels of the sub channels that did open?

They stay in CHANNEL_OPENED_STATE with netvsc_channel_cb() registered
and their ring buffers still allocated. Their NAPI is disabled here and
then deleted by netif_napi_del() in netvsc_attach() or
netvsc_subchan_work().

__netif_napi_del_locked() leaves NAPI_STATE_SCHED set, so
napi_schedule_prep() in netvsc_channel_cb() always fails:

drivers/net/hyperv/netvsc.c:netvsc_channel_cb() {
    ...
	if (napi_schedule_prep(&nvchan->napi)) {
		/* disable interrupts from host */
		hv_begin_read(rbi);

		__napi_schedule_irqoff(&nvchan->napi);
	}
}

The inbound ring is never drained. Any recv buffer sections the host
places on these channels are never completed.

A sub channel also cannot be closed on its own, because
vmbus_disconnect_ring() has:

	if (channel->primary_channel != NULL)
		return -EINVAL;

So these channels and their high-order ring buffers stay armed with no
consumer until the next detach closes the primary channel. That memory
stays allocated under the same memory pressure that caused the
fallback.

If the host sends RX traffic on these channels, could it be dropped
and leak recv buffer sections? Could that starve RX on the primary
channel too?

> +	}
> +}

[ ... ]

> @@ -1329,6 +1354,19 @@ int rndis_set_subchannel(struct net_device *ndev,
>  	wait_event(nvdev->subchan_open,
>  		   atomic_read(&nvdev->open_chn) == nvdev->num_chn);
>  
> +	/* open_chn also counts the sub channels that failed to open. They
> +	 * have no ring buffer and a disabled NAPI, so fall back to the
> +	 * primary channel.
> +	 */
> +	for (i = 1; i < nvdev->num_chn; i++) {
> +		if (!rndis_subchannel_opened(nvdev, i)) {
> +			netdev_warn(ndev, "sub channel %d is not open, using one queue\n",
> +				    i);
> +			rndis_disable_subchannels(ndev, nvdev);
> +			return -EIO;

[Severity: Medium]

Does this early return leave ndc->rx_table pointing at queues that no
longer exist?

rndis_filter_device_add() fills rx_table for the requested channel
count:

	if (!netif_is_rxfh_configured(net)) {
		for (i = 0; i < ndc->rx_table_sz; i++)
			ndc->rx_table[i] = ethtool_rxfh_indir_default(
						i, net_device->num_chn);
	}

This return skips rndis_filter_set_rss_param(). Neither netvsc_attach()
nor netvsc_subchan_work() resets rx_table when it sets num_chn = 1, so
netvsc_get_rxfh() would report queues that do not exist.

A key-only update (ethtool -X ethX hkey ..., so rxfh->indir is NULL)
skips the indir[i] >= num_chn check in netvsc_set_rxfh() and goes
straight to:

	return rndis_filter_set_rss_param(rndis_dev, key);

rndis_set_rss_param_msg() then copies the stale table to the host
unchanged:

	for (i = 0; i < ndc->rx_table_sz; i++)
		itab[i] = ndc->rx_table[i];

Could the host then steer RX flows to the sub channels that this patch
leaves open on vmbus but never polls, so those flows are silently
dropped?

The stale rx_table after a fallback existed before this patch. What is
new is that it can now point at sub channels that are open but not
polled.

The commit message only says the driver falls back to the primary
channel. It does not mention that the opened sub channels stay open, or
how rx_table is handled.

> +		}
> +	}
> +

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261114220358.5429-1-julius%40bairaktaris.de
