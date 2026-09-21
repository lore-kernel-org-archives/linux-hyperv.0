Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8E947D460;
	Mon, 21 Sep 2026 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790033042; cv=none; b=A27pAOiaQIqhtdCsRJPqLvaGpz/T2QF6rkwjcn7/NoYkclZbliyCqm7jFz4E3Z5N9zodxCdNNAdjkqxdITPsZciZewEJ24ARGjsqL+WZBDi0vJgHN+6r97lhEoZNpFiMcm53k2ozr/cJBcqbICjj4Ygd1ilZiDE36dlaynp56cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790033042; c=relaxed/simple;
	bh=F9Nc5VQmOoSmRUIxGOfwTVssqSez1uZN9c7xJYqdl5I=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dc8JvAAMQviadUIDvwJ8YEcpbqjcdYLAViqfGon8gH4e2HSCRaLYuhic4T4Dq/zqdUSfmdGg3xyTqy9jfVDn9erbEQy2m2n+5UMJzJ+ginNUkE/4SDhWXquaRFyDiS96njoBA6e2GmEtMMLjIlCIMAYiiLJ/EAHyqypZbBzyY1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uvo2n6Fi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uvo2n6Fi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 306E71F000FF;
	Mon, 21 Sep 2026 23:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790033037;
	bh=q/Nbz2dyNClG9b4ee353cgWCmiZ/CbxVIEn8L+troCo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Uvo2n6FiGWfFvycM6y1y/I7EE1/KRtfmO3D2WYmBsvvHpmiKkAZLuc/sTvdveTX52
	 VHJvhyG4+9lgiLSVtJQch9Z8BgVPTJna0vIcQgAqF7LsOsmP5xIYLkWCd2KhTmXePa
	 kWObz8aU2BI3moyNuOS9kkeOUFDZTgu34kggH2SP9aYCzmm6WOxkI6bTGtZs6gRdtH
	 l/J7dXVhoyXjf1HMT9RncEUzQ7VWZpU5rhgxla6A6LXC5MyjwYiY5/QKuaicO9Ldfk
	 Istbvu5fpLeJeXuveJ7Lp21hxiSovjYdzxgSOG28lRDISjEA3Zq34aSdIRNVZiUqtt
	 1fVX8ldeGjnpA==
Subject: Re: [PATCH] vsock/hv_sock: fix socket/table leak when rescind races
 the delayed close
From: netdev-bot+sashiko@kernel.org
To: bartlomiej.dmitruk@isec.pl
Cc: decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 sgarzare@redhat.com, mst@redhat.com, kuba@kernel.org
Date: Mon, 21 Sep 2026 23:23:56 +0000
Message-ID: <179003303663.2160803.2038691427232135222@kernel.org>
In-Reply-To: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
References: <20260917220213.56102-1-bartlomiej.dmitruk@isec.pl>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Missing `Fixes:` tag and stable Cc on a real bug fix.

Pre-existing issues:
- [High] The identical leak the patch closes for hv_sock remains in the
  sibling transport that shares the same `vsk->close_work` /…

--

vsock/hv_sock: fix socket/table leak when rescind races the delayed close

This changes hvs_close_timeout() so that, when SOCK_DONE is already set but
vsk->close_work_scheduled is still true, the running work drops the
scheduling reference and calls vsock_remove_sock() itself. That covers the
case where hvs_close_connection() could not cancel the already-dequeued
work.

A couple of questions below.

> Make the running timeout complete the cleanup the rescind path could not:
> when SOCK_DONE is set but the work is still marked scheduled, drop the
> scheduling reference and remove the socket.  The two cleanup sites are
> mutually exclusive and guarded by close_work_scheduled, so the reference
> is dropped exactly once.  (cancel_delayed_work_sync() cannot be used from
> hvs_do_close_lock_held(): it runs under the same lock_sock() the work
> takes.)
>
> Signed-off-by: Bartłomiej Dmitruk <bartlomiej.dmitruk@isec.pl>

[Severity: Medium]
Should this carry a Fixes: tag and a stable Cc?

git blame on the pre-image points both halves of the defective logic at
commit a9eeb998c28d ("hv_sock: Add support for delayed close"): the
cancel_delayed_work()-conditional reference drop in
hvs_do_close_lock_held(), and the unconditional
vsk->close_work_scheduled = false in hvs_close_timeout().

The triggering event is a host-initiated channel rescind, so it is not
under guest control. Would the following trailers be appropriate, along
with a [PATCH net] subject prefix?

  Fixes: a9eeb998c28d ("hv_sock: Add support for delayed close")
  Cc: stable@vger.kernel.org

> diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> index 855b15971c359..2779961fc18ca 100644
> --- a/net/vmw_vsock/hyperv_transport.c
> +++ b/net/vmw_vsock/hyperv_transport.c
> @@ -499,10 +499,18 @@ static void hvs_close_timeout(struct work_struct *work)
>  
>  	sock_hold(sk);
>  	lock_sock(sk);
> -	if (!sock_flag(sk, SOCK_DONE))
> +	if (!sock_flag(sk, SOCK_DONE)) {
>  		hvs_do_close_lock_held(vsk, false);
> -
> -	vsk->close_work_scheduled = false;
> +	} else if (vsk->close_work_scheduled) {
> +		/* A concurrent rescind (hvs_close_connection) set SOCK_DONE but
> +		 * could not cancel this already-running work, so it left the
> +		 * scheduling reference and vsock_remove_sock() to us.  Finish
> +		 * the cleanup to avoid leaking the socket and its table entry.
> +		 */
> +		vsk->close_work_scheduled = false;
> +		vsock_remove_sock(vsk);
> +		sock_put(sk);
> +	}
>  	release_sock(sk);
>  	sock_put(sk);
>  }

[Severity: High]
This is a pre-existing issue and not introduced by this patch, but does the
same struct sock leak still exist in virtio_transport_common.c, which uses
the same vsk->close_work and vsk->close_work_scheduled fields from
include/net/af_vsock.h?

virtio_transport_close_timeout() still has the pattern this hunk replaces:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_close_timeout() {
	sock_hold(sk);
	lock_sock(sk);

	if (!sock_flag(sk, SOCK_DONE)) {
		(void)virtio_transport_reset(vsk, NULL);

		virtio_transport_do_close(vsk, false);
	}

	vsk->close_work_scheduled = false;

	release_sock(sk);
	sock_put(sk);
}

and the cancel-failure path is the same one described in the changelog:

net/vmw_vsock/virtio_transport_common.c:virtio_transport_cancel_close_work() {
	if (vsk->close_work_scheduled &&
	    (!cancel_timeout || cancel_delayed_work(&vsk->close_work))) {
		vsk->close_work_scheduled = false;

		virtio_transport_remove_sock(vsk);

		/* Release refcnt obtained when we scheduled the timeout */
		sock_put(sk);
	}
}

The racing event there is a peer packet rather than a host rescind:

virtio_transport_recv_pkt()
  lock_sock()
  virtio_transport_recv_connected()   /* VIRTIO_VSOCK_OP_RST */
    virtio_transport_do_close(vsk, true)
      virtio_transport_cancel_close_work(vsk, true)

If virtio_transport_close_timeout() has already been dequeued and is
blocked on lock_sock(), cancel_delayed_work() returns false, so
close_work_scheduled stays true, the scheduling sock_put() is skipped and
virtio_transport_remove_sock() is not called, while SOCK_DONE is set. The
work then resumes, skips the !sock_flag(sk, SOCK_DONE) branch, clears
close_work_scheduled and drops only its own local reference.

Does that leak the struct sock and its struct virtio_vsock_sock, leave the
socket in the bound/connected tables, and leave vvs->rx_queue unpurged? The
recovery in virtio_transport_destruct() -> virtio_transport_cancel_close_
work(vsk, true) would not run because sk_refcnt never reaches zero, and
would be a no-op anyway once the flag has been cleared.

Since both transports share close_work and close_work_scheduled, would it
make sense to put this cleanup rule in code common to both rather than only
in hyperv_transport.c, so the two users do not implement different
ownership protocols for the same field?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917220213.56102-1-bartlomiej.dmitruk%40isec.pl
