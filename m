Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D413876C0;
	Wed,  4 Feb 2026 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770187838; cv=none; b=Ub0XiIgrKGOcvY9dVwNVoJbHYQtPfUNJPzZM9ZoACcVTGZlHads7Lf2ifsgOqeS41IIL4LYm+IvGCLefLN5inSC1dzZcWNjtcLRSHeGbs1xC3BrjQJpJSVYphSwJONUsGNA5hQeNsS2JDLTmizYzN7H+Sr2TympMbT6k60Ar8+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770187838; c=relaxed/simple;
	bh=dfWZb3yLNx512S5YomAyNbaY0lqcpeTSp9pWd5Ifgq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EimUnr1REysoTZwvS7KQpW7H+xh5crzhKmi+jBE5e7FaEardZGVX6aZYRFqPPQAyENs3pjablnh41KS9ykFmm3hK9WfEUY6zcfP5eWNg4bUcEqmY0Ic7oYJLZv/149dZwSZm/1QTCf061nrk/0WZEBedD6kJKAmFkdunpwnjQ44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EIKm6eGN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EIKm6eGN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2F7EC4CEF7;
	Wed,  4 Feb 2026 06:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770187837;
	bh=dfWZb3yLNx512S5YomAyNbaY0lqcpeTSp9pWd5Ifgq8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EIKm6eGN4qWevUx/GAMXCZJWi2/7jaIKRnrjZcB+KLpopandjqYqAbuBH/pzUDSDo
	 Gyz6vl/jl6MBITdqiIc3h6GXM0Jm3ZSvDe96SvxWOQcReuMSQZRxrOFzy392/6H2aB
	 oJijQ5FsSgAF63+Ol2VcE4MNYt0I6esoS2F4wmdgKQCCmvI7KO6sSndutXvmxaEt0e
	 F0KuTCXx60bprDvMPGm1tUCfFpZp36sbUd4zJpWPudt4OJc4+WZb4XdOj+4lbgi+dT
	 5c7lSn7T1AYQn+jbVUV4wZJly/nB7EOVo6dp/wOs+NNpXsYwaKKlE2AzOamBZAaRfC
	 3WQr3/Ad1gMjA==
Date: Wed, 4 Feb 2026 06:50:36 +0000
From: Wei Liu <wei.liu@kernel.org>
To: mhklinux@outlook.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] x86/hyperv: Update comment in hyperv_cleanup()
Message-ID: <20260204065036.GL79272@liuwe-devbox-debian-v2.local>
References: <20260202164839.1691-1-mhklinux@outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260202164839.1691-1-mhklinux@outlook.com>

On Mon, Feb 02, 2026 at 08:48:39AM -0800, mhkelley58@gmail.com wrote:
> From: Michael Kelley <mhklinux@outlook.com>
> 
> The comment in hyperv_cleanup() became out-of-date as a result of
> commit c8ed0812646e ("x86/hyperv: Use direct call to hypercall-page").
> 
> Update the comment. No code or functional change.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>

Applied to hyperv-next.
