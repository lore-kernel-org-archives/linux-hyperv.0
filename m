Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAB433A9F8
	for <linux-hyperv@vger.kernel.org>; Thu,  6 Aug 2026 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786026057; cv=none; b=AqJyg4e8znmv1c6w8c90nmyRn7aftflSW4hlL4YrWS8oSP1eNa2YgSvTPDFUB4AH4nTBqtRcDuE5dDQ/j7DeTYSotXf+/hDL0vPdSO2qrDTRCnQUZL2Wb24+V5wSN9sNyfJY2W0QlhJV8N/JrGWKoP0vp5g9ycnWl5mOyQKZQqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786026057; c=relaxed/simple;
	bh=eHHuItxQiXhPpFDz0gJ1DixpYcbqRQZE/LizmtkL3bk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=oPNqn/SFHBTTCRKK7/E5BWZjaa1XIiU73hH+yPtgsfvlssH5epJASZjQ+1ddjowrQz32OVE8VJ1ebB+UR+1pKj3HYixdGgxC0QEbNRXlX1baCFL5bkizszzG/z1JBaI6pgIw0/Mitgmy/7/FQIbxzr1Z1j110CueeD1v+1OlHAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMKAAH3V; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMKAAH3V"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBD11F000E9;
	Thu,  6 Aug 2026 14:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786026055;
	bh=zST+BEh4vjqs2vlYjdXh+DIhJOhE10Td5xzYbzNZ+P0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kMKAAH3VzUDi7NGmKdPXZ/4EKa1vq5GTNPFmjSkpd2HKa+wFpRt7R5vi4UgjkD5/6
	 p6GzH5NJV+0hiwG6ideqteeneCW7OGnR82lO4hZHNkh2QMZ6MJqE/rbnpwahXQZ/dh
	 KBLMCRThXO7JAJlxMWFxvlURDi256gqOdv0JdIgQTHSF245NsRS8r6dY0TEmaJsnZ7
	 uZqAihgeXeDQs3yNeieKQZhuWnmg7GMJCVjyiFzEv70/9oVwyQPErZKEeOT9rgDam6
	 iVvXfa2of6KVLOGPuG25WTJ5x6EaWom57LPCcXOG98z7KWoDBglU0NW6IMo0HRyDxA
	 3Japk0mWSJPyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net: mana: fix reset work race with device removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Fan Wu" <fanwu01@zju.edu.cn>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260805141937.217114-1-fanwu01@zju.edu.cn>
References: <20260805141937.217114-1-fanwu01@zju.edu.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 06 Aug 2026 14:20:54 +0000
Message-Id: <20260806142055.5CBD11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Clearing GC_IN_SERVICE before a PCI rescan allows a redundant 10=
-second reset cycle to race with device teardown.
--

--- Patch [1]: [PATCH net] net: mana: fix reset work race with device remov=
al ---
commit 09d0d942fe66b8d000decbfd0fc00c78cb2cea3c
Author: Fan Wu <fanwu01@zju.edu.cn>

net: mana: fix reset work race with device removal

This commit serializes the reset service work with device removal by holding
the PCI device lock. It ensures the GDMA context is not freed while a reset
is in progress. The lock is dropped before rescanning the PCI bus or when t=
he
reset completes.

> diff --git a/drivers/net/ethernet/microsoft/mana/gdma_main.c b/drivers/ne=
t/ethernet/microsoft/mana/gdma_main.c
> --- a/drivers/net/ethernet/microsoft/mana/gdma_main.c
> +++ b/drivers/net/ethernet/microsoft/mana/gdma_main.c
[ ... ]
> @@ -621,8 +622,8 @@ static void mana_serv_reset(struct pci_dev *pdev)
>  	if (ret =3D=3D -ETIMEDOUT || ret =3D=3D -EPROTO) {
>  		/* Perform PCI rescan on device if we failed on HWC */
>  		dev_err(&pdev->dev, "MANA service: resume failed, rescanning\n");
> -		mana_serv_rescan(pdev);
> -		return;
> +		clear_bit(GC_IN_SERVICE, &gc->flags);
> +		goto rescan;

[Severity: Medium]
If mana_gd_resume() fails, the driver clears GC_IN_SERVICE and releases the
device lock before calling pci_stop_and_remove_bus_device() via
mana_serv_rescan().

If the hardware repeatedly asserts errors and issues another reset request
during this window, mana_schedule_serv_work() could queue a new reset work.

That new work would immediately grab the device lock, observe a non-NULL gc,
and sleep for 10 seconds. This could block the PCI core from completing the
device teardown, as it requires the device lock to invoke the remove callba=
ck.

Does clearing GC_IN_SERVICE here before the PCI rescan open a race window
that delays device teardown?

>  	}
> =20
>  	if (ret)
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260805141937.2171=
14-1-fanwu01@zju.edu.cn?part=3D1
