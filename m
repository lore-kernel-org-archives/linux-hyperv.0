Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC5519049B;
	Thu,  2 Jul 2026 16:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010212; cv=none; b=Uw6RKQM/k7RCjljAZARRBjBRiMrAK2h6jLQqfSR6v/QQvDjvtQjTHp2YeWsbvY2eHUMXVFX22GoM2m0efzLNceziJorhy/saNy4ajR5GZFTIZxfXXSr4N3L1uw9zxgHG/7ZE/5C1efHd3rY6+fWSxSo7yI5wmWTi/50t0gCUhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010212; c=relaxed/simple;
	bh=i9VQISNzX1pWMKkdROthOHX0pc3X26tQIQE83/UHHZs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g0nXSm7U+IzkOA1v3j5Il8xFL4PBdPNeUVTMyYu7B429vPxsJdSHb2WNatHXBHdEIpeASVJto+92xpiLZJ7AP1Ke5sNCc0oCdYV8ZxKHaZEAAA98LTxNtNl8odGL6n17BhXoLFuzULIbzsqoBCGvCXTyJOBTHjGSmPmosMBuXHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIRwGFX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIRwGFX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7981F00A3D;
	Thu,  2 Jul 2026 16:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010211;
	bh=X5GdJEzxuvZqI/BImFFsR0KsN9CCqgh3+vyT1B1REQg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oIRwGFX+R8w4Dm74ofhcXaYXgkGGc7X1wOmUo8DyelWWYF43wZbErfuNGUYR+uEt6
	 QXYNWXC2+3Swk9Kd+CCMvHnoeeaidtcy5U6hMWMy3IdOYnOu0zGdAx5HHy3xNdSEaY
	 +9Sqv0decb7/Y50sM5rDo9bHqrtX1g895JsNSbAjcaFLbTMbBLv2mCkgndc6+WMivB
	 KU+A3MUWLmbuqydVodM8Dk3owTFU+U3ddC7E9K++MFtst6WO0bdmc6W2uigZF1ytSw
	 IdGNy5D/DzGYlVPVDULFZi9Itri8QXQLdDXx+CR3cZHlZyANdHw1IUZCzM08O8/P/S
	 +XIXGd5vRbtiQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] hyperv: Introduce new hypercall interfaces used
 by Hyper-V guest IOMMU
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-2-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:36:50 +0000
Message-Id: <20260702163651.0E7981F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] `struct hv_input_create_device_domain` is missing a 4-byte paddi=
ng field, resulting in a non-standard 28-byte size.
--

commit 267ecd2e71d0d7f097fc4d970780fef12801efc5
Author: Wei Liu <wei.liu@kernel.org>

hyperv: Introduce new hypercall interfaces used by Hyper-V guest IOMMU

This commit introduces new hypercall definitions to allow a child partition
to interact with the para-virtualized Hyper-V guest IOMMU. It includes
interfaces for capability detection, device/domain management, and IOTLB
flushing.

[ ... ]

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9bc..493608e791b45 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h

[ ... ]

> +union hv_create_device_domain_flags {
> +	u32 as_uint32;
> +	struct {
> +		u32 forward_progress_required: 1;
> +		u32 inherit_owning_vtl: 1;
> +		u32 reserved: 30;
> +	} __packed;
> +};
> +
> +struct hv_input_create_device_domain {
> +	struct hv_input_device_domain device_domain;
> +	union hv_create_device_domain_flags create_device_domain_flags;
> +} __packed;

[Severity: Medium]
Does this structure need an explicit 4-byte padding field at the end to
ensure its size is a multiple of 8 bytes?

Because the struct is packed and lacks tail padding, its size is exactly
28 bytes. These structures are often initialized on a reused per-CPU page
like this:

hv_create_device_domain() {
        ...
        memset(input, 0, sizeof(*input));
        ...
}

If the hypervisor expects an 8-byte aligned 32-byte input for this hypercal=
l,
the memset will only clear the first 28 bytes. This leaves 4 bytes of
uninitialized garbage from previous hypercalls in the tail end of the buffe=
r,
which might cause domain creation to fail if the hypervisor strictly valida=
tes
padding fields to be zero.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160518.3112=
34-1-zhangyu1@linux.microsoft.com?part=3D1
