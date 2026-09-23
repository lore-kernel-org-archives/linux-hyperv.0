Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B6E51EE0C;
	Wed, 23 Sep 2026 12:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790167596; cv=none; b=ouTU7hFcYd/B4hjqJ94OQo6BppgisxR66OCWAn/KqOaNXDmJKz8TH5bR7p74YHFGDZV5Ski14leNpYE1f6awugdYOmoeByGArqM6kqHNpv/dahGA6b3bmWhYPYGuhuEUdiaV0iB7qCyT18GTtncs35ncigyx3bPvhd4TC7QrhtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790167596; c=relaxed/simple;
	bh=o373JaRvIMBaRzOlt0PlMiXmyhP7s3N7mpWqgD980G8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WKA+b6qj5yRG/bZFcnJXU3e7Ifpxq+P7+fbmJIJKXW1vVhrzDAgCQEmD0ZpZR9h/Jx45eIW2cPoeT8+mirYwnyWU5SZ8T55OkXydNJeyFVjXTzMnhbTKYVLSPnUUaY2C1aKHsu1X4iai6K0FI1MFYWemexUuVpoEoOKwDXe8+r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cI6JcwOO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cI6JcwOO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F1AF1F00893;
	Wed, 23 Sep 2026 12:46:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790167595;
	bh=eiThmUCDTi6jUA1esSlRxj1CPMF6e/wEMRadt309C40=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cI6JcwOOIRFhRxM8g4WpDcr26Js/UM4pa3y6rPO5TdH4Wb1y5NgachHOYLD/F8sFb
	 +RkopNzqh7Ud98DWWg5xe/00LsqtbbDrF1qzGFMwjMzq/fkbjGyG96TSPKh/M94N1Z
	 Db99mCnvapocPleW5Nej70sJ9MLb7EcNQ5ovOIo7HpD34mMuFdwggf3IySvy5ytCIr
	 hmPyAUY9qghKGtUZQHa3FM0KIk29TwmqfSjn0pmoQm1jXL1RYnmSrwQYJkuVEMkLt7
	 tf/51tznVrfQQB6PCa2i/B6Z1dZKq6wOmZZeT6kxG2QRMRqJhtjqKvOZK1mQSjyNPr
	 oVnVRIcP6YDpQ==
Subject: Re: [PATCH v2] vsock/hv_sock: don't finish a connection on a socket
 being released
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, sgarzare@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, mst@redhat.com, linux-hyperv@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 23 Sep 2026 12:46:33 +0000
Message-ID: <179016759361.2160803.2565725244445913228@kernel.org>
In-Reply-To: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
References: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
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

Critical: 1 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Critical] The new `goto out` makes the reversed teardown order at the
  `out:` label of hvs_open_connection() (`sock_put(sk)` at…
- [Medium] Commit message understates the impact of the race it fixes:
  for the guest-initiated (!conn_from_host) path the pre-patch race is a…

--

vsock/hv_sock: don't finish a connection on a socket being released

This adds a sk_shutdown == SHUTDOWN_MASK check to hvs_open_connection()
right after lock_sock(), so a VMBUS channel offer that races close() bails
out instead of completing a connection or enqueueing a child on a socket
that __vsock_release() has already torn down.  The check is placed in the
common path so it covers both the conn_from_host and !conn_from_host cases.

Two questions below, one about the commit message and one about the exit
path the new check now jumps to.

> (!conn_from_host && sk->sk_state != TCP_SYN_SENT))
> 		goto out;

Regarding this part of the changelog:

    "or completes a connection on a socket being torn down
    (!conn_from_host); the socket and its VMBUS channel then leak."

[Severity: Medium]
For the guest-initiated path, is a leak really the pre-patch outcome?  In
__vsock_release() sock_orphan() runs immediately before the shutdown mask
is set:

net/vmw_vsock/af_vsock.c:__vsock_release() {
	...
	sock_orphan(sk);
	sk->sk_shutdown = SHUTDOWN_MASK;
	...
}

so sk->sk_socket is already NULL in exactly the state the new check
detects.  For a socket in TCP_SYN_SENT, hvs_release() ->
hvs_close_lock_held() returns early and leaves sk_state alone:

net/vmw_vsock/hyperv_transport.c:hvs_close_lock_held() {
	if (!(sk->sk_state == TCP_ESTABLISHED ||
	      sk->sk_state == TCP_CLOSING))
		return true;
	...
}

which means the pre-patch state check in hvs_open_connection() passes and
the !conn_from_host completion path runs:

net/vmw_vsock/hyperv_transport.c:hvs_open_connection() {
	...
	} else {
		sk->sk_state = TCP_ESTABLISHED;
		sk->sk_socket->state = SS_CONNECTED;
	...
}

Wouldn't that dereference a NULL sk->sk_socket and oops the guest rather
than leak the socket and channel?  Should the changelog describe that as
the impact for the guest-initiated path, since it also changes how urgent
a stable backport looks?

> +	/* __vsock_release() may have already set sk_shutdown = SHUTDOWN_MASK
> +	 * (and, for a listener, flushed the accept queue) while leaving the
> +	 * socket in TCP_LISTEN/TCP_SYN_SENT.  Proceeding would enqueue a child
> +	 * onto a released listener, or complete a connection on a released
> +	 * socket, leaking it and its VMBUS channel.
> +	 */
> +	if (sk->sk_shutdown == SHUTDOWN_MASK)
> +		goto out;

[Severity: Critical]
Can this new goto out free sk and then touch it?  The out: label in
hvs_open_connection() drops the reference before unlocking:

net/vmw_vsock/hyperv_transport.c:hvs_open_connection() {
	...
out:
	/* Release refcnt obtained when we called vsock_find_bound_socket() */
	sock_put(sk);

	release_sock(sk);
}

Counting references for the race the patch targets:

CPU1 (VMBUS offer worker)
hvs_open_connection()
   vsock_find_bound_socket() -> sock_hold()	/* refs: alloc + bound + this */
   lock_sock(sk)				/* blocks */

CPU0 (close)
__vsock_release()
   sock_set_flag(sk, SOCK_DEAD);
   vsk->transport->release() -> hvs_release() -> hvs_close_lock_held()
       -> vsock_remove_sock()			/* bound ref dropped */
   sk->sk_shutdown = SHUTDOWN_MASK;
   while ((pending = vsock_dequeue_accept(sk)) != NULL) { ... }
   release_sock(sk);
   sock_put(sk);				/* only CPU1's ref left */

CPU1 then acquires the lock, the new sk_shutdown == SHUTDOWN_MASK test
fires, and control goes straight to out: without ever reaching the later
sock_hold()/vsock_enqueue_accept() that used to keep sk alive on the
success path.  sock_put() therefore takes the refcount 1 -> 0.  vsock does
not set SOCK_RCU_FREE anywhere under net/vmw_vsock/, so sk_free() ->
__sk_free() -> sk_prot_free() frees the struct sock right there, and the
following release_sock(sk) spin-locks sk->sk_lock.slock, runs the backlog
and wakes sk->sk_lock.wq on freed memory.

The rest of the file already uses the other order, for example:

net/vmw_vsock/hyperv_transport.c:hvs_close_connection() {
	lock_sock(sk);
	hvs_do_close_lock_held(vsock_sk(sk), true);
	release_sock(sk);

	/* Release the refcnt for the channel that's opened in
	 * hvs_open_connection().
	 */
	sock_put(sk);
}

Should the out: label be reordered to release_sock(sk) before
sock_put(sk) as part of this change, given the new check makes this exit
the expected outcome of the race?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919123128.28868-1-bartlomiej.dmitruk%40isec.pl
