Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35EA226E165
	for <linux-hyperv@vger.kernel.org>; Tue,  1 Sep 2026 13:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788270280; cv=none; b=EWOI5pbS9TxkZ5youI4d+Y8wQrWvdPJwTFlVVYmx/muIXrTuK8j40c73/Q28LwYzabp0KnR08ZunulYZRzQziwRYfzvLecd7bRh+/bDjFh5EntjDX6WxGShkM4RywvI2yEAJBJfJEyb6+rL3Bx8Vx6UYKSNKyr9F37nrDec9tG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788270280; c=relaxed/simple;
	bh=H1e1PIwPGpwvqMn2a5H2dnkaK9fSotNSftJIVuzqg54=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=e7GECTeo/zfOEbFuYhoEAKF/PLFFIsTYFN0xsyGhp1gRY4l80PLyf6RXaK+1C13CiTZ2sCc1tp5TLFg1/n0TY245xcm3N+RL4/phoSAQYjACe08uuAYN7rPu6rTDZZWIbGyuGpMGapajAvJlIu7u4a9l+5obF/6KlVjTfS2RTzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RH853fce; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RH853fce"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A038A1F000E9;
	Tue,  1 Sep 2026 13:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788270278;
	bh=GfZG2aDBS2BXDNvzgFGiGsWTCf6A7xHN27N97H3Cwfs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RH853fceQF3+chpAF7Y+q/Cv40L/OIjPqdx5HRsIjM5d6ugQEwwW0+LMsbJzHWi0h
	 LERcV1w1QppW5IdO7dBnnIrH6/E9d8nfyG/HYhKqkWAi0CyW8wzvNfSOyLVoqxMkfD
	 4bGFdCkKUqPFTSP/Up82HtsiYtgFU9mPNGelXlK632VK0vkpGx31v7aL/uHuXRHRQK
	 /M6RDmglvgXmIw/6JeNbORqw0S6efi2Gu7qssbXYnFdZJrAZnNVwm+OQ/6QRlgUEG0
	 Sl9Hf54Ir3wwOP43g0zpjNImuujutIRcKePIKnADLzhkR5lCuyT9p68qRI8a6g+I14
	 5CaBydck6dI7Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] vsock: use sk_acceptq_is_full()
 helper in all transports
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260831133314.4125787-350-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-350-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 13:44:38 +0000
Message-Id: <20260901134438.A038A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Calling release_sock() after sock_put() in hvs_open_connection=
() leads to a use-after-free if the last reference is dropped.
- [High] Failed connection handshakes leak the listening socket's sk_ack_ba=
cklog count in vmci_transport_recv_listen(), leading to a permanent DoS.
- [High] Leaked sk_ack_backlog in virtio_transport_recv_listen() on transpo=
rt assignment failure, leading to a permanent DoS.
--

commit b2cf725bf1bbce146242b6299dd0f179a06ce499
Author: Raf Dickson <rafdog35@gmail.com>

    vsock: use sk_acceptq_is_full() helper in all transports
   =20
    Replace the open-coded backlog check with sk_acceptq_is_full().
    The helper uses > instead of >=3D, which is the correct comparison
    per commit 64a146513f8f ("[NET]: Revert incorrect accept queue
    backlog changes."), and adds READ_ONCE() for proper memory ordering.
   =20
    Link: https://patch.msgid.link/20260612045842.122207-1-rafdog35@gmail.c=
om

> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_tran=
sport.c
> index 432fcbbd14d4f..2c38c8ec2c829 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -323,7 +323,7 @@ static void hvs_open_connection(struct vmbus_channel =
*chan)
>  		goto out;
> =20
>  	if (conn_from_host) {
> -		if (sk->sk_ack_backlog >=3D sk->sk_max_ack_backlog)
> +		if (sk_acceptq_is_full(sk))
>  			goto out;
> =20
>  		new =3D vsock_create_connected(sk);

[Severity: Critical]
This is a pre-existing issue, but does calling release_sock() after
sock_put() in hvs_open_connection() lead to a use-after-free?

In hvs_open_connection(), if the reference dropped by sock_put(sk) is the
final one, the socket memory will be freed, but release_sock(sk) is called
immediately after:

out:
	/* Release refcnt obtained when we called vsock_find_bound_socket() */
	sock_put(sk);

	release_sock(sk);

Should release_sock(sk) be called before sock_put(sk) to prevent
dereferencing freed memory?

> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transpor=
t.c
> index 7eccd6708d664..0198d06ce3d3e 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -1000,7 +1000,7 @@ static int vmci_transport_recv_listen(struct sock *=
sk,
>  	 * reset.  Otherwise we create and initialize a child socket and reply
>  	 * with a connection negotiation.
>  	 */
> -	if (sk->sk_ack_backlog >=3D sk->sk_max_ack_backlog) {
> +	if (sk_acceptq_is_full(sk)) {
>  		vmci_transport_reply_reset(pkt);
>  		return -ECONNREFUSED;
>  	}

[Severity: High]
This isn't a bug introduced by this patch, but could the error path in
vmci_transport_recv_listen() leak the listening socket's sk_ack_backlog
count on a failed connection handshake?

Earlier in vmci_transport_recv_listen(), if the handshake fails, the
pending socket is removed:

		if (err < 0)
			vsock_remove_pending(sk, pending);

		release_sock(pending);
		vmci_transport_release_pending(pending);

		return err;

Since sk_acceptq_added() was previously called, shouldn't this path also
call sk_acceptq_removed(sk) to decrement the listener's backlog?
Without it, legitimate connection attempts might be permanently rejected
once the counter reaches the maximum limit.

[Severity: High]
This is a pre-existing issue, but is there a leak of sk_ack_backlog in
virtio_transport_recv_listen() on transport assignment failure?

In net/vmw_vsock/virtio_transport_common.c, in the error path where the
socket is destroyed:

	ret =3D vsock_assign_transport(vchild, vsk);
	/* Transport assigned (looking at remote_addr) must be the same
	 * where we received the request.
	 */
	if (ret || vchild->transport !=3D &t->transport) {
		release_sock(child);
		virtio_transport_reset_no_sock(t, skb);
		sock_put(child);
		return ret;
	}

Because sk_acceptq_added() was already called for this connection, does
this path need to call sk_acceptq_removed(sk) to prevent a permanent
denial of service where no further connections are accepted?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-350-sashal@kernel.org?part=3D1
