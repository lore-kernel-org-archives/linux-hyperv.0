Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A28D4582D2
	for <linux-hyperv@vger.kernel.org>; Fri, 31 Jul 2026 18:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785521495; cv=none; b=q6Vp8bLwzbFfidOy2gId/GVmhIqGbfCXCh11IoLNwDiM1zvdslQz/ZRQO3UMS/5QkZX1ku7GGr/EZrlk5MJUhZa7Uzn8rY4xwpuFmqfvTBnrXYAtRYe+vd5QTboZx7lj/BsxmiwGbcREaJRGOJkXTP6CFEBgrqUxp3ydETHrlP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785521495; c=relaxed/simple;
	bh=1wqT6fgguWPW4M9eF0kbyBrjvDXIuS6oN5OqwiNNiOA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=om4MbXqzqp0z3xCrHn5eM6rr0pzepxOv7gzansob+HOSiC2GTknhLEzYhmTKOCer1mKe6WYmMrs/FVuzp30fNXhz47SDN9q3VT/0wC9xha+pRhwZsgsIXKbdsUK+/wUH9I6V65O9gRoI043Bx6r0Dzxs7DRNuzYaxiyQ/f/rKOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VqOljwuE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UR4NJZRK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VqOljwuE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UR4NJZRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785521488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1wqT6fgguWPW4M9eF0kbyBrjvDXIuS6oN5OqwiNNiOA=;
	b=VqOljwuEhtV5CAFM2lsY3QNhUI5BXG4ITTZ7Zj5mqghCUHz/a5cuMb5KZi2WmsbavwI8nm
	7RakAXCP4QKeloMN3GCcUyvo3CFWw18dtqji2jwtBIs6BoiKkj9OEpqSEZKczV1alDiyzp
	eXGg6ix2rmyryDFN/3EXl8eHBZBVUpo=
Received: from mail-yx1-f71.google.com (mail-yx1-f71.google.com
 [74.125.224.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-3-eCiP9lMPyDuDe_9VUZzA-1; Fri, 31 Jul 2026 14:11:27 -0400
X-MC-Unique: 3-eCiP9lMPyDuDe_9VUZzA-1
X-Mimecast-MFC-AGG-ID: 3-eCiP9lMPyDuDe_9VUZzA_1785521487
Received: by mail-yx1-f71.google.com with SMTP id 956f58d0204a3-668910ff32bso2564869d50.1
        for <linux-hyperv@vger.kernel.org>; Fri, 31 Jul 2026 11:11:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1785521486; x=1786126286; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=1wqT6fgguWPW4M9eF0kbyBrjvDXIuS6oN5OqwiNNiOA=;
        b=UR4NJZRKVXZ5ll5iK3YhQiucUYMqPXyd8vnZhhkLZjBtYb2PYAzwJUC9gc//Ie1mCx
         VotCUy7ulW6i/5Yt0SWqiodXCdHjVR2G4DYz15QRSp9xvSkXTG0xVhQs/0MrkB8Qf9lq
         ThmdHg9Fk+KGzH5mQIhoANq3vFdTO0ms6JjlK4zxAeDBI+edamJ3EdtK9i+qhMMdD039
         vr1zA8EhsZRpiOrbi6QmrCaM5bxAt3TC/QDV39eOkGp55LiODpQZmwtee3kRdHQvgBQs
         uxWkX2myKEQLgT0cG8aInE5VvqiKLcGlaBnI2C/uW2nkuOwJyDz7tDBF0+7MfeHS+DIB
         a9bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785521487; x=1786126287;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1wqT6fgguWPW4M9eF0kbyBrjvDXIuS6oN5OqwiNNiOA=;
        b=jPGigpIXxORsTF96zwvsy5+LaM4MT6CnwF/EzmocASaMkYqHqauNJDKp94cWBn+hg+
         bpgRShQFn+J1bmi0I3rbwreeb1cnMAp/Om649KCNP+sIbWqLH+Dpbpxmez7bvBrYPTbY
         dHyfz7x0dE7jQYCgn6TBSOdCLxdz5DaMzanLnTb1Cdr6MgHrgPmXn9Wrui10U3jYltWV
         8w2gAzLJ7UQZaOpPlixki8tU5slAv+BjSN+u0mxj3wcYZytE4wY9yrGlrKWCr7JLBSuO
         xsZo07AWIY34rEqbcuyg/rUSw0S9ziVJx83oZTIEEXEUxu535tdkxXMu/P7KOe06kYsH
         PaqA==
X-Gm-Message-State: AOJu0YwHhoDtVfKoZ64wU6/MWwsH1h5FUDCmpwCVWiv2QiU57KES0QJH
	fCTvZ714Ek7BivZ4LUqgOaSGNrfq57XZ4Z9eV6M90PYqyIKWL+N115ydd+GyqtIqtEHAjaxGNpI
	mqGftHESZwwoW9Gy02nBXiVkO21Np1vgd8B/+kVptTJhhkbKdWnqpksSPdNWvigS8Xw==
X-Gm-Gg: AR+sD11bp8V5EmT3kTcqgBxqRWIBq9MhV/dyxQL+wAqbmGr1eGLYiFwggbvNRr+VMwy
	Bn9adVhhlL2aFfGtfH24cPMD9RPFh9oLqPuzOEvlPkLt15OxXNc+WU4GP28aCeeEUT3V56VMm5y
	Zl/Nc45FfcpuWhmA3Sk9yFV3rZ73XIxgE3QSkJWS1V8d3wH3OuFGirST0bADvdXyTP54EhuYGby
	M5ClKMSq5bUEVRpJ82CuH8OVVqKM4/GP5MlFNjIzMHUb2fGFM2VRmcv/O4jSARywtd8vpNcGQqw
	aL3TLw1g3BDP081o6qNaNuealD8jErOjucWZOEX+CN1JZ0jUrxOpf60RbXvd7I///g99STZgiZL
	sdUPYaXdhtHI6RZ0c9W1pVCRFvBO2doWTGCue
X-Received: by 2002:a53:a692:0:b0:668:9230:e271 with SMTP id 956f58d0204a3-6694f05de2amr854653d50.19.1785521486539;
        Fri, 31 Jul 2026 11:11:26 -0700 (PDT)
X-Received: by 2002:a53:a692:0:b0:668:9230:e271 with SMTP id 956f58d0204a3-6694f05de2amr854635d50.19.1785521486115;
        Fri, 31 Jul 2026 11:11:26 -0700 (PDT)
Received: from loberman-thinkpadp16gen3.rmtusma.csb ([2600:6c65:2440:d8c:dbb1:97f1:a6e6:766b])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66948e49c3csm1056816d50.7.2026.07.31.11.11.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 11:11:25 -0700 (PDT)
Message-ID: <80785a3bccc6505c28c71271b004e0b5f3fd3b3f.camel@redhat.com>
Subject: Re: [PATCH v2] scsi: storvsc: Support manual scans for all Hyper-V
 targets
From: Laurence Oberman <loberman@redhat.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org
Date: Fri, 31 Jul 2026 14:11:24 -0400
In-Reply-To: <20260723165134.618071F000E9@smtp.kernel.org>
References: <20260723163743.1274830-1-loberman@redhat.com>
	 <20260723165134.618071F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2026-07-23 at 16:51 +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
>=20
> Pre-existing issues:
> - [High] Kernel panic in fc_eh_timed_out() due to missing NULL check
> for fc_rport, contradicting the v2 changelog claim.
> - [High] Use-After-Free race condition in fc_user_scan_tgt due to
> unpinned rport pointer.
> --
>=20
> --- Patch [1]: [PATCH v2] scsi: storvsc: Support manual scans for all
> Hyper-V targets ---
> commit 7a84d34942989f4df1a7195141939c24f221c9ea
> Author: Laurence Oberman <loberman@redhat.com>
>=20
> scsi: storvsc: Support manual scans for all Hyper-V targets
>=20
> This patch provides a storvsc-specific user_scan callback that uses
> the
> exported scsi_scan_target() interface to allow explicit scanning of
> targets
> without requiring synthetic fc_rports for each target.
>=20
> > ---
> > Changes in v2:
> > - Replace the private, unexported scsi_scan_host_selected() helper
> > with
> > =C2=A0 the exported scsi_scan_target() interface.
> > - Preserve wildcard channel and target scan behavior.
> > - Verify that storvsc_eh_timed_out() does not use the FC error-
> > handler
> > =C2=A0 helpers; the reported missing-rport dereference is not present.
>=20
> [Severity: High]
> This isn't a bug introduced by this patch, but is the v2 changelog
> accurate
> regarding storvsc_eh_timed_out()?
>=20
> Looking at storvsc_eh_timed_out() in drivers/scsi/storvsc_drv.c, it
> appears
> to explicitly route I/O timeouts to the FC transport error handler:
>=20
> if (scmnd->device->host->transportt =3D=3D fc_transport_template)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return fc_eh_timed_out(scmnd);
>=20
> When fc_eh_timed_out() handles this, it extracts the fc_rport
> pointer:
>=20
> struct fc_rport *rport =3D starget_to_rport(scsi_target(scmd->device));
> if (rport->port_state =3D=3D FC_PORTSTATE_BLOCKED)
>=20
> Because storvsc targets are created without an intermediate fc_rport
> parent,
> starget_to_rport() returns NULL. Does this mean fc_eh_timed_out()
> will
> immediately dereference a NULL pointer during an I/O timeout?
>=20
>=20
> As a related observation on the FC transport layer scan paths:
>=20
> [Severity: High]
> This is a pre-existing issue, but does fc_user_scan_tgt() have a race
> condition that could lead to a use-after-free?
>=20
> In drivers/scsi/scsi_transport_fc.c:fc_user_scan_tgt(), the host lock
> is
> dropped before scanning the target:
>=20
> spin_unlock_irqrestore(shost->host_lock, flags);
> scsi_scan_target(&rport->dev, channel, id, lun,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 SCSI_SCAN_MANUAL);
>=20
> If a concurrent FC link down event or port removal triggers
> fc_rport_final_delete(), can the rport device be removed and freed
> before
> or during the scsi_scan_target() execution? If so, should a reference
> be
> acquired on rport->dev prior to dropping the lock?

I do not see any of F/C related calls in what I modified or in the code
I worked on so for me v2 is the correct and final version of this.

Thanks
Laurence

