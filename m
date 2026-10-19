Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=204.191.154.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792444500;
	b=VOSTpE1Joktl9LM3eiV5ECHdVFjP2xIvxskiKWLoH5jCMFNGUjMNWh+SrXcMyUCfwnHg
	 LRgN1y1JaIkq3XiuOK2AG0TEkVz5bHQotY3i/krm8xi3mpk6d2EKt3yAIcbAx79g4ZfCg
	 L6nmb+F5+d/LWadkmMMXgmIvjrih6ZgijeodAgU7iuGWTpGFur+oFmarAiJwyoaZdkJvV
	 U29Tij0iT/Jmc+SOfrUifw+Pcg60zdKH0B3gKp2FpbHwXS51R/Teo/hQgh/4192/SD3nF
	 LpT+nsq29T5fFxDGfgNxTbkCy3L4GpwSIVXEMZHu9HlqI1vwa/HfTj0HRfUCbX2N12Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792444500;
	h=DMARC-Filter:DKIM-Signature:Received:Message-ID:Date:MIME-Version:
	 User-Agent:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-SA-Exim-Connect-IP:
	 X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:X-Spam-Checker-Version:
	 X-Spam-Level:X-Spam-Status:Subject:X-SA-Exim-Version:
	 X-SA-Exim-Scanned;
	bh=UUZq94NQZVOOmLkYnr0O3jTydDL2EzwXIjitFjyB/co=;
	b=s4HzL5WgwyO2S/BIxkUQl+HXp5VDOXAIM69UTArs3+TpMA0SRpcwrf3xxJ3v4P0pQGYO
	 gJuNRKUvWT7JcZrrN10+AYbXGg1qxTk1UNbuHtsZySm89LJ42DxeXbHsC1oNo/D6hLxkI
	 weCSWNMr8dhJfQ6H1Q48XX7VK5OCp4n/lAgXdeLap48/6SCMeQnXHfBqfk+dbsST1OaCh
	 8LC2FcidOYsdTnjMBY+h1ooTGVdssAzET5GkImPOijCs5k0iCOEQEBqZ5jc7qkUpvVX6u
	 o0SleaXA8x6FvfXyhzBrHqNB7OK3uHTo7TM1jRBeyKbxZY+HyFjtO6uNfqj/S9SGjIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=deltatee.com;
	spf=pass smtp.mailfrom=deltatee.com;
	dkim=pass header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=chlpUkYZ;
	arc=none smtp.remote-ip=204.191.154.188
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19F2606A31B;
	Mon, 19 Oct 2026 21:14:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F19F2606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=deltatee.com header.i=@deltatee.com header.a=rsa-sha256 header.s=20200525 header.b=chlpUkYZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=UUZq94NQZVOOmLkYnr0O3jTydDL2EzwXIjitFjyB/co=; b=chlpUkYZbGrbu3Dvkcaa+tIgM7
	0dpzAXPvxd9GMjCGrBqksQzj44m5jWRM0yipgFrW+uW88Gu1Bm8+GTu4j2Vw0OtolWwPsGyC9rEQc
	MK6dd7bxuKS6FBI4QtqLQOOQPGXUdMzxg3rD8eVmQ3cfkhqtUpcrJSRMpn+Uy1dBL7VOXKKrnuQtM
	0sWvy+EXYwqAprB+jJpc4NpYJG9Q4bftwzBWMzb94W6s6iZxUbp9rbiCXNLysOWHh2xvFD6nbDi6L
	ux3S7SaqxO47C5IlVRMpdM+viGCjZl3LnjMixfhi7ZOUWictm3usCr1rKO6P76ttloO3BzMc18R9/
	MUL5Xeaw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1xIugz-00000000HUZ-2bSt;
	Mon, 19 Oct 2026 15:14:50 -0600
Message-ID: <fca6d815-519a-449d-a5b7-36bd3ad0c19f@deltatee.com>
Date: Mon, 19 Oct 2026 15:14:38 -0600
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
To: "Popov, Pavel E" <pavel.e.popov@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Leon Romanovsky <leon@kernel.org>
Cc: Jim Chow <jim.chow@broadcom.com>, Radu Rugina <radu.rugina@broadcom.com>,
 Alexey Makhalov <alexey.makhalov@broadcom.com>, Wei Liu
 <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
 Lukas Wunner <lukas@wunner.de>,
 Nathan Ciobanu <nathan.d.ciobanu@linux.intel.com>,
 "bcm-kernel-feedback-list@broadcom.com"
 <bcm-kernel-feedback-list@broadcom.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20261016223402.19991-1-pavel.e.popov@intel.com>
 <20261016223402.19991-2-pavel.e.popov@intel.com>
 <8b01d643-f62d-4118-a700-8874341d953b@deltatee.com>
 <LV2PR11MB6070CE9CCA125C290C0F8209B29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <20261017074820.GD219304@unreal>
 <LV2PR11MB6070ABD61B46E9590C9B28ACB29A2@LV2PR11MB6070.namprd11.prod.outlook.com>
 <LV2PR11MB607077BABF5643BD4FAF470FB2982@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <LV2PR11MB607077BABF5643BD4FAF470FB2982@LV2PR11MB6070.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: pavel.e.popov@intel.com, bhelgaas@google.com, leon@kernel.org, jim.chow@broadcom.com, radu.rugina@broadcom.com, alexey.makhalov@broadcom.com, wei.liu@kernel.org, mhklinux@outlook.com, lukas@wunner.de, nathan.d.ciobanu@linux.intel.com, bcm-kernel-feedback-list@broadcom.com, virtualization@lists.linux.dev, linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 1/2] PCI/P2PDMA: Allow P2PDMA in VMware guests on Intel
 hosts
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-10-19 13:48, Popov, Pavel E wrote:
> Logan, Leon,
> 
> I kept the hypervisor check to avoid changing what the host bridge
> whitelist refuses on bare metal. Looking at those cases again, on the
> listed Xeon CPUs this is a limitation of the whitelist itself, not a
> known hardware limit, and it is why Intel QAT/DSA/IAA had to be added
> by ID. So I'd drop the hypervisor check.
> 
> Would a v3 that moves the Xeon list into cpu_supports_p2pdma(), the
> same way as the AMD check, be acceptable to you both?

Yes, that's essentially what I was suggesting before. That would be
acceptable to me.

Thanks,

Logan
