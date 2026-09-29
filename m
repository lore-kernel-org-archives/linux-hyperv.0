Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D47F545DAF
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790706295; cv=none; b=sXPUYAWZOhQH/XLCN9nm5nBgfn4hcG+3IcA+377uKQ1RpM4o9g8nCE7REoNrtf5nXpY9qqENG9itT9ccBIXgED2SUdhPSlUbd1yip+CkBvM/xmzmLpzNFGYDCOkqC6whRO5vHRp+Foo93U1r1Hi4m0C2fn4aTsFLx5+35Jukh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790706295; c=relaxed/simple;
	bh=Fqx3KWI7zKF5EUe6C94Wva7dKRKSJh6v1+D4Wvd7Z6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RRLweG4yOITEAp06luBD65HPMKhJTZQx7abBUvspP1XR+adDCY/oogHmBI4RNYW8J+mpQAB265Xes17T+nf6Q6Y8uyvAqM3SvdIQhrygOz4yxuyIQtS/nvboZUddG8FSlO6fXlknhWIY0aj1/ihpUAxfENSlZJx5HlQzZCBsIeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SjB1zXAV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SjB1zXAV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0FF61F00893
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 18:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790706292;
	bh=3LDX7+Mud3J8zpXdkSNDNa5bDkRHbdnXtamokc+3+WM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SjB1zXAVHcEWSyy04t0xKLh4vANfjZ7jkgMABnSmYpkaV75cP5FCbQMmxmUXUzONr
	 db1qTL9LvTsNPaQNO0G/H64YNSm9xuKV0cwqI4UiBPXnsAa5Usjaxl8KaHjS7yRiXu
	 FsPuly5tl+i7rskXFuSVPE/nZs5ftybjPmv8C/mN1s48ZflzAGL9/VrBt5cMZ/uG8r
	 oxIfYdcVYIiWhSmhrwEfLmfdWs3I5AO4lqk3XTu9fg5g2MDaKGKlzhQOt0ugC2z4gg
	 y5oUJLSgFSejHOdWjTtYD03AbCAqmwZmI96JEm5aWzh1ELgmAfgb5baUl522HFNa7y
	 G0OptBkW3pWeQ==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b8cbb7b9cfso3657825e87.0
        for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 11:24:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwU+f+7h6hsVwbJTz52CWyPJXgJLmiDQLV3zhgGJHLFuA2AL064HuamOIJ8INq4wDd0BgpHjXsUkUtxStM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ8xCnmH988QoS06JVlbcaroCfn5FG6ugMmO55+TVA50Owl/BrY
	ioNoPtCRYe0kcvrCB2MPbK6z6ngf3jp51WPj9ZY+N3tQIRG4HlIJsteBnEFvPWgfdyEqi8oH/0s
	976AyURrUUysvH8gEwEJx959QS7Y3vhI=
X-Received: by 2002:a05:6512:6884:10b0:5b7:593c:244a with SMTP id
 2adb3069b0e04-5ba3bcc0f5cmr86226e87.44.1790706291286; Tue, 29 Sep 2026
 11:24:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260929181056.4746-1-mhklinux@outlook.com>
In-Reply-To: <20260929181056.4746-1-mhklinux@outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Tue, 29 Sep 2026 20:23:07 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jNJBCK1Zj0cVuTK3mtyJFF3MbEH8HKvTNKCa84eMUdmQ@mail.gmail.com>
X-Gm-Features: AclHuK-cFszhp4BxuzIJ6fUSdOus_BTEAFvvpq0fl1NsiwLrWWh5dCh7Xo8S6XY
Message-ID: <CAJZ5v0jNJBCK1Zj0cVuTK3mtyJFF3MbEH8HKvTNKCa84eMUdmQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in pcibios_root_bridge_prepare()
To: mhklinux@outlook.com
Cc: rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com, 
	linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 8:11=E2=80=AFPM Michael Kelley <mhkelley58@gmail.co=
m> wrote:
>
> pcibios_root_bridge_prepare() currently has code to handle Hyper-V
> guest root bridges with the sysdata parent field set to NULL. While
> this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
> Support root bridge preparation for Hyper-V") was accepted, more
> recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
> device to PCI device") always sets the sysdata parent field to a
> non-NULL value.
>
> No harm is caused by leaving the special case in place, even
> though it is no longer needed. But in the interest of overall
> code cleanliness, remove it.
>
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>

> ---
> This patch does not just do a revert of 7d40c0f70d92 because
> an intervening commit moved the code to a new source code
> file.
>
>  drivers/pci/pci-acpi.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 42d545edd7fa..452a90317c58 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_host_br=
idge *bridge)
>                 return 0;
>
>         cfg =3D bridge->bus->sysdata;
> -
> -       /*
> -        * On Hyper-V there is no corresponding ACPI device for a root br=
idge,
> -        * therefore ->parent is set as NULL by the driver. And set 'adev=
' as
> -        * NULL in this case because there is no proper ACPI device.
> -        */
> -       if (!cfg->parent)
> -               adev =3D NULL;
> -       else
> -               adev =3D to_acpi_device(cfg->parent);
> -
> +       adev =3D to_acpi_device(cfg->parent);
>         bus_dev =3D &bridge->bus->dev;
>
>         ACPI_COMPANION_SET(&bridge->dev, adev);
> --
> 2.25.1
>
