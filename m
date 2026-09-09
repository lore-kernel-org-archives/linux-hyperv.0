Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A221364926;
	Wed,  9 Sep 2026 06:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936791; cv=none; b=LXXALhKMQ0DiNlqgTs+QRcIqeHdASKnI3Df8SCeK++huE3e/BBb4OUkdvls37vTPvuCkABT+T0G7qBOdzah1R3Ja27T7iIsDuLw3ne0ZcIDiwlAp3KXR3mEhves6vUs+ELCHfBiFPkJs/SUc8Q9fyUhJ2I3B3/odUuAN0usX9y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936791; c=relaxed/simple;
	bh=s1VombYFkWe0RBwA7jSzNnrXpmetv2L0GsXsdbsgqIU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rBfTPPFDxNZGu9opKtkKJy2IJryTaXC0LekvDui/d7PDTEYHp80UIrIUUlKsUO7Lr4fma3wWWaCAY9p/41RQjnBu3zJLir1JiJWIgCgOGEzn8Y34aPDIXc7T3AAM/FBryjwWQD/0h36R0YD8lqxj6Gn3nyjXNW5KuFAbPMZHeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a35PkeKj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a35PkeKj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90C61F00A3A;
	Wed,  9 Sep 2026 06:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936789;
	bh=s1VombYFkWe0RBwA7jSzNnrXpmetv2L0GsXsdbsgqIU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=a35PkeKjs2aWawuh1c6DSjf64vK0+rmhpBA2vg50JhSQ1wRkvyEasfgGArk0jD3WY
	 u3jU+QYK/xoSZmjQOPA73EcBJATKz/Iw7RxzpiKko3gnnA9FSwVDTka8deseTbae7v
	 zFKtBkpWSzLUED84s9Bi2ZkcChnEd32oS2aMtZTLsI/E9JjtiC+tsiEPiiZBT2i65Z
	 jutE8t9I3wwEh8NeHxDQp7ywvbvtFKHmQadvfLWnlzcFVF42pR0DDRBWiLfYSFDmf6
	 g2B+kV8pGE5QiqDIoL5wDKkv62qPoK7sZ+d2X3c535xXpeqrnEQxEWDHZsjwllvjdd
	 W16IUair0Y74w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/4] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260909064448.1004-2-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
 <20260909064448.1004-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:53:09 +0000
Message-Id: <20260909065309.B90C61F00A3A@smtp.kernel.org>
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
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064448.1004=
-1-namjain@linux.microsoft.com?part=3D1

