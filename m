Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794064447;
	b=LYqknk1pIIEq/yOR/EECbs4xUSm5DM8tr1YD7TY2TcjuZ9S1AlGVorzS3PJPodQgMT8m
	 SaNgf7XJHse6ArsvatO57YwOGi75B4gvHYev83xQSIrugg6P31rqj7bHyZF/H3e7NKjub
	 pEDEBjvlkt1UsD1h9aWpMYpjdpouJ1b+dxI0BZytlbAPnEtFVwuKz2UwCURiV5v4c9aoP
	 3xtZSZ++nNQ/vt16WS/nlRKf5440ExUCtuO1Zu1ao0jZ6oMgtsMp7GhmBkJT4zFGwdgbb
	 1UlC4qht7snlED9zHNhHeFl4ohe6DXdmrcEdqIgk21FSy3yK30p5bf6apbM1R6Bp1qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794064447;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Subject:From:To:Cc:Date:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:User-Agent:
	 MIME-Version;
	bh=cbWwAcQq4uRDikoBSCyhCaJCcw0pytPybYrMp+gi6BY=;
	b=oEJFthCWwz7hIZRKhkVHUxLxs4dUzbuZlT6wwGS7w981O5CL4r4/2vl/uTqieclAy6Zg
	 pDvWfCoSFLR9rRPsh58eEwrLkmSu9dIPMxmouXm9kd0Z3mg3xhYPraB9qk/diKEvfrf0b
	 AhhJVvzIqJO8nLtVyqPUVkC1LUXcm7TluE29Y/24TwVVG9qdm7adxxw8hT21Uo7Mhyepb
	 2MwizeUKuQGpwyJXUBzn9+hD54TsaXyEOjOJvjhmdEcdhmB35ZBoV73qVmMIzY2e8m+Oy
	 lb6HodjWphl2YPxKEmrkq/dkG4rO3Eu7AH2UzHB0kLpQ6KMARkZbD7KHnCZ6He/jwCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="isoiA/1M";
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BNGhKGvB;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F986606EEAC
	for <linux-hyperv@vger.kernel.org>; Sat,  7 Nov 2026 15:14:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F986606EEAC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=isoiA/1M;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=BNGhKGvB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794064445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cbWwAcQq4uRDikoBSCyhCaJCcw0pytPybYrMp+gi6BY=;
	b=isoiA/1MqNm7NIIxWctRGfrrIp2yFjOXgZ/eql11LDg7cvACtO0LYoo2kfq9hFgZ9HjsrB
	wrfsF7L7UXJFXd3U8gpPNAQtFTXsTHOJDL/v1uDjM3tR8RckoTvT0LbMN2MHYWkBZGmAdi
	zEd589+3+C9XKc7/8OYisBTtW/e2pgc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-f_xEmIzhOPK_azeKdKraGA-1; Sat, 07 Nov 2026 10:14:04 -0500
X-MC-Unique: f_xEmIzhOPK_azeKdKraGA-1
X-Mimecast-MFC-AGG-ID: f_xEmIzhOPK_azeKdKraGA_1794064444
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-5338974c0ceso35757711cf.0
        for <linux-hyperv@vger.kernel.org>; Sat, 07 Nov 2026 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1794064443; x=1794669243; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=cbWwAcQq4uRDikoBSCyhCaJCcw0pytPybYrMp+gi6BY=;
        b=BNGhKGvBDH/eOwWGXi7JOM7zNagjpt537akmEhO87/lJZ72KDbFlCMkAhV0gSDbtAl
         MF390plYheI3/LFt86NbYLD1Gi6di/f9Ph/WkZGyeVCNHe1LGQ9ON0tMrDxoPc8zV6XT
         HIvf688FdFvydUO9ePGNSh09XzNrryrrz9Snb0saqBX9Wt5xFZ275qtRFxSfH1MuRP2r
         bn/0RTXTA3HpizEcTN/H8XwuDg/zw0PhWK8qvnn6xFG5qxU58/fJZJQqPYRvXfb9l8/N
         vM/OYjVOXKUq+E04GrQrfmNEDkaqNEC5FLbrUwQxrcE0HhtpkKZmq31luGUmeLz6bOIQ
         9L9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794064443; x=1794669243;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbWwAcQq4uRDikoBSCyhCaJCcw0pytPybYrMp+gi6BY=;
        b=2j0faJOPjVXfh0/FmZaxjmQ7KHF7wuZrbwWSB3US82ZAZlX217Gmyij8F45zVv0Paj
         KtvRAtTN+nkzwf2WKwFjZRiiPI6AJ0z7oXURxw+EFBvqIp0kewq7SS1l+Ml38fiLwayf
         W7nASRij7QbYfRyZGg1hrR70yGCn8OGQlTUcs5JN7Rxvo3zdPJwXpQAn3SqUZtWk2pQs
         wfKctPvn3/K+Ldl21+fmh+pynRlbMjtlGNOxdIfsciXCF63hdN4rm1HqdsZ5JNfyNjuO
         R0WxeG40UgB2iLzjZGAXTH3yQ3oPm2ZfUqhza2MV1vu0k6yTn1VfPfkLpsxyZkxtXVjT
         ad1A==
X-Forwarded-Encrypted: i=1; AKwUvBxK9losZSyk1sSfoJ560Gy8XgiSJ2v7p1ziKBOBYqcBj92w5Od9WS+n1BTS0XuWmkDqAc2HRe/ev4AQdDE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9a7xSk5ZYaem3rJ0UkLfqJpD8DmMTtg1JTMcwJ93DYxPfNHozK
	e5RWQRdL+kOAR6w1JAPlR4ZF0bN6HzX9MaOenMR1erwicWUOL7jjjS0MVBNa+lf4QXSbIvvcQkz
	pyWcRKhuS6Mk8ZldnOxBwltNuL0o08YpeiI03+jvRKKUk3lsVJmtVAz+A7GOY3U5ICw==
X-Gm-Gg: AYBFou3tdUX3ZgLsxD5TLancMPOGxBXoBrFnvACcZXUw4GD0DS7ZGo/Ii9rvYrTkX22
	opb/4/tjhXFOBexkLXRfgjVoF7ILFCnSdcuIdGLpo6h4hnxbE8spPvUhfrZ5RaYA83RUpWAD3mk
	LDdpm9DNvQc9LkRrmY5YhyedInkuHk8HIdg73ZPRitlPJoaBa+isrkAmUHL+vQ/9p3Au3sqc/j0
	84xMnqNS6Z1Q/9scByLt/NZyM9uIvSaJorFmM4ZVcc405pJaTxUwQ6TTe4n6gnHt3k3Z10lHdhr
	By1ZY/iTq4KEfzJwnYp0CTq+c2g0V/DLifbSLjlWSHqdR4ghXmZtCHGMIMSv/WTZ/vzY5XwrDkd
	5KbjcpBSkQxzbex7p9hN3mxcKKVOk5PCeD7FZTviHTLU4NcCubsbPFVc0OuU7IzZXSFhIsyvmZq
	knvOTgV0wR9nWybhKl0AHZtkXMBKl49dOvgR75+Hy/b7DJrqSNO/lrxD+QvFkWkIRLZ85+KA==
X-Received: by 2002:a05:622a:9017:b0:54f:863d:92c0 with SMTP id d75a77b69052e-54f863d9456mr34737141cf.65.1794064443286;
        Sat, 07 Nov 2026 07:14:03 -0800 (PST)
X-Received: by 2002:a05:622a:9017:b0:54f:863d:92c0 with SMTP id d75a77b69052e-54f863d9456mr34736571cf.65.1794064442628;
        Sat, 07 Nov 2026 07:14:02 -0800 (PST)
Received: from loberman-thinkpadp1gen5.rmtusma.csb ([2600:6c65:2440:d8c:929c:b769:6def:faa3])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54e25d65a9csm48127661cf.11.2026.11.07.07.14.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 07:14:01 -0800 (PST)
Message-ID: <080f3cc7097c9a8191e4fa2f03ff2d67d0640f40.camel@redhat.com>
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
Date: Sat, 07 Nov 2026 10:14:00 -0500
In-Reply-To: <MN2PR02MB68634FAAFE0BA7C4DB3153D9D4772@MN2PR02MB6863.namprd02.prod.outlook.com>
References: <20261104222541.2675051-1-loberman@redhat.com>
	 <MN2PR02MB68634FAAFE0BA7C4DB3153D9D4772@MN2PR02MB6863.namprd02.prod.outlook.com>
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

On Thu, 2026-11-05 at 00:46 +0000, Michael Kelley wrote:
> From: Laurence Oberman <loberman@redhat.com> Sent: Wednesday,
> November 4, 2026 2:26 PM
> >=20
> > qla2x00_set_isp_flags() derives the physical port number from
> > PCI_INTERRUPT_PIN, and the port number selects the per-port VPD,
> > NVRAM,
> > NPIV and FCP priority flash regions.
> >=20
> > On Hyper-V guests, pci-hyperv returns 0 for byte and word reads of
> > PCI_INTERRUPT_PIN since commit fea93a3e5d5e ("PCI: hv: Return zero,
> > not
> > garbage, when reading PCI_INTERRUPT_PIN"). Commit 7268e509b43a
> > ("scsi:
> > qla2xxx: Handle INTx not connected while passing through") then
> > falls
> > back to PCI_FUNC(). With Discrete Device Assignment (DDA), each
> > function
> > of a multi-port HBA is presented as function 0 in its own PCI
> > domain, so
> > every port gets port_no 0. All ports read port 0's NVRAM, pass the
> > checksum and register the same WWPN, and nothing is logged.
> >=20
> > Without that commit, port_no underflows to 255, no flash region is
> > selected and every port fails with "Inconsistent NVRAM checksum"
> > and
> > falls back to the default WWPN.
> >=20
> > pci-hyperv only zeroes byte and word accesses within 0x3c-0x3d. A
> > dword
> > read at PCI_INTERRUPT_LINE reaches the device's config space and
> > returns
> > the real pin in bits 15:8. On Hyper-V guests, use that when the
> > byte
> > read returns 0, and warn if the pin is still 0 so that duplicate
> > WWPNs
> > are not silent. Bare metal, KVM/vfio and other hypervisors are
> > unchanged.
>=20
> There's a patch in flight [1] that kills the behavior that your patch
> takes
> advantage of. I don't have knowledge of the full details that
> motivated [1],
> so maybe Mukesh Rathor or Wei Liu can add some info, as well as
> comment on the validity of what you are observing as a possible
> work-around to the qla2xxx problem.
>=20
> Michael
>=20
> [1]
> https://lore.kernel.org/linux-hyperv/20260913232255.2801797-1-wei.liu@ker=
nel.org/
>=20
> >=20
> > Tested with an equivalent change on a RHEL 9 (5.14-based) guest
> > with a
> > dual-port QLE2692 (ISP2261) assigned through DDA (Hyper-V host
> > 10.0.17763):
> >=20
> > =C2=A0 before: both ports "Inconsistent NVRAM checksum=3D0xffffffc0
> > id=3DNGKP",
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 both WWPN 0x2100=
00e08b1c5586
> > =C2=A0 after:=C2=A0 port_no 1 and 0, NVRAM valid, WWPN 0x210034800d7065=
bd and
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x210034800d7065=
bc, fabric login and FC-NVMe localport
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 registration on =
both ports
> >=20
> > Also tested on bare metal (ISP2031): the new path is not taken and
> > port
> > numbers and WWPNs are unchanged.
> >=20
> > Signed-off-by: Laurence Oberman <loberman@redhat.com>
> > ---
> > RFC: this relies on pci-hyperv not virtualizing dword reads at
> > 0x3c,
> > which is an implementation detail rather than an interface. It is
> > posted
> > as the smallest working fix and to start the discussion. Feedback
> > wanted
> > on cleaner alternatives:
> >=20
> > =C2=A0- Hyper-V (linux-hyperv): could pci-hyperv expose the real
> > =C2=A0=C2=A0 PCI_INTERRUPT_PIN, or provide the physical function number=
, for
> > DDA
> > =C2=A0=C2=A0 devices? Some drivers use the pin for port identity, not o=
nly
> > for
> > =C2=A0=C2=A0 interrupt routing.
> >=20
> > =C2=A0- Marvell: is there a firmware or register source for the physica=
l
> > =C2=A0=C2=A0 port that does not depend on PCI config space? CSRX_FUNCTI=
ON in
> > =C2=A0=C2=A0 ctrl_status is a single bit and would not cover quad-port
> > =C2=A0=C2=A0 27xx/28xx/29xx.
> >=20
> > =C2=A0- The check is x86-only (hypervisor_is_type()). pci-hyperv also
> > =C2=A0=C2=A0 supports arm64 guests; a better way to detect a pci-hyperv=
 bus
> > is
> > =C2=A0=C2=A0 welcome.
> >=20
> > This has not yet been tested on a 7.3 kernel in the DDA guest;
> > testing
> > was on a RHEL 9.8 backport. The upstream behaviour without this
> > patch
> > (duplicate WWPNs with no warning) follows from the code and has not
> > yet
> > been reproduced on 7.3.
> >=20
> > =C2=A0drivers/scsi/qla2xxx/qla_os.c | 40
> > ++++++++++++++++++++++++++++++++++-
> > =C2=A01 file changed, 39 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/scsi/qla2xxx/qla_os.c
> > b/drivers/scsi/qla2xxx/qla_os.c
> > index 3c412c7fb6fe..4180d3f15231 100644
> > --- a/drivers/scsi/qla2xxx/qla_os.c
> > +++ b/drivers/scsi/qla2xxx/qla_os.c
> > @@ -24,6 +24,10 @@
> > =C2=A0#include <scsi/scsi_transport.h>
> > =C2=A0#include <scsi/scsi_transport_fc.h>
> >=20
> > +#ifdef CONFIG_X86
> > +#include <asm/hypervisor.h>
> > +#endif
> > +
> > =C2=A0#include "qla_target.h"
> >=20
> > =C2=A0/*
> > @@ -2704,6 +2708,40 @@ static struct isp_operations qla29xx_isp_ops
> > =3D {
> > =C2=A0	.initialize_adapter	=3D qla2x00_initialize_adapter,
> > =C2=A0};
> >=20
> > +/*
> > + * Read the INTx pin used to derive the physical port number.
> > + *
> > + * pci-hyperv hard-wires byte and word reads of PCI_INTERRUPT_PIN
> > to zero.
> > + * With Hyper-V Discrete Device Assignment every function is also
> > presented
> > + * as function 0 in its own PCI domain, so the PCI_FUNC() fallback
> > gives
> > + * port 0 for every port and they all report port 0's WWPN. A
> > dword read at
> > + * PCI_INTERRUPT_LINE is not virtualized by pci-hyperv and returns
> > the
> > + * device's pin in bits 15:8, so use that on Hyper-V guests.
> > + */
> > +static u8
> > +qla2x00_get_intx_pin(struct qla_hw_data *ha)
> > +{
> > +	u8 pin;
> > +
> > +	pci_read_config_byte(ha->pdev, PCI_INTERRUPT_PIN, &pin);
> > +#ifdef CONFIG_X86
> > +	if (!pin && hypervisor_is_type(X86_HYPER_MS_HYPERV)) {
> > +		u32 val =3D 0;
> > +
> > +		pci_read_config_dword(ha->pdev,
> > PCI_INTERRUPT_LINE, &val);
> > +		pin =3D (val >> 8) & 0xff;
> > +		if (pin)
> > +			ql_log_pci(ql_log_info, ha->pdev, 0xffff,
> > +				=C2=A0=C2=A0 "Hyper-V: INTx pin reads 0,
> > config dword 0x%08x
> > gives pin %u.\n",
> > +				=C2=A0=C2=A0 val, pin);
> > +		else
> > +			ql_log_pci(ql_log_warn, ha->pdev, 0xffff,
> > +				=C2=A0=C2=A0 "Hyper-V: unable to determine
> > physical port, ports
> > may report duplicate WWPNs.\n");
> > +	}
> > +#endif
> > +	return pin;
> > +}
> > +
> > =C2=A0static inline void
> > =C2=A0qla2x00_set_isp_flags(struct qla_hw_data *ha)
> > =C2=A0{
> > @@ -2887,7 +2925,7 @@ qla2x00_set_isp_flags(struct qla_hw_data *ha)
> > =C2=A0		ha->port_no =3D ha->portnum & 1;
> > =C2=A0	else {
> > =C2=A0		/* Get adapter physical port no from interrupt pin
> > register. */
> > -		pci_read_config_byte(ha->pdev, PCI_INTERRUPT_PIN,
> > &ha->port_no);
> > +		ha->port_no =3D qla2x00_get_intx_pin(ha);
> > =C2=A0		if (ha->port_no =3D=3D 0) {
> > =C2=A0			/* None of INT[A|B|C|D] may be virtualized
> > by vfio */
> > =C2=A0			ha->port_no =3D PCI_FUNC(ha->pdev->devfn);
> > --
> > 2.56.0
> >=20
Hello Michael,

Thanks very much for the information. I will follow the thread.=C2=A0
Our main pressing issue is any guest on HYPER-V with DDA moving to
RHEL9 from RHEL8 loses functionality for the pass-through qla2xxx ports

Regards
Laurence

