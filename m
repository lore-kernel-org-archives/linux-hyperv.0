Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993976;
	b=xgE90QHG+MpqmmNbDm7hlKm0K5EQ/WD3G2x0CsD6jIOg0fpGGewe+uvydtbMszHQybel
	 2pXK47rHr2T9gh1Yl8MqnwrW7KMzDGIwKlwDAih0RZYtwLOWvqHMCW0ywqBhbM51p0Ya3
	 D4OQzKrzyZldysAa/h35tgAzEdBP2ofYN722IeGLVychcSpJFvYocxQPvAo9TKevmpuaY
	 9WLA+XvAlyM5TpZYsiQqEkAfl/ACAOJpW+Uc1u0EPywCKlRJsdYnzgjgJwa3X5vqkeXUB
	 +D0bDLJB0gV7ajzIIswpxAooibBiMlBS2OIXWcXf7qFrBIjnic8x8whOcjEsNij7q5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993976;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Cc:Subject:To:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Spam-Status:X-Spam-Checker-Version;
	bh=p1W3I/d1u/9FO67gv60y0eLOYdwW97n30fOKHH9B9OQ=;
	b=2z7UeKNMwiUPtZL7UVWOne2n5ZIwEDaeeo8Z/6/vqN2CkQM5Ty+y5abrqS6f68yG+A3F
	 b25/JoOLlmvSaqvs+Jtv3ET2dMRBG1+ZiAJ+yNrtVIQJ98j3LpSfaMQWqFuVcofYK5xdA
	 zYvy/I3FAilrE1w9iKM9VMlAkjjBM/EkirJGGuhUytQJje0dp8y/UgOjTFymbNFplDkKP
	 oBI1CwnokNIlEHUFa8tF29kwOkGEWJQQieQBrH8gjAD9AF6L2t/8PqETGnxUKmtFdd6VM
	 ZMSb9XF9iAohaitarkbPIH73WYpx9CFWv+KbglSVTTHYpB0jlZLaHcWTyB5LgGe/enw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=svM8MMw+;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C92606A326;
	Fri,  6 Nov 2026 19:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 98C92606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=svM8MMw+
Received: from [100.64.128.135] (unknown [20.29.225.195])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14DE820B7167;
	Fri,  6 Nov 2026 11:39:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14DE820B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793993974;
	bh=p1W3I/d1u/9FO67gv60y0eLOYdwW97n30fOKHH9B9OQ=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=svM8MMw+X6bM0aZ91HxoG4d5bHYSqBvUxohIv5uJLfKIMgoo42EmBWT1OQjVtZEDv
	 uj1+zbgiNQLrQNb0/ZbRhTnwcBpmo7SL1Axc5VyYAE6hwrU2zXuGYhYy20cSY01TfZ
	 hvb/Zfq53HWR3RSkPo8FnmbJH1QIiJjbBu1yQv6I=
Message-ID: <5cc647e4-b4e2-4d8c-b41a-831a66b4ce64@linux.microsoft.com>
Date: Fri, 6 Nov 2026 11:39:33 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, jgg@nvidia.com,
 jacob.pan@linux.microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
Subject: Re: [PATCH V4 2/5] PCI: hv: Export hv_build_devid_type_pci() and
 change return type
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20261105020106.3496339-1-mrathor@linux.microsoft.com>
 <20261105020106.3496339-3-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20261105020106.3496339-3-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/4/2026 18:01, Mukesh R wrote:
> On Hyper-V, most hypercalls related to device domain management like
> attach device to a device domain, or to map/unmap regions, interrupts,
> etc need a device ID as a parameter. So, make hv_build_devid_type_pci()
> public and change return type to u64 to enforce its size.
> 
> Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
> Reviewed-by: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> ---
>  arch/x86/hyperv/irqdomain.c     | 9 +++++----
>  arch/x86/include/asm/mshyperv.h | 6 ++++++
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
Reviewed-by: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
