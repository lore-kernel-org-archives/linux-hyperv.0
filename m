Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE2E31E838;
	Fri, 21 Aug 2026 13:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787319194; cv=none; b=hNOFlUQ8WDXqKMRagCCrcnZ1IGX+eKeVgJZ6Dtxb7dpiJG0oP0nitj2Eg7tegYPc+o2abv0K5AzMWNlb1nFhRO6iH/gW/F2Mq6FybqhUNOEcr24J/kwKx0HezBCzyYTEJ/4MX57OIMDZ0KKVLDVTL0LMv2q1YrebR7GfSvFCl6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787319194; c=relaxed/simple;
	bh=EFluWCCYHTVPvb1APYFVMDrTseI93nCjDflybMoYVFI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=eyXbqBq4dpBBUHzAw7QvPN+ZayH309bjRO95iXK8cpFJ3b34SWR8jzyYfNqQnvkOtVS5VyASPU7gmBpi1N8QhECDnk9UgOJMLb1KFYwp5kLuMyGKTY3Kdw8EPn9jWiHXVqCxdpX2ED/qMHyQoP/sG1NLP8Myk4dZB58sEAZTLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fw2dhe3a; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fw2dhe3a"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C93B1F000E9;
	Fri, 21 Aug 2026 13:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787319193;
	bh=EFluWCCYHTVPvb1APYFVMDrTseI93nCjDflybMoYVFI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fw2dhe3axs0dYr60a6131UVaPwnZ0ZTlF7Edym0Xahzpjezo4orzHqy3b4B786PMF
	 bKXhBzNXfSkBpGBLXL999FbTz+XMkuh15P7Cj/15UBqDMp7Et+XzeMA64nAEt/KAWR
	 Je5t4v5C3mPeZLVSIQ9AjaRPdPSPpyo/vfc5gCphVbFAJ7pSTilwSfa4iRNVwjJDYh
	 M3KMmPFtHm4O/UFB8zKvIB2z9pHNjvAJsykhhTr5LwOmhGg92m89lGMpKxoABmq8TT
	 lKLG/EmFRyu2kvNdQ9I5j0MiIv+hGvqThiDWWD4NxQty/I1t8nxTdcbIO02MrMCsCu
	 ymBGkseOTEQ9Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/5] iommu/x86: Add architectural MSI reserved region
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260821132654.211730-4-zhangyu1@linux.microsoft.com>
References: <20260821132654.211730-1-zhangyu1@linux.microsoft.com>
 <20260821132654.211730-4-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 13:33:12 +0000
Message-Id: <20260821133313.2C93B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
> address window from normal IOVA mappings, but each open-codes the range
> and its allocation attributes.
>=20
> Add iommu_alloc_resv_x86_msi_region() to encapsulate those details, and
> convert the Intel and AMD drivers to use it.
>=20
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821132654.2117=
30-1-zhangyu1@linux.microsoft.com?part=3D3

