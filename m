Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C1C45DF6B;
	Tue,  4 Aug 2026 13:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849952; cv=none; b=hPTh6HnRMtM/vV9Pi2Wb79VZuYnLdjpTYdx2SA/r4Qv7vxHBkPBUiD50EmLDwCYijXrjMFJpfAuVHWc/iY/OBamNr9fhBaforSCfKM5PVC8WHkHcp+ujOabTDN0cOISfTNJ+re5ld+k/XZzAmbJTFzzd2zk0L3CUz2CZaGBJZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849952; c=relaxed/simple;
	bh=ksNSGzquOkJGQB0zL8v2rsj/K3g8ppWK1umePFku/MI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z41tQtRCVXu+KilzAb50cAbRfPsa3z2nq07SOn5EFA9cdIScMqcYPdiyok3QeUGShdbrs3NZfSId2dq9G7zo7SjlgFyFFU3aax8dlGJHeVpYcUNgXtkd+v6w3QfRnqcyENch8H3fZMeVJncEceH2+gbfdHKcjXiIMlfqwfoSdic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmqZl9Fo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmqZl9Fo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294781F000E9;
	Tue,  4 Aug 2026 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785849949;
	bh=4wyjvMKvhAcJreTXfeaRljIo44c1fS4JMWl0lopeTOU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FmqZl9Fol+ZLScWCrNFkjh56XTMy2ufbmJSsdKBe8HXMYmw4W/XP4gDcaraS3Fv7G
	 usGqat3c/TjgPagCirQz4DeFr87nERBj4itU7pslemBxvRqyrpMPe6TmGZJI2ryYbo
	 u9+s/rJV1wTDhj3ItK1GHaor0geHno0bouLKxgwOhZeCVdiDeTeN98Vu6zlXIoMyr3
	 qElG0HcmBzxIsQyLDOwW5wt3XvrIzlRvGCyOoOL77+tffknud+j+i+bq7CYGOVO3ps
	 jJMFKb209Vxipz+keGOXjrcbotLhHmdWO4NnSfyraIqWfruwDNaLxgCVpcD43KOg34
	 8Hp4hCRzTe0fQ==
Date: Tue, 4 Aug 2026 14:25:42 +0100
From: Will Deacon <will@kernel.org>
To: Kameron Carr <kameroncarr@linux.microsoft.com>, aneesh.kumar@kernel.org
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, mhklinux@outlook.com,
	catalin.marinas@arm.com, mark.rutland@arm.com,
	lpieralisi@kernel.org, sudeep.holla@kernel.org, arnd@arndb.de,
	thuth@redhat.com, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH v3 1/6] arm64: rsi: Add RSI host call structure and
 helper function
Message-ID: <anHoVr_PRkBHRGu3@willie-the-truck>
References: <20260721201148.1441143-1-kameroncarr@linux.microsoft.com>
 <20260721201148.1441143-2-kameroncarr@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721201148.1441143-2-kameroncarr@linux.microsoft.com>

On Tue, Jul 21, 2026 at 01:11:43PM -0700, Kameron Carr wrote:
> Add struct rsi_host_call to rsi_smc.h, which represents the host call
> data structure used by the Realm Management Monitor (RMM) for the
> RSI_HOST_CALL interface. The structure contains a 16-bit immediate field
> and 31 general-purpose register values, aligned to 256 bytes as required
> by the CCA RMM specification.
> 
> Add rsi_host_call() static inline wrapper in rsi_cmds.h that invokes
> SMC_RSI_HOST_CALL with the physical address of the host call structure.
> This will be used by Hyper-V guest code to route hypercalls through the
> RSI interface when running inside an Arm CCA Realm.
> 
> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> ---
>  arch/arm64/include/asm/rsi_cmds.h | 22 ++++++++++++++++++++++
>  arch/arm64/include/asm/rsi_smc.h  |  7 +++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/rsi_cmds.h b/arch/arm64/include/asm/rsi_cmds.h
> index 2c8763876dfb7..9daf8008e5da2 100644
> --- a/arch/arm64/include/asm/rsi_cmds.h
> +++ b/arch/arm64/include/asm/rsi_cmds.h
> @@ -88,6 +88,28 @@ static inline long rsi_set_addr_range_state(phys_addr_t start,
>  	return res.a0;
>  }
>  
> +/**
> + * rsi_host_call - Make a Host call.
> + * @host_call_struct: IPA of host call structure
> + *
> + * This call will fail if the IPA of the host call structure:
> + * * is not aligned to 256 bytes,
> + * * is not protected / encrypted,
> + * * is RIPAS_EMPTY
> + *
> + * Returns:
> + *  On success, returns RSI_SUCCESS.
> + *  Otherwise, returns an error code.
> + */
> +static inline unsigned long rsi_host_call(phys_addr_t host_call_struct)
> +{
> +	struct arm_smccc_res res;
> +
> +	arm_smccc_smc(SMC_RSI_HOST_CALL, host_call_struct, 0, 0, 0, 0, 0, 0,
> +		      &res);
> +	return res.a0;
> +}

As I've mentioned to Aneesh on two occasions already [1][2], this code
should be moved out of arch/arm64 before we add anything else to it.

Thanks,

Will

[1] https://lore.kernel.org/r/agsNO9cc7H-b0H8L@willie-the-truck
[2] https://lore.kernel.org/r/al_svOwkb5SleTWg@willie-the-truck
