Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7E543F410E;
	Wed, 30 Sep 2026 14:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790779019; cv=none; b=mtLSTKA9D8zA0FWt3LLfEtYa4dS5hcuznABbWv3rXL1UkTB2093Mv2m2dhDaiEynBj3zjg/JXkg6HPq35RuJ8Azfy7Jl0f/i+xwxcr79As+YXL8AMY2ZjjVx3HYNrsbF0MUdkqJHWZjqA62y4nL29FLR3CkO5/9F7858rSRcGLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790779019; c=relaxed/simple;
	bh=R7ohTtZ4o0spMOuugFUpKcdg4Z1YVfYN8tLs8JiXdX0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XxRoobT7W7FZEP0rgjceKkbui698UcnzFcJkGNNIAQuWZZwNrx64pfHPK4b7I++HLZtf6Q/Y1VfzaSMj5+rUAJ/fCNe4UkUqULL6gO6NQWMJjoUgglfuU/6g/23kGrcs0t0PxoxM2c8JC7t15/Uk92L1stJqY33gA2Y8Wry+zbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oyk8R6A7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oyk8R6A7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E381F00893;
	Wed, 30 Sep 2026 14:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790779008;
	bh=R7ohTtZ4o0spMOuugFUpKcdg4Z1YVfYN8tLs8JiXdX0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Oyk8R6A7fNq9h3WQkAfX0dTcYewpdlOfx/pOJQTYpGSebCo1CT5DiaNt6JuoSATsh
	 pdgmqIDd1CZ+76fWaQsOrHhScjWZ87O1PCZRwYz1p0YF85p0hDnnUnt3Lj+NGPc6g+
	 SBscu3gRQ7DXmvDyEtu1CRxJc7V55+S6u+WUevpUWYIT3rnYk2tX1m7TEfiKVj5nZC
	 b+HNpEAmIsPiO5lsuMMiR5Vxk5Ssgg167qhLyPL9FJe1cpVrf9jgeKHgFtYlzPbI4v
	 twCwGET+wpw3ewsduY/S6bQuT4SIM/N+tcoYs2etKOsVXoVdC7lNqEAl+kwS8mBD1Y
	 EIR8LcuGyJ7eQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 5/5] iommu/hyperv: Add page-selective IOTLB flush
 support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260930141409.437904-6-zhangyu1@linux.microsoft.com>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
 <20260930141409.437904-6-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:36:48 +0000
Message-Id: <20260930143648.A4E381F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Add page-selective IOTLB flush using HVCALL_FLUSH_DEVICE_DOMAIN_LIST.
> This hypercall accepts a list of (page_number, page_mask_shift) entries,
> enabling finer-grained IOTLB invalidation compared to the domain-wide
> HVCALL_FLUSH_DEVICE_DOMAIN used by hv_iommu_flush_iotlb_all().
>=20
> hv_iommu_calc_flush_range() computes the smallest power-of-two aligned
> range that covers the target IOVA region, producing a single flush
> descriptor. This may over-flush when the range is not naturally aligned,
> matching the approach used by Intel VT-d PSI. If the page-selective
> flush fails, the code falls back to a full domain flush.
>=20
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141409.4379=
04-1-zhangyu1@linux.microsoft.com?part=3D5

