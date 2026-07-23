Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8054743900D
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784821441; cv=none; b=Y2yiEMULhh/JMF4MElJUJIj95hwvi7MBiXMoCetjYlOakuj4EztL2qRR3Z9+4mrExuf5bV48idaMojXVKG999Rgv/82lgxZlf+S2uizO03/jlgeBN+X/6s6ncB3yKBatR+SSP5RqnJactEZhxAtMceLov6d+GJ2Y7OyfBR+SFJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784821441; c=relaxed/simple;
	bh=5S4SOJTxhNbUlM+7sQeSvQ9JEBov4QQqcnN9jQ4hUxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b/eYzailPMoAxOITJpuIWX9uLsipH6fn7YePetWrWKQonoLs1ISRJj+IdE42YmglEnDsN9JD3T/BGPgezPx8FtJ/uWv6fzCKrGNOkefPvvQFbVowxDkKQjmvZQ9MjbFCaYxhwTt72QHZ36ghgFPdDZWL3GK8+tRH0+xg9vS3ac0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Yk5hQvgh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=mWfmKzox; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yk5hQvgh";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="mWfmKzox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784821433;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0f5FCY8RFaoWJvszTpojKDVKtO+UBE2lORQW5KPgAk=;
	b=Yk5hQvghQr6iEip1cxLM0BoOKYyhCMNJ/na/n+Tzl2290TJmB/NjDUzIvjl3R3GmGeKTEH
	OwP0BaVV60uGL+4vbJL6QbqkC1pIy+66DBfSqvEVghHYeIahIYIIZb2PW+GwL66dKq5gBD
	jJ7B25AL4qh8S2yuC48ii6AlMqQ8XjY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-568-z-oHWz-RPo2Q_cu80TIF1Q-1; Thu, 23 Jul 2026 11:43:52 -0400
X-MC-Unique: z-oHWz-RPo2Q_cu80TIF1Q-1
X-Mimecast-MFC-AGG-ID: z-oHWz-RPo2Q_cu80TIF1Q_1784821431
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93106d8affcso69341185a.0
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Jul 2026 08:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784821431; x=1785426231; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=a0f5FCY8RFaoWJvszTpojKDVKtO+UBE2lORQW5KPgAk=;
        b=mWfmKzox8NpdwdOem7yjAwYw7NGSCdmqdtYwjPvFEl0lMlf6tEwuyZ7QzY0p7F8Z6w
         YE7GlPAiMi80FKkteYCWSHY9X5VVMz6ejaZQNYithCbZedonJDPpTDgbva2p2EUA9r+X
         yRVszrACchUkEBFTs96ySsmxl+ZcGh6PKC56CLsVyR0vKzXCVLizQ4rNXE7LOFRH+cle
         W+Pa0Lw0ipqMEQG7WrVrtEAuShuSplKDo7PTp7DkxCM+dRy7Kg4i86wFXI7BvS2rMX/Q
         A/ykLvKO1lvSfZXMXcwaRLVODjgGqn7WMH0EZs/i3R9FvvLsGjesuiibZ+W2n4IHdNb3
         paRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784821431; x=1785426231;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a0f5FCY8RFaoWJvszTpojKDVKtO+UBE2lORQW5KPgAk=;
        b=GxMo5otAMsSvdKWtTgY3PMMzK+1Ras/bVkiIgpX8GU3zrQbvVMRNlQqwrJs2eF3yXM
         w8tC/v6AO5HsQmkq6EENWbwN+wWEEV9dqrFdivlsQ9lLMRRwaBfAn3vyamguImXIRBbG
         x3dPeOJX9Pxv6QNgkw305DSYVIwWI9DPXELJUGlXZSynnsTBPXIJo8dbBGnziURadWBa
         Ymvs1S1nwujPcFn2m9K3+RWA7Y/uNRGK7iq1VLQx7lhKSJNrkVd6m2nhu1SWU7lpWRSY
         wnb+MK2EDiSmEb9uYIpodI5eIvR0B8fmtmVcn/SOHOYoq0zFpdSceJEjANgtAHQHbCJL
         qPKA==
X-Forwarded-Encrypted: i=1; AHgh+RpNOqLItUPtUsMfHJW/yusGzR5hkP8FIj/WzX5Z0Un5R4gitazRyXosTnRwwwpYAmtEWmXNm4SPKJgBI3w=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcnmG5kKg0F/SwM1T7mKbIRg3aIk8GGW+mLEmRLN5ms6rF2xq8
	7NNE6VXa3SM+I3+HO/rsIpZ6bzaqzrbKRIVxvIfzKbequtdXk2t9eDdy101dBU0dD0/QyertPvn
	OAWDZwOPvgETCcXqL/h9JoVY3GS9zYH8I3a5XxepiCM6P35p/Pa4fJhe+L1KUJ823vg==
X-Gm-Gg: AR+sD10OxA18zb1YLPWN/0hUNw175hbrGDLgemh8huVscBrrl+b6RDGbh74/G8St+Ji
	Hqx59b4yF01jYyQ9hF0ItvE8WILQxRjeQ2ceiADr1TJyZiikkUHOKQdYUWrppsYNRTZiKOiwI0J
	857PV0pXOyzxMNYo2F7kH0mW+uSUEs04MtpHP9tdgNSIkYOZSwjEz9jkeqZdNkkRrJL4R64q21o
	JuLjKJ3zoeE4DymYvSx+DXMtR4f8ga5oUDqJQOODgDq9p5A+uew0F4ZNJ22S5KbrYjn45gGVvIz
	JpqvP7KDgD3Xy3MpbFhRRspyj1nSDbyWDQy8oq5gPSMxFvyA12YC4ZZTPG2XxMDNYV3eQo896bD
	Fg0K2olYvop/ffREITa3+xkHE37u/iMjfHwpS
X-Received: by 2002:a05:620a:2259:10b0:92e:b17d:3bd5 with SMTP id af79cd13be357-93103631f53mr275825685a.37.1784821431304;
        Thu, 23 Jul 2026 08:43:51 -0700 (PDT)
X-Received: by 2002:a05:620a:2259:10b0:92e:b17d:3bd5 with SMTP id af79cd13be357-93103631f53mr275822385a.37.1784821430477;
        Thu, 23 Jul 2026 08:43:50 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-930f687acdasm441727685a.1.2026.07.23.08.43.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 08:43:49 -0700 (PDT)
Message-ID: <a95878ba0518d010ba4ca8243b82754f7755f7e8.camel@redhat.com>
Subject: Re: [PATCH] scsi: storvsc: Support manual scans for all Hyper-V
 targets
From: Laurence Oberman <loberman@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-scsi@vger.kernel.org, linux-hyperv@vger.kernel.org
Date: Thu, 23 Jul 2026 11:43:48 -0400
In-Reply-To: <20260723153101.13F911F00A3A@smtp.kernel.org>
References: <20260723151458.872265-1-loberman@redhat.com>
	 <20260723153101.13F911F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 15:30 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> New issues:
> - [Low] The patch calls the unexported internal midlayer function
> `scsi_scan_host_selected()` and includes the private header
> `"scsi_priv.h"` from a hardware driver, which will break module
> builds.
>=20
> Pre-existing issues:
> - [High] Timeouts on targets scanned without an `fc_rport` parent
> will cause a NULL pointer dereference in the FC transport error
> handler.
> --
>=20
> --- Patch [1]: [PATCH] scsi: storvsc: Support manual scans for all
> Hyper-V targets ---
> commit ce267d7e85b7a51757a8afe1188939d3c5146d27
> Author: Laurence Oberman <loberman@redhat.com>
>=20
> scsi: storvsc: Support manual scans for all Hyper-V targets
>=20
> This patch provides a storvsc-specific user_scan callback that
> directly
> invokes scsi_scan_host_selected(). This bypasses the single-rport
> lookup
> in fc_user_scan() to allow userspace to explicitly scan any target
> supported by storvsc. The goal is to avoid requiring storvsc to
> create
> and manage synthetic fc_rports for every Hyper-V target.
>=20
> > diff --git a/drivers/scsi/storvsc_drv.c
> > b/drivers/scsi/storvsc_drv.c
> > index f03dc03a42c35..eb40473a8aad6 100644
> > --- a/drivers/scsi/storvsc_drv.c
> > +++ b/drivers/scsi/storvsc_drv.c
> > @@ -43,6 +43,7 @@
> > =C2=A0#include <scsi/scsi_dbg.h>
> > =C2=A0#include <scsi/scsi_transport_fc.h>
> > =C2=A0#include <scsi/scsi_transport.h>
> > +#include "scsi_priv.h"
>=20
> [Severity: Low]
> Will this cause an architectural layering violation? Including a
> private
> midlayer header like scsi_priv.h from a low-level hardware driver
> normally
> breaks subsystem encapsulation.
>=20
> [ ... ]
>=20
> > @@ -550,6 +551,17 @@ static void storvsc_host_scan(struct
> > work_struct *work)
> > =C2=A0	scsi_scan_host(host);
> > =C2=A0}
> > =C2=A0
> > +#if IS_ENABLED(CONFIG_SCSI_FC_ATTRS)
> > +static int storvsc_user_scan(struct Scsi_Host *host,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int channel,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 unsigned int id,
> > +			=C2=A0=C2=A0=C2=A0=C2=A0 u64 lun)
> > +{
> > +	return scsi_scan_host_selected(host, channel, id, lun,
> > +				=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 SCSI_SCAN_MANUAL);
> > +}
>=20
> [Severity: Low]
> Does this cause a module build failure during the modpost link stage?
>=20
> The function scsi_scan_host_selected() in drivers/scsi/scsi_scan.c
> lacks an
> EXPORT_SYMBOL directive. If the kernel is configured to build storvsc
> as a
> module (CONFIG_HYPERV_STORAGE=3Dm), it seems it will fail to link.
>=20
> [Severity: High]
> This is a pre-existing issue, but does creating a topology without an
> fc_rport parent lead to a NULL pointer dereference during error
> handling?
>=20
> If a SCSI command times out on a target scanned directly under the
> SCSI host
> (which this manual scan facilitates), storvsc_eh_timed_out()
> delegates to
> the FC transport's fc_eh_timed_out(). Because the target was scanned
> under
> the host device instead of an fc_rport, starget_to_rport() evaluates
> to NULL.
>=20
> This NULL pointer is then unconditionally dereferenced in
> drivers/scsi/scsi_transport_fc.c:fc_eh_timed_out():
>=20
> fc_eh_timed_out()
> {
> =C2=A0=C2=A0=C2=A0 ...
> =C2=A0=C2=A0=C2=A0 struct fc_rport *rport =3D starget_to_rport(scsi_targe=
t(scmd-
> >device));
>=20
> =C2=A0=C2=A0=C2=A0 if (rport->port_state =3D=3D FC_PORTSTATE_BLOCKED)
> =C2=A0=C2=A0=C2=A0 ...
> }
>=20
> Can timeouts under hardware or network load on these targets trigger
> a
> kernel panic?
>=20
> > +#endif
> > +
>=20
> [ ... ]
Thanks for the review.

The module-build observation is correct. scsi_scan_host_selected() is
an internal SCSI midlayer helper and is not exported for use by a
modular storvsc driver. The successful built-in kernel build did not
expose that problem so I never caught it.

The callback should instead use the exported scsi_scan_target()
interface and should not include scsi_priv.h.

I am also reviewing the FC error-handler concern before posting a
revised patch. Devices discovered directly below the SCSI host do not
have an fc_rport parent, while the storvsc timeout path delegates to
fc_eh_timed_out(). A revised patch must ensure that this topology
cannot lead to a NULL rport dereference.

I will address both points in v2.

Thanks,
Laurence

