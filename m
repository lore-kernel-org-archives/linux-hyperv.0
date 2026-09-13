Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792DE374E6F;
	Sun, 13 Sep 2026 23:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789340679; cv=none; b=fuZZ69PqNe0csUINm/ARQjmlnMhoMLyMK/TXraslOtv+7IRAqlYhyPLi9WyLtR/DGDUx3EepBypsOWP3iutapqhiZ9hJa1jq2SL1/JDuFFWdMzvJ/isqjIjk6TLTmDtQI4Mkjow/tZvwy2eco6Ld8FiilEacuO5f+g5xUvibUfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789340679; c=relaxed/simple;
	bh=58+zVChsuWJCBAWFInD47an+V6ia2yTcx5IybLfOLRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/aaGdECL6NBZ8wJby7g0UcjqrCE2/i7BGNMZ0+XHjLriwpU3pi2wEY+cQKCIgBHcoam/qdjNYPabMfFY58LFnKbQztCaJ9fjURVpvHVpqy9/z5kYAhcS6XR/WZ5qfjqJs6caD40BlE6t/KK2mL1CXXrZ0jB24TjH0ReQem7V1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Po7lshkv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Po7lshkv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BB7E1F000FF;
	Sun, 13 Sep 2026 23:04:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789340678;
	bh=rW+deSoDR82XMMFwuv/xW/X0XsLnokx6xzBHx/xDY1I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Po7lshkvEEBvAyix9a5qjov+UsAtgac+/6ChjvjSVWyq5SwNTgtanyf3A6aMAJfN2
	 pkapBdaFy1jyp4XnSur03j2wfJqGiwO2sykERxE2U4TQeAeCvWExeanr6m4dIe1aOC
	 Gs+fwnk+kBvxgYSsRlSJSfeYl6aCGrGeRfuGkUCyMLA/h+VSod9ifZEIR/ojfaIFQU
	 w7Ag7Y853j9V21/kCD7pkKi6KHgydaeonIMurpbZQg19A+B3HAODfnYh96zwoGMicf
	 YgoaUQAVrah6DC9I+EQHy0gY6P1KLoMcfX1UCaEH7JJw2jxt33XEkmjVJANPevouG/
	 C8Ht6cDxFQZqA==
Date: Sun, 13 Sep 2026 16:04:37 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 2/2] tools/hv: fix typo "retrive" in comment
Message-ID: <20260913230437.GK2219269@liuwe-devbox-debian-v2.local>
References: <20260907044946.10813-1-hemanth.selam@gmail.com>
 <20260907044946.10813-3-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260907044946.10813-3-hemanth.selam@gmail.com>

On Mon, Sep 07, 2026 at 10:19:46AM +0530, Hemanth Selam wrote:
> Correct "retrive" to "retrieve", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches a comment, no
> code changes.

There is no need to write a whole paragraph for a simple typo fix.

Wei

> 
> Assisted-by: Cursor:claude-opus-5
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
> ---
>  tools/hv/hv_get_dns_info.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/hv/hv_get_dns_info.sh b/tools/hv/hv_get_dns_info.sh
> index 268521234d4b..288821565eee 100755
> --- a/tools/hv/hv_get_dns_info.sh
> +++ b/tools/hv/hv_get_dns_info.sh
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  
> -# This example script parses /etc/resolv.conf to retrive DNS information.
> +# This example script parses /etc/resolv.conf to retrieve DNS information.
>  # In the interest of keeping the KVP daemon code free of distro specific
>  # information; the kvp daemon code invokes this external script to gather
>  # DNS information.
