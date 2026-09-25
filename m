Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2222B47884D;
	Fri, 25 Sep 2026 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336096; cv=none; b=pob1TO1mPVdT/4DLURf7lKRZ0ymna+tIGJmt/PbigUjEbHj5+g4H0UQT/CtGt8prnL127i0N0P6FBfkD1aFui/OXh1bHqxbMgVEc+KtUjxhqQ5KzjVh/gpErEjyRxWXMnyidbRg0ePV+6xXyiFlS1KzuyGcZgPBKR0DsGaMZ/Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336096; c=relaxed/simple;
	bh=o+HfiujomK2MynNig97a+2a2ftn0bwEV8MCv2d9Vdzo=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=DwdTPemYDJjTtWda3gy9fHBjB7Cr2uMDu3tF4i5Fk/VbSTzHSodtFzfIoBTyfnXqH+a8kdP3flQ4tKYXqyWLjXUsunyCTOZG44XFY8dUNSwbuj452NcD8T5K83z13lhsvz7zKLi5ujdXZE7trsu4FgG8/6TdMKwPGkt0udhtdls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIRvyGNC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIRvyGNC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3797D1F000FF;
	Fri, 25 Sep 2026 11:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336094;
	bh=o+HfiujomK2MynNig97a+2a2ftn0bwEV8MCv2d9Vdzo=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=LIRvyGNCyp4ct1HfQ70+U3MWqLRteF6Oh+j5Xfa/5NP+yydAwI1nnwiFE1VVb0ghc
	 N72bXDIqBv3Sqsz4MOLKRnBCYRds1Gn/nfP9UskYYaetZEOEqScWDMHjyTYXwSTQSk
	 LfQ+d/qSnZ+F5UJP7/+qA3iiJAwE8hefy7idg/JRrCb5U6WL5LftDWZQVtB/d0U67V
	 F4hE54XTXOq1EUj43hY5/UIIF4In9YZhD85GCBx1SFJ8qvFPhSMvrokjAJfDTrb6K2
	 OpQQuUdWHOgOPhIbIFNFCqqnIIxB1s09J4iWZ7+p5bGRf2Xp2jsP95EYAHwIDZegOa
	 wNx/lhJhR56qg==
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Sep 2026 13:34:51 +0200
Message-Id: <DLOD6E6L35CN.KDDA9DEG9WP0@kernel.org>
Subject: Re: [PATCH v3] driver core/ACPI: Introduce companion_bus_register()
Cc: "Linux Driver Core Development" <driver-core@lists.linux.dev>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Linux ACPI"
 <linux-acpi@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Michael Kelley" <mhklinux@outlook.com>, "Hyper-V List"
 <linux-hyperv@vger.kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <12985239.O9o76ZdvQC@rafael.j.wysocki>
In-Reply-To: <12985239.O9o76ZdvQC@rafael.j.wysocki>

On Fri Sep 25, 2026 at 11:23 AM CEST, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> The ACPI bus type does not allow drivers to be matched to devices, so
> the sysfs attributes related to drivers created for it are useless and
> their existence is confusing.
>
> Moreover, it is better to prevent drivers from being registered and
> looked up for a bus like that.
>
> To allow skipping the creation of those sysfs attributes and preventing
> driver registration and lookup for the ACPI bus type, introduce a
> "companion" bus type concept and add a special registration function
> for registering "companion" bus types, companion_bus_register().
>
> The "drivers" directory under the ACPI bus type is still needed because
> there are versions of systemd that depend on it [1].

Maybe we should also add a brief note above kset_create_and_add("drivers", =
...)
why we retain the directory even if !use_drivers.

> Link: https://lore.kernel.org/linux-acpi/SN6PR02MB41575266A4580339E186E5D=
9D4812@SN6PR02MB4157.namprd02.prod.outlook.com/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Danilo Krummrich <dakr@kernel.org>
