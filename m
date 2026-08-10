Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DAF39891F;
	Mon, 10 Aug 2026 09:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786353703; cv=none; b=jJoyLlUBq8LIesuTqqQgtFSmMGd9sQrhTWsXXWEhWLoWS1hCZ6Le1O9mbEpduZ9htR2LOLKfdGbul2B8trRAP0GdFj32X2GAF4ljQoHwKqh2flwgNX/qytvx0QTna07zUhGCDnzEuUrzWY7XAyDqBE/RKWmcd0D7Eo7NOL90jWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786353703; c=relaxed/simple;
	bh=887lH8NinqxKBk530OhtDT/IHNIgXmnoyRXJn3B97Uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RCWi3Kn7CITouiYK8XHfxD/1t9USwBdmrNNQAgxl4nlM0oo6eAnqT9pu01cTMA/Ru0MrHT7aTEgkSK4nSjkTtNTfYOdpxkTQE6R+lXHvq+sOv0cjtf6BxvQ5hp4DTzf9KO3+iODJeBWg5Bxwqa1P2OVUpniQ1OTkpsoRqK9wtdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WzFfrDyF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WzFfrDyF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA0ED1F000E9;
	Mon, 10 Aug 2026 09:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786353698;
	bh=eoZNCSB/mEUoRdFUmqijwSuGqE6NX/x37+bfjc4DSY0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WzFfrDyFr85/HA1GCbq50gGMBcxeeWAyIqcvkVSP+9sOD8Wr7zXN0yOyez+2M3J1T
	 d6iQC8JDD4NZhlHm/Vjziimb/gMeSjyX5hUjKaT/n4Td3yNXy8xqfw/BI6DSPuBodR
	 mtX+RA9MQVmkulsZYUyUzhzpbWt6+UiWwfjLTD28mA0CbMjveirIoAYwcqC0AIM2Vp
	 hBG9PnBSjQKBG/Y7nvI7wdhaTyJ+x6SfIihMi2iif0PukXwrJK27qFbqwKsDYyigBz
	 h3uRoIOkUa4ShqHJrVf19ZobD0Ljx/fokmbJtpZIq/YSZ/0oUvUn7oN88VgixfXHTb
	 W7QW9Yt3pN0kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260810090716.2325295-3-namjain@linux.microsoft.com>
References: <20260810090716.2325295-1-namjain@linux.microsoft.com>
 <20260810090716.2325295-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 10 Aug 2026 09:21:37 +0000
Message-Id: <20260810092137.DA0ED1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] `irq_chip_retrigger_hierarchy()` skips the outermost interrupt chi=
p, breaking retriggering for interrupts where the top-level chip directly i=
mplements `.irq_retrigger` (e.g., single-level domains).
--

--- Patch [2]: [PATCH v2 2/3] x86/irq: Use irq_chip_retrigger_hierarchy() i=
n fixup_irqs() ---
commit 51de6b45bc61b20c750e5760473230c207ce5194
Author: Naman Jain <namjain@linux.microsoft.com>

x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()

This commit updates fixup_irqs() to use a scoped guard for the
irq_desc lock and replaces the direct invocation of the outermost
chip's irq_retrigger() callback with irq_chip_retrigger_hierarchy().

> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
[ ... ]
> @@ -489,22 +484,18 @@ void fixup_irqs(void)
[ ... ]
>  		if (is_vector_pending(vector)) {
> -			desc =3D __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> -			data =3D irq_desc_get_irq_data(desc);
> -			chip =3D irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			guard(raw_spinlock)(&desc->lock);
> +			if (irq_chip_retrigger_hierarchy(&desc->irq_data))

[Severity: High]
Does this skip the outermost interrupt chip for single-level domains?

Looking at irq_chip_retrigger_hierarchy() in kernel/irq/chip.c, the loop
initialization immediately advances to the parent data:

int irq_chip_retrigger_hierarchy(struct irq_data *data)
{
	for (data =3D data->parent_data; data; data =3D data->parent_data)
		if (data->chip && data->chip->irq_retrigger)
			return data->chip->irq_retrigger(data);
	return 0;
}

For domains where the outermost chip directly implements the retrigger=20
callback (such as legacy interrupts in x86_vector_domain), data->parent_dat=
a=20
will be NULL or lack the retrigger logic. Will this cause the hierarchy wal=
k=20
to just return 0 and silently drop the pending interrupt during CPU hot-unp=
lug?

The generic try_retrigger() in kernel/irq/resend.c handles this by explicit=
ly=20
checking desc->irq_data.chip->irq_retrigger before falling back to the=20
hierarchy walk. Should fixup_irqs() follow that same pattern to avoid skipp=
ing
the top-level chip?

>  				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>  		}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260810090716.2325=
295-1-namjain@linux.microsoft.com?part=3D2
