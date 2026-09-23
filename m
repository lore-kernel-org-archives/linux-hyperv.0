Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28743988F8;
	Wed, 23 Sep 2026 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138228; cv=none; b=ozJr7Ka+aYxKwU/E/esk3c2RzbLXM6FjjZXtGlogktHyeQqf4XXV5zH6KEIbBo9Fd5ijj5db9GlOAf/vCRa1dv72w2mrZaJOYbMrs9J5/T4gM8STrJXYDlNIBaQfdaE3P027bwDzioQy9xn1i9tYDaO3Gd+sxvfT6pK/biKsq64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138228; c=relaxed/simple;
	bh=rezUe5/PZ0Ao7JSl5Tn1cwKhlA67AwBSKZHaqOpxvK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hfjcg0nX9j0IXf/qUZhTGs6tZjAwC8n914EpQJx+AXlXSwqgOlBv7qERFX6/6sfKbpEVgNC4786TSVEFq62UOiMHf0VdWTk4yXoOA9Fv4ZvBZxiFC0VJDhSy4Qal28UQZOYb3b6+/HjRyzCwZZo+D1D6VZZvUSnra4qh92nwtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n6mS9H5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n6mS9H5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 025451F000FF;
	Wed, 23 Sep 2026 04:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138227;
	bh=rezUe5/PZ0Ao7JSl5Tn1cwKhlA67AwBSKZHaqOpxvK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n6mS9H5uYdjb8+C4SeIvYtm22D+KuphHVL6dLhraR4HMgTy00OrG/V/5ULyL0ftBf
	 Xs8cSv9q3kvikT4r7sL2sYxCdKppgGfF3bCqB/jpFXe9tQSYvCb1vdLunEx8OhA7fn
	 l+vWVzxXyXyWNNJxQIaVypV9ejBaVq49B+NO+GdPiklzzhKWRwB+ryFsLVz56WCiQ/
	 jH00HGmuj+jPSkj0YxtELnqVEGvMx6xgcrKHuPCKUl4ZwHywe2lZ9e55EGnVX0+Erb
	 PlNDIgsjOBJtFiRuHzfSFQCjKEHYJPmZr4zuYwwVazsw5jIC4DXKdYxsLGFsB9t9Jj
	 9j95KOGDKWIZg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/4] x86/hyperv: Set irq_retrigger for root partition
 PCI/MSI irqchip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260923043023.3150498-2-namjain@linux.microsoft.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
 <20260923043023.3150498-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:37:06 +0000
Message-Id: <20260923043707.025451F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043023.3150=
498-1-namjain@linux.microsoft.com?part=3D1

