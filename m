Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5D942CB01
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2026 18:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790275589; cv=none; b=IPB5M0Cqmjq6NveQQ59CBblH6RYZseTQKH0loV8iS4dA+SDxIKeNmF73bp23GFoUtvgK4hCDMK8TvjFVT8LyzQK1J8o37LJIbFDjOAzm2V2UPa/qN2DAVveGsIdqnA/8LznnVXYI87YGqUgu8WF8JhInSYt0SDK68sthp+ay8IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790275589; c=relaxed/simple;
	bh=XiJZu2DJ7QOUt/Amb86cxy51pfeARMzjxUXP6+qjxhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRZVBtERs8oSPyVu1E20bL1QYqzQU1ljUlDInF+dPr+goDWKa+IY67XTcD6ovtLoO05v49097Z1sKZtxZ1L+4wpZgr4ld9IzC2YLGlIhT9vnCv2Z0RQfISsyfYbD7QLUObP1uiJik38fOE2i0L4ILcSy473MXCOU30PXXJqegjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OQiD8401; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OQiD8401"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A48EC1F0089B
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2026 18:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790275580;
	bh=S94iqHBHbR3PvK8lSesl73AJ9uh+LF5R5k+adzWkj+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=OQiD8401dZXebvoU5pYyRnSTY0AqolBIOmzrLQpVla+dz+i1WHwuXx/W44ddTwzjT
	 qyMnyGq/ytRwmimhSD95jJgF/kLGzZsByRnjZceXLvAaKezhsp1WrxjaVKSYmnOgQ3
	 T/kLuPzfB6RGt50qNmnTOGWoGYD9b/vA8zrqJQLcLG0t/dQgaqnc92EWo4uaVs0/H8
	 u19pXVNZOHmN+rrCybdgnyo8Sa2+xB4rBPxt2KscF4+d6OSmUI63ymk+sFSKt/CnzS
	 XntbEi/S3tL3Gi+KV9DwWCpO9MioQXTISmtkhBC5UpTU+JlAlfNeITInNDYpOytZ4w
	 nboE5PzYBekSg==
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a302a4e42aso412901fa.3
        for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2026 11:46:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBz7y50jo4X43qbetJfsUxm976bIHDfVpYHk/lzwYrHF15f621oYplP5Sw7/+lgQjzCJCUqy2H9V8GEFxRs=@vger.kernel.org
X-Gm-Message-State: AFuF++naJ7UDbfFA1wDGAplgQsaAoTWeppbuIVRpjCXd8gwdxUEslDG4
	VamwIdmLI/7mGNh3BbRrUOgWwSkBTWPgPzuY969Zq2pSQRi5hDeBtC509igfKzB+zvtiw3O/bhD
	fvB4EQz14Vl85OSeFYsroI0JddftirD4=
X-Received: by 2002:a2e:bc20:0:b0:3a6:3946:3a23 with SMTP id
 38308e7fff4ca-3a63dd9f008mr7438381fa.11.1790275578960; Thu, 24 Sep 2026
 11:46:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki> <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SN6PR02MB41575266A4580339E186E5D9D4812@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41575266A4580339E186E5D9D4812@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Thu, 24 Sep 2026 20:44:42 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0i2oawbWzrVro1gGx2=hYOhjXPNJWDJ6LsNCq1WOxfHGQ@mail.gmail.com>
X-Gm-Features: AclHuK_kDP1jb-vmJEQTklCk_QMTq01kgGxRdse_GLImA2Vr_OAjJ9A1FRmmPhA
Message-ID: <CAJZ5v0i2oawbWzrVro1gGx2=hYOhjXPNJWDJ6LsNCq1WOxfHGQ@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 8:23=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Michael Kelley <mhklinux@outlook.com> Sent: Wednesday, September 23=
, 2026 10:06 AM
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
> > initialized (drivers/hv/vmbus_drv.c). It may be that the VMBus
> > driver is doing something wrong or making an invalid assumption.
> > I'll debug the problem today or tomorrow, but any insight you can
> > offer would be appreciated. I'm working with linux-next20260921.
>
> Here's what I've learned so far:
>
> 1) The problem is apparently due to systemd-udevd being unable
> to load modules with the VMBus bus driver or any of the
> individual drivers for VMBus devices.
>
> 2) I'm testing on Ubuntu 20.04 with systemd version 245. The
> problem reproduces on a different 20.04 instance. But everything
> works correctly on Ubuntu 24.04 with systemd version 255.
>
> 3) If the VMBus bus driver and key VMBus device drivers are
> compiled as built-in instead of as modules, the Ubuntu 20.04 system
> will boot.
>
> 4) If I keep your patch, but change companion_bus_register() to
> pass "true" as the second argument instead of "false", then the
> /sys/bus/acpi/drivers directory is created as before, and everything
> works. Also, only adding back the .match function as you suggested
> does not make any difference.
>
> 5) The VMBus bus is enumerated in the ACPI DSDT. The individual
> synthetic devices that are logically on VMBus are not -- they are
> "offered" by Hyper-V to the guest at runtime via a custom protocol.
> The synthetic devices end up with paths like:
>
> /sys/devices/LNXSYSTM:00/LNXSYBUS:00/ACPI0004:00/MSFT1000:00/<some GUID>

Which is rather unfortunate.

They should appear under the MSFT1000:00 platform device corresponding
to the ACPI device with the same name.

Anyway, it looks like older systemd may be thinking that they are ACPI
devices and may be looking for drivers in /sys/bus/acpi/drivers/.

To kind of check that this is the case, can you replace "use_drivers"
with "true" in the first check in bus_register_internal() only (with
the $subject patch applied, of course)?  That would leave the
"drivers" directory in place, but it would skip the creation of the
probe files.

> My conclusion is that for some reason, the older system-udevd has
> a dependency on the /sys/bus/acpi/drivers directory being present.
> This isn't a kernel problem per se, but there's an implicit ABI of sorts
> that assumes the existence of the "drivers" directory.
>
> To confirm all this more precisely, I'm trying to find a clever way
> to get an strace of systemd-udevd when it errors out due to the
> missing "drivers" directory, and somehow relate that back to the
> git history of systemd-udevd.
>
> Thoughts?

Well, the fact of life is that it can't cope with the changes made by
the $subject patch, but maybe we can get away with a simpler one, so
please check the above.

I'll drop the $subject patch from linux-next at least for now.

BTW, do you know why vmbus_acpi_add() does this:

ACPI_COMPANION_SET(&device->dev, device);

which essentially attempts to make an ACPI device become an ACPI
companion of itself and is useless and broken?

If this is done to work around something, there may be a design issue
in that driver.

Thanks!
