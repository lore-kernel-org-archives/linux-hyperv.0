Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576336920C
	for <linux-hyperv@vger.kernel.org>; Fri,  7 Aug 2026 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111406; cv=none; b=aOCaZd8kUG4B1exTeSr5UeION3Yr776yIKy/ZuXf7+Vzru+AhQ0hXFsRKxeBWumguTFQMgbHUykFrPEagBiz6fSQVSiWf9gxtIVG3b9QCtE/UDGzwf6o3qx6cuDXZR6ayL8fzvGDdCSDYVcWAu9XzOvKxmpUUpMJ2PEDXpgwS6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111406; c=relaxed/simple;
	bh=pZSkiNq609BFkvmW+k44UHOlvIEPlM02NsMvJtUr/08=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=gAW/JtwsoHyVVpSuLyU3djMm5clRoz5edZsKzJFaVYeIyO1AuguDClUBW8fGTYrCtKWIwnlbyzqb60I177mWWYp84PrBSlC0xmAIp5CxQdKyf2xd1z0GUo8kB+oIelhhwrx5aNIV5aJPKqt5swRU2KRWPT9qa+8+1xy0LB8EsZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FDdOLZ5G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FDdOLZ5G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 174BD1F000E9;
	Fri,  7 Aug 2026 14:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786111405;
	bh=MOQjeBXn4WIQeVf3LBz66jmjva10YqXKPdLvx2Hv3ws=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FDdOLZ5GXSXBMOUCp4XA/6qfTU73uuSqRlElShI038L7BrAkMZTEUeJCorl5+0JXG
	 Tx/DE9AMPGlYqFvOKzBH2i8v/nOrSfn1uTn20GeeHkjX7ZQowjLuv9o0Os7wZQtBgY
	 9u3RtpDRE1bLpm0yNh8vBzKnc5burXUu4oiD4lsM5qyu+7etQHZBT7+3wLhxu2JNA9
	 GJxhsZWdgXN0bdtY5gPeE2/TAEykPFyOhrpa8fKNvQjHEFNkbsQA/VHfClaNf1N+hT
	 KiNKvg6iZwUGKikFG9sh25WgDRL9q9p0EHDWUX4ZtNg+bmERd1PvtSO1nRw+w1iVxh
	 jGiuVIYDUtXfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 01/13] mshv: add SEV-SNP UAPI definitions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Hu" <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260807135134.303943-2-weh@linux.microsoft.com>
References: <20260807135134.303943-1-weh@linux.microsoft.com>
 <20260807135134.303943-2-weh@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:03:24 +0000
Message-Id: <20260807140325.174BD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added UAPI structure `struct mshv_complete_isolated_impo=
rt` embeds `union hv_partition_complete_isolated_import_data` directly by v=
alue. However, this union is defined in `include/hyperv/hvhdk_mini.h`, whic=
h is a kernel-internal header and not exported to userspace. Because usersp=
ace headers cannot access this internal definition, the union evaluates to =
an undeclared, incomplete type. Any userspace application including `<linux=
/mshv.h>` will now fail to compile with a hard compiler error, completely b=
reaking the UAPI.
--

--- Patch [1]: [PATCH v1 01/13] mshv: add SEV-SNP UAPI definitions ---
commit 0c72e15c0e7fd5f724d97fa58e436ee572659cfa
Author: Wei Liu <wei.liu@kernel.org>

mshv: add SEV-SNP UAPI definitions

This adds the MSHV UAPI and Hyper-V ABI definitions needed by the SEV-SNP
partition ioctls. It includes structures for SNP isolation type, GPA=20
host-access, isolated-page requests, and SEV control register definitions.

> diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
> index 32ff92b6342b2..4e7f3038f0c67 100644
> --- a/include/uapi/linux/mshv.h
> +++ b/include/uapi/linux/mshv.h
[ ... ]
> @@ -219,6 +220,55 @@ struct mshv_gpap_access_bitmap {
[ ... ]
> +struct mshv_complete_isolated_import {
> +	union hv_partition_complete_isolated_import_data import_data;
> +};

[Severity: High]
Will this cause a compilation failure for userspace applications including
<linux/mshv.h>?=20

It appears union hv_partition_complete_isolated_import_data is defined in
include/hyperv/hvhdk_mini.h, which is a kernel-internal header and not expo=
rted
to userspace.=20

Because userspace headers cannot access this internal definition, embedding=
 the
union directly by value here will evaluate to an undeclared, incomplete type
for any userspace application trying to use the UAPI.

[ ... ]
> @@ -254,6 +304,11 @@ struct mshv_root_hvcall {
[ ... ]
> +#define MSHV_COMPLETE_ISOLATED_IMPORT	_IOW(MSHV_IOCTL, 0xF4, struct mshv=
_complete_isolated_import)

[Severity: High]
Does this ioctl macro expansion also fail in userspace for the same reason?

The _IOW macro implicitly requires the size of the incomplete type during
expansion, which will also break compilation when the underlying struct rel=
ies
on the kernel-internal union.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807135134.3039=
43-1-weh@linux.microsoft.com?part=3D1
