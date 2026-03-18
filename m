Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C31D86329;
	Wed, 18 Mar 2026 04:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773807812; cv=none; b=qP6ai/w8hAq5m/rV2gf6HXWLZeOaaNPeom6kAq77G6E1QdtLVS4uvwaIK3zMLUoLFjxfRoPy4TJ3uYR/fTbuxCSl1U6+QrFh7q36dHU2LRolevzLgmNct3EpCdNuchTSt0kyBgFni5c7nAqys2Mq/ESGZCjCpErcu8153vX8+IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773807812; c=relaxed/simple;
	bh=9cUipr/zeEkTHohkWl1q+71lI/8YrOGLEVd7bAETmjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K/37fMqlG9bK6nJqzDafQhAkqHQbUH/MZY+XusqJ07huuFsiMUVOCQTmVsVSArTCPOk/bEboNmF+cs6JLSnjdDEOpFNf9OKv0LiU6kYWXMNOpMH0cB2D9PH4BH6O0NY3RR7cjXJmJe+XCQjjA8AshOPXb2kNR22QP8sYsf0e1o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Q0D96+mY; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Q0D96+mY"
Received: from [100.79.128.244] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0F74A20B710C;
	Tue, 17 Mar 2026 21:23:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F74A20B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1773807810;
	bh=RIlEsLdaVR+40flaYcqMAVD3R9hzK0WAVAtp83OthA8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Q0D96+mYZKhqvtohnIYX9Y0wSlgpN8qU1rA60SHesDeVTj+lbqezoEYn259Go3cBt
	 tb2emd1Se7lI85zK0MIxEXzim0+tteQa/7P9ao/ynPs8My+J4WELDxhQR4CI4Nhd+i
	 8OvFhet4gQExD7pKSmVle52vjr2liCLVPCauJW7I=
Message-ID: <a8f856a0-49a8-4041-9036-4e9ade79532b@linux.microsoft.com>
Date: Wed, 18 Mar 2026 09:53:20 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] Drivers: hv: Add ARM64 support in mshv_vtl
To: Michael Kelley <mhklinux@outlook.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "x86@kernel.org" <x86@kernel.org>, "H . Peter Anvin" <hpa@zytor.com>,
 Arnd Bergmann <arnd@arndb.de>, Paul Walmsley <pjw@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Marc Zyngier <maz@kernel.org>, Timothy Hayes <timothy.hayes@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 mrigendrachaubey <mrigendra.chaubey@gmail.com>,
 "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
References: <20260316121241.910764-1-namjain@linux.microsoft.com>
 <SN6PR02MB4157DFC7B7CE94500C89664BD441A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <SN6PR02MB4157DFC7B7CE94500C89664BD441A@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/18/2026 3:33 AM, Michael Kelley wrote:
> From: Naman Jain <namjain@linux.microsoft.com> Sent: Monday, March 16, 2026 5:13 AM
>>
>> The series intends to add support for ARM64 to mshv_vtl driver.
>> For this, common Hyper-V code is refactored, necessary support is added,
>> mshv_vtl_main.c is refactored and then finally support is added in
>> Kconfig.
>>
>> Based on commit 1f318b96cc84 ("Linux 7.0-rc3")
> 
> There's now an online LLM-based tool that is automatically reviewing
> kernel patches. For this patch set, the results are here:
> 
> https://sashiko.dev/#/patchset/20260316121241.910764-1-namjain%40linux.microsoft.com
> 
> It has flagged several things that are worth checking, but I haven't
> reviewed them to see if they are actually valid.
> 
> FWIW, the announcement about sashiko.dev is here:
> 
> https://lore.kernel.org/lkml/7ia4o6kmpj5s.fsf@castle.c.googlers.com/
> 
> Michael


Thanks for sharing Michael,
I'll check it out and do the needful.

Regards,
Naman

