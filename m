Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792691474;
	b=IJ8oXThMQrtVk9J9xjeGMDnzYn9Xf9JVG7BxyAGPEzFfXJo67X1E50Ny0Sk0F7dT/iw0
	 PGxE4Jd8p+a6YeWmHljAlR/Sn2IE5shkpAkYsTVrImu2tcVoe06NvZ6B6E6v5dy8BEppG
	 CPyy80QL78tZJPryo5fv6cx7tQ4uN0+8OqAa0Rinix0Co1DSCS+Amkw2Y8kWvzshKazfB
	 5/ghHT95BcTWsvANzJctDnTg+L87GS/jfl777HSu3ZNGtbqz2EBfMeMXDbhmchw/W0Fhr
	 g4Xosp7Cvs8gngWFtXDSDAoCe2IVN/fqE6ymidANlsB8Xp5vEh1nSYbvZDhG/jPIAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792691474;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=R9bdZDRYMZKsVAULKpGjrw6cvUzg31C4HzoC6qyPpxg=;
	b=wIFPeGXcyraecQxAADUjl7uK5Ys6sS68T7zllA4hmAkfDyP2jhkCm0hisPFP9fd+1SfX
	 ftLSLngPi1508NdGRxKFzMcloJNlDAtqSjUrJJ9Mzi3tIb2G49XBIvFO6poxQySufOG0B
	 y4MzflbXrgWH9WxEvHFs2HOyDzABI7w6/hHcNu50NErRXooSd2G3s4dOYQPwLa8eU656k
	 iqCKWKppZ+DFUAyo94ZYhcVqTmEcBJpA+dXphh4SRa2PZOQb4sDacW8usrzw3m9N/37ow
	 7MnWV/uoNh+4MOLNulXKTKSrqIwgKgzlNnLI4tOxkMi1U1StLAtaCLEmj3hh5P4PPuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9IbipuY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62321606A322
	for <linux-hyperv@vger.kernel.org>; Thu, 22 Oct 2026 17:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R9IbipuY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 081D71F031E1
	for <linux-hyperv@vger.kernel.org>; Thu, 22 Oct 2026 17:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792691473;
	bh=R9bdZDRYMZKsVAULKpGjrw6cvUzg31C4HzoC6qyPpxg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=R9IbipuYeS8U8DQjU7FPkEmEfIf/NPdYmnwjw4RBtvBDFJyTi4hs16qhmd1n58ea/
	 s5839OU9KCvFmKdlWE4KfWSONHMELitgDXuZ+X8ruWu/dWqnMhlqZMaMR7jUnMpCYU
	 JzKya07J0bW4TOMQn9gyKSU1QoWuBGjlrtmQ2KzcBq53aT6HL/pXLn26yVpp6aPYb8
	 uhXN94xc6uQogzFzd2wU0TMDYAWu8XqvRMxEOfjXiREuGL4mZjWzBVGLioOf2GZdfR
	 y68MvYNYbWEOpHzRTtnH0/qTdYWF08wrm2dzfnac8RUBPS+JhpgafVsw++RPCYsbF4
	 9cpr/6urTomQg==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5be3db57938so1676345e87.0
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Oct 2026 10:51:12 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxkwKiWm0elNIiRajTVjQeLopx4lT0xKtwFK+bTOERQN15iGUe6KDprRo8aZ4CGTwCjHS/o/JqjdmJkOAI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKIEkltnDkxzXC4VX3otKyI30BHCwSJ06Z85CgsM9GGBpcz3zj/
	7Dq44uYjgIO82h7H1WYmi7PWrQEy/mtTj+pT6QGLJjffTT/7V3tvjAfQ5kAQcn2bVplKfIh1cno
	xvn8QQwR14UTgtljxJRE6QEfkpqAON6A=
X-Received: by 2002:a05:6512:124e:b0:5bf:a036:3e4b with SMTP id
 2adb3069b0e04-5bfa1bb87d5mr2514627e87.7.1792691471347; Thu, 22 Oct 2026
 10:51:11 -0700 (PDT)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929181056.4746-1-mhklinux@outlook.com> <CAJZ5v0jNJBCK1Zj0cVuTK3mtyJFF3MbEH8HKvTNKCa84eMUdmQ@mail.gmail.com>
 <MN2PR02MB6863A57660077B2466B77FB8D4652@MN2PR02MB6863.namprd02.prod.outlook.com>
In-Reply-To: <MN2PR02MB6863A57660077B2466B77FB8D4652@MN2PR02MB6863.namprd02.prod.outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 22 Oct 2026 19:48:51 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iSn8_sxdaXcSv8zvzwUpUPVTHpZw0Tg-OEPmq+xAFOmw@mail.gmail.com>
X-Gm-Features: AclHuK9OQn02mgBMGrBtFonnYHv87q3DVWCFzjepFTk63xsOK8_QFIiC_dLyc3Y
Message-ID: <CAJZ5v0iSn8_sxdaXcSv8zvzwUpUPVTHpZw0Tg-OEPmq+xAFOmw@mail.gmail.com>
Subject: Re: [PATCH 1/1] PCI/ACPI: Remove Hyper-V special case in pcibios_root_bridge_prepare()
To: Michael Kelley <mhklinux@outlook.com>, "bhelgaas@google.com" <bhelgaas@google.com>
Cc: "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, 
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 22, 2026 at 7:14=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Rafael J. Wysocki (Intel) <rafael@kernel.org> Sent: Tuesday, Septem=
ber 29, 2026 11:23 AM
> >
> > On Tue, Sep 29, 2026 at 8:11=E2=80=AFPM Michael Kelley <mhkelley58@gmai=
l.com> wrote:
> > >
> > > pcibios_root_bridge_prepare() currently has code to handle Hyper-V
> > > guest root bridges with the sysdata parent field set to NULL. While
> > > this special case existed when commit 7d40c0f70d92 ("arm64: PCI:
> > > Support root bridge preparation for Hyper-V") was accepted, more
> > > recent commit 8d21732475c6 ("PCI: hv: Propagate coherence from VMbus
> > > device to PCI device") always sets the sysdata parent field to a
> > > non-NULL value.
> > >
> > > No harm is caused by leaving the special case in place, even
> > > though it is no longer needed. But in the interest of overall
> > > code cleanliness, remove it.
> > >
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> >
> > Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
>
> Is anything else needed for this patch?  I presume it should
> be picked up in the PCI tree.

Right.

I can pick it up, but then I'd rather have an ACK from Bjorn.  Or we
can try asking directly:

Bjorn, if you have any objections or concerns regarding this, please
let me know.

> >
> > > ---
> > > This patch does not just do a revert of 7d40c0f70d92 because
> > > an intervening commit moved the code to a new source code
> > > file.
> > >
> > >  drivers/pci/pci-acpi.c | 12 +-----------
> > >  1 file changed, 1 insertion(+), 11 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > index 42d545edd7fa..452a90317c58 100644
> > > --- a/drivers/pci/pci-acpi.c
> > > +++ b/drivers/pci/pci-acpi.c
> > > @@ -1572,17 +1572,7 @@ int pcibios_root_bridge_prepare(struct pci_hos=
t_bridge *bridge)
> > >                 return 0;
> > >
> > >         cfg =3D bridge->bus->sysdata;
> > > -
> > > -       /*
> > > -        * On Hyper-V there is no corresponding ACPI device for a roo=
t bridge,
> > > -        * therefore ->parent is set as NULL by the driver. And set '=
adev' as
> > > -        * NULL in this case because there is no proper ACPI device.
> > > -        */
> > > -       if (!cfg->parent)
> > > -               adev =3D NULL;
> > > -       else
> > > -               adev =3D to_acpi_device(cfg->parent);
> > > -
> > > +       adev =3D to_acpi_device(cfg->parent);
> > >         bus_dev =3D &bridge->bus->dev;
> > >
> > >         ACPI_COMPANION_SET(&bridge->dev, adev);
> > > --
> > > 2.25.1
> > >
>
