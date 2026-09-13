Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC4037B407;
	Sun, 13 Sep 2026 22:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789337981; cv=none; b=kGzPIV50dYSijeWIYJVgM3HVsqaWjVwhFLGwwy1aKxfhIvdjWxO45R2l2MdwCFqQfkrKyWDBWOlm8j7EB1sp2RO3vZjIjhQTUZ5CSgFrMUlsPNQmEFaPWu7jtAECzpLW5sS4VXczhPISfeOVDU13meJSnKdQsEO2DPx2xfC5pmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789337981; c=relaxed/simple;
	bh=FUz+/mpKPpQkMkf0CFBNhKdE1qzag8tmhqGJJ2U2k0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CgdcIOu8YtEACaomMPfdE1Im6O5Q/F2RxfWweAOLBMDlB5J9SBB7HjIqi5wx9tfd5BQBTcSye5iy7sXC9N2z1thz6IPiZhmNWow6s7Y3FVTMxr8bWmo8mzs3X9PB2l1rWF84JltQvhSmT/7bdG1bDFWrT5ek/CcpUQ/wG6wGAaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQZhD1Dd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQZhD1Dd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A1A1F000FF;
	Sun, 13 Sep 2026 22:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789337980;
	bh=5+XNXb7q0BIslRylIzmTQUDNDf0MUWF31Vfp7zTb4Gc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UQZhD1DdTex2B2E46QCXxcehAy7EG55yPF7tk8gOGg0o4G1JD7DxeB525Xcq5FrJP
	 Nmp5BMRpHfrF48yIr1CRK1XNvlKemQuVCYBjKrG0PgCXpHPFB4STwucag74i7iv4TS
	 ZFk2ytnwRE1jAw/euQVC+UdVjTVgCEIZv8Zr4UjaBpxjfmcJcEj04GA1FksWdQO/l+
	 VOdBTSiTBwDHdM9hY+PGTJzRyJrjfhx6FRFzImVQBEbNIU6m9yEJHgRY56U4pAGRzd
	 drdlJT5Qv21XXECAXQF86HLlcj82qqCwRyRy7MAotl79tJkNY1nR/MxOuwRQ3xeo60
	 wypX4ItQDuo3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hv: hardwire PCI_INTERRUPT_PIN to 0
Reply-To: sashiko-reviews@lists.linux.dev
To: wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260913221039.2218950-1-wei.liu@kernel.org>
References: <20260913221039.2218950-1-wei.liu@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 22:19:39 +0000
Message-Id: <20260913221940.05A1A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Medium] The patch fails to hard-wire `PCI_INTERRUPT_LINE` to 0 during 16=
/32-bit reads, introducing inconsistent emulation behavior.
- [Medium] Modifying the returned integer via `char *` pointer arithmetic i=
s broken on big-endian architectures.
- [Low] Extraneous closing brace causes a syntax error and breaks compilati=
on.
--

commit 34dba20e549ad1a394e94eeb91577f3b24614432
Author: Mukesh R <mrathor@linux.microsoft.com>

PCI: hv: hardwire PCI_INTERRUPT_PIN to 0

This commit hardwires PCI_INTERRUPT_PIN to 0 for Hyper-V Discrete Device
Assignment, as it does not support legacy (INTx) interrupts. It addresses
an issue where 16-bit or 32-bit reads miss the previous 8-bit emulation
and yield non-zero values.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd3..e6db82413addb 100644
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
Does this logic miss PCI_INTERRUPT_LINE?

The previous emulation blocks in _hv_pcifront_read_config() explicitly
hard-wire the 8-bit read of PCI_INTERRUPT_LINE to 0.

It seems a 16-bit or 32-bit config read encompassing PCI_INTERRUPT_LINE
would leak the hardware's non-zero value, violating the design intent to
hide legacy interrupts.

> +			*((char *)val + PCI_INTERRUPT_PIN - where) =3D 0;

[Severity: Medium]
Will modifying the returned integer via char * pointer arithmetic work on
big-endian architectures?

For a 32-bit read on big-endian systems, casting a u32 * to char * and
indexing by byte offset modifies the wrong byte in memory.

This could fail to clear PCI_INTERRUPT_PIN and might accidentally zero
another byte like PCI_MIN_GNT.

> +		}

[Severity: Low]
Could this extraneous closing brace cause a compilation failure?

It doesn't appear to match any opening brace in the added block, which
would break the block structure and lead to a syntax error.

>  	} else {
>  		dev_err(dev, "Attempt to read beyond a function's config space.\n");
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913221039.2218=
950-1-wei.liu@kernel.org?part=3D1
