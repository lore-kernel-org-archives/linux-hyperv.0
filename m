Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE15227B94;
	Sat, 18 Jul 2026 02:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784341849; cv=none; b=AsugL5EurGkcjY9NlrnSjOat8APBncYCetcehGQpLTkymrDFu+dcZqdUC45VQcspHwMPfXy1TUwPSom0lcWRysZeoOE8EZAIbKs6D9nKwKNvZbI/f9Yu9BEyykZ65ThhOlNKSLNEGOkC0lGFAxqI0chj+7n4OQ4fStvb0u24e4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784341849; c=relaxed/simple;
	bh=6eCdo9ENdDFUOn1f/N4as+R1qCUjSX9KY9b+JIRteZw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CdfmNEjAgx5RBpW5Mj8LNhwrBwFgW2V1oO/PZQQb0qEnFvywcpHvy63ZkmdX2JL6QqubraTqzy29xHGmcteS/abMl1VkOkGvt6+Oa03mBfEDXLr9uAic2GCYBU0xevyO5H+6RUIeQOXDlmvAnQtCA215VzxGanggofdbT4dZ9Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjLrGNtt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjLrGNtt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8EC51F000E9;
	Sat, 18 Jul 2026 02:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784341848;
	bh=lKeHcNaz6UKNaGXV5CV8O8HgpA4OtK75wqf/Jo7mkFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RjLrGNttKIXqVLaMCBKQGFZTH8XTwoORpyEG2rrtlH3dhz1dT8/S7oZh/TfzOfslK
	 fKv2yII4/xkCtb8YBHsinYkxnO5pnSohBc/hPO9g6JzWwyxQxB5R/ND/STk/5NacBC
	 hoUE2knQAyfMNSKNLa+exb9LVM5X2jYLCgacUI5pbmTcXpGvfJY82dUxtD079UOXql
	 npA5nm/N5xcbgtgIIfgH+Mml62m+l31wJ8NMGkUNlUdsk2Shdj2vTsg+yYQjz4UROI
	 s/pqLfV3UaCexCI4Mt97CWbJ0UJnNJAcES+KBEGLWjztibET0UGKf2kunMsRXY/Ixn
	 rsumA61idrJOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V4 5/9] mshv: Import data structs around device passthru
 from hyperv headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mukesh R" <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260718021949.926306-6-mrathor@linux.microsoft.com>
References: <20260718021949.926306-1-mrathor@linux.microsoft.com>
 <20260718021949.926306-6-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 18 Jul 2026 02:30:47 +0000
Message-Id: <20260718023047.E8EC51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The memory layout of `union hv_device_domain_id` is inverted compa=
red to the expected Hyper-V ABI, resulting in corrupted device domain IDs b=
eing passed to the hypervisor.
--

--- Patch [5]: [PATCH V4 5/9] mshv: Import data structs around device passt=
hru from hyperv headers ---
commit 02ed2cd292e85f0b6e754b6a29df473f95394315
Author: Mukesh R <mrathor@linux.microsoft.com>

mshv: Import data structs around device passthru from hyperv headers

This commit copies and imports definitions and declarations from Hyper-V
public headers. These additions are related to creating domains in the
hypervisor and attaching devices to them.

> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9bc..90497635c3cbd 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h

[ ... ]

> +/* 3 domain types: stage 1, stage 2, and SOC */
> +#define HV_DEVICE_DOMAIN_TYPE_S2  0 /* HV_DEVICE_DOMAIN_ID_TYPE_S2 */
> +#define HV_DEVICE_DOMAIN_TYPE_S1  1 /* HV_DEVICE_DOMAIN_ID_TYPE_S1 */
> +#define HV_DEVICE_DOMAIN_TYPE_SOC 2 /* HV_DEVICE_DOMAIN_ID_TYPE_SOC */
> +
> +/* ID for stage 2 default domain and NULL domain */
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
Is the memory layout of union hv_device_domain_id inverted compared to the
expected Hyper-V ABI?

The macro HV_DEVICE_DOMAIN_ID_S2_NULL is defined as 0xFFFFFFFFULL, which
places 0xFFFFFFFF in the lower 32 bits and 0 in the upper 32 bits. Given
that Stage 2 (S2) domains have a type of 0, this macro implies that the id
should be in the lower 32 bits and the type should be in the upper 32 bits.

However, union hv_device_domain_id defines type as the first bitfield
(occupying the lower 32 bits) and id as the second (occupying the upper 32
bits).

Under this layout, casting 0xFFFFFFFFULL evaluates to type =3D 15 and id =
=3D 0,
instead of the expected type =3D 0 and id =3D 0xFFFFFFFF. Could this cause
malformed domain IDs to be sent to the hypervisor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260718021949.9263=
06-1-mrathor@linux.microsoft.com?part=3D5
