Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3333FE15
	for <linux-hyperv@vger.kernel.org>; Fri, 14 Aug 2026 05:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786683921; cv=none; b=F8pI9fZ9lU6qgMnrJ5JwwLE3ov6dZ426Eb0MRJXAsXY0FGdzMBkVN3BdyP3B3fU7IeVEKEpKmFBYaqPFXQsX7bNQhAa00VbEzaZCJPZMeXBrzmGbnub3ouJWwDwnDnbjx+l23q8dh4CFkX5Qn6/avZWTVRVAsg2R591IakhId+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786683921; c=relaxed/simple;
	bh=LJAJ/QWpVCk4Sdla42EoORBeAlmw5alxaXSachaLENs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GIfcZbswaAuuzHbSGV+FmL94jpyBLovgw3jIz5d7p7XOqvAwyi6SmwjhUmLA8d49zax9FS22njfw0aJL+wBxDrO3d6QWQWJFfyVRNYDnwA+TgISMqwu8ACkjWdoNmfyZ8Ju8Wl7ir2sIFXLQY3cLt2ek3aaC6gio70rtR1HXEg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELfLvDgc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELfLvDgc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE2051F00A3A;
	Fri, 14 Aug 2026 05:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786683919;
	bh=XyXsT4QpA9JNIqej2/5jnBNEFYVHlOLxjavgjaudqa8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ELfLvDgcpfqjcvMoF4PXWplxEjI4eg2z/lBFV2vds8E32PaZTRqidURrvGBKPEK3i
	 367i+rYB9cxxgSVfPKjRGHTIPUu9/j+8LG9B50jZDI/Q5fqu1k7NzaqxG3jcYXN8A7
	 o9ZsvEd+lclZB2VLlrV/fZ/Dw5kgZn1kdmO2jHsGefr0G16V60anJF52Ps8UPCG2zv
	 x4sCErPl1NZhyAqToOV0LG17KHi9DlamDoW6iYd9efZlqtDqnEUISzIMTrOFHTxOFC
	 fweywyirh5SW0BYSUM1t7NiT9WxNDyoiANmdB2xq/fWEtS4jstK9g/rJlPpNsJM2+L
	 +9a/DYoa1NjmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 11/13] net: mana: keep a user-configured RSS
 table across a queue rebuild
Reply-To: sashiko-reviews@lists.linux.dev
To: "Long Li" <longli@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260813050418.2906468-12-longli@microsoft.com>
References: <20260813050418.2906468-1-longli@microsoft.com>
 <20260813050418.2906468-12-longli@microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 05:05:19 +0000
Message-Id: <20260814050519.BE2051F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Desynchronization between `apc->indir_table_sz` and the actual h=
eap allocation size of `apc->indir_table` during device reset leads to heap=
 out-of-bounds read and write.
--

--- Patch [11]: [PATCH net-next v2 11/13] net: mana: keep a user-configured=
 RSS table across a queue rebuild ---
commit e2bf133521a3f8f376f19cc855758c1eb53a195b
Author: Long Li <longli@microsoft.com>
net: mana: keep a user-configured RSS table across a queue rebuild

A queue rebuild regenerates the RSS indirection table from the driver defau=
lt.
This patch updates the driver to carry the user-configured table over inste=
ad
when the queue count is unchanged.

> diff --git a/drivers/net/ethernet/microsoft/mana/mana_en.c b/drivers/net/=
ethernet/microsoft/mana/mana_en.c
> index 7c43c2f9043ba..6e77b59cfcf90 100644
> --- a/drivers/net/ethernet/microsoft/mana/mana_en.c
> +++ b/drivers/net/ethernet/microsoft/mana/mana_en.c
[ ... ]
> +static bool mana_rss_table_keep(struct mana_port_context *apc,
> +				unsigned int num_queues, bool *lost)
> +{
> +	u32 i;
> +
> +	*lost =3D false;
> +
> +	if (!netif_is_rxfh_configured(apc->ndev))
> +		return false;
> +
> +	for (i =3D 0; i < apc->indir_table_sz; i++) {
> +		if (apc->indir_table[i] >=3D num_queues) {

[Severity: Medium]
This is a pre-existing issue, but can this loop perform an out-of-bounds
read on apc->indir_table?

During a device reset, mana_init_port() re-queries the hardware and updates
apc->indir_table_sz directly:

mana_init_port() {
	...
	err =3D mana_query_vport_cfg(apc, port_idx, &max_txq, &max_rxq,
				   &apc->indir_table_sz);
	...
}

If the hardware returns a larger size than what was originally allocated
for apc->indir_table, does the driver reallocate the array to match the
new apc->indir_table_sz? If not, this loop might read past the end of
the existing heap allocation, which this patch extends into the new
mana_rss_table_keep() function.

> +			*lost =3D true;
> +			return false;
> +		}
> +	}
> +
> +	return true;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813050418.2906=
468-1-longli@microsoft.com?part=3D11
