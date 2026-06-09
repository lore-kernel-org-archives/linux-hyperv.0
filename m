Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A36734E763
	for <linux-hyperv@vger.kernel.org>; Tue,  9 Jun 2026 10:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781000057; cv=none; b=b9LIVysM0hejlRzgwFYAhu7yHu4y5MTl/KrwMi1CZ7pSqmSnvh7Lb8Q0swtsz3VqxEzSwKHQ0cly3HPnW6VKHGN2JJdK2okw3a/AKpj0jMR7XBqkFR11qIx5M13UrNQKzbM887LyEYIL+naJ/veL+qshi+pf/RjVkbmJhlxnaw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781000057; c=relaxed/simple;
	bh=/r8LKojwVhuscD+kz5SuKfi+ztUDkW8UYQIXSb0Fa6Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IW4aXW3gkiL3LoeIgdwCfnJAJczhW7yIo4ifq4P81q+WiWWjS/GFI99NfSYMkWa27TrIZndyE9tUe88i/Wt+ZoktlLTPRAykNnf+i68uzIhMA7oT0IkTz+sz7GpqF+J+yjX3lVFFzgPayfnfz86CGmzCkE/lJVVjA88AwAEEwi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FnTNEfhI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FnTNEfhI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A4661F00898;
	Tue,  9 Jun 2026 10:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781000056;
	bh=+J6kBQd9FtTY31rUvUA1vlYHFwAntX1IqHLW4pSv2gs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FnTNEfhI42zZYw/nULVVn5TGUNuIF0SDiek6R2GQRBwUHS5DH1nrSShDGzg1TocMa
	 2DNRMlpzDhkEaKogrz4fw58TYMNqPNYbZGihvUoeyC5jOB9MYUPN8S5u+QTz1SuxYH
	 G9yUkelOWrEoHW+47iq7WTtgKiK9teN7F07KS1J0k0FbXpCigNPDNvcRuQxOhj6apj
	 7yyLpb+ltaR5OZ79qZlmoF8wLOM5JRUMcnjfOP+s4gOcsTP43oUBwY3oFF7SCcjxg6
	 ymDI4EWzfpEojL1kl/w/H/4aJE/iACjVgF+ERVVbHvnF7odKVcNkOW9sI90mda7J3z
	 9QTgiYDRiwgmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2 2/2] net: mana: guard TX wq object destroy with
 INVALID_MANA_HANDLE check
Reply-To: sashiko-reviews@lists.linux.dev
To: "Aditya Garg" <gargaditya@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260608101345.2267320-3-gargaditya@linux.microsoft.com>
References: <20260608101345.2267320-3-gargaditya@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:14:15 +0000
Message-Id: <20260609101416.1A4661F00898@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch prevents destroying uninitialized TX WQ objects that hol=
d the `INVALID_MANA_HANDLE` sentinel, but bypasses unreached elements in th=
e zero-initialized array, causing handle `0` to be erroneously passed to fi=
rmware.
- [High] Hardware vport registrations and configurations are not cleanly re=
verted if subsequent queue allocations fail inside `mana_create_vport()`, p=
ermanently breaking the network interface.
--

commit 27abeb920ad813c7f2d581fe8f249fdc9e94666a
Author: Aditya Garg <gargaditya@linux.microsoft.com>

net: mana: guard TX wq object destroy with INVALID_MANA_HANDLE check

This commit adds a check in mana_destroy_txq() to prevent destroying
uninitialized TX WQ objects that hold the INVALID_MANA_HANDLE sentinel. This
avoids passing invalid handles to the firmware, which previously caused
errors and logs. The change mirrors existing RX-side cleanup patterns.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index c9b1df1ed1098..d7de4c4d25bbe 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
> @@ -2334,7 +2334,8 @@ static void mana_destroy_txq(struct mana_port_conte=
xt *apc)
>  			netif_napi_del_locked(napi);
>  			apc->tx_qp[i].txq.napi_initialized =3D false;
>  		}
> -		mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);
> +		if (apc->tx_qp[i].tx_object !=3D INVALID_MANA_HANDLE)
> +			mana_destroy_wq_obj(apc, GDMA_SQ, apc->tx_qp[i].tx_object);

[Severity: High]
This is a pre-existing issue, but does this check safely handle all
uninitialized tx_object values?

In mana_create_txq(), apc->tx_qp is allocated using kzalloc_objs(), which
zero-initializes the array:

mana_create_txq() {
    apc->tx_qp =3D kzalloc_objs(struct mana_tx_qp, apc->num_queues);
    if (!apc->tx_qp)
        return -ENOMEM;

    for (i =3D 0; i < apc->num_queues; i++) {
        apc->tx_qp[i].tx_object =3D INVALID_MANA_HANDLE;
    ...
}

If mana_create_txq() fails during the loop, the unvisited elements
(where j > i) will still have their zero-initialized values, meaning
tx_qp[j].tx_object =3D=3D 0.

Since mana_destroy_txq() iterates over all apc->num_queues, and 0 is not
INVALID_MANA_HANDLE, the condition apc->tx_qp[i].tx_object !=3D
INVALID_MANA_HANDLE will be true for these unvisited queues.

Could this lead to erroneously calling mana_destroy_wq_obj() with handle 0,
potentially destroying an active WQ object used by another queue or port?

> =20
>  		mana_deinit_cq(apc, &apc->tx_qp[i].tx_cq);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but is there a resource leak in
mana_create_vport() if mana_create_txq() fails?

mana_create_vport() {
    ...
    err =3D mana_pf_register_hw_vport(apc);
    if (err)
        return err;

    err =3D mana_cfg_vport(apc, gd->pdid, gd->doorbell);
    if (err)
        return err;

    return mana_create_txq(apc, net);
}

If mana_create_txq() fails, it returns the error directly to
mana_alloc_queues() without jumping to a destroy_vport label. This bypasses
mana_destroy_vport() and skips cleaning up the hardware vport registrations.

Because the interface fails to open, apc->port_is_up remains false. Future
teardown attempts will skip mana_dealloc_queues(), leaving vport_use_count
permanently incremented.

Would this prevent the interface from ever being brought up again, as
mana_cfg_vport() enforces apc->vport_use_count =3D=3D 0, requiring a driver
reload to recover?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608101345.2267=
320-1-gargaditya@linux.microsoft.com?part=3D2
