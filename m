Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2A13ED5C3
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 18:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790189556; cv=none; b=LFZAUz4jao5M/gUFPPMv/UBy0son7D4QjBQM4fLj2H/qilknrRX6eDTKdq/WaKcanqvu6u7YoV2mjiJhMFl3FBIILfEYHbE9zhbb4m4OE43lg2KU3/isdoHZpvtso2HylpWav3SlHFMQ5T4ofbUDdxMClOOvQb+PFWnbJDYGvDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790189556; c=relaxed/simple;
	bh=58C58dQ82t5+zlJLmKYz7BT0ZZ4TksGP2vwZgvI7VHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J+KrYwKL3jSv8Gfl2WW6VpvcGQdTX1CfT2IKOkWqM+1Tz9YvZlHg4DcfczoJDm1bUz1h2Xcna9zRXK+nE5xZwTafzHJGMAlk0YckajLNG5r6s/4X0pS/IsF3kERGZqc4Hw9mG7hvRPJluieenYJWKTH74Eg+bdZRKMGePNUM220=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SK8Ikv9j; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SK8Ikv9j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55C0E1F00899
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 18:52:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790189554;
	bh=asV5Nhu5JL7ETSWSf6IlFfAv99mCCJ0cM4Jd7QRWFJ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SK8Ikv9j4e5bfqIqVve0xcBUl0xRIYVVjajBUM+D9ZCM3w5myG4aEH8yoxiFDWzsJ
	 WE83v5Akm5qTW15BU8IrCB+tGU2xOgX/qR3fUYtspyHv4RG00KMjLxEpsKbWMvnqxd
	 /+DTt8JsVXdcktx2m/RTbbqOoeO1I0/ibW1rOohOQi/pAliM8HHO3pmfmYQOOzPTWV
	 fRjJ/kcSxtoSldSjvxCKVvq3KLBwYGIGQ9xw+byd+FRbMOe2gJMQerIAuFZezNMKkK
	 oG8Cf0Qoo86umlsOUeDWMIjJi6jDtymoPKNG35CyKqqPjfvXHkQlJQqtPp2iqDaV5F
	 W9bUlodPnurRg==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so1853131fa.1
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 11:52:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxYDfeY00eV1RrmsavxAJTdS3TfoWlmii+hhLilCEY+pQWCELnhL0oNi/b847o+5zP21eEou1pvqsG100Y=@vger.kernel.org
X-Gm-Message-State: AFuF++lboIPYwvDPet5PYybKDjYvve57q7V4/5SsZqu7ZKaW55Mr3icf
	rGo11fGDBQ8bs1anN54rFkErI5PXuFOzUjIBuDvIA4A2tJBtAYhY3e2Q+1FOHwjxQdCHJlf/39y
	I8O55fyBNsY3ut7pzYBkJ+HvTzine2Yk=
X-Received: by 2002:a2e:bd0a:0:b0:3a5:d8c5:dea3 with SMTP id
 38308e7fff4ca-3a63bf1e0bamr334331fa.2.1790189551756; Wed, 23 Sep 2026
 11:52:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki> <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAJZ5v0juW=oum7jULzHeTbaG2Ame=ge3nitsKDz_05Xs6wQqZA@mail.gmail.com> <CAJZ5v0gG30TSY=di+TULEvbB3GxxFNcLvx=xT2i1aFgfiNjnmA@mail.gmail.com>
In-Reply-To: <CAJZ5v0gG30TSY=di+TULEvbB3GxxFNcLvx=xT2i1aFgfiNjnmA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 20:50:57 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i_SO7yJSQMJqENVnO1cYbkCSHzwzkO4EvxbriNQ_ksGQ@mail.gmail.com>
X-Gm-Features: AclHuK8RIbYFkzCrSILJIRSwRsGAcoFYVFCVjexewZrE6A-5xAIe1mMJHJzZKHo
Message-ID: <CAJZ5v0i_SO7yJSQMJqENVnO1cYbkCSHzwzkO4EvxbriNQ_ksGQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:31=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Sep 23, 2026 at 7:32=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Wed, Sep 23, 2026 at 7:06=E2=80=AFPM Michael Kelley <mhklinux@outloo=
k.com> wrote:
> > >
> > > From: Rafael J. Wysocki <rafael@kernel.org> Sent: Wednesday, Septembe=
r 9, 2026 9:41 AM
> > > >
> > > > The ACPI bus type does not allow drivers to be registered, so the s=
ysfs
> > > > attributes related to drivers created for it and its devices are
> > > > useless, and its drivers/ directory is always empty.  All of that i=
s
> > > > confusing and wasteful.
> > > >
> > > > To allow skipping the creation of those sysfs attributes, introduce=
 a
> > > > "companion" bus type concept and add a special registration functio=
n for
> > > > registering "companion" bus types, companion_bus_register().
> > > >
> > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > As a heads up, this patch breaks Linux guests booting on Hyper-V.
> > > Something goes wrong in the VMBus driver getting loaded and
> > > initialized (drivers/hv/vmbus_drv.c).
> >
> > This patch doesn't affect anything except for bus registration and
> > driver addition and lookup for the ACPI bus type.
> >
> > > It may be that the VMBus
> > > driver is doing something wrong or making an invalid assumption.
> > > I'll debug the problem today or tomorrow, but any insight you can
> > > offer would be appreciated. I'm working with linux-next20260921.
> >
> > No idea what's going on.
>
> Actually, you may try to restore the stub .match() callback for
> acpi_bus_type because the lack of it causes 1 to be returned by
> driver_match_device(), so if any driver points to acpi_bus_type as its
> bus by mistake, the check will now succeed.

Which shouldn't matter though because driver_match_device() is only
called in 3 places and none of them is reachable for acpi_bus_type
after the $subject patch AFAICS.

So still no idea what can be going on, sorry.
