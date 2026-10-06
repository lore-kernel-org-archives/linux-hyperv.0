Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8442F3A1D14;
	Tue,  6 Oct 2026 20:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791320350; cv=none; b=ieoT1kapNgQLb4YBi2sqJqVPnfAIfOW8c5ynWaUtZPxZtQmRBF+VKTzlRw6BoAE52VSyxFQzsAQO3eMYT4aaiCj9Q6WGQG+Otqu2h7QiqhETWjNBn8k5XGfppP9V7odYi8rGtYNkG/QNXJQ91jID4YtGIV198OGgOW5YNvMmouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791320350; c=relaxed/simple;
	bh=7d1zjRxFeIdFPvWMoMRaES7nqPV52UpcEk3lX5qGjMg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kgepsgXojm/0vHsVie0hK72NSqD9XQSK4pXG0GKBGrLnMI6Zofc2Rv2Ja3rANMsga10zJ5io/kU/ee20NIsFFjMxuWP/x5i+hIi64GeNDzn7EL6rEzksYNq7G1X6jW/Fn8+RS8fVXcULXkqMvIm3sIaYFN/0xCPA2Xp8VaEd1ho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SZBPtfx/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SZBPtfx/"
Received: from [192.168.4.134] (unknown [52.172.102.253])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3E38320B7178;
	Tue,  6 Oct 2026 13:58:05 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3E38320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1791320293;
	bh=2UIH46eWahkUAhT4XWny8Yeih5us5EgbzPo8Ucycx74=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SZBPtfx/gnoXS2+HW6AkHLs+4fhMcxak+MZ8KRCzfDTZJY5r4xh5pSAu6nriJsy3I
	 1dfC8JeHrTBae8/0PfwZaHdHp+V+Om/vnnp8gnImzb9TKljOfTr8OXgyXudE4onMTf
	 3R0vzs67Pq4gaRc9uoTZBGvT38Ky6T0OHW8gUknA=
Message-ID: <5636487a-31c7-43fb-8b27-a6a98b15200f@linux.microsoft.com>
Date: Tue, 6 Oct 2026 13:59:05 -0700
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [PATCH net-next 0/5] hv_netvsc: make XDP propagation
 act more like bonding
To: Haiyang Zhang <haiyangz@microsoft.com>, Jakub Kicinski <kuba@kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "pabeni@redhat.com" <pabeni@redhat.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "horms@kernel.org" <horms@kernel.org>,
 "wei.liu@kernel.org" <wei.liu@kernel.org>, Dexuan Cui <DECUI@microsoft.com>,
 "longli@microsoft.com" <longli@microsoft.com>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "hawk@kernel.org" <hawk@kernel.org>, "andriin@fb.com" <andriin@fb.com>,
 Saurabh Singh Sengar <ssengar@microsoft.com>
References: <20261001014131.310771-1-kuba@kernel.org>
 <LV5PR21MB4704E9960B2B82028F2FB51DCA892@LV5PR21MB4704.namprd21.prod.outlook.com>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <LV5PR21MB4704E9960B2B82028F2FB51DCA892@LV5PR21MB4704.namprd21.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/2/2026 12:38 PM, Haiyang Zhang wrote:
> 
> Thank you for making this patch set, looks good to me.
> I will find a teammate to test it.
> 
> - Haiyang

I ran LISA functional tests (T4) in Azure, including XDP related tests
[1], on the patch set based on v7.3-rc6.

I did not see any regressions in my testing, but my testing did not
cover:

  * Hibernation scenarios
  * Kdump tests (not super relevant but worth a note)
  * Performance (XDP or otherwise)
  * Scenarios trying to repro issues found in the patches

If you are worried about the performance impacts of this patchset, I can
do a comparison of performance with and without the patches.

Looking at the Sashiko comments, many of them look valid. It is at least
worth taking another look before merging. I am not providing a review
sign off, only the results of my regression testing.

[1] https://github.com/microsoft/lisa/tree/main/lisa/microsoft/testsuites/xdp


Tested-by: Kameron Carr <kameroncarr@linux.microsoft.com>

-- 
Regards,
Kameron
