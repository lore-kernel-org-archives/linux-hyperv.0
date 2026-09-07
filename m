Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D7417366;
	Mon,  7 Sep 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764459; cv=none; b=duvxMpK5v2xVojSdNhrZcc4dDbIKRh+NQAfvg/4za73xvWwO89qxRUGUyTIUIH0bdPd5vd0MMB6trJh5RJ9yUleV5v0xwSyzxbuuiXKxTC31Ss4y19lqQF0YPfKrPYTsuzjbuenBmxScbLhV9kMYbtGX2k3AiToHRzEyTPklZjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764459; c=relaxed/simple;
	bh=Trr8xobQJsHw1TGMf6aO4R57IuIDMlaCgq7a55MSMHs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=HTXWwR6YBCG4IMOrRzd+KPaEbGPPIwTtm6HZijpXdzFf8JerFa3Yp+/eZrKhzm3RNvClSDQRdkDlMGQmvse4lbuOB9qakPZ2tZb5DxuRtOYkRqP0N4nrO8NQE+a6NYnG8oVTaljeHN2A7nAFkLdLEps+nXL3LMUOe+/HM3rCgQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWbCgOvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWbCgOvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E061F00A3A;
	Mon,  7 Sep 2026 07:00:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788764456;
	bh=Trr8xobQJsHw1TGMf6aO4R57IuIDMlaCgq7a55MSMHs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LWbCgOvcUbyM/yrqSlZiyYdgd6nB69PKywLFJ/xbg3xOc8dph2tYnOQy8nRHtg0p+
	 7S6xvR8KVBLgie9WEe2tmGGKkc+yEqUaumf0bB5DEkbPWkePeZXnbLRlkl0qQ7S3lj
	 RPjmWOvToJf/lJV8YNJY21HVIpqHVPTNgVGF5C5vSD8s/YSyoZ3mezm67HQsi6mI5G
	 vIUkQUh6UADZZXTYuCixDt3Mv2NNj6gOOiC04vn1chWcLnvAEIJuTFGf98i6YQ0j0x
	 5ue4bdoEqlx3AR+xjjCuAd7RueHcEundh+xDVfblCgLEzkcKyrz0tGsPDqxO+GCuIf
	 8NPGaj0Eup8Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/3] x86/irq, iommu/amd, x86/hyperv, PCI: Drop
 redundant irq_retrigger inits
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260907065129.269262-4-namjain@linux.microsoft.com>
References: <20260907065129.269262-1-namjain@linux.microsoft.com>
 <20260907065129.269262-4-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 07:00:56 +0000
Message-Id: <20260907070056.B2E061F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> With fixup_irqs() and the generic resend path (try_retrigger()) now both
> falling back to irq_chip_retrigger_hierarchy(), installing it as the
> irq_retrigger() callback on the outermost domain chips is no longer
> required. The hierarchy walk reaches the x86 vector domain's
> apic_retrigger_irq() for all of these stacked domain chips.
>=20
> Remove the now redundant irq_retrigger() initializations from the outermo=
st
> domain interrupt chips, including the Hyper-V root partition PCI/MSI chip.
> msi_set_affinity() is the only site that invoked the outermost chip's
> irq_retrigger() directly. Convert it to irq_chip_retrigger_hierarchy() so
> the x86_init_dev_msi_info() initialization can be dropped as well.
>=20
> No functional change intended.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907065129.2692=
62-1-namjain@linux.microsoft.com?part=3D3

