Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D55443E44;
	Mon, 14 Sep 2026 11:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789385363; cv=none; b=aAsM63Cdo8c0PEuIsX7mdtP3cqxhnpxfJRC5JY5kcxRp9Z5XPD/619eJTYOSXik5a9DVCDuqoZ6WuQMMH0FP3nn/4fJ9LFN56DvRY/PD5i/ucfR5dKWFatP2bLJcqYAkR9j6lmh0e+nLyWVpzdD7umNj9+vnVa3vDhIEr1Fms+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789385363; c=relaxed/simple;
	bh=jHGUPqMoa5WtGyaxrAun15N2Y3uRd4EREcm8B5Q9LiU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sq4zVKj/0YNUDV6YW6IQhAcs8Wj5WtzLl1GD8EcYTt4fptYPlpen+owMki2GvRYOWIlTFXTcpI3trDnWe95PY5264iDtsDPll3EFeo4lhpO+qAMQiKUR6vAr2q45X7j69W4Wlv/pJarqqldlGgHFhnRBu+Us1JkxSpqJdFHIDxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lP7RJxjz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lP7RJxjz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AC91F000FF;
	Mon, 14 Sep 2026 11:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789385358;
	bh=jHGUPqMoa5WtGyaxrAun15N2Y3uRd4EREcm8B5Q9LiU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lP7RJxjz11X/QCiMTI4aPTYYg89pNCufNCQ9dBqhVxXjVQWdTtTIiaLMrLcYBA/th
	 wc4aMSdzL0Fz1qw6VvSl1mTOgHx72CiPnKCMTyP2iwFTCBT3a6lwt3qsIsd7Srf0gH
	 fsMFXi9qWaqskAJ3aerLHZHQHP/kHGMuq3yT+kg20P2ZqOZt+zp8o8xpVI1cMxnME3
	 zeen/rp/jB3LyQWYcJ/Dg6mzTUblmClyVc42gIS0/6Ku788dNkySBbNBRa+zi1KoQt
	 IRwCl7si0RzMICP/LWfWNFQ1DFYJaVMYhxSkPuUH+3mGDx+9hw0CWuWoZq9fRuKoTc
	 rGN/xHUUOLyuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] x86/irq: Use irq_chip_retrigger_hierarchy() in
 msi_set_affinity()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Naman Jain" <namjain@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
In-Reply-To: <20260914111836.2119301-4-namjain@linux.microsoft.com>
References: <20260914111836.2119301-1-namjain@linux.microsoft.com>
 <20260914111836.2119301-4-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 14 Sep 2026 11:29:17 +0000
Message-Id: <20260914112917.C9AC91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

> msi_set_affinity() re-injects a pending interrupt on its new target by
> looking at the outermost domain chip and invoking its irq_retrigger()
> callback. Since this mirrors the behavior of
> irq_chip_retrigger_hierarchy(), use the helper directly instead.
>=20
> Suggested-by: Thomas Gleixner <tglx@kernel.org>
> Reviewed-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
> Reviewed-by: Thomas Gleixner <tglx@kernel.org>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260914111836.2119=
301-1-namjain@linux.microsoft.com?part=3D3

