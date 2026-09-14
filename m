Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5659C443312;
	Mon, 14 Sep 2026 11:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385696; cv=none; b=T7JZWP4s8zTcfBSiOXUgx481bFuKupCBlUJ0rzDx6uBx+erzlDK7SiIEjrQHUP0T69K4stm07VEOgohLWnYhR/0ACOy6qqf8YLTRi7QHvVrTQjVwQBHf6ndVjU7H8w/e00II/BzNWWyKypB1Ur9a6Gu4hX6fK2PpztHzHEVbt6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385696; c=relaxed/simple;
	bh=24hfIN03bvH9nUUi0JMuYoqII6d5TuKmXTVhaAx768c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZoEmlCdTrh4Xxl11xwublla7Ub1+0WJc+3j5fEnhOEmLAo28rlqyNaG8z2OMgcaxjlTPD1GAXNrO3eR1nMtvEgrJBEZpf9ZQAzGAWu09UQUeoIGZzwh09QVdzAfXZzJVyxLwfKZMyavvsZ7eqSaV/Ob6wyilhqwP8HKWCExH/wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8gQiV/I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8gQiV/I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A441F000FF;
	Mon, 14 Sep 2026 11:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385694;
	bh=uXm9jPWyqiPYswZygbYCLMBoSUOh5BbQ/FiIezcSOxI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=c8gQiV/IYOeWNXf/iGIAidqAod4oDmPs0grLCLXF0VNhEDtObX7f6JHpcLUvaMhkZ
	 6JUzkNc+uLxDSPLHJvbDf9GhljYeigVXWy5zLp+rWHaVbgZK3KMSBv/idr8/JPsc0V
	 3SwSPiv83vgVN5ELFvndgtHPbAdwvj0IxrMrGedvZkf5yZsr80uceTi6/k8ug41wsp
	 ka/PlE7Rv0ry5qjxVkXF4wcNtZ2Dnr0kj8GldPJy64aUK4BojTX0+H8YivHqLyIA+0
	 bmFjWTIYvlXsWmMy1u7UiA8R+NRL4rueKv3wvwlrlk0KN1UvfJNkO1fN6VHIFFcCb8
	 kkYEiq3/tZDpA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 fixup_irqs()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260914111836.2119301-3-namjain@linux.microsoft.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:34:54 +0000
Message-Id: <20260914113454.A5A441F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The use of irq_chip_retrigger_hierarchy() silently drops pending i=
nterrupts for root-level irq_chips (like lapic_controller) during CPU hotpl=
ug, because it intentionally bypasses the outermost chip.
--

commit 25a8009ce9e28c732ed15d13383d7819cd1539c8
Author: Naman Jain <namjain@linux.microsoft.com>

x86/irq: Use irq_chip_retrigger_hierarchy() in fixup_irqs()

This patch modifies fixup_irqs() to re-inject pending interrupts by walking
the interrupt hierarchy using irq_chip_retrigger_hierarchy(), rather than
relying solely on the outermost chip. It also introduces scoped guards for
the descriptor locks and conditionally sets VECTOR_RETRIGGERED only when
the retrigger operation succeeds.

> diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
> --- a/arch/x86/kernel/irq.c
> +++ b/arch/x86/kernel/irq.c
[ ... ]
> @@ -490,21 +490,19 @@ void fixup_irqs(void)
[ ... ]
>  		if (is_vector_pending(vector)) {
> -			desc =3D __this_cpu_read(vector_irq[vector]);
> -
> -			raw_spin_lock(&desc->lock);
> +			guard(raw_spinlock)(&desc->lock);
>  			data =3D irq_desc_get_irq_data(desc);
> -			chip =3D irq_data_get_irq_chip(data);
> -			if (chip->irq_retrigger) {
> -				chip->irq_retrigger(data);
> +			ret =3D irq_chip_retrigger_hierarchy(data);
> +			if (ret)
>  				__this_cpu_write(vector_irq[vector], VECTOR_RETRIGGERED);
> -			}
> -			raw_spin_unlock(&desc->lock);
>  		}

[Severity: High]
Does this silently drop pending interrupts for root-level irq_chips like
lapic_controller?

Looking at irq_chip_retrigger_hierarchy(), it initializes its loop by
stepping immediately to the parent data:

kernel/irq/chip.c:irq_chip_retrigger_hierarchy() {
    for (data =3D data->parent_data; data; data =3D data->parent_data)
        if (data->chip && data->chip->irq_retrigger)
            return data->chip->irq_retrigger(data);

    return 0;
}

If the interrupt relies on a non-hierarchical root domain where parent_data
is NULL, this loop will immediately exit and return 0. The valid
irq_retrigger callback on the outermost leaf chip is never executed.

Could this lead to lost hardware interrupts (such as legacy timer or ISA
interrupts) during CPU hot-unplug for these devices?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914111836.2119=
301-1-namjain@linux.microsoft.com?part=3D2
