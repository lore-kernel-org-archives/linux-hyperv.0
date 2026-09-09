Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E9F26ED40;
	Wed,  9 Sep 2026 06:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788936699; cv=none; b=O12zkq0x03o89m5DZsZh/9QGlCBj+gGpgHHUV2QRnNy5umGLqe6EEtbozW8JPQ4lrMoCHavnl7NSGlYUN3w7sDh7qQqglY7UvPHNdCJB3Yd3lZ5bbMR/EyGiZk8lidT1j0yog3d6ZeZvj5RhmdFg6yvkVU9BX/5M+i5shmPeMc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788936699; c=relaxed/simple;
	bh=/Vpv64L6HaZpc6gcMeg5p4tX3KbD1h7vocGCMAPotDY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Hi/PfWOR0+67vzgnzza5H7InCKuG4urQNiLKnmHzJ5Ip8mZgscqNaTi9HoIpnKQcJ6Tqf6f6oMYNCkDCR3jB0nKbOIJaMiYTRLgCK/YDEvqLJtbPd9hcfh6skxv9eigEIXQC62nfS02Xw0v6hiQ/3V5bW8yPQ6oJLrFXDMiDhj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXtOYHrq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXtOYHrq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693E41F00A3A;
	Wed,  9 Sep 2026 06:51:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788936697;
	bh=/Vpv64L6HaZpc6gcMeg5p4tX3KbD1h7vocGCMAPotDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IXtOYHrqA8cil3BoPFKsVVCCRhM3D+h/0tggo3R4p+sc+9FpGp86T+9A1AJ6BYXlA
	 gpbCJBx5H+0hzvRPohXG5wIhJ7JotCrHTXyZ1M4lCs7emLG5Xz7MN2eQXwhfwpPZkh
	 BaFB59sGJD/033uIETjwpwNukhtxaWuBEB39zUJxm/MLgliF8Ck6LrBnEYdeveZnvN
	 m8uvOhhTxAZQFlPuUAlz2FICQkGGDmVFdqBazSK6sPXj5Hc7K9Nq95xfLOg2zTCGKO
	 yiDwwKQvKFNC3G56x1rfAHJ6NJtVVDE9TuxliFc4hLL5CpuzN+7rUCipuChlJejNXN
	 GsHa6m/mvp2Sg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/4] x86/irq: Fall back to
 irq_chip_retrigger_hierarchy() in msi_set_affinity()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260909064448.1004-4-namjain@linux.microsoft.com>
References: <20260909064448.1004-1-namjain@linux.microsoft.com>
 <20260909064448.1004-4-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 06:51:36 +0000
Message-Id: <20260909065137.693E41F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> msi_set_affinity() re-injects a pending interrupt on its new target by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback directly, without checking whether that callback is present.
>=20
> Keep calling the outermost chip's irq_retrigger() when it is present,
> but fall back to irq_chip_retrigger_hierarchy() otherwise, which walks
> up the interrupt hierarchy until it finds a chip that implements
> irq_retrigger().
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909064448.1004=
-1-namjain@linux.microsoft.com?part=3D3

