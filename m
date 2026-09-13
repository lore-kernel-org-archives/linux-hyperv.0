Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCC036998A;
	Sun, 13 Sep 2026 22:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789339975; cv=none; b=RFI7XZXWf7it3EhrdAH9hsqwpuiwU3TOCSrM6UtIWyA+Wzet6UamhJIu4ixXwpFm9YiviTPxfs+KR/IlCRqOha49M4PBV3siWHzQb5YMYvsHzQ/4L1cE0P3n4SBmV9GMeXt4z999FPIZWrd+UuCBlbr7ToCBZ22gq0AoXet0Kwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789339975; c=relaxed/simple;
	bh=/jEbsC7pSvqSjb3f3uZCmlBrauSlDgmZk+5qBVCNmoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cX1daNXqOyLDi5ma5FooLxIBGCWLHK/J7s8W5ivcdWgONXavPfIsIdErKSHJ6OMxkuZYY9bNDhNBC0bHzulTzBtfrbFW05Vc3DiC7VnpX7G2Eec3UI1eBadHRMCELYWe4EOxcrUsItkCOg9aN5TVlqg2/Vz73lN/eepHc98TFzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i8+moK+O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i8+moK+O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1165D1F000FF;
	Sun, 13 Sep 2026 22:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789339974;
	bh=sFLEzIkWizB/Nwf5ajBI2FY7Ykla6wCDppOKpbWhOFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i8+moK+OQHIp1za2gczKaIHDu17PiijV/yWSEnrq8yApUI3JB5GG3REjoCAKShtHx
	 uuTMORoj979jXPk65NFIAdogPfBxvQYGOmGx2JrfseE1TRH9aCwDXiGBe7ZV/BnwJ9
	 u+z1Dmr4vApRzIqrQsKEiOrXRoNn3j+vFuSfLuFw3hHb4M0XBThQ9GWYhvGVDfle2J
	 z164XQMIor3gEtodrfxpnVHacf/IrlPU+gFsLTJhUBA4dT5CnAdc3Rq8eis2rEWnJS
	 mEFNSYBpHDpr0VBsrQOx0ZnvlygqLmUsIhzkWbs6tT29ncOkd/nn501wZxNiTwxjq3
	 gdAi5SzDcbi9g==
Date: Sun, 13 Sep 2026 15:52:52 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc: mukeshrathor@linux.microsoft.com, anirudh@anirudhrb.com,
	schakrabarti@linux.microsoft.com,
	Mukesh R <mrathor@linux.microsoft.com>,
	Asher Kariv <askariv@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Message-ID: <20260913225252.GH2219269@liuwe-devbox-debian-v2.local>
References: <20260913221039.2218950-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260913221039.2218950-1-wei.liu@kernel.org>

On Sun, Sep 13, 2026 at 03:10:39PM -0700, wei.liu@kernel.org wrote:
> From: Mukesh R <mrathor@linux.microsoft.com>
> 
> Hyper-V Discrete Device Assignment (DDA) does not support legacy (INTX)
> interrupts. When PCI_INTERRUPT_PIN is read, the pci-hyperv controller,
> which captures configuration space accesses, returns 0 to the caller.
> 
> However, the current code only captures 8bit read access, thus 16bit/32bit
> are missed, forwarded to the host/HW, and may yield a non zero value.
> 
> This fix addresses this issue, and makes sure that PCI_INTERRUPT_PIN is
> hardwired to 0, while the other bytes, are those returned by the host/HW.
> 
> Signed-off-by: Asher Kariv <askariv@microsoft.com>
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  drivers/pci/controller/pci-hyperv.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 89816a2bd7cd..e6db82413add 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1240,6 +1240,16 @@ static void _hv_pcifront_read_config(struct hv_pci_dev *hpdev, int where,
>  			mb();
>  		}
>  		spin_unlock_irqrestore(&hbus->config_lock, flags);
> +
> +		/*
> +		 * Make sure PCI_INTERRUPT_PIN is hard-wired to 0, since it
> +		 * may be read using a 32bit read, which is skipped by the
> +		 * above emulation.
> +		 */
> +		if (where <= PCI_INTERRUPT_PIN &&
> +		    PCI_INTERRUPT_PIN < (where + size))
> +			*((char *)val + PCI_INTERRUPT_PIN - where) = 0;
> +		}

Please ignore this version. A new version will be sent out to add back the
opening brace.

Wei

>  	} else {
>  		dev_err(dev, "Attempt to read beyond a function's config space.\n");
>  	}
> -- 
> 2.53.0
> 
