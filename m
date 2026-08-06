Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41BF47A888
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786027170; cv=none; b=qggdAzXXw9eOz4KzN7i1AC4B8qMVJC5gLLLrFqW4D5rZje72CAqbMgzyfl8Qfj2VohrIBJGytgnWXREUTgCgE1kPryC0Jb6OzIzlXRhR4vTlZnYSOn2bw8GaL4dA0sPBhHTGEBpwRyzuAhhYRR/+lNVsMzz/MxRSVcP8iF3DHyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786027170; c=relaxed/simple;
	bh=VhXJEk0ZlItF0tZ7suLZSuM9uf6Q2x0YW3unxxSC2Lc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=l32zNx4WMpfUDiLh2klY5Uke4DKjibig1/K/QwZOWGYys4QseyC1AoVPl3OUsyF+B4geCnMRcc42woZS8F0psUTjbycmjPknuD/3STA+DtCAksla1AHDSy22+v7VArd2RSFP4ioivPr0ltL/ouJ32KJyWiy+dHGxt3dDl7/TGp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQkSiCwv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQkSiCwv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609441F00A3D;
	Thu,  6 Aug 2026 14:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786027168;
	bh=0jNAoOScC/29TwVJzXqqWqkkxMAkfV9L6f5p79ikJ2o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jQkSiCwvswEpH4fJL5mlHK+xraWrh3Ct165YVnkSXIw0w7ItOH4oZp2iBLS3obbv+
	 E0jsVQwQY4iNB4q787P79BkFVoZytiOwln5ttYtdYY6h+yP7srGRz0pXr8iDcYWZrb
	 r9I0i3rZFIpREbRdrAaf/XcXDiwiObxKyi3zmbZfltLwDXyw3GgjRoN+Je2p1xEoVA
	 Toctp8HjRRDkx8lQr63yZoPoQEN/Pcqt9O0rlYFqI87adVZwzL1egzJJ0SZSXGnbeO
	 bJMpZQhCbgM1xsNTMMd4gWKntVsJ9duzw4HDFdEW4nef1R0BcoPd2ObLZDk7EyhMgf
	 bjhbCsj4A0Uqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: fix reset work race with device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805143812.220509-1-fanwu01@zju.edu.cn>
References: <20260805143812.220509-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:39:27 +0000
Message-Id: <20260806143928.609441F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces a 10-second sleep while holding the device co=
re lock (`device_lock`), which will block system PM and driver core operati=
ons.

Pre-existing issues:
- [High] Driver unbind unexpectedly triggers a full PCI bus rescan due to t=
he `!gc` check.
--

--- Patch [1]: [PATCH net] net: mana: fix reset work race with device remov=
al ---
commit 839c641df5112c8f696d580233f5a31b4e6686dd
Author: Fan Wu <fanwu01@zju.edu.cn>

net: mana: fix reset work race with device removal

The reset service work runs on the system workqueue and obtains the
GDMA context through PCI drvdata. It can race with device removal,
which frees the context, so this patch serializes mana_serv_reset()
with device removal by taking the PCI device lock.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
> @@ -591,15 +591,16 @@ static void mana_serv_fpga(struct pci_dev *pdev)
> =20
>  static void mana_serv_reset(struct pci_dev *pdev)
>  {
> -	struct gdma_context *gc =3D pci_get_drvdata(pdev);
> +	struct gdma_context *gc;
>  	struct hw_channel_context *hwc;
>  	int ret;
> =20
> +	device_lock(&pdev->dev);

[Severity: High]
Does holding device_lock() here cause a regression by stalling system PM
and driver core operations?

mana_serv_reset() calls msleep(MANA_SERVICE_PERIOD * 1000) (which is a 10
second sleep) further down in this function:

mana_serv_reset() {
        ...
        mana_gd_suspend(pdev, PMSG_SUSPEND);
        msleep(MANA_SERVICE_PERIOD * 1000);
        ...
}

Because system suspend loops over all devices and sequentially acquires
device_lock, would a suspend attempt or a user-space unbind operation
unconditionally hang for up to 10 seconds while waiting for this lock?

> +	gc =3D pci_get_drvdata(pdev);
>  	if (!gc) {
>  		/* Perform PCI rescan on device if GC is not set up */
>  		dev_err(&pdev->dev, "MANA service: GC not setup, rescanning\n");
> -		mana_serv_rescan(pdev);
> -		return;
> +		goto rescan;

[Severity: High]
This is a pre-existing issue, but if mana_gd_remove() is called due to a
standard driver unbind, it clears drvdata. If a pending reset work then
executes, acquires the lock, and observes gc =3D=3D NULL, it jumps to the r=
escan
label which forcefully removes the device and triggers a full PCI bus resca=
n.

Will this effectively defeat the user's attempt to unbind the driver and
disrupt the PCI topology?

>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805143812.2205=
09-1-fanwu01@zju.edu.cn?part=3D1
