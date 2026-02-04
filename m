Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6865923643F
	for <linux-hyperv@vger.kernel.org>; Wed,  4 Feb 2026 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185182; cv=none; b=LIgq4w6t732Q9OoiaDpG7wyx6LA5OT9F1TAueHmTjfyP6Sgjfo5TvVWcgjm/hixoCedmfSnW93MLIfPcYcpjBvkkWlGtfAdb34z24H2JBziC9DgrxZEx7GJi0JDhpvmIFiJXfWvvG5Kvr6VzMYu5jlCP9iFRDwoBBn0FIMAKtMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185182; c=relaxed/simple;
	bh=zUJk98wV5q9ll57HCJuP+InzWHU3cNBZdOZcnyUNOl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgTu5kIBTwZsuVQN7WYN8Z8nrjt7OGV5/T4jXQ/q1Nj79YetZFH3fHdR0/9bOwvfNFAZbdapmyvsZNleK0pfCDR1IwuxLIKUhxTMGA0at4pbXMzWzIeiJQ12En5+trEtFpsR8NjFeRLRxzThatmmu1cE5C/0tzMpETp4wOKjCKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=akpLt5vl; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="akpLt5vl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5589C4CEF7;
	Wed,  4 Feb 2026 06:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770185182;
	bh=zUJk98wV5q9ll57HCJuP+InzWHU3cNBZdOZcnyUNOl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=akpLt5vlTZXkFqq8m6C+N9k3AZdPAh0g1/BPPndteVkrAU/E+pugK1eliUJlsb1y4
	 l/Og0gwLx2ngHkSuOKcNkDAX2AuRbcKU8S0EiilnwMSJTwAJgpXX7C2wU/q6sRV3ig
	 obsoT7QoP99JCMm17NP2sRwgnNbNtfgOpWSCnWM3NGUFY83+T2RD4cUbjDUhuGewg4
	 0B5BO1o2hO7mFnd7IwPoJKuPl0B6OMM0H1wLcj29Jb0njFQRNsB0eUbCUeD3ZzWqQL
	 XuS27dzBKn8y5EioPxQUd/j/MlRD+I58B135hTWQbR0Mgas+35+98PMGiAXwNg0H3H
	 JSWARNepgX4PQ==
Date: Wed, 4 Feb 2026 06:06:20 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Mukesh Rathor <mrathor@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, wei.liu@kernel.org,
	nunodasneves@linux.microsoft.com
Subject: Re: [PATCH v2] mshv: make certain field names descriptive in a
 header struct
Message-ID: <20260204060620.GB79272@liuwe-devbox-debian-v2.local>
References: <20260116224904.2532807-1-mrathor@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260116224904.2532807-1-mrathor@linux.microsoft.com>

On Fri, Jan 16, 2026 at 02:49:04PM -0800, Mukesh Rathor wrote:
> When struct fields use very common names like "pages" or "type", it makes
> it difficult to find uses of these fields with tools like grep, cscope,
> etc when the struct is in a header file included in many places. Add the
> prefix mreg_ to some fields in struct mshv_mem_region to make it easier
> to find them.
> 
> There is no functional change.
> 
> Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>

I generally don't mind such changes, but this patch doesn't apply
anymore. Please rebase to the latest hyperv-next.

Wei
