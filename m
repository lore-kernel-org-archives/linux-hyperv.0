Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524260;
	b=BSOdzGprS+yUc83ZC37KER52MZGxdDFiqbVwOCzY45S2CddtwO8CXZduVsMMU818TaGb
	 kZQUR0UI+i/3tTYx05FtqL7KdgDuFbbUmvyjAeWnKRRNVZ+KSogy2Fuu0arLqbWSgOyiP
	 JfWk8uiBu5l0gDkW3msH+KaYCqpgi/OfQrOHhprHbchQPT0oqLTP2QRPGtZbjCifmJ6Pu
	 sxmAGl/gEf7AAJZneo92oCloP1IhNm3AT8hPsSWyMzChuZB/YXre+hH4myAGNPst4OBzN
	 YTRo23Jgj8l2QBGes8CKtgaY+50wlgIczCelwKrzNtlzrh7+94x5GdbDiyautuCGyqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524260;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=EioaRMd6eqHJ2q4oFGJHSd8yKli/WmaenmbovHLD7kM=;
	b=pzQaiehT8r1f+9xl9Ssp5urP+2z1c6D4T6Jhvw53KqP2g9WLLrbKNnJRr30KAaHpZ8Le
	 oEuSnY6fGN0XBP4sFPO64MD/2cFARpjLFtyb7CZxILCe6vkmp1ULo9M/QedEzPCOcphYt
	 BimFZ1UPU8wTTzijQI7cPT83yq9j9oN15QEO7Iky2zRFW2dRwVKLztYu5269vPfj0oi1h
	 LInaYvlU937wW2A6X1N1h2CJnqDsrPYivF7p6tTwBSNkjgroNZGHOvJ11v37gnHRB2taY
	 DKHtOPFkofT4VNJp3qmdz06U/NtMHXVmDnjJAulXb7DkLAAPk4aS02NQ8qEoBRBReDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIe4TmdY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7136606A32A;
	Tue, 24 Nov 2026 12:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIe4TmdY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C181F00A01;
	Tue, 24 Nov 2026 12:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524259;
	bh=EioaRMd6eqHJ2q4oFGJHSd8yKli/WmaenmbovHLD7kM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=CIe4TmdY6br9AwtykCotco9JqqtkfH/WJSKKebGrNrp1nJRNaETh5VyuIAhCTDcip
	 HNTg6G0cnMvBbFNNP2lHFrZkvd+uT+MU9WiZJFhUKiwURwFW2hxSLq2j9hAp6T1Tou
	 hAF6+S+Zwz1JebfljFHSfDgXfrz70GLMMcUEnPCRZGmHpoxPkobTfWf3vEGqwYuYgq
	 C0Vnjg1h+32bNYodx1Ajq+UZRjVx7hcZrNRUnuV65EW8rCMy9UmpW86bl3voP/YTrB
	 /iaT8wwWdSqVhMDDM+eFrX/HNcVmxn7NCzb+Cwbm75V6qeOY/O6Sl4/jKq44oNDnAU
	 hfqWfjujP6xlw==
Message-ID: <sashiko-outbox-231167@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 6/8] vsock: allow datagrams to use directional
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-6-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
 <20261124-vsock-dgram-support-v4-6-3607484e85e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:44:18 +0000
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
- [Medium] vsock: inconsistent loopback source CID check in
  vsock_dgram_get_transport()
- [Medium] vsock: missing VMADDR_CID_ANY check in
  vsock_dgram_resolve_cid()
- [Medium] vsock: per-packet global vsock_register_mutex lock on
  datagram hot paths
--

commit 21473b8a230a0146483d0435292761949197fc7c
Author: Sergio Lopez <slp@redhat.com>

vsock: allow datagrams to use directional transports

This commit enables AF_VSOCK datagram sockets to route packets across
directional (G2H/H2G) and loopback transports while retaining VMCI as a
fallback endpoint owner and unifying datagram receive queueing in the core.

Link: https://lore.kernel.org/all/sashiko-outbox-213343@kernel.org/
Link: https://lore.kernel.org/all/DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index aef5389eeca2c..1880ff8ed9ca3 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -724,6 +802,113 @@ int vsock_assign_transport(struct vsock_sock *vsk, =
struct vsock_sock *psk)
>  }
>  EXPORT_SYMBOL_GPL(vsock_assign_transport);
> =20
> +/**
> + * vsock_dgram_get_transport - select a transport for a datagram destina=
tion
> + * @vsk: socket whose datagram state will be used
> + * @remote_addr: destination address
> + * @vmci_self: wildcard destination resolved to the VMCI owner's local C=
ID
> + *
> + * The caller must hold the socket lock and release the returned transpo=
rt's
> + * module reference after use. A datagram fallback owns its socket's bin=
ding,
> + * but a directional transport takes precedence when it can reach the pe=
er.
> + * Parent fallback sets VMADDR_FLAG_TO_HOST to preserve that route on co=
nnect.
> + *
> + * Return: a referenced transport or an ERR_PTR on failure.
> + */
> +const struct vsock_transport *
> +vsock_dgram_get_transport(struct vsock_sock *vsk,
> +			  struct sockaddr_vm *remote_addr, bool vmci_self)
> +{

[ ... ]

> +	if (!transport)
> +		goto out;
> +	if (owner->dgram_transport_match &&
> +	    !owner->dgram_transport_match(transport)) {
> +		err =3D -ESOCKTNOSUPPORT;
> +		goto out;
> +	}
> +	/* Loopback source addresses must route replies back to loopback. */
> +	if (shared && transport =3D=3D transport_local &&
> +	    vsk->local_addr.svm_cid !=3D VMADDR_CID_ANY &&
> +	    !vsock_use_local_transport(vsk->local_addr.svm_cid)) {
> +		err =3D -EADDRNOTAVAIL;
> +		goto out;
> +	}

[Severity: Medium]
Does this loopback source check miss the VMCI exclusions that
vsock_select_transport() applies?

For a VMCI-owned datagram socket in global mode, vsock_select_transport()
routes both owner->get_local_cid() and VMADDR_CID_HOST away from
transport_local even when vsock_use_local_transport() returns true.
Checking only vsock_use_local_transport(vsk->local_addr.svm_cid) here lets
a socket explicitly bound to VMADDR_CID_HOST (when no active G2H CID is
present) or to VMCI's local CID (when VMCI is registered as transport_g2h)
send or connect over transport_local, but replies to that source CID and
connected-peer verification in virtio_transport_dgram_source_allow()
resolve to vmci_transport instead of transport_local, causing connected
loopback receivers to drop the packets.

[ ... ]

> @@ -1461,6 +1660,31 @@ static int vsock_read_skb(struct sock *sk, skb_rea=
d_actor_t read_actor)
>  	return vsk->transport->read_skb(vsk, read_actor);
>  }
> =20
> +static int vsock_dgram_resolve_cid(struct vsock_sock *vsk,
> +				   struct sockaddr_vm *remote_addr,
> +				   bool *vmci_self)
> +{
> +	const struct vsock_transport *owner =3D vsk->transport;
> +
> +	if (remote_addr->svm_cid !=3D VMADDR_CID_ANY)
> +		return 0;
> +
> +	mutex_lock(&vsock_register_mutex);
> +	if (owner->dgram_fallback && vsock_net_mode_global(vsk) &&
> +	    vsk->local_addr.svm_cid =3D=3D owner->get_local_cid()) {
> +		remote_addr->svm_cid =3D vsk->local_addr.svm_cid;
> +		*vmci_self =3D true;
> +	} else if (transport_local || owner->dgram_transport_match) {
> +		remote_addr->svm_cid =3D VMADDR_CID_LOCAL;
> +	} else {
> +		remote_addr->svm_cid =3D owner->get_local_cid();
> +		*vmci_self =3D owner->dgram_fallback;
> +	}
> +	mutex_unlock(&vsock_register_mutex);
> +
> +	return remote_addr->svm_cid =3D=3D VMADDR_CID_ANY ? -EADDRNOTAVAIL : 0;
> +}

[Severity: Medium]
Should the first branch also check that vsk->local_addr.svm_cid !=3D
VMADDR_CID_ANY?

vmci_transport_init() registers vmci_transport as the datagram fallback at
module load time even when neither VMCI guest nor host personality is
active, in which case owner->get_local_cid() returns VMCI_INVALID_ID
(VMADDR_CID_ANY).  When a wildcard-bound or auto-bound socket calls
connect() or sendmsg() with remote_addr->svm_cid =3D=3D VMADDR_CID_ANY,
vsk->local_addr.svm_cid =3D=3D owner->get_local_cid() matches on
VMADDR_CID_ANY, skipping the transport_local branch and failing with
-EADDRNOTAVAIL even when vsock_loopback is loaded.

>  static int vsock_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
>  			       size_t len)
>  {

[ ... ]

> @@ -1493,42 +1717,34 @@ static int vsock_dgram_sendmsg(struct socket *soc=
k, struct msghdr *msg,
>  	if (msg->msg_name &&
>  	    vsock_addr_cast(msg->msg_name, msg->msg_namelen,
>  			    &remote_addr) =3D=3D 0) {
> -		/* Ensure this address is of the right type and is a valid
> -		 * destination.
> -		 */
> -
> -		if (remote_addr->svm_cid =3D=3D VMADDR_CID_ANY)
> -			remote_addr->svm_cid =3D transport->get_local_cid();
> -
> -		if (!vsock_addr_bound(remote_addr)) {
> -			err =3D -EINVAL;
> -			goto out;
> -		}
> +		connected_addr =3D *remote_addr;
> +		remote_addr =3D &connected_addr;
>  	} else if (sock->state =3D=3D SS_CONNECTED) {
> -		remote_addr =3D &vsk->remote_addr;
> -
> -		if (remote_addr->svm_cid =3D=3D VMADDR_CID_ANY)
> -			remote_addr->svm_cid =3D transport->get_local_cid();
> -
> -		/* XXX Should connect() or this function ensure remote_addr is
> -		 * bound?
> -		 */
> -		if (!vsock_addr_bound(&vsk->remote_addr)) {
> -			err =3D -EINVAL;
> -			goto out;
> -		}
> +		/* A fallback must not pin subsequent sends to the host. */
> +		connected_addr =3D vsk->remote_addr;
> +		remote_addr =3D &connected_addr;
> +		vmci_self =3D vsk->dgram_peer_is_vmci_self;
>  	} else {
>  		err =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	if (!transport->dgram_allow(vsk, remote_addr->svm_cid,
> -				    remote_addr->svm_port)) {
> +	err =3D vsock_dgram_resolve_cid(vsk, remote_addr, &vmci_self);
> +	if (err)
> +		goto out;
> +	if (!vsock_addr_bound(remote_addr)) {
>  		err =3D -EINVAL;
>  		goto out;
>  	}
> =20
> -	err =3D transport->dgram_enqueue(vsk, remote_addr, msg, len);
> +	transport =3D vsock_dgram_get_transport(vsk, remote_addr, vmci_self);
> +	if (IS_ERR(transport)) {
> +		err =3D PTR_ERR(transport);
> +		goto out;
> +	}
> +
> +	err =3D transport->dgram_enqueue(vsk, transport, remote_addr, msg, len);
> +	module_put(transport->module);

[Severity: Medium]
Can we avoid taking vsock_register_mutex and bouncing module refcounts on
every datagram send and connected receive?

vsock_dgram_sendmsg() and virtio_transport_dgram_source_allow() (on every
incoming datagram for a connected socket, while holding the virtqueue lock
and lock_sock()) now call vsock_dgram_get_transport(), which acquires the
global vsock_register_mutex, does try_module_get()/module_put(), and
performs multiple vhost_vsock_get() lookups per packet, serializing
datagram traffic across all sockets system-wide.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-vsock-dgra=
m-support-v4-0-3607484e85e8@redhat.com?part=3D6
