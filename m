Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793314509;
	b=W1Q8VkfjTDYqb/cc4wofQpVG+Fndnz+KxWD/fzQD/tBCk5pHofUQu8HXEcOPKHGFxpzO
	 r+nxsR8E+PcAdQQmDlb6Ea+NwfoSUXXY4tHHaxrvKJhXVkgFvlphgmVbjp9SeEPvCbCRV
	 B9oG9vGAULEqy/mWBDUvcP97mAf2sKMVvSZc0zVVmuxsNSH7zbs1u2al7K1LCpiHzppkU
	 bj3QDz5uC3ll/AHHGYNCXdyvFsCX7CFuQuWuE3tWP33hHwtsjp2aXJ5agt0Sweqs8E2jE
	 YmDFlgp7QvCEN8sRgSPoIK2Zc57823n+iaCZzSLzgDE9D9l0g2im+WEWkHUtqG9zrxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793314509;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=gUsEdTCZCen2ya5mfIqI1V3L46WdjmRn9nLkUV+DgkU=;
	b=izlU3AgGRoHxB00q2l4t1lIyxC0Tdr+oMMLNl998mEsFVDDC2yuIYEZpGCajQD+Vlnkl
	 HYjgUeBK7eaaNrJWj2JA/7stiIn3tq/r5OUagzqgYWGsAAqO0SdR3QPGBoLQuoOT0VwAW
	 F/rz2n6zFdOjkCuDmmkmyw9djDCexBY287UQDRdfQ7LdUyX6vACCv9P9lqmrFfKxYgvil
	 CaBG21OeITmPe3NYarV80eeHUPmk9KlTKzYjyzGhrVXW87sEkAxVyhPEf1acgPQQQs22Y
	 owtH1V0t7gPcL3NQgBj5rFMW8TEnLF+P0LU+9Qic/D6W7mjiqeu60xOUy+kqEhdm7ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YdAmEVvy;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108FE606A31C;
	Thu, 29 Oct 2026 22:55:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 108FE606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YdAmEVvy
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 38052169E;
	Thu, 29 Oct 2026 15:55:04 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34A6A3F673;
	Thu, 29 Oct 2026 15:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1793314507; bh=/IfRaxU3Nul4k0T2WVvt2X2CtI8TxghS+GLQv9LfQX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YdAmEVvyuWfOrvI0K8oHzeizVLRf5tnnf2q4PSt+Bil1PYpt0EQZx6L/LqScpX51E
	 z0lhgXvgtL2AdW/iql+ikQ27908N1yErS2wF+HPTCcg7srGMcOlum7vhbNJxnp82d+
	 4+ruaYRoK/6HS33BQpWgXzNf+3a+gRWr3/jIcG2M=
Date: Thu, 29 Oct 2026 22:55:02 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
	mhklinux@outlook.com, will@kernel.org, mark.rutland@arm.com,
	lpieralisi@kernel.org, sudeep.holla@kernel.org, arnd@arndb.de,
	thuth@redhat.com, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v5 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Message-ID: <auPOxoaRbdOEHnv_@arm.com>
References: <20261002215725.2015959-1-kameroncarr@linux.microsoft.com>
 <20261002215725.2015959-2-kameroncarr@linux.microsoft.com>
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002215725.2015959-2-kameroncarr@linux.microsoft.com>

On Fri, Oct 02, 2026 at 02:57:20PM -0700, Kameron Carr wrote:
> Add struct rsi_host_call to arm-smccc-rsi.h, which represents the host
> call data structure used by the Realm Management Monitor (RMM) for the
> RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> and 31 general-purpose register values, aligned to 256 bytes as required
> by the CCA RMM specification.
> 
> Add rsi_host_call() static inline wrapper in arm-rsi-cmds.h that invokes
> SMC_RSI_HOST_CALL with the physical address of the host call structure.
> This will be used by Hyper-V guest code to route hypercalls through the
> RSI interface when running inside an Arm CCA Realm.
> 
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>

This looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
