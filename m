Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02AEB4F3ED5;
	Wed, 30 Sep 2026 14:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778467; cv=none; b=j91435vu78mUjH3/sk5gru+AxMtdD6IEeTrT4Wwn/O5CkkUVGigbgMU9ot4jW4PRCqoCCLlBW6W7N+5R07/DXakX6zp/RX3KAtFa6K33kPk2J6w+hl2nllyqia+XoocXeMeQMWSxJy3kInl0Cb6TKLOmkic5/87HXyt5jlek7OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778467; c=relaxed/simple;
	bh=Wfi26VXgshrkmgSWcy0xfANrukFOjTdXZLi516LNLbk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=px0+xZJkNt46sBQFbtJt7Aluhg0IoaBOEtJZJVZ/FSS8FI8frVnR6DuAKrwuPgx87DeK9RRsaAopu7syFCJCRevjXkJ+Z1g5pZiHFaJ5kh41Fzg+fboSNlbfXQOebdH4m2Px5JYZiT8HtqcP+NuB4o1UTWhZN7KSWloHDXc2D/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oa41pPv/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oa41pPv/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 172031F000FF;
	Wed, 30 Sep 2026 14:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778453;
	bh=WsSkvb5QIumlCO0oqFroFjggPccVImChj2tnLC7Gp8k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oa41pPv/IH6Y4uuahu7F2+cjPb2PtxFsTjD3Tj3X6HisiIMDkrCtyZTMCwPCYzzlv
	 h78VwDZkBhPZgPsksIas5IvX3Sdm00g7SGt6CHvcgtlLOWwMjrj6wAaWkeq6Xtv9cH
	 uZnxXv9E7ccBG3JY2p+dG0Q6hPHHWVOgFf8tsTQsE6WgWMVwGpEJiiMOv4u838Qk4K
	 TloIZFDWR8GZUO23BTE783mOTtM2WqCdfxnv1VJQQ2f8VvvivJia57H/nENV9FtX+g
	 da1knbdO2tfp0L9+zoYKclx0WhJrL317t+e9zdz07Iz9Om6jIkeShmj+S2shx270+Z
	 PKicaqC5VbZCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260930141409.437904-2-zhangyu1@linux.microsoft.com>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
 <20260930141409.437904-2-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:27:32 +0000
Message-Id: <20260930142733.172031F000FF@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141409.4379=
04-1-zhangyu1@linux.microsoft.com?part=3D1

