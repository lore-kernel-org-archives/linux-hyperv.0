Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6AA3359A6C;
	Mon, 12 Oct 2026 05:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783587; cv=none; b=KCTYBlOpU+JEcBpCK2VmROT4wOEIsNc8YENCLBCEnX7mLcjYE3yIAMW36mzHx8CgnHT+GRST1q/N2I9inkwJyz+8TSfYj9fILXCz4YkyuUse9pO/xT54lQ2UQTZddwLslhoCdfyq769q7nXZ4mNozr0Qs0mcPtz/YQ9AFD8s9Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783587; c=relaxed/simple;
	bh=DlNUrjzbU6JRlHe3QlYTyGVqRO35YHpFVy+7vBW06F4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KVd8Lk+g8iQEPF8UJkuKEGTmaxqIssuAOXkjvFtBP7dyN42nC81hCRWpLhHxXVEzCrNO8foZNHfEcIBkXh232OPHzIeHpgK3kvgMyyFXjlifI1dA+rzTt93eXqkuGIFKG5//qcXimFdVG7S8WOSpemYfapO71Ea2q/m6KeWSWWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=PZ9Bw3QN; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="PZ9Bw3QN"
Received: from [10.95.64.165] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1564B20B7166;
	Sun, 11 Oct 2026 22:39:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1564B20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791783583;
	bh=FrA7TKK/qqyZow+lLey4f2KpnQJuwXpGdmMwKqR9TxA=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=PZ9Bw3QNuW2NglP0S/i19+khYr9TTls/GyokauoHbAuIawbd8PPVvwQ/L0TT+62YP
	 xUiOh8V4R/1mtOjhSoMV/IvRhr3DHNFCvSpf64K9ovD5wNIt66WOHtpTRvD/nlN2te
	 YtnBBJCLVXTggMJD3vKUSlj2wrvboa1d3XgDRozo=
Message-ID: <9a85540f-5bc2-4f01-a751-b5daf2cc88ad@linux.microsoft.com>
Date: Mon, 12 Oct 2026 11:09:39 +0530
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Update documentation for
 sending VMBus packets
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261009184056.7382-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261009184056.7382-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 10/10/2026 12:10 AM, Michael Kelley wrote:
> The functions for sending VMBus packets have changed.
> vmbus_sendpacket_mpb_desc() can target multiple ranges, and
> vmbus_sendpacket_pagebuffer() has been removed. vmbus_sendpacket_getid()
> has been added. Update the documentation accordingly.
> 
> Fixes: 45a442fe369e ("Drivers: hv: vmbus: Remove vmbus_sendpacket_pagebuffer()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> Changes in v2:
> * Add vmbus_sendpacket_getid() to the documentation. [Naman Jain]

Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Regards,
Naman
