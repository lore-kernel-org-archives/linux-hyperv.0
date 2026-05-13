Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBED3357D0D;
	Wed, 13 May 2026 03:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778642780; cv=none; b=L+dyl5GUfuLz3fJX16BVKF8q1Od6377W45xQBlOarA7+5XChFPB7V8trlV7yehDgnwa3BEJfsewEnr44ge1g/9iW1cnVouRC5JmsN73wDJED9gRZ2F61TpsM1lXwo4+vgLpEqPRJ5NlNC+ZK8r5HJuACXyT9cPhX6yDYwzUO7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778642780; c=relaxed/simple;
	bh=A79S49VJDCMOREwNe+qoBpxMC873Ismfrsl1AsaZR4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=B62kUHvJ40/gfyqRgw4kTtC97zsGYYMft+2OWBUrW/2STdbXkisQcG7mkdIKLl9xxyKMc/lSYu9pNKiiGZ9oc50SodytQel+yjAB/T9NazcgjtjjEIjtLmldWcNc9nYwBgzHTQI7GMHtP0ez4c0sICJlqioj3/krCVkkXdKQTig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oitYgmE6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oitYgmE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 618D9C2BCB0;
	Wed, 13 May 2026 03:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778642780;
	bh=A79S49VJDCMOREwNe+qoBpxMC873Ismfrsl1AsaZR4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date:From;
	b=oitYgmE6X9He/OPEGSuR1FnpCdPT4eVF7aOR36uJXbmroGqm3uXiCgKbMxdurpwPR
	 5m16inG+4+S6+8Mjxezs/p+xvpQenjLui/ldjK4ah/SPB5WmsHl6zurl8o2ekkbQJa
	 W2xaorAS6/ZN36a3t90jb0WsQzY1nDUbV79/XNaeidYMQ6/9GdTsJgzY3uD+OCT6AI
	 fOalJExJ8IWMS6JYMrlNRR7ftgS9INOVfuYQB8ZKqq1o6u6rCMluTCAPIsD7EHWYXJ
	 sOYgaT5rBjya+BamZP/ZFS8d5imq15VC/ycAEsKEXfy2UntM+9jA3UpNjY2BTjrWzx
	 J6QeObH/J0jTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V3 02/11] x86/hyperv: Cosmetic changes in irqdomain.c
 for readability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260512020259.1678627-3-mrathor@linux.microsoft.com>
References: <20260512020259.1678627-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 13 May 2026 03:26:19 +0000
Message-Id: <20260513032620.618D9C2BCB0@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] Resource leak in `hv_msi_domain_free()` when freeing multiple IRQs.
- [High] Uninitialized memory write to hardware MSI registers in `hv_irq_co=
mpose_msi_msg()` error paths.
- [High] Invalid hardware state read in `hv_build_devid_type_pci()` for Typ=
e 0 PCI-X leaf devices.
--

commit 8c84576bf69ec6b4d58407408095bf71a9940bf2
Author: Mukesh R <mrathor@linux.microsoft.com>

x86/hyperv: Cosmetic changes in irqdomain.c for readability

Make cosmetic changes such as renaming variables for consistency, fixing
checkpatch warnings, updating indentation, and replacing spaces with tabs.

> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
[ ... ]
> @@ -115,67 +112,71 @@ static int get_rid_cb(struct pci_dev *pdev, u16 ali=
as, void *data)
>  	return 0;
>  }
> =20
> -static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
> +static union hv_device_id hv_build_devid_type_pci(struct pci_dev *pdev)
>  {
[ ... ]
> -	if (data.bridge) {
> -		int pos;
> +	if (data.bridge =3D=3D NULL)
> +		goto out;
> =20
> -		/*
> -		 * Microsoft Hypervisor requires a bus range when the bridge is
> -		 * running in PCI-X mode.
[ ... ]
> -		pos =3D pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
> -		if (pos) {
> -			u16 status;
> +	pos =3D pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
> +	if (pos) {
> +		u16 status;

If the leaf device is on the root bus, data.bridge will point to the leaf
device itself (a Type 0 device) after pci_for_each_dma_alias() completes.
Does this code incorrectly assume data.bridge is always a Type 1 bridge?

If it evaluates a Type 0 device here, reading PCI_X_BRIDGE_SSTATUS aliases
the Type 0 Command register. This could cause the code to read standard
Type 1 PCI_SECONDARY_BUS and PCI_SUBORDINATE_BUS offsets (which fall into
the middle of BAR2 for a Type 0 device), sending arbitrary BAR values as
shadow bus ranges to the hypervisor.

[ ... ]
> @@ -249,10 +253,8 @@ static void hv_irq_compose_msi_msg(struct irq_data *=
data, struct msi_msg *msg)
>  	}
> =20
>  	stored_entry =3D kzalloc_obj(*stored_entry, GFP_ATOMIC);
> -	if (!stored_entry) {
> -		pr_debug("%s: failed to allocate chip data\n", __func__);
> +	if (!stored_entry)
>  		return;
> -	}

If kzalloc_obj() or hv_map_msi_interrupt() fails, this returns early
without populating the struct msi_msg *msg parameter.

Since callers (like msi_domain_activate() or irq_chip_compose_msi_msg())
allocate msg on the stack and cannot check for errors due to the void
return type, does this result in uninitialized stack memory being blindly
written to the hardware MSI registers?

[ ... ]
> @@ -344,13 +351,15 @@ static int hv_msi_domain_alloc(struct irq_domain *d=
, unsigned int virq, unsigned
>  		return ret;
> =20
>  	for (int i =3D 0; i < nr_irqs; ++i) {
> -		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller, NULL,
> -				    handle_edge_irq, NULL, "edge");
> +		irq_domain_set_info(d, virq + i, 0, &hv_pci_msi_controller,
> +				    NULL, handle_edge_irq, NULL, "edge");
>  	}
> +
>  	return 0;
>  }
> =20
> -static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq, =
unsigned int nr_irqs)
> +static void hv_msi_domain_free(struct irq_domain *d, unsigned int virq,
> +			       unsigned int nr_irqs)
>  {
>  	for (int i =3D 0; i < nr_irqs; ++i) {
>  		struct irq_data *irqd =3D irq_domain_get_irq_data(d, virq);

Does this loop leak chip_data and leave IRQs mapped in the hypervisor for
the remaining nr_irqs - 1 IRQs?

It appears to call irq_domain_get_irq_data() using the base virq on every
iteration instead of virq + i, causing hv_teardown_msi_irq() to be
repeatedly invoked on the first IRQ only.

> @@ -362,6 +371,7 @@ static void hv_msi_domain_free(struct irq_domain *d, =
unsigned int virq, unsigned
> =20
>  		hv_teardown_msi_irq(to_pci_dev(desc->dev), irqd);
>  	}
> +
>  	irq_domain_free_irqs_top(d, virq, nr_irqs);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260512020259.1678=
627-1-mrathor@linux.microsoft.com?part=3D2
