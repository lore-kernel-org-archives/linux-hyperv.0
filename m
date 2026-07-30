Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAF649620;
	Thu, 30 Jul 2026 06:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785393279; cv=none; b=VLRk8ExP/lzPRJo/utF4i0HoRTbWHIOJOZ7C2zPpLT0LaLYV+AltfPok1UpUrxC9WcJV4HGERJejyxuNhQq/PSRo9GkZG1vnJNgddp+hFBzsU4mvc2hlEBRApzSilQZNPsOg7Bv8YDdm36lKPpkectap9ZwSRs28p0rv7cJQX7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785393279; c=relaxed/simple;
	bh=uUrJGfaBIb7mDA4YBbtbfsAXDxZqOs8qYQYrmWapWeM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=BF3TV6fJ26G0oB4v/5mxyQxyG6sLffgc9gYEexjkmefiYVbsAxWUrnkCmDnf+jnSL1rmEVA5IL22loUYWlX7CW5+Yukp4xL2obFZ16jOZKII0cpq+eSprzfpRVnN0yaZ3ibzU/iopBV0TiCF6S9Z6IO0eLlk8AnXjMUpTC4VElg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U3LhnaM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U3LhnaM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF6391F000E9;
	Thu, 30 Jul 2026 06:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785393278;
	bh=7TW3V65Ed9QROSvOoOYcEkM/qCbnhSzbOuwkLOL4aPQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U3LhnaM3LleXLXiVai+NylyKynb6c6mGY1S+5Ggv0xMro+AAD1GmJ/XDul7KscPHE
	 HTSpQouH7r+qV86PV4sLBzOKNJEICwPZorDcuJ1wKadqKBVSCE/tlT+4cOyU9AoQ9H
	 Z/vei2FPemFXnHjNh1K8M92rUfkYYk/BHxWQB9FRsM3scvWXI/G6wkO6PqfdnGdDTk
	 s2X1gQBEluqigaPA4kNLmDbh89OkeTlTUk88avlbnTv9AUnfMC/XzdItf3GYMzY4jp
	 2/pfzhQnhovTPHnzdzOrak2/kS+5otrzIl1dNL4GTo6fHA3vVCgsPcIVcGpHuLeBLQ
	 i3aWx0hkUF9qA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v13 2/2] net: mana: force full-page RX buffers
 via ethtool private flag
Reply-To: sashiko-reviews@lists.linux.dev
To: "Dipayaan Roy" <dipayanroy@linux.microsoft.com>
Cc: bpf@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260729063347.3388035-3-dipayanroy@linux.microsoft.com>
References: <20260729063347.3388035-1-dipayanroy@linux.microsoft.com>
 <20260729063347.3388035-3-dipayanroy@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:34:37 +0000
Message-Id: <20260730063437.EF6391F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Use-after-free of BPF program when mana_pre_alloc_rxbufs fails dur=
ing XDP setup
--

--- Patch [2]: [PATCH net-next v13 2/2] net: mana: force full-page RX buffe=
rs via ethtool private flag ---
commit 2ea505589c71d255969461add82f06436f8f8e80
Author: Dipayaan Roy <dipayanroy@linux.microsoft.com>

net: mana: force full-page RX buffers via ethtool private flag

This commit adds an ethtool private flag to force one RX buffer per page,
bypassing the page_pool fragment path. This is intended to restore
line-rate throughput on certain ARM64 platforms with 4K PAGE_SIZE.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c b/drivers=
/net/ethernet/microsoft/mana/mana_ethtool.c
> index 482cd16009abb..7e441d6ae5dce 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_ethtool.c
[ ... ]
> @@ -756,6 +775,78 @@ static int mana_get_link_ksettings(struct net_device=
 *ndev,
[ ... ]
> +static int mana_set_priv_flags(struct net_device *ndev, u32 priv_flags)
> +{
[ ... ]
> +	if (changed & BIT(MANA_PRIV_FLAG_USE_FULL_PAGE_RXBUF)) {
[ ... ]
> +		err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
> +		if (err) {
> +			netdev_err(ndev,
> +				   "Insufficient memory for new allocations\n");
> +			apc->priv_flags =3D old_priv_flags;
> +			goto clear_flag;
> +		}

[Severity: High]
This isn't a bug introduced by this patch, but while reviewing the callers
of mana_pre_alloc_rxbufs(), does a failure during XDP setup leave a dangling
pointer?

In drivers/net/ethernet/microsoft/mana/mana_bpf.c:mana_xdp_set(),
apc->bpf_prog is updated before the allocation:

        apc->bpf_prog =3D prog;

If the allocation fails, the function returns early without cleaning up:

        err =3D mana_pre_alloc_rxbufs(apc, ndev->mtu, apc->num_queues);
        if (err) {
                NL_SET_ERR_MSG_MOD(extack,
                                   "XDP: Insufficient memory ...");
                return err;
        }

The core network stack handles the error by releasing its reference to the
new BPF program, which may then be freed. Because the early return skips
the err_dealloc_rxbuffs label, apc->bpf_prog is never reverted to old_prog.
Could a subsequent interface flap execute mana_attach() and assign this
freed BPF program to the hardware RX queues, causing a use-after-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729063347.3388=
035-1-dipayanroy@linux.microsoft.com?part=3D2
