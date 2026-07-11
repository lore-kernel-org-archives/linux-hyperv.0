Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 470454499B8
	for <linux-hyperv@vger.kernel.org>; Sat, 11 Jul 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783798079; cv=none; b=GnjGEznFoEot+lIjquheCyMOTuzEujYrYTcv5NijEPOrUiTzBXQASOEwqOayzrKD/U4Zfve0YcVKqQECEMymWbfPbSGzgRiPV6m2F6mC3HYJ9+4McwSQQQczzQl7YFx2zLx1uFj/7svmli0NMUYh0D3S9kcwqYrw6iCimm0gD2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783798079; c=relaxed/simple;
	bh=NH9RMuY++mMBT/mgINYDJnTDdj+XRKYYUP+ucAhZmeI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=GyjUvzmJlMSy2eoL+qKp4xgtiFlp53+HtuRvVQOsIe0KM8r8mRYPa5CVzM0bGAX4yzQJ1pHt2pC8HzMd/4CXpizF4X6t+7s6q7cdokO90RyptLdLb4ev/FtzlzBmk3w2JZNuvwvYVckrDk5F473J+v3TetA7WIUNo81tKs/b0hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0aXU8is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0aXU8is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B29911F000E9;
	Sat, 11 Jul 2026 19:27:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783798077;
	bh=SG5NK0BWelKwajY6/Xu0BR3SOuyyIGghrS1WfAbwdJs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l0aXU8isAvs9nSWPEsIyy9fHq5rifefhtDW9CCi+mM5Pm2tdcR7IhSwIuK4rA51aw
	 AFBmg+e6YYF7griLLUL7GUgk9bLI593EpTf0eC1sRO36Tuh0NzQV+7Hj/FdDj+A08i
	 ltl1LWcWkjfmCcF2B+yKRpqfMWwVsmpvz8yKxFhR2cJn4qkz6mx6DaF4uTauSdCCX/
	 6jy2vTR7+G0nTEEHAWii6FDm8SGdPO2s9EOfRUIfqweoBMq5lujd2UFA0eg2XSFgbS
	 WR3+G0uuduzKW58yTI5YbEUaJ1kf09zzo5sIB+b5NjNctsLpmABqHthogqehCF8Is5
	 rOlCFfbvX9qtw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v4] net: mana: Add handler for sriov configure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haiyang Zhang" <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260710192735.2921300-1-haiyangz@linux.microsoft.com>
References: <20260710192735.2921300-1-haiyangz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 19:27:57 +0000
Message-Id: <20260711192757.B29911F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Uncancelled background works (`mana_serv_work` and `mana_dev_recov=
ery_work`) lead to Use-After-Free of `gdma_context` during device removal.
--

--- Patch [1]: [PATCH net-next v4] net: mana: Add handler for sriov configu=
re ---
commit d651d90ceb3e1716b100c2eb4035662f066b67fa
Author: Haiyang Zhang <haiyangz@microsoft.com>

net: mana: Add handler for sriov configure

This commit adds a callback function for the pci_driver / sriov_configure
interface. It requests the NIC to provide a specific number of VFs, or
disables VFs if the requested number is zero.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> index aef3b77229c13..a38d4bb74621f 100644
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -2456,6 +2456,8 @@ static void mana_gd_remove(struct pci_dev *pdev)
>  {
>  	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> =20
> +	pci_disable_sriov(pdev);
> +
>  	mana_rdma_remove(&gc->mana_ib);
>  	mana_remove(&gc->mana, false);

[Severity: High]
This is a pre-existing issue, but can this lead to a Use-After-Free of
gdma_context if there are uncancelled background works?

When mana_gd_remove() executes, it eventually frees the gdma_context via
vfree(gc) without flushing works like mana_serv_work or
mana_dev_recovery_work that might be pending on the system_wq.

If a hardware event triggers mana_gd_process_eqe() and schedules
serv_work before a hot-unplug, could the scheduled work run after
mana_gd_remove() has freed the context?

The worker thread mana_serv_func() calls mana_serv_reset(), which does:

    struct gdma_context *gc =3D pci_get_drvdata(pdev);
    ...
    hwc =3D gc->hwc.driver_data;

Since the PCI core only clears drvdata after remove() returns, this could
dereference the freed gc memory. Should these background works be
cancelled before freeing the context?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710192735.2921=
300-1-haiyangz@linux.microsoft.com?part=3D1
