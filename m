Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592038;
	b=UyGh4cYE3zm98nKTM8fmTNqnQP9A3oL0OY20QWvortXoytUPV7+4sx51o+qqxKp8VrS+
	 t2Zq9+7fPpE9rFgIpUMQ+Gkog9f/RxKM/YGIoqCPNGBitIDCERRqrQzMXvUl5UxmukZI9
	 AErop079rDyO8A7k+XzNNPyFjcgYh8ZDzUafxfNPOFkMrOtnKVCuToaziPLc0G+kMdpdC
	 aFU9cB1ytMzvU/RJbZtPZdzWCVkT0eXsP1yJGU/LAf4Pye9FcNquIthdcPzSBrd0fk0nW
	 VjJm8LJZZLg4+3jLIAuTPMFRBF1sxS96I+XTddHoDyLK4/JyoSxEiuZ+xd9l40LulMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592038;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=vkI2kpbBTjq1G+vLnjeYQ9WTuUYVL/E+GPeIv8+PO/Q=;
	b=t701toxag+xPnFNP+VOnyF+ndcm68bCfiLM8989IxBq6OoDg6cWaoYzj+DlaGZOOtRHx
	 LNXDCbZCKv+9xPe0O0DkR4XhB4q/oDa155aTNpgn61mHYUwfJWTKCUw1dhnE+BUleALWh
	 MOqZlUDSlC9GmpxDo6820bXUUekV3QMemmU8zTT2RK/90tuRlaWDF76dvbGRcRoSKr9FR
	 IRk+Yw3/3wb8fZWtDyNriaM2sollhC5j0Na5YO4z04vi2IWAlNHhmbb2ZSRDoGmtuwiKl
	 xrWyQLjM9zzzvRpLhiVHtZmR+nLsz5pnXFGpLdgm5wzs+QJi5ahUzRr8N1Uejqg/RLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKeNKKE8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B51E7606BD34;
	Fri, 13 Nov 2026 17:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iKeNKKE8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF2DA1F00ADF;
	Fri, 13 Nov 2026 17:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592038;
	bh=vkI2kpbBTjq1G+vLnjeYQ9WTuUYVL/E+GPeIv8+PO/Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKeNKKE8yqXNHHQjsuwa5zFMDBuSuRJxhgJApUpc32E8KTU56YQaFyoJLIMIxLmET
	 /uRTqIZ2zb6N5G+nONAB+FmTNhT5e5dnn+HfbuQPjg8D5qUe1DtY3D3bOdzoj4j999
	 oASbNNI3Ip28aDuu1b5N6+XWK2LXV2bC5fj/gKW6VZ+6AN91GaF8N6hOFrqSm23WWs
	 JN2V8SSM/T5ueFVIU1acXUTOrgQQ3nnN/YDDTngWYIv0Ic7qLFYBHGT43OoQyON8rP
	 xXhptVaeVEsOtqjEZZs22ARcqRbVRuEBdmDiDqeCgjIjpJD/dHY1nd0aEAERpmI3V5
	 RYwmAkIT6AkiQ==
Message-ID: <sashiko-outbox-213362@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 3/8] vsock/virtio: implement the datagram data
 path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-3-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-3-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:47:17 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] vsock/virtio: OOB read on filtered nonlinear vhost dgram skb
- [Medium] vsock/virtio: empty datagrams skipped on repeated MSG_PEEK
--

commit 7bb89ea8d31712feb1c6f76854206e10a5fd07b5
Author: Sergio Lopez <slp@redhat.com>

vsock/virtio: implement the datagram data path

This commit adds the VIRTIO_VSOCK_F_DGRAM feature bit and
VIRTIO_VSOCK_TYPE_DGRAM packet type, and implements the common virtio
transport operations to bind, send, and receive datagrams.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 1e762a480df49..08baa1181ba6d 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -999,7 +1018,47 @@ virtio_transport_dgram_dequeue(struct vsock_sock *v=
sk,
>  			       struct msghdr *msg,
>  			       size_t len, int flags)
>  {
> -	return -EOPNOTSUPP;
> +	struct sock *sk =3D sk_vsock(vsk);
> +	struct virtio_vsock_hdr *hdr;
> +	struct sk_buff *skb;
> +	size_t payload_len;
> +	int err;
> +
> +	if (flags & (MSG_OOB | MSG_ERRQUEUE))
> +		return -EOPNOTSUPP;
> +
> +	skb =3D skb_recv_datagram(sk, flags, &err);
> +	if (!skb)
> +		return err;

[Severity: Medium]
Does calling skb_recv_datagram() skip an unread empty datagram when
userspace calls recvmsg() with MSG_PEEK more than once?

Because virtio_vsock_hdr lives in skb headroom, an empty datagram has
skb->len =3D=3D 0.  skb_recv_datagram() passes off =3D 0 to
__skb_recv_datagram(), which sets peek_at_off =3D true in
__skb_try_recv_from_queue():

net/core/datagram.c:__skb_try_recv_from_queue() {
	...
		if (flags & MSG_PEEK) {
			if (peek_at_off && _off >=3D skb->len &&
			    (_off || skb->peeked)) {
				_off -=3D skb->len;
				continue;
			}
			if (!skb->len) {
				skb =3D skb_set_peeked(skb);
				if (unlikely(!skb)) {
					*err =3D -ENOMEM;
					return NULL;
				}
			}
			*peeked =3D 1;
			refcount_inc(&skb->users);
		} else
	...
}

The first MSG_PEEK sets skb->peeked =3D 1 on the 0-length skb, and the next
MSG_PEEK sees _off >=3D skb->len && skb->peeked and skips the unread empty
datagram, returning the following datagram out of order or failing with
-EAGAIN.  Calling __skb_recv_datagram() with sk_peek_offset(sk, flags)
avoids this, as in commit a0917e0bc6ef ("datagram: When peeking datagrams
with offset < 0 don't skip empty skbs").

[ ... ]

> @@ -1805,6 +1875,38 @@ void virtio_transport_recv_pkt(struct virtio_trans=
port *t,
>  		goto free_pkt;
>  	}
> =20
> +	/* Dgram packets are delivered directly to bound sockets without
> +	 * going through the connection state machine. Undeliverable
> +	 * datagrams are silently dropped (no RST).
> +	 */
> +	if (le16_to_cpu(hdr->type) =3D=3D VIRTIO_VSOCK_TYPE_DGRAM) {
> +		if (le16_to_cpu(hdr->op) !=3D VIRTIO_VSOCK_OP_RW)
> +			goto free_pkt;
> +
> +		sk =3D vsock_find_bound_dgram_socket_net(&dst, net);
> +
> +		if (!sk)
> +			goto free_pkt;
> +
> +		vsk =3D vsock_sk(sk);
> +		lock_sock(sk);
> +		if (sock_flag(sk, SOCK_DEAD) ||
> +		    vsk->transport !=3D &t->transport ||
> +		    (sk->sk_socket->state !=3D SS_UNCONNECTED &&
> +		     !vsock_check_source(vsk, &t->transport, &src))) {
> +			release_sock(sk);
> +			sock_put(sk);
> +			goto free_pkt;
> +		}
> +
> +		if (sock_queue_rcv_skb(sk, skb))
> +			kfree_skb(skb);

[Severity: High]
Can sock_queue_rcv_skb() corrupt a nonlinear vhost-vsock skb when a socket
filter trims the packet, leading to an out-of-bounds read in
virtio_transport_dgram_dequeue()?

In vhost_vsock_alloc_skb(), the skb is allocated from the guest TX
descriptor chain length before hdr->len is inspected, and
virtio_vsock_skb_put() then sets skb->len =3D payload_len without adjusting
skb->data_len:

include/linux/virtio_vsock.h:virtio_vsock_skb_put() {
	if (skb_is_nonlinear(skb))
		skb->len =3D len;
	else
		skb_put(skb, len);
}

When a guest sends a TX descriptor chain larger than 32 KiB with hdr->len
smaller than the descriptor payload space, the resulting nonlinear skb has
skb->len < skb->data_len and a negative skb_headlen(skb).  If the receiving
host datagram socket has a filter attached, sock_queue_rcv_skb() ->
sk_filter_trim_cap() -> pskb_trim() -> ___pskb_trim() treats the negative
skb_headlen(skb) as a large unsigned offset, drops all page frags, zeroes
skb->data_len, and sets skb->tail past skb->end.  The subsequent
skb_copy_datagram_iter() in virtio_transport_dgram_dequeue() then copies
skb_shared_info and out-of-bounds kernel heap memory after skb->end to
userspace.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D3
