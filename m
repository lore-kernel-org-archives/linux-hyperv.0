Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E122F1B6D08;
	Wed,  4 Feb 2026 00:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770164740; cv=none; b=Z0SqT4kF4Hy2pWvQ0UvsEKYGVC/25auAz1aU0hn25GIWUt4bjsGnLfIgrmqWAuxoPg/h+TRno1o0zuYcvhBowbu53AFgwfAL4P7kjD7Q58LIkMeB8X6xUoYirJCYlReSqyj8/SenyJI7E0uLLG0AuwfndPGqPDEXF5ZnWPutpS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770164740; c=relaxed/simple;
	bh=93V1tnNO48R4YSziO2OBRkztT4fceSeQzmD+wKHwnQY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=jMCGuvWQkNT8WPPmQh3BKONONP2b2Z5CCblrwLiLIlxZDFYGebzJOomxxh/tM8PGCzVcw98ztOXD11dwjbidPOns4d0gvJ/tM1uxq/cuJYfIsRmW09yBXpjZYtOEIYqXUV2faXoEyRm2Ce9brWjx1G6Wz3k0cQvSUq+MrE84Mkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=UdDFW5QM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="UdDFW5QM"
Received: from [192.168.201.246] (unknown [4.194.122.170])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6391620B7168;
	Tue,  3 Feb 2026 16:25:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6391620B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770164738;
	bh=wbP0hZGgUwNxM5s9scfeDr4cV2A7ZyLoJzh09YzAmWA=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=UdDFW5QMyCuMMxO69GRurf/jt+gDeJvAdw6yvbVmWNHt2pQ8/SVSKqaHWfHlGdfmu
	 bBcElZiFnS3EuX7QK29Jzxc90C2akVPbkU3f2PWE3oo6gTvtDpr1h9B7sSVse6a+zJ
	 jNklQuN5A8SwAdmnMsK20eIhFQMT1buhsLoMNNqQ=
Message-ID: <ae52e158-d138-4344-ab0c-74b2fae56ddb@linux.microsoft.com>
Date: Tue, 3 Feb 2026 16:25:34 -0800
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 easwar.hariharan@linux.microsoft.com, wei.liu@kernel.org
Subject: Re: [PATCH v0] x86/hyperv: Move hv crash init after hypercall pg
 setup
To: Mukesh R <mrathor@linux.microsoft.com>
References: <20260203224121.26711-1-mrathor@linux.microsoft.com>
From: Easwar Hariharan <easwar.hariharan@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20260203224121.26711-1-mrathor@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/3/2026 2:41 PM, Mukesh R wrote:
> Fix a regression where hv_root_crash_init() fails a hypercall because
> the hypercall page is not fully setup. The regression is caused by
> following commit:
> 
> commit c8ed0812646e ("x86/hyperv: Use direct call to hypercall-page")
> 

Is that the right commit? The named commit was merged in v6.18-rc1 and
hv_root_crash_init() was only merged in v6.19-rc1...

Thanks,
Easwar (he/him)
