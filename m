Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26817271464;
	Sun, 13 Sep 2026 23:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789342493; cv=none; b=F874NPqEk/yMzSLlFOhjSPi5AjISYp0Zp0+WvQzlbDuhed3LLRBNvSotYjSd5dVGnafi1Qh3k3BFnrJmS3AgMvgqBO5ztwYosFpcrHekfHZ3MTlGNCaoi/QrFL+s6xOdrRXQ65XKdCfQWEA6dLhd/9ozyDCUjYPG8VsCTLbk6ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789342493; c=relaxed/simple;
	bh=YZE4BwU4qtMAogi/3Dlpj3U9IsDoADjsg16MrNRuDco=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SrMcmpa9fPTSGw+4+Ezj+Lvzyl49Myzmuw8eF+bmv9vo3QIPY/35JHlWnssKDdZqxSrMnzSvkpZVMKm49ZECh428Y6rSpaPnu+WiYS+/nqTonF5UycpsUlLsRkKT3Ik/h7cAcZAT8RPqsUHLHfl0M/m+XFk+J2oo3j9GAIRlFTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m2aI7UY1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m2aI7UY1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D691F000FF;
	Sun, 13 Sep 2026 23:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789342491;
	bh=DXK3aFyXFtNdiAF1Cgs5lDGN4nEnz+MRU2y6MDtyg4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m2aI7UY1fV3sGg9PT+CQjalBjs5GJVImo4Mbj7ASq22GBcP3Nl/HZEEbI8ErDgw5s
	 qmsSNQmHDSEoG7xdy4nlv58jRAmC4pz6VrnIy35cdqrNk49l92YBusppkbsJTCOtvd
	 ExL7SSEXggflVtIg8DbG1I9Jr0Hhc0oYnzViRn1acBj3dl1cUqvlQin66L9USIHR7H
	 33mPyQpTjJNfxieF3PK6+0apex6pNg6qK980gjMgLr7iC6MdNn6KdPe07T0lfSMcoI
	 ODhAlTjPGdVmeeZWVDYxcwSap6lfQKQWq5y9J0lHrNDQ0yGASkfF2JEYOUlApZ47zt
	 viyKkhCJ884ng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260913232255.2801797-1-wei.liu@kernel.org>
References: <20260913232255.2801797-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 23:34:51 +0000
Message-Id: <20260913233451.95D691F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Directly modifying a u32 buffer via a char pointer cast assumes Li=
ttle Endian memory layout, clearing the wrong byte and corrupting adjacent =
registers on Big Endian architectures.
- [Medium] The patch hardwires PCI_INTERRUPT_PIN to 0 for 16/32-bit reads b=
ut completely ignores PCI_INTERRUPT_LINE, creating an inconsistent configur=
ation space state.
--

commit badaaf9419fe573b12895ca135de8cb0ded77d3e
Author: Mukesh R <mrathor@linux.microsoft.com>

PCI: hv: hardwire PCI_INTERRUPT_PIN to 0

Hyper-V DDA does not support legacy interrupts, so the driver intercepts
8-bit configuration reads to hardwire PCI_INTERRUPT_PIN to 0. This commit
attempts to also hardwire the pin for 16-bit and 32-bit reads, which
previously bypassed the emulation and leaked host hardware values.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd3..bb4e6ca4ac1ce 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -1240,6 +1240,16 @@ static void _hv_pcifront_read_config(struct hv_pci=
_dev *hpdev, int where,
>  			mb();
>  		}
>  		spin_unlock_irqrestore(&hbus->config_lock, flags);
> +
> +		/*
> +		 * Make sure PCI_INTERRUPT_PIN is hard-wired to 0, since it
> +		 * may be read using a 32bit read, which is skipped by the
> +		 * above emulation.
> +		 */
> +		if (where <=3D PCI_INTERRUPT_PIN &&
> +		    PCI_INTERRUPT_PIN < (where + size))

[Severity: Medium]
Will this leave PCI_INTERRUPT_LINE leaking host hardware state on 16-bit
and 32-bit reads?

The original code correctly hardwires both PCI_INTERRUPT_LINE and
PCI_INTERRUPT_PIN to 0 for 8-bit reads. By only checking and clearing
PCI_INTERRUPT_PIN here, a 16-bit or 32-bit read starting at
PCI_INTERRUPT_LINE will bypass the emulation and return the raw host
hardware legacy configuration to the guest.

> +			*((char *)val + PCI_INTERRUPT_PIN - where) =3D 0;

[Severity: High]
Could this corrupt adjacent configuration registers on big-endian
architectures?

This pointer cast directly modifies the memory backing the u32 val buffer.
Because a u32 is stored in CPU native endianness, treating it as a char
array assumes a little-endian layout.

On a big-endian guest, the computed byte offset will point to the wrong byte
in the u32, such as clearing PCI_MIN_GNT instead of PCI_INTERRUPT_PIN. This
would leave the intended pin unmodified while corrupting another register.

> +
>  	} else {
>  		dev_err(dev, "Attempt to read beyond a function's config space.\n");
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913232255.2801=
797-1-wei.liu@kernel.org?part=3D1
