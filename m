Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FDF442388;
	Mon, 14 Sep 2026 11:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385167; cv=none; b=V4Rp4yvzNV31C5RJinaEkZCBNAdCBaaIu/XQj8nmQQkDmdLmHZpu2I5wfrnVr0qFPBwZRY86n8DxT/7fcXfkn8RbN0108vSHvmpGfeXVwjkS7F02/+lrKDg+DF9LtLNub/cfcqvRfO2mwwE2/Ar/8L33rH0w5hTjiHi44zhtpjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385167; c=relaxed/simple;
	bh=KKrIHRbTMSmXOXT1z4zqgTdHjLdCwDah4ipih/8s4dI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VvVI0foiSkU7EQOnbpr9UUYV81umbvw+FepBWx5hw4GD4v84siax69Hupikh1EdFrX1u23cEmlP2nT3zblN/UvPBHFhLqnuDjW0No02+0qReqdsSfnqGakAtk/2tucyG7A7SPzoXHn2aOrr77CV4dtR1YtF4AC+kgd1TFHUWvwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ihp4XjN8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ihp4XjN8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513711F000FF;
	Mon, 14 Sep 2026 11:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385166;
	bh=KKrIHRbTMSmXOXT1z4zqgTdHjLdCwDah4ipih/8s4dI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ihp4XjN8utQubM7pPwfenVSyjv1paL152tWC3MBn0CkJw5pLooxFA0Eu8m2zCYue8
	 EsX4PatfHVd9LAUrC8j0Dwa7fW4DqD4ri5N/N4L7a6/I/pbZfUKh0+jLVpegCX1d78
	 2jt054e8tKjOIh+hNWhHNr/ohqlicgem1WuxdiGzyZVaaVtolKsBv1gD1rK1/H/3zz
	 ZOisol8QPOrrOGnNNaTR3lskqIIkBZTvfl5V7GhcsYDCsHW2tK3FGltFl0YLqOzTqM
	 4v2sR5Qw7NxWwWoaBGb9j/Js4Zz8EzWd2xBHkfXM5Nn5huiP7QvlyNWpKdWl7Tc0M1
	 3WLdFtAfnowNA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/4] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260914111836.2119301-2-namjain@linux.microsoft.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:26:05 +0000
Message-Id: <20260914112606.513711F000FF@smtp.kernel.org>
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
> Reviewed-by: Nam Cao <namcao@linutronix.de>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914111836.2119=
301-1-namjain@linux.microsoft.com?part=3D1

