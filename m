Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 684CF345ED2;
	Sat, 19 Sep 2026 12:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789821824; cv=none; b=gMD3lcmTMUtstsRAtRsWhUQDbwkONKLGNfQszDG5Xu8r9r1aqb2cgpfaXbomE5EcsKRHi2LE/9+Sk2O2eUwmSnCler0/at9J0ALKkpABpIEcmyL5WbbblqfdF0VVabiks+DpQ1ISPYhe78UN0EDpTCDsFAC/JfURBXliC56vrng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789821824; c=relaxed/simple;
	bh=BnH3aoLxRKIE3Ma0+9/j5SzrGY8ao/QGld34xRrwFvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K4kmRgC1Dqv7J/7/rwAf++8Ehi+ipRbnOU1xBUoUdZ+c1T+SG7tdGq/XOXSWHlN5az50thn7DFw9ZJgaXVE9kn8nVGHWVPcdsyZFVDYLInV86KR1B/cYUqTlRQKiQW7dwnmLQh5To9E0bDqrPRKEki061uxoXsxDojc2Oa8HJuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X1qpurOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X1qpurOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35AB1F000FF;
	Sat, 19 Sep 2026 12:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789821823;
	bh=BnH3aoLxRKIE3Ma0+9/j5SzrGY8ao/QGld34xRrwFvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X1qpurODU3izzhJK0zx18xi6Rwhqj89uhep9IdjVWlp3erJvMKk58YNuanBh/itAV
	 QCBVUeQwtFzzaK8eZZ7mD7v9YYFCVHiVk0nWy/7/DDhPCYrWddb/dxKo4lqz9O6Kna
	 H9YpfJxzBi4UzhUqKTT2gV9DfaSlxgE89XT39tACiSegryrYn49Z7eg+pkTwSHjmL8
	 atTTaqwzNQPXFw9be7VMcBfjKSQ8qki3VIii1PRCB2+jo3C7X4DcGnFSnqRQP0LRSS
	 HAfk3g6o0Rqx/3sLKqxl+ziDbn7F3bMUi0akuFvyqyapz0YlfCoUlW6HNesa/D1ff3
	 HQxYFu+QDKnzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] vsock/hv_sock: don't finish a connection on a socket
 being released
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QmFydMWCb21pZWogRG1pdHJ1aw==?= <bartlomiej.dmitruk@isec.pl>
Cc: "Eugenio Perez" <eperezma@redhat.com>, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, virtualization@lists.linux.dev
In-Reply-To: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
References: <20260919123128.28868-1-bartlomiej.dmitruk@isec.pl>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Sep 2026 12:43:42 +0000
Message-Id: <20260919124342.B35AB1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> hvs_open_connection() only checks sk->sk_state (TCP_LISTEN for a
> host-initiated connection, TCP_SYN_SENT for a guest-initiated one) before
> proceeding. __vsock_release() sets sk->sk_shutdown =3D SHUTDOWN_MASK and,=
 for
> a listener, flushes the accept queue, while leaving sk_state unchanged. A
> VMBUS channel offer that races close() therefore still passes the state
> check and either enqueues a child onto the already-flushed accept queue
> (conn_from_host) or completes a connection on a socket being torn down
> (!conn_from_host); the socket and its VMBUS channel then leak.
>=20
> The virtio transport guards the listener case in
> virtio_transport_recv_listen(); hv_sock has no equivalent. Add a
> sk_shutdown =3D=3D SHUTDOWN_MASK check to the common path right after
> lock_sock(), so both the host- and guest-initiated paths bail out.
> hv_sock holds lock_sock(sk) across hvs_open_connection(), so the check is
> race-free.
>=20
> This was found by code inspection; I do not have Hyper-V hardware to test=
 on.
>=20
> Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual S=
ockets (AF_VSOCK)")
> Signed-off-by: Bart=C5=82omiej Dmitruk <bartlomiej.dmitruk@isec.pl>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919123128.2886=
8-1-bartlomiej.dmitruk@isec.pl?part=3D1

