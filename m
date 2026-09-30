Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA8A5013B0;
	Wed, 30 Sep 2026 14:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790778042; cv=none; b=kjKKGwWl6nEzblw6q1pjB4Mf/kbEsJFqbpoFhC8mK0qQwceRm5C2cNPzGZECVv23msr4Ne5nwFWETCoFNgXEVB4WwT9kLSgsp+Ixy9hdpqwvpU5O3BbSgLAXIzFSyGCGF8yOjA5dYtgReqABqg9uus0PiXrs+tdvyGAa1eOyVP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790778042; c=relaxed/simple;
	bh=8eGLQvp/bfVK/U/uouS83NcjhJZhHN+6sjuzTvy7B5k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=K95I4O+rszPPrL6i6VDP7ZyinQ5I8Vfn7zRfP5abozbglide/IoVK3OnaOZSLBgcAmHcWjqu/dcPNTSNPnyMbSnufcB6k5RCxw1+KQkST3DerSlwUaIgfo39myF80s+4gk/1wO1pSAufShx1hq+Ce4wEBnonoeVCvN+7RF9JVdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nUTn3tb5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nUTn3tb5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DAF81F00893;
	Wed, 30 Sep 2026 14:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790778030;
	bh=8eGLQvp/bfVK/U/uouS83NcjhJZhHN+6sjuzTvy7B5k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nUTn3tb5Dhxs7l9ndOVhqCYu1JibSsANGU8Rr76c6eomh+tFYV8Eq3iBED40nyDMj
	 OibU33CBYJTcukstHjNUkpv8CwDiso6tludIaRc/PYNwgptRqe0EBtl9Q+JHQcbOlL
	 TYEwm3z0Kd8f/+Cd36kuCblVAXAV5Kn4gjxx9ag9hjbFgfWGOLnAjp7kH/qcs2qruH
	 Z4jr+zly8oLqkvYwW/sygn0w9HvSqQdiCgcFxpJ0nf8HDxHi2T+fs8vZviPnTGQ0ry
	 SFJCk9jwtY7jBrNpbMS85xOzwX7cROZoPGZhGAxY4EIqdwgJnwCoZxfPtSfXL/um8h
	 qS08DQH3xjM2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] iommu/x86: Add architectural MSI reserved region
 helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org
In-Reply-To: <20260930141409.437904-4-zhangyu1@linux.microsoft.com>
References: <20260930141409.437904-1-zhangyu1@linux.microsoft.com>
 <20260930141409.437904-4-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 30 Sep 2026 14:20:29 +0000
Message-Id: <20260930142030.0DAF81F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> Intel and AMD IOMMU drivers both reserve the x86 architectural MSI
> address window from normal IOVA mappings, but each open-codes the range,
> allocation attributes, and insertion into the reserved-region list.
>=20
> Add iommu_add_resv_x86_msi_region() to encapsulate those operations, and
> convert the Intel and AMD drivers to use it. Return an error on allocation
> failure so callers can preserve their existing error paths.
>=20
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260930141409.4379=
04-1-zhangyu1@linux.microsoft.com?part=3D3

