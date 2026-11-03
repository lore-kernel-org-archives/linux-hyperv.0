Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674673;
	b=x1YRK5IkNqYHKp++NrUYimmfcUozZs/3sSVMNE1JrjoBr/0UvsvarQjzBmKJfhdpcB02
	 MgifD9fSI0nDnuZxXOYAqyGYCXlGI0gPHoJp3q66QKYJhqlvu+nSk5X9MV0sukf6JUUmg
	 wOXIWaVOBIEiw/ajFzVKU9oaXkafsW14lva+kRF9s6Ug3Hlo9eHM6bmyLfDp2l0plxHqi
	 aaVdqjWO6DRfQsJm7Z3d7n8qXMHSPm+ReqC7shKjXQADSl/kqCfCIaLs74QvLsn1e0ppD
	 mUHDa6rJj2Iq2qY+l21zlr4N5Ezo26Y/zFgp+VsGscaLEOVHOA+b09dl8DSzkoqiBNQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674673;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a5vUcGwKZonRH4GXpm79rv5WQsZkPrGydxWz1lVW+bY=;
	b=Jf3vqUApY4L9JLrFhN4Q8yzphms0ZR7Fk4EYeGAULhNhokxtKojqFCZSXBYrfmiKUcso
	 Q4PwOU5bq5kJnVq9PZLzRr76YudNsHzds49vDhc0yzBdmtHUZr+ZqG5waGmkPJak8idNP
	 Z0fu5Rbda+wN7GW0hPXFTkxiKc1/lN6lEpWVCZFHhtfSNrIw1bYrS6RrMyHetDjhoJni5
	 FFNWoDmWGuKADowFfEMVI7mBcjyBRoT3sBpZ+VlkNeb/v/bBUznLoT0YHdnpDm3Et1Z/w
	 L5wFIVaWwe+vQeBoA6XNkAs8hWR8xcD1O4XYF8i+pP9+fRxv0kWLHPSWDezr5QJfRsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr2EBKez;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640F606A326
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Nov 2026 02:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fr2EBKez
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C06AD1F0093A;
	Tue,  3 Nov 2026 02:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793674672;
	bh=a5vUcGwKZonRH4GXpm79rv5WQsZkPrGydxWz1lVW+bY=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=fr2EBKezIH3YJ4vMxXWc23Rb33ebozGLThnz3RCQH5Nvp9mWITqIokBNFNysEK1+o
	 PI54jJ1qN8JfnpEYbcWGXF7F22dp0S3QVP9ZtHbmso/Rp8a7XWYJwYJ6mxzXCMybYz
	 WxkHHQDdCFj8gZHrYRNA2sDDibzo9/Pqc5QtcJcHEkW7oF1KoMGAmPOWmDSlWtx+z3
	 jZ2+2le+TT7mWuIH6OJO23XE2ondIDRlWGi4QHyqo/SgpccXFDIMrLCO/tjgNQBvCJ
	 abtitcAmgCwo8zKvjlVWYcD0uOG2MZtpXbaNmpwZ+zRXJlJs7tSNMleYLWFPw7GCsF
	 BcL0Fq50rO+Ug==
Message-ID: <sashiko-outbox-194478@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 4/5] iommu/hyperv: Only call pviommu init on non-root
 VMs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>, linux-hyperv@vger.kernel.org
In-Reply-To: <20261103025150.3192119-5-mrathor@linux.microsoft.com>
References: <20261103025150.3192119-1-mrathor@linux.microsoft.com>
 <20261103025150.3192119-5-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 02:57:52 +0000
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] iommu/hyperv: always-false NULL check on iommu_init in hyperv_init=
()
--

commit 4f2b2cb5f11d745054ce781b3dfdb1a7f85d3560
Author: Mukesh R <mrathor@linux.microsoft.com>

iommu/hyperv: Only call pviommu init on non-root VMs

This commit renames hv_iommu_init() to hv_pviommu_init() and updates
hyperv_init() so that x86_init.iommu.iommu_init is only assigned on non-root
Hyper-V VMs when x86_init.iommu.iommu_init is not already set.

> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index b90e6f4875335..18651c38dba3e 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -580,7 +580,8 @@ void __init hyperv_init(void)
>  	x86_init.timers.setup_percpu_clockev =3D hv_stimer_setup_percpu_clockev;
> =20
>  #ifdef CONFIG_HYPERV_PVIOMMU
> -	x86_init.iommu.iommu_init =3D hv_iommu_init;
> +	if (!hv_root_partition() && x86_init.iommu.iommu_init =3D=3D NULL)
> +		x86_init.iommu.iommu_init =3D hv_pviommu_init;

[Severity: High]
Can x86_init.iommu.iommu_init =3D=3D NULL ever evaluate to true here?

In arch/x86/kernel/x86_init.c, x86_init.iommu.iommu_init is statically
initialized to iommu_init_noop rather than NULL:

    static int __init iommu_init_noop(void) { return 0; }
    ...
    struct x86_init_ops x86_init __initdata =3D {
        ...
        .iommu =3D {
            .iommu_init		=3D iommu_init_noop,
        },
        ...
    };

And in arch/x86/kernel/pci-dma.c, pci_iommu_init() invokes
x86_init.iommu.iommu_init() unconditionally without a NULL check.

Because x86_init.iommu.iommu_init defaults to iommu_init_noop (or is
overwritten by an earlier hardware IOMMU detector in pci_iommu_alloc()) and
is never set to NULL, doesn't checking x86_init.iommu.iommu_init =3D=3D NUL=
L in
hyperv_init() prevent hv_pviommu_init from ever being registered on non-root
guest VMs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103025150.3192=
119-1-mrathor@linux.microsoft.com?part=3D4
