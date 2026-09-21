Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C53B813E
	for <linux-hyperv@vger.kernel.org>; Mon, 21 Sep 2026 23:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790031689; cv=none; b=morkQOr++u3g7lFxcrzbDRyn6lwiCdtLI0t1W3i8bipZaZSRCAdvDak87Q7VtZck90LTs4rBdFOnXqSqr9U8xVMuB6bXnPEnR4txZGLYAFNvZ8rmvpVdTvbA0X7bU9kPuryraKryfbCOIMtQ40fbdixgYZN4Trffmruj2vWDgD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790031689; c=relaxed/simple;
	bh=gHpknGT5/FCdGG/SRJhV6AE+WQFNuOZqJeOUYnzNzSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=f9TdyjCJ6MmHEsbUeWP3CMfD2FkL9hdQT5XQlUMkjafV4ay7eZqqS7PStAQvwD5PmO/0HfepuGf2Ok/VBbP3wi5kyKUYfNNT4rE1Z01Kvxu5rDfQauCwDQHX9tETf9/YOD2f09UVwA8L8yGNXBjMi6SsorJ/eM3npkiR5OOfG1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWVXagfA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWVXagfA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BFBD41F000FF;
	Mon, 21 Sep 2026 23:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790031688;
	bh=GFXllnPKPybHjy1Iw6rivea3CkHRyiv7jHQAcDEgTUI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KWVXagfAWJvHOE/V6Vr9mdZIkpAiITRA4PJmwV6rqmpntXdDR4ivVdbnXx9y1lXbQ
	 Am9sD2e7+PJFTd6tDOniGMHZsyOxl5cH3gfpL79Rc5PbzUC6sABwxRqkwlPJJuRCB1
	 jKR/c1CpyJt7kqCRX60woEzXoS6JB+q9VRkQVHIZ8lky6ccDlvmYysQbzkqbMJUa4v
	 NqwXTtYKZ5YvtSyLkaoCxwzPO95Hcl3KJNzD8HSkdp5oEREA12stYacg6XmqHFoMok
	 MqTZBwfzs405UOEUpsa2c0XKcjP1MzbtSFtOLWgo/UXvTwPb4OFPwhqeZZLq9dXcC4
	 m/5hskRFhxp7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V0 1/3] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260921225028.4007330-2-mrathor@linux.microsoft.com>
References: <20260921225028.4007330-1-mrathor@linux.microsoft.com>
 <20260921225028.4007330-2-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 23:01:27 +0000
Message-Id: <20260921230127.BFBD41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hv: invalid fallback device ID when CONFIG_PCI_MSI=3Dn
--

commit 92e8d721eb5c704c530977f1074dc44ee7895e0a
Author: Mukesh R <mrathor@linux.microsoft.com>

PCI: hv: Export hv_build_devid_type_pci() and change return type

This commit makes hv_build_devid_type_pci() public and changes its return
type to u64 to enforce its size. It also adds a fallback stub for when
CONFIG_PCI_MSI is disabled.

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

[Severity: High]
Does returning 0 here break PCI device isolation and silently misconfigure =
the
hypervisor IOMMU?

On Hyper-V, a device ID of 0 is not an error code; it is a valid ID
corresponding to HV_DEVICE_TYPE_LOGICAL (type 0) with ID 0. If CONFIG_PCI_M=
SI
is disabled (which is permitted, as CONFIG_HYPERV_ROOT_IOMMU does not selec=
t or
depend on it), the IOMMU driver will silently issue attach/map hypercalls
targeting Logical Device 0 instead of the actual PCI device.

For example, when compiled with CONFIG_HYPERV_ROOT_IOMMU=3Dy and
CONFIG_PCI_MSI=3Dn, during boot and device initialization, hv_iommu_att_dev=
2dom()
could call this stub and pass the resulting 0 to the
HVCALL_ATTACH_DEVICE_DOMAIN hypercall.

Can the actual implementation of hv_build_devid_type_pci() in
arch/x86/hyperv/irqdomain.c and its dependencies (get_rid_cb, struct rid_da=
ta)
be moved outside the CONFIG_PCI_MSI configuration boundary rather than being
masked by a silently failing stub? They use standard PCI APIs and have no
real dependency on MSI.

> +#endif
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921225028.4007=
330-1-mrathor@linux.microsoft.com?part=3D1
