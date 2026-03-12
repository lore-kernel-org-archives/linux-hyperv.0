Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287333128D7;
	Thu, 12 Mar 2026 04:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773290704; cv=none; b=qd/GfybZTO/mp3QmfHGp/9/ZJ/Yxbv7xws4x/EUmRHu3rlQmv9V1BNhkYcRbW+GixnSAvglxxNRIa9ohVJKVkiNEe8AMo/zl/FuHxcZ5kKwQBEAdYIv4Dg1loMtiN3/H02px+3qiwqcs56otNHmUY/LVeMHPhYdFdUEd7BqHOjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773290704; c=relaxed/simple;
	bh=uo4SSl8fAgSbLnKxoM8NkTc5BpnLftMtAAjRH39TfzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iA1fbyvp/ViLHhyPc7Z6OeC/Qy3f3ZFNGpRBOosGT9rIBV1jqEwPRYJP84GUhSm+Phx0CuzU1xrF1sIJgwXlYmcjHd7WsqGbsTH33akJJl47mHyArU82HcK/sfkfcz0KiW6cXiEdUqmCHcah3/syBVFvTjnzSFT35URfZXEKqkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hzcPKQYU; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hzcPKQYU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9823AC4CEF7;
	Thu, 12 Mar 2026 04:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773290703;
	bh=uo4SSl8fAgSbLnKxoM8NkTc5BpnLftMtAAjRH39TfzE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hzcPKQYUgP9E659xiVXIxYlYZkJNwUfbGPurGs4iSjTFtyKUTfhxD2Zbjk47hWhIE
	 mXbav4xqdv/O7tqOKyOluoXC7akYV+XVYRjQCA2Y6L+bg/4rRK3sP95HC/lGNk6OWc
	 HTwOFLoR/Jx6UMt8CrcSpCDbjMZp9Hn9wp6qbbW4pxEOIyLkai/fPZ+59SmjaarpDp
	 WMS38KJuFZsb/VJ0SqjPb3/4FUIAqgeQE4UuNzxSG9/5DxwPiRS7spmDlZPD136uxB
	 rEobjQS9Q1y07ii4zrq7xuc5f6RV/W+CaC3DsNCQTrqF1cLbj4w0NyhqFOpCO+C+Cw
	 rt8TxMIpyidog==
Date: Thu, 12 Mar 2026 04:45:02 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mshv: Introduce tracing support
Message-ID: <20260312044502.GB3771304@liuwe-devbox-debian-v2.local>
References: <177238674748.34040.4319844213401541666.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <177238674748.34040.4319844213401541666.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>

On Sun, Mar 01, 2026 at 05:39:10PM +0000, Stanislav Kinsburskii wrote:
> Introduces various trace events and use them in the corresponding places
> in the driver.
> 
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>

Applied to hyperv-next.
