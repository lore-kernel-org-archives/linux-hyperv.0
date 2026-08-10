Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA84D3AA1A1;
	Mon, 10 Aug 2026 09:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353183; cv=none; b=bYuhgmzcOIKuxzSytgu4ZkUmNpKuYZaSs76zUDl72EDvz4LXU1i4TJfaiuetA3LhrEz0fa4n3X5L/2w7B5RTU3mhWWBLmDtZ15C55q7BzSnxjj876JcPqXnkV38zI+Tp5jzVauKamVskOhFT/Aie6fiEg32UhN0fNbDEkuezvV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353183; c=relaxed/simple;
	bh=F3/7bKz5CDtEx6QZvDHwdM6WrAagl20Tukuy26Y0wvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kyTi6Uat/qWoK2JA4H/09CDSpFAUG+kYzxs0L7QnuFt0xGu2Q4SbiRzvJz0wU2vv/8v24bEIZJyi3tQzDrWzpnBsVy2YDRZ4Grk8yIZ/z+DtDLlR8AnwAqb8Uc39mC0X1bmm+tqeyExa9WLkO11lroDM/zi/diS7NijBn6s0ZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FrdxG2kA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FrdxG2kA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FFE11F000E9;
	Mon, 10 Aug 2026 09:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786353182;
	bh=F3/7bKz5CDtEx6QZvDHwdM6WrAagl20Tukuy26Y0wvo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FrdxG2kAEbPU1HJe2MXuYCqGlMP7cC9/k7Z5x4CKxPbwN4K0k+KbgqViimm7VEPQj
	 dsI9lH7fk4bfVr3nJSOqO5ChBgqeICzNNhoNWha0qa335G1q3psRvHmL4tYr2h7dZ9
	 npNOI2iVw0qoqizrGrUMb3gm6BFcvpuvHyuHsqzGACWJ3cCd5gLolXwiB3dzUfDVZZ
	 1WHyw2S7huZK3oPfqn4dp2W+I0hUu1mOfyJ2d4LfU8/+wWhzi5r8q7YjK/AnqwgOEF
	 OivfgQu92W3kJEZa5Uj6cgm7xozR18+tttgPKegeyEofpuXqecImR6MPQOUxhd9YfM
	 Tth1VstBeayyw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] PCI: hv: Set irq_retrigger callback for the
 Hyper-V PCI MSI irqchip
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260810090716.2325295-2-namjain@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-2-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:13:01 +0000
Message-Id: <20260810091302.0FFE11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> The Hyper-V vPCI MSI irqchip never installs an irq_retrigger() callback.
>=20
> On CPU hot-unplug fixup_irqs() migrates the interrupts which are affine to
> the outgoing CPU to a new target. If an interrupt still has its pending b=
it
> set in the outgoing CPU's IRR at that point, fixup_irqs() resends it on t=
he
> new target through the irqchip's irq_retrigger() callback. As the Hyper-V
> PCI/MSI chip does not provide that callback, the pending interrupt is
> silently dropped, which can result in lost interrupts, stalls and "No irq
> handler for vector" messages during CPU hotplug.
>=20
> Install irq_chip_retrigger_hierarchy() as the irq_retrigger() callback for
> the Hyper-V PCI/MSI irqchip, so that a pending interrupt is resent on its
> new target CPU via the parent x86 vector domain.
>=20
> Fixes: 4daace0d8ce85 ("PCI: hv: Add paravirtual PCI front-end for Microso=
ft Hyper-V VMs")
> Cc: stable@vger.kernel.org
> Suggested-by: Long Li <longli@microsoft.com>
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Aditya Garg <gargaditya@linux.microsoft.com>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810090716.2325=
295-1-namjain@linux.microsoft.com?part=3D1

