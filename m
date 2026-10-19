Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09055363C6F;
	Mon, 19 Oct 2026 05:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792386630; cv=none; b=PQI9ikIV/AlGnl/5tcCS/8+8Sk7AOLPSsebjzPgxzQfbPC9G1iFPpfCJzMY9XgB7hz+YSKzbTLgYdGncCkoO+RFAWj61CxW/yhZBVcBIms1JMutSTEblHAHnqCTCIDzyu7GbrGTW66RwZC27IchRnFIMYvsSoiOdDgCkUtISKSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792386630; c=relaxed/simple;
	bh=ZdBqok8rrBt2JcUhblYWiBRfSj38rVwAnuD3J5yeSMI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R+RdAlUyqQSNtZav8/gh91qfgqAVJlMAttyRQm+ATscbUyYgZWBkmxOtHHlfu8AhQ5g/Pndxy4tb6Lf7Pf2ajx41NrD0ZH+eSGCogGFaEDdi3mL2xpIKjoxPoOzQeOs/QkBNL3Vo6X+0S4lDfnj7QnWmWb2xsJrTp9aOZm8kP5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SUiSKX59; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SUiSKX59"
Received: from [10.95.64.89] (unknown [4.194.122.136])
	by linux.microsoft.com (Postfix) with ESMTPSA id C50A120B7168;
	Sun, 18 Oct 2026 22:10:07 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C50A120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1792386610;
	bh=99zGf1UYeMzipFM7ppAzhWPhBXUh3NmiRWjzT7zkbPc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SUiSKX59v4tiWL1TL1YbR6clUagEM7Os6Z9nDT5mR4w0Wi81mX5NNq9+IAJoRRn82
	 H5Ydazoc3uJqhwfpkb9Eu2MhOPsWeD8dDuZdradenAB3U7kCK/4gkiZKCGTirZ7svG
	 6x2AE/9XwWzwptv3DtuHeQ89DhOJ35AG/oJmG+h0=
Message-ID: <b88b0341-a732-41e1-87df-4f0503df39cc@linux.microsoft.com>
Date: Mon, 19 Oct 2026 10:40:11 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mshv_vtl: reject poll files with multiple waitqueues
To: Daehyeon Ko <4ncienth@gmail.com>, Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
 Michael Kelley <mhklinux@outlook.com>,
 Roman Kisel <romank@linux.microsoft.com>, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261016061114.1686153-1-4ncienth@gmail.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261016061114.1686153-1-4ncienth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/16/2026 11:41 AM, Daehyeon Ko wrote:
> MSHV_SET_POLL_FILE invokes a file descriptor poll callback with a poll
> table backed by a single embedded wait entry. A poll callback may,
> however, register the table with more than one waitqueue. pipe_poll()
> does this naturally for an O_RDWR FIFO.
> 
> The second registration currently warns but then inserts the same list
> node into another list. The new insertion overwrites the entry links while
> the first waitqueue still points at it, corrupting the first waitqueue and
> causing an invalid callback traversal when that queue wakes.
> 
> Reject a second distinct waitqueue, remove the first registration, and
> return -EINVAL from the ioctl. Repeated registration of the same waitqueue
> is treated as a no-op. A rejected replacement leaves the CPU slot
> unregistered, consistent with the existing remove-before-register ordering.
> Single-waitqueue users such as the OpenHCL io_uring poll file keep their
> existing behavior.
> 
> Fixes: 7bfe3b8ea6e3 ("Drivers: hv: Introduce mshv_vtl driver")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM

This tag is no longer valid on latest linux-next tip and gives 
checkpatch error.

Code changes LGTM.

> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>   drivers/hv/mshv_vtl_main.c | 24 ++++++++++++++++++++++--
>   1 file changed, 22 insertions(+), 2 deletions(-)
> 
Regards,
Naman
