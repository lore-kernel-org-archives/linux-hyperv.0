Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9E742A82;
	Tue, 27 Jan 2026 00:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769472772; cv=none; b=pAenKtThcjptuI+I1MOcKZSZu8cB7tfCSBbDfPEyumkdBIFio/IHfrdtEAI5ydMe+aP8I153MpcmBByFpLZMmMWcV+fcYbSo6bdP9DFIqfNjMjGKM8445UazFJqb/9Y9z/FYB0XTqqER6by71GIjqH8qZ1x2RoL2KToo5PuNp+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769472772; c=relaxed/simple;
	bh=zdmajJzDp/psdFRxl0ZcH62OrdSpFyzRjV6JfY4r7DI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=CMs7DtH0x0pz0hI7adB93bXD+RN4XoBpjElyMsM55sfaPA6nExxjyfMMN9nnacEzT9yU2Ux84v6l4mM+F+XJzJV6/YJNgFsN70BnNV8Yjz5Y2Ht3HecTKRs4M2BZeIruuhd5NMDuy0ZOGVcQfrWncc8LRNdul7QMC4gQonEApkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SoOUK2P6; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SoOUK2P6"
Received: from [100.65.200.230] (unknown [20.236.11.29])
	by linux.microsoft.com (Postfix) with ESMTPSA id 14E8820B7165;
	Mon, 26 Jan 2026 16:12:50 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 14E8820B7165
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769472770;
	bh=6smxruiRdaZfdeGOTbp2HZfZaukKEptCoPsgRHW3hec=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=SoOUK2P6Ewe9+u7DPzgBrLB2SsaZi4N7JAoDDZt5A5xqUNrNEBvYWQsZBH2i477VN
	 WDCWLOvTCQ+5TAB9EDb5NuVSA19gmXszEnnQX5d6p0gCXNblKMliNRtF0EhkNXY797
	 wKlWis/mBTI7VveHkmqdlS1Qhg3CCuoUTcZbftY4=
Message-ID: <ce54d00e-f252-48ac-8b0e-2992d1d4ef70@linux.microsoft.com>
Date: Mon, 26 Jan 2026 16:12:48 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] Add VMBus message connection ID support via
 DeviceTree
From: Hardik Garg <hargar@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, krzk+dt@kernel.org, robh@kernel.org,
 conor+dt@kernel.org, mhklinux@outlook.com
Cc: devicetree@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, ssengar@linux.microsoft.com,
 longli@microsoft.com, Naman Jain <namjain@linux.microsoft.com>,
 hargar@microsoft.com, jacob.pan@linux.microsoft.com
References: <58cb22cb-b0c8-4694-b9e4-971aa7f0f972@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <58cb22cb-b0c8-4694-b9e4-971aa7f0f972@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Just a gentle ping on this patch in case it got lost. I want to
check if anyone had a chance to look at it, or if there is
anything I should update or clarify.

I’ve also noticed a formatting issue in patch 2/2, which I
will address when sending a v6 along with any feedback.



Thanks,
Hardik

On 12/23/2025 3:05 PM, Hardik Garg wrote:
> This patch series adds support for reading the VMBus message
> connection ID from DeviceTree. The connection-id determines which
> hypervisor communication channel the guest should use to talk to
> the VMBus host.
>
> Changes in v5:
> - Updated subject line and commit description to clarify what
>   connection ID is and why DeviceTree support is required
> - Addressed reviewer feedback about zero handling and binding
>   constraints
> - Revised binding description to clarify version-based selection
>   instead of using "defaults" language
> - Fixed checkpatch warnings (indentation and alignment) 
