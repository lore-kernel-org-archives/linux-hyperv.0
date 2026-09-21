Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFFE398902;
	Mon, 21 Sep 2026 23:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790032645; cv=none; b=bDPeTEJt+9NrjlmtgSj4aRGwB8oZ8qKHRnmv9HvXRBGC0i5H2G4IiikEg1fOcgJgYTTWdcca6ruElOCkbcBU8HZm0qf2XNLq9l2eugMY41+e8E5ZHQ+rQxGNUK6GgMN0WAaafDOxDNiOMabONzimuIbmSrjaWz38PnilwmQNoVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790032645; c=relaxed/simple;
	bh=AUFbhEmXlZkVXtSMKv7VlAO0otXxEUML2aBbTl1nVMs=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MEBCOxorM6PZkDqmaUaqOpPQsIjxOdqMdtX+ZbHKzhjGWHZfQhOG49ZtYinUEnoa0ftawKIDvFfM+cs1D5BECIjM4AhMn5p0dqEM/ItFWZiwSV18R8Fgonf0+xGP3ZJhhili9XctLUBhu7PjQYPMfWKug7Avv9MptgI4EoxYcbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+oJrMdn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+oJrMdn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F088E1F000FF;
	Mon, 21 Sep 2026 23:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790032641;
	bh=+wEn3Ak0xk7EOTNfcdfLsG0vOpuUj3SLgH6sSDqmVac=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=X+oJrMdnXu+h3ySDtfxpoOridtFjoYe842E/PQsyzPDq79DbbHydjTTLZtD3s5vST
	 bjZsQ3byp1ixHxbC1x/dJforJlTKDvQOmP+13lNmaQj3W9msBdrAbtB2+74CIfkdB3
	 r1rFGWvKu6xWbcFXZ7J3/F79PWYGBtLJk6wZWmKAKyzBInnyJLcPbol7c7xebaG7Qr
	 uztpDqKmy+h9ootJ1trcyVDqiY5SJo6wpeAAgbXmSEjqPAQKq2SSeyWmiij037A+K1
	 gJXOhXui0XFMs1DNzlunsh165us9vJMzxrOhq7gSmcEWK5sDlQLcNbqFVjM5ZGFCU7
	 F5Wt3O8QdxHYQ==
Subject: Re: [PATCH] vsock/hv_sock: reject incoming connections when the
 listener is being released
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 sgarzare@redhat.com, mst@redhat.com, kuba@kernel.org
Date: Mon, 21 Sep 2026 23:17:20 +0000
Message-ID: <179003264046.2160803.3176959842906352107@kernel.org>
In-Reply-To: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220156.56015-1-bartlomiej.dmitruk@isec.pl>
X-sashiko-severity: Critical
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 1 · High: 0 (1) · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new early-exit added to hvs_open_connection() jumps to
  the `out:` label, which performs `sock_put(sk)`…
- [Low] The commit fixes a real, user-visible socket and VMBUS-channel
  leak in hvs_open_connection() (net/vmw_vsock/hyperv_transport.c:334)…

Pre-existing issues:
- [High] hvs_open_connection() (net/vmw_vsock/hyperv_transport.c): the
  new released-listener guard `if (sk->sk_shutdown == SHUTDOWN_MASK)…

--

vsock/hv_sock: reject incoming connections when the listener is being released

This adds a check for sk_shutdown == SHUTDOWN_MASK in
hvs_open_connection() so that a host channel offer racing close() of an
hv_sock listener does not create a child socket and enqueue it onto an
accept queue that __vsock_release() has already flushed.  The stated goal
is to stop the child socket and its VMBUS channel from leaking.

No Link: tags are present in the commit header.

A few questions about the change below.

[Severity: Low]
Should this carry a Fixes: tag?

The unguarded child creation in hvs_open_connection(), and the release
path that sets sk_shutdown = SHUTDOWN_MASK while leaving sk_state ==
TCP_LISTEN, both date back to the introduction of the transport, so the
trailer would be:

Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")

Without it, stable tooling will not pick up what is otherwise a real leak
fix.

> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 855b15971c359..19e487ac27263 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -326,6 +326,14 @@ static void hvs_open_connection(struct vmbus_channel *chan)
>  		if (sk_acceptq_is_full(sk))
>  			goto out;
>  
> +		/* __vsock_release() may have already flushed the accept queue
> +		 * and set sk_shutdown = SHUTDOWN_MASK while leaving sk_state ==
> +		 * TCP_LISTEN.  Enqueuing a child now would leak the child socket
> +		 * and its VMBUS channel.  Mirror virtio_transport_recv_listen().
> +		 */
> +		if (sk->sk_shutdown == SHUTDOWN_MASK)
> +			goto out;
> +

[Severity: Critical]
Can this new goto out lead to a use-after-free of the listener?

The out: epilogue in hvs_open_connection() drops the reference before it
unlocks:

net/vmw_vsock/hyperv_transport.c:hvs_open_connection() {
	...
out:
	/* Release refcnt obtained when we called vsock_find_bound_socket() */
	sock_put(sk);

	release_sock(sk);
}

In the exact race this patch targets, is the vsock_find_bound_socket()
reference the last one left?  The racing close() drops everything else:

net/vmw_vsock/af_vsock.c:__vsock_release() {
	sock_set_flag(sk, SOCK_DEAD);

	if (vsk->transport)
		vsk->transport->release(vsk);	/* hvs_release() ->
						 * vsock_remove_sock() ->
						 * vsock_remove_bound()
						 */
	sock_orphan(sk);
	sk->sk_shutdown = SHUTDOWN_MASK;
	...
	while ((pending = vsock_dequeue_accept(sk)) != NULL) {
		__vsock_release(pending, SINGLE_DEPTH_NESTING);
		sock_put(pending);
	}

	release_sock(sk);
	sock_put(sk);
}

vsock_dequeue_accept() also does sock_put(listener) for each queued child,
and hvs_close_lock_held() returns true immediately for TCP_LISTEN without
touching sk_state, so once __vsock_release() finishes the listener is only
kept alive by the lookup reference held by hvs_open_connection().

hvs_open_connection() then takes the lock, sees sk_state == TCP_LISTEN,
matches the new sk_shutdown == SHUTDOWN_MASK test, and goes to out:, where
sock_put() drops the count to zero.  vsock_proto sets neither SOCK_RCU_FREE
nor SLAB_TYPESAFE_BY_RCU, so sk_free() -> __sk_destruct() ->
kmem_cache_free() runs synchronously and the following release_sock(sk)
touches sk->sk_lock.slock, the backlog and the wait queue on freed memory.

Before this change the same race normally continued into
vsock_enqueue_accept(), which does sock_hold(listener), so the leak being
fixed here is what kept the socket alive past that sock_put().  Should the
epilogue be reordered to release_sock(sk) followed by sock_put(sk) as part
of this fix?

[Severity: High]
This isn't a bug introduced by this patch, but should the new test be
hoisted above the if (conn_from_host) block so it also covers the
guest-initiated arm?

As placed, the check only runs for conn_from_host.  For the
!conn_from_host case hvs_open_connection() accepts sk_state ==
TCP_SYN_SENT, and hvs_close_lock_held() leaves sk_state alone for that
state too, so a socket that __vsock_release() has already torn down still
looks connectable while sock_orphan() has cleared sk->sk_socket.  The else
branch then does:

net/vmw_vsock/hyperv_transport.c:hvs_open_connection() {
	...
	} else {
		sk->sk_state = TCP_ESTABLISHED;
		sk->sk_socket->state = SS_CONNECTED;

		vsock_insert_connected(vsock_sk(sk));
	}
	...
}

which writes through a NULL sk_socket, and inserts an already released
socket into the connected table.

Core vsock already treats that combination as a state where sk_socket must
not be dereferenced:

net/vmw_vsock/af_vsock.c:vsock_connect_timeout() {
	...
	if (sk->sk_state == TCP_SYN_SENT &&
	    (sk->sk_shutdown != SHUTDOWN_MASK)) {
		sk->sk_state = TCP_CLOSE;
		sk->sk_socket->state = SS_UNCONNECTED;
	...
}

Moving the new check up to just after the sk_state tests would cover both
arms.

>  		new = vsock_create_connected(sk);
>  		if (!new)
>  			goto out;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917220156.56015-1-bartlomiej.dmitruk%40isec.pl
