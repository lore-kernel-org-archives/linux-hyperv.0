Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793204456;
	b=vnOxCkgi8/QiPyIefzAd4lPbRSr7N2ROu3g1RUIM40PH7A9PEqDE5xQkoxhcxt2C9uvm
	 czED4cXzViq/6H3rIt0xxpMwIGDObKQybTOPsP8gLWzTqY2qRbmXlWxvCbp/fqK+Fr7F2
	 fsrDeAr0zS38PFfsHpsVGAxKXwsq3L8wW2kxI4EfsxX5Mp0ihVNloGS94t+/mPKy6cy8s
	 +zVLKkwv+xjdU4GOssJ0RTyYPP8C0Papvm55ET6Cr0rBTsqddDN+Ve8gZrZ762I+dnr0T
	 7B85F0XKM/Civu1CyTF1nDQ0GHrsSw8jpBQpEaL4S4K+uN5XUytiHl4TydhuIQWtDfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793204456;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Zhr/tHkDJQkZfq7AsFcRymMgMcTsHiAv1mGITq5gBXc=;
	b=HLHYdX+Di8214IoiPNHJyyg/uAHMx9KzzZxLiSnhKfnfSTn2tU8Mpy7ezIcT32h8GRSo
	 Xa6dGZscCHq0FyftX6sKATdKpUXte+GBPdu109gpL+VKjspdKqMp5uGQO9MOPXLeczTmq
	 PJZXU5G8HikSSwZCdicVeYpUZhRcfdXBgNPnENRpqN5WwEJrC0Nq7+3fJ2bFGjv/2UbuV
	 Iqp9oCmfEkH6GPsNoqtTsqwzdos1mhQjdQ8sOmGqMIYZTTAd8I2eBXLr44r43WlRqxqnR
	 Gi0e3b5BMOgztZSlHGbcQ1ZTQX4b1gudne3yTtE4vPvcK+/kBuoXKrA3eXEQ0PUps3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTkouKGt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B74606A327;
	Wed, 28 Oct 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jTkouKGt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12ECF1F01825;
	Wed, 28 Oct 2026 16:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793204455;
	bh=Zhr/tHkDJQkZfq7AsFcRymMgMcTsHiAv1mGITq5gBXc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jTkouKGtMzl6QkKX8lYJFy+YQW6SzYXd3a0urKEJCz5BZgT7ypkH8Gtn55iMQPdGu
	 c26sJeUrg/sMeGW4QVPfmIuVuatyaDB1/ww5thGvSnzrkeJuVy2cOHkoC6cvgT4g5W
	 p24jUZE86JKTN5+bODmcA355kTJLTQnYMpV3Ftin4Deh5DtjL+0M57ZFovYFhJtDt7
	 7k1IQSulRkBq6jHvtB9eWcCFFcGxJBgOccft/D80T8J/dkJ78U3pATHORyd22I+F5F
	 hyuS+eMajnA5tyGMg2ac3UudVVDRoQ6NBv6Q38s5WbFEi1/5K1raVZaQydZfsHF4Hi
	 Zy72ms1PGhk9g==
Message-ID: <sashiko-outbox-188158@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 5/8] vhost/vsock: negotiate datagram support with
 guests
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-5-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-5-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:20:54 +0000
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
- [Medium] vhost/vsock: missing dgram_allow check in vhost_vsock_handle_tx_=
kick()
--

commit 635912e90dc603f9b7384d44cf174e18056f799d
Author: Sergio Lopez <slp@redhat.com>

vhost/vsock: negotiate datagram support with guests

This commit exposes VIRTIO_VSOCK_F_DGRAM in the vhost feature bitmap and
tracks whether datagram support was negotiated per guest via
vsock->dgram_allow. It also wires up vhost_transport_dgram_allow() to check
the negotiated feature on the target guest for outbound datagrams.

> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index 0cb87971d7491..eb2fbdb721aa9 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c

[ ... ]

> @@ -516,6 +520,24 @@ static bool vhost_transport_seqpacket_allow(struct v=
sock_sock *vsk,
>  	return seqpacket_allow;
>  }
> =20
> +static bool vhost_transport_dgram_allow(struct vsock_sock *vsk,
> +					u32 cid, u32 port)
> +{
> +	struct net *net =3D sock_net(sk_vsock(vsk));
> +	struct vhost_vsock *vsock;
> +	bool dgram_allow =3D false;
> +
> +	rcu_read_lock();
> +	vsock =3D vhost_vsock_get(cid, net);
> +
> +	if (vsock)
> +		dgram_allow =3D vsock->dgram_allow;
> +
> +	rcu_read_unlock();
> +
> +	return dgram_allow;
> +}
> +
>  static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
>  {
>  	struct vhost_virtqueue *vq =3D container_of(work, struct vhost_virtqueu=
e,

[Severity: Medium]
Can a guest that has not negotiated VIRTIO_VSOCK_F_DGRAM still send
VIRTIO_VSOCK_TYPE_DGRAM packets to unconnected bound SOCK_DGRAM sockets on
the host?

vhost_transport_dgram_allow() checks vsock->dgram_allow on outbound host
connect() and sendmsg() paths, but on the guest-to-host path in
drivers/vhost/vsock.c:vhost_vsock_handle_tx_kick(), incoming packets are
passed to virtio_transport_recv_pkt() without checking vsock->dgram_allow:

drivers/vhost/vsock.c:vhost_vsock_handle_tx_kick() {
	...
		/* Only accept correctly addressed packets */
		if (le64_to_cpu(hdr->src_cid) =3D=3D vsock->guest_cid &&
		    le64_to_cpu(hdr->dst_cid) =3D=3D
		    vhost_transport_get_local_cid())
			virtio_transport_recv_pkt(&vhost_transport, skb,
						  vsock->net);
		else
			kfree_skb(skb);
	...
}

Unlike VIRTIO_VSOCK_TYPE_SEQPACKET, where inbound connection requests go
through virtio_transport_recv_listen() -> vsock_assign_transport() ->
vhost_transport_seqpacket_allow(), inbound VIRTIO_VSOCK_TYPE_DGRAM packets
in net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_pkt() are
queued directly onto bound unconnected SOCK_DGRAM sockets without calling
dgram_allow():

net/vmw_vsock/virtio_transport_common.c:virtio_transport_recv_pkt() {
	...
	if (le16_to_cpu(hdr->type) =3D=3D VIRTIO_VSOCK_TYPE_DGRAM) {
		if (le16_to_cpu(hdr->op) !=3D VIRTIO_VSOCK_OP_RW)
			goto free_pkt;

		sk =3D vsock_find_bound_socket_net(&dst, net);
		...
		if (sock_flag(sk, SOCK_DEAD) ||
		    vsk->transport !=3D &t->transport ||
		    (sk->sk_socket->state !=3D SS_UNCONNECTED &&
		     !vsock_check_source(vsk, &t->transport, &src))) {
			release_sock(sk);
			sock_put(sk);
			goto free_pkt;
		}

		if (sock_queue_rcv_skb(sk, skb))
			kfree_skb(skb);
	...
}

Even with the later virtio_transport_dgram_source_allow() check, unconnected
bound SOCK_DGRAM sockets return true before consulting dgram_allow().

Should vhost_vsock_handle_tx_kick() drop VIRTIO_VSOCK_TYPE_DGRAM packets
when !vsock->dgram_allow, or should virtio_transport_recv_pkt() validate
dgram_allow() for incoming datagrams regardless of whether the receiving
socket is connected?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D5
