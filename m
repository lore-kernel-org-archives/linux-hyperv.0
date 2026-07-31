Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7D0248F72;
	Fri, 31 Jul 2026 22:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785538055; cv=none; b=YclcFUhjUAUFDkNbeQNMin2AfJBtbdg/1MhFjZbCTU0OmZJvn02i7UqadKf/pZOCJyTlBBNiHXoBsj3A1LEJ6tz6TFaqwQ9A58ljOhyDAtHxaD18ezVclfaZJcMmHmLnkWFRaN9zRCBP3196FkFoozQiqccDHV5lS1BadpGDkvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785538055; c=relaxed/simple;
	bh=0a6s+116G+osAVkvRy2r+diLeG0040ozpI6N6GsHTkk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nPsJjNzjjN3LbzfLk1uYO2EBVD8PpQR56StWI9CzoKMLTvCCTBdiJ5YCVKkQ/6TYjymzuRc0QkJNn83kyJSraWnfQ06fetkvY4Z5nH61qd9fr6Ytqz4b9EB7Iuqoyl74F4PJswQABewC7tmcNl0i2kNRHgNTYN3r+0UXh/Mbh5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRDgDOOD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRDgDOOD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19931F00AC4;
	Fri, 31 Jul 2026 22:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785538054;
	bh=H5AzO/8A4Ze/0djuCSwlvu6eajkMkgGvorO+JayFrLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRDgDOODrnIQVb6nVpQIVqsbnOgy4VqWRDK4YOP0hSE94hGp4tStMe+XlFtRmvgit
	 7hVgscqQ5DV6fpkFNplyxMGwjMIHz4GscsibgAGrAckamhDz6rD48rBarCgOhQAO/p
	 9ooFH4dB2LnAEdTD2lnD8Em6mvF6Htnle/MzH234I7HEVQGtgHfndat8H3VCzVI4RK
	 CNqR+dmz1bSJrJlIznvKFQ8TisAe/y42GzXXgADUPHO1aHUXTdUlpEqxxVfticzQRr
	 F1ldrDbCPYcX+uhWxUIYK6Mes7FhyeMqRwTW2apxrI4L3USPlgCHmL5Swt6DoSD/qk
	 XtIVj3BGA9PYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/9] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260731223427.2554388-7-mrathor@linux.microsoft.com>
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-7-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 22:47:33 +0000
Message-Id: <20260731224733.E19931F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Medium] Incomplete API export for cross-architecture code

Pre-existing issues:
- [High] Resource leak of multi-vector MSI IRQs during teardown
--

--- Patch [6]: [PATCH v5 6/9] PCI: hv: Export hv_build_devid_type_pci() and=
 change return type ---
commit 2b1777d94c87d493032cb98e1c21a4774a30a00a
Author: Mukesh R <mrathor@linux.microsoft.com>

PCI: hv: Export hv_build_devid_type_pci() and change return type

On Hyper-V, most hypercalls related to PCI passthru to map/unmap regions,
interrupts, etc need a device ID as a parameter. This device ID refers
to that specific device during the lifetime of passthru. So,
make hv_build_devid_type_pci() public and change return type to u64 to
enforce it's size.

> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index b3ad50a874dca..8780573a43326 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
[ ... ]
> @@ -172,8 +172,9 @@ static union hv_device_id hv_build_devid_type_pci(str=
uct pci_dev *pdev)
>  	}
> =20
>  out:
> -	return hv_devid;
> +	return hv_devid.as_uint64;
>  }
> +EXPORT_SYMBOL_GPL(hv_build_devid_type_pci);

[Severity: Medium]
Will exporting and implementing this API solely in an x86-specific file cau=
se
build failures for ARM64?

The commit message mentions making this public for PCI passthrough hypercal=
ls,
but the mshv driver supports both x86 and ARM64. It appears cross-architect=
ure
builds will lack this implementation when they try to utilize the newly
exported API.

[ ... ]
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f64393e853ee3..8ebbd1cb7c8ce 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
>  static inline void hv_root_crash_init(void) {}
>  #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
> =20
> +#ifdef CONFIG_PCI_MSI
> +u64 hv_build_devid_type_pci(struct pci_dev *pdev);
> +#else
> +static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return=
 0; }
> +#endif
> +

[Severity: Medium]
Similarly, should this declaration be placed in a shared or cross-architect=
ure
header so that ARM64 drivers can safely include it without breaking?

While reviewing this file, I also noticed an issue in hv_msi_domain_free().

[Severity: High]
This is a pre-existing issue, but does this loop fail to tear down the
remaining vectors for multi-vector MSI IRQs?

arch/x86/hyperv/irqdomain.c:hv_msi_domain_free() {
    ...
	for (int i =3D 0; i < nr_irqs; ++i) {
		struct irq_data *irqd =3D irq_domain_get_irq_data(d, virq);
    ...
}

Because it looks up the base virq on every iteration instead of virq + i,
does this continuously leak hypervisor-level interrupt resources and chip_d=
ata
memory allocations during a device unbind?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731223427.2554=
388-1-mrathor@linux.microsoft.com?part=3D6
