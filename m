Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5B94252AE
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 18:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790188367; cv=none; b=d25vCWEkhc4iqNliYSyiKYn3ZiQm2V6BiD6OBWnmU0B7pgF3LRrQ9+FL6WdYe5yyVods1PW3Fg4afYnmp5Yq+iDms0lsdVxzCr53NRtH24QG0+ZALXJa6TxvqLC5GMkzUZwedFkJGy0GvuFe8hvZlNIXMo4YNm3ErUzKLJSrXfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790188367; c=relaxed/simple;
	bh=RhrniuGsdulcZYvKq+2TYiAc8QqT8K6C795uP8iEL9M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0+MzjLLXUjZUI73BKoxDuS9XlOfTdCXnjo+F27VI3p7rjB8qoq9RGimMhm42WQk5LG1nxWNMthoLQ0XPvTDBKw2zsnsqnfBbqAu9nNrlyEUghA+bM1Sj2gm68GGRUQDlj7tTpwYAxvRbjhS1wzQbf0rCvQLCoWp6IHS2P/PNB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl3wzBmX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl3wzBmX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071FF1F00899
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 18:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790188364;
	bh=3FUqrWkaUC4wf+RmoMNoQdOTxXi3zIfav3tI1Ul3KAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Rl3wzBmXyLj3/rFZMe2k0X4tRC0yQPYq9IEGIV8rWdlAtpPvDL3q0mcfPYqyOAWCw
	 4Jr1C02bpFaEaQ2JZTir7awqQw19Idc0wtUZj6Z9lUlVqkzSVFRb/mU2hM0uGb3M24
	 fn8DUEo6Ulc+m3QRcXbzsLZV9OrsFA2D2QO0i38naffTPH8VRwwRZ0Tt+mzszXV0FI
	 t/OaL2IJQZVmSPMf9g62BflEdBmPzxqPlskemv9kBdevuIpkvBJUE+y1dZFdjnDBxg
	 kiy9beL7rf5xkvzrhgBmX5wOTphAVq6VhQ+hsrnstqOwBkyXhsQSVN0Sl/LMhjqL55
	 S0/9izmVGnPxg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3a20f06cce6so1641881fa.1
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 11:32:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzMyQzbRdTUy1MFklkhviihU7NeAY8DckoD/Asq4kw5C8rgwK30rcn8pYxH7iuZDEYEe5YRaeVI2m+PjFo=@vger.kernel.org
X-Gm-Message-State: AFuF++l8+snXfU8gi19MfWC9JVvlgNaSE4dkiqB4I8YTcAdE7FY1aYWO
	W1NjcuKdElsIGKKZREn52DI4PXG0A2lDBFKs/DJ5+nSEsl7jQoVyIJ6sCcy8SNZFxch4rNEVpb+
	hIO6a7B560nrwfMpxpaZ8JuOl5MSxREE=
X-Received: by 2002:a05:651c:1585:b0:3a3:61ec:43c7 with SMTP id
 38308e7fff4ca-3a63c2fbf19mr113021fa.24.1790188362323; Wed, 23 Sep 2026
 11:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki> <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAJZ5v0juW=oum7jULzHeTbaG2Ame=ge3nitsKDz_05Xs6wQqZA@mail.gmail.com>
In-Reply-To: <CAJZ5v0juW=oum7jULzHeTbaG2Ame=ge3nitsKDz_05Xs6wQqZA@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 20:31:08 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gG30TSY=di+TULEvbB3GxxFNcLvx=xT2i1aFgfiNjnmA@mail.gmail.com>
X-Gm-Features: AclHuK90z00VDMPvs5p4_PAmbjzNA-GsvAHiBkjn1QRO1j-pXLVaVCOanb6xX1w
Message-ID: <CAJZ5v0gG30TSY=di+TULEvbB3GxxFNcLvx=xT2i1aFgfiNjnmA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:32=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Sep 23, 2026 at 7:06=E2=80=AFPM Michael Kelley <mhklinux@outlook.=
com> wrote:
> >
> > From: Rafael J. Wysocki <rafael@kernel.org> Sent: Wednesday, September =
9, 2026 9:41 AM
> > >
> > > The ACPI bus type does not allow drivers to be registered, so the sys=
fs
> > > attributes related to drivers created for it and its devices are
> > > useless, and its drivers/ directory is always empty.  All of that is
> > > confusing and wasteful.
> > >
> > > To allow skipping the creation of those sysfs attributes, introduce a
> > > "companion" bus type concept and add a special registration function =
for
> > > registering "companion" bus types, companion_bus_register().
> > >
> > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > As a heads up, this patch breaks Linux guests booting on Hyper-V.
> > Something goes wrong in the VMBus driver getting loaded and
> > initialized (drivers/hv/vmbus_drv.c).
>
> This patch doesn't affect anything except for bus registration and
> driver addition and lookup for the ACPI bus type.
>
> > It may be that the VMBus
> > driver is doing something wrong or making an invalid assumption.
> > I'll debug the problem today or tomorrow, but any insight you can
> > offer would be appreciated. I'm working with linux-next20260921.
>
> No idea what's going on.

Actually, you may try to restore the stub .match() callback for
acpi_bus_type because the lack of it causes 1 to be returned by
driver_match_device(), so if any driver points to acpi_bus_type as its
bus by mistake, the check will now succeed.
