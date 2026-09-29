Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8004F4E430C
	for <linux-hyperv@vger.kernel.org>; Tue, 29 Sep 2026 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721872; cv=none; b=teVV89xjcJLa88TTR1fbEIihsGhyVtze7EJ2A3Kc0SVhoeiWSTtk7HfVFs/eLrsh+9SEN1xiG+DzWcEDSPgRUoIKdOhbv3YjD7O9XuyKcyYhD4AJ2s0FM1pbwHu+D3VZvcXlJlU1YLE6tB+Mhl3Pk8ctMnZPuxHq3c76Ew7jO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721872; c=relaxed/simple;
	bh=JDvCCPWxlCPPR+ZuErGjkB3TvTN8aOGY5TNFSizvo+w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ioov3tSaeysLPC4xaWbv4UOtb7RTjJi+hFe8Uu5nH5IU7kOrPcyNko7enkZ3GW+ADwynYw2EacAwLx9okyfXCVgOwmNgDANmei+dCb1rjuM7LtrWdoM3Irqxz+UFIS83/8yvnfLqotZql69Lu8y14Y6mfDc5ZPu8URGyc0NKbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dmRfDg/K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dmRfDg/K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED6301F000FF;
	Tue, 29 Sep 2026 22:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790721871;
	bh=DVb6oiEOsrNVnjUYFt18tBOLY+1P9HqUZVRve0AB+KI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dmRfDg/Krn9q9bCqQ/FCiU1W8O8IQc+DLq57pl9E/MjH70kt2P0pgl58ky+ueP96X
	 VI8EQWwNfr8SbTQJX1OaL5aeM7RqkD3oAb5vAy02J/cxbUX2TlSbD8KP1DPFteXbD7
	 Qxp5FJmsT9p8YqarcSzOWi4WSw/Nt0TiYBlT8FYV9AXnpJpexgnkRv0oXLvnh/EmgP
	 HidOh4eLi7r2IMH169Ks40DZYN1mbclZQ5sB05woV1X0+ANs/LtoG8sUU80lLK7d1p
	 DDRglzYHxsduERCrdMKl9JlLwVZrKXmy8C3bKon1Fbf7pTYKSzQIqeSdZzO/bWdFL8
	 JL1Jfz2JbeFnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2 3/4] mshv: Import data structs around device domains
 from hyperv headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org
In-Reply-To: <20260929223622.778617-4-mrathor@linux.microsoft.com>
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
 <20260929223622.778617-4-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 22:44:30 +0000
Message-Id: <20260929224430.ED6301F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] hv: ABI contract violation due to inverted struct layout in union =
hv_device_domain_id
--

commit c28c527a68422d4f65cc6bf951a593dabdfd536b
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Import data structs around device domains from hyperv headers

This commit copies and imports definitions and declarations from Hyper-V
public headers related to creating iommu domains, attaching devices to
them, and other related operations.

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index 035ba20870f73..3dbfb338bcba1 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
[ ... ]
> +#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
> +#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
> +
> +#define HV_DEVICE_DOMAIN_ID_S2_DEFAULT 0
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
Does this struct layout correctly match the hypervisor ABI expectations?

The macro HV_DEVICE_DOMAIN_ID_S2_NULL is defined as 0xFFFFFFFFULL,
representing an invalid S2 domain. For a 64-bit value to have a type of 0
(S2) and an id of 0xFFFFFFFF and evaluate to 0xFFFFFFFFULL, the id field
must occupy the lower 32 bits, and type must occupy the upper 32 bits.

However, the current layout places type in the first 32-bit word (lower
32 bits) and id in the second (upper 32 bits).

If the driver populates type 0 and id 0xFFFFFFFF during domain creation or
attachment via HVCALL_CREATE_DEVICE_DOMAIN, wouldn't it produce
0xFFFFFFFF00000000ULL?

Will the hypervisor misinterpret this as an id of 0 and a type of 15
instead, causing the hypercalls to fail or operate on the wrong domains?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929223622.7786=
17-1-mrathor@linux.microsoft.com?part=3D3
