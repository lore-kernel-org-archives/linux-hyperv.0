Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795524454;
	b=RlcMkpncTO+M0gRmlmAbpSX8HoyQVXwvf1zerytD7W2GgtXyx4e/DU+qvPjqacZiNVpD
	 4DbBWc9PINoOl1ejISuFbKiZi9ho01Dzz5qUOvIlMAGWaqqjWIYhuruhESbmz/i3d5IUk
	 UqZogKj+xN5jmqb6n/TU6ekXrd6qTjjJy5czNr5nmLe+ebdP4jCu1pT4sUKUkOAP7qAhW
	 TZVuTkC6cuitWRrKU79AuBNlrw1Zsf7KBxfWK0+mQR07jQYPoyn7UtLHWS7axg9U8lUSH
	 UeG4w9R7b5ov4Rf4vH37Q/cxHS/BdCrbqA+PQtop/TIkPHexc9Tbr+RSGRGK7GtNI4Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795524454;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ro/RH43C78Nv0CR/7XnRdlSOTeJqQRr+VavPu3YBWK4=;
	b=1Jy4RW6uI74IFMKZDWRY2AaUazDTncwqLWohDfDQxPauIs6ee3v7YSQ8x5TXspCZQtlb
	 a4Ie8wSEmDOsj2ShvMGMB6XUpq1PTHOgHy5PNY0mvtwXoGV6peM23vHtUTAS98x6fQsdW
	 /Z706OhQTOJ7LGb60R9POQiuBeOeuyRbYQXiOKWCUDfPyVh+zMPZ22IcNCkV666WVZJmq
	 pR+F/fkOH4s9+XixWIj96J15Fh4JKujGUATdSrY49OAVStMlt+jxeI3EnycdndKxnyedQ
	 I5MkqsoxaXczRqnPU8AxOzRzZ7Be0ouZdmmbpz5qIWpiMvEUvDEjYCyIeRKEbB5d+Pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxfeyXLD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BCB606A31E;
	Tue, 24 Nov 2026 12:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mxfeyXLD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D7C1F000CA;
	Tue, 24 Nov 2026 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795524453;
	bh=ro/RH43C78Nv0CR/7XnRdlSOTeJqQRr+VavPu3YBWK4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mxfeyXLD1gPs4UQR8oTQj3OkLshj7HZiQUBU45TqVI28lk9JhOxpgQq7BDQaFClJV
	 hkpfcliDjY+qoVOgqamRxWmXAaYN1feznIRPtzOHCK0o8k9EOsmt1GOMiFoS3AICN/
	 vWK93aucLOFcdfR/CAu9armJTVyRUwysQM8vj/qVLPLcnhh4o9iSzjVbPW49uGBcjZ
	 UD+0CNAV1M3PspaMlA9puxg3BJUt3qaeGmL2Y9KDnT/tUxcGjyhbeEWvh3ZMamRP0w
	 e1KZ7cCtD9x0brzVfrQ5mdPrIoInMVaV6bpYftG/0yF/drjSzzNAehBcbi6IPMJZ83
	 EdfRrfBiSkm0A==
Message-ID: <sashiko-outbox-231174@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v4 8/8] vsock: add datagram tests to vsock_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261124-vsock-dgram-support-v4-8-3607484e85e8@redhat.com>
References: <20261124-vsock-dgram-support-v4-0-3607484e85e8@redhat.com>
 <20261124-vsock-dgram-support-v4-8-3607484e85e8@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 12:47:32 +0000
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
- [Medium] vsock_test: vsock_dgram_check_vmci_host() skips when
  vhost_vsock is unloaded
- [Medium] vsock_test: local CID tests fail when VMCI coexists with
  vhost and loopback
--

commit 792ed67e2ec454b7d9e33e144a3b395a0eb9843c
Author: Sergio Lopez <slp@redhat.com>

vsock: add datagram tests to vsock_test

This commit adds SOCK_DGRAM test cases to vsock_test covering local
loopback semantics, host/guest transfers, transport routing, and queue
accounting, along with capability-based skip checks and a --local mode.

> diff --git a/tools/testing/vsock/vsock_test_dgram.c b/tools/testing/vsock=
/vsock_test_dgram.c
> new file mode 100644
> index 0000000000000..16c3a6e59f792
> --- /dev/null
> +++ b/tools/testing/vsock/vsock_test_dgram.c

[ ... ]

> +static bool usable_local_cid(void)
> +{
> +	unsigned int cid;
> +	int fd, ret;
> +
> +	fd =3D open("/dev/vsock", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return false;
> +	ret =3D ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid);
> +	close(fd);
> +	return ret =3D=3D 0 && cid !=3D VMADDR_CID_ANY && cid > VMADDR_CID_LOCA=
L;
> +}

[Severity: Medium]
Can usable_local_cid() enable the local-CID loopback tests when VMCI owns
VMADDR_CID_HOST?

When vhost_vsock, vsock_loopback, and vmw_vsock_vmci_transport are loaded
together in a global namespace without a guest-to-host transport,
IOCTL_VM_SOCKETS_GET_LOCAL_CID returns VMADDR_CID_HOST (from vhost_vsock),
so vsock_dgram_check_local_cid() enables test_dgram_bound_lookup() and
test_dgram_connected_cid().  However, VMCI is the datagram owner in a
global namespace and its local CID is also VMADDR_CID_HOST, so
vsock_select_transport() routes packets addressed to VMADDR_CID_HOST
through vmci_transport instead of vsock_loopback.

As a result, test_dgram_bound_lookup() fails with EADDRNOTAVAIL when
sending from a socket bound to VMADDR_CID_LOCAL to one bound to
VMADDR_CID_HOST, and test_dgram_connected_cid() times out because the
receiver connects to VMADDR_CID_HOST (selecting vmci_transport) while the
packet arrives over loopback_transport and is dropped by
virtio_transport_dgram_source_allow().

[ ... ]

> +const char *vsock_dgram_check_vmci_host(const struct test_opts *opts)
> +{
> +	unsigned int caps =3D dgram_capabilities(opts, 0);
> +	unsigned int cid;
> +	char mode[16];
> +	FILE *file;
> +	int fd;
> +
> +	if (!(caps & DGRAM_SOCKET))
> +		return "datagrams unavailable locally";
> +	if (!(caps & DGRAM_VMCI_MODULE))
> +		return "requires VMCI datagram transport";
> +
> +	file =3D fopen("/proc/sys/net/vsock/ns_mode", "r");
> +	if (!file)
> +		return "requires a mounted vsock namespace sysctl";
> +	if (!fgets(mode, sizeof(mode), file)) {
> +		fclose(file);
> +		return "cannot read vsock namespace mode";
> +	}
> +	fclose(file);
> +	if (strncmp(mode, "global", 6))
> +		return "requires a global vsock namespace";
> +
> +	fd =3D open("/dev/vsock", O_RDONLY | O_CLOEXEC);
> +	if (fd < 0)
> +		return "cannot open /dev/vsock";
> +	if (ioctl(fd, IOCTL_VM_SOCKETS_GET_LOCAL_CID, &cid)) {
> +		close(fd);
> +		return "cannot read local CID";
> +	}
> +	close(fd);
> +	if (cid !=3D VMADDR_CID_HOST)
> +		return "requires VMCI host CID without an active guest CID";
> +	return NULL;
> +}

[Severity: Medium]
Does checking IOCTL_VM_SOCKETS_GET_LOCAL_CID =3D=3D VMADDR_CID_HOST skip
test_dgram_vmci_host_routes() whenever vhost_vsock is unloaded and no
/dev/vmci host context is active?

Loading vmw_vsock_vmci_transport only registers transport_dgram_fallback;
vmci_register_vsock_callback() registers transport_h2g only while
vmci_host_users() > 0.  Because vsock_dev_do_ioctl() queries only
transport_g2h, transport_h2g, and transport_local for
IOCTL_VM_SOCKETS_GET_LOCAL_CID (never transport_dgram_fallback), the ioctl
returns VMADDR_CID_ANY or VMADDR_CID_LOCAL when vhost_vsock is not loaded,
causing vsock_dgram_check_vmci_host() to skip the test even though VMCI
host datagram sockets can bind and send to VMADDR_CID_HOST.

Instead of requiring the ioctl to return VMADDR_CID_HOST, could this verify
that the ioctl does not return a guest CID (> VMADDR_CID_HOST) and probe
binding a datagram socket to VMADDR_CID_HOST?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124-vsock-dgra=
m-support-v4-0-3607484e85e8@redhat.com?part=3D8
