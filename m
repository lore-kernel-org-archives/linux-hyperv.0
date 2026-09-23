Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F3439EF20;
	Wed, 23 Sep 2026 04:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138635; cv=none; b=NVWTQqvOQlkJoLcVwWyJkm9xC6IjrT8+5tcl0Vvo0N1AlsJmbYB+SdHhv/FpMz5RI+5tqoPerYKgDpz9nf3scxsz/8Jhwgoera9rVf0lWZqDXOqxF8WYR/5YloF5s7X9M8h7EO5yqW8VHCva6AIOF+r0840uEbpQ940LmqYxgvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138635; c=relaxed/simple;
	bh=u6AozpVoDUtlRuIWlHgofvXudr9NzO0myszU5ZVs+3w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oG3NZFEV3Erd++5TOC8fHSK5Cx/b2FYi/lvLYr/7HiShSYbqJ2cjV1d1A+YUHf61xUXEdKrK5vAo8/4owMnOlhjji7v/WScwAImtDUJB85jQ/B+j/uCPADXlg4GZzYCbYC4BR4l9NBBm5VsflyRdMCLYSwpKBtUyXnb3vV8UqBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KrUQh5dZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KrUQh5dZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 277A31F000FF;
	Wed, 23 Sep 2026 04:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138634;
	bh=yZY9RHoRnMPP5KcjzU3A3E88EO11DRaMwMqvvCwDukw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KrUQh5dZQVoHXNlqUlicNqRnMEzIDOBE1k644MrQdySMb99Rd/nxWK93z0vnTmP/x
	 jr/bffGsbL7ZfrscMSlAlVx/BRHC1PsIN5Bzb6SqjpP0qYa3Pu7Tk8WcnVsV7AmwtH
	 pW3y6nAUVV4zmpZ1fu0bpabVAQrv4O9EpaCkJVpsWaZbIkRLk43/Tvk/QaYPHPBaV8
	 mdS+DfK8LbgWjU+30GI/Gptg0D2nkjmCCCWfN0pITc9ymyNX9v6UZghPukA7I6xHGx
	 wVXQbIuMr6qwRFYT2mFHfe+YTaEuyqBK/b4b+OhK4rW51LBCRoXtz7NWd6Nd9YSvVI
	 ifnVh4S5tiPGQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260923043023.3150498-5-namjain@linux.microsoft.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
 <20260923043023.3150498-5-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:43:53 +0000
Message-Id: <20260923044354.277A31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] irq: lost interrupts during CPU hotplug due to skipped top-level c=
hip in fixup_irqs()
--

commit 7fb72a647b56b7209b19850bb988eed0fff8563c
Author: Naman Jain <namjain@linux.microsoft.com>

x86/irq, iommu/amd, x86/hyperv, PCI: Drop redundant irq_retrigger inits

This commit removes the redundant irq_retrigger() initializations from the
outermost domain interrupt chips. The commit message notes this is because
fixup_irqs() and msi_set_affinity() now use irq_chip_retrigger_hierarchy().

>     With fixup_irqs() and msi_set_affinity() now using
>     irq_chip_retrigger_hierarchy(), the outermost domain chips no longer =
need
>     the helper as their irq_retrigger() callback. The generic resend path
>     already uses the hierarchy helper.

[Severity: High]
Can the transition to using irq_chip_retrigger_hierarchy() directly in
fixup_irqs() result in a regression where hardware interrupts are lost
during CPU hotplug?

When a CPU is taken offline, fixup_irqs() is called to migrate and
retrigger pending interrupts. It retrieves the top-level irq_data and calls
irq_chip_retrigger_hierarchy():

arch/x86/kernel/irq.c:fixup_irqs() {
    ...
    data =3D irq_desc_get_irq_data(desc);
    ret =3D irq_chip_retrigger_hierarchy(data);
    ...
}

However, irq_chip_retrigger_hierarchy() is designed to be used as a chip
callback, so it unconditionally starts its search at data->parent_data,
skipping the top-level chip itself:

kernel/irq/chip.c:irq_chip_retrigger_hierarchy() {
    ...
    for (data =3D data->parent_data; data; data =3D data->parent_data)
        if (data->chip && data->chip->irq_retrigger)
    ...
}

If an interrupt is non-hierarchical (e.g., directly managed by
lapic_controller in the root x86_vector_domain), it has no parent
(parent_data =3D=3D NULL).

Will the retrigger loop fail to execute, returning 0 without calling
apic_retrigger_irq(), and silently dropping the pending interrupt?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043023.3150=
498-1-namjain@linux.microsoft.com?part=3D4
