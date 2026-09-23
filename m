Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33D5616BB
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 19:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190792; cv=none; b=W70KLGFY/kWUfnoszEAdIZEq7GWSLq1LFyBQ8JiX6zLp7iJ6cDv595klGe0ycbqCN4xp/m9na5N1AbCR9hsivMiXrsUl5JHhA3nHpyVPE6/K54zbALQVoCR2PD/daqod1fZhxhFp3CJ9sTlmFFYytjCe1Y116CU+IEoBHxgoAFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190792; c=relaxed/simple;
	bh=QkMRJqPJl7ePcYGGV7fY2eFNdHZRVJFUL4xJqCIlvU8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rumM14LLKZ853a3A9Ej5FDKvAHX+MvcwkE4zgxDZKeMPmzv00Ro1NJsJrGKp9lWDLLN7N0FwCQqJ3ZlZheId17bpHra3KsNpOTukhaOCUDgD2Y1SaouWfzZ1TtUa7WBHNa3swLvN7cCKDvBsdKnzwJufxdH4S0tVxQXwFYW+0co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L8DGJ3tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L8DGJ3tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 176BB1F000FF
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 19:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790190790;
	bh=I76f4OHyDlcX5rVdz+1/GZlzDhbdolScIBFIjAnh+HA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=L8DGJ3tt3GYF2k6tfb6Ccw8S91G7x148MzspOh6k+eauNkAAOz3oV5gZuvUEbDo4w
	 UkIdvB8Ffh7FG4n/WPMkRspVMz0+WGzeAXMY7Xa3Hfqc/VOqC+ZXpGpmYqC7UjLbWP
	 g+SlNwnSpgZNeC9hoVItl64tKSl7Yr/0O5EbSK5pYZR57rvKL+REZVlvjxxqt79bH+
	 o8xhOciG2Q4d6XODDqUU2ZpgR9K1kc1qrCK92GV8dP6ZgHuwGiN/0zUXd9fFUp9qtA
	 WVtZaFz7480LHw4TXf2MVLCVXRKFs73gLUilFAriYNO+4DrHjNrEcVkAPaRSTnAGC3
	 ZIrZoZxNPZzRA==
Received: by mail-lr2-f35.google.com with SMTP id 38308e7fff4ca-3a612404718so10738181fa.2
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 12:13:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzCzpdV8IFwgdzwznT0xBDWwWnGcrVCnZGtKLd/7YNpAcn1s243E9Qe5/A47gL71rNdG24rHNsj4BBE9rI=@vger.kernel.org
X-Gm-Message-State: AFuF++mLmbDMgJlLv/DNYLLy6J6F6bxFUWiYkLLwMhIkRn8ls3ulvQgq
	WtE6K+kyJyG3phgu+lXikG03BM6BQvByojIcaYRF5wx16p/JTNUKJrQKXtq2C0TWmU6D+YqIx4o
	zktzZeV62nqpjQonDbeK16WQjcECWF04=
X-Received: by 2002:a2e:be90:0:b0:3a1:b658:feac with SMTP id
 38308e7fff4ca-3a63c0df7a6mr418261fa.13.1790190788472; Wed, 23 Sep 2026
 12:13:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki> <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
 <CAJZ5v0juW=oum7jULzHeTbaG2Ame=ge3nitsKDz_05Xs6wQqZA@mail.gmail.com>
 <CAJZ5v0gG30TSY=di+TULEvbB3GxxFNcLvx=xT2i1aFgfiNjnmA@mail.gmail.com> <CAJZ5v0i_SO7yJSQMJqENVnO1cYbkCSHzwzkO4EvxbriNQ_ksGQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0i_SO7yJSQMJqENVnO1cYbkCSHzwzkO4EvxbriNQ_ksGQ@mail.gmail.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 21:11:34 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gt8+tRT92y3hPnGXmFvpG1AfqvFC6jRbfV6gxGMy8e1g@mail.gmail.com>
X-Gm-Features: AclHuK8Jy2YHw6VOFjUIhdVb8r-z2f9I08RuDXiI3nHZDK0KyDP9zyBNWmx2rOc
Message-ID: <CAJZ5v0gt8+tRT92y3hPnGXmFvpG1AfqvFC6jRbfV6gxGMy8e1g@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 8:50=E2=80=AFPM Rafael J. Wysocki (Intel)
<rafael@kernel.org> wrote:
>
> On Wed, Sep 23, 2026 at 8:31=E2=80=AFPM Rafael J. Wysocki (Intel)
> <rafael@kernel.org> wrote:
> >
> > On Wed, Sep 23, 2026 at 7:32=E2=80=AFPM Rafael J. Wysocki (Intel)
> > <rafael@kernel.org> wrote:
> > >
> > > On Wed, Sep 23, 2026 at 7:06=E2=80=AFPM Michael Kelley <mhklinux@outl=
ook.com> wrote:
> > > >
> > > > From: Rafael J. Wysocki <rafael@kernel.org> Sent: Wednesday, Septem=
ber 9, 2026 9:41 AM
> > > > >
> > > > > The ACPI bus type does not allow drivers to be registered, so the=
 sysfs
> > > > > attributes related to drivers created for it and its devices are
> > > > > useless, and its drivers/ directory is always empty.  All of that=
 is
> > > > > confusing and wasteful.
> > > > >
> > > > > To allow skipping the creation of those sysfs attributes, introdu=
ce a
> > > > > "companion" bus type concept and add a special registration funct=
ion for
> > > > > registering "companion" bus types, companion_bus_register().
> > > > >
> > > > > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > >
> > > > As a heads up, this patch breaks Linux guests booting on Hyper-V.
> > > > Something goes wrong in the VMBus driver getting loaded and
> > > > initialized (drivers/hv/vmbus_drv.c).
> > >
> > > This patch doesn't affect anything except for bus registration and
> > > driver addition and lookup for the ACPI bus type.
> > >
> > > > It may be that the VMBus
> > > > driver is doing something wrong or making an invalid assumption.
> > > > I'll debug the problem today or tomorrow, but any insight you can
> > > > offer would be appreciated. I'm working with linux-next20260921.
> > >
> > > No idea what's going on.
> >
> > Actually, you may try to restore the stub .match() callback for
> > acpi_bus_type because the lack of it causes 1 to be returned by
> > driver_match_device(), so if any driver points to acpi_bus_type as its
> > bus by mistake, the check will now succeed.
>
> Which shouldn't matter though because driver_match_device() is only
> called in 3 places and none of them is reachable for acpi_bus_type
> after the $subject patch AFAICS.

Well, not quite.

If a driver with an incorrect bus is passed to driver_attach(), it
will iterate over devices on that bus and call __driver_attach() for
each of them.  If driver_match_device() succeeds then, the device will
be passed to driver_probe_device() and it will not be good.

So it may be worth checking after all.
