Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64250296BB8;
	Tue, 25 Aug 2026 05:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787635817; cv=none; b=LPYpf045nsjWYpkEcVuOqkrL3fmXRyREf4lS79lHwg2K1NgmhOV71KdBvvx4mXv3VEOkQOQQml/cjUdPfLVHhkNex+vRDPQsOjM+8nCaFB/EWL2ZL4V+2QMHbcNi/GhMRxb+SP/XGv2q+zSXfNHL1sb+ZJU+h8/tSEYPgdkj7bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787635817; c=relaxed/simple;
	bh=XoN0q/eYiYGUIZn5OX+/IJVKEYWSL6/VB3NwApWJMGI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=bpn2QG+hv+4EfV5UrgTEvYcyDAuoqWHp+f7pNtifUi7Ocs83GU2A8Slm38Z7qiEkrLo5ztCiDzaHSJxV1P0iAjqcTCNn7XJH9oMej5nC1CmdQ/Odb98W1Z32nViS48rzTKt5jAGF3ch3kGIDhSX1heqyBulXr49GJsuOZq9D6UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KLQbAnJa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KLQbAnJa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26731F000E9;
	Tue, 25 Aug 2026 05:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787635815;
	bh=ucjKBFGl3teOd/f7urVYUh3YM8HAZa9ALMVF3BiA4Fw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KLQbAnJaS747qAZjn5mq1NuASsa8UkJa6Fe2RSYRJ5IS6+MmKwfBqvyy7lN9Xk/aF
	 d2lf+lo0hJObLmqvsROzBF3yhaBnLQtAfF7BZcRbnfNa6Va3NXwIRAiWZLxJ3/m8hM
	 x2sh7VvbLb2FQq+88kuJ53L8qVvobvmQ4EUagILvTjeHq9GAv2M1IYcDiWXCmvQ8CN
	 Hw/S/F5AV1y8NdGOS1cpSWN2WdIx1UGUDzFeHjmpBpktkZbXwnyTNCDFlw4y2/COWw
	 sHKbuyinLZS763/cW1RjhL1c4hmgUFXzgEyLO+2+IaO4LO7rxLcLawSucTqQG8gIF7
	 AVBccL1s44CnQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] PCI: hv: Warn when wait_for_response() waits
 indefinitely
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sahil Chandna" <sahilchandna@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
References: <20260825051850.2438816-1-sahilchandna@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 25 Aug 2026 05:30:15 +0000
Message-Id: <20260825053015.B26731F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Use-After-Free on Error Path for VMbus Completion Packets
--

--- Patch [1]: [PATCH] PCI: hv: Warn when wait_for_response() waits indefin=
itely ---
commit 7a3f315fe3798f61aaba375b4ed84ec32d84ef0f
Author: Sahil Chandna <sahilchandna@linux.microsoft.com>
PCI: hv: Warn when wait_for_response() waits indefinitely

This commit adds a periodic warning to wait_for_response() if the guest wai=
ts
too long for a rescind message or packet completion. This makes indefinite =
hangs
visible in the guest's kernel log so they can be correlated with host-side =
state.

Link: https://lore.kernel.org/linux-hyperv/20260612174010.2598695-1-hamzama=
hfooz@linux.microsoft.com/

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index cfc8fa403dad6..c4fba00391649 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
[ ... ]
>  static int wait_for_response(struct hv_device *hdev,
>  			     struct completion *comp)
>  {
> +	unsigned long delay =3D secs_to_jiffies(PCI_RESPONSE_HANG_TIMEOUT_SEC);
> +	u64 timeout =3D get_jiffies_64() + delay;
> +
>  	while (true) {
>  		if (hdev->channel->rescind) {
>  			dev_warn_once(&hdev->device, "The device is gone.\n");
>  			return -ENODEV;

[Severity: Critical]
This is a pre-existing issue, but does this early return on rescind lead to=
 a
use-after-free for the completion packets?

When wait_for_response() detects hdev->channel->rescind and returns -ENODEV,
callers like hv_read_config_block() will immediately return and unwind their
stack:

drivers/pci/controller/pci-hyperv.c:hv_read_config_block() {
    ...
    ret =3D wait_for_response(hbus->hdev, &comp_pkt.comp_pkt.host_event);
    if (ret)
        return ret;
    ...
}

This pops the stack frame containing the completion context without
deregistering the request. If a late completion packet arrives, wouldn't
hv_pci_onchannelcallback() retrieve the dangling pointer and execute the
invalid completion function?

drivers/pci/controller/pci-hyperv.c:hv_pci_onchannelcallback() {
    ...
            comp_packet =3D (struct pci_packet *)req_addr;
            response =3D (struct pci_response *)buffer;
            ...
            comp_packet->completion_func(comp_packet->compl_ctxt,
                                         response,
                                         bytes_recvd);
    ...
}

Could this result in memory corruption or a control-flow hijack if the
hypervisor sends a completion packet after the rescind offer, but before
the channel is completely closed?

>  		}
> =20
>  		if (wait_for_completion_timeout(comp, HZ / 10))
>  			break;
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260825051850.2438=
816-1-sahilchandna@linux.microsoft.com?part=3D1
