Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3B50254C;
	Wed, 30 Sep 2026 14:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778397; cv=none; b=QilwMGTGWhNvrWNRFH7W0HwfQr6998jP4J7qBTJgdWC1KOO8isCu0qhwQya1ddDghAaNRuU5vb9iwZZrPXohkW16RykIM/qypZngStIR3p5MuZ3m2QXrnBKtkXU2fA89fZQmzG+NLumYrQhAX09BTwToQLTPbpKCB3cgwGXA16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778397; c=relaxed/simple;
	bh=f/oPS/6LN7AtyOJDdHaNlPVwRR3LelyTEwXtTG6kIsI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Xgzrfk5y1DTuI+hK6EkC2PKgGpsWaDKGOFUTdE38fat5dsrfEx5oFGBiIY99N2CEo14BVhHFteUSY40oqiDqkHF1W7UgVHrTKYEvGHvHfQXasPjWANSuArqneonWyRtw6QnQL7lM5vgoDfQSvTb4Kdxn2Hc4WGYZfbnx6J7KQvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dZTleuLf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dZTleuLf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF91B1F000FF;
	Wed, 30 Sep 2026 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778381;
	bh=BgElX6ix/uj8mU+GjZwgFWkmJAhx3eGKGdpZu2qmE3U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dZTleuLfBEbkNzxWEJd1W/0p7E8/klH95n5BcDYK7ZpL/JT9NEL5QwkMbTzvi4GeG
	 djeUgozHof5UJwhgfTsZtft+qvCJGXGi8gnjOOftcx7wLd+Uy+7KPMjS96ITAf2D/I
	 BLXWb99RsZ+KxDzBx0WidGevDYUL5BvxLGfkdZRIGFqN4bwCXQDC7kSM9jyB/9evTf
	 RS9NCO5/EXpO8RizEelXbtSOL/0mdkVWevaoxHaE9xVwUY/EPky+jraRWcxoTj7FWZ
	 yEYkYV1wAjef3xEfsdBr4qRKkNIFgB/dqw1pMPN3MiswvgLhpQRS37xe/IhS0TOHOD
	 J10RMs8Mw6e5w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] Drivers: hv: Add logical device ID registry for
 vPCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260930141409.437904-3-zhangyu1@linux.microsoft.com>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
 <20260930141409.437904-3-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:26:20 +0000
Message-Id: <20260930142620.CF91B1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] pci-hyperv: logical device ID leaked on remove after failed resu=
me
--

commit 60c40edaf8c7fd1e4ba684f1b2ec029a89674f03
Author: Yu Zhang <zhangyu1@linux.microsoft.com>
Drivers: hv: Add logical device ID registry for vPCI devices

This commit adds a registry in hv_common.c that maps a PCI domain number to
its logical device ID prefix. The vPCI bus driver registers the prefix when=
 a
bus is probed and unregisters it when the bus is removed.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd3..db70be47af6e1 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c

[ ... ]

> @@ -3978,6 +3985,8 @@ static void hv_pci_remove(struct hv_device *hdev)
> =20
>  	hbus =3D hv_get_drvdata(hdev);
>  	if (hbus->state =3D=3D hv_pcibus_installed) {
> +		int dom =3D hbus->bridge->domain_nr;
> +
>  		tasklet_disable(&hdev->channel->callback_event);
>  		hbus->state =3D hv_pcibus_removing;
>  		tasklet_enable(&hdev->channel->callback_event);
> @@ -3995,6 +4004,8 @@ static void hv_pci_remove(struct hv_device *hdev)
>  		hv_pci_remove_slots(hbus);
>  		pci_remove_root_bus(hbus->bridge->bus);
>  		pci_unlock_rescan_remove();
> +
> +		hv_pci_unregister_dev_id(dom);
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
Does this code leak the logical device ID if hv_pci_resume() fails?

If the device suspends and hv_pci_resume() fails, it leaves hbus->state
as hv_pcibus_init (or if hv_pci_suspend() fails, it leaves it as
hv_pcibus_removing). Later, when the device is unbound and hv_pci_remove()
is called, it skips this if (hbus->state =3D=3D hv_pcibus_installed) block,
omitting the required hv_pci_unregister_dev_id() call.

This will cause a memory leak of struct hv_pci_busdata and its hash table
entry. Because the domain remains registered, any subsequent probe (e.g.,
driver re-bind) will fail with -EEXIST in hv_pci_register_dev_id(),
permanently disabling the device until reboot.

Although the underlying hbus->state mishandling is pre-existing, the leaked
registry and the resulting -EEXIST probe failure are introduced in this pat=
ch.

>  	}
> =20
>  	hv_pci_bus_exit(hdev, false);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141409.4379=
04-1-zhangyu1@linux.microsoft.com?part=3D2
