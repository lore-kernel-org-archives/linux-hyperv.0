Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47AD42BB15;
	Mon, 21 Oct 2024 02:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729478630; cv=none; b=odenZ8CNbgIN3yeG3avZTA14wZs8j9lovb2lkVGmW/QPTF6jBIaqQ/mrbZdIBiXrrEuCkWVJyZa7NF7qfrYtRvDRw1uB/6WHO2RnYcY/3wcCZh2baf73Cef0Fl0shNwKCdCv5qZVZ0J0reu/B2YlN2ptwzj93uVE1K0HhOwGrfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729478630; c=relaxed/simple;
	bh=7reS95gIjk5O7EeOY+alNCkKpWV3ZVr+XL9yPaz46aA=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=co8E9zp2jkj45DXNKOY9OTrTO9Ff8LTZtDjMS4GqTl80ac4PQBNc8NtUR5duzvwgp3l48Mg2JlOnDStmCS8SsZo9svisxGPo1jUv8xMrPylaAFN6XxyqlWYdgDrdLiyHO1C8Q2GvjnkgOGj75V+izRfBHrbNDUjcPwcvcoZhsUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lmRyQezQ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lmRyQezQ"
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4BFCB210AF3D;
	Sun, 20 Oct 2024 19:43:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4BFCB210AF3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1729478623;
	bh=HJh6F2/RZnTg7orit1nBkBFk8Pucd0YAweZ7gT+let4=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=lmRyQezQwl4TR7sH0cM9bWamFr3HALo51rGDaZoGeWA6etASy+bvm/KH75gdHtbu2
	 MJ3iwDvrFd4H2K2FnjUc4vBo5zuS1AcE+q9T+4Mls2dkljtVzF1bm0U04d+AfECdtZ
	 hfRccKf1rcRtZXfjPmW84EgmGZXLhAfvcT5Rux1g=
Message-ID: <89d37f41-25fe-4b0b-a5c4-8ee7e8746761@linux.microsoft.com>
Date: Sun, 20 Oct 2024 19:43:42 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, John Starks <jostarks@microsoft.com>,
 jacob.pan@linux.microsoft.com
Subject: Re: [PATCH 2/2] Drivers: hv: vmbus: Log on missing offers
To: Naman Jain <namjain@linux.microsoft.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>
References: <20241018115811.5530-1-namjain@linux.microsoft.com>
 <20241018115811.5530-3-namjain@linux.microsoft.com>
Content-Language: en-US
From: Easwar Hariharan <eahariha@linux.microsoft.com>
In-Reply-To: <20241018115811.5530-3-namjain@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/18/2024 4:58 AM, Naman Jain wrote:
> From: John Starks <jostarks@microsoft.com>
> 
> When resuming from hibernation, log any channels that were present
> before hibernation but now are gone.
> 
> Signed-off-by: John Starks <jostarks@microsoft.com>
> Co-developed-by: Naman Jain <namjain@linux.microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>

Looks good to me.

Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
