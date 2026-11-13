Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794577163;
	b=mb/7VDVoEan3c4Rcs0gjd7CKhMpGKggU6PUJvCCuAhqcGm0W5NvnbKSJ037jcPVd2X9h
	 erSdnPnFqLGMhGmJM4xNa/todF762hKxf83NymuQzzoHry/ze55n4YtBhFPidmssVHBv6
	 y7YMYFCkLyx+pXWIdmm6FcVaJgOZGoYboQ0ngaqspH1kQnZtvmuOPKkcpMRIZFz/5pDNM
	 mgbmaXFdRoMj7Gwl2C36PKAXBqQgwLyQSn/VMBcIX6UmCf1OPxL99HRSX9vKLkkIS8qui
	 R+qtMiwNekEwPmf9cCjlPFVKqCjeS9DmUn54kpgZMR0KDQBwNvomEAHHpTUH6XYwxew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794577163;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VQejXV2bOHWexBSaDT+HrozleuwE+FHCXrUstZn5Ty4=;
	b=prd8G1Dcsg94CmYTSOSGYJqjH4kmP5sgQyOo7M1RTluatirgCPm/IVOo838oWdG2evHm
	 CabS189hl6KueMvv2J94PpK3UwkFoK93c4RZkpR08iMqQjXK/BOAaI3jiPGA0LgUyvYd2
	 W4ZeHh8DmG7Q30CtIAXCECwOaJpfrwYt2CwyHPmTS3oO6fxUWd8rOk7mQwlPEeSacfm6y
	 AoI9GmXAaHwJAQFuAmZ5yuOSJuxnvyof5pUYDMNfWmkAtJyBltpkFmVWfZ73YcxcJ/J93
	 Q9UvoX9pjYXFMWd0Aab266yZGdZF7GIsp8qZubB1kFCFvoaOtkG6hZrwyDF+Z1S03rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ6rnwMX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720BE606A323;
	Fri, 13 Nov 2026 13:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kQ6rnwMX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA7011F000C4;
	Fri, 13 Nov 2026 13:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794577163;
	bh=VQejXV2bOHWexBSaDT+HrozleuwE+FHCXrUstZn5Ty4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kQ6rnwMX/2GycR7odNs3nCAPJfJdfAacoKTKWD/2Wi3QLOBh+ycJsfi9ETT25kEw+
	 K06MAuv5tOUt5CgwM/mXlzMoZ7koe4K8YwGjZlUfzssL9Un7bDg34EtTfNkHmp8su2
	 OWc3MQCyXLMIGnLsUjEl1a1C/JwN5U8942m0Qgwd8VqXdnPMstZXeVEmKDblRuvAiD
	 U+ocIYnegcgxf+a05bUPYZrP38lJ9Ft/8Eh6fkh7DiA1CdZ+dF/v5eEQWANIHGALgg
	 kGDGktx9UMDpB/zVORGVs5abtGeLZKn5BWhHdzm1uj+1pdNojg4wnJ4B3UNOe7L7MF
	 NGiKM/0wdAu+w==
Message-ID: <sashiko-outbox-212907@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 6/8] vsock: allow datagrams to use directional
 transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-6-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-6-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:39:22 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [High] vsock: Hyper-V stream connections broken in
  vsock_use_local_transport()
- [High] vsock: vsock_select_transport() routes VMADDR_CID_HOST
  datagrams to VMCI
- [High] vsock: explicit CID bind failure in vmci_transport_dgram_bind()
- [High] vsock/vmci: local netns isolation bypass in
  vmci_transport_dgram_bind()
- [Medium] vsock: broken VMADDR_CID_ANY handling in
  vsock_dgram_connect() and sendmsg()
- [Medium] vsock: bind rollback TOCTOU race in
  virtio_transport_recv_pkt()
- [Medium] vsock/virtio: virtio_transport_recv_pkt() sets TO_HOST on
  host datagrams
- [Low] vsock/virtio: unused to_host field in struct virtio_vsock_skb_cb
--

commit 99283d4e6bf0b4f58509834e3f59987834c1907c
Author: Sergio Lopez <slp@redhat.com>

vsock: allow datagrams to use directional transports

This commit routes AF_VSOCK datagrams across directional transports,
loopback, and the VMCI fallback transport while unifying datagram
receive queuing in the core socket layer.

Link: https://lore.kernel.org/all/DMGNAV67LK3F.2FNLTD5NVHDEA@gmail.com/

> diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
> index f91704731057e..16b869085a0ab 100644
> --- a/include/linux/virtio_vsock.h
> +++ b/include/linux/virtio_vsock.h
> @@ -12,6 +12,7 @@
>  struct virtio_vsock_skb_cb {
>  	bool reply;
>  	bool tap_delivered;
> +	bool to_host;
>  	u32 offset;
>  };

[Severity: Low]
This isn't a bug, but struct virtio_vsock_skb_cb::to_host is never read or
written anywhere in the patch (receive-side VMADDR_FLAG_TO_HOST is stored
in VSOCK_DGRAM_SKB_CB(skb)->src.svm_flags instead).

> diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
> index aef5389eeca2c..7e52c7e5583c2 100644
> --- a/net/vmw_vsock/af_vsock.c
> +++ b/net/vmw_vsock/af_vsock.c

[ ... ]

> @@ -568,6 +569,8 @@ EXPORT_SYMBOL_GPL(vsock_enqueue_accept);
> =20
>  static bool vsock_use_local_transport(unsigned int remote_cid)
>  {
> +	u32 local_cid;
> +
>  	lockdep_assert_held(&vsock_register_mutex);
> =20
>  	if (!transport_local)
> @@ -576,11 +579,50 @@ static bool vsock_use_local_transport(unsigned int =
remote_cid)
>  	if (remote_cid =3D=3D VMADDR_CID_LOCAL)
>  		return true;
> =20
> -	if (transport_g2h) {
> -		return remote_cid =3D=3D transport_g2h->get_local_cid();
> -	} else {
> -		return remote_cid =3D=3D VMADDR_CID_HOST;
> -	}
> +	local_cid =3D transport_g2h ? transport_g2h->get_local_cid() :
> +		VMADDR_CID_ANY;
> +	if (local_cid =3D=3D VMADDR_CID_ANY)
> +		local_cid =3D VMADDR_CID_HOST;
> +
> +	return remote_cid =3D=3D local_cid;
> +}

[Severity: High]
Does replacing VMADDR_CID_ANY with VMADDR_CID_HOST here break Hyper-V
SOCK_STREAM connections when vsock_loopback is loaded?

hvs_transport registers as transport_g2h and its get_local_cid() callback
(hvs_get_local_cid()) always returns VMADDR_CID_ANY because Hyper-V guests
do not use a numeric guest CID.  With this change,
vsock_use_local_transport(VMADDR_CID_HOST) returns true whenever
transport_local is registered, so vsock_select_transport() routes
outgoing guest-to-host connect() calls to loopback_transport instead of
hvs_transport, and incoming host connections in hvs_open_connection()
(which sets vnew->remote_addr.svm_cid =3D VMADDR_CID_HOST) fail the
!hvs_check_transport(vnew) check and are dropped.

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
> +	/* VMCI may use a different local CID from the virtio transports. */
> +	if (dgram_owner && dgram_owner->dgram_fallback &&
> +	    cid =3D=3D dgram_owner->get_local_cid())
> +		return dgram_owner;
> +	if (cid <=3D VMADDR_CID_HOST ||
> +	    (remote_addr->svm_flags & VMADDR_FLAG_TO_HOST))
> +		return transport_g2h;

[Severity: High]
On a virtio guest with vmw_vsock_vmci_transport loaded, doesn't checking
cid =3D=3D dgram_owner->get_local_cid() before cid <=3D VMADDR_CID_HOST mis=
route
VMADDR_CID_HOST datagrams to VMCI instead of virtio_transport?

drivers/misc/vmw_vmci/vmci_driver.c:vmci_get_context_id() {
	if (vmci_guest_code_active())
		return vmci_get_vm_context_id();
	else if (vmci_host_code_active())
		return VMCI_HOST_CONTEXT_ID;

	return VMCI_INVALID_ID;
}

Because vmci_drv_init() initializes the host device unconditionally on
module load, vmci_host_code_active() is true on any guest without a VMware
PCI device, so vmci_transport_get_local_cid() returns VMCI_HOST_CONTEXT_ID
(2, which equals VMADDR_CID_HOST).  When a guest SOCK_DGRAM socket sends
or connects to VMADDR_CID_HOST, cid =3D=3D dgram_owner->get_local_cid()
matches vmci_transport before reaching cid <=3D VMADDR_CID_HOST, causing
sends to fail in vmci_datagram_send() with -EHOSTUNREACH and connected
sockets to reject incoming virtio datagrams from the host in
virtio_transport_dgram_source_allow().

[ ... ]

> @@ -629,33 +673,28 @@ int vsock_assign_transport(struct vsock_sock *vsk, =
struct vsock_sock *psk)
>  	    vsk->remote_addr.svm_cid > VMADDR_CID_HOST)
>  		vsk->remote_addr.svm_flags |=3D VMADDR_FLAG_TO_HOST;
> =20
> -	remote_flags =3D vsk->remote_addr.svm_flags;
> -
>  	mutex_lock(&vsock_register_mutex);
> =20
>  	switch (sk->sk_type) {
>  	case SOCK_DGRAM:
> -		new_transport =3D transport_dgram;
> +		/* VMCI must own bind() to create its receive handle, even when
> +		 * directional transports serve individual destinations.
> +		 */
> +		if (transport_dgram_fallback)
> +			new_transport =3D transport_dgram_fallback;
> +		else if (transport_g2h)
> +			new_transport =3D transport_g2h;
> +		else if (transport_h2g)
> +			new_transport =3D transport_h2g;
> +		else
> +			new_transport =3D transport_local;
>  		break;

[Severity: High]
Should vsock_assign_transport() (or vmci_transport_dgram_bind()) avoid
allocating a global VMCI datagram handle when the socket's netns is in
VSOCK_NET_MODE_LOCAL?

Assigning transport_dgram_fallback to SOCK_DGRAM sockets in a
VSOCK_NET_MODE_LOCAL namespace causes vmci_transport_dgram_bind() to call
vmci_transport_datagram_create_hnd(), which reserves the port in the
system-wide vmci_resource_table and registers vmci_transport_recv_dgram_cb(=
).
Because vmci_resource_table is global and vmci_transport_recv_dgram_cb()
does not check vsock_net_mode_global(vsk), sockets in local-mode
namespaces collide on ports with init_net and can receive global VMCI
datagrams across the namespace isolation boundary.

[ ... ]

> @@ -1498,7 +1671,8 @@ static int vsock_dgram_sendmsg(struct socket *sock,=
 struct msghdr *msg,
>  		 */
> =20
>  		if (remote_addr->svm_cid =3D=3D VMADDR_CID_ANY)
> -			remote_addr->svm_cid =3D transport->get_local_cid();
> +			remote_addr->svm_cid =3D transport->dgram_transport_match ?
> +				VMADDR_CID_LOCAL : transport->get_local_cid();
> =20
>  		if (!vsock_addr_bound(remote_addr)) {
>  			err =3D -EINVAL;
> @@ -1508,27 +1682,32 @@ static int vsock_dgram_sendmsg(struct socket *soc=
k, struct msghdr *msg,
>  		remote_addr =3D &vsk->remote_addr;
> =20
>  		if (remote_addr->svm_cid =3D=3D VMADDR_CID_ANY)
> -			remote_addr->svm_cid =3D transport->get_local_cid();
> +			remote_addr->svm_cid =3D transport->dgram_transport_match ?
> +				VMADDR_CID_LOCAL : transport->get_local_cid();
> =20
>  		/* XXX Should connect() or this function ensure remote_addr is
>  		 * bound?
>  		 */
> -		if (!vsock_addr_bound(&vsk->remote_addr)) {
> +		if (!vsock_addr_bound(remote_addr)) {
>  			err =3D -EINVAL;
>  			goto out;
>  		}
> +		/* A fallback must not pin subsequent sends to the host. */
> +		connected_addr =3D *remote_addr;
> +		remote_addr =3D &connected_addr;
>  	} else {
>  		err =3D -EINVAL;
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
> =20
> -	err =3D transport->dgram_enqueue(vsk, remote_addr, msg, len);
> +	err =3D transport->dgram_enqueue(vsk, transport, remote_addr, msg, len);
> +	module_put(transport->module);
> =20
>  out:
>  	release_sock(sk);
> @@ -1542,6 +1721,7 @@ static int vsock_dgram_connect(struct socket *sock,
>  	struct sock *sk;
>  	struct vsock_sock *vsk;
>  	struct sockaddr_vm *remote_addr;
> +	const struct vsock_transport *transport;
> =20
>  	sk =3D sock->sk;
>  	vsk =3D vsock_sk(sk);
> @@ -1563,11 +1743,16 @@ static int vsock_dgram_connect(struct socket *soc=
k,
>  	if (err)
>  		goto out;
> =20
> -	if (!vsk->transport->dgram_allow(vsk, remote_addr->svm_cid,
> -					 remote_addr->svm_port)) {
> -		err =3D -EINVAL;
> +	if (remote_addr->svm_cid =3D=3D VMADDR_CID_ANY &&
> +	    vsk->transport->dgram_transport_match)
> +		remote_addr->svm_cid =3D VMADDR_CID_LOCAL;
> +
> +	transport =3D vsock_dgram_get_transport(vsk, remote_addr);
> +	if (IS_ERR(transport)) {
> +		err =3D PTR_ERR(transport);
>  		goto out;
>  	}
> +	module_put(transport->module);
> =20
>  	memcpy(&vsk->remote_addr, remote_addr, sizeof(vsk->remote_addr));

[Severity: Medium]
What happens in vsock_dgram_connect() and vsock_dgram_sendmsg() when
remote_addr->svm_cid is VMADDR_CID_ANY and vmci_transport owns the socket
(so dgram_transport_match is NULL)?

In vsock_dgram_connect(), remote_addr->svm_cid is left as VMADDR_CID_ANY
(0xffffffffU) and passed to vsock_dgram_get_transport().  Because
0xffffffffU > VMADDR_CID_HOST, vsock_select_transport() takes the
g2h_fallback path when enabled and sets VMADDR_FLAG_TO_HOST on
vsk->remote_addr, while leaving vsk->remote_addr.svm_cid as VMADDR_CID_ANY
so virtio_transport_dgram_source_allow() drops all incoming packets until
sendmsg() is called.

In vsock_dgram_sendmsg(), the SS_CONNECTED path then mutates
vsk->remote_addr.svm_cid in place before copying it into connected_addr.
Moreover, if VMCI has no active personality, transport->get_local_cid()
returns VMCI_INVALID_ID (VMADDR_CID_ANY), causing vsock_addr_bound() in
vsock_dgram_sendmsg() to fail with -EINVAL and vsock_select_transport() in
vsock_dgram_connect() to match cid =3D=3D dgram_owner->get_local_cid() inst=
ead
of loopback.

> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virt=
io_transport_common.c
> index 08baa1181ba6d..3ef86f5eaf362 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c

[ ... ]

> @@ -1891,14 +1887,21 @@ void virtio_transport_recv_pkt(struct virtio_tran=
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

[Severity: Medium]
Can virtio_transport_recv_pkt() deliver a datagram to an unbound socket or
the wrong port if vmci_transport_dgram_bind() rolls back the core bind?

CPU0                                  CPU1
__vsock_bind()                        virtio_transport_recv_pkt()
  lock_sock(sk)
  vmci_transport_dgram_bind()
    vsock_bind_common(vsk, addr)
                                        sk =3D vsock_find_bound_dgram_socke=
t_net(&dst, ...)
                                        lock_sock(sk) (blocks)
    vmci_transport_datagram_create_hnd()
      (fails)
    vsock_unbind_common(vsk)
  release_sock(sk)
                                        (acquires lock_sock)
                                        virtio_transport_dgram_source_allow=
()
                                        sock_queue_rcv_skb(sk, skb) <-- que=
ued on unbound socket

vsock_bind_common() publishes vsk in vsock_bind_table and drops
vsock_table_lock before vmci_transport_datagram_create_hnd() runs.  If
handle creation fails, vsock_unbind_common() removes vsk or retries on
another port, but virtio_transport_recv_pkt() does not re-check that
vsk->local_addr still matches dst after acquiring lock_sock(sk).

> +
> +		/* Loopback can hand the TX skb to its receiver. Release TX
> +		 * ownership before replacing its private control block.
> +		 */
> +		skb_orphan(skb);
> +		vsock_addr_init(&VSOCK_DGRAM_SKB_CB(skb)->src,
> +				src.svm_cid, src.svm_port);
> +		if (t->transport.get_local_cid() > VMADDR_CID_HOST)
> +			VSOCK_DGRAM_SKB_CB(skb)->src.svm_flags =3D
> +				VMADDR_FLAG_TO_HOST;

[Severity: Medium]
Should this also check src.svm_cid > VMADDR_CID_HOST before setting
VMADDR_FLAG_TO_HOST, matching vsock_assign_transport()?

On a guest using virtio_transport, t->transport.get_local_cid() is the
guest CID (> VMADDR_CID_HOST), so checking only get_local_cid() sets
VMADDR_FLAG_TO_HOST on every received datagram even when the sender is the
host itself (src.svm_cid =3D=3D VMADDR_CID_HOST).  recvmsg() then reports
VMADDR_FLAG_TO_HOST in msg_name for direct host-to-guest traffic, whereas
getpeername() on a socket connected to VMADDR_CID_HOST reports
svm_flags =3D=3D 0.

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 2b9493e987d1e..3c02c9a5319b9 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c

[ ... ]

> @@ -1690,39 +1693,49 @@ static void vmci_transport_release(struct vsock_s=
ock *vsk)
>  	}
>  }
> =20
> +#define VMCI_DGRAM_BIND_RETRIES 24
> +
>  static int vmci_transport_dgram_bind(struct vsock_sock *vsk,
>  				     struct sockaddr_vm *addr)
>  {
> +	const bool auto_port =3D addr->svm_port =3D=3D VMADDR_PORT_ANY;
>  	u32 port;
>  	u32 flags;
> +	unsigned int i;
>  	int err;
> =20
> -	/* VMCI will select a resource ID for us if we provide
> -	 * VMCI_INVALID_ID.
> -	 */
> -	port =3D addr->svm_port =3D=3D VMADDR_PORT_ANY ?
> -			VMCI_INVALID_ID : addr->svm_port;
> -
> -	if (port <=3D LAST_RESERVED_PORT && !capable(CAP_NET_BIND_SERVICE))
> -		return -EACCES;
> -
>  	flags =3D addr->svm_cid =3D=3D VMADDR_CID_ANY ?
>  				VMCI_FLAG_ANYCID_DG_HND : 0;
> =20
> -	err =3D vmci_transport_datagram_create_hnd(port, flags,
> -						 vmci_transport_recv_dgram_cb,
> -						 &vsk->sk,
> -						 &vmci_trans(vsk)->dg_handle);
> -	if (err < VMCI_SUCCESS)
> -		return vmci_transport_error_to_vsock_error(err);
> -	vsock_addr_init(&vsk->local_addr, addr->svm_cid,
> -			vmci_trans(vsk)->dg_handle.resource);
> +	/* Reserve the same port for VMCI and directional receive. A VMCI
> +	 * resource may already occupy a core-selected ephemeral port.
> +	 */
> +	for (i =3D 0; i < VMCI_DGRAM_BIND_RETRIES; i++) {
> +		err =3D vsock_bind_common(vsk, addr);
> +		if (err)
> +			return err;
> =20
> -	return 0;
> +		port =3D vsk->local_addr.svm_port;
> +		err =3D vmci_transport_datagram_create_hnd(port, flags,
> +							 vmci_transport_recv_dgram_cb,
> +							 &vsk->sk,
> +							 &vmci_trans(vsk)->dg_handle);

[Severity: High]
What happens here when a user binds a SOCK_DGRAM socket to an explicit
local CID (such as VMADDR_CID_LOCAL or a virtio guest CID) while
vmw_vsock_vmci_transport is loaded?

drivers/misc/vmw_vmci/vmci_datagram.c:dg_create_handle() {
    ...
	if ((flags & VMCI_FLAG_ANYCID_DG_HND) !=3D 0) {
		context_id =3D VMCI_INVALID_ID;
	} else {
		context_id =3D vmci_get_context_id();
		if (context_id =3D=3D VMCI_INVALID_ID)
			return VMCI_ERROR_NO_RESOURCES;
	}
    ...
}

Because addr->svm_cid !=3D VMADDR_CID_ANY, flags is 0.  If VMCI has no
active guest or host personality (vmci_get_context_id() =3D=3D VMCI_INVALID=
_ID),
dg_create_handle() returns VMCI_ERROR_NO_RESOURCES and every explicit-CID
bind() fails with -ENOBUFS.  If VMCI is active, dg_create_handle() binds
the VMCI handle to vmci_get_context_id() rather than addr->svm_cid, so a
socket bound to VMADDR_CID_LOCAL (or a virtio guest CID) still registers a
VMCI receiver on VMCI's context ID and can receive external VMCI datagrams.

Conversely, vsock_find_cid() only checks transport_g2h, transport_h2g, and
transport_local, so if VMCI's local CID differs from transport_g2h,
__vsock_bind() rejects binding to VMCI's own local CID with
-EADDRNOTAVAIL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D6
