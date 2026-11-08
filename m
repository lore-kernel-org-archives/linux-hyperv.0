Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794156955;
	b=zMRtxUkDmB1TBZI4nhVncV39ghE1WwKMDAiMm55yeoT5Oy/G7wqUMz8au73bS4mbZh1W
	 AjPEcvZaq4SWkx3obCosdtzH5kCbrE5VoL69hZWbdshr/6IxN5kk/f5x2ncB4pf7j2T3D
	 URvl37UXlmjco2lIje8e7gvLQwl2Ic1Uj4dfEJa2RQp3jvzTTv+yXq7JeonxIerigJ2ip
	 MbqqxBzG/5RYPkMeNEKtMkfbn6XoG895v03c8KEw3xUziPnWX7soIC65Me2ZAvrpHzYXt
	 1WCm6O0K1AjjMLcXy7AtrIqLQGGURUV6OJTcQlGKmabjodXmFgf3ybQxZxjf7nNF2Jw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794156955;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=5clIn+ab69f599ujad42Koar5tkf18xn+pTKzRnZxkc=;
	b=WSDPqh2oVlOsdYZtf2YIIMUOf0L3ggBF5EizPxO5qEd5NZabTO5KlRVIqLnegbYkCwRU
	 45R65TS5+NLnmpPOKDNZmVsFZdqAX81TZao8estrMPfI262D6VPYun79sjiKCQy4lQgl8
	 c7Qf4g4qdxNZrD4loW/HKDX5hoygvj+yiTLJEBRtE/iVFYkD7N3WbYUWDuutFlnT8Go9X
	 JaJJA8LeBhdXCbEjzH89vm0WUi/LF93SnYoa/fxmFGMZR3DabWO2Y14mNuLeufAcAPK/5
	 4BgQvm+bQEmoP5U2G5ZNPcyGZbABfxsjrmgPvkwBkXYTibWUgO5FCEiwtxBEhmpYY2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsqPxGrV;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hbCm5wxD;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9085A606A31C
	for <linux-hyperv@vger.kernel.org>; Sun,  8 Nov 2026 16:55:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9085A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NsqPxGrV;
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=hbCm5wxD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794156952;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5clIn+ab69f599ujad42Koar5tkf18xn+pTKzRnZxkc=;
	b=NsqPxGrVQJsYLfFXHR9KSa8uhJNA17swjEhsNA1CCPBbXMBO0Kt0V6EHAv9zU1dFifl8KH
	xvzy8GjxfuJbMdWoNc2Lp2UYAaJsdvyG79qJM2QeN029X9eYFV5u2MIcVvUKad1x2b2jpi
	fwhcWkQbbe3auJo7cfGqtYU4wLah06A=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-fm38rydyOF2bzP7FZiMz3g-1; Sun, 08 Nov 2026 11:55:51 -0500
X-MC-Unique: fm38rydyOF2bzP7FZiMz3g-1
X-Mimecast-MFC-AGG-ID: fm38rydyOF2bzP7FZiMz3g_1794156951
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f37c94ceeso45270585a.1
        for <linux-hyperv@vger.kernel.org>; Sun, 08 Nov 2026 08:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794156951; x=1794761751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5clIn+ab69f599ujad42Koar5tkf18xn+pTKzRnZxkc=;
        b=hbCm5wxDrXfgqKa/QGGbAD1Qh4yBpwoRN64DpO4NVqJuHJ37RMZ7hwhnwHznKIFoGN
         dGWC96rX4gO9cjy4Ir/IoPDkS7fviQvS91g3nROM8W5uH1dwBWkqn8b2TSu5ZdnEdC/H
         SgVk58mU+awxkC4GAUDfVamnbBfQ+x9+LZ5lBI7AHE7s+faNvrlzgsaOE8RiyhCiZRaL
         7xyW1hVETqvC9Q1hPkrn+9fD2cPH+z8REN8K1bnt75CNniVaEm9cFTjBZVwtAfdjpfSN
         i0Mdz/U9DFu/15BzcXjFijypIRZpRmpe1KXh3ggLcT+Tj8W2GlFBsvTNdkusO25w8EvZ
         Jepw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794156951; x=1794761751;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5clIn+ab69f599ujad42Koar5tkf18xn+pTKzRnZxkc=;
        b=ninEKmrpnL3XFOYQpcolZ8X9t/LzoT7yVXdCGFUJ0VC7Y+frzFJ03+5cMtpHwKJHNi
         cm1Eke1FIaLOMslwjkKRcGQW9ZwVAX9jyOvogttE3clsvc7Z0wFD2pLF9t4xkKDTIjgG
         7UqlYXMzNgCXB9H1pAHgZ9hS4wl7HQItpjrwrKjMwMDO4hOBEyncFYivBP8xabzCLQN2
         mEYqBeXqfaL0oOwMnDKj43bl9O6ne8hhbA09OqabFeVyzPunzKSGOSTk0GdRkKOkIKcY
         0+Znpixp366xMPgYrjt3JjUK8HlPn5Z+yhCmAMkiuqqrADpUNMQnIPJzk+t0Jw5LYTsn
         9yFQ==
X-Forwarded-Encrypted: i=1; AL+hErFe5NhPJTQMs2cRiDN5iKuWTMU5DdUMIl0O4TaqAM4kgEPz2vCBd23dm8wQHqU6v2xvNG+GTQZVEeCYpuA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+3oJ8GyXHEq6/OZ0bcDLpUdn/qSGttEW4K2cmYEccmP39elGvR
	+m34mrl7veYLunOu0hS7BWnGNHARz29Oxe7mdsjwUVIfJ17gYAzpRHtLXtRRi+NYa3GysSTUcXV
	S994PeFWuVJLJyb7FQoYB5+jAK7c8UQ2JFmIktbgCiW0LzsoxS9IUK4qu4ka14lXAGQ==
X-Gm-Gg: AYBFou3eN690Wgx96/9+qH8m5sE3p5wej3yPX5uINOSyqM2QIIkYqmsllHTolAG9aPy
	i9M0ybDHAdMrxGGSWVAFgQAVVLrZ8uFxzvLbIfXdMlTBJUnZeEGdZeJ6v0fdRZLHcSsK2jbjwSY
	TE85zNBdnGnhl08q50nrTr6HN4rm1dX/62bXYDJzUbjJqOFwDFcOVlCZHkB0Nsv4/fsISz9VsLi
	EH/iKA5s+OvgxVRmeC0vMOmNRJMJ9OJ35YEB4c5lzyyysogg0vGuPWp0HyWlvWNh9mY/UGFnNOa
	CWRDaJTw/16UHjIkYIUR5+t3GAv0gLobdi1zAxtg84/kp4loYZz76BPQbuYieueo5SkLvfCT/yp
	+HBEg8OefiqcaBW3fHjq2a3eYhvS0aOzG8SxCuzl9WLSpfH8ky8nE8wd2fAqajX+XEkl9hJfjrP
	uNKeEwtso9mXtTGJEl5fqgeo2nlwqXLSRYa3YZ9khy659D607QNj9yk8XspZ7hqxP7rYC8OA==
X-Received: by 2002:a05:620a:1724:b0:93f:1789:8359 with SMTP id af79cd13be357-94604dd4bc2mr725762585a.31.1794156950616;
        Sun, 08 Nov 2026 08:55:50 -0800 (PST)
X-Received: by 2002:a05:620a:1724:b0:93f:1789:8359 with SMTP id af79cd13be357-94604dd4bc2mr725760485a.31.1794156950063;
        Sun, 08 Nov 2026 08:55:50 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94782ccaea3sm250464985a.4.2026.11.08.08.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 08:55:49 -0800 (PST)
Message-ID: <b6b39c415514de821d8a71cefda41f3d4f53405a.camel@redhat.com>
Subject: Re: [RFC PATCH] scsi: qla2xxx: Use the real INTx pin for the port
 number on Hyper-V guests
From: Laurence Oberman <loberman@redhat.com>
To: Michael Kelley <mhklinux@outlook.com>, "njavali@marvell.com"	
 <njavali@marvell.com>, "martin.petersen@oracle.com"
 <martin.petersen@oracle.com>,  "wei.liu@kernel.org"	 <wei.liu@kernel.org>,
 Mukesh R <mrathor@linux.microsoft.com>
Cc: "GR-QLogic-Storage-Upstream@marvell.com"
	 <GR-QLogic-Storage-Upstream@marvell.com>, 
 "James.Bottomley@HansenPartnership.com"
	 <James.Bottomley@HansenPartnership.com>, "haiyangz@microsoft.com"
	 <haiyangz@microsoft.com>, "decui@microsoft.com" <decui@microsoft.com>, 
 "sbhat@linux.ibm.com"
	 <sbhat@linux.ibm.com>, "kmahlkuc@linux.ibm.com" <kmahlkuc@linux.ibm.com>, 
 "linux-scsi@vger.kernel.org"
	 <linux-scsi@vger.kernel.org>, "linux-hyperv@vger.kernel.org"
	 <linux-hyperv@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	 <linux-kernel@vger.kernel.org>
Date: Sun, 08 Nov 2026 11:55:47 -0500
In-Reply-To: <080f3cc7097c9a8191e4fa2f03ff2d67d0640f40.camel@redhat.com>
References: <20261104222541.2675051-1-loberman@redhat.com>
		 <MN2PR02MB68634FAAFE0BA7C4DB3153D9D4772@MN2PR02MB6863.namprd02.prod.outlook.com>
	 <080f3cc7097c9a8191e4fa2f03ff2d67d0640f40.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Sat, 2026-11-07 at 10:14 -0500, Laurence Oberman wrote:
> On Thu, 2026-11-05 at 00:46 +0000, Michael Kelley wrote:
> > From: Laurence Oberman <loberman@redhat.com> Sent: Wednesday,
> > November 4, 2026 2:26 PM
> > >=20
> > > qla2x00_set_isp_flags() derives the physical port number from
> > > PCI_INTERRUPT_PIN, and the port number selects the per-port VPD,
> > > NVRAM,
> > > NPIV and FCP priority flash regions.
> > >=20
> > > On Hyper-V guests, pci-hyperv returns 0 for byte and word reads
> > > of
> > > PCI_INTERRUPT_PIN since commit fea93a3e5d5e ("PCI: hv: Return
> > > zero,
> > > not
> > > garbage, when reading PCI_INTERRUPT_PIN"). Commit 7268e509b43a
> > > ("scsi:
> > > qla2xxx: Handle INTx not connected while passing through") then
> > > falls
> > > back to PCI_FUNC(). With Discrete Device Assignment (DDA), each
> > > function
> > > of a multi-port HBA is presented as function 0 in its own PCI
> > > domain, so
> > > every port gets port_no 0. All ports read port 0's NVRAM, pass
> > > the
> > > checksum and register the same WWPN, and nothing is logged.
> > >=20
> > > Without that commit, port_no underflows to 255, no flash region
> > > is
> > > selected and every port fails with "Inconsistent NVRAM checksum"
> > > and
> > > falls back to the default WWPN.
> > >=20
> > > pci-hyperv only zeroes byte and word accesses within 0x3c-0x3d. A
> > > dword
> > > read at PCI_INTERRUPT_LINE reaches the device's config space and
> > > returns
> > > the real pin in bits 15:8. On Hyper-V guests, use that when the
> > > byte
> > > read returns 0, and warn if the pin is still 0 so that duplicate
> > > WWPNs
> > > are not silent. Bare metal, KVM/vfio and other hypervisors are
> > > unchanged.
> >=20
> > There's a patch in flight [1] that kills the behavior that your
> > patch
> > takes
> > advantage of. I don't have knowledge of the full details that
> > motivated [1],
> > so maybe Mukesh Rathor or Wei Liu can add some info, as well as
> > comment on the validity of what you are observing as a possible
> > work-around to the qla2xxx problem.
> >=20
> > Michael
> >=20
> > [1]
> > https://lore.kernel.org/linux-hyperv/20260913232255.2801797-1-wei.liu@k=
ernel.org/
> >=20
> > >=20
> > > Tested with an equivalent change on a RHEL 9 (5.14-based) guest
> > > with a
> > > dual-port QLE2692 (ISP2261) assigned through DDA (Hyper-V host
> > > 10.0.17763):
> > >=20
> > > =C2=A0 before: both ports "Inconsistent NVRAM checksum=3D0xffffffc0
> > > id=3DNGKP",
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both WWPN 0x21=
0000e08b1c5586
> > > =C2=A0 after:=C2=A0 port_no 1 and 0, NVRAM valid, WWPN 0x210034800d70=
65bd
> > > and
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x210034800d70=
65bc, fabric login and FC-NVMe localport
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 registration o=
n both ports
> > >=20
> > > Also tested on bare metal (ISP2031): the new path is not taken
> > > and
> > > port
> > > numbers and WWPNs are unchanged.
> > >=20
> > > Signed-off-by: Laurence Oberman <loberman@redhat.com>
> > > ---
> > > RFC: this relies on pci-hyperv not virtualizing dword reads at
> > > 0x3c,
> > > which is an implementation detail rather than an interface. It is
> > > posted
> > > as the smallest working fix and to start the discussion. Feedback
> > > wanted
> > > on cleaner alternatives:
> > >=20
> > > =C2=A0- Hyper-V (linux-hyperv): could pci-hyperv expose the real
> > > =C2=A0=C2=A0 PCI_INTERRUPT_PIN, or provide the physical function numb=
er,
> > > for
> > > DDA
> > > =C2=A0=C2=A0 devices? Some drivers use the pin for port identity, not=
 only
> > > for
> > > =C2=A0=C2=A0 interrupt routing.
> > >=20
> > > =C2=A0- Marvell: is there a firmware or register source for the
> > > physical
> > > =C2=A0=C2=A0 port that does not depend on PCI config space? CSRX_FUNC=
TION
> > > in
> > > =C2=A0=C2=A0 ctrl_status is a single bit and would not cover quad-por=
t
> > > =C2=A0=C2=A0 27xx/28xx/29xx.
> > >=20
> > > =C2=A0- The check is x86-only (hypervisor_is_type()). pci-hyperv also
> > > =C2=A0=C2=A0 supports arm64 guests; a better way to detect a pci-hype=
rv bus
> > > is
> > > =C2=A0=C2=A0 welcome.
> > >=20
> > > This has not yet been tested on a 7.3 kernel in the DDA guest;
> > > testing
> > > was on a RHEL 9.8 backport. The upstream behaviour without this
> > > patch
> > > (duplicate WWPNs with no warning) follows from the code and has
> > > not
> > > yet
> > > been reproduced on 7.3.
> > >=20
> > > =C2=A0drivers/scsi/qla2xxx/qla_os.c | 40
> > > ++++++++++++++++++++++++++++++++++-
> > > =C2=A01 file changed, 39 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/scsi/qla2xxx/qla_os.c
> > > b/drivers/scsi/qla2xxx/qla_os.c
> > > index 3c412c7fb6fe..4180d3f15231 100644
> > > --- a/drivers/scsi/qla2xxx/qla_os.c
> > > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > > @@ -24,6 +24,10 @@
> > > =C2=A0#include <scsi/scsi_transport.h>
> > > =C2=A0#include <scsi/scsi_transport_fc.h>
> > >=20
> > > +#ifdef CONFIG_X86
> > > +#include <asm/hypervisor.h>
> > > +#endif
> > > +
> > > =C2=A0#include "qla_target.h"
> > >=20
> > > =C2=A0/*
> > > @@ -2704,6 +2708,40 @@ static struct isp_operations
> > > qla29xx_isp_ops
> > > =3D {
> > > =C2=A0	.initialize_adapter	=3D qla2x00_initialize_adapter,
> > > =C2=A0};
> > >=20
> > > +/*
> > > + * Read the INTx pin used to derive the physical port number.
> > > + *
> > > + * pci-hyperv hard-wires byte and word reads of
> > > PCI_INTERRUPT_PIN
> > > to zero.
> > > + * With Hyper-V Discrete Device Assignment every function is
> > > also
> > > presented
> > > + * as function 0 in its own PCI domain, so the PCI_FUNC()
> > > fallback
> > > gives
> > > + * port 0 for every port and they all report port 0's WWPN. A
> > > dword read at
> > > + * PCI_INTERRUPT_LINE is not virtualized by pci-hyperv and
> > > returns
> > > the
> > > + * device's pin in bits 15:8, so use that on Hyper-V guests.
> > > + */
> > > +static u8
> > > +qla2x00_get_intx_pin(struct qla_hw_data *ha)
> > > +{
> > > +	u8 pin;
> > > +
> > > +	pci_read_config_byte(ha->pdev, PCI_INTERRUPT_PIN, &pin);
> > > +#ifdef CONFIG_X86
> > > +	if (!pin && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
> > > +		u32 val =3D 0;
> > > +
> > > +		pci_read_config_dword(ha->pdev,
> > > PCI_INTERRUPT_LINE, &val);
> > > +		pin =3D (val >> 8) & 0xff;
> > > +		if (pin)
> > > +			ql_log_pci(ql_log_info, ha->pdev,
> > > 0xffff,
> > > +				=C2=A0=C2=A0 "Hyper-V: INTx pin reads 0,
> > > config dword 0x%08x
> > > gives pin %u.\n",
> > > +				=C2=A0=C2=A0 val, pin);
> > > +		else
> > > +			ql_log_pci(ql_log_warn, ha->pdev,
> > > 0xffff,
> > > +				=C2=A0=C2=A0 "Hyper-V: unable to determine
> > > physical port, ports
> > > may report duplicate WWPNs.\n");
> > > +	}
> > > +#endif
> > > +	return pin;
> > > +}
> > > +
> > > =C2=A0static inline void
> > > =C2=A0qla2x00_set_isp_flags(struct qla_hw_data *ha)
> > > =C2=A0{
> > > @@ -2887,7 +2925,7 @@ qla2x00_set_isp_flags(struct qla_hw_data
> > > *ha)
> > > =C2=A0		ha->port_no =3D ha->portnum & 1;
> > > =C2=A0	else {
> > > =C2=A0		/* Get adapter physical port no from interrupt
> > > pin
> > > register. */
> > > -		pci_read_config_byte(ha->pdev,
> > > PCI_INTERRUPT_PIN,
> > > &ha->port_no);
> > > +		ha->port_no =3D qla2x00_get_intx_pin(ha);
> > > =C2=A0		if (ha->port_no =3D=3D 0) {
> > > =C2=A0			/* None of INT[A|B|C|D] may be
> > > virtualized
> > > by vfio */
> > > =C2=A0			ha->port_no =3D PCI_FUNC(ha->pdev->devfn);
> > > --
> > > 2.56.0
> > >=20
> Hello Michael,
>=20
> Thanks very much for the information. I will follow the thread.=C2=A0
> Our main pressing issue is any guest on HYPER-V with DDA moving to
> RHEL9 from RHEL8 loses functionality for the pass-through qla2xxx
> ports
>=20
> Regards
> Laurence
Hi Michael,

Thanks, that settles it. With "PCI: hv: hardwire PCI_INTERRUPT_PIN to
0"
any read covering 0x3d returns 0, so qla2xxx cannot use the pin under
DDA at all. Please consider this RFC withdrawn.

The qla2xxx problem itself remains. The driver uses the pin, not for
interrupts, but as its only indication of which physical port a
function
is on. That selects the per-port VPD, NVRAM, NPIV and FCP priority
flash
regions. Under DDA each function is presented as function 0 in its own
domain, so PCI_FUNC() cannot tell the ports apart either, and every
port
of a dual-port QLE2692 comes up with port 0's WWPN.

Wei, Mukesh: if there is a supported way for a guest to learn the
physical function of a DDA-assigned device, qla2xxx could use it.
Otherwise I think this has to be solved in the driver.

Nilesh: on the same guest, the -1015 mailbox dump logged by the Marvell
out-of-tree driver at init differs between the two ports only in
mb[15]:

  pin A port: mb[8-15] 0003h 0001h 0001h 0001h f080h 0000h 0008h 0000h
  pin B port: mb[8-15] 0003h 0001h 0001h 0001h f080h 0000h 0008h 4001h

Is that firmware reporting the physical function? If so, and if it is
available on ISP25xx/27xx/28xx/29xx before the flash regions are
selected, it would give qla2xxx a port number that does not depend on
PCI config space, under any hypervisor. I am happy to test a patch on
the customer's DDA guest.

Thanks,
Laurence

