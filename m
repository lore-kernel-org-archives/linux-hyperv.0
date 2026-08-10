Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA643AC0D7;
	Mon, 10 Aug 2026 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353805; cv=none; b=WFguaZSVYZrLnzI2FTISdkEjwrBW9itm93ZItjBdBatcYAxooxMdMYjBSzci6h57Bd8b/nonSw2/DV+KmjOPh+kRxLQZDkNbhEVCQhj8D6E5Qlli4ndxwf39jKYC7GQ5HhRiv8ZDIReCWUvqsvAVHvdymi8mutBPorubVXBMXdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353805; c=relaxed/simple;
	bh=96tOjn3hUEGfBeB7/LafxOoQdXfwx6jVWAG3It3QHPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gvzAJM0bnVli7OlVzr5x3eab5eOlfmwaqwZJ0ctIhMj3nqVeN4+RTje8QY1+pl8+mTORtdH50zIHNbyiZcIwZC9a1r0Y7nxn5gXYK0S+9Pc0yr4gOk9M2Wr5ZuR304qYysCUT+ZynDicOOCwwMjVK2vFdWi6AxW73MQHT+nf9+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgiRzFdm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgiRzFdm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F9211F000E9;
	Mon, 10 Aug 2026 09:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786353804;
	bh=96tOjn3hUEGfBeB7/LafxOoQdXfwx6jVWAG3It3QHPE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bgiRzFdmfa8wYSLmE04AFLrs/0XneXaFbYcezJYEtfaZZWLPnK4oCpwGpbzhVemRh
	 5CtgZ64BMXOCxL0qOqzY9ZCGccCWg5HwHQ/VFscFbCtqxNFI4luOO0F36D4/VtNN9s
	 RhoIKucxosnJDX8mSX87KNk35ws+HNRhmdn1zqLBCv2D/ZTZsuA5TSP3jxa9E9wF1R
	 yFrTzOry8XukY+WADxTy2kIbDhX0hiYJiqjte4UaA+qOnv4gZRV7gd07zkgAXIsIVH
	 ZEfMtGodFmYzILx0fjE7FD4F5ycqbkG7F0d0mXno03s1H8XYHpBVRvrHo3qiQeW3yr
	 rUELHxbOZmULA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260810090716.2325295-4-namjain@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-4-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:23:23 +0000
Message-Id: <20260810092324.4F9211F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> With fixup_irqs() now using irq_chip_retrigger_hierarchy() and the generic
> resend path (try_retrigger()) already falling back to it, installing
> irq_chip_retrigger_hierarchy() as the irq_retrigger() callback on the
> outermost domain chips is no longer required. The hierarchy walk reaches
> the x86 vector domain's apic_retrigger_irq() for all of these stacked
> domain chips.
>=20
> Remove the now redundant irq_retrigger() initializations from the outermo=
st
> domain interrupt chips.
> msi_set_affinity() is the only site that invoked the outermost chip's
> irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
> the x86_init_dev_msi_info() initialization can be dropped as well.
>=20
> No functional change intended.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810090716.2325=
295-1-namjain@linux.microsoft.com?part=3D3

