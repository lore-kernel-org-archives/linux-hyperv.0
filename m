Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3284543935F;
	Wed, 22 Jul 2026 22:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758025; cv=none; b=T7pmAHGBM9rlnf/37N5Imfk53vHkZlB6WR3gukm9UhsG9Nl8mQylyTm1xNfNGPQlZNdImTSqsyGWUkInybmDKW346TrhtazUvRveRQDep2AfdXiUrrk8QivgRrvsO85Azl66Xmu5/BssZ/7L8KkdR5FsIlLWs43OKlSFKNZVSJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758025; c=relaxed/simple;
	bh=9PWPrkLvv0N5dINZDtdWgVB/dRAI2m/5G6FpTwZskiY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sF0thpc1MxfcfeY8fpNBUWYMhl9uJXmBxWpYGe4tX5lpWlr7lhcSZTxYc58f7freqRw+e5IejUFfBv04XsTwnUQh/8KF3f8fCMeFF/AchK270R+yXnau5YtZHD7E2qRJRLFTlwvZDffs9uxHM6Er7crB6f+nAnbTvKDkY2vJNoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHZkDOaU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHZkDOaU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1CF91F000E9;
	Wed, 22 Jul 2026 22:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758022;
	bh=bARl/bTrEz8ADR0uIQZAHZzlAmr7YvZiT9cRuBSMK0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YHZkDOaUgoUGr06fJQhPzQFmTeL1erXX/N15t7XQo5aXfdSjb65KsTgDF1cG45c2i
	 ACa+wLBXrPG+nn/jb9KILXKFrVwyqzwp+0h2jq5BL3hFpGw5EUmBxoGBt8Q2Vsdyyh
	 qGy5mObwUf/t743qRlWqeiOne7Y5qIqsWIJjCc7jZ2afJLl2POKUZjtNWsgfSuAzX3
	 Wq8k2/mJpyOJXYxaYsOsqiAfgush77NFFbgOgHnwbD4pD+Ezgq3qhFGDQB+xzvNKGO
	 QNvh0PoU98mt7ZbN1JhVQcWRpMAd0Xn3dc2qyJNRMipUXDqEZkKgzq2U98s3vkPhXt
	 vyaH2UTBWhLAw==
Date: Wed, 22 Jul 2026 15:07:01 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv_vtl: clear hypercall output before copyout
Message-ID: <20260722220701.GD2020652@liuwe-devbox-debian-v2.local>
References: <20260624172157.2790-1-alhouseenyousef@gmail.com>
 <20260625181314.1399-1-alhouseenyousef@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260625181314.1399-1-alhouseenyousef@gmail.com>

On Thu, Jun 25, 2026 at 08:13:14PM +0200, Yousef Alhouseen wrote:
> mshv_vtl_hvcall_call() copies output_size bytes to userspace.
> 
> The output page is freshly allocated. Userspace chooses the copyout length.
> 
> If the hypercall writes less, the tail can contain stale page data.
> 
> Clear the copied range before issuing the hypercall.
> 
> Also check both bounce page allocations before either page is used.
> 
> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>

Applied. Thanks.
