Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A28A3ABD82;
	Thu,  8 Oct 2026 16:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791478530; cv=none; b=uj/82SB3JRIzAcYTVnT2/U9Nho+oYs7JvNzxY7zs8qjrl2EIKJ+JhGFsh2PIqwYCTZUxWu8soC8lXjKtPtcaxt2dmKuPTvyzxt2IJy+o3jc2yGHarLAj88FkZveN7xIyTuHwyr/Ftmp5/QP6eteEgqNMeEa03D/gwEllVi995DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791478530; c=relaxed/simple;
	bh=M+C7oa0qlOXJuKMG7trryJofZicerOzbBwHwVAwaveU=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=O5XUe8B8ouEu1G+JBdb4OaLfyHEjxdNtS2kLHBnZRiMOc+wYxAr9ZSGTB/yRq8NewakQ1Nd1I0jzIlbvwzb1lUlARp3okAYoTKyE3x+yKugaoFoc7VOlMOrQgHyaDXD4KhGYd3SP6ObGwxH2mz6/qAbPyjPlIDAitUHltInySxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ndVOvjF0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ndVOvjF0"
Received: from [100.64.161.192] (unknown [52.148.140.42])
	by linux.microsoft.com (Postfix) with ESMTPSA id 69E0C20B7166;
	Thu,  8 Oct 2026 09:54:31 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 69E0C20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791478471;
	bh=wQpKVuFoBgYqlY1J3u33QmU+YvSK+kPYfJmYVLlAMbE=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=ndVOvjF0v5TjpIIKUCxIa7aFyX0OMDq+YZ5w3ISFZAd14VRUi/6WhSqfZS6WB8JH9
	 6zeboYeJJ6Hs+Ws8K54eL33IYMLRT+JW7P8DcUuseXIe7htN07hEPxMwD8ct8DJYVT
	 yTJTI9wkW7Sa/LsTqC18qAXPT0ajckF/vgw/+A8E=
Message-ID: <28fe612a-e91b-4825-bb8c-f34c893c2dec@linux.microsoft.com>
Date: Thu, 8 Oct 2026 09:55:27 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: mhklinux@outlook.com, easwar.hariharan@linux.microsoft.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 0/14] hv: vmbus: make rings and host-visible buffers
 survive buddy fragmentation
To: Emerson Busson <emersonbusson@gmail.com>
References: <20261007190752.336426-1-emersonbusson@gmail.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261007190752.336426-1-emersonbusson@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/7/2026 12:07, Emerson Busson wrote:
> This series moves VMBus ring backing to the chunk allocator and keeps the
> allocation, GPADL ownership, and mapping references together. It preserves
> the exported four-argument interfaces while allowing the private allocation
> paths to carry ownership and sharing policy.
> 
> A review of the original vzalloc fallback noted that CCA and TDX guests
> without a paravisor need direct-map page transitions. This revision uses
> contiguous chunks for buffers that must be host-shared, transitions each
> page through page_address(), and combines the chunks with vmap(). Ordinary
> guest-private buffers retain vzalloc-style allocation.
> 

Can you provide a link to the v1 of this changeset and this "original vzalloc
fallback" review? And a changelog and motivation for this series?

<snip>

Thanks,
Easwar (he/him)
