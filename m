Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E17730E0CC;
	Fri,  4 Sep 2026 08:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788509079; cv=none; b=ah8oCyFGEtuTWGfL4Cn9DAlD9kFlitD89+3z41nKADYXPB39QdcgPZaGnCK4sQ5zLitDRiIY59UdEbPhbafulXgaBlVezT5sC1gKWeluwyThrV7VqZZcjXg2CHne3cbEh4Vqt/2pCFPzzfABrDzaK9odFAHwwaA19pZR3o9tbR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788509079; c=relaxed/simple;
	bh=3tNvoHoWQF1cTkbG3Q1EPPiZOKS0SYP1NlO3NRa+AaY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Mi6UX7JkyBd11MiOGMMnv53Ud0yI9ITwzzWjAxa4ItEb1BmQvOj17HUBhxAy3RA62qE6ebmMnKQ42ey0UBrf6beWQV4XtyA8AckqxTbF/NexZXCo5gFsYtPrx+WbFeMjRTvl3BZdf4+Z5qhst/i7nTx0aFH1m5mM2AKFFXZ/C24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JOiA6EcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JOiA6EcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C614E1F00A3D;
	Fri,  4 Sep 2026 08:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788509078;
	bh=uOLT5Sl8tqECZQdY9hoKbUhdsZzRicCSf8sTWaP8m8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JOiA6EcZIZCdGaoWIxGxLFFSE+O44wmHdwvdgQDWOKku9lU6QT+V9wO104bjhOxYd
	 iUoCX+mB7953og6AB0EayZm4oEw5OBxCjlkoJb4Z1laN6YNlgkbRdxGUByRTCvdGrN
	 6deqWTahzzSQRTcOrTXn846BxWiMlSAF0napbkdFEZmu497K4qHW5lESye12jv7My0
	 x41f7XUv6JLxk9gUXzTQO5FOxQyxPZXdRx3e5RrVzdGEOereUlXUQTXcYICLHV5M0l
	 Ayspb4P5CiZF5xP29eAZdbaW5ME+QMzr7Cga0k0sS7Ot0+y1H6DPLbvJRgBg00+TRI
	 g4/LF1VvQ+vgQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260904075512.174154-2-zhangyu1@linux.microsoft.com>
References: <20260904075512.174154-1-zhangyu1@linux.microsoft.com>
 <20260904075512.174154-2-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:04:37 +0000
Message-Id: <20260904080437.C614E1F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> From: Wei Liu <wei.liu@kernel.org>
>=20
> Hyper-V guest IOMMU is a para-virtualized IOMMU based on hypercalls.
> Introduce the hypercalls used by the child partition to interact with
> this facility.
>=20
> These hypercalls fall into below categories:
> - Detection and capability: HVCALL_GET_IOMMU_CAPABILITIES is used to
>   detect the existence and capabilities of the guest IOMMU.
>=20
> - Device management: HVCALL_GET_LOGICAL_DEVICE_PROPERTY is used to
>   check whether an endpoint device is managed by the guest IOMMU.
>=20
> - Domain management: A set of hypercalls is provided to handle the
>   creation, configuration, and deletion of guest domains, as well as
>   the attachment/detachment of endpoint devices to/from those domains.
>=20
> - IOTLB flushing: HVCALL_FLUSH_DEVICE_DOMAIN is used to ask Hyper-V
>   for a domain-selective IOTLB flush (which in its handler may flush
>   the device TLB as well).
>=20
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Co-developed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904075512.1741=
54-1-zhangyu1@linux.microsoft.com?part=3D1

