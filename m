Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A083C2C0307;
	Wed, 22 Apr 2026 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776839160; cv=none; b=qU2gcIxKzWQFgg6HDSxbBox843XsdvbrgZU/GLO6Oxct+6zwc7Y40kayx19U1htXZQB0tZFWrt5jest3wcRKd/DzXtnCPjy/l2wJrGTAnLz2QwPYt7S2z7kjAGqPFnadIwo4MkYnG1WakoKgkn19EcbE3olKZ0hlkLFrsKeN9Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776839160; c=relaxed/simple;
	bh=UIsS48hwkwg+vaA44Sv+PQoDF9ZlSMsJ/DpD9VqJkls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FOfRqewLbPtQvRCD0Dr7i70TZoY+nCkTlsJcijeDmwPFYkHVwv7RYneuNyYp+cQJ87QkuDjx3GOcSnojCx0UtnEGaLSXNJM/O13BXSDHcbMz3YcIs366xD44siAF78iWoowD0R17wu8cBkKlU6GuJRgzQ+isH5Xez+qj3x0gcBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr65nNMJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr65nNMJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337B6C19425;
	Wed, 22 Apr 2026 06:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776839160;
	bh=UIsS48hwkwg+vaA44Sv+PQoDF9ZlSMsJ/DpD9VqJkls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cr65nNMJp+WO44DD8fCyb6bZDLb50nC8eX6SskEAGCfWwnByhYd/P5RZNSxIWzwdD
	 xSIgSrx/t+riZjgWh2X9bUS3Y5b3D/yiYxMLKQkX3N6j30F44dJLRuTnh6Bik6c/R2
	 i2akW4NnC/ZuTFbFsV2wu2xczIGqLGZKbULmOFxIwnyvoEA71brXvq56ATyb/p3+kA
	 9cpiB57BDW26s6byTlfuQgvA8pZkLcj4FSYOt4WpntuE+4zcH776ILLGPaH/azYBSu
	 UOF8QgsiwCBkqQnkLGV1Qd1HDGxQa5d18B/ZC8iUs3Ua8DaXlAb09Fe+SACq0tpEfw
	 JTA5m9771a6IQ==
Date: Wed, 22 Apr 2026 06:25:58 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mshv: Fix incorrect access type usage in GPA intercept
 trace event
Message-ID: <20260422062558.GA805420@liuwe-devbox-debian-v2.local>
References: <177682681331.1683870.15540242284121796900.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177682681331.1683870.15540242284121796900.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Wed, Apr 22, 2026 at 03:00:13AM +0000, Stanislav Kinsburskii wrote:
> The trace event was checking for HV_INTERCEPT_ACCESS_READ twice in the
> ternary operator chain instead of checking for EXECUTE, which would
> cause execute accesses to be incorrectly displayed as '?' in traces.
> 
> Move the access type conversion to the TP_fast_assign section where
> the raw value is available, rather than performing the conversion
> during formatting. This eliminates the redundant checks and ensures
> all access types are correctly identified and displayed.
> 
> Fixes: 03f7d01f699010 ("mshv: Add tracepoint for GPA intercept handling")

This is not yet in Linus' tree.

I folded this into the original patch.

Wei

> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
> ---
>  drivers/hv/mshv_trace.h |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/hv/mshv_trace.h b/drivers/hv/mshv_trace.h
> index 6b8fa477fa3bf..e7280c47e579a 100644
> --- a/drivers/hv/mshv_trace.h
> +++ b/drivers/hv/mshv_trace.h
> @@ -524,16 +524,16 @@ TRACE_EVENT(mshv_handle_gpa_intercept,
>  		    __entry->partition_id = partition_id;
>  		    __entry->vp_index = vp_index;
>  		    __entry->gfn = gfn;
> -		    __entry->access_type = access_type;
> +		    __entry->access_type = access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
> +					   (access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
> +					    (access_type == HV_INTERCEPT_ACCESS_EXECUTE ? 'X' : '?'));
>  		    __entry->handled = handled;
>  	    ),
>  	    TP_printk("partition_id=%llu vp_index=%u gfn=0x%llx access_type=%c handled=%d",
>  		    __entry->partition_id,
>  		    __entry->vp_index,
>  		    __entry->gfn,
> -		    __entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'R' :
> -				    (__entry->access_type == HV_INTERCEPT_ACCESS_WRITE ? 'W' :
> -				    (__entry->access_type == HV_INTERCEPT_ACCESS_READ ? 'X' : '?')),
> +		    __entry->access_type,
>  		    __entry->handled
>  	    )
>  );
> 
> 
