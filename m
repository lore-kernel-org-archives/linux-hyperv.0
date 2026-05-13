Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1F13D47BF;
	Wed, 13 May 2026 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778654610; cv=none; b=aOsBFclrwUiZeNLhvsv7b+weRDJ0bGwIN/qZIxnNr10fK7v0kBp3Knu4TtXzSfHLoQckkYaQM3Lyn43HWG7fl7Rp25bPJW59hLu2tdPL/Uqn7gtaIth9uXvnfkhHM9EEpXyv+Apg/ZrICgxtXWALtdKWWayAmNulI3z9tzeSpgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778654610; c=relaxed/simple;
	bh=yLvNrrxq9IsaYKABVJv7VnFq7IiQi5JhmwAKdQoEjKk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n87GdsZGdrQMo7lYx1KNncjmKfh396126Q4Y6o1J3nnH9b4qfHUr+zbxICWY261kDQ5fJPa0x4Lm1LpoiSlXTGJbHtZlpCtcn4kjHLWLHvhfxeuToJyKCu2HKaTBeSHnFBDuTVmwkXhvI59d5MQCrAvlkGyMef0YL6Hriq/b0go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cG15a3cO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cG15a3cO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48447C2BCB7;
	Wed, 13 May 2026 06:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778654609;
	bh=yLvNrrxq9IsaYKABVJv7VnFq7IiQi5JhmwAKdQoEjKk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=cG15a3cOTCvpg9P6rfhAXBdJU/UUJSj3MqFGCUijxeTcMXHikz9ZPQH4xUJCy3ZEb
	 pDNuP7igsWftsi42YId+uTrEWdx/QQhm42J4vhgk+ZDFD5KxMb+lHq1+SOfR/nRy9Y
	 6NsZqM9brDgd89H85Halx72Fp8G0T32LXttsfxF1dWtvjbQ80cHDZhcRt4oIrcq6nN
	 JNS6vZjBc2hNqlKEeoKEp6dfz/IA7BwrI1INp1T90i9oVBv8i91qQKfskHNN7rrzQE
	 TqZrShm/u2R2PM+BVe79EppljfqG18315os1KWsPxOsWkhL5olt6n4E587jdM27x6+
	 Z8Yvuoz3Ihq9w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 08/11] PCI: hv: VMBus and PCI device IDs for PCI
 passthru
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260512020259.1678627-9-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-9-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 06:43:28 +0000
Message-Id: <20260513064329.48447C2BCB7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Conflicting declarations and missing `#ifdef` guards for `hv_build_=
devid_type_pci()` cause build failures under certain Kconfig combinations.
--

commit 086da02227f217e959d3022c592e1b8698814d5b
Author: Mukesh R <mrathor@linux.microsoft.com>

PCI: hv: VMBus and PCI device IDs for PCI passthru

This commit introduces functions to build and export VMBus and PCI device
IDs for use with Hyper-V PCI passthru. It exposes hv_build_devid_type_pci()
and adds hv_pci_vmbus_device_id() to generate the device IDs expected by
the hypervisor.

> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index b3ad50a874dca..8780573a43326 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -112,7 +112,7 @@ static int get_rid_cb(struct pci_dev *pdev, u16 alias=
, void *data)
>  	return 0;
>  }
> =20
> -static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
> +u64 hv_build_devid_type_pci(struct pci_dev *pdev)
>  {
>  	int pos;
[ ... ]
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyp=
erv.h
> index f64393e853ee3..2ef34001f8d31 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
[ ... ]
> @@ -248,6 +248,12 @@ void hv_crash_asm_end(void);
>  static inline void hv_root_crash_init(void) {}
>  #endif  /* CONFIG_MSHV_ROOT && CONFIG_CRASH_DUMP */
> =20
> +#if IS_ENABLED(CONFIG_HYPERV_IOMMU)
> +u64 hv_build_devid_type_pci(struct pci_dev *pdev);
> +#else
> +static inline u64 hv_build_devid_type_pci(struct pci_dev *pdev) { return=
 0; }
> +#endif /* IS_ENABLED(CONFIG_HYPERV_IOMMU) */

Will this cause build failures under certain Kconfig combinations?

If CONFIG_PCI_MSI=3Dy and CONFIG_HYPERV_IOMMU=3Dn, arch/x86/hyperv/irqdomai=
n.c
provides a non-static definition of hv_build_devid_type_pci(), but this
header provides a static inline definition, which leads to a redefinition
error.

Conversely, if CONFIG_PCI_MSI=3Dn and CONFIG_HYPERV_IOMMU=3Dy, this header
declares the function, but it is never defined because irqdomain.c is not
compiled, resulting in linker errors.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D8
