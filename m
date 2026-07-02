Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464B63546D2;
	Thu,  2 Jul 2026 16:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010544; cv=none; b=DX7PcrLMHSrRZFcB6U+wMnkMLo6zKB3MQCzwfVqW5Q99qIOB/cX+cxs6WkYcNq+7l8QDxmGuzszhUZROmp9MeXiQzousvgaZwtSOMpRAjEkTs8uAIGnRY8FM38lnSwNwkLt3JZKFfjVsYwUTmFaX3+/u3zR87G3XZT+HHMlfRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010544; c=relaxed/simple;
	bh=GTS6Uu9pJPrqEx4yIeERKVg833roPmZ7jMVMjztHBFg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CwewBhm+2pV8SItNInaldyXUFf9E4QEtS5CNzFMCbI9INYkqY+8TTJVJjqeY6Emi1GoPG/6V5CpdXzD9ANnEOUMBWyWBKGSIH3kuhJGMKcg0msnY2zEJbeSGQ0OpzR/1X+Mi1fT5MpEAqGB8oqTK/Mi9aRbac2b8K+eM+umtcfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kKppJCYF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kKppJCYF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200F81F00A3A;
	Thu,  2 Jul 2026 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010543;
	bh=GTS6Uu9pJPrqEx4yIeERKVg833roPmZ7jMVMjztHBFg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kKppJCYF3VQXzHS13ud3qCNYBeVJT+Yqm4haa5QeEsD8tDhOS48mwe5rGnuNC7N+Y
	 Yjplv3zMkU5qraZxGPmCSJ2UPnJQeyFjM6Bn+lnDoD+UtlS4CxLQ2WExcD+tHYFdKs
	 Pcn5J5PtIQjYzy/iqVix+rN/M956JKLYRl9ibpOdQu1mc9tgq3uKeS7fxao3RkgmuS
	 stitn+hyr8yOzPzvF2vpi0IDKWe3z/ONeQY7AGQiL/dT7ly5jcKWq1x604AfiN7uxs
	 m53j0/21IyyTCoU6LQFHbkQh0tb1utgnHlTx8IZ84D5jMRq7FpYYekvgh6jTriYw/k
	 xkD/PZMYkBybQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] Drivers: hv: Add logical device ID registry for
 vPCI devices
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yu Zhang" <zhangyu1@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
References: <20260702160518.311234-1-zhangyu1@linux.microsoft.com>
 <20260702160518.311234-3-zhangyu1@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 16:42:21 +0000
Message-Id: <20260702164222.200F81F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
>=20
> Hyper-V identifies each PCI pass-thru device by a logical device ID in
> its hypercall interface. This ID consists of a per-bus prefix, derived
> from the VMBus device instance GUID, combined with the PCI function
> number of the endpoint device.
>=20
> Add a small registry in hv_common.c that maps a PCI domain number to its
> logical device ID prefix. The vPCI bus driver (pci-hyperv) registers the
> prefix when a bus is probed and unregisters it when the bus is removed.
> Consumers such as the para-virtualized IOMMU driver look up the prefix
> by PCI domain number and combine it with the function number to form the
> complete logical device ID for hypercalls.
>=20
> The prefix construction is shared via hv_build_logical_dev_id_prefix() so
> that pci-hyperv's interrupt retargeting path and the registry use exactly
> the same byte layout. It is derived on demand from the constant hv_device
> instance GUID rather than cached in struct hv_pcibus_device, which is
> private to the pci-hyperv module; this keeps the interface narrow and
> avoids depending on pci-hyperv internals.
>=20
> Co-developed-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> Signed-off-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702160518.3112=
34-1-zhangyu1@linux.microsoft.com?part=3D2

