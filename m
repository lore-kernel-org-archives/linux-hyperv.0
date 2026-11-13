Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592272;
	b=Yzy/+wWWoZ/kqQ/VR2eLGgRNmn/GAr4TbpbL5gXQ7P/BSs3PtvZDa7Lrg8g9rQf8zFjb
	 /DCo5BSfnzn4eaDQGh+H4LtCoOw0nQB5LISBr9og5iU+e6fxD9scmyN/p3dn+gDinKmqe
	 i6K8ah8y9aECnlC92nCJGKnCgUbW/NbKFcPtb2ACQ1NqbBMZs68xGsB9I8fNC9yAHMZfa
	 ia56suSS0NlNlxoQ5iaxVc5kV8HpMKwvH+UGSr0Z2pTj72KNeq0pR+RuiKZgVLis6g4q4
	 A3t256uBnIfiGIw5VfhQKi8IwMXHYF1Vn8VQ5EXxpR47J2K1dQcqY6AM05He5d/oPTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592272;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=kp6LJYO7FBDq9cnPH8XB/SVlMIwHKZGH99cpSp4Ussw=;
	b=xlOpaHuKUlUNM/KQqZfddMIrDEHVsVBbgsfL5lFSmVhz37lwZxB8fYoW7X3rxU3RVDQk
	 QWDjLWiQv8rUDoH9wjKXuQdiH2+5LMd7JQLDoQaP3hwtp6aQOdJbbjuCwekUe6ijY4SH3
	 8qfMQzeS9Q1/a8hvOnGBCYB9q4vltXgwCPw5Gtge8YxD0k+PXDWABbJ3yGkD8gD5BfF4B
	 cu+XV2EhWmSFcGm8W2w2OV0NXAJePEFsdsB1R/MlQc1j/Xt2wGSMe4RKeyt74mpVZ0906
	 uhHGFhwYUt4tvRlqJEKEx6iLnsEAMkZyUHhbwdAZbxw1+6wSoV7zuqKVEU5Re7/xuyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSeDKEr3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF324606A8BC;
	Fri, 13 Nov 2026 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YSeDKEr3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468EA1F000C4;
	Fri, 13 Nov 2026 17:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794592272;
	bh=kp6LJYO7FBDq9cnPH8XB/SVlMIwHKZGH99cpSp4Ussw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YSeDKEr3kFtMIpdz7r3PWKfVNvQX6p0qQiyINauVJ5retsHiYWHGjiufaCBVwu7Ny
	 fNYIyA4DNmrFJGE3+YsgKar7WWSpDsu+W14mSyYobg2Tg3qnGrQZXbaX5ZR/XwbZfH
	 AV3jfmYpNFTQsv2btO8jUeHZ0iWcM8FF13mO2owXMTlvM5TobEflTPQkB0vg2Z0jaB
	 OqncOFBAgQuHy1TiZFMIhqV0t0MyM6xVuKyIhwcmRCkGVYCScQ3Z7W960mL6IdveMJ
	 PJIY/Ybx3IIXyZj0M+zxvPblRYD8XPgsVcihFNIBAjHGkkDX0LJknkOtzmiaXucGox
	 OapjjdKphZbZA==
Message-ID: <sashiko-outbox-213365@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 8/8] vsock: add datagram tests to vsock_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v3-8-1523c8e9b27e@redhat.com>
References: <20261113-vsock-dgram-support-v3-0-1523c8e9b27e@redhat.com>
 <20261113-vsock-dgram-support-v3-8-1523c8e9b27e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 17:51:11 +0000
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
- [Medium] selftests/vsock: unguarded loopback SOCK_SEQPACKET connect in
  local netns
- [Low] vsock/test: incomplete DGRAM_VMCI probe in dgram_capabilities()
--

commit 75f8685914783d3ed99f76000f4d13a1f1c04ea3
Author: Sergio Lopez <slp@redhat.com>

vsock: add datagram tests to vsock_test

This commit adds AF_VSOCK datagram tests to vsock_test covering local
semantics, peer transfers, routing, queue accounting, and capability-based
skips, along with a --local mode for running local test cases standalone.

> diff --git a/tools/testing/vsock/vsock_test_dgram.c b/tools/testing/vsock=
/vsock_test_dgram.c
> new file mode 100644
> index 0000000000000..4b45dcf2a15cc
> --- /dev/null
> +++ b/tools/testing/vsock/vsock_test_dgram.c
> @@ -0,0 +1,1061 @@

[ ... ]

> +static unsigned int dgram_capabilities(const struct test_opts *opts,
> +				       unsigned int needs)
> +{
> +	unsigned int caps =3D DGRAM_SOCKET;
> +	struct sockaddr_vm peer;
> +	int fd, local_fd;
> +
> +	fd =3D socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
> +	if (fd < 0) {
> +		if (dgram_unavailable(errno))
> +			return 0;
> +		check(fd, "probe datagram socket");
> +	}
> +	/* VMCI may own the socket while a directional transport serves peers.
> +	 * A nested guest can have both virtio and vhost registered. Probe the
> +	 * requested direction so vhost registration cannot mask a virtio device
> +	 * that did not negotiate datagrams.
> +	 */
> +	if (!access("/sys/module/vmw_vsock_vmci_transport", F_OK))
> +		caps |=3D DGRAM_VMCI;

[Severity: Low]
Does checking only for /sys/module/vmw_vsock_vmci_transport leave
test_dgram_vmci_inq() unskipped when VMCI cannot route datagrams to
itself?

When vmw_vsock_vmci_transport is loaded without vsock_loopback, running in
a local-mode vsock network namespace causes vmci_transport_dgram_allow()
to return false and sendto() in test_dgram_vmci_inq() to fail with EINVAL
(or EADDRNOTAVAIL when VMCI has no active context ID), aborting the test
run instead of skipping.

[ ... ]

> +	if (needs & DGRAM_LOOPBACK) {
> +		/* Binding a stream socket to CID_LOCAL probes registration of
> +		 * the loopback transport without sending a packet to the host.
> +		 */
> +		local_fd =3D vsock_bind_try(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, SOCK_ST=
REAM);
> +		if (local_fd >=3D 0) {
> +			caps |=3D DGRAM_LOOPBACK;
> +			close(local_fd);
> +		} else if (errno !=3D EADDRNOTAVAIL) {
> +			check(local_fd, "probe loopback transport");
> +		}
> +	}
> +	return caps;
> +}

[ ... ]

> +void test_dgram_bound_lookup(const struct test_opts *opts)
> +{
> +	const int types[] =3D { SOCK_STREAM, SOCK_SEQPACKET };
> +	unsigned int cid =3D local_cid();
> +	size_t i;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(types); i++) {
> +		int listener =3D vsock_bind(VMADDR_CID_ANY, VMADDR_PORT_ANY, types[i]);
> +		int stream =3D vsock_bind(VMADDR_CID_LOCAL, VMADDR_PORT_ANY, types[i]);
> +		struct sockaddr_vm listen_addr =3D local_address(listener);
> +		struct sockaddr_vm src =3D sock_name(stream, false);
> +		struct sockaddr_vm dest;
> +		int accepted, tx, rx;
> +		char byte;
> +
> +		check(listen(listener, 1), "listen");
> +		if (vsock_connect_fd(stream, listen_addr.svm_cid, listen_addr.svm_port=
))
> +			fail("%s loopback connect: %s",
> +			     types[i] =3D=3D SOCK_STREAM ? "stream" : "seqpacket", strerror(e=
rrno));

[Severity: Medium]
Will the SOCK_SEQPACKET iteration in test_dgram_bound_lookup() and
test_dgram_port_space() fail with ESOCKTNOSUPPORT when vsock_test runs in
a local-mode vsock network namespace?

dgram_capabilities() probes DGRAM_LOOPBACK with SOCK_STREAM, which is
allowed in both global and local namespace modes, whereas
vsock_loopback_seqpacket_allow() rejects SOCK_SEQPACKET when the socket is
not in global mode:

net/vmw_vsock/vsock_loopback.c:vsock_loopback_seqpacket_allow() {
	return vsock_net_mode_global(vsk);
}

As a result, running vsock_test in a local-mode namespace (such as the
local-namespace cases in tools/testing/selftests/vsock/vmtest.sh) will
pass the capability check and then abort in test_dgram_bound_lookup() and
test_dgram_port_space() when connecting the SOCK_SEQPACKET socket to
VMADDR_CID_LOCAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v3-0-1523c8e9b27e@redhat.com?part=3D8
