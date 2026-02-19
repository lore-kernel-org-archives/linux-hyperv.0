Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B473D2F1FFE;
	Thu, 19 Feb 2026 06:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771483487; cv=none; b=oxI0GNYLaSiWpvHTh6J2uQMKQccEo6o4JPke8td8LpGMF5yFCU7Pzkwj5K2qcACWQoZcGvSQXDeS3UTEyuZ1+0kJ5kSiNiHyMUbL/1um05pxzPirzZ9VSSeX4BdB7691ZHHeZTq0N7opq744tJ/8vwx1Lw/bY8nij4ZNsJl9CHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771483487; c=relaxed/simple;
	bh=U72yBetEEj40dfTGYm8YGvs7OafQR8KVVoM9K+TxDUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovyRr/Q+QqKDl/me7DjJJtqfz0d76T4knaRktg2a+7Y1uB2DNqPAJjv/Ye+LWjD7ktO9oFMVSU/ZMXDFOOwzJ+Jq3ZZsJw1ZIiWNX7Vo7tZje5tId4ZO3FgTj1wI4vBJW2PIadIUf4w1fWDArorbNDNr3Nln+pAg3noQsrgqa5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JNlEPjhP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNlEPjhP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF4DC4CEF7;
	Thu, 19 Feb 2026 06:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771483487;
	bh=U72yBetEEj40dfTGYm8YGvs7OafQR8KVVoM9K+TxDUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JNlEPjhPITdBUb0IaWxmCrRc0u85TAdZosv2/KL4OJtFTagcZ3DB92lzo7wOVla9W
	 qo+vJMYGDw4oBequMtIkWwks5vxn97AjiDMo+niLmiok/UBmySajgqrgMQ70n6MKD3
	 bNakhVfVBbvEbjwjK31YKqvfwp/Rn4fXOfChpIyuFZk62fDe+CKMKMtcqe62o/80i2
	 ajrxW2vXUJikjl5KDAjERTTCtKX50v9V5XP39f7coUdeTCARjYUJhvY+soceWg/jSP
	 jIfkJQo56pDJuDRzZv7rWzNTJp48Lh4NvXkZsxvoZafHLZqFVZnoCvc/Bp2FJ9nInj
	 ygZYZHiKxCjFQ==
Date: Thu, 19 Feb 2026 06:44:45 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Anirudh Rayabharam <anirudh@anirudhrb.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] mshv: Handle insufficient root memory hypervisor
 statuses
Message-ID: <20260219064445.GP2236050@liuwe-devbox-debian-v2.local>
References: <177031674698.186911.179832109354647364.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <177031694699.186911.12873334535011325477.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
 <aYWCmVxnO8R3vsc-@anirudh-surface.localdomain>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aYWCmVxnO8R3vsc-@anirudh-surface.localdomain>

On Fri, Feb 06, 2026 at 05:56:41AM +0000, Anirudh Rayabharam wrote:
> On Thu, Feb 05, 2026 at 06:42:27PM +0000, Stanislav Kinsburskii wrote:
> > When creating guest partition objects, the hypervisor may fail to
> > allocate root partition pages and return an insufficient memory status.
> > In this case, deposit memory using the root partition ID instead.
> > 
> > Note: This error should never occur in a guest of L1VH partition context.
> 
> I think you should rephrse this to:
> 
> "... should never occur in an L1VH partition"
> 
> because none of the errors in this patch series occur inside a guest. They
> either occur in L1VH or root or both.

I have dropped this note from the commit message. If anything, this
should be in the code so that it can be kept up to date.

Wei
