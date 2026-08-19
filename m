Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EB753E0B;
	Wed, 19 Aug 2026 00:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787098413; cv=none; b=WMCzaFD43dT/yg2d8lkd5pjv8LfjrzOBUnEni7nXhTSuEpaSOHurTVzMYw7u9fl7pSEzmWw4egoxvWwQSL1uHE6BJuYXCl+N/8kEAnyWiiK6vCkhq/AHj3qyJWgZXeKqYRfSPnAQDO71hRHzejYKeL8rcSWVtrddKi2OZLq2AIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787098413; c=relaxed/simple;
	bh=8iDklElsJ6xw7hjQXnB+OE3JR6ZvoL3btmETnJlm8pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aTE4KzaE1UlJrZDlUZd5GLW2UYxg4pc2cyVFBA539A/vixTfWQte7EhEGYNcoeMkNkHctgJ+HAZVhZk+Nr1gKMS/U7ZAzxkN9kq9yvIiM8yBTCNqj2tVvdgxELco6+Gdk77atAbtwa2b66nhyabmwoCz7DSWVqyzDFag4p/xBDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YCf9rXVN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YCf9rXVN"
Received: from [100.75.32.23] (unknown [40.78.13.173])
	by linux.microsoft.com (Postfix) with ESMTPSA id E691620B7168;
	Tue, 18 Aug 2026 17:13:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E691620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1787098383;
	bh=kGK8AZVrxJbzYPYu4KuWQYugyNrpdc8p1cPWMIJfr8c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YCf9rXVNMsq36q1Oigz0BXR+CmAxOJ1vDRt/9HKRwlx5d8JHh3q9QuU7Ctogadbgw
	 3MwYurMfz15mGKdp7IYtfCGhp10aYHHTKPIXXrpSdwFmr8UE/dE5WpuN+jTcYH/ih0
	 r1aj0M3PvDlfrTgRHakhp0vtoJ7cEMukui+J+ORI=
Message-ID: <912a5911-5b38-a14f-132f-a2d1d7c8f154@linux.microsoft.com>
Date: Tue, 18 Aug 2026 17:13:29 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v5 7/9] x86/hyperv: Implement Hyper-V virtual IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: hpa@zytor.com, robin.murphy@arm.com, robh@kernel.org, wei.liu@kernel.org,
 mhklinux@outlook.com, muislam@microsoft.com, namjain@linux.microsoft.com,
 magnuskulke@linux.microsoft.com, anbelski@linux.microsoft.com,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arch@vger.kernel.org, kys@microsoft.com, haiyangz@microsoft.com,
 decui@microsoft.com, longli@microsoft.com, tglx@kernel.org,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
 joro@8bytes.org, will@kernel.org, lpieralisi@kernel.org,
 kwilczynski@kernel.org, bhelgaas@google.com, arnd@arndb.de,
 jacob.pan@linux.microsoft.com
References: <20260731223427.2554388-1-mrathor@linux.microsoft.com>
 <20260731223427.2554388-8-mrathor@linux.microsoft.com>
 <20260805124838.GP27883@nvidia.com>
 <269d79fa-08ab-55ff-77c7-fb11fa2005d9@linux.microsoft.com>
 <20260818234840.GA134244@nvidia.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20260818234840.GA134244@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/18/26 16:48, Jason Gunthorpe wrote:
> On Tue, Aug 18, 2026 at 04:39:32PM -0700, Mukesh R wrote:
> 
>> Thanks for the review. I know there is another set of patches for pvIOMMU
>> ongoing (both came from the same source) and you are probably repeating
>> things, and I appreciate your patience. I'll also try to look for your
>> comments in that patch series going forward.
> 
> Those patches look pretty good so you should try to copy their stuff
> :)
> 
> They ended up never calling detach, I hope you can do that too. Just

Unfortunately, my case is a bit different due to the "direct attach"
feature for guest VMs. When a device moves from say a paging domain to be
directly attached to a VM, today, it must first be detached. But since
that just moves to identity, I am discussing with hyp team if detach
is really required, and if we can get rid of it via just attaching to
identity/blocked first before doing the direct attach. Hopefully, it
can be done even if changes are needed in the hypervisor.

Thanks again,
-Mukesh

> always have a blocking or identity domain and just use it everywhere.
> 
> Since you can't predict what translation detach gives it should not
> be set on a device. release could be the only exception and only if
> you reall have to.
> 
> Jason

