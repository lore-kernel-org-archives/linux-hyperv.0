Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205272;
	b=qA3CqBCY7p0NjkPQkqXQPlUmGj1zilm5Z7AgHyDg96EOQ3yTKaNoc9b/HqgKhQpEAvNq
	 aB9rBOO2XEwUHKSgwxtGK/c3rRqPVApOtIFrzIhWXWW16slX9wtIsyn5uyx/5nbsU/VEX
	 AXeTfnker7RPe+eIGxZlbwvg8pbYOCQwFCbLhD7V56pf9lQhquBjuSNu5X4WJph/5MSlc
	 G91UWx1tDwCWhggr4gyni3oVyOxP5Ef5FeTfikmCdqQ+xHqOMdP2+9KSqACe8XCOYgA9l
	 zaRXU1r8sUqJ8hLJ+0E8UVYsOkaFERYhJUa+73+oB2vIEL1r9MWgcGXDV3dRBE9alEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205272;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=0qMByyHPKGaQUWfgXFNZxpLHWxfO4wafpSFpsLM9Ew4=;
	b=b5O0SiFl6fVJmGn94GRr+z8kJfX4E57T7vwavqlJ/xsTyZgf0nnupsl61OUBdik+/TZA
	 kC8eyvGNrzYL4tX/x3BKkKsVHPSzJAQesgBX92dIShgHnisBoDH4Juhi0NE2bzm0fRxCA
	 FAQjgsANEbwPsZ5WcQTjDv0aYNXkhQDwgtwIPbdexN0sV3Alat2XmDo4LKeyCyr3tMJ00
	 +nQ/+V/JiUtVsVoggdM3Bp+Kuiv7larNlZ/wvjY9J82vfuXwvTGUAJ5iHphJhL6wFwJSz
	 +q1cTBFkbu8UOzWjeIGyDfqM7XhmdRpPukmpNZHVp3w/Bb1hplLB1WD38MGawzz4GEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sq0uzUAy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B3A606A31A;
	Wed, 28 Oct 2026 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sq0uzUAy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 564B31F01825;
	Wed, 28 Oct 2026 16:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793205271;
	bh=0qMByyHPKGaQUWfgXFNZxpLHWxfO4wafpSFpsLM9Ew4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Sq0uzUAyrwf/IEVsDj/CwujMg6dOti6mqvoJ+DAnV7nsWaSUUelc1lXowij71/91g
	 aO5kNF9MYq8fwJt/6Ws1eMMBtxvCzCoJUYwBbZPG2wWTbClj5mjo9kCzb98hWRjbJJ
	 G/EvdgDF4mFH8yszdA4nppTdSfbjJrdaKDQKrS0it3A/ZI/fTzqNJcTbVBdfRfteCZ
	 eUMU4C8ltDNDftLxTNx89yj9cbkZE0t8w+BlBeq/oB5mhoCdhKxRY5YApiNTHiuI62
	 6jsqfYUw/VS9A91ksyH5Cwrv3BUkhD4gTYwo53vV9Erp73M6ZO1GxTKAafgP7uZCCi
	 9nv1z3fbeE2ZQ==
Message-ID: <sashiko-outbox-188166@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 6/8] vsock: allow datagrams to use directional
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-6-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-6-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:34:30 +0000
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
- [High] vsock/virtio: bypass of checks in virtio_transport_dgram_source_al=
low()
- [Medium] vsock: vsock_dgram_sendmsg() mutates connected vsk->remote_addr =
on fallback
--

commit 634f5c11de9d307a1a88027855c76c28c15f7d96
Author: Sergio Lopez <slp@redhat.com>

vsock: allow datagrams to use directional transports

This commit enables AF_VSOCK datagram sockets to initialize through and
route across directional transports (such as virtio, vhost, and loopback)
when a dedicated datagram transport is not registered.

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index dc1add2d2e896..6419498a6fe27 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> @@ -1493,7 +1606,8 @@ static int vsock_dgram_sendmsg(struct socket *sock,=
 struct msghdr *msg,
>  		remote_addr =3D &vsk->remote_addr;
> =20
>  		if (remote_addr->svm_cid =3D=3D VMADDR_CID_ANY)
> -			remote_addr->svm_cid =3D transport->get_local_cid();
> +			remote_addr->svm_cid =3D transport->dgram_transport_match ?
> +				VMADDR_CID_LOCAL : transport->get_local_cid();
> =20
>  		/* XXX Should connect() or this function ensure remote_addr is
>  		 * bound?
> @@ -1507,13 +1621,14 @@ static int vsock_dgram_sendmsg(struct socket *soc=
k, struct msghdr *msg,
>  		goto out;
>  	}
> =20
> -	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
> -				    remote_addr->svm_port)) {
> -		err =3D -EINVAL;
> +	transport =3D vsock_dgram_get_transport(vsk, remote_addr);
> +	if (IS_ERR(transport)) {
> +		err =3D PTR_ERR(transport);
>  		goto out;
>  	}

[Severity: Medium]
When vsock_dgram_sendmsg() is called without msg_name on a connected
socket, remote_addr points directly to &vsk->remote_addr.

If the socket connected to an active H2G guest CID (leaving
vsk->remote_addr.svm_flags without VMADDR_FLAG_TO_HOST) and that guest is
temporarily unavailable while g2h_fallback is enabled,
vsock_dgram_get_transport() takes the fallback path and mutates
remote_addr in place:

net/vmw_vsock/af_vsock.c:vsock_dgram_get_transport() {
	...
	} else if (sock_net(sk)->vsock.g2h_fallback && transport_g2h &&
		   transport_g2h->has_remote_cid &&
		   transport_g2h->has_remote_cid(vsk, cid)) {
		transport =3D transport_g2h;
		to_host =3D true;
	}
	...
	if (to_host)
		remote_addr->svm_flags |=3D VMADDR_FLAG_TO_HOST;
}

Because vsock_dgram_get_transport() checks VMADDR_FLAG_TO_HOST before
transport_h2g->has_remote_cid(), won't this permanently pin
vsk->remote_addr to transport_g2h for subsequent sends, receive source
checks, and getpeername() even after the H2G guest restarts?

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index ae33630d99e71..7c1ec8feb853c 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -322,13 +322,18 @@ static int virtio_transport_send_pkt_info(struct vs=
ock_sock *vsk,
> =20
>  	info->type =3D virtio_transport_get_type(sk_vsock(vsk));
> =20
> -	t_ops =3D virtio_transport_get_ops(vsk);
> +	t_ops =3D info->t_ops ?: virtio_transport_get_ops(vsk);
>  	if (unlikely(!t_ops))
>  		return -EFAULT;
> =20
>  	src_cid =3D t_ops->transport.get_local_cid();
> +	/* Preserve explicit datagram bindings so loopback replies can find the=
m. */
> +	if (info->type =3D=3D VIRTIO_VSOCK_TYPE_DGRAM &&
> +	    src_cid =3D=3D VMADDR_CID_LOCAL &&
> +	    vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY)
> +		src_cid =3D vsk->local_addr.svm_cid;
>  	src_port =3D vsk->local_addr.svm_port;
[ ... ]
> @@ -1861,6 +1877,33 @@ static bool virtio_transport_valid_type(u16 type)
>  	       (type =3D=3D VIRTIO_VSOCK_TYPE_DGRAM);
>  }
> =20
> +static bool
> +virtio_transport_dgram_source_allow(struct vsock_sock *vsk,
> +				    const struct vsock_transport *transport,
> +				    const struct sockaddr_vm *src)
> +{
> +	const struct vsock_transport *peer_transport;
> +	struct sockaddr_vm peer =3D vsk->remote_addr;
> +	bool allow;
> +
> +	if (!virtio_transport_dgram_transport_match(vsk->transport) ||
> +	    !virtio_transport_dgram_transport_match(transport))
> +		return false;
> +	/* Shutdown preserves the peer; only disconnect removes it. */
> +	if (sk_vsock(vsk)->sk_socket->state =3D=3D SS_UNCONNECTED)
> +		return true;
> +
> +	peer_transport =3D vsock_dgram_get_transport(vsk, &peer);
> +	if (IS_ERR(peer_transport))
> +		return false;
> +	allow =3D peer_transport =3D=3D transport &&
> +		src->svm_port =3D=3D vsk->remote_addr.svm_port &&
> +		(src->svm_cid =3D=3D vsk->remote_addr.svm_cid ||
> +		 transport->get_local_cid() =3D=3D VMADDR_CID_LOCAL);
> +	module_put(peer_transport->module);
> +	return allow;
> +}
> +
>  /* We are under the virtio-vsock's vsock->rx_lock or vhost-vsock's vq->m=
utex
>   * lock.
>   */
> @@ -1911,14 +1954,14 @@ void virtio_transport_recv_pkt(struct virtio_tran=
sport *t,
>  		vsk =3D vsock_sk(sk);
>  		lock_sock(sk);
>  		if (sock_flag(sk, SOCK_DEAD) ||
> -		    vsk->transport !=3D &t->transport ||
> -		    (sk->sk_socket->state !=3D SS_UNCONNECTED &&
> -		     !vsock_check_source(vsk, &t->transport, &src))) {
> +		    !virtio_transport_dgram_source_allow(vsk, &t->transport, &src)) {
>  			release_sock(sk);
>  			sock_put(sk);
>  			goto free_pkt;
>  		}

[Severity: High]
Can virtio_transport_dgram_source_allow() bypass feature negotiation,
local CID transport isolation, and connected peer CID checks?

First, for SS_UNCONNECTED sockets, virtio_transport_dgram_source_allow()
returns true immediately after virtio_transport_dgram_transport_match(),
which is a static callback comparison that succeeds for virtio_transport,
vhost_transport, and loopback_transport without calling
transport->dgram_allow(vsk, src->svm_cid, src->svm_port).

Since neither vhost_vsock_handle_tx_kick() nor virtio_transport_rx_work()
checks vsock->dgram_allow before calling virtio_transport_recv_pkt(), a
peer that has not negotiated VIRTIO_VSOCK_F_DGRAM can deliver
VIRTIO_VSOCK_TYPE_DGRAM packets to any unconnected bound socket on the
host (bypassing vhost_transport_dgram_allow()) or on a guest initialized
via the vhost_transport fallback (bypassing
virtio_transport_dgram_allow_check()).

Second, returning true early for SS_UNCONNECTED sockets skips checking
whether vsk->local_addr.svm_cid is compatible with the receiving
transport. Because virtio_transport_rx_work() does not validate
hdr->dst_cid against the guest CID and __vsock_find_bound_socket_net()
matches dst.svm_cid =3D=3D vsk->local_addr.svm_cid or VMADDR_CID_ANY, an
external peer on virtio_transport can send datagrams addressed to
VMADDR_CID_LOCAL, VMADDR_CID_HOST, or VMADDR_CID_ANY and reach an
unconnected socket bound to VMADDR_CID_LOCAL or VMADDR_CID_HOST.

Third, on loopback_transport, virtio_transport_send_pkt_info() now
preserves explicit vsk->local_addr.svm_cid values in hdr->src_cid, and
__vsock_find_bound_socket_net() allows distinct local sockets to bind to
the same port on different local CIDs (such as VMADDR_CID_LOCAL and the
guest or host CID). Because transport->get_local_cid() =3D=3D VMADDR_CID_LO=
CAL
is always true for loopback_transport, won't a local socket bound to
(VMADDR_CID_LOCAL, port) be accepted by a socket connected to (guest_cid,
port) despite having a mismatched src->svm_cid?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D6
