Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1003FDBFD;
	Tue, 28 Jul 2026 13:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785247148; cv=none; b=Xb39t9MDhqWGuaGEfo85Nsik3HCG5atP+sWQPOq+OYkvE9odzz3QnzXYcprpANvcH09v0P4V/pmZmW9eCcD8GV7VYNsWINWqWTFh3Mt1lCupbmnOD7CRCh8kl6g0SC1GJ8rtOc9J5xGhhwEwZviSQ6kwwqhcQbHbbc4/wXbKN9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785247148; c=relaxed/simple;
	bh=0BGI9+S07Rb5M01DwOuDYzDvFZ8d6L5HKRtiyxRjhhk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=KuUdv7NyufGo9pMcp/n0q4NPRJxSl/LH2sevX31C23Y8fdIQF9GdQxXcAxynhd+M5q9q5moBer6dc9ZxFjF2SYtz2zKI98BHoQaK6I1kekks4PrZD1d3PB/VQPCWXiWnK9aWe+fZBhNI56ih1aDydr0V9/WluSJrlYboZCU8Awc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0m6SUOE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0m6SUOE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130E71F000E9;
	Tue, 28 Jul 2026 13:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785247146;
	bh=0BGI9+S07Rb5M01DwOuDYzDvFZ8d6L5HKRtiyxRjhhk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J0m6SUOEJWtW7i1WPUNT/QF4CXZgF6jj1uW52/Y76nx4dBRO3UDdLehkhEmL1pyO1
	 brnSHPKWNhLvYAhCsKzF3xrX2K6mblH28i/WLsrh08fosfvH/hQuvup3tXpwUIzHmn
	 qbDmobzOs6D14bYV1QTpMMkuRG4wuKGfUZBNyro8jV05xKH7GE8dt7f456ypnes5pP
	 qpPPE35O6U8xipfV7DenHs/bwELXYlFZVhtFBtg03eQBTwxnMNMHRTmQ5Ducxji5B4
	 4SBKLnDs/HyLz+3uZ2RjU8IllhTarUv5KCneNKB3C4l0Iqrc8SuL3bcQYRCA4vikWo
	 Otn/UdN2E+1BA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/3] x86/irq, iommu/amd, PCI: Drop redundant
 irq_retrigger inits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260728135117.2888175-4-namjain@linux.microsoft.com>
References: <20260728135117.2888175-1-namjain@linux.microsoft.com>
 <20260728135117.2888175-4-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 13:59:05 +0000
Message-Id: <20260728135906.130E71F000E9@smtp.kernel.org>
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
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728135117.2888=
175-1-namjain@linux.microsoft.com?part=3D3

