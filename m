Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D44329371;
	Tue, 30 Jun 2026 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859826; cv=none; b=b4fVDjjKDdev6ttaz2iJImyw52vLtORVFnKzvEn6ahq/zYAQHxSBNDflwlhoc83tmrmnZsCt0peC+01gdtaXmAMboOus6XmaV2uKEKQ5k1s3b/A7RLE8cqBC2ayr7n99uLkyj2jH2Izsg9b+jS5yVxdlWFr1qXEQ20j9TJ58sEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859826; c=relaxed/simple;
	bh=AVkiR2T904paXhw8X+uxBlEDyPr0PywmBVB0JoBPsmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNFW7wMhPPycgK8D37M1Gl2MkgrvYEJiYD2IbM0W0lpEm36PKmNs5VE8XIvcZ95zkNDGPun8h19iDrygXM67ksaGXR5OWHQ6Kx62hcVA9eci/jOvGz3RC+m5iSPSJw9Arag0y9PENtVLSRnxSEpBYCLBTmxWEmwmpJEIGTksIvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VV6qjPfB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VV6qjPfB"
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 6B83020B7166; Tue, 30 Jun 2026 15:50:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6B83020B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1782859818;
	bh=AlNHyLNdXKUxzV0+dDJJ6R2Z4TPIzad5lmYuyvaNHkQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VV6qjPfB8jujHayzSezGTaV56aZQOD6zzvQct9Pi9ddL78wpebU+gkg55iaDFgg4v
	 MjgHbez1nfGgmtVBFK+Pz3qlOz6EG4XpTZbzbtnBKQ+fSPFg/RoSODZ9edHG6TTP3+
	 6tnJdoMUZqzAky9C1y/5oVUZQUzox7AkvkoSX/38=
Date: Tue, 30 Jun 2026 18:50:18 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: wei.liu@kernel.org
Cc: Linux on Hyper-V List <linux-hyperv@vger.kernel.org>, stable@kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mshv: fix hv_input_get_system_property struct
Message-ID: <akRIKl4wTuZVw/t0@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260630215754.200779-1-wei.liu@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630215754.200779-1-wei.liu@kernel.org>

On Tue, Jun 30, 2026 at 02:57:54PM -0700, wei.liu@kernel.org wrote:
> From: Wei Liu <wei.liu@kernel.org>
> 
> Keep it in sync with the correct definition.
> 
> The old code worked by chance.
> 
> Cc: stable@kernel.org

Any idea how far back this goes? Also, does it require a check on the
hypervisor version, or was it always wrong?

> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/hyperv/hvhdk_mini.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index b4cb2fa26e9b..035ba20870f7 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -184,8 +184,9 @@ enum hv_dynamic_processor_feature_property {
>  
>  struct hv_input_get_system_property {
>  	u32 property_id; /* enum hv_system_property */
> +	u32 reserved;
>  	union {
> -		u32 as_uint32;
> +		u64 as_uint64;
>  #if IS_ENABLED(CONFIG_X86)
>  		/* enum hv_dynamic_processor_feature_property */
>  		u32 hv_processor_feature;
> -- 
> 2.53.0
> 
