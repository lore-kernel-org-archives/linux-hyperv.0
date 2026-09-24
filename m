Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B903CF97A
	for <linux-hyperv@vger.kernel.org>; Thu, 24 Sep 2026 02:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216016; cv=none; b=qn8m6tlklMCIY9gBb7gMOJNqOG3/cf46KgUOo1grv+o66lhYzqK6A07aMfi26qR1VdjuY4KbcJhypDVlB5IgXOKDXWD4XHAUbVCZREy2ZL3BaX4gMbV3PbZsfagKmaK60hIQDVb2PEQoWFnEaQ8y7C4l346R0scmbR6QDCH4IVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216016; c=relaxed/simple;
	bh=zXn4mDq9szUMFQlBTRBtEJn90SShbQC0GSLCRElMJ98=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hTYyYYksjOfLRQ5MMl+Lz8W5BXor3XcDYpDUEYTWPLyP9Bfgvj67aC9UCVZfAeV24mYPx6Vhrty1yzIRZ4mroj58QV8AJ49j0AWN10XPWF2NTR/QHy1Aksmva9oAI688g1FVosWYj0/Btwctaaswis6JZv5fJI5NCdKXc6OIpcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kb62JHy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kb62JHy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E2A1F000FF;
	Thu, 24 Sep 2026 02:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216012;
	bh=SfJBLfPNbMBBvWQbz0KHj1xuVmWIleaMBJYGc2ZJJXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kb62JHy4cT8NHziebvHzl4ygAmoBNBtDbULeeSJPAQafCXRjBssWjfj3MCCMoCa6G
	 gk6pDIWJoCItWmDJRTeoX+nOqdHo8JZXAHxA/XwcOhttbcxFY6aK/7AFmivwHFJWR2
	 k6qDNV5AsL2dKiOes8FRXkZfXHYSo7lJAB8DyBSUOrOabVwI+wqR1vTIYOSeMA+l7d
	 WMmVZ8NOh91JzZaPQ3zFghwAeJW5kKp+LwSMcVkkid5dUGn233VsuL/bOUmsQ+jdy3
	 6jjOmBOgiLqXJlS1nPzp8RjPwz3SHHE3uTTLidnbiy0bCFMS2ke85Dm9bMcWiNOt63
	 f2A/CHIeuEyPQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V1 2/3] mshv: Import data structs around device domains
 from hyperv headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260924020221.128762-3-mrathor@linux.microsoft.com>
References: <20260924020221.128762-1-mrathor@linux.microsoft.com>
 <20260924020221.128762-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 02:13:32 +0000
Message-Id: <20260924021332.B1E2A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] mshv: incorrect bitfield layout for union hv_device_domain_id corr=
upts hypercall ABI
--

commit a37c5c0ca47021bec11c9aa7d2a0eb2626dc10ce
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Import data structs around device domains from hyperv headers

Copy/import from Hyper-V public headers, definitions and declarations that
are related to creating iommu domains in the hypervisor, attaching devices
to them, doing the reverse, etc.

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 035ba20870f73..3dbfb338bcba1 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h

[ ... ]

> +#define HV_DEVICE_DOMAIN_ID_S2_NULL    0xFFFFFFFFULL
> +
> +union hv_device_domain_id {
> +	u64 as_uint64;
> +	struct {
> +		u32 type : 4;
> +		u32 reserved : 28;
> +		u32 id;
> +	};
> +} __packed;

[Severity: High]
Does this struct incorrectly define type and reserved before id, placing id=
 in
the upper 32 bits of the 64-bit union instead of the lower 32 bits?

The imported constant HV_DEVICE_DOMAIN_ID_S2_NULL is defined as 0xFFFFFFFFU=
LL,
which has 0xFFFFFFFF in the lower 32 bits and 0 in the upper 32 bits. This
indicates the hypervisor expects the 32-bit id field to be in the lower 32
bits (LSB) and the type to be in the upper 32 bits.

Because C bitfields in little-endian architectures populate the lowest bits
first, defining type and reserved before id places the type field in the
lower 32 bits and the id field in the upper 32 bits.

Could this layout mismatch cause hypercalls to create or attach device doma=
ins
to send a corrupted 64-bit domain ID? If the hypervisor misinterprets the
domain type and ID, this would lead to hypercall failures and break IOMMU
isolation for devices when the driver populates domain_id.type and
domain_id.id.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924020221.1287=
62-1-mrathor@linux.microsoft.com?part=3D2
