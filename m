Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=13.77.154.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795502639;
	b=g9jzlZ3dgh5vXkLawOHKLKFP3u2LewxbiSr5R95S6e4sn+Iz/U2CJxnn/4mt2jF/YBar
	 r5DdoyWw5gT9wf7c95b9b9UbOiTgDmI8K/ME1oeEkX369N1yrMNIqa86O3fVcHlyQIAjz
	 y8gXAXiNXqh+XEgaoX+o5q3YKCoeaxrAQ9gdJlxHjtghTHRHPlwmMjI3CtCcbav69xCSV
	 Av007GK1c05sIFYiOuQabbqp6QIOx4cNw7TRzqljoXe+Y+qvzynDWvUCjsownBuuCLTSn
	 Zib/Mbkr4s66j8369gCniKv6WuukO0nVfzJ2nX3opLpE8cTHnN9PeDdx2PTHepG6gtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795502639;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Spam-Status:
	 X-Spam-Checker-Version;
	bh=DhYV2EZ+W+sZ+MP1659S2aKSwEW3twmXY/nzfpAi0Yw=;
	b=jXHklNN19vfDyKGasYrtb4zxrdWE/vLrNfFiA+EcPDPWpqnBDt5GTLobt9jm97EDHxZo
	 OiIscbFOPK4n587VKKUCtNdJ7HcSjfAo4gOX7z16uCzOSTTba+RbR+dHXDCykV0b7Ll+5
	 iikRypj9/XdLtH8CsEshBHvbOMX4KlBKW3Fltido1w5jQj62LZUr0JHwIm/mV8PxYJCwX
	 hzUtSSZoylQNXLG/2iT/FBQQFIFk0dTbFXq4TrUfcRga8t1ZgtfAPcpHg8FfCDF8oNish
	 IjT3PQVi3jFZjeZP4AQz9/2OLaQHP63BwmZVP+koPuVFdiRrcEwqCAsJdAY5DhP+jzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.microsoft.com;
	spf=pass smtp.mailfrom=linux.microsoft.com;
	dkim=pass header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=sT9Syemc;
	arc=none smtp.remote-ip=13.77.154.182
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3325606A31E;
	Tue, 24 Nov 2026 06:43:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3325606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.a=rsa-sha256 header.s=default header.b=sT9Syemc
Received: from [10.95.64.197] (unknown [4.194.122.144])
	by linux.microsoft.com (Postfix) with ESMTPSA id E90A620B7169;
	Mon, 23 Nov 2026 22:43:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E90A620B7169
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1795502634;
	bh=DhYV2EZ+W+sZ+MP1659S2aKSwEW3twmXY/nzfpAi0Yw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sT9Syemc0Y9vKFpuk45tKrKM8Pc9EhNW1Hi9Y7BLdHgfAgrIAHXnag0rUbsksjf07
	 /SPB63VQK8sSQtfd7hsX/uhjT/E5EubDa1JwsJCrfgvcKtxlDgZLa0MQRq9LKaheSZ
	 XeKgGXfL1RvpkGi+rRbDF0VbjC1ZUx5wPtCmrsGg=
Message-ID: <c47e391e-2d5d-4a01-a55c-fab646741a78@linux.microsoft.com>
Date: Tue, 24 Nov 2026 12:13:50 +0530
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
Subject: Re: [PATCH v2 2/5] x86/tlb: Make the conditional flush predicate
 reusable
To: Dave Hansen <dave.hansen@intel.com>, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, tglx@kernel.org, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
 peterz@infradead.org
Cc: hpa@zytor.com, riel@surriel.com, mhklinux@outlook.com,
 bigeasy@linutronix.de, zhouchuyi@bytedance.com, houwenlong.hwl@antgroup.com,
 qq570070308@gmail.com, bastien.curutchet@bootlin.com, dianders@chromium.org,
 jgross@suse.com, hawk@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20261117091507.2088642-1-namjain@linux.microsoft.com>
 <20261117091507.2088642-3-namjain@linux.microsoft.com>
 <99ac4123-dcf3-4654-b38b-e9318d9d75d2@intel.com>
Content-Language: en-US
From: Naman Jain <namjain@linux.microsoft.com>
In-Reply-To: <99ac4123-dcf3-4654-b38b-e9318d9d75d2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/23/2026 9:36 PM, Dave Hansen wrote:
> On 11/17/26 01:15, Naman Jain wrote:
>> +/* Adapt the typed predicate to the SMP conditional-call interface. */
>> +static bool should_flush_tlb_wrapper(int cpu, void *data)
>> +{
>> +	return should_flush_tlb(cpu, data);
>> +}
> 
> Could we please fix up the LLM-generated comments like this before
> sending them for review? This is not the way humans write comments.

Sorry, I agree. I'll remove/fix them. Thanks for your patience.

Regards,
Naman
