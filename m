Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792702075;
	b=Kh+D/TvTzWA5+z/IzZA6NSgbVzJyUMK8TVjjBnk8eCjb2+kvt2W21euoBmQSHq1gdCny
	 NAnB2I7lYr5pPTPKhOChfOq3kFQtdolrLWdpR5RtZIT2l1j6lGuUoqoZNyEzBkuDRLqbg
	 1ObhUMeBLj9xpEMzlm4zxD0jJ4R9iBw09dSGgQCSd6jIUaINKswCG2SAE77ZE4zhTkVxt
	 MjXScJmdL+RMqHM5v8neKTDfAdiBeQZB51xVwErz9tTjts8JoUBlyZg6rFrLkY3odi82p
	 6GHMhFi+YIMyDHsoTjBn3AByRZmCMxwPtyXfVEtaOBVrJWJPQTv9Ja8L5u0bFq8HbUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792702075;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=d195u7s0gxTdhw6oOnomff1bquLC/NKl5tNruuLaGVA=;
	b=ZARo2gaXJNXWSArvwUAPuJPLm+9sKMnQPyuuHUuyb7jVMBEU8CmN42RsVcigb30P6sNZ
	 Cuakzh9h4ZXNvH9pcht4KLt3IgsVHWFAqHOpTU+Plzj+8kBdk0eXlNBcEpqrgVORSw3lO
	 33UGDP2/vpz3jGcJdoUNO3UjcUWccfa+dLisPQYneOudjEURzqDcpvuMD7ceisYQld0qn
	 gAx04ioRlJDJ2EFTqGII6nYLCno7AyhFOxACBDOtLw7E+J9hZRLQKd2eTL8OdMOmwX4zM
	 9Tk1HuiyD0XzAPPgWlhFRM5JKmYNdeKSrybOBI8uqNCZ4RCYBlXCCpfSiDmq+TAIvTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Czebhs3R;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7F7606A319;
	Thu, 22 Oct 2026 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Czebhs3R
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81CE31F01825;
	Thu, 22 Oct 2026 20:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792702074;
	bh=d195u7s0gxTdhw6oOnomff1bquLC/NKl5tNruuLaGVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=Czebhs3R+FTztiglyFjiBrHOT+jX/KjJoEWSItc9oQ1OcRqPABu4AgxD3i9usp0Bc
	 LOKsrbvWS3OM9aV41ywnomAGnwc1rgzOEwYEPY/S+p5Zmub9wSAJfWeqp/QaFyJkZc
	 SNfhtuxu85/pGCVLXrFNBBR9dsgCXltBtwKPIau5bst9rh+WIrvNv2SFT8j8SldQ1A
	 e6FZxXSKeYKHgZBBgDNJ8LMyCrnuUb4Wn70t6J94iwMPXgVns5Aq/sj3D/+cLuXQmV
	 jWd4uS765Yj1CF95bgLvCMqmWFS99H6nmim0VyDutqvOi7BFOALs2484zccbr/bXKS
	 jsKwg092ddrUg==
Date: Thu, 22 Oct 2026 15:47:53 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: mhklinux@outlook.com
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in
 pcibios_root_bridge_prepare()
Message-ID: <20261022204753.GA2740623@bhelgaas>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929181056.4746-1-mhklinux@outlook.com>

On Tue, Sep 29, 2026 at 11:10:56AM -0700, Michael Kelley wrote:
> pcibios_root_bridge_prepare() currently has code to handle Hyper-V
> guest root bridges with the sysdata parent field set to NULL. While
> this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
> Support root bridge preparation for Hyper-V") was accepted, more
> recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
> device to PCI device") always sets the sysdata parent field to a
> non-NULL value.
> 
> No harm is caused by leaving the special case in place, even
> though it is no longer needed. But in the interest of overall
> code cleanliness, remove it.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to pci/pending/controller/hv for v7.5, thanks!  The branch
will be renamed and rebased to v7.4-rc1 after that is tagged.

> ---
> This patch does not just do a revert of 7d40c0f70d92 because
> an intervening commit moved the code to a new source code
> file.
> 
>  drivers/pci/pci-acpi.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 42d545edd7fa..452a90317c58 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  		return 0;
>  
>  	cfg = bridge->bus->sysdata;
> -
> -	/*
> -	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> -	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> -	 * NULL in this case because there is no proper ACPI device.
> -	 */
> -	if (!cfg->parent)
> -		adev = NULL;
> -	else
> -		adev = to_acpi_device(cfg->parent);
> -
> +	adev = to_acpi_device(cfg->parent);
>  	bus_dev = &bridge->bus->dev;
>  
>  	ACPI_COMPANION_SET(&bridge->dev, adev);
> -- 
> 2.25.1
> 
