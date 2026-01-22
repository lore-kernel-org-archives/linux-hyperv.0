Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089FF318BBE;
	Thu, 22 Jan 2026 01:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769044964; cv=none; b=cUE/yMFmCOGG9j6nVa6ojVJaIPxFmmBu+Sxhv7PB+vBDKqutcPAZHBzoREjzYffM8kN257I27gb8Bq9Ho+MD3VgjNownrLYVOXtAw+t0t3/pVRG8w9ouj8jb0mlZXNFxxWt1liYadc/fRuffBmGchXfU5ZH/2IxJxk4wRZtMwn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769044964; c=relaxed/simple;
	bh=CI4P8qzfIxVMaoZcD1Mkt9NxVImPp2nSRmWD3+Jxem0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mb9MlOvSYk+TkCKB1Y3gXlv6kKfwCOTHoMONXy52zKbs5lV615OmVVQES40IYUF1TwE7jvOeLQLrPbpu5+fjo7R4cF3zK8U5OQoy01YGXum/X9GTpupeiBzN/cf3LwmCpRe/gyn3Mn728/LcXg1v7IvssPMRWJwZ96wCwv0gwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RXgb9ElR; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RXgb9ElR"
Received: from skinsburskii.localdomain (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id F0ABD20B7167;
	Wed, 21 Jan 2026 17:22:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com F0ABD20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769044962;
	bh=2W1nP6JyVpPiYaq2IoL1THDDdV4A1s7rk/2HaOJt7TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXgb9ElRwtydJzGwj/+Q70EO78IcvOlPOkAzpmG6c+C3kX0FH0oHWS4aKNRGhJ5wc
	 g/Lf3KDjBFELVr9hhjDL3HVvSGavO4rP3lh7h9NGuTDJ5r3njFVUjYd/v2ZVFYUYJp
	 oIwQxkFCkzO6xvjBt8B4+yOfGj7dsDk4Uu6QZPCc=
Date: Wed, 21 Jan 2026 17:22:40 -0800
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	prapal@linux.microsoft.com, mrathor@linux.microsoft.com,
	paekkaladevi@linux.microsoft.com
Subject: Re: [PATCH v4 5/7] mshv: Update hv_stats_page definitions
Message-ID: <aXF74NU30szToANY@skinsburskii.localdomain>
References: <20260121214623.76374-1-nunodasneves@linux.microsoft.com>
 <20260121214623.76374-6-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260121214623.76374-6-nunodasneves@linux.microsoft.com>

On Wed, Jan 21, 2026 at 01:46:21PM -0800, Nuno Das Neves wrote:
> hv_stats_page belongs in hvhdk.h, move it there.
> 
> It does not require a union to access the data for different counters,
> just use a single u64 array for simplicity and to match the Windows
> definitions.
> 
> While at it, correct the ARM64 value for VpRootDispatchThreadBlocked.
> 
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
>
> ---
>  drivers/hv/mshv_root_main.c | 22 ++++++----------------
>  include/hyperv/hvhdk.h      |  8 ++++++++
>  2 files changed, 14 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
> index fbfc9e7d9fa4..12825666e21b 100644
> --- a/drivers/hv/mshv_root_main.c
> +++ b/drivers/hv/mshv_root_main.c
> @@ -39,23 +39,14 @@ MODULE_AUTHOR("Microsoft");
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Microsoft Hyper-V root partition VMM interface /dev/mshv");
>  
> -/* TODO move this to another file when debugfs code is added */
>  enum hv_stats_vp_counters {			/* HV_THREAD_COUNTER */

Given the changes you are making for printing VP counters in the
subsequent patches, this union looks redundant.
I'd suggest replacing it a simple define for the thread blocked counter.

But nontheless:

Reviewed-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>


>  #if defined(CONFIG_X86)
> -	VpRootDispatchThreadBlocked			= 202,
> +	VpRootDispatchThreadBlocked = 202,
>  #elif defined(CONFIG_ARM64)
> -	VpRootDispatchThreadBlocked			= 94,
> +	VpRootDispatchThreadBlocked = 95,
>  #endif
> -	VpStatsMaxCounter
>  };
>  
> -struct hv_stats_page {
> -	union {
> -		u64 vp_cntrs[VpStatsMaxCounter];		/* VP counters */
> -		u8 data[HV_HYP_PAGE_SIZE];
> -	};
> -} __packed;
> -
>  struct mshv_root mshv_root;
>  
>  enum hv_scheduler_type hv_scheduler_type;
> @@ -485,12 +476,11 @@ static u64 mshv_vp_interrupt_pending(struct mshv_vp *vp)
>  static bool mshv_vp_dispatch_thread_blocked(struct mshv_vp *vp)
>  {
>  	struct hv_stats_page **stats = vp->vp_stats_pages;
> -	u64 *self_vp_cntrs = stats[HV_STATS_AREA_SELF]->vp_cntrs;
> -	u64 *parent_vp_cntrs = stats[HV_STATS_AREA_PARENT]->vp_cntrs;
> +	u64 *self_vp_cntrs = stats[HV_STATS_AREA_SELF]->data;
> +	u64 *parent_vp_cntrs = stats[HV_STATS_AREA_PARENT]->data;
>  
> -	if (self_vp_cntrs[VpRootDispatchThreadBlocked])
> -		return self_vp_cntrs[VpRootDispatchThreadBlocked];
> -	return parent_vp_cntrs[VpRootDispatchThreadBlocked];
> +	return parent_vp_cntrs[VpRootDispatchThreadBlocked] ||
> +	       self_vp_cntrs[VpRootDispatchThreadBlocked];
>  }
>  
>  static int
> diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
> index 469186df7826..ac501969105c 100644
> --- a/include/hyperv/hvhdk.h
> +++ b/include/hyperv/hvhdk.h
> @@ -10,6 +10,14 @@
>  #include "hvhdk_mini.h"
>  #include "hvgdk.h"
>  
> +/*
> + * Hypervisor statistics page format
> + */
> +struct hv_stats_page {
> +	u64 data[HV_HYP_PAGE_SIZE / sizeof(u64)];
> +} __packed;
> +
> +
>  /* Bits for dirty mask of hv_vp_register_page */
>  #define HV_X64_REGISTER_CLASS_GENERAL	0
>  #define HV_X64_REGISTER_CLASS_IP	1
> -- 
> 2.34.1
