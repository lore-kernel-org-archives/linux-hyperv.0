Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBACA4E66A7
	for <linux-hyperv@vger.kernel.org>; Fri, 25 Sep 2026 16:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790354424; cv=none; b=s8OywAKqcD1d1TdM8mxJqYvLmIV1Cxz+1Fqt02tynsBG1xXg1lZSHGb6naMPrNmi2I5GfSiH2rgM5HGUChsGC76J9XHiD3c0zvsPhMu6jwolD7VK6azmPFDihD8RiTiAgJCrpUyjRBzcaygIAmFqM3P4KL429ix/spLOlr4cd7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790354424; c=relaxed/simple;
	bh=LnFCumRPW5KkkTADLpdYawZ4Ym7zY4tKFvbDYPg3oPo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kOmjDen5MBCnUicltq/2vgYR5odrJdU9vTorijHkyLNBzLaKDmCEGgFKOweWuQDAkpKtP5wxBXG+aKBx+jlxzbUjYF1Cvh6amuZEyG5Zo2YRy+UPQGgzqaoIvajtQ9qGqyLzUtP9ZLMK0rBTT1kLLlVByJpy0qF4l8mmaCgNsW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Da4kxrr7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Da4kxrr7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D23DE1F008A0
	for <linux-hyperv@vger.kernel.org>; Fri, 25 Sep 2026 16:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790354406;
	bh=LnFCumRPW5KkkTADLpdYawZ4Ym7zY4tKFvbDYPg3oPo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Da4kxrr7dMbJ32AyfEX245OU5vO+hGYp+YxW5c6M2i8h8OVAwUI7Cbu3rS49JXuM6
	 a5mRllx20Kf7Gu/kdQ/IyGqoaboeBvciomnz1Ltjll/+/PTVGyrDaqe1+gA0Y47xvO
	 DJoQAKx1nVc374htNwc85lEzwp/HzzgNsyWcivEgs6GNNsa4xQ7SR0aSNCwfjftMEj
	 cccMdGVqXQl6XIqK2VHbFzt3jUe8mCt6GpGV5NYIZku/bFtx+d0J3lOdzd8Fxf8KZk
	 7R6CbsVHXoMTRatNOkm3PicYGfrsVqIju8y1V2ITIroph3ga0NTfCm9KmL9d0MlWCD
	 TaRaThs668h0A==
Received: by mail-lr2-f34.google.com with SMTP id 38308e7fff4ca-3a6502af787so6661321fa.0
        for <linux-hyperv@vger.kernel.org>; Fri, 25 Sep 2026 09:40:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxOPGB9jVl/mDp5YTXV9zBS2rMcc8giuEeIEAnGM7L5eMvkQr4bgghRPBcPneym+w6Z90qZe3akn1R8xRE=@vger.kernel.org
X-Gm-Message-State: AFuF++ncmIr66QqNnDk9OZYp74kpOuKsDwlSJh/NV6xMXbwDNtpOLkmn
	ZlE5KGgZDjIK55zhjJpgpJesXAi2Dc1VK5zslaw4w4UzQiurY1QQ9UD8gVVn2Xvsa4b2VUPeILV
	NG+Ic23NyNKaTyWGTr5BHENk67QZm6hg=
X-Received: by 2002:a05:651c:154a:b0:3a3:74b9:8a79 with SMTP id
 38308e7fff4ca-3a63c30cb49mr16943651fa.18.1790354405251; Fri, 25 Sep 2026
 09:40:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12985239.O9o76ZdvQC@rafael.j.wysocki> <SN6PR02MB415753ABAFF3119B85B4DEEFD4802@SN6PR02MB4157.namprd02.prod.outlook.com>
In-Reply-To: <SN6PR02MB415753ABAFF3119B85B4DEEFD4802@SN6PR02MB4157.namprd02.prod.outlook.com>
From: "Rafael J. Wysocki (Intel)" <rafael@kernel.org>
Date: Fri, 25 Sep 2026 18:38:26 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iT49TDwYFHOpeSgci3dEySae-ggdwYFeh4YnAY=qD2Zg@mail.gmail.com>
X-Gm-Features: AclHuK92Clwh4unR71Db_V9est7mnsRaI26kEfG495yOxv53OK9E3laP1v2FN2s
Message-ID: <CAJZ5v0iT49TDwYFHOpeSgci3dEySae-ggdwYFeh4YnAY=qD2Zg@mail.gmail.com>
Subject: Re: [PATCH v3] driver core/ACPI: Introduce companion_bus_register()
To: Michael Kelley <mhklinux@outlook.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Linux Driver Core Development <driver-core@lists.linux.dev>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux ACPI <linux-acpi@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, Hyper-V List <linux-hyperv@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 6:38=E2=80=AFPM Michael Kelley <mhklinux@outlook.co=
m> wrote:
>
> From: Rafael J. Wysocki <rafael@kernel.org> Sent: Friday, September 25, 2=
026 2:24 AM
> >
> > The ACPI bus type does not allow drivers to be matched to devices, so
> > the sysfs attributes related to drivers created for it are useless and
> > their existence is confusing.
> >
> > Moreover, it is better to prevent drivers from being registered and
> > looked up for a bus like that.
> >
> > To allow skipping the creation of those sysfs attributes and preventing
> > driver registration and lookup for the ACPI bus type, introduce a
> > "companion" bus type concept and add a special registration function
> > for registering "companion" bus types, companion_bus_register().
> >
> > The "drivers" directory under the ACPI bus type is still needed because
> > there are versions of systemd that depend on it [1].
> >
> > Link: https://lore.kernel.org/linux-acpi/SN6PR02MB41575266A4580339E186E=
5D9D4812@SN6PR02MB4157.namprd02.prod.outlook.com/ [1]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>
> Tested this against 7.3.0-rc2, running on my Ubuntu 20.04 instance
> with the older systemd, and as a Hyper-V guest. The VM booted
> as expected, whereas the boot failed with v2 of this patch.
>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>

Thank you!
