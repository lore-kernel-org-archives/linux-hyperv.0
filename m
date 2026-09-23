Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEEB23D2A1;
	Wed, 23 Sep 2026 04:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790138544; cv=none; b=IjmZoMQT8i0HyJcBdtwzArsafvhHu1UgZzwwx3l7lS39uavtu8r892n7O+pJtb5o6ADLX+czKTKz5sa21Awt9h5/HcxOqFYpbx/ohNHYrqOjD8OJSUnlS4P78BFNqoefddASCf41HwgByMBIIvQZG4TC2D5IB4HoSd1CleBZ5H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790138544; c=relaxed/simple;
	bh=yibyr9XU8I0xlpV+XKtkEJ1YZcZSQPpXzKXaAHIayrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=t9bn7rtI4voVVKAORJLmv5m9xJhcVyzF0qT/2hAg0FUFgz/1FUihf6eIpLenjGDrIwgqr3pfjICthcGBsytHelh+LUw24N8lk5j63CT7qwXdu2XjCJTTUHyx7yqm3JKWLGKjSJYxxF+49JIbDtaCqydIZeHqUpSK1QU+HP5E/2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvG/G3XY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvG/G3XY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B9A1F000FF;
	Wed, 23 Sep 2026 04:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790138543;
	bh=yibyr9XU8I0xlpV+XKtkEJ1YZcZSQPpXzKXaAHIayrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YvG/G3XYaz12b22BNGRlo51Ex34tHYF57h900f6Jp8jULu+GRHwPD/YEvjfytIcB5
	 VffcmErP1QXoqnJqTXzmeiadH7UBD9lP2sC4KwM3O8DSn1WiD3C2ah5lNKz5ix5jKz
	 10JmT8yaBhcYaOHwuhlXf52gqe+Fyc1YjkLx0HgomFatZ8awBi08lK8gyn0YVzI8nB
	 i4qHvvn+qEObaOAq33kefqWvbFgpcnWd4TZmkbppEM7WNVQHevmncVCUs52k6L9zbI
	 Hg4YaQIPw67OakKp0Q1ICzg6a7OrMH6nP+AZSJ1JI8ZFfEhs3n5YwjdhlXiIpQTn5Y
	 c+i0a+CL6phoA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260923043023.3150498-4-namjain@linux.microsoft.com>
References: <20260923043023.3150498-1-namjain@linux.microsoft.com>
 <20260923043023.3150498-4-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 04:42:22 +0000
Message-Id: <20260923044222.C9B9A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> The irqchips used by msi_set_affinity() are initialized by
> x86_init_dev_msi_info(), which sets their irq_retrigger() callback to
> irq_chip_retrigger_hierarchy(). Call the hierarchy helper directly instead
> of invoking it indirectly through the irqchip callback.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260923043023.3150=
498-1-namjain@linux.microsoft.com?part=3D3

