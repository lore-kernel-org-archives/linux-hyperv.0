Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9F46C4C5;
	Thu,  3 Sep 2026 09:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788426653; cv=none; b=q0pia8nEJ7um7yeQtGO1sjIpSnJNDXv1HnUzPRPCmnjXaJ4M2Y/vdTiyDom/bKQiVvDBboAohtgdwh95jtszAO47i4MT+mS34i1b6fCqWQ3k/RSTG/h795XVKnqpbB1O5SQI0wADaCt9lfOjTU/DaJ8F1LRPU74BvjbLQuSMwuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788426653; c=relaxed/simple;
	bh=cx1axVRz7cdn8WI+nJ8VQQmUx0Er/eDQmSJDpr1pDiw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o1xjuiUPI//DCAVI2/gyEPdahGvQkEHTAHciMrj/6ULYRjYGXBRwukSJnpzu78xpGrNyJm8GQJYO8l0aA5qi44+bnP+cvDY4y+5khJuPpcyPk56UVZRzOaLZd587CW9Cnu1pwTr9H6mpHQsRP1I5gTpcfWg0amEeMRLF2sQfQNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kuhcU9kk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuhcU9kk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B731F000E9;
	Thu,  3 Sep 2026 09:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788426650;
	bh=yK8wvrGSHpZjkUMfwjPfTJBNF4H8Z42Q5sZ5A9sNFkA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kuhcU9kkkhsCH60W93JxL+ToA4RQQEwX52TMV2pJeEiAMpq0i8WdMZHD4Sd5httfK
	 MEi6ejHLEYN4MSl8uZWird/h36hjJ9SjOdJhDMCGO/JuLLGjtBsgIucCrh8ACWEme9
	 tH0DvRIXpzfFx14swQguyQ9s9wDzTzN/TNcEWLgKpZfFcFeMRifVLXMmQqAZEG93kp
	 0jVjFJXfOXf1dsyXn1aaiSTl2ipoMoasl1GWtzabaOW91pBDQbAZQqlIZcImy3iHds
	 1CLXKBRUvKcwZi0VYn8mcrYM5NBhZvO24SZ5ZiR7eF/LdYnvfIZpUC6r/mVG7KRWW1
	 dyubeIbrhBCXA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2] net: mana: remove unreachable dead code in
 mana_bpf()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muhammad Falak R Wani" <falakreyaz@gmail.com>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <3d8b67307df6fefdc18743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com>
References: <3d8b67307df6fefdc18743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 09:10:50 +0000
Message-Id: <20260903091050.84B731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Failure to restore `apc->bpf_prog` on error path causes Use-After-=
Free.
--

commit 26086af444af1d715f516a007146a7dd00ce97c6
Author: Muhammad Falak R Wani <falakreyaz@gmail.com>

net: mana: remove unreachable dead code in mana_bpf()

This commit cleans up mana_bpf() by removing an unreachable return statement
after a switch statement that already unconditionally returns.

Link: https://lore.kernel.org/netdev/DKWZHHOFA1F3.1EL2DMFNGMP0Y@gmail.com/

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_bpf.c b/drivers/net=
/ethernet/microsoft/mana/mana_bpf.c
> index 53308e139cbe9..70bb8c9dc3413 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_bpf.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_bpf.c
[ ... ]

This is a pre-existing issue, but while reviewing this patch I noticed a
potential problem in the adjacent mana_xdp_set() function when it handles
allocation failures:

drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_set() {
        ...
        apc->bpf_prog =3D prog;

        if (apc->port_is_up) {
                ...
                err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queu=
es);
                if (err) {
                        NL_SET_ERR_MSG_MOD(extack,
                                           "XDP: Insufficient memory for tx=
/rx re-config");
                        return err;
                }
        ...
}

[Severity: High]
Does this error path leave a dangling pointer in apc->bpf_prog?

It appears that if mana_pre_alloc_rxbufs() fails, the function returns
immediately without restoring apc->bpf_prog =3D old_prog. The generic XDP c=
aller
will see the failure, assume the driver rejected the program, and drop its =
BPF
program reference.

Could this leave a freed pointer in apc->bpf_prog that might be dereferenced
when the interface is later restarted or accessed?

> @@ -253,7 +253,6 @@ static int mana_xdp_set(struct net_device *ndev, stru=
ct bpf_prog *prog,
>  int mana_bpf(struct net_device *ndev, struct netdev_bpf *bpf)
>  {
>  	struct netlink_ext_ack *extack =3D bpf->extack;
> -	int ret;
> =20
>  	switch (bpf->command) {
>  	case XDP_SETUP_PROG:
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/3d8b67307df6fefdc18=
743274cef3de4fca0e7de.1788339612.git.falakreyaz@gmail.com?part=3D1
