Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29D240860A
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790184829; cv=none; b=m0h5hUWHAhgyo8Aw5u3xKnaKfMbTxa1UJQsAQev5VGYwXLZunq1g93n14K+y9DE9jFOzA1tY4YG6vKyNq2LUveZb/0DzE6zLOLoFxtSegSa67CmTKy9SaNR3B5WEERJmjE9FI/zIkfUgfB+4OMxJ1Vk5qe7Kz1lKaPBTBRSA8oM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790184829; c=relaxed/simple;
	bh=7+/gGtEFAH1Te/Z6G2y9uyEyvE2QFcnJ2KCCavRFD4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z6MElhI6zBuNqk+6gcZWpExHsrv9ayBQ0sGsZ6VA6mycop0gri+dhkpEGh6Lw81mNjOOdse4EeH/JuyS4qHnpKNq7H+763RfHXuXUDzPoSUkeTZ0KEBsD70EHYj0oX8fvpq4DHcpGYpKlT7HF5Zyplw4NQKduM2YucbLAYtT1m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6SgdMjn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6SgdMjn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 904AF1F000FF
	for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 17:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790184827;
	bh=ey3SPrkpKGVXMZKt+yPD2M8w0aKzs8cc5D2kXCri1v4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=B6SgdMjnd4YBwwvGENi6BHN81O7xtWfLsllo8cidAPecVIcXGbW44cuuaWvcwxU+x
	 UezGpwSZ8KX8phDwaAGcmjOa80FpxUT+1E585H0cVA7S+esg0CucWCSImGWy5AM2Wr
	 RyhE0SZt1WiI5lwSEZudGKt9FLVL1XUvr5L0xpbXXkhE0tkk4kBjIUzlf2bmyCeUeK
	 sB495Az+n9a3lVqNvwH7yEk1fx7QPl6Cuh6ogzpukSvTP9gk8Ze8RaF2b4sM7a9P4v
	 UYrKFcERGVk0T2YPcO7dw8EWFznCoYPC6ib+mwm53jSlZTeJPFxIE6xnI3LjorbCGr
	 LtjIYD35+pV8w==
Received: by mail-lr2-f41.google.com with SMTP id 38308e7fff4ca-3a6287d59b2so9457391fa.2
        for <linux-hyperv@vger.kernel.org>; Wed, 23 Sep 2026 10:33:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByuGhMQhk2JsX7vN/ChhhORkfjUqR4OnOuWjg1CJeAhDJemPsKJTrrj1FD+T9ePAtkbdJHxgfkMTvYGPs8=@vger.kernel.org
X-Gm-Message-State: AFuF++kDbB+XxAqvmjJRtVI0Y/BAU/Hfrv9grHPpSPyQzCFyaMxCNKg+
	8W710v5U9F52mZpwtaC27Khk0nO2r011YQlPH6nz/rzXYcw4LWSNRQ2LQH2AGIGjTUCpTIPWKSV
	PFMEPDY3NzkIzj2sk4olRHc/UuHcRnRI=
X-Received: by 2002:a2e:a985:0:b0:3a6:3359:84a0 with SMTP id
 38308e7fff4ca-3a6335989femr6183721fa.5.1790184825869; Wed, 23 Sep 2026
 10:33:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6329043.lOV4Wx5bFT@rafael.j.wysocki> <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB41577ECCDB3E757B8859AE7FD4822@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Wed, 23 Sep 2026 19:32:11 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0juW=oum7jULzHeTbaG2Ame=ge3nitsKDz_05Xs6wQqZA@mail.gmail.com>
X-Gm-Features: AclHuK--LX3vVHrZY-Ra9i7rARu_luIZZvd7q6F9lMAi8jGLa6H7OU8CGiKAerI
Message-ID: <CAJZ5v0juW=oum7jULzHeTbaG2Ame=ge3nitsKDz_05Xs6wQqZA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2026 at 7:06=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Rafael J. Wysocki <rafael@kernel.org> Sent: Wednesday, September 9,=
 2026 9:41 AM
> >
> > The ACPI bus type does not allow drivers to be registered, so the sysfs
> > attributes related to drivers created for it and its devices are
> > useless, and its drivers/ directory is always empty.  All of that is
> > confusing and wasteful.
> >
> > To allow skipping the creation of those sysfs attributes, introduce a
> > "companion" bus type concept and add a special registration function fo=
r
> > registering "companion" bus types, companion_bus_register().
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> As a heads up, this patch breaks Linux guests booting on Hyper-V.
> Something goes wrong in the VMBus driver getting loaded and
> initialized (drivers/hv/vmbus_drv.c).

This patch doesn't affect anything except for bus registration and
driver addition and lookup for the ACPI bus type.

> It may be that the VMBus
> driver is doing something wrong or making an invalid assumption.
> I'll debug the problem today or tomorrow, but any insight you can
> offer would be appreciated. I'm working with linux-next20260921.

No idea what's going on.
