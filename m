Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203944;
	b=eaN1YqccSLDxkxZpGghRfMqBoZ9dN9MJxdgZUzdcyM5YfL9ZllSdYbW8f1/Y52K09sLt
	 Zs9Cf8dU6b0fjYh0jcOaztkXZUiEEC9Fj5hSKSSIE/ei54KajpAgJFbuueuEA7Mbl4V5V
	 t7xksFOQyyjxr554nkFrqW4tqU+qDaknndfrEycU8oRmG8A1qbj5hGPWw5MVgslV1caeY
	 AJ6XMeeivGapKKYPAT7hxj0XInQYXFWCUM444RKSrXqbnxp0X4dlKEYLmcIYZCtdlcrlI
	 btSYtA3HqdM09Xkunt89I0IBSGQhuRBopmpdgF0iXA5Ba/WZ/Ak8V6WOfrfHp33v4gA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203944;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=m0w+H9ri4/QR5iS0jHJ5XKqn/LJH5Dn3U0BXDvYkf6o=;
	b=J9kKxVMykcn7Pd/Zoo5iZZjXu6DUAYyg61rAiZG81Zocnidz/XztV+fSqp+i+hboXW/f
	 d/rp6cZSPmZOWlMRjkcQtnLoIi9c0m6zGMihaFjDwJGjgZSvGVwrk0m2aJJjN3xbhnGtn
	 8kRtE5X+LlrAhk2fArSHMu9AmfE9mpDS+vLSfEXvfUSWKQPZJs5/HLYAtx1tKjFh3WfLT
	 AGCWrk2VUy+b8bJdD+yvNSSlkeyjhft2F5lWn+jYhZD0izFIYJk5Zu4yfN1F3Vq7Tm33z
	 Bo5iM0t3bgT+cvfOuV/KSMnFJlzwEBOGle6RMGbioskaDf0RLq8DbNbH1hGv8/xWGFw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlpIHqX8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D385606A31F;
	Wed, 28 Oct 2026 16:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LlpIHqX8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7882B1F01825;
	Wed, 28 Oct 2026 16:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203943;
	bh=m0w+H9ri4/QR5iS0jHJ5XKqn/LJH5Dn3U0BXDvYkf6o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LlpIHqX8epKl6KT7s0ykAhklS936gT5waqvqbDERoIHCigfRZVJswLvecz9uMAcBo
	 cH5JGBUfqZ1Dry+CNlE+2c3Sh1OmUi69syD2XadSM0tovWXf18CpQvPwxfxKKea5TL
	 uxvyze90UfGUkba42Mp+Aqa6h96fkzdYkzlWphuWFZ5MjTgex3qReSqi3VAfQf7dFj
	 o5bTsuYIM7vv7el2MTE0qxGjEgs6RB+1F/dn9blbAmQPyOXwfbXk0rgv94YU5GCL0I
	 +9iMYq0TIJRfQlkB7e5469Xc3fUzcv9Xa8JPBp56lESR91YqddlIpFi8nZ5j0wBLdg
	 P66CxctDN7mpg==
Message-ID: <sashiko-outbox-188128@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 8/8] vsock: add datagram tests to vsock_test
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sergio Lopez" <slp@redhat.com>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, bpf@vger.kernel.org, linux-hyperv@vger.kernel.org, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261028-vsock-dgram-support-v1-8-e457cf7cee78@sinrega.org>
References: <20261028-vsock-dgram-support-v1-0-e457cf7cee78@sinrega.org>
 <20261028-vsock-dgram-support-v1-8-e457cf7cee78@sinrega.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 16:12:23 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] vsock/test: missing opening brace in test_cases[] breaks compilation
- [Low] vsock/test: outdated datagram test IDs documented in README
--

commit f2fbe86b3992eecc82537eceffe22f137e4055d3
Author: Sergio Lopez <slp@redhat.com>

vsock: add datagram tests to vsock_test

This commit adds datagram test cases to vsock_test covering local semantics,
host/guest transfers, routing, and queue accounting, along with capability
checks and documentation updates.

> diff --git a/tools/testing/vsock/README b/tools/testing/vsock/README
> index 680ce666ceb56..be34b032ef135 100644
> --- a/tools/testing/vsock/README
> +++ b/tools/testing/vsock/README

[ ... ]

> @@ -51,6 +51,25 @@ suite run, e.g.
> =20
>  For more information see Documentation/dev-tools/kmemleak.rst.
> =20
> +Datagram tests
> +--------------
> +vsock_test includes datagram cases in the client/server runs above. Unsu=
pported
> +cases print a skip reason.
> +
> +Virtio/vhost datagrams require kernel support on both sides and a VMM th=
at
> +negotiates VIRTIO_VSOCK_F_DGRAM. Load vsock_loopback on both host and gu=
est for
> +the local cases, and make /dev/vsock available. VMCI's dedicated datagram
> +transport takes priority when loaded, causing virtio/vhost cases to skip.
> +
> +Run only the local datagram cases without a peer or TCP control connecti=
on:
> +
> +  ./vsock_test --local
> +
> +Use --list and --pick <test_id> to select individual cases. The BPF admi=
ssion
> +test (48, requiring BPF privileges) and nested routing test (49, requiri=
ng both
> +virtio and vhost transports) need explicit selection. The VMCI queue-len=
gth
> +test (53) runs only with VMCI.

[Severity: Low]
Are these test IDs off by 3?

In tools/testing/vsock/vsock_test.c, there are 44 existing entries in
test_cases[] before the new datagram tests (indices 0 through 43, ending wi=
th
the three SO_INQ test cases). That places test_dgram_sockmap() at index 51,
test_dgram_nested_source() at index 52, and test_dgram_vmci_inq() at index =
56,
while indices 48, 49, and 53 correspond to test_dgram_connect(),
test_dgram_source_cid(), and test_dgram_sizes().

> diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock=
_test.c
> index 10b9074fb87f7..f4ff6a42a9cb1 100644
> --- a/tools/testing/vsock/vsock_test.c
> +++ b/tools/testing/vsock/vsock_test.c

[ ... ]

> @@ -2911,6 +2912,95 @@ static struct test_case test_cases[] =3D {
>  	{
>  		.name =3D "SO_INQ option validation",
>  		.run_client =3D test_so_inq_validation_client,
> +	},
> +		.name =3D "SOCK_DGRAM autobind, duplicate bind and wildcard destinatio=
n",
> +		.run_client =3D test_dgram_bind,
> +		.run_server =3D test_dgram_bind,
> +		.check =3D vsock_dgram_check_local,
> +		.local =3D true,
>  	},

[Severity: Low]
Is there a missing opening brace before the first SOCK_DGRAM entry in
test_cases[]? Without it, compiling tools/testing/vsock/vsock_test.c fails
with a syntax error because .name is parsed at the top level of the array
initializer and the following closing brace terminates test_cases[] early.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-vsock-dgra=
m-support-v1-0-e457cf7cee78@sinrega.org?part=3D8
