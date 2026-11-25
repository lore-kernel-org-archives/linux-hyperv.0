Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795610230;
	b=N5u1s5eP6lclngY+Nzu9d/RF0x8S1bslBxLGFAuGV2IGutXrR2fEswL98XaUDdHJiyZW
	 iZ/CVDO0gXp003RF9b6pD6fc1164vlQooPKxknHJTEAlUiLqKS4oapJQQPx51sPsQ1AZ/
	 5O6849j+KvCs0VdaSLfrqNNF/JVjxDu5KXjMvoRoBIJyHksjTz+pjlAZJ0glDtV6hWriW
	 jXGWm6PTZ7MCq1CW4cViuFvnCmSfJvlSqBhf16gwVKciPSCyXU2tO0XdQWvaztQ4ObUS6
	 do3qKoC0hYPtn4WH7/VfXw7ciZpvdN9y98hkq1slRToYmp1IgMcGXRJPN3+OZl0qgtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795610230;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:In-Reply-To:References:Organization:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=4pIL38w9A3gdcQQ2Fq7C7ElgTfT9wt+HeDTbfSsUEYo=;
	b=zAVRiwVP/KudgR9131opACBb5ouX9JCYNTxToSuRA//HgK0Aphn63yvTgF1lXmVzOpVK
	 cvPrDEioU5JJ7Y9vGDoBSZxc51JcnYDfYKOojtyy771aAu0FNgiqCmeqKlfR/HPOz4vVh
	 LT14dI+d7+T9WHcs9Qe41GKfOyXRm4OlWRsm+2hNUlklk3P/Qg74AP3hsGfiBCarQtVwK
	 quCifewrRYvjkiAUKnmt41KCxbKp14kzaWTFW92OBot+b7bsOTE2m74rx9o2hv87gP3Bn
	 UlPxJuotpdmsGPR7puFWTeQshPS7DjIMEa6scB/mqiWszUB2mZ03qwqcvTLcr93Ozcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YhPks0LG;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DDAF606A323;
	Wed, 25 Nov 2026 12:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3DDAF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=YhPks0LG
Received: from localhost (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id A1DFE20B7170;
	Wed, 25 Nov 2026 04:36:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A1DFE20B7170
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795610223;
	bh=4pIL38w9A3gdcQQ2Fq7C7ElgTfT9wt+HeDTbfSsUEYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YhPks0LGvq+pZuuxixVJ62GTFNm7lH4LNPCUg/O19AD7n10pw6CzkthtwSdb1a9IN
	 MO7bqLug6Aa7/bJtsftjlYvQhHBUEnUHUxkbdxM9XiLxpSkTcg+jxlmMsBBkOdHJ1d
	 X53KcCxTFu/7Gg5YXoieTtAXgOzpA73teX4x8Fsc=
Date: Wed, 25 Nov 2026 04:36:59 -0800
From: Jacob Pan <jacob.pan@linux.microsoft.com>
To: Yu Zhang <zhangyu1@linux.microsoft.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Jason Gunthorpe <jgg@nvidia.com>, Easwar
 Hariharan <easwar.hariharan@linux.microsoft.com>, Tianyu Lan
 <Tianyu.Lan@microsoft.com>, Mukesh R <mrathor@linux.microsoft.com>, Thara
 Gopinath <tgopinath@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>, Dexuan Cui <decui@microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>, iommu@lists.linux.dev,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH] MAINTAINERS: Add dedicated entry for Hyper-V IOMMU
Message-ID: <20261125043659.000027d2@linux.microsoft.com>
In-Reply-To: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
References: <20261125074331.25190-1-zhangyu1@linux.microsoft.com>
Organization: LSG
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Yu,

On Wed, 25 Nov 2026 15:43:30 +0800
Yu Zhang <zhangyu1@linux.microsoft.com> wrote:

> Changes under drivers/iommu/hyperv/ are merged through the IOMMU
> subsystem tree, while MAINTAINERS currently lists the directory under
> "Hyper-V/Azure CORE AND DRIVERS" pointing to the Hyper-V tree.
> 
> Move drivers/iommu/hyperv/ into a dedicated "HYPER-V IOMMU DRIVER"
> entry pointing to the IOMMU tree, with Yu Zhang as maintainer and
> Jacob Pan, Easwar Hariharan, and Tianyu Lan as reviewers. Keep
> linux-hyperv@vger.kernel.org on the mailing list entries so the
> Hyper-V community stays copied on patches.
> 
> Suggested-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> Signed-off-by: Yu Zhang <zhangyu1@linux.microsoft.com>
> ---
> Easwar, Tianyu: please let me know if you have any other thoughts or
> suggestions.
> 
> Wei, Haiyang, Dexuan: feel free to chime in if you have any feedback
> on moving drivers/iommu/hyperv/ out of the Hyper-V core section.
> 
>  MAINTAINERS | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 44540a1eb2b8..dcdc73e9ce6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -12448,6 +12448,17 @@ L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	drivers/media/i2c/hi847.c
>  
> +HYPER-V IOMMU DRIVER
> +M:	Yu Zhang <zhangyu1@linux.microsoft.com>
> +R:	Jacob Pan <jacob.pan@linux.microsoft.com>
> +R:	Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
> +R:	Tianyu Lan <Tianyu.Lan@microsoft.com>
> +L:	iommu@lists.linux.dev
> +L:	linux-hyperv@vger.kernel.org
> +S:	Supported
> +T:	git
> git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux.git
> +F:	drivers/iommu/hyperv/ +
>  Hyper-V/Azure CORE AND DRIVERS
>  M:	Haiyang Zhang <haiyangz@microsoft.com>
>  M:	Wei Liu <wei.liu@kernel.org>
> @@ -12470,7 +12481,6 @@ F:	drivers/clocksource/hyperv_timer.c
>  F:	drivers/hid/hid-hyperv.c
>  F:	drivers/hv/
>  F:	drivers/input/serio/hyperv-keyboard.c
> -F:	drivers/iommu/hyperv/
>  F:	drivers/net/ethernet/microsoft/
>  F:	drivers/net/hyperv/
>  F:	drivers/pci/controller/pci-hyperv-intf.c

Acked-by: Jacob Pan <jacob.pan@linux.microsoft.com>
