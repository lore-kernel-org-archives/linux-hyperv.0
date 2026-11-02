Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793647653;
	b=bQAq6Ix7Ec7N5Vk4rKZ8cRotb51PlliUg4xrP60QCOVPGcRshCO8uaF7DJIgQLVWTMiL
	 nPdTzj/DcDv1RLFaiZqv84SNt86a4xDsVHS1HY2SZ5HG2PKutJOLsJzMlTq7CIvYcDrrh
	 aw06S9xKbDKxpwvBqjCmvkdMyACcN9A15VkWY3KV5ASo7g6AdJVJFQCpuy3G3fqXQb6pS
	 JVHewwn3tuuUvB4mke2rD02ekvYbm+DyvDpNvtWxtpSIABy0Yh1PHQmwAAV8UDE2qVxXa
	 rnpPmtz2ccZS2HnzchgcMCtYOrVNRVGGkRegdxLvx70/E1NprauZxWnPkGa8wMOZArg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793647653;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=9R7rn27BTvQI3HlJKKfu8p/MBYgn8iEr6X7HO0Xk9Xo=;
	b=NxC8TpgXNmqOmNjtr86gbeUjMiZTHIVjFhgiOlDpj3LKLaNMXulSL/WN30LGifgcS8YY
	 sgOmJCx+ZagR6FBrqC4aSY/OAsBZ9YzPO6LXs6Xhp4vQTSxgzyMMAGNAxajpZqSAxj1je
	 CKXB4XXL2GEnEbHDagHnhdpIFgBd8pRVtLEfQLGHpNgSiKoxn41vu2AZ83Q9sOfKLFDcc
	 uhsErk1xthQA+xOBxpVraYZzzLWBo0k3et41BWkWPrnSUacdjyM49Bwhw3p1O6/KCBlTb
	 GxGSDripRBue9AKPIwZjPYps7jBdAExyd3ZTZa3Jj4Vf1GAEIdaXelM7vho4Mvlbddg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TO39YtUd;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57792606A326;
	Mon,  2 Nov 2026 19:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 57792606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=TO39YtUd
Received: from [10.4.158.9] (unknown [131.107.174.137])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6549D20B7166;
	Mon,  2 Nov 2026 11:27:18 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6549D20B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1793647638;
	bh=9R7rn27BTvQI3HlJKKfu8p/MBYgn8iEr6X7HO0Xk9Xo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=TO39YtUd3Cf/StF0QdPN6j/y4FbKs8B4iukuDInUIKTsVQ1LEzXCfdknb5uZ9yR6g
	 3ho611vKzzuwp3vFYIg+aRD3vGJGC8lACS0ButV7faA5pYvf3tsTfix5VvL1wLluTa
	 L28VqbIrKkdSC4GVW4GL5tz22IwvjhYGEzwbQOdg=
Message-ID: <c87dc2c3-9211-46d2-9301-46a03d4b0ad7@linux.microsoft.com>
Date: Mon, 2 Nov 2026 11:27:37 -0800
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
Subject: Re: [PATCH v6 2/6] arm64: hyperv: Detect Hyper-V via RSI host call in
 CCA Realms
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: decui@microsoft.com, haiyangz@microsoft.com, mhklinux@outlook.com,
 wei.liu@kernel.org, arnd@arndb.de, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, lpieralisi@kernel.org, mark.rutland@arm.com,
 sudeep.holla@kernel.org, thuth@redhat.com, will@kernel.org
References: <20261031001412.4150488-1-kameroncarr@linux.microsoft.com>
 <20261031001412.4150488-3-kameroncarr@linux.microsoft.com>
 <auh-KP-4gFxHtO1z@arm.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <auh-KP-4gFxHtO1z@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/2/2026 4:12 AM, Catalin Marinas wrote:
> On Fri, Oct 30, 2026 at 05:14:08PM -0700, Kameron Carr wrote:
>> When booting without ACPI, hyperv_detect_via_smccc() detects Hyper-V by
>> querying the SMCCC vendor hypervisor UID. In an Arm CCA Realm the SMCCC
>> call is handled by the RMM rather than by the hypervisor, so the
>> query never reaches Hyper-V and detection fails.
>>
>> When running in a Realm, forward ARM_SMCCC_VENDOR_HYP_CALL_UID_FUNC_ID
>> to the host with RSI_HOST_CALL instead, which is how Hyper-V hypercalls
>> are issued from a Realm.
>>
>> This is done in the Hyper-V code rather than in the generic
>> arm_smccc_hypervisor_has_uuid() because the other users expect different
>> behavior.
>>
>> hyperv_init() is an early_initcall and runs before the secondary CPUs
>> are brought up, so a single __initdata host call structure is used
>> without locking.
>>
>> ACPI-based detection and non-Realm guests are unaffected.
>>
>> Signed-off-by: Kameron Carr <kameroncarr@linux.microsoft.com>
> 
> This works for me, thanks. I replied to Dexuan clarifying my objection
> to v5 do the UUID check generically.

Thank you for your review and suggestions.
Your clarification makes sense.

Is this a "Reviewed-by" or an "Acked-by"?

-- 
Regards,
Kameron
