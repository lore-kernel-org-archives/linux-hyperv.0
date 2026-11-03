Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674466;
	b=PsKVYEfY2cKhO8IFo0iLICbSQUWLGCkab39W4nTimQRu+pWiRTlimBEflkD7v+YRHbMU
	 ZVMHmFeMEKa3OPPqDyk1C43mcWyAIVkGfG50hiAk2mFlTn+5pzZNMP/pN2M1dDYHxS6AC
	 lOsAOHJ7UWIBlQCQj1x7MP4fEOSPbjzs2ugu7wRXe0QLkabpdpefbXUm46wfWF3QMO+8E
	 hARnBZRo2OGATtBZaKGRnADHOZDipXwW+PnYi9UpRkk3+/eyhKrzYHG5V055F4uXoCjF/
	 Y9g8v1K+itH3EeGZiglmgE632hn6EvC9PuuP1PJqQ5p9S56v52kMCqVTaSM7izWagPw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674466;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:Content-Language:To:Cc:References:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=3mEZ6r4DuMod8ALHHWcJ1ipvuJ0fm+r6+wtOXPIOWo0=;
	b=Aiv6eNFdZhMeWXlnH9Lq0T+K7U8ciY4DC3Uz1Ha2ikFhnu9DaQpsq5zy1t7Xy2D2Y4E2
	 FPjgI7K5X32MEP8Nft9PE421kK14NLG27w1keefGtunbyJF+iCOQa2cwUnvSTARKC+jgz
	 4FRWg7v/opiIeGExFwUIiPm5D5siZBPYDr2MvOfwN4ZBNrgvqpplGlWyVFHk+AtUNOLvM
	 rR6u/FGxXsal9TgThmm/1OvtmNR1W6Rjhi3KpXJKeVkMfTPkxZsM3hTIixJI7D8Myxly1
	 aoJC9R4DqIOD6IVjUTekWClf3kiVzu4fpHmkW5M4boCgOcOFpV5rHkSPJYJHu4jfFNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Q+COE4FG;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FB45606A327;
	Tue,  3 Nov 2026 02:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FB45606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Q+COE4FG
Received: from [192.168.0.88] (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3AA1D20B7166;
	Mon,  2 Nov 2026 18:54:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3AA1D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793674450;
	bh=3mEZ6r4DuMod8ALHHWcJ1ipvuJ0fm+r6+wtOXPIOWo0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q+COE4FGgrozfHlhXCSRaB6pt7mVWZ539RWqSvJUtwfyY/urNsPtrf9lML94V40Pl
	 gERI3+rDya5psPYeLTvH31Fq/FdeMQZ+rCNjYTgYPHOKfcNYS+QHRP7vepQkQMcOkP
	 cuLo5v+uNONKutTactMRslPs7YGE7un6lif/oEug=
Message-ID: <69d99439-8d60-79c6-36a8-662210bb0dc4@linux.microsoft.com>
Date: Mon, 2 Nov 2026 18:54:23 -0800
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Post: <mailto:linux-hyperv@vger.kernel.org>
List-Help: <mailto:linux-hyperv+help@vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-hyperv+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH V2 4/4] x86/hyperv: Implement root partition IOMMU kernel
 only driver
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, linux-arch@vger.kernel.org,
 jacob.pan@linux.microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, arnd@arndb.de
References: <20260929223622.778617-1-mrathor@linux.microsoft.com>
 <20260929223622.778617-5-mrathor@linux.microsoft.com>
 <c01d422c-5277-010b-ff14-dfe5fec6a7bb@linux.microsoft.com>
 <20261021232000.GW3008132@nvidia.com>
From: Mukesh R <mrathor@linux.microsoft.com>
In-Reply-To: <20261021232000.GW3008132@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/21/26 16:20, Jason Gunthorpe wrote:
> On Wed, Oct 21, 2026 at 02:36:53PM -0700, Mukesh R wrote:
>> Hi Jason and Joerg,
>>
>> I am going to rebase due to all the patches that went it and crank
>> out a new version. Do you have any more comments/concerns, I think I have
>> addressed all your concerns. Pl lmk.
> 
> You should wait two or three weeks till rc1 comes out at least
> 
> Jason

Done. Please check V3:

https://lore.kernel.org/linux-hyperv/20261103025150.3192119-1-mrathor@linux.microsoft.com/T/#t

Thanks,
-Mukesh
