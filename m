Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53CA4908D1;
	Thu, 15 Oct 2026 07:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792048452; cv=none; b=AQcAMNGwVZPcdkyPQqDZU20eg4lIiuKwq1/cBxNbgS/SPelKaqFR+Lk6qdqZgwO8vtOKIJGiSHUcDGorFzEv9eh72P+OSzcIag2i5JMLppcN/78n7EIIK50PbS3F8Y78J5AccYXYzEjChZY+udch0Ri3Sk8LhDtpR7E0g06VuEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792048452; c=relaxed/simple;
	bh=fKH+1Bp6XRsNMG9dc5HGKDnhLMD62quetW8NrrNn2as=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iVnFYlq5VFawWhXhN49cdK9lI2A7aY421SVuQXw/RKELRNqZQFHcShLY1igLt2v7XESrwdN0TZXtprxe68ZdDN1R6b5UEnXSrvH4SpcJaT9Rg27WQv8vwRe1FpsDpBEn8VO0UPdiTerUS/vG364Ea6mSIvpfVm5/kqMyTa21KGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVE4nzPP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVE4nzPP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA9361F000C4;
	Thu, 15 Oct 2026 07:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792048444;
	bh=D6x1fISs5AcZrukLtgufyChM/sdinLD8YEymSWdlEE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fVE4nzPP9Vtov/ytYPqt0cHJfNfD8lKMyGICTx3wbyINNRF9jxrQTxMwQISadr92d
	 QIZv0L5io2h9RiLSfvSVBjcQ8LuhXDiYHGjBcQ8guJ3nqewj6Q5kzFvkeccNppJOCI
	 V2uc+TDwWf9T3KRyAdZBV9LrZy490BxHfBzU6CHSbQKdGos1Ar4RFcHT5t2EV3AuDM
	 4f4bJZXoZq+doDOLTBKeU3iUW6ORKAxheW6mfX14M2zQSA50MgEhYFMC6QN6HwE42Y
	 NvPShiI20dJ3jW39IuuTowwhQqQiIqvgdDZIg73vcd5WpVDlaKpw/ek0vDcbMbR9RY
	 c2metI3VT5m0w==
Date: Thu, 15 Oct 2026 00:14:02 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Cc: Emerson Busson <emersonbusson@gmail.com>, mhklinux@outlook.com,
	kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/14] hv: vmbus: make rings and host-visible buffers
 survive buddy fragmentation
Message-ID: <20261015071402.GA936897@liuwe-devbox-debian-v2.local>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
 <28fe612a-e91b-4825-bb8c-f34c893c2dec@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28fe612a-e91b-4825-bb8c-f34c893c2dec@linux.microsoft.com>

On Thu, Oct 08, 2026 at 09:55:27AM -0700, Easwar Hariharan wrote:
> On 10/7/2026 12:07, Emerson Busson wrote:
> > This series moves VMBus ring backing to the chunk allocator and keeps the
> > allocation, GPADL ownership, and mapping references together. It preserves
> > the exported four-argument interfaces while allowing the private allocation
> > paths to carry ownership and sharing policy.
> > 
> > A review of the original vzalloc fallback noted that CCA and TDX guests
> > without a paravisor need direct-map page transitions. This revision uses
> > contiguous chunks for buffers that must be host-shared, transitions each
> > page through page_address(), and combines the chunks with vmap(). Ordinary
> > guest-private buffers retain vzalloc-style allocation.
> > 
> 
> Can you provide a link to the v1 of this changeset and this "original vzalloc
> fallback" review? And a changelog and motivation for this series?

The title is

[PATCH 0/2] hv: vmbus: prevent control-plane starvation and order-7 ring deadlocks under memory pressure

Wei
