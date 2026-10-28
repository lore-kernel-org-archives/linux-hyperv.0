Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204603;
	b=vDeB+P691oAzPxtpZMeBogQRQUOvBsR6mr0s86icB/qq/9vw/dOrfVQMUdv6AcRJP3zL
	 qC4cmPjZRmVdJkMevWMbNKAowwJ3maR2k/vDL0RSIQ8NdtMj2sphK76bLWzgrV9ttVeBO
	 1J5fKoZKCl0jbP1gbA7MIN3xRocr/TDmLSKfUUU0ZMOeF29HDeAaAtGI3SHzeR0e6LQ6M
	 2xWisE1dzoLrfbZQduvXe8sRRAtDSKOc2clyWowVlLkY3BOzI87NCvErGuXtkme2uwHrT
	 XvCx9IV7imZxv1F6ptyK/CYc/dfiQiBGiB8rn0jaDl2MV5VTbFTC+Yb8g9ZOEcQGCEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204603;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BLQUsnwHtniwhgkkbsnGlPT6RDNadmyHf+RyveJ60AI=;
	b=K/wj3tnR+YiTnPkYs7FKlxqcWG486lfhRhuiXHQrMl5+ZIoHf5bcAP9Ss1XciLsgFfi8
	 +nMS3QK1lY4WN89fY1FzBA6Chzegile8napNtZW7B9vhREhdZj2Bdm/oYr6MQTSoKsm1u
	 wFrtntabmQnZ6cGz37UR+OZBbyArRGC/6J5lb4aM7drwDIkSf7rIlhZRq0mDFSrTyL5+9
	 E5f+/m8SUTy6kSGtz7bzLg5rrCX8GA+ey9T7SqW+rjnicTaQFF9KSCJ9p11mTs4zNLXfX
	 Ix2/7jNHQrVYZmRLk+GQ71Vq4QAIdua4xqwWiT6DDm/lxQy4VP9jtZauw7p8FPD7taw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeoKmsgG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB158606A31A;
	Wed, 28 Oct 2026 16:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DeoKmsgG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F238B1F01825;
	Wed, 28 Oct 2026 16:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204602;
	bh=BLQUsnwHtniwhgkkbsnGlPT6RDNadmyHf+RyveJ60AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DeoKmsgG9cwEUqsHpxEW3mICIOC0LvEi9+yaXn/YGH9vLb5aAV5cDt17SPgV1YCVb
	 a5cL/Istkmxl0SORcz/GrsBK6JUZtDWbPyg6QyFrhvGWN9qNfyXPKgPSJu29z/B6wq
	 MAxEG39pGRXWoTKj2Z63AurElOD5PwSe8n8A8CsgfasG5yxJqYgAZr8vBaxnzWeWSP
	 bnh+AHJxlzLQc34kT5sgpMqVpcLcaU3Y42qnly8TP96RA4W8U5W+aQpE0+cXFdujSY
	 UoonfxRuf9u/WOK7nzcSvNQUbCus/h/kfUSXUc2k/sHBGGBLp3FyoqbI2VY45YkMyP
	 zPBZecwBgdrIw==
Message-ID: <sashiko-outbox-188160@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 7/8] vsock: preserve host-to-guest datagram
 boundaries
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-7-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:23:21 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] vsock/virtio: uncondensed 64 KiB rx skbs exhaust sk_rcvbuf on sm=
all packets
--

commit 7675c425557daffdbb774353bcdf90cea6ee4417
Author: Sergio Lopez <slp@redhat.com>

vsock: preserve host-to-guest datagram boundaries

This patch preserves host-to-guest datagram boundaries by dropping
oversized datagrams in vhost and allocating full-size paged RX buffers
in virtio_transport when datagrams are negotiated.

> diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_tran=
sport.c
> index 14ce0836bc395..d256274088b38 100644
> --- a/net/vmw_vsock/virtio_transport.c
> +++ b/net/vmw_vsock/virtio_transport.c

[ ... ]

> @@ -312,22 +313,31 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
>  static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
>  {
>  	int total_len =3D VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
> -	struct scatterlist pkt, *p;
>  	struct virtqueue *vq;
>  	struct sk_buff *skb;
>  	int ret;
> =20
>  	vq =3D vsock->vqs[VSOCK_VQ_RX];
> +	/* A datagram must fit in one RX buffer, including its header. */
> +	if (vsock->dgram_allow)
> +		total_len =3D VIRTIO_VSOCK_SKB_HEADROOM +
> +			    VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
> =20
>  	do {
> -		skb =3D virtio_vsock_alloc_linear_skb(total_len, GFP_KERNEL);
> +		skb =3D virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
>  		if (!skb)
>  			break;
> =20
>  		memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
> -		sg_init_one(&pkt, virtio_vsock_hdr(skb), total_len);
> -		p =3D &pkt;
> -		ret =3D virtqueue_add_sgs(vq, &p, 0, 1, skb, GFP_KERNEL);
> +		/* Post the header and the entire payload as one RX buffer. */
> +		virtio_vsock_skb_put(skb, total_len - VIRTIO_VSOCK_SKB_HEADROOM);
> +		skb_push(skb, VIRTIO_VSOCK_SKB_HEADROOM);
> +		sg_init_table(vsock->in_bufs, ARRAY_SIZE(vsock->in_bufs));
> +		ret =3D skb_to_sgvec(skb, vsock->in_bufs, 0, total_len);
> +		skb_pull(skb, VIRTIO_VSOCK_SKB_HEADROOM);
> +		if (ret >=3D 0)
> +			ret =3D virtqueue_add_inbuf(vq, vsock->in_bufs, ret, skb,
> +						  GFP_KERNEL);
>  		if (ret < 0) {
>  			kfree_skb(skb);
>  			break;
> @@ -698,7 +708,7 @@ static void virtio_transport_rx_work(struct work_stru=
ct *work)
> =20
>  			/* Drop short/long packets */
>  			if (unlikely(len < sizeof(*hdr) ||
> -				     len > virtio_vsock_skb_len(skb))) {
> +				     len > sizeof(*hdr) + skb->len)) {
>  				kfree_skb(skb);
>  				continue;
>  			}
> @@ -710,8 +720,7 @@ static void virtio_transport_rx_work(struct work_stru=
ct *work)
>  				continue;
>  			}
> =20
> -			if (payload_len)
> -				virtio_vsock_skb_put(skb, payload_len);
> +			pskb_trim_unique(skb, payload_len);

[Severity: Medium]
Can allocating 64 KiB nonlinear RX buffers here leave skb->truesize at ~66 =
KiB
after pskb_trim_unique() and prematurely exhaust sk->sk_rcvbuf on small
packets?

When vsock->dgram_allow is true, virtio_vsock_rx_fill() calls
virtio_vsock_alloc_skb() with total_len =3D VIRTIO_VSOCK_SKB_HEADROOM +
VIRTIO_VSOCK_MAX_PKT_BUF_SIZE (44 + 65536 bytes):

include/linux/virtio_vsock.h:virtio_vsock_alloc_skb() {
	if (size <=3D SKB_WITH_OVERHEAD(PAGE_SIZE << PAGE_ALLOC_COSTLY_ORDER))
		return virtio_vsock_alloc_linear_skb(size, mask);

	size -=3D VIRTIO_VSOCK_SKB_HEADROOM;
	return __virtio_vsock_alloc_skb_with_frags(VIRTIO_VSOCK_SKB_HEADROOM,
						   size, mask);
}

On 4 KiB and 16 KiB page systems, this calls alloc_skb_with_frags() with a
44-byte linear header request and 65536 bytes in page fragments. Because
skb->head comes from skb_small_head_cache, reserving 44 bytes leaves only
about 276 bytes of linear tailroom (skb->end - skb->tail), while all 64 KiB=
 of
payload capacity is placed in page fragments with skb->truesize set to ~66 =
KiB.

When virtio_transport_rx_work() receives a packet and calls
pskb_trim_unique(skb, payload_len) -> pskb_trim() -> ___pskb_trim(), traili=
ng
unused fragments are unreferenced without reducing skb->truesize, and
skb_condense() is called:

net/core/skbuff.c:skb_condense() {
	if (skb->data_len) {
		if (skb->data_len > skb->end - skb->tail ||
		    skb_cloned(skb) || !skb_frags_readable(skb))
			return;

		/* Nice, we can free page frag(s) right now */
		__pskb_pull_tail(skb, skb->data_len);
	}
	skb->truesize =3D SKB_TRUESIZE(skb_end_offset(skb));
}

Whenever payload_len exceeds skb->end - skb->tail (~276 bytes), skb_condens=
e()
returns early without pulling data into skb->head, freeing the first 32 KiB
page fragment, or updating skb->truesize.

In virtio_transport_recv_pkt(), sock_queue_rcv_skb(sk, skb) then charges the
full ~66 KiB skb->truesize against sk->sk_rcvbuf (212992 bytes by default),=
 so
queuing just 4 datagrams of ~300 bytes will fill sk_rcvbuf and drop subsequ=
ent
datagrams, while also pinning 32 KiB page fragments per packet across
SOCK_DGRAM, SOCK_STREAM, and SOCK_SEQPACKET receive queues sharing the RX
virtqueue.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D7
