Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794591738;
	b=Lx7JYvNMvO8gJQJ4mr5tDmkGNgvnbbehsPciz1f9M5g6edSrjsHSRt9MnvpEPRQxDFXv
	 NGLY81Dn8/IgUDzlf4raY5JUSQckYkvGHKw1dLXedE7G8RPBCkD+65jv7qY5pS/+r0HsJ
	 OlUrJAh0/X5/4dkL6OQPkGwfR3mKJdCBCyUDg8mCE5wGCShx50FuoQ0jAIJONDtTfFdFa
	 3/fX2W2X2BrkxoKRbDazA7Jrb79SEyvyI7qVtMomjcw6rKiJsAhnCkuJ+El9aC/1y5bsV
	 TNKlaCQyy43lj9SNEh29nGNW+EM2JKpKESl5aqDzO4n8aDb2LvwX293p7cFjKD/RrcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591738;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Fl69UvFz7M/xHyOwf6baSwAePhr8TRIxNHnV31DbQTQ=;
	b=Do79olGp19KnlPN7sVs14S747Yi+u6DRJb2eM20Oq1ADHR3M9Y1Khq07ZN3E//DLTM5S
	 35LpT6mzEDKBD16SaB4Bo6uRADByZqpluRCiXeif6xXz6kdAoKMSGTCPWC5ArkAlkWFVs
	 el+5jwKs93Iq/NJTgJZ5eL+MGqVusWs/Wd+x0N2Xhv0jgSjNWBWGdKoQK0tZl16oioLIo
	 ElNRRX43iDRdmeXAKkVb9ZZSpe1pAI7wfhi0ZvdSFQL73aMTJl+0qciSuMiydeMmuf1hP
	 OU7y2jqcIhCn9DVx8FPhOGnRKaZJLM+yUANpS+m9HPiUuE6+NHRG9T0lBOWFOxBnaaQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ7jUEK+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC64606A337;
	Fri, 13 Nov 2026 17:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fQ7jUEK+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A51F11F000C4;
	Fri, 13 Nov 2026 17:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794591738;
	bh=Fl69UvFz7M/xHyOwf6baSwAePhr8TRIxNHnV31DbQTQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fQ7jUEK+TH4qkM6EcY55fWVb3n50Tf6Pf8cEF2a9Zd7nkdXuZUK9wGFQbUgnLBxm4
	 MVoalfuakHjRIW48AxR4Yr4Fd8GJzzaDwA0RlJFQGtspK3sTUzsUTwz+zNgqPNeVwe
	 lAn/ZkaIFB/JQWWNUBfsO7+Ams8vd/8w4JlEHDCKcUJxPkqkzgpFeC7Shet9VcRTd/
	 oplv4zxjZITYY1vV7tnlgcEpQyKLFJxJyebh5/5/9Ez9cmb89F15uaonJwLw9rEMSE
	 1w/TKooUnKxlGJuExzBqRyJ4WghawzGaUkjVCFgCKfMQ+JMdx/1gqfUUhe2DeRYaZA
	 b2zcOxs6rvi2w==
Message-ID: <sashiko-outbox-213343@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 6/8] vsock: allow datagrams to use directional
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-6-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-6-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:42:17 +0000
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
- [Medium] vsock: local datagrams route to transport_g2h when loopback
  is unloaded
- [Medium] vsock: VMCI datagram sockets misroute CID_HOST and CID_ANY to
  loopback
--

commit 9eab4679f5d6926cf379df182996c2e8cd726902
Author: Sergio Lopez <slp@redhat.com>

vsock: allow datagrams to use directional transports

This commit enables datagram sockets to select directional and loopback
transports per destination while keeping a fallback transport as the
socket owner when needed, and unifies datagram receive queuing in the
core.

Link: https://lore.kernel.org/all/DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com/

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index aef5389eeca2c..e0d1a3e5d05cc 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c
[ ... ]
> @@ -576,11 +579,56 @@ static bool vsock_use_local_transport(unsigned int =
remote_cid)
>  	if (remote_cid =3D=3D VMADDR_CID_LOCAL)
>  		return true;
> =20
> -	if (transport_g2h) {
> -		return remote_cid =3D=3D transport_g2h->get_local_cid();
> -	} else {
> -		return remote_cid =3D=3D VMADDR_CID_HOST;
> +	local_cid =3D transport_g2h ? transport_g2h->get_local_cid() :
> +		VMADDR_CID_HOST;
> +	/* A virtio device without a CID keeps the host loopback alias.
> +	 * Hyper-V has no numeric CID even while it is active, so CID_HOST
> +	 * must keep using its guest-to-host transport in that case.
> +	 */
> +	if (local_cid =3D=3D VMADDR_CID_ANY && transport_g2h->dgram_transport_m=
atch)
> +		local_cid =3D VMADDR_CID_HOST;
> +
> +	return remote_cid =3D=3D local_cid;
> +}
> +
> +/* Select a route without changing socket ownership. The caller holds
> + * vsock_register_mutex and pins the returned transport before releasing=
 it.
> + */
> +static const struct vsock_transport *
> +vsock_select_transport(struct vsock_sock *vsk,
> +		       const struct sockaddr_vm *remote_addr,
> +		       const struct vsock_transport *dgram_owner,
> +		       bool *to_host)
> +{
> +	struct sock *sk =3D sk_vsock(vsk);
> +	u32 cid =3D remote_addr->svm_cid;
> +
> +	lockdep_assert_held(&vsock_register_mutex);
> +	*to_host =3D false;
> +
> +	if (vsock_use_local_transport(cid))
> +		return transport_local;
> +	if (cid <=3D VMADDR_CID_HOST ||
> +	    (remote_addr->svm_flags & VMADDR_FLAG_TO_HOST))
> +		return transport_g2h;

[Severity: Medium]
Can vsock_select_transport() route VMADDR_CID_LOCAL datagrams to
transport_g2h when transport_local is not registered?

When transport_local is NULL, vsock_use_local_transport(VMADDR_CID_LOCAL)
returns false and cid <=3D VMADDR_CID_HOST (1 <=3D 2) matches, returning
transport_g2h instead of NULL. Because vsock_dgram_resolve_cid() also
maps VMADDR_CID_ANY to VMADDR_CID_LOCAL whenever
owner->dgram_transport_match is set, datagram connect() and sendmsg() to
VMADDR_CID_LOCAL or VMADDR_CID_ANY transmit local packets to the host (or
fall back to the VMCI owner) instead of failing with -ENODEV. When
vsock.g2h_fallback is enabled without transport_local, connecting a
datagram socket to the guest's own CID also succeeds via transport_g2h
even though subsequent sends fail in virtio_transport_send_pkt().

[ ... ]

> @@ -1461,6 +1645,27 @@ static int vsock_read_skb(struct sock *sk, skb_rea=
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
> +	if (transport_local || owner->dgram_transport_match) {
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
Does this misroute VMCI datagrams onto loopback when vsock_loopback is
loaded?

On a VMCI guest where virtio_transport is loaded without an active
virtio-vsock device (or transport_g2h is NULL),
vsock_use_local_transport(VMADDR_CID_HOST) returns true, so
vsock_select_transport() routes VMADDR_CID_HOST datagrams to
transport_local instead of falling back to the VMCI owner. In addition, if
a VMCI socket is bound to VMCI's local CID and sends or connects to
VMADDR_CID_ANY while transport_local is registered,
vsock_dgram_resolve_cid() resolves the destination to VMADDR_CID_LOCAL and
vsock_dgram_get_transport() skips the fallback to owner because
transport->get_local_cid() =3D=3D VMADDR_CID_LOCAL, failing with
-EADDRNOTAVAIL when vsk->local_addr.svm_cid does not match loopback.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D6
