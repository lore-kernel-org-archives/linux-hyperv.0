Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17D030E0F2
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 15:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118014; cv=none; b=gwTHmf8aw2iVKfPb5EO0V41v3OLQCk2ZN/3JxhvOdrjvQc4BXSv8Am5PvEIHIkqXm3FrcDJzEv+oYU2DwWTkA9ApTvydgL9DEVON4egQ1MV3L2YAmeQnFSX9qZwtZaUJNW0yqhUE2dfa8rFSDUXpDUNLO46Gc9Cekc2dUF1m2/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118014; c=relaxed/simple;
	bh=Jv2Q7zIBlpkjnepFqjNg36ORI8M+LVgIL46egNMgHrw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G9Dxhcy6lYHyjVxcsvza0ReMYxCrK++o/1PW6q+TEfeMrPeFrb2zzMx5ZUDZo6XP+pB+mRpb0L75CsbuoUZT5hJXeWBdMJrQqN1983E1IXvYZXBuobM/taX6lNtzUFZAoe2/cb4bQWNJ1ry0GYn1FIdQCOrZW/nqbNeZr2uLS+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lqCa9smm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lqCa9smm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF061F000E9;
	Fri,  7 Aug 2026 15:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118013;
	bh=/1tX/uJ2fVMGAqk3QdCbo5cBjIhTe6BL4hiGR/aoBlY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lqCa9smmdl5tFg0QKDaowBugYTcKlJjeOKeYyaVY1yXICOf1nQYpih1bcVz+1SDgF
	 RYbgXeQrXbJjl8Z60jf2vh7pZelCWWBkj9r2UZ3ydaEW+tDaqg/smBqeRLoyWAsEOi
	 jk6RcQK4u+tMMesgYO7gpcH5qDUrYhcIMVstxO0Wu2gL4vE/an1LtaEOV3kxayWid7
	 ck4f9JGFv5NJbyQS/aVEtUlufpWMbDk5IhLKEAIId4lP6+qSIL7mzsHpMSJ4jE6fLK
	 96lYPOm+clmh1YNbL/7RVRDJM1q0spraTMKhWGovZLZY0c3PGm8/kONZBXnI+haIko
	 ypB3bj0NX3CMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 10/13] mshv: unmap SNP memory before state teardown
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-11-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-11-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 15:53:32 +0000
Message-Id: <20260807155333.3BF061F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Userspace can trigger a kernel memory leak or DoS by unmapping mem=
ory regions of an active encrypted partition.
--

--- Patch [10]: [PATCH v1 10/13] mshv: unmap SNP memory before state teardo=
wn ---
commit f9f61905fec1fff131a4505ade5ecacaee8647a1
Author: Wei Liu <wei.liu@kernel.org>

mshv: unmap SNP memory before state teardown

This commit updates the partition teardown process to unmap memory regions
before destroying the SNP partition state. The regions are only released
after the SNP state is fully torn down, which allows the host to regain
access while the partition is still secure.

[ ... ]
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index c81a8d0493c19..0fbd2158968da 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
[ ... ]
> @@ -2166,10 +2166,8 @@ static void destroy_partition(struct mshv_partitio=
n *partition)
>  		if (mshv_partition_encrypted(partition)) {
>  			hlist_for_each_entry_safe(region, n,
>  						  &partition->pt_mem_regions,
> -						  hnode) {
> -				hlist_del(&region->hnode);
> -				mshv_region_put(region);
> -			}
> +						  hnode)
> +				mshv_region_unmap(region);
> =20
>  			ret =3D destroy_snp_partition_state(partition);
>  			if (ret) {

[Severity: High]
This is a pre-existing issue, but does a similar problem occur when userspa=
ce
unmaps memory via the MSHV_SET_GUEST_MEMORY ioctl?

When a userspace process unmaps memory from an active SEV-SNP partition,
mshv_unmap_user_memory() drops the region unconditionally without checking =
the
SNP state:

drivers/hv/mshv_root_main.c:mshv_unmap_user_memory() {
    ...
    region =3D mshv_partition_region_by_gfn(partition, mem->guest_pfn);
    ...
    hlist_del(&region->hnode);
    ...
    mshv_region_put(region);
}

Because the partition's SNP state is still active, could mshv_region_share()
fail to regain host access during teardown?

drivers/hv/mshv_regions.c:mshv_region_destroy() {
    ...
    if (mshv_partition_encrypted(partition)) {
        ret =3D mshv_region_share(region);
        if (ret) {
            pt_err(partition,
                   "Failed to regain access to memory...\n",
                   ret);
            return;
        }
    }
}

If it returns early here, does this result in a permanent leak of the pinned
host pages and kernel structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D10
