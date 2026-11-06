Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793943689;
	b=fn7q+r3g6WColT+oVNyilghJLvqSofF5X/G2o+8y+d19LiA5Cc7szlDGlzYHjUhuD+bG
	 EidovtqPpd9z0xVvYKo5cl/wPBW8SLDdLmOBeOo6JTlZKpxsqIp5PVsrwbxpIU70jtyyu
	 05PkcKOz6/fkoqoe/fclNiL60fL/yqzTWNnyMf13DdZC1YQRPaI54N+ouQYXzYRQt2BfY
	 k3C3o8FwKc9EpeBEKVEdri4Vmp5mhl32ja5D89NS2Gpsa+mNFIyKZcnVV9N+VIccwCkEN
	 RXRfSRY4zqWB3HL1WqjpPJmLFQ4KtJWbk3K79d2628LY+iNp4s9G0hyC61ACu082nJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793943689;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=CMk8QWd3v4DiWhdwGphPM7XRgbKcJMclO2DxGjqOWJY=;
	b=ffnKWycj8klc4dKfbIxSedQVrhw5mVWl2ZuObnw8QTasNk4ipXEv0814gexFxs9hU/I4
	 to7sVHMkG44KdLyckBpJ61x1m2xuM8a7SJwdQpHgAcX3iFdGgB3vu1ZltsmoCuyyRPpCn
	 Uate6toJGZ8YaToe761k4EPN8nUjAjGmY+tbxhktydG9GYOBQAFqujh14+E9Ck1WGLhgB
	 LyXffb84OCa8Z0ksmsJHoqFvU/E8vVUx82f364b+Oi9dSmqIqnogXsmVDi39h1TPhfNaH
	 igLpmHJBnXLY83IqBpOPND/NSZg3Jm6yT06QovQinxt6iyCJ6loXTOth9X8QZzXRwnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Xl9XntBF;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973BA606A326;
	Fri,  6 Nov 2026 05:41:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 973BA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=Xl9XntBF
Received: from [192.168.1.14] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id CA50F20B7166;
	Thu,  5 Nov 2026 21:41:24 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CA50F20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793943687;
	bh=CMk8QWd3v4DiWhdwGphPM7XRgbKcJMclO2DxGjqOWJY=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=Xl9XntBF8g1w/LlsO8axMUCvYwd6GE9HT6X2G5x7gFyvBxCX0AV3ZL7n/aBFn6BVU
	 th0hlx0Mo3FRizArJ4I0LcYdyI0VWlO2DHgW4zkrArU46V0QCVmfTOvLO1QF+AvXuN
	 cSU1sAz89+EQcp+zofENdJuSoglDevJ3tmDJsGK0=
Message-ID: <1a768ba9-5848-49d0-b842-b3de2b3e4503@linux.microsoft.com>
Date: Fri, 6 Nov 2026 11:11:20 +0530
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
Subject: Re: [PATCH v2 1/1] Documentation: hyperv: Update docs for PCI
 pass-thru device support
To: mhklinux@outlook.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-doc@vger.kernel.org
References: <20261105180922.69256-1-mhklinux@outlook.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <20261105180922.69256-1-mhklinux@outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2026 11:39 PM, Michael Kelley wrote:
> Add a section to the documentation describing the IRQ domain and IRQ chip
> hierarchy that is created for virtual PCI devices, including the
> differences on x86 and arm64, and the reasons for those differences.
> 
> In the context of the IRQ domain and chip hierarchies, describe how the
> CPU selected for effective affinity is spread across CPUs in the affinity
> masks. Again, account for the differences in x86 and arm64.
> 
> Finally, rework existing text on how MSI messages are composed. Provide
> an expanded section on the overall approach that Hyper-V takes to MSI
> messages. The section provides more context on the handling of MSI messages
> in the Hyper-V vPCI driver, and why it is structured the way it is.
> 
> Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> ---
> This doc update assumes that the patch to implement effective
> affinity spreading for arm64 SPIs [1] is accepted.
> 
> [1] https://lore.kernel.org/linux-hyperv/20261101021928.52649-1-mhklinux@outlook.com/
> 

Subject to above patch going in first.
Reviewed-by: Naman Jain <namjain@linux.microsoft.com>

Thanks for addressing the comments Michael.

Regards,
Naman

