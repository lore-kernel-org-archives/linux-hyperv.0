Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB883408626;
	Mon,  7 Sep 2026 07:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764755; cv=none; b=lpeRd27xnG97dj/01jS5JSY8rfx3oRnJHOcTaKulDBtHXvPb1h6N8SCEmA8kVzfvCmIMOgLs7GOzSyd/iluAOXNP85AKPY6JTHonfdXLoHTu6x9WaSQmc5bcWlDvtfoD/wEGGJDOa4u08pqmbh0x9N+oaWpExG9OMI32ryxFG2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764755; c=relaxed/simple;
	bh=9n1YSZo6B3UfOa8vsiem7Bn6ItIGNN4W17gq6R0aCPw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GmVarWHpOgHLZWHEPz5aZ1ZOe/huQhicWUuMoJ4uhvboGFVAyviook1vH6dtyVihR+nG/kc632kLTiCJIlViZ+auFsPSFAnxX8qd3ifuWr/SUMw+9SpE5dbSJpKA4jjdfMRDe2pRUHhEpDY4/pWOwxmXiBaCQeDxMyfi/tOTCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrIS4TUI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrIS4TUI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275351F00A3A;
	Mon,  7 Sep 2026 07:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764753;
	bh=9n1YSZo6B3UfOa8vsiem7Bn6ItIGNN4W17gq6R0aCPw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VrIS4TUI/09fxXMy99p5Ci9xSA1YzKtfwoH0Fong9tynQTjvAhizVYQOcrcegCsz8
	 yZ0guXahXLi3EgYzedgAgDc8nHnECbHB8w0u8davY0cE0S8pfiSoEHBKE7TmBEMyFU
	 dP03+PP215HWarE3j5hCh6wgiCIDzkLS/OtXYatnd+PVwDCaBiYi7n0F0QkJq7ESzt
	 DuP8yrak61g6Cyn+6gGIb8QJPWC2t/aBTRWbL1IaIsdn2yq7NfPkDL5qQgPi7ryiC0
	 lP92m1TDJiinQLaBIuk7CwqV2w46ZDTZCnfE9TGi0Cha/1lViEYA1vEW6avNweRSzl
	 q2u6nwYT2Acxg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/3] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260907065129.269262-2-namjain@linux.microsoft.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:05:52 +0000
Message-Id: <20260907070553.275351F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> The Hyper-V root partition vPCI MSI irqchip lost its irq_retrigger()
> callback when it was converted to msi_create_parent_irq_domain(). The
> callback was present on the original irqchip and was dropped during that
> conversion.
>=20
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> the outgoing CPU to a new target. If an interrupt still has its pending b=
it
> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on t=
he
> new target through the irqchip's irq_retrigger() callback. As the root
> partition PCI/MSI chip no longer provides that callback, the pending
> interrupt is silently dropped, which can result in lost interrupts, stalls
> and "No irq handler for vector" messages during CPU hotplug.
>=20
> Restore irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
> the root partition PCI/MSI irqchip, so that a pending interrupt is resent
> on its new target CPU via the parent x86 vector domain.
>=20
> Fixes: 4691db0704ac ("x86/hyperv: Switch to msi_create_parent_irq_domain(=
)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907065129.2692=
62-1-namjain@linux.microsoft.com?part=3D1

