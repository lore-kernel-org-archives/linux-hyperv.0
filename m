Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ADF8175A64;
	Sat, 17 Oct 2026 00:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792195922; cv=none; b=ofpiJZ18Gh+9zm3x2F5CU4wmP2xuqMrX/U8F02ezS9vaCrLeU8Ym08SD8APveI16TKx1t6cAEZ7pBdr2G10J3hCfz6RZC1XaHbYLQAmCp4XIeu3QcpVd+VxGPRMjlfY6QB4tePOLT/pWkPR1dEJg88c4OqgqmL3IPPyusvhm+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792195922; c=relaxed/simple;
	bh=yuk2OTZC/k/9aXNzEak54o9hoM3zyyKGbyaR82yJSo8=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=RDQm93jsccURtzHDwLzXe2YhnzQrxHjVEutYThnzXXs8EKmh3o1SVivc5Mk+zhf2sh6aRNatE6YAt2BiPdVRXLckO7s7CxDcCoZwSItDl3cE9r1N7jaUOXBtFfp7ADT8VTWK3+b7Aln7dsKA2aKwwWGVWwQ4C97AlR6eT0cbZ2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brVzAgYH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brVzAgYH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAB01F000C4;
	Sat, 17 Oct 2026 00:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792195920;
	bh=Zpf4Khns8EGSXQqrluTsrofGOJxz6W1quvKI/WW6JI4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brVzAgYHFlNkUrLyk3/KKgs6p+WB91/hwmyFJZMGKW2V6xZEypR/jgNaEWyqHQm09
	 1odqgeIYFZXr9NVbyN2AjeSB7H5NvEyHnwvGsKJ5n3cVjeiO+sUBJiTp2VdfrSYfNp
	 oEB4X708Ud4JLj80wkCqbOCVy1CRGRXMGBkRaKfqKGL2ukpbIhDZlXHFphF8DdUwdg
	 H+qHgB7rZXlzkLVbIIPPvk5t24knqERHrLlma4MIgvMPg9z/giHVo0dPrR3ffEbd5M
	 Q6mZ7LuhuODn09VVUbFxWuFQw8Wk8crY6lRtS+F2vepFqwVd96m9l5yD3eDGa9vUbv
	 pAGWy+aVW7aFQ==
Message-ID: <sashiko-outbox-175060@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] PCI: hv: add vPCI device reset support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hamza Mahfooz" <hamzamahfooz@linux.microsoft.com>, linux-hyperv@vger.kernel.org
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
References: <20261016235940.942090-1-hamzamahfooz@linux.microsoft.com>
 <20261016235940.942090-2-hamzamahfooz@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 17 Oct 2026 00:12:00 +0000
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] PCI: hv: hv_pci_reset_device() passes 3 arguments to wait_for_respo=
nse()
--

commit 5767f2b6950e5dc7da0b5c142f971d8282c27a56
Author: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>

PCI: hv: add vPCI device reset support

This commit negotiates Hyper-V vPCI protocol version 1.5 and implements the
reset_root_port() callback on pci_host_bridge by sending a PCI_RESET_DEVICE
request over the vPCI VMBus channel.

> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller=
/pci-hyperv.c
> index 89816a2bd7cd3..4bb4ca6da1f7b 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c

[ ... ]

> @@ -1397,6 +1401,52 @@ static int hv_pcifront_write_config(struct pci_bus=
 *bus, unsigned int devfn,
>  	return PCIBIOS_SUCCESSFUL;
>  }
> =20
> +static int hv_pci_reset_device(struct pci_host_bridge *bridge,
> +			       struct pci_dev *pdev)
> +{
> +	struct hv_pcibus_device *hbus =3D
> +		container_of(bridge->sysdata, struct hv_pcibus_device, sysdata);
> +	struct pci_child_message reset =3D {};
> +	struct hv_pci_compl comp_pkt;
> +	struct pci_packet pkt =3D {
> +		.completion_func =3D hv_pci_generic_compl,
> +		.compl_ctxt =3D &comp_pkt,
> +	};
> +	enum hv_pcibus_state state;
> +	int ret;
> +
> +	/* Do not take state_lock: eject holds it while removing/locking pdev. =
*/
> +	state =3D READ_ONCE(hbus->state);
> +	if (state !=3D hv_pcibus_probed && state !=3D hv_pcibus_installed)
> +		return -ENODEV;
> +
> +	init_completion(&comp_pkt.host_event);
> +	reset.message_type.type =3D PCI_RESET_DEVICE;
> +	reset.wslot.slot =3D devfn_to_wslot(pdev->devfn);
> +
> +	ret =3D vmbus_sendpacket(hbus->hdev->channel, &reset, sizeof(reset),
> +			       (unsigned long)&pkt, VM_PKT_DATA_INBAND,
> +			       VMBUS_DATA_PACKET_FLAG_COMPLETION_REQUESTED);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D wait_for_response(hbus->hdev, &comp_pkt.host_event,
> +				"PCI_RESET_DEVICE");

[Severity: Low]
Does this compile when CONFIG_PCI_HYPERV is enabled?

In drivers/pci/controller/pci-hyperv.c, wait_for_response() only accepts two
arguments:

static int wait_for_response(struct hv_device *hdev,
			     struct completion *comp)

Passing "PCI_RESET_DEVICE" as a third argument in hv_pci_reset_device()
causes the build to fail with too many arguments to wait_for_response().

> +	if (ret)
> +		return ret;
> +
> +	if (comp_pkt.completion_status =3D=3D STATUS_NOT_SUPPORTED)
> +		return -ENOTTY;
> +
> +	if (comp_pkt.completion_status) {
> +		pci_err(pdev, "Hyper-V device reset failed: %#x\n",
> +			comp_pkt.completion_status);
> +		return -EIO;
> +	}
> +
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261016235940.9420=
90-1-hamzamahfooz@linux.microsoft.com?part=3D2
