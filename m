Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0BB314D37;
	Mon, 10 Aug 2026 19:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388401; cv=none; b=SxTbXHIPS5c0xvucK+1/yP1zfChsV8PgtCsrLUNlAuTare7MKJ2cLnuXvIOzJw3nW+eC3W30IpYQcoT08ayFJL/++VE/QlG/vyMc8zJ2VfbKfFG4/E5JEvn1skVajwq4QmM1NJj+wyoD/4Zg+Xmaoy2LGxxEQg8/dH9sDj4hm8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388401; c=relaxed/simple;
	bh=z9jvuMGSn3wG4EkijCyrscWYGgkVyHqY5HbqNoJqvPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7A6Alewnh+Lj4IbGr5lpjZuU464d7HwlaYNwNmwGqQ+Ub3/Mz7dajvwsqHAx8TXfyPqCTjEwOtlWj4MEUxbxzjWzJPyFMYUgvkNIcsTD0lg7zkcFydvHfTzlrE2P+K54Q4ADQvTV2g4UOoAmuzFp8xt3wc4+ympCMO0Y1IckIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cd8ToKbW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cd8ToKbW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B23181F000E9;
	Mon, 10 Aug 2026 18:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388399;
	bh=BrGutwOmQzAod7wW9aa2Qu1QyV6AH/gbqvGOutCf8Q8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Cd8ToKbWlTwOz1s97lWe2ufAKulANF9S3tB6KGqpY5qHXMrrzG0POskKHWh5atwet
	 kEk9z1c5qpoZ4S2ef4mpMf+NDLIUXJvs8GW7F2vY1YucSPE59wlOGlGtqVxlEukCvb
	 II8z2JrdkQ6X0WYAWwUcGaJ3GgsUwtox570Ra4+8+Wi5id94MSgXs2UK0IZR/u+iA1
	 Yehag3aW4OPONDV/1WvgsDIBviUA8WvvRqaYuybjL6ZBCQL/i5KzqzodxVzTigEebD
	 VzuHMUe/z9X+ClTRijb7r0hJ3nBNofVfeOtXZ+pcdUC6WFPHA/2RzmNuMWJ3zpI33p
	 ndhlAoXRhxgfQ==
Date: Mon, 10 Aug 2026 11:59:58 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Wei Hu <weh@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
Subject: Re: [PATCH v2 05/13] hyperv: fix hv_input_get_system_property layout
 for SNP status
Message-ID: <20260810185958.GE2496954@liuwe-devbox-debian-v2.local>
References: <20260810124527.1409634-1-weh@linux.microsoft.com>
 <20260810124527.1409634-6-weh@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810124527.1409634-6-weh@linux.microsoft.com>

On Mon, Aug 10, 2026 at 12:44:59PM +0000, Wei Hu wrote:
> From: Wei Hu <weh@microsoft.com>
> 
> The processor-feature selector must sit at offset 8 (property_id + u32
> reserved), matching the Microsoft Hypervisor ABI. Upstream 7.1's leaner
> struct placed it at offset 4, so HVCALL_GET_SYSTEM_PROPERTY(SNP_STATUS)
> failed and mshv aborted (no /dev/mshv). Restore reserved + u64 union.
> 
> Signed-off-by: Wei Hu <weh@microsoft.com>

This patch exists in upstream as:

commit d6f0248f04a96249660591e47fcf37ba98ac7ea3
Author:     Wei Liu <wei.liu@kernel.org>
AuthorDate: Tue Jun 30 14:57:54 2026 -0700
Commit:     Wei Liu <wei.liu@kernel.org>
CommitDate: Wed Jul 22 21:58:21 2026 +0000

    mshv: fix hv_input_get_system_property struct

    Keep it in sync with the correct definition.

    The old code worked by chance.

    Fixes: e68bda71a2384 ("hyperv: Add new Hyper-V headers in include/hyperv")
    Cc: stable@kernel.org
    Signed-off-by: Wei Liu <wei.liu@kernel.org>


You can drop this.

Wei

> ---
>  include/hyperv/hvhdk_mini.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/hyperv/hvhdk_mini.h b/include/hyperv/hvhdk_mini.h
> index db83fedce243..dd84085c0aff 100644
> --- a/include/hyperv/hvhdk_mini.h
> +++ b/include/hyperv/hvhdk_mini.h
> @@ -237,8 +237,9 @@ enum hv_dynamic_processor_feature_property {
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
> 2.43.0
> 
