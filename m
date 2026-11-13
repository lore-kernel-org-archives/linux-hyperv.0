Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794575641;
	b=B0yWFSgstqpQCvLuQ93hJS5m6mxdyec2fCfH7uUbWtgS44tsZrG8vSDDq+hFTU4AmN/v
	 u1T+0Esza5QWfNWd88qZWUK/BSAxqsVoEwxOzSLZLy4rDr4AKquW71Km/oBt/fmYqLjS5
	 hAlRjsbfz+D7y4Zsz7pIvj4niVYQnR0CdgYlx2zSGnPHf+GfJ8NMceF0MW1pLNVimNRmX
	 MtQX0HukkIHRmkjsje7U9Q30wTXTxfFtLf3wQZA5kq44EhAI9EOB4ykn4xBQimOqtt8D2
	 GT/94g8Bz6paAxRlILJcldjfyhqjJTeuHyCrajYG8UUUwSIXu/Pd7o3RLdnFj/UOGTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794575641;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=YastPo/MxpHn32hI4mUdatvURBdW1oCQ5/676MSOTh4=;
	b=suABltElV7E2K0uFki74aYobeEJr70jLh1T3QrQkKzTzbM2zJX6kFjd6buQ+PQhGBYqy
	 RaCnr39fyJyvRbAv6iQ/Cus0+bEO6XE5WyMAD09xhrHe+aLzq64BBtZDmQUmrY0IEq/19
	 jiTB/k4v9Vkt5pJD2FX4lUv8yjgsHHqgVjuY962+V72ftK9haK84Oh1UqbAehNalkRFkg
	 LLJ3FKoiFDl7oEJrEwZp3AhwpyzxAaTi3Mw5wIc+gGtOKDdHS5c3F9LW2XFqlE0YtEuJn
	 EE8JC47dVwdLubA3zyVqH1BENUR2NOOMbTpwCjyfrAHpA3JLYEHvq5L8fqTguOVZEJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNPwakQ7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534A6606A885;
	Fri, 13 Nov 2026 13:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cNPwakQ7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A805B1F000C4;
	Fri, 13 Nov 2026 13:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794575641;
	bh=YastPo/MxpHn32hI4mUdatvURBdW1oCQ5/676MSOTh4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cNPwakQ73SG0aUnltDM+31RJGAK+A8otNZ5y06utarNyFgV+FjZvtxMon7bjfbQEG
	 W8dE50CltWZDxegPvK30tydF7oSORXLUOuv3fC+4r17W/hfkT4tkJW5GDGC4qWs8Gu
	 qgiFZebHKN3+RAGfQph14LeIi93y4UtJZgUe0vdz2xJSsRxMtOejfucKIIvmVvBzm3
	 465flGhPcfDSuEQCR+dx6ZLFjJ/3FLU3Cwl9cYnus2CZ5RLdWsmtl/ejY4093QMuMu
	 /dm9F10l+HqSPfxqCSMIYBR+SS8vryr2LtW4LZH+hhuWbbZr+OKfI9Yro+50EHeVuw
	 5wEqCu1ilTbGQ==
Message-ID: <sashiko-outbox-212831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 8/8] vsock: add datagram tests to vsock_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261113-vsock-dgram-support-v2-8-bacfc85b71ce@redhat.com>
References: <20261113-vsock-dgram-support-v2-0-bacfc85b71ce@redhat.com>
 <20261113-vsock-dgram-support-v2-8-bacfc85b71ce@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 13:14:00 +0000
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
- [Medium] vsock_test: local tests calling local_cid() fail without
  virtio or vhost
- [Medium] vsock_test: false-positive DGRAM_VIRTIO and DGRAM_PEER in
  dgram_capabilities()
- [Medium] vsock_test: VMCI coexistence fails in test_dgram_bind() and
  local CID bind
--

commit 004d4f33594e6af5b36eeee37f6e14f8e43323f5
Author: Sergio Lopez <slp@redhat.com>

vsock: add datagram tests to vsock_test

This commit adds AF_VSOCK datagram tests to vsock_test covering local
loopback behavior, host/guest transfers, routing, and queue accounting,
along with a --local execution mode and capability-based test skipping.

> diff --git a/tools/testing/vsock/vsock_test_dgram.c b/tools/testing/vsock=
/vsock_test_dgram.c
> new file mode 100644
> index 0000000000000..78bdf015a352f
> --- /dev/null
> +++ b/tools/testing/vsock/vsock_test_dgram.c
[ ... ]
> +static unsigned int local_cid(void)
> +{
> +	unsigned int cid;
> +	int fd;
> +
> +	fd =3D open("/dev/vsock", O_RDONLY | O_CLOEXEC);
> +	check(fd, "open /dev/vsock");
> +	check(ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid), "get local CID");
> +	close(fd);
> +	if (cid =3D=3D VMADDR_CID_ANY || cid <=3D VMADDR_CID_LOCAL)
> +		fail("a virtio or vhost transport is required (local CID %u)", cid);
> +	return cid;
> +}

[Severity: Medium]
Will test_dgram_source_cid(), test_dgram_bound_lookup(), and
test_dgram_connected_cid() abort the test run instead of skipping when
vsock_loopback is loaded without a virtio or vhost transport?

Those three tests are guarded only by vsock_dgram_check_local(), which
succeeds whenever vsock_loopback is registered, but they unconditionally
call local_cid().  Without a guest-to-host or host-to-guest transport,
vsock_dev_do_ioctl() falls back to transport_local and returns a local cid
of 1, causing local_cid() to call fail().

[ ... ]

> +static unsigned int dgram_capabilities(const struct test_opts *opts,
> +				       unsigned int needs)
> +{
> +	unsigned int caps =3D DGRAM_SOCKET;
> +	struct sockaddr_vm peer;
> +	bool vmci;
> +	int fd, local_fd;
> +
> +	fd =3D socket(AF_VSOCK, SOCK_DGRAM | SOCK_NONBLOCK | SOCK_CLOEXEC, 0);
> +	if (fd < 0) {
> +		if (dgram_unavailable(errno))
> +			return 0;
> +		check(fd, "probe datagram socket");
> +	}
> +	/* VMCI may own the socket while a directional transport serves peers.
> +	 * Check the drivers independently; connect() below probes the peer rou=
te.
> +	 */
> +	vmci =3D !access("/sys/module/vmw_vsock_vmci_transport", F_OK);
> +	if (vmci)
> +		caps |=3D DGRAM_VMCI;
> +	if (!vmci ||
> +	    !access("/sys/bus/virtio/drivers/vmw_vsock_virtio_transport", F_OK)=
 ||
> +	    !access("/sys/class/misc/vhost-vsock", F_OK))
> +		caps |=3D DGRAM_VIRTIO;
> +
> +	if ((needs & DGRAM_PEER) && (caps & DGRAM_VIRTIO)) {
> +		bind_fd(fd, opts->bind_cid, VMADDR_PORT_ANY);
> +		peer =3D address(opts->peer_cid, opts->peer_port);
> +		if (opts->to_host)
> +			peer.svm_flags =3D VMADDR_FLAG_TO_HOST;
> +		if (!connect(fd, (struct sockaddr *)&peer, sizeof(peer)))
> +			caps |=3D DGRAM_PEER;
> +		else if (!dgram_unavailable(errno) && errno !=3D EINVAL)
> +			check(-1, "probe peer datagram route");
> +	}
> +	close(fd);

[Severity: Medium]
Can dgram_capabilities() report false-positive virtio and peer datagram
support when either vmw_vsock_vmci_transport is absent or the directional
transport did not negotiate datagrams?

When vmw_vsock_vmci_transport is not loaded, !vmci short-circuits the sysfs
checks and sets the virtio capability even if only vsock_loopback is
loaded; if opts->peer_cid is 2 without a guest-to-host transport,
vsock_use_local_transport() routes connect() to loopback and also sets the
peer capability.  Conversely, when vmw_vsock_vmci_transport is loaded
alongside virtio or vhost without datagram support negotiated,
vsock_dgram_get_transport() falls back to vmci_transport during connect(),
so connect() succeeds and peer tests run and fail instead of skipping.

[ ... ]

> +void test_dgram_bind(const struct test_opts *opts)
> +{
> +	int rx =3D bound_socket(VMADDR_CID_ANY);
> +	struct sockaddr_vm dest =3D local_address(rx);
> +	int tx =3D dgram_socket();
> +	int other =3D dgram_socket();
> +	struct sockaddr_vm src;
> +	char byte;
> +
> +	dest.svm_cid =3D VMADDR_CID_ANY;
> +	expect_error(bind(other, (struct sockaddr *)&dest, sizeof(dest)),
> +		     EADDRINUSE, "duplicate bind");
> +	send_packet(tx, &dest, "A", 1);
> +	src =3D recv_packet(rx, &byte, 1, 0, 1, false);
> +	if (byte !=3D 'A' || src.svm_port !=3D sock_name(tx, false).svm_port ||
> +	    src.svm_cid !=3D VMADDR_CID_LOCAL || src.svm_port < 1024)
> +		fail("autobind or wildcard destination returned an invalid source");
[ ... ]
> +static void check_connected_local_cid(unsigned int peer_cid,
> +				      unsigned int stray_cid, bool shutdown_write)
> +{
> +	int rx =3D bound_socket(VMADDR_CID_ANY);
> +	int allowed =3D bound_socket(peer_cid);
> +	int stray =3D dgram_socket();
> +	struct sockaddr_vm peer =3D sock_name(allowed, false);
> +	struct sockaddr_vm dest =3D local_address(rx);
> +	struct sockaddr_vm src;
> +	char byte;
> +
> +	bind_fd(stray, stray_cid, peer.svm_port);

[Severity: Medium]
Do test_dgram_bind() and check_connected_local_cid() fail when
vmw_vsock_vmci_transport is loaded alongside vsock_loopback?

When vmci_transport owns the datagram socket, vsock_dgram_sendmsg()
resolves a wildcard destination cid via transport->get_local_cid()
(vmci_get_context_id()) instead of 1, so test_dgram_bind() failseither in
send_packet() or on the src.svm_cid check.  In check_connected_local_cid(),
vmci_transport_dgram_bind() passes flags =3D 0 to dg_create_handle() for any
non-wildcard cid, ignoring addr->svm_cid and registering both allowed and
stray under (vmci_get_context_id(), peer.svm_port), so binding stray fails
with -EADDRINUSE.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113-vsock-dgra=
m-support-v2-0-bacfc85b71ce@redhat.com?part=3D8
