Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1775D33C182;
	Fri, 21 Aug 2026 13:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319675; cv=none; b=iZc0P301n/BNMYxWKvvf3fpeTMxHrLIP/u72QjJJjFK+2YHWSe/JD/gq9vRiMP8Yt78Y6vCiTogHnRpG/fzLtLoSDTVo1L7akgUFWdNSYhFk5+CXXPBjjdin4g3QYsDsta/Qo9wn7aKNXd8+Id1n8UmHDQQSCeNvK7OylcFOUTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319675; c=relaxed/simple;
	bh=CN7T58bRMJFXhsEC1dLz+P8pyaq0y7QPtHE/3dpUn4c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Vffj3TW86nfO7/UlOue/KQJ4uYKx7BGKlGbnKY/xitJk6O5kz0br7nXFX2jZtdxywmqgboPO6rWD7rH5dAIiA5qlZ4fEv8vdr1TzIVAR4b+9WQ4YyofPMyYBCsvdhUuHsZHeGN6WvP0K86HhUR7/jDM1evWn2Cmv/kl83q3lHOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ff99cyw/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ff99cyw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F411F000E9;
	Fri, 21 Aug 2026 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787319667;
	bh=SBH8/mwWZMZnT/Pu/3PSs941p/dLyFof/7Sm+2EiKrs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ff99cyw/L2JEIOT/H8PDwh6OGAO1V7g0zAdGp9rpViTrla840GQjxpZI+tsqG31Vs
	 J8zSpjOokXiikW7PvEgveORGW357OavBYdH32SCxGt3sLC33WuS37c1pyr9Qk8AV69
	 MZSvcnh0DOAk9dKIVg1YZPlnZ0RwgXfVYx52UaeQgxcVkY7Ejg3uL7NeKZGlh6G27+
	 f9+wsyX+rjmqpi6bJVun4/e3K50oe3RK1eGDDKQ8ZpEMb1maKm9od0Hsr5T+auBL01
	 uqA2ZQHcbfdLIWIJteFLRHW4Lnf1FANv769iG8KjO2v14ac8WBNeTW1+jD9w80giZX
	 NLB2hspVSCYCQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/5] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260821132654.211730-2-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-2-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:41:07 +0000
Message-Id: <20260821134107.A2F411F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821132654.2117=
30-1-zhangyu1@linux.microsoft.com?part=3D1

